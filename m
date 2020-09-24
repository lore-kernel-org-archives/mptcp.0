Content-Type: multipart/mixed; boundary="===============8839741446340732688=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/4] mptcp: add reset option support
Date: Thu, 24 Sep 2020 16:35:01 +0200
Message-ID: <20200924143505.27641-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6024

--===============8839741446340732688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds initial support for the RESET option.
First patch is a minor cleanup, I would propose to pass this to
net-next.

Second patch moves a few helpers around so they can be used
from tcp core (needed to add mtpcp reset option to 'active resets',
as those do not use the normal tcp output option path).

Third patch adds mptcp reset option, both for sending and receiving.

Last patch adds a call to the mptcp layer for inbound resets.

At this time, this is non-sensical, as nothing makes use of the
rest-option hint.

The option/reason code would have to be propagated to the PM so
it could use that for e.g. reconnect decisions.

We can discuss further steps in todays meeting.

--===============8839741446340732688==--
