<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:import url="/common/base.jsp">
  <c:param name="title">得点管理システム</c:param>

  <c:param name="scripts"></c:param>

  <c:param name="content">
<script>
document.addEventListener('keydown', function(e) {
    console.log(e.keyCode, e.key);
});
window.addEventListener('DOMContentLoaded', () => {

const keyCodes = {
		  // 0: {
		  //   'Key has no keycode',
		  //   id: '',
		  // },
		  // 3: {
		  //   'break',
		  //   id: '',
		  // },
		  8: {
		    // 'backspace / delete',
		    id: 'backspace',
		  },
		  9: {
		    id: 'tab',
		  },
		  // 12: {
		  //   'clear',
		  //   id: '',
		  // },
		  13: {
		    id: 'enter',
		  },
		  16: {
		    id: 'shift',
		    checkSide: true,
		    // DOM_KEY_LOCATION_LEFT
		    // DOM_KEY_LOCATION_RIGHT
		  },
		  17: {
		    id: 'control',
		    checkSide: true,
		  },
		  18: {
		    id: 'alt',
		    checkSide: true,
		  },
		  19: {
		  //   'pause/break',
		    id: 'pause',
		  },
		  20: {
		    id: 'capsLock',
		  },
		  // 21: {
		  //   'hangul',
		  //   id: '',
		  // },
		  // 25: {
		  //   'hanja',
		  //   id: '',
		  // },
		  27: {
		    id: 'esc',
		  },
		  // 28: {
		  //   'conversion',
		  //   id: '',
		  // },
		  // 29: {
		  //   'non-conversion',
		  //   id: '',
		  // },
		  32: {
		    id: 'space',
		  },
		  // 33: {
		  //   'page up',
		  //   id: '',
		  // },
		  // 34: {
		  //   'page down',
		  //   id: '',
		  // },
		  // 35: {
		  //   'end',
		  //   id: '',
		  // },
		  // 36: {
		  //   'home',
		  //   id: '',
		  // },
		  37: {
		    id: 'arrowLeft',
		  },
		  38: {
		    id: 'arrowUp',
		  },
		  39: {
		    id: 'arrowRight',
		  },
		  40: {
		    id: 'arrowDown',
		  },
		  // 41: {
		  //   'select',
		  //   id: '',
		  // },
		  // 42: {
		  //   'print',
		  //   id: '',
		  // },
		  // 43: {
		  //   'execute',
		  //   id: '',
		  // },
		  44: {
		  //   'print Screen',
		    id: 'print',
		  },
		  45: {
		  //   'insert',
		    id: 'insert',
		  },
		  46: {
		    id: 'delete',
		  },
		  // 47: {
		  //   'help',
		  //   id: '',
		  // },
		  48: {
		    id: '0',
		  },
		  49: {
		    id: '1',
		  },
		  50: {
		    id: '2',
		  },
		  51: {
		    id: '3',
		  },
		  52: {
		    id: '4',
		  },
		  53: {
		    id: '5',
		  },
		  54: {
		    id: '6',
		  },
		  55: {
		    id: '7',
		  },
		  56: {
		    id: '8',
		  },
		  57: {
		    id: '9',
		  },
		  58: {
		    // ':',
		    id: 'semicolon',
		  },
		  59: {
		    // 'semicolon (firefox), equals',
		    id: 'equals',
		  },
		  60: {
		    // '<',
		    id: 'comma',
		  },
		  61: {
		    // 'equals (firefox)',
		    id: 'equals',
		  },
		  // 63: {
		  //   'ß',
		  //   id: '',
		  // },
		  64: {
		    // '@ (firefox)',
		    id: '2',
		  },
		  65: {
		    id: 'a',
		  },
		  66: {
		    id: 'b',
		  },
		  67: {
		    id: 'c',
		  },
		  68: {
		    id: 'd',
		  },
		  69: {
		    id: 'e',
		  },
		  70: {
		    id: 'f',
		  },
		  71: {
		    id: 'g',
		  },
		  72: {
		    id: 'h',
		  },
		  73: {
		    id: 'i',
		  },
		  74: {
		    id: 'j',
		  },
		  75: {
		    id: 'k',
		  },
		  76: {
		    id: 'l',
		  },
		  77: {
		    id: 'm',
		  },
		  78: {
		    id: 'n',
		  },
		  79: {
		    id: 'o',
		  },
		  80: {
		    id: 'p',
		  },
		  81: {
		    id: 'q',
		  },
		  82: {
		    id: 'r',
		  },
		  83: {
		    id: 's',
		  },
		  84: {
		    id: 't',
		  },
		  85: {
		    id: 'u',
		  },
		  86: {
		    id: 'v',
		  },
		  87: {
		    id: 'w',
		  },
		  88: {
		    id: 'x',
		  },
		  89: {
		    id: 'y',
		  },
		  90: {
		    id: 'z',
		  },
		  91: {
		    // 'Windows Key / Left ⌘ / Chromebook Search key',
		    id: 'cmdLeft',
		  },
		  92: {
		    // 'right window key',
		    id: 'cmdRight',
		  },
		  93: {
		    // 'Windows Menu / Right ⌘',
		    id: 'cmdRight',
		  },
		  // 95: {
		  //  '// sleep',
		  //   id: '',
		  // },
		  96: {
		    // 'numpad 0',
		    id: '0',
		  },
		  97: {
		    // 'numpad 1',
		    id: '1',
		  },
		  98: {
		    // 'numpad 2',
		    id: '2',
		  },
		  99: {
		    // 'numpad 3',
		    id: '3',
		  },
		  100: {
		    // 'numpad 4',
		    id: '4',
		  },
		  101: {
		    // 'numpad 5',
		    id: '5',
		  },
		  102: {
		    // 'numpad 6',
		    id: '6',
		  },
		  103: {
		    // 'numpad 7',
		    id: '7',
		  },
		  104: {
		    // 'numpad 8',
		    id: '8',
		  },
		  105: {
		    // 'numpad 9',
		    id: '9',
		  },
		  106: {
		    // 'multiply',
		    id: '8',
		  },
		  107: {
		    // 'add',
		    id: 'equals',
		  },
		  108: {
		    // 'numpad period (firefox)',
		    id: 'dot',
		  },
		  109: {
		    // 'subtract',
		    id: 'minus',
		  },
		  110: {
		    // 'decimal point',
		    id: 'dot',
		  },
		  111: {
		    // 'divide',
		    id: 'slash',
		  },
		  112: {
		    id: 'f1',
		  },
		  113: {
		    id: 'f2',
		  },
		  114: {
		    id: 'f3',
		  },
		  115: {
		    id: 'f4',
		  },
		  116: {
		    id: 'f5',
		  },
		  117: {
		    id: 'f6',
		  },
		  118: {
		    id: 'f7',
		  },
		  119: {
		    id: 'f8',
		  },
		  120: {
		    id: 'f9',
		  },
		  121: {
		    id: 'f10',
		  },
		  122: {
		    id: 'f11',
		  },
		  123: {
		    id: 'f12',
		  },
		  124: {
		    id: 'f13',
		  },
		  125: {
		    id: 'f14',
		  },
		  126: {
		    id: 'f15',
		  },
		  127: {
		    id: 'f16',
		  },
		  128: {
		    id: 'f17',
		  },
		  129: {
		    id: 'f18',
		  },
		  130: {
		    id: 'f19',
		  },
		  131: {
		    id: 'f20',
		  },
		  132: {
		    id: 'f21',
		  },
		  133: {
		    id: 'f22',
		  },
		  134: {
		    id: 'f23',
		  },
		  135: {
		    id: 'f24',
		  },
		  // 144: {
		  //   'num lock',
		  //   id: '',
		  // },
		  // 145: {
		  //   'scroll lock',
		  //   id: '',
		  // },
		  160: {
		    // '^',
		    id: '6',
		  },
		  161: {
		    // '!',
		    id: '1',
		  },
		  163: {
		    // '#',
		    id: '3',
		  },
		  164: {
		    // '$',
		    id: '4',
		  },
		  165: {
		    // 'ù',
		    id: 'u',
		  },
		  // 166: {
		  //   'page backward',
		  //   id: '',
		  // },
		  // 167: {
		  //   'page forward',
		  //   id: '',
		  // },
		  168: {
		    // 'refresh',
		    id: 'f5',
		  },
		  169: {
		    // 'closing paren (AZERTY)',
		    id: '0',
		  },
		  170: {
		    // '*',
		    id: '8',
		  },
		  171: {
		    // '~ + * key',
		    id: 'tilde',
		  },
		  // 172: {
		  //   'home key',
		  //   id: '',
		  // },
		  173: {
		    // 'minus (firefox), mute/unmute',
		    id: 'minus',
		  },
		  174: {
		    // 'decrease volume level',
		    id: 'f10',
		  },
		  175: {
		    // 'increase volume level',
		    id: 'f11',
		  },
		  // 176: {
		  //   'next',
		  //   id: '',
		  // },
		  // 177: {
		  //   'previous',
		  //   id: '',
		  // },
		  // 178: {
		  //   'stop',
		  //   id: '',
		  // },
		  179: {
		    // 'play/pause',
		    id: 'f8',
		  },
		  // 180: {
		  //   'e-mail',
		  //   id: '',
		  // },
		  181: {
		    // 'mute/unmute (firefox)',
		    id: 'f10',
		  },
		  182: {
		    // 'decrease volume level (firefox)',
		    id: 'f11',
		  },
		  183: {
		    // 'increase volume level (firefox)',
		    id: 'f12',
		  },
		  186: {
		    // 'semi-colon / ñ',
		    id: 'semicolon',
		  },
		  187: {
		    // 'equal sign',
		    id: 'equals',
		  },
		  188: {
		    // 'comma',
		    id: 'comma',
		  },
		  189: {
		    // 'dash',
		    id: 'minus',
		  },
		  190: {
		    // 'period',
		    id: 'dot',
		  },
		  191: {
		    // 'forward slash / ç',
		    id: 'slash',
		  },
		  192: {
		    // 'grave accent / ñ / æ / ö',
		    id: 'tilde',
		  },
		  193: {
		    // '?, / or °',
		    id: 'slash',
		  },
		  194: {
		    // 'numpad period (chrome)',
		    id: 'dot',
		  },
		  219: {
		    // 'open bracket',
		    id: 'squareBracketLeft',
		  },
		  220: {
		    // 'back slash',
		    id: 'doubleYen',
		  },
		  221: {
		    // 'close bracket / å',
		    id: 'squareBracketRight',
		  },
		  222: {
		    // 'single quote / ø / ä',
		    id: 'apostrophe',
		  },
		  223: {
		    // '`',
		    id: 'tilde',
		  },
		  224: {
		    // 'left or right ⌘ key (firefox)',
		    id: 'cmd',
		    checkSide: true,
		  },
		  225: {
		    // 'altgr',
		    id: 'altRight',
		  },
		  // 226: {
		  //   'left back slash',
		  //   id: '',
		  // },
		  // 230: {
		  //   'GNOME Compose Key',
		  //   id: '',
		  // },
		  231: {
		    // 'ç',
		    id: 'c',
		  },
		  // 233: {
		  //   'XF86Forward',
		  //   id: '',
		  // },
		  // 234: {
		  //   'XF86Back',
		  //   id: '',
		  // },
		  // 240: {
		  //   'alphanumeric',
		  //   id: '',
		  // },
		  // 242: {
		  //   'hiragana/katakana',
		  //   id: '',
		  // },
		  243: {
		  //   'half-width/full-width/Hankaku',
		    id: 'HankakuZenkaku',
		  },
		  244: {
		  //   'kanji/Zenkaku',
		    id: 'HankakuZenkaku',
		  },
		  // 255: {
		  //   'toggle touchpad',
		  //   id: '',
		  // },
		};


		function getKeyElement(e) {
			  const key = keyCodes[e.keyCode];

			  if (key && key.id) {
			    let keySelector = "#Key--" + key.id;

			    if (key.checkSide && KeyboardEvent) {
			      if (e.location === KeyboardEvent.DOM_KEY_LOCATION_LEFT) {
			        keySelector += 'Left';
			      } else if (e.location === KeyboardEvent.DOM_KEY_LOCATION_RIGHT) {
			        keySelector += 'Right';
			      }
			    }

			    const keyElement = document.querySelector(keySelector);

			    return keyElement;
			  }
			}


		document.addEventListener('keydown', function(e) {
		  const keyElement = getKeyElement(e);
		  <%--console.log('Keydown detected:', e.keyCode, e.key);--%>


		  if (keyElement) {
			  <%-- console.log('Found SVG element:', keyElement.id); --%>

		    keyElement.setAttribute('class', 'Key Key--active');
		  }
		  else {
			  <%--console.log('No matching SVG element found.');--%>
		  }
		});

		document.addEventListener('keyup', function(e) {
		  const keyElement = getKeyElement(e);
		  console.log('Keyup detected:', e.keyCode);


		  if (keyElement) {
			  keyElement.setAttribute('class', 'Key');

		    keyElement.setAttribute('class', 'Key');
		  }

		});

		function removeActiveKeyClass() {
		  const keyElements = document.querySelectorAll('.Key--active');

		  for (let i = 0; i < keyElements.length; i++) {
		    keyElements[i].setAttribute('class', 'Key');
		  }
		}

		window.addEventListener('blur', removeActiveKeyClass);



});

