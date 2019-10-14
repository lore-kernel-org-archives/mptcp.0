Content-Type: multipart/mixed; boundary="===============8286899088807335932=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/6] mptcp: switch mptcp_poll to mptcp socket wait
 queue
Date: Tue, 15 Oct 2019 01:19:17 +0200
Message-ID: <20191014231919.2454-5-fw@strlen.de>
In-Reply-To: 20191014231919.2454-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2126

--===============8286899088807335932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_poll places current task on a wait queue.  This can cause us to block
forever -- some subflows might never receive any data because they're
used as a backup/fallback path.

This makes mptcp_poll wait on the mptcp socket wait queue instead.
__tcp_poll is used instead to avoid blocking current task again after
parent mptcp socket has been woken from the subflow layer.

The series is incomplete, mptcp_should_wake_parent() should be extended
to take packets off the subflow queue and add them to the mptcp socket
queue, i.e. move most of the work currently done at recvmsg time into
the wakeup function.

This is also needed to not wake userspace in case the subflow tcp data
was stale (e.g. because of too early mptcp-level retransmit).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 9 ++++++++-
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 5 ++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c4be647a8057..259a2743db91 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -523,6 +523,11 @@ static enum mapping_status mptcp_get_mapping(struct so=
ck *ssk)
 	return ret;
 }
 =

+bool mptcp_should_wake_parent(struct mptcp_subflow_context *subflow)
+{
+	return true;
+}
+
 static void mptcp_wait_data(struct sock *sk, long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
@@ -1378,11 +1383,13 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
 		return ret;
 	}
 =

+	sock_poll_wait(file, sock, wait);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct socket *tcp_sock;
 =

 		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
-		ret |=3D tcp_poll(file, tcp_sock, wait);
+		ret |=3D __tcp_poll(tcp_sock->sk);
 	}
 	release_sock(sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 991182578b22..73f79d82f76e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -262,6 +262,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 void mptcp_finish_join(struct sock *sk);
 void mptcp_reset_timer(struct sock *sk);
+bool mptcp_should_wake_parent(struct mptcp_subflow_context *ctx);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2db2857a1ec6..c3429f8eca6e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -320,13 +320,12 @@ static void subflow_data_ready(struct sock *sk)
 	subflow->tcp_sk_data_ready(sk);
 =

 	if (parent) {
-		pr_debug("parent=3D%p", parent);
-
 		smp_mb__before_atomic();
 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
 =

-		parent->sk_data_ready(parent);
+		if (mptcp_should_wake_parent(subflow))
+			parent->sk_data_ready(parent);
 	}
 }
 =

-- =

2.21.0

--===============8286899088807335932==--
