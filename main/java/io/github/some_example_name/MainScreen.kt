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

class MainScreen(private val game: Main) : Screen {
    private val stage = Stage()
    private val skin = Skin(Gdx.files.internal("uiskin.json"))

    init {
        val screenWidth = Gdx.graphics.width.toFloat()
        val screenHeight = Gdx.graphics.height.toFloat()

        // Tworzenie przycisku New Game
        val button = TextButton("New Game", skin)
        button.setPosition(((screenWidth - button.width) / 2)-80, (screenHeight - button.height) / 2) // Środek ekranu
        //button.setPosition(100f, 150f)
        button.setSize(200f,50f)
        button.addListener(object : ClickListener() {
            override fun clicked(event: InputEvent?, x: Float, y: Float) {
                game.screen = NewGameScreen(game) // Przełącz na NewGameScreen
            }
        })

        // LoadGame
        val button2 = TextButton("Load Game", skin)
        button2.setPosition(((screenWidth - button.width) / 2)-25, ((screenHeight - button.height) / 2)-100)
        button2.setSize(200f,50f)
        button2.addListener(object : ClickListener() {
            override fun clicked(event: InputEvent?, x: Float, y: Float) {
                game.screen = LoadGameScreen(game)
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

        // Tworzenie etykiety "Cywilizacja 2050"
        val titleLabel = Label("Cywilizacja 2050", skin)
        titleLabel.setPosition(680f,500f)
        titleLabel.setAlignment(Align.center) // Wyśrodkowanie tekstu
        titleLabel.setFontScale(4f) // Ustawienie skali czcionki

        stage.addActor(button) // Dodaj przycisk do sceny
        stage.addActor(button2) // Dodaj drugi przycisk do sceny
        stage.addActor(button3)
        stage.addActor(titleLabel) // Dodaj etykietę do sceny

        Gdx.input.inputProcessor = stage // Ustawienie stage jako InputProcessor
    }

    override fun show() {
        Gdx.input.inputProcessor = stage
    }

    //nie umiem dodac zdjecia jako tla bo mi wypierdala wzystko

    override fun render(delta: Float) {
        Gdx.gl.glClearColor(0f, 0.1333f, 0.2941f, 1f) // Składniki koloru RGBA
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
