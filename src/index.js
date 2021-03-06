import express from 'express'
import axios from 'axios'
import promisify from 'es6-promisify'

export default () => {
  const config = {
    port: 'PORT' in process.env ? parseInt(process.env.PORT, 10) : 5000,
  }

  const app = express()
  app.set('config', config)
  app.get('/proxy', async (req, res) => {
    const response = await axios.get({ url: req.query.url })
    res.send(response.data)
  })

  app.get('/health', (req, res) => {
    res.send({ ok: true })
  })


  const start = promisify(cb => {
    const server = app.listen(config.port, (err) => {
      cb(err, server)
    })
  })

  return { start, app }
}