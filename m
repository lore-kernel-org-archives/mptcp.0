Content-Type: multipart/mixed; boundary="===============3221673145332110012=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 19/20] mptcp: Don't free skb when tcp_transmit_skb
 without cloning
Date: Fri, 14 Sep 2018 10:25:23 -0700
Message-ID: <20180914172524.67961-22-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 743

--===============3221673145332110012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because, tcp_transmit_skb will already take care of the free'ing.

Fixes: 17683a61dd6d ("mptcp: Don't clone empty DATA_FIN in tcp_transmit_skb=
")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit db9347ff01f604e60f0199faa2847337c3f829cb)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_output.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index c0b2c9ff8ca2..6bc27496c457 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -562,10 +562,8 @@ static bool mptcp_skb_entail(struct sock *sk, struct s=
k_buff *skb, int reinject)
 		tcp_init_tso_segs(subskb, 1);
 =

 		/* Empty data-fins are sent immediatly on the subflow */
-		if (tcp_transmit_skb(sk, subskb, 0, GFP_ATOMIC) !=3D 0) {
-			kfree_skb(subskb);
+		if (tcp_transmit_skb(sk, subskb, 0, GFP_ATOMIC))
 			return false;
-		}
 	}
 =

 	if (!tp->mptcp->fully_established) {
-- =

2.16.2


--===============3221673145332110012==--
