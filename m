Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57D6D13
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 18:50:30 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lUZjZ-00018K-Af; Thu, 08 Apr 2021 20:50:29 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 09/10] mptcp: sockopt: add TCP_CONGESTION and TCP_INFO
Date: Thu,  8 Apr 2021 20:49:35 +0200
Message-Id: <20210408184936.6245-10-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408184936.6245-1-fw@strlen.de>
References: <20210408184936.6245-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP_CONGESTION is set for all subflows.
The mptcp socket gains icsk_ca_ops too so it can be used to keep the
authoritative state that should be set on new/future subflows.

TCP_INFO will return first subflow only.
The out-of-tree kernel has a MPTCP_INFO getsockopt, this could be added
later on.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/protocol.c |   4 ++
 net/mptcp/sockopt.c  | 101 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 26e3ffe8840e..302419e2d92c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2390,6 +2390,8 @@ static int __mptcp_init_sock(struct sock *sk)
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
 
+	tcp_assign_congestion_control(sk);
+
 #if IS_ENABLED(CONFIG_KASAN)
 	sock_set_flag(sk, SOCK_RCU_FREE);
 #endif
@@ -2586,6 +2588,8 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
+
+	tcp_cleanup_congestion_control(sk);
 	sk_refcnt_debug_release(sk);
 	mptcp_dispose_initial_subflow(msk);
 	sock_put(sk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index e7a710d1d1de..ab9eb728e649 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -510,6 +510,62 @@ static bool mptcp_supported_sockopt(int level, int optname)
 	return false;
 }
 
+static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t optval,
+					       unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	char name[TCP_CA_NAME_MAX];
+	bool cap_net_admin;
+	int ret;
+
+	if (optlen < 1)
+		return -EINVAL;
+
+	ret = strncpy_from_sockptr(name, optval,
+				   min_t(long, TCP_CA_NAME_MAX - 1, optlen));
+	if (ret < 0)
+		return -EFAULT;
+
+	name[ret] = 0;
+
+	cap_net_admin = ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
+
+	ret = 0;
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err;
+
+		lock_sock(ssk);
+		err = tcp_set_congestion_control(ssk, name, true, cap_net_admin);
+		if (err < 0 && ret == 0)
+			ret = err;
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+		release_sock(ssk);
+	}
+
+	if (ret == 0)
+		tcp_set_congestion_control(sk, name, false, cap_net_admin);
+
+	release_sock(sk);
+	return ret;
+}
+
+static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
+				    sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case TCP_ULP:
+		return -EOPNOTSUPP;
+	case TCP_CONGESTION:
+		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
 		     sockptr_t optval, unsigned int optlen)
 {
@@ -539,6 +595,49 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	if (level == SOL_IPV6)
 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
 
+	if (level == SOL_TCP)
+		return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
+
+	return -EOPNOTSUPP;
+}
+
+static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
+					  char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct socket *ssock;
+	int ret = -EINVAL;
+	struct sock *ssk;
+
+	lock_sock(sk);
+	ssk = msk->first;
+	if (ssk) {
+		ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
+		goto out;
+	}
+
+	ssock = __mptcp_nmpc_socket(msk);
+	if (!ssock)
+		goto out;
+
+	ret = tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
+
+out:
+	release_sock(sk);
+	return ret;
+}
+
+static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
+				    char __user *optval, int __user *optlen)
+{
+	switch (optname) {
+	case TCP_ULP:
+	case TCP_CONGESTION:
+	case TCP_INFO:
+	case TCP_CC_INFO:
+		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
+	}
 	return -EOPNOTSUPP;
 }
 
@@ -562,6 +661,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 
+	if (level == SOL_TCP)
+		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	return -EOPNOTSUPP;
 }
 
-- 
2.26.3

