Content-Type: multipart/mixed; boundary="===============0311667411502490933=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix wrong merge resolution
Date: Mon, 02 Mar 2020 10:34:42 +0100
Message-ID: <20200302093442.1481757-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3837

--===============0311667411502490933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise the data are never init and we get warnings in workqueue code.

I really don't know how I made this mistake :-/

Fixes: ce2d7fb36478 (tgupdate: merge t/mptcp-introduce-MPTCP-retransmission=
-timer base into t/mptcp-introduce-MPTCP-retransmission-timer)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: introduce MPTCP retransmission timer"

 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b8e71d5a4ff9..d20f19b779fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1106,6 +1106,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	msk->first =3D NULL;
 	inet_csk(sk)->icsk_sync_mss =3D mptcp_sync_mss;
 =

+	mptcp_pm_data_init(msk);
+
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 =

-- =

2.25.0

--===============0311667411502490933==--
