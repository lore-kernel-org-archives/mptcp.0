Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DA2BC7
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 23:45:12 +0000 (UTC)
IronPort-SDR: xwZDSGIT7Cg631UPP5cCCJuLD2PVoXTKolDZ4J3sjHAQ3UqNUMDRdVE9OzbYTejKjzY272iDgn
 /7Na80+HzF1w==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258923280"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258923280"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:08 -0700
IronPort-SDR: gL12sDXfjrd8wB/3mbUlH5ccoRJxC3LTEeF5Eo+2Kl3J6oWr38HhdANlkf/+UkSqqyS34B2swG
 xKMjOG86BLdQ==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461793363"
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
Subject: [PATCH net-next 08/13] mptcp: setsockopt: support SO_LINGER
Date: Thu, 15 Apr 2021 16:44:57 -0700
Message-Id: <20210415234502.224225-9-mathew.j.martineau@linux.intel.com>
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

Similar to PRIORITY/KEEPALIVE: needs to be mirrored to all subflows.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index bfb9db04d26b..ee5d58747ce7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -143,6 +143,47 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	return -ENOPROTOOPT;
 }
 
+static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t optval,
+					      unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	struct linger ling;
+	sockptr_t kopt;
+	int ret;
+
+	if (optlen < sizeof(ling))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&ling, optval, sizeof(ling)))
+		return -EFAULT;
+
+	kopt = KERNEL_SOCKPTR(&ling);
+	ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, SO_LINGER, kopt, sizeof(ling));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
+
+		if (!ling.l_onoff) {
+			sock_reset_flag(ssk, SOCK_LINGER);
+		} else {
+			ssk->sk_lingertime = sk->sk_lingertime;
+			sock_set_flag(ssk, SOCK_LINGER);
+		}
+
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				       sockptr_t optval, unsigned int optlen)
 {
@@ -182,6 +223,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
+	case SO_LINGER:
+		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
 	}
 
 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
-- 
2.31.1

