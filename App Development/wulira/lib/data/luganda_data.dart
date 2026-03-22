import '../models/word.dart';
import '../models/lesson.dart';

// ─── GREETINGS ────────────────────────────────────────────────────────────────
const _greetingWords = [
  Word(
    id: 'g1',
    luganda: 'Oli otya?',
    english: 'How are you?',
    phonetic: 'Oh-lee oh-tya',
    category: 'greetings',
    level: 1,
    exampleSentence: 'Oli otya, mukwano gwange?',
    exampleTranslation: 'How are you, my friend?',
  ),
  Word(
    id: 'g2',
    luganda: 'Gyendi',
    english: 'I am fine',
    phonetic: 'Jen-di',
    category: 'greetings',
    level: 1,
    exampleSentence: 'Gyendi, webale okwogera.',
    exampleTranslation: 'I am fine, thank you for asking.',
  ),
  Word(
    id: 'g3',
    luganda: 'Webale',
    english: 'Thank you',
    phonetic: 'Weh-bah-leh',
    category: 'greetings',
    level: 1,
    exampleSentence: 'Webale nyo!',
    exampleTranslation: 'Thank you very much!',
  ),
  Word(
    id: 'g4',
    luganda: 'Mwasuze otya?',
    english: 'Good morning',
    phonetic: 'Mwa-su-zeh oh-tya',
    category: 'greetings',
    level: 1,
    exampleSentence: 'Mwasuze otya, taata?',
    exampleTranslation: 'Good morning, father?',
  ),
  Word(
    id: 'g5',
    luganda: 'Osiibye otya?',
    english: 'Good afternoon',
    phonetic: 'Oh-see-byeh oh-tya',
    category: 'greetings',
    level: 1,
  ),
  Word(
    id: 'g6',
    luganda: 'Sula bulungi',
    english: 'Good night',
    phonetic: 'Su-la bu-lun-gi',
    category: 'greetings',
    level: 1,
  ),
  Word(
    id: 'g7',
    luganda: 'Tofaayo',
    english: 'You are welcome',
    phonetic: 'Toh-fah-yo',
    category: 'greetings',
    level: 1,
  ),
  Word(
    id: 'g8',
    luganda: 'Weraba',
    english: 'Goodbye',
    phonetic: 'Weh-rah-ba',
    category: 'greetings',
    level: 1,
  ),
];

// ─── NUMBERS ─────────────────────────────────────────────────────────────────
const _numberWords = [
  Word(id: 'n1', luganda: 'Emu', english: 'One (1)', phonetic: 'Eh-mu', category: 'numbers', level: 1),
  Word(id: 'n2', luganda: 'Bbiri', english: 'Two (2)', phonetic: 'Bbee-ri', category: 'numbers', level: 1),
  Word(id: 'n3', luganda: 'Ssatu', english: 'Three (3)', phonetic: 'Ssa-tu', category: 'numbers', level: 1),
  Word(id: 'n4', luganda: 'Nnya', english: 'Four (4)', phonetic: 'Nnya', category: 'numbers', level: 1),
  Word(id: 'n5', luganda: 'Ttaano', english: 'Five (5)', phonetic: 'Ttaa-no', category: 'numbers', level: 1),
  Word(id: 'n6', luganda: 'Mukaaga', english: 'Six (6)', phonetic: 'Mu-kaa-ga', category: 'numbers', level: 1),
  Word(id: 'n7', luganda: 'Musanvu', english: 'Seven (7)', phonetic: 'Mu-san-vu', category: 'numbers', level: 1),
  Word(id: 'n8', luganda: 'Munaana', english: 'Eight (8)', phonetic: 'Mu-naa-na', category: 'numbers', level: 1),
  Word(id: 'n9', luganda: 'Mwenda', english: 'Nine (9)', phonetic: 'Mwen-da', category: 'numbers', level: 1),
  Word(id: 'n10', luganda: 'Kkumi', english: 'Ten (10)', phonetic: 'Kku-mi', category: 'numbers', level: 1),
];

// ─── FAMILY ───────────────────────────────────────────────────────────────────
const _familyWords = [
  Word(id: 'f1', luganda: 'Taata', english: 'Father', phonetic: 'Taa-ta', category: 'family', level: 1,
      exampleSentence: 'Taata wange ali mulunji.', exampleTranslation: 'My father is tall.'),
  Word(id: 'f2', luganda: 'Maama', english: 'Mother', phonetic: 'Maa-ma', category: 'family', level: 1),
  Word(id: 'f3', luganda: 'Mukwano', english: 'Friend', phonetic: 'Mu-kwa-no', category: 'family', level: 1),
  Word(id: 'f4', luganda: 'Muganda', english: 'Sibling', phonetic: 'Mu-gan-da', category: 'family', level: 1),
  Word(id: 'f5', luganda: 'Jjajja', english: 'Grandparent', phonetic: 'Jja-jja', category: 'family', level: 1),
  Word(id: 'f6', luganda: 'Mwana', english: 'Child', phonetic: 'Mwa-na', category: 'family', level: 1),
  Word(id: 'f7', luganda: 'Ssebo', english: 'Sir / Mr.', phonetic: 'Sse-bo', category: 'family', level: 1),
  Word(id: 'f8', luganda: 'Nnyabo', english: 'Madam / Mrs.', phonetic: 'Nnya-bo', category: 'family', level: 1),
];

