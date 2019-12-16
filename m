Content-Type: multipart/mixed; boundary="===============6882843363545252992=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: tcp: Check for filled TCP option space
 before SACK
Date: Mon, 16 Dec 2019 13:37:25 +0100
Message-ID: <7ad85d0d66f3dcbebbd9d2ee6896cfedd1620812.1576499809.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3075

--===============6882843363545252992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Less invasive checks, so that the number of branchs when hitting
the sack code path decreses compared to the current vanilla tree.
--
Some addictional check in tcp_established_options() is needed, otherwise
the tcp header will be corrupted when mptcp_established_options() fully
consumes the TCP option space. This condition can be reached without
MPTCP, so not sure if the result patch is still worthy for -net ?!?
---
 net/ipv4/tcp_output.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 710ab45badfa..e797ca6c6d7d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -748,19 +748,20 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

-	if (size + TCPOLEN_SACK_BASE_ALIGNED >=3D MAX_TCP_OPTION_SPACE)
-		return size;
-
 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
+		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
+					 TCPOLEN_SACK_PERBLOCK))
+			return size;
+
 		opts->num_sack_blocks =3D
 			min_t(unsigned int, eff_sacks,
 			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
 			      TCPOLEN_SACK_PERBLOCK);
-		if (likely(opts->num_sack_blocks))
-			size +=3D TCPOLEN_SACK_BASE_ALIGNED +
-				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+
+		size +=3D TCPOLEN_SACK_BASE_ALIGNED +
+			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
 	}
 =

 	return size;
-- =

2.21.0

--===============6882843363545252992==--
