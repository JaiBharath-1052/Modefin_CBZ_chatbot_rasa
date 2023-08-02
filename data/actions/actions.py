# This files contains your custom actions which can be used to run
# custom Python code.

# See this guide on how to implement these action:
# https://rasa.com/docs/rasa/custom-actions


# This is a simple example for a custom action which utters "Hello World!"

from typing import Any, Text, Dict, List

from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from typing import Dict, Text, Any, List, Union, Optional
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import UserUtteranceReverted, ActionReverted, ReminderScheduled, ConversationPaused, ConversationResumed

from typing import Dict, Text, Any, List, Union, Optional
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import UserUtteranceReverted, ActionReverted, ReminderScheduled, ConversationPaused, ConversationResumed
import json
import random
import logging

logger = logging.getLogger(__name__)

''' This action will respond with jokes to the user ,that are picked up randomly 
    from a file and displayed to the user''' 
class jokes(Action):
    def name(self):
        return "action_jokes"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        try:
            with open('actions/jokes.json', 'r') as f:
                data = json.load(f)
                random_joke = random.choice(data)
                dispatcher.utter_message(text=random_joke.get("setup")+" -- "+random_joke.get("punchline"))
                return[]
        except FileNotFoundError:
            logger.warning("File `jokes.json` does not exist")
            dispatcher.utter_message(text="Sorry, I do not know any jokes right now.  I should do later!")
            return[]
