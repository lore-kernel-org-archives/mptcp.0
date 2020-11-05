Content-Type: multipart/mixed; boundary="===============7901182738047629607=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH MPTCP 0/5] mptcp: add reset and fastclose option
 support
Date: Thu, 05 Nov 2020 18:01:21 +0100
Message-ID: <20201105170126.5627-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 6568

--===============7901182738047629607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds reset and fast close options.
Both need common infrastructure:
 1. need to parse mptcp option in tcp reset packets, and making
    them available to the stack
 2. ability to add mptcp option to tcp reset packets

First two patches move code around and add mptcp-callsite for
option deciding from rst packets.

Patch 3 adds reset support (both decoding and adding them).
Patch 4 adds the fastclose receive processing.
Patch 5 sends a fastclose packet when userspace calls close()
while there is unread data in the mptcp rx queue.

Patch 2) is not strictly need ATM, I could rework the series
to remove it and only handle fastclose for the time being.
Last patch could be removed as well so we only handle the rx case
(there is nothing in RFC that says we must send fastclose).

Comments welcome.


--===============7901182738047629607==--
