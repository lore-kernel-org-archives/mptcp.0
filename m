Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97A6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 13:16:06 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lP3Mi-0003ku-9Q; Wed, 24 Mar 2021 14:16:04 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: <mptcp@lists.01.org>,
	Florian Westphal <fw@strlen.de>
Subject: [RFC PATCH mptcp-next v2 2/8] mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
Date: Wed, 24 Mar 2021 14:15:40 +0100
Message-Id: <20210324131546.13730-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210324131546.13730-1-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
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
 net/mptcp/sockopt.c | 99 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 7f0cb012e3a2..dd9e921018f8 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -24,6 +24,82 @@ static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 	return msk->first;
 }
 
+static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval, unsigned int optlen, int *val)
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
+	msk->setsockopt_seq++;
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
@@ -50,6 +126,9 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 		}
 		release_sock(sk);
 		return ret;
+	case SO_KEEPALIVE:
+	case SO_PRIORITY:
+		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	}
 
 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
@@ -350,9 +429,24 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
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
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow;
+	bool slow;
 
 	msk_owned_by_me(msk);
 
@@ -360,7 +454,12 @@ void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
 	if (subflow->setsockopt_seq == msk->setsockopt_seq)
 		return;
 
+	slow = lock_sock_fast(ssk);
+
+	sync_socket_options(msk, ssk);
 	subflow->setsockopt_seq = msk->setsockopt_seq;
+
+	unlock_sock_fast(ssk, slow);
 }
 
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk)
-- 
2.26.3

