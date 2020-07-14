Content-Type: multipart/mixed; boundary="===============9032669003716004406=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 01/11] mptcp: syn cookie support
Date: Tue, 14 Jul 2020 20:25:03 +0200
Message-ID: <20200714182514.25250-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4997

--===============9032669003716004406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, this is the initial round of patches to add syn cookie
support to mptcp.

Last patch extends the self-test to enable cookie mode in one
of the network namespaces.

Patch #10 contains a very ugly cast, see 'XXX' in commit
message for details.

The first two patches are not related to syncookie support,
I can submit them independently.

JOIN support uses idea presented by Christoph, i.e. the request
socket is added to the listen sk even in cookie mode (possibly
moving socket past the syn backlog limit).
For this, extra accounting is added to the parent socket.
In case the parent already has too many connections (including
half-open ones), cookie mode is used instead (which won't work
for a join request -- this will trigger tcp fallback + reset
when ack comes back).

Comments welcome.



--===============9032669003716004406==--
