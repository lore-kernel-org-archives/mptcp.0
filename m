Content-Type: multipart/mixed; boundary="===============6976805264532074764=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH MPTCP 5/5] mptcp: send fastclose if userspace closes
 socket with unread data
Date: Thu, 05 Nov 2020 18:01:26 +0100
Message-ID: <20201105170126.5627-6-fw@strlen.de>
In-Reply-To: 20201105170126.5627-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6573

--===============6976805264532074764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add building & sending of FASTCLOSE option.
RFC 8684 describes two methods:

A): Host sends an ACK containing the MP_FASTCLOSE
    option on one subflow [..] On all the other subflows,
    Host A sends a regular TCP RST to close these subflows and tears
    them down. [..]

R): Host A sends a RST containing the MP_FASTCLOSE option on all
    subflows [..].  Host A can tear down the subflows and the
    connection immediately.

This implements option R) only: All subflows are re-set with FASTCLOSE.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  | 35 +++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c | 32 +++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0a940687f738..08b60d527de0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -681,6 +681,31 @@ static bool mptcp_established_options_rm_addr(struct s=
ock *sk,
 	return true;
 }
 =

+static bool mptcp_fastclose(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->snd_fastclose);
+}
+
+static bool mptcp_established_options_fastclose(struct sock *sk,
+						unsigned int *size,
+						unsigned int remaining,
+						struct mptcp_out_options *opts)
+{
+	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	if (likely(!mptcp_fastclose(mptcp_sk(subflow->conn))))
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_FASTCLOSE)
+		return false;
+
+	*size =3D TCPOLEN_MPTCP_FASTCLOSE;
+	opts->suboptions |=3D OPTION_MPTCP_FASTCLOSE;
+	opts->rcvr_key =3D subflow->remote_key;
+
+	return true;
+}
+
 static noinline void mptcp_established_options_rst(struct sock *sk, struct=
 sk_buff *skb,
 						   unsigned int *size,
 						   unsigned int remaining,
@@ -691,6 +716,9 @@ static noinline void mptcp_established_options_rst(stru=
ct sock *sk, struct sk_bu
 	if (remaining < TCPOLEN_MPTCP_RST)
 		return;
 =

+	if (mptcp_established_options_fastclose(sk, size, remaining, opts))
+		return;
+
 	*size =3D TCPOLEN_MPTCP_RST;
 	opts->suboptions |=3D OPTION_MPTCP_RST;
 	opts->reset_transient =3D subflow->reset_transient;
@@ -1179,6 +1207,13 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 		ptr +=3D 5;
 	}
 =

+	if (OPTION_MPTCP_FASTCLOSE & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FASTCLOSE,
+				      TCPOLEN_MPTCP_FASTCLOSE, 0, 0);
+		put_unaligned_be64(opts->rcvr_key, ptr);
+		ptr +=3D 2;
+	}
+
 	if (OPTION_MPTCP_RST & opts->suboptions)
 		*ptr++ =3D mptcp_option(MPTCPOPT_RST,
 				      TCPOLEN_MPTCP_RST,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7e9705943813..6b6efa00cad5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2133,6 +2133,29 @@ static void __mptcp_check_send_data_fin(struct sock =
*sk)
 	}
 }
 =

+static void __mptcp_send_fastclose(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	WRITE_ONCE(msk->snd_fastclose, true);
+
+	__mptcp_flush_join_list(msk);
+	__mptcp_clear_xmit(sk);
+
+	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(tcp_sk);
+		subflow->reset_transient =3D 0;
+		subflow->reset_reason =3D MPTCP_RST_EMPTCP;
+		mptcp_subflow_reset(tcp_sk);
+		release_sock(tcp_sk);
+	}
+}
+
 static void __mptcp_wr_shutdown(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -2185,6 +2208,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
 	bool do_cancel_work =3D false;
+	bool send_fin =3D false;
 =

 	lock_sock(sk);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
@@ -2197,7 +2221,13 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 		goto cleanup;
 	}
 =

-	if (mptcp_close_state(sk))
+	send_fin =3D mptcp_close_state(sk);
+	if (!skb_queue_empty(&sk->sk_receive_queue)) {
+		__mptcp_send_fastclose(sk);
+		send_fin =3D false;
+	}
+
+	if (send_fin)
 		__mptcp_wr_shutdown(sk);
 =

 	sk_stream_wait_close(sk, timeout);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d4c99e091cb9..93352044bff9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,6 +243,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		snd_fastclose;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	spinlock_t	join_list_lock;
-- =

2.26.2

--===============6976805264532074764==--