</script>
<%-- <div class="Wrapper"> --%>

<style>

body {
  padding: 30px 20px;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 16px;
  background-color: fafafb;
  color: #222;
  text-align: center;
}

h1 {
  font-size: 24px;
  margin: 10px 0;
}

small {
  display: block;
  font-size: 14px;
  color: #888;
}

h2 {
  color: #e74c3c;
  font-weight: bold;
}

a {
  color: #555;
  transition: all 0.25s;
}

a:hover {
  color: #3498db;
}

p {
  line-height: 1.3em;
  margin-bottom: 20px;
  color: #888;
}

.Wrapper {
  max-width: 800px;
  margin: 0 auto;
}

.Keyboard {
  width: 100%;
}

.Key {
  fill: #eee;
  stroke: none;
}

.Key--active:nth-child(7n + 1) {
  fill: #1abc9c;
}

.Key--active:nth-child(7n + 2) {
  fill: #2ecc71;
}

.Key--active:nth-child(7n + 3) {
  fill: #3498db;
}

.Key--active:nth-child(7n + 4) {
  fill: #9b59b6;
}

.Key--active:nth-child(7n + 5) {
  fill: #f1c40f;
}

.Key--active:nth-child(7n + 6) {
  fill: #e67e22;
}


.Key--active:nth-child(7n + 7) {
  fill: #e74c3c;
}
<%--
.Key--active {
  fill: #ff5722 !important; /* bright orange */
  stroke: #333 !important;
}
--%>


