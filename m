Content-Type: multipart/mixed; boundary="===============5781005158928454515=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 00/10] mptcp: refactor token code
Date: Sun, 25 Aug 2019 20:59:29 +0200
Message-ID: <20190825185939.21596-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1697

--===============5781005158928454515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series is intentionally marked RFC so noone bothers
to squash all of this into the mptcp tree.

The idea is to first do a review-friendly series, with
each change done in an individual patch.

Then, once consensus is reached (maybe over several iterations),
I would send a few larger patches suitable for squashing (rather
than being review friendly...).

The patches remove unneeded small helpers, add 'mptcp' prefix
to non-static functions, add error handling to those that may
fail and adds a few comments.

Feedback welcome.

 pm.c       |    6 =

 protocol.c |    5 =

 protocol.h |   27 +--
 subflow.c  |   76 ++++++++--
 token.c    |  447 +++++++++++++++++++++++++++-----------------------------=
-----
 5 files changed, 278 insertions(+), 283 deletions(-)


--===============5781005158928454515==--
