from django.test import TestCase


class HelloWorldCase(TestCase):
    def testHello(self):
        mdummy = 'one'
        self.assertEqual(mdummy, "one")