#include "PlayerController.h"
#include <QAudioDevice>
#include <QAudioOutput>
#include <QMediaDevices>

PlayerController::PlayerController(QObject *parent)
    : QAbstractListModel{parent}
{
    const auto &audioOutput = QMediaDevices::audioOutputs();
    if (!audioOutput.isEmpty()) {
        m_mediaPlayer.setAudioOutput(new QAudioOutput(&m_mediaPlayer));
    }

    addAudio("aa",
             "tt",
             QUrl("qrc:/MusicPlayer/assets/audio/sample-15s.mp3"),
             QUrl("assets/images/CruelSummer-TaylorSwift.png"));
    addAudio("bb",
             "tt",
             QUrl("qrc:/MusicPlayer/assets/audio/sample-12s.mp3"),
             QUrl("assets/images/FastCar-LukeCombs.png"));
    addAudio("cc",
             "tt",
             QUrl("qrc:/MusicPlayer/assets/audio/sample-9s.mp3"),
             QUrl("assets/images/PaintTheTownRed-DojaCat.png"));
    addAudio("dd",
             "tt",
             QUrl("qrc:/MusicPlayer/assets/audio/sample-6s.mp3"),
             QUrl("assets/images/Snooze-SZA.png"));
}

bool PlayerController::playing() const
{
    return m_playing;
}

int PlayerController::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_audioList.length();
}

QVariant PlayerController::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() < m_audioList.length() && index.row() >= 0) {
        const auto audio = m_audioList[index.row()];
        switch (role) {
        case AudioAuthorNameRole:
            return audio->authorName();
        case AudioTitleRole:
            return audio->title();
        case AudioSourceRole:
            return audio->audioSource();
        case AudioImageSourceRole:
            return audio->imageSource();
        }
    }
    return {};
}

QHash<int, QByteArray> PlayerController::roleNames() const
{
    QHash<int, QByteArray> result;

    result[AudioAuthorNameRole] = "audioAuthorName";
    result[AudioTitleRole] = "audioTitle";
    result[AudioSourceRole] = "audioSource";
    result[AudioImageSourceRole] = "audioImageSource";

    return result;
}

void PlayerController::switchToNextSong()
{
    const int index = m_audioList.indexOf(m_currentSong);
    if (index + 1 >= m_audioList.length()) {
        setCurrentSong(m_audioList.first());
    } else {
        setCurrentSong(m_audioList[index + 1]);
    }
}

void PlayerController::switchToPreviousSong()
{
    const int index = m_audioList.indexOf(m_currentSong);
    if (index - 1 < 0) {
        setCurrentSong(m_audioList.last());
    } else {
        setCurrentSong(m_audioList[index - 1]);
    }
}

void PlayerController::playPause()
{
    m_playing = !m_playing;
    emit playingChanged();

    if (m_playing) {
        m_mediaPlayer.play();
    } else {
        m_mediaPlayer.stop();
    }
}

void PlayerController::changeAudioSource(const QUrl &source)
{
    m_mediaPlayer.stop();
    m_mediaPlayer.setSource(source);
    if (m_playing) {
        m_mediaPlayer.play();
    }
}

void PlayerController::addAudio(const QString &title,
                                const QString &authorName,
                                const QUrl &audioSource,
                                const QUrl &imageSource)
{
    beginInsertRows(QModelIndex(), m_audioList.length(), m_audioList.length());

    auto audioInfo = new AudioInfo(this);
    audioInfo->setTitle(title);
    audioInfo->setAuthorName(authorName);
    audioInfo->setAudioSource(audioSource);
    audioInfo->setImageSource(imageSource);

    if (m_audioList.isEmpty()) {
        setCurrentSong(audioInfo);
    }
    m_audioList << audioInfo;

    endInsertRows();
}

void PlayerController::removeAudio(int index)
{
    if (index >= 0 && index < m_audioList.length()) {
        beginRemoveRows(QModelIndex(), index, index);
        auto toRemove = m_audioList[index];
        if (toRemove == m_currentSong) {
            if (m_audioList.length() > 1) {
                if (index != 0) {
                    setCurrentSong(m_audioList[index - 1]);
                } else {
                    setCurrentSong(m_audioList[index + 1]);
                }
            } else {
                setCurrentSong(nullptr);
            }
        }

        m_audioList.removeAt(index);
        toRemove->deleteLater();
        endRemoveRows();
    }
}

void PlayerController::switchToAudioByIndex(int index)
{
    if (index >= 0 && index < m_audioList.length()) {
        setCurrentSong(m_audioList[index]);
    }
}

AudioInfo *PlayerController::currentSong() const
{
    return m_currentSong;
}

void PlayerController::setCurrentSong(AudioInfo *newCurrentSong)
{
    if (m_currentSong == newCurrentSong)
        return;
    m_currentSong = newCurrentSong;
    emit currentSongChanged();

    if (m_currentSong) {
        changeAudioSource(m_currentSong->audioSource());
    } else {
        m_mediaPlayer.stop();
        m_mediaPlayer.setSource(QUrl());
        m_playing = false;
        emit playingChanged();
    }
}
