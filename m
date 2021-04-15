Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64B2BC0
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 23:45:12 +0000 (UTC)
IronPort-SDR: 5SofQsnX265WhmYd0OpfgReojzfaBManCO9NfLBEPGmPgbvFK81l5oE+IAKJos5+wFkWzp47js
 9wAES8FmDJKw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258923277"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258923277"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:08 -0700
IronPort-SDR: oXcO+T70XrIKJyvX6gmp1SlRTF8xeOQIOPcgBEhYahqiNBFaQ7VZezvLFmdYVrUEEPLiF+CSHA
 qG/P7guI/buw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461793361"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.243.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:08 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 06/13] mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
Date: Thu, 15 Apr 2021 16:44:55 -0700
Message-Id: <20210415234502.224225-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415234502.224225-1-mathew.j.martineau@linux.intel.com>
References: <20210415234502.224225-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

start with something simple: both take an integer value, both
need to be mirrored to all subflows.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
2.31.1

