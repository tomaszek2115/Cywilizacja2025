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

class LoadGameScreen(private val game: Main) : Screen {
    private val stage = Stage()
    private val skin = Skin(Gdx.files.internal("uiskin.json"))

    init {
        // Tworzenie przycisku <-
        val button = TextButton("<-", skin)
        button.setPosition(100f, 600f)
        button.setSize(50f,50f)
        button.addListener(object : ClickListener() {
            override fun clicked(event: InputEvent?, x: Float, y: Float) {
                game.screen = MainScreen(game) // Przełącz na MainScreen
            }
        })

        // button Start
        val button2 = TextButton("Start", skin)
        button2.setPosition(650f,100f)
        button2.setSize(200f,50f)
        button2.addListener(object : ClickListener() {
            override fun clicked(event: InputEvent?, x: Float, y: Float) {
                //game.screen = MainScreen(game)
            }
        })

        // Settings
        val button3 = TextButton("@", skin)
        button3.setPosition(1400f,600f)
        button3.setSize(50f,50f)
        button3.addListener(object : ClickListener() {
            override fun clicked(event: InputEvent?, x: Float, y: Float) {
                game.lastScreen = game.screen // Zapisz aktualny ekran
                game.screen = SettingsScreen(game)
            }
        })

        // Label Load Game
        val loadGameLabel = Label("Load Game", skin)
        loadGameLabel.setPosition(700f,600f)
        loadGameLabel.setAlignment(Align.center) // Wyśrodkowanie tekstu
        loadGameLabel.setFontScale(2f) // Ustawienie skali czcionki

        stage.addActor(button) // Dodaj przycisk do sceny
        stage.addActor(button2)
        stage.addActor(button3)
        stage.addActor(loadGameLabel)

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