</style>




  <div class="Wrapper">
  <h2>Start typing!</h2>

  <h1>Keyboard easter egg<small>from <a href="https://muffinman.io">my blog</a></small></h1>

  <p>
    Works only on devices with keyboard.<br/>
    Read how it works in <a href="https://muffinman.io/javascript-keyboard-easter-egg">this blog post</a>.
  </p>

<svg class="Keyboard" viewBox="0 0 800 242" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <g stroke="none" stroke-width="1" fill="#FFFFFF" fill-rule="evenodd">
    <rect class="Key" id="Key--q" x="52" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--w" x="95" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--e" x="138" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--r" x="182" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--t" x="225" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--y" x="269" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--u" x="312" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--i" x="356" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--o" x="399" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--p" x="442" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--squareBracketLeft" x="486" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--squareBracketRight" x="529" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--backslash" x="573" y="70" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--HankakuZenkaku" x="1" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--1" x="44" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--2" x="88" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--3" x="131" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--4" x="175" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--5" x="218" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--6" x="262" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--7" x="305" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--8" x="348" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--9" x="392" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--0" x="435" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--minus" x="479" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--equals" x="522" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--doubleYen" x="566" y="25" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--esc" x="1" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f1" x="45" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f2" x="89" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f3" x="133" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f4" x="176" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f5" x="221" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f6" x="264" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f7" x="308" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f8" x="352" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f9" x="396" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f10" x="440" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f11" x="484" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--f12" x="528" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--print" x="572" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--pause" x="616" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--insert" x="660" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--delete" x="704" y="0" width="37" height="18" rx="6"></rect>
    <rect class="Key" id="Key--backspace" x="610" y="25" width="43" height="37" rx="6"></rect>
    <rect class="Key" id="Key--a" x="65" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--s" x="109" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--d" x="152" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--f" x="195" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--g" x="239" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--h" x="282" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--j" x="326" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--k" x="369" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--l" x="413" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--semicolon" x="456" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--apostrophe" x="500" y="114" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--z" x="88" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--x" x="131" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--c" x="175" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--v" x="218" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--b" x="262" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--n" x="305" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--m" x="348" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--comma" x="392" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--dot" x="435" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--slash" x="479" y="158" width="36" height="37" rx="6"></rect>
    <rect class="Key" id="Key--fn" x="0" y="203" width="33" height="37" rx="6"></rect>
    <rect class="Key" id="Key--controlLeft" x="41" y="203" width="33" height="37" rx="6"></rect>
    <rect class="Key" id="Key--altLeft" x="81" y="203" width="33" height="37" rx="6"></rect>
    <rect class="Key" id="Key--altRight" x="444" y="203" width="33" height="37" rx="6"></rect>
    <rect class="Key" id="Key--arrowLeft" x="485" y="221" width="37" height="19" rx="6"></rect>
    <g class="Key" id="Key--arrowUp" transform="translate(529.000000, 203.000000)">
      <path d="M37,11.5 L37,6 C37,2.6862915 34.3137085,-6.08718376e-16 31,0 L6,0 L6,0 C2.6862915,6.08718376e-16 -4.05812251e-16,2.6862915 0,6 L0,6 L0,11.5 L0,19 L37,19 L37,11.5 Z"></path>
    </g>
    <g class="Key" id="Key--arrowDown" transform="translate(529.000000, 222.000000)">
      <path d="M37,7.5 L37,13 C37,16.3137085 34.3137085,19 31,19 L6,19 C2.6862915,19 4.05812251e-16,16.3137085 0,13 L0,7.5 L0,0 L37,0 L37,7.5 Z"></path>
    </g>
    <rect class="Key" id="Key--arrowRight" x="573" y="221" width="36" height="19" rx="6"></rect>
    <rect class="Key" id="Key--enter" x="543" y="114" width="66" height="37" rx="6"></rect>
    <rect class="Key" id="Key--cmdLeft" x="122" y="203" width="45" height="37" rx="6"></rect>
    <rect class="Key" id="Key--cmdRight" x="392" y="203" width="45" height="37" rx="6"></rect>
    <rect class="Key" id="Key--shiftRight" x="522" y="158" width="87" height="37" rx="6"></rect>
    <rect class="Key" id="Key--tab" x="0" y="70" width="44" height="37" rx="6"></rect>
    <rect class="Key" id="Key--capsLock" x="0" y="114" width="57" height="37" rx="6"></rect>
    <rect class="Key" id="Key--shiftLeft" x="0" y="158" width="80" height="37" rx="6"></rect>
    <rect class="Key" id="Key--space" x="175" y="203" width="210" height="37" rx="6"></rect>
  </g>
</svg>

</div>





      </c:param>
</c:import>