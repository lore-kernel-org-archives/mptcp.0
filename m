Content-Type: multipart/mixed; boundary="===============0860682687713680255=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [BUG] mptcp data transfers very slow in mmap mode
Date: Mon, 11 May 2020 14:08:37 +0200
Message-ID: <20200511120837.GA21748@breakpoint.cc>
X-Status: 
X-Keywords:                  
X-UID: 4367

--===============0860682687713680255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

$subject says it all:

ns1 TCP   -> ns1 (127.0.0.1:10000     ) TCP     (duration   349ms)
ns1 MPTCP -> ns1 (127.0.0.1:10001     ) MPTCP   (duration 26780ms)
ns1 MPTCP -> ns1 (127.0.0.1:10002     ) TCP     (duration   353ms)
ns1 TCP   -> ns1 (127.0.0.1:10003     ) MPTCP   (duration   343ms)

This is with '-m mmap', no tc, and a file of 50 mbyte.
Might be related to
https://github.com/multipath-tcp/mptcp_net-next/issues/6

(i.e., it could be that -m mmap just triggers this reliably).

I will investigate; I get the above result on both net-next
and mptcp-next with no changes.

Recent patches I sent do not change the 'lo' behaviour but
I do see worse behaviour of cross-netns transfers.

Don't know why so far, will report when I learn more.

--===============0860682687713680255==--
