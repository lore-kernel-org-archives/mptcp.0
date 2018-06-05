Content-Type: multipart/mixed; boundary="===============3377311284131659611=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 18/19] mptcp: Disable TCP coalesce/collapse for
 MPTCP subflows
Date: Tue, 05 Jun 2018 16:40:37 -0700
Message-ID: <20180605234038.28497-19-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 661

--===============3377311284131659611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As a temporary measure, make sure packets are passed to the upper layers
unmodified so the TCP options are preserved.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/ipv4/tcp_input.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bdc36001ce90..ab8c6f1daabb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4335,6 +4335,9 @@ static bool tcp_try_coalesce(struct sock *sk,
 	if (TCP_SKB_CB(from)->seq !=3D TCP_SKB_CB(to)->end_seq)
 		return false;
 =

+	if (tcp_sk(sk)->is_mptcp)
+		return false;
+
 	if (!skb_try_coalesce(to, from, fragstolen, &delta))
 		return false;
 =

@@ -4838,11 +4841,17 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *=
list, struct rb_root *root,
 			break;
 		}
 =

+		if (tcp_sk(sk)->is_mptcp) {
+			end_of_skbs =3D false;
+			break;
+		}
+
 		/* Decided to skip this, advance start seq. */
 		start =3D TCP_SKB_CB(skb)->end_seq;
 	}
 	if (end_of_skbs ||
-	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
+	    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) ||
+	    tcp_sk(sk)->is_mptcp)
 		return;
 =

 	__skb_queue_head_init(&tmp);
-- =

2.17.1


--===============3377311284131659611==--
