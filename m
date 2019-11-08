Content-Type: multipart/mixed; boundary="===============8054624654946098546=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/6] subflow: store known available bytes in
 subflow
Date: Fri, 08 Nov 2019 23:09:50 +0100
Message-ID: <20191108220953.30904-4-fw@strlen.de>
In-Reply-To: 20191108220953.30904-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2452

--===============8054624654946098546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of just a flag, store the number of bytes that are known to be
available for reading.

This will allow a followup patch to include this number in the dss ack.
At this time, we can only ack up to msk->ack_seq, but that number is
only updated when userspace reads from the socket.

This could lead to a needless retransmission if userspace doesn't
read fast enough.

Ideally we could update this number to include all the pending data,
i.e. tp->rcv_nxt - tp->copied_seq, but there is no guarantee that the
next skb in sk_receive_queue contains the next packet in logical mptcp
sequence space.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 83b06382e56a..bc7e8fa54afa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -215,8 +215,8 @@ struct mptcp_subflow_context {
 		conn_finished : 1,
 		map_valid : 1,
 		backup : 1,
-		data_avail : 1,
 		rx_eof : 1;
+	u32	data_avail;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 76156a7aaea8..0d686f91e0b4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -612,7 +612,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 bool mptcp_subflow_data_available(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	struct sk_buff *skb;
+	const struct sk_buff *skb;
+	u32 data_avail =3D 0;
 =

 	/* check if current mapping is still valid */
 	if (subflow->map_valid &&
@@ -636,9 +637,18 @@ bool mptcp_subflow_data_available(struct sock *sk)
 	}
 =

 	skb =3D skb_peek(&sk->sk_receive_queue);
-	subflow->data_avail =3D skb &&
-		       before(tcp_sk(sk)->copied_seq, TCP_SKB_CB(skb)->end_seq);
-	return subflow->data_avail;
+	if (skb) {
+		const struct tcp_sock *tp =3D tcp_sk(sk);
+		u32 map_remaining =3D subflow->map_data_len -
+				    mptcp_subflow_get_map_offset(subflow);
+
+		data_avail =3D TCP_SKB_CB(skb)->end_seq - tp->copied_seq;
+		data_avail =3D min_t(u32, data_avail, map_remaining);
+	}
+
+	subflow->data_avail =3D data_avail;
+
+	return subflow->data_avail > 0;
 }
 =

 static void subflow_data_ready(struct sock *sk)
-- =

2.23.0

--===============8054624654946098546==--
