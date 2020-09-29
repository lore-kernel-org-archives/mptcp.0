Content-Type: multipart/mixed; boundary="===============0013166576539739038=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/2] mptcp: Consistently use READ_ONCE/WRITE_ONCE
 with msk->ack_seq
Date: Tue, 29 Sep 2020 15:08:19 -0700
Message-ID: <20200929220820.278003-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200929220820.278003-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6102

--===============0013166576539739038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The msk->ack_seq value is sometimes read without the msk lock held, so
make proper use of READ_ONCE and WRITE_ONCE.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7fa822b55c34..120ef39fe589 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -518,11 +518,11 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 =

 	if (subflow->use_64bit_ack) {
 		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
-		opts->ext_copy.data_ack =3D msk->ack_seq;
+		opts->ext_copy.data_ack =3D READ_ONCE(msk->ack_seq);
 		opts->ext_copy.ack64 =3D 1;
 	} else {
 		ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
-		opts->ext_copy.data_ack32 =3D (uint32_t)(msk->ack_seq);
+		opts->ext_copy.data_ack32 =3D (uint32_t)READ_ONCE(msk->ack_seq);
 		opts->ext_copy.ack64 =3D 0;
 	}
 	opts->ext_copy.use_ack =3D 1;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 365ba96c84b0..5d747c6a610e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -123,7 +123,7 @@ static void __mptcp_move_skb(struct mptcp_sock *msk, st=
ruct sock *ssk,
 =

 	skb_ext_reset(skb);
 	skb_orphan(skb);
-	msk->ack_seq +=3D copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 =

 	tail =3D skb_peek_tail(&sk->sk_receive_queue);
 	if (offset =3D=3D 0 && tail) {
@@ -261,7 +261,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
 		struct mptcp_subflow_context *subflow;
 =

-		msk->ack_seq++;
+		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 =

 		sk->sk_shutdown |=3D RCV_SHUTDOWN;
@@ -1720,7 +1720,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 		msk->remote_key =3D mp_opt->sndr_key;
 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
 		ack_seq++;
-		msk->ack_seq =3D ack_seq;
+		WRITE_ONCE(msk->ack_seq, ack_seq);
 	}
 =

 	sock_reset_flag(nsk, SOCK_RCU_FREE);
@@ -2072,7 +2072,7 @@ bool mptcp_finish_join(struct sock *sk)
 	parent_sock =3D READ_ONCE(parent->sk_socket);
 	if (parent_sock && !sk->sk_socket)
 		mptcp_sock_graft(sk, parent_sock);
-	subflow->map_seq =3D msk->ack_seq;
+	subflow->map_seq =3D READ_ONCE(msk->ack_seq);
 	return true;
 }
 =

-- =

2.28.0

--===============0013166576539739038==--
