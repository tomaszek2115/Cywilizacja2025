package io.github.some_example_name

import com.badlogic.gdx.Gdx
import com.badlogic.gdx.Screen
import com.badlogic.gdx.graphics.GL20
import com.badlogic.gdx.scenes.scene2d.Stage
import com.badlogic.gdx.scenes.scene2d.ui.Skin
import com.badlogic.gdx.scenes.scene2d.ui.TextButton
import com.badlogic.gdx.scenes.scene2d.utils.ClickListener
import com.badlogic.gdx.scenes.scene2d.InputEvent
import com.badlogic.gdx.scenes.scene2d.ui.Label
import com.badlogic.gdx.utils.Align

class SettingsScreen(private val game: Main) : Screen {
    private val stage = Stage()
    private val skin = Skin(Gdx.files.internal("uiskin.json"))

    init {
        // Tworzenie przycisku <-
        val button = TextButton("<-", skin)
        button.setPosition(100f, 600f)
        button.setSize(50f,50f)
        button.addListener(object : ClickListener() {
            override fun clicked(event: InputEvent?, x: Float, y: Float) {
                // Użyj lastScreen do przejścia z powrotem do ostatniego ekranu
                game.screen = game.lastScreen ?: MainScreen(game) // Jeśli nie ma ostatniego ekranu, wróć do MainScreen
            }
        })
        // Settings
        val settingsLabel = Label("Settings", skin)
        settingsLabel.setPosition(700f,600f)
        settingsLabel.setAlignment(Align.center) // Wyśrodkowanie tekstu
        settingsLabel.setFontScale(2f) // Ustawienie skali czcionki

        stage.addActor(button) // Dodaj przycisk do sceny
        stage.addActor(settingsLabel)

        Gdx.input.inputProcessor = stage // Ustawienie stage jako InputProcessor
    }

    override fun show() {
        Gdx.input.inputProcessor = stage
    }

    override fun render(delta: Float) {
        Gdx.gl.glClearColor(0.3882f, 0.545f, 0.7568f, 1f)
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT)

        stage.act(delta)
        stage.draw()
    }

    override fun resize(width: Int, height: Int) {}
    override fun pause() {}
    override fun resume() {}
    override fun hide() {}
    override fun dispose() {
        stage.dispose()
        skin.dispose()
    }
}
