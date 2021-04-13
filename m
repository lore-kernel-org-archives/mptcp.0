Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E070
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 15:55:06 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lWLNZ-0006rb-9S; Tue, 13 Apr 2021 17:55:05 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 03/10] mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
Date: Tue, 13 Apr 2021 17:54:40 +0200
Message-Id: <20210413155447.14043-4-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210413155447.14043-1-fw@strlen.de>
References: <20210413155447.14043-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

start with something simple: both take an integer value, both
need to be mirrored to all subflows.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 106 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 27b49543fc58..9be4c94ff4d4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -45,6 +45,90 @@ static u32 sockopt_seq_reset(const struct sock *sk)
 	return (u32)sk->sk_state << 24u;
 }
 
+static void sockopt_seq_inc(struct mptcp_sock *msk)
+{
+	u32 seq = (msk->setsockopt_seq + 1) & 0x00ffffff;
+
+	msk->setsockopt_seq = sockopt_seq_reset((struct sock *)msk) + seq;
+}
+
+static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval,
+				unsigned int optlen, int *val)
+{
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (copy_from_sockptr(val, optval, sizeof(*val)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
+
+		switch (optname) {
+		case SO_KEEPALIVE:
+			if (ssk->sk_prot->keepalive)
+				ssk->sk_prot->keepalive(ssk, !!val);
+			sock_valbool_flag(ssk, SOCK_KEEPOPEN, !!val);
+			break;
+		case SO_PRIORITY:
+			ssk->sk_priority = val;
+			break;
+		}
+
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+}
+
+static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optname, int val)
+{
+	sockptr_t optval = KERNEL_SOCKPTR(&val);
+	struct sock *sk = (struct sock *)msk;
+	int ret;
+
+	ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname,
+			      optval, sizeof(val));
+	if (ret)
+		return ret;
+
+	mptcp_sol_socket_sync_intval(msk, optname, val);
+	return 0;
+}
+
+static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
+					   sockptr_t optval, unsigned int optlen)
+{
+	int val, ret;
+
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+
+	switch (optname) {
+	case SO_KEEPALIVE:
+		mptcp_sol_socket_sync_intval(msk, optname, val);
+		return 0;
+	case SO_PRIORITY:
+		return mptcp_sol_socket_intval(msk, optname, val);
+	}
+
+	return -ENOPROTOOPT;
+}
+
 static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
@@ -71,6 +155,9 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 		}
 		release_sock(sk);
 		return ret;
+	case SO_KEEPALIVE:
+	case SO_PRIORITY:
+		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	}
 
 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
@@ -371,8 +458,27 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	return -EOPNOTSUPP;
 }
 
+static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	if (ssk->sk_prot->keepalive) {
+		if (sock_flag(sk, SOCK_KEEPOPEN))
+			ssk->sk_prot->keepalive(ssk, 1);
+		else
+			ssk->sk_prot->keepalive(ssk, 0);
+	}
+
+	ssk->sk_priority = sk->sk_priority;
+}
+
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
 {
+	bool slow = lock_sock_fast(ssk);
+
+	sync_socket_options(msk, ssk);
+
+	unlock_sock_fast(ssk, slow);
 }
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.26.3

