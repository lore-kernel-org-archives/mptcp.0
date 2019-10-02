Content-Type: multipart/mixed; boundary="===============5470519533611017959=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: removed unused fields in structures
Date: Wed, 02 Oct 2019 18:40:29 +0200
Message-ID: <20191002164032.11111-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1983

--===============5470519533611017959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After having applied a recent patch (mptcp: Remove all traces of
checksum support), I saw that there were still some fields related to
the checksum feature in 'include' directory.

While removing them, I also saw that there were two holes in two 'u8' we
were using. So I simply merged these holes. I guess we will want to
optimise this code in 'struct tcp_options_received' to use even more
unions and reduce the structure size, e.g. we cannot receive an
MP_CAPABLE option and an MP_JOIN one, etc.

I propose to already merge the two first ones now (to have it in RFCv2)
and wait for a proper review for the last one.

Matthieu Baerts (3):
  mptcp: removed unused fields in structure: mptcp.h
  mptcp: removed unused fields in structure: tcp.h
  mptcp:options: merge two holes in one

 include/linux/tcp.h | 16 +++++++---------
 include/net/mptcp.h |  2 --
 2 files changed, 7 insertions(+), 11 deletions(-)

-- =

2.20.1

--===============5470519533611017959==--