// ─── FOOD ─────────────────────────────────────────────────────────────────────
const _foodWords = [
  Word(id: 'fd1', luganda: 'Matoke', english: 'Cooked bananas', phonetic: 'Ma-toh-keh', category: 'food', level: 2,
      exampleSentence: 'Ndya matoke buli lunaku.', exampleTranslation: 'I eat matoke every day.'),
  Word(id: 'fd2', luganda: 'Posho', english: 'Maize meal (ugali)', phonetic: 'Po-sho', category: 'food', level: 2),
  Word(id: 'fd3', luganda: 'Ddembe', english: 'Peace / Orange', phonetic: 'Ddeh-mbeh', category: 'food', level: 2),
  Word(id: 'fd4', luganda: 'Enva', english: 'Vegetables', phonetic: 'Eh-nva', category: 'food', level: 2),
  Word(id: 'fd5', luganda: 'Amazzi', english: 'Water', phonetic: 'A-mah-zzi', category: 'food', level: 2),
  Word(id: 'fd6', luganda: 'Omwenge', english: 'Local brew / Drink', phonetic: 'Om-weh-ngeh', category: 'food', level: 2),
  Word(id: 'fd7', luganda: 'Ente', english: 'Cow (beef source)', phonetic: 'Eh-nteh', category: 'food', level: 2),
  Word(id: 'fd8', luganda: 'Ndiisa', english: 'I am eating', phonetic: 'Ndi-ee-sa', category: 'food', level: 2),
];

// ─── COMMON PHRASES ───────────────────────────────────────────────────────────
const _phraseWords = [
  Word(id: 'p1', luganda: 'Simanyi', english: 'I don\'t know', phonetic: 'Si-mah-nyi', category: 'phrases', level: 2),
  Word(id: 'p2', luganda: 'Nkwagala', english: 'I love you', phonetic: 'Nkwa-ga-la', category: 'phrases', level: 2,
      exampleSentence: 'Nkwagala nnyo.', exampleTranslation: 'I love you very much.'),
  Word(id: 'p3', luganda: 'Kale', english: 'OK / Alright', phonetic: 'Ka-leh', category: 'phrases', level: 1),
  Word(id: 'p4', luganda: 'Nedda', english: 'No', phonetic: 'Neh-dda', category: 'phrases', level: 1),
  Word(id: 'p5', luganda: 'Yee', english: 'Yes', phonetic: 'Yeh', category: 'phrases', level: 1),
  Word(id: 'p6', luganda: 'Nkusaba', english: 'I am asking / Please', phonetic: 'Nku-sa-ba', category: 'phrases', level: 2),
  Word(id: 'p7', luganda: 'Nsonyiwa', english: 'Sorry / Forgive me', phonetic: 'Nso-nyi-wa', category: 'phrases', level: 2),
  Word(id: 'p8', luganda: 'Jangu', english: 'Come here', phonetic: 'Jan-gu', category: 'phrases', level: 1),
];

// ─── ALL LESSONS ──────────────────────────────────────────────────────────────
final List<Lesson> allLessons = [
  Lesson(
    id: 'lesson_greetings',
    title: 'Greetings',
    subtitle: 'Say hello like a local',
    emoji: '👋',
    level: 1,
    category: 'greetings',
    words: _greetingWords,
  ),
  Lesson(
    id: 'lesson_numbers',
    title: 'Numbers',
    subtitle: 'Count 1 to 10',
    emoji: '🔢',
    level: 1,
    category: 'numbers',
    words: _numberWords,
  ),
  Lesson(
    id: 'lesson_family',
    title: 'Family',
    subtitle: 'Talk about loved ones',
    emoji: '👨‍👩‍👧',
    level: 1,
    category: 'family',
    words: _familyWords,
  ),
  Lesson(
    id: 'lesson_phrases',
    title: 'Phrases',
    subtitle: 'Everyday expressions',
    emoji: '💬',
    level: 1,
    category: 'phrases',
    words: _phraseWords,
  ),
  Lesson(
    id: 'lesson_food',
    title: 'Food & Drink',
    subtitle: 'Market and meals',
    emoji: '🍌',
    level: 2,
    category: 'food',
    words: _foodWords,
    isPremium: false,
  ),
];
