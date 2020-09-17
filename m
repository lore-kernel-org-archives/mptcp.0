Content-Type: multipart/mixed; boundary="===============4735180189987016527=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: fix integer overflow in
 mptcp_subflow_discard_data()
Date: Thu, 17 Sep 2020 23:07:24 +0200
Message-ID: <1a927c595adf46cf5ff186ca6b129f12fb70f492.1600375771.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5919

--===============4735180189987016527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph reported an infinite loop in the subflow receive path
under stress condition.

If there are multiple subflows, each of them using a large send
buffer, the delta between the sequence number used by
MPTCP-level retransmission can and the current msk->ack_seq
can be greater than MAX_INT.

In the above scenario, when calling mptcp_subflow_discard_data(),
such delta will be truncated to int, and could result in a negative
number: no bytes will be dropped, and subflow_check_data_avail()
will try again to process the same packet, looping forever.

This change addresses the issue by expanding the 'limit' size to 64
bits, so that overflows are not possible anymore.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/87
Fixes: 6719331c2f73 ("mptcp: trigger msk processing even for OoO data")
Reported-and-tested-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
net-next patch, as the culprit commit is only on net-next currently
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a2ae3087e24d..34d6230df017 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -807,7 +807,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
 }
 =

 static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *s=
kb,
-				       unsigned int limit)
+				       u64 limit)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	bool fin =3D TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-- =

2.26.2

--===============4735180189987016527==--
