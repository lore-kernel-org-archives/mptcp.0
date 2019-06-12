Content-Type: multipart/mixed; boundary="===============6908516393915932219=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: Implement MPTCP receive path
Date: Wed, 12 Jun 2019 16:32:44 -0700
Message-ID: <20190612233244.14091-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1354

--===============6908516393915932219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This MPTCP debug print is an unnecessary change to common TCP code, and
it's best to get rid of it before upstream review.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/ipv4/tcp_output.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 08675fd0f070..a850686b8e2a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3707,9 +3707,6 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 	skb_set_tcp_pure_ack(buff);
 =

 	/* Send it off, this clears delayed acks for us. */
-	if (sk_is_mptcp(sk))
-		pr_debug("mptcp sk=3D%p", sk);
-
 	__tcp_transmit_skb(sk, buff, 0, (__force gfp_t)0, rcv_nxt);
 }
 EXPORT_SYMBOL_GPL(__tcp_send_ack);
-- =

2.22.0


--===============6908516393915932219==--
