Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF572C81
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 20:41:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="295303539"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="295303539"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 12:41:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="506889219"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.14.166])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 12:41:46 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Poorva Sonparote <psonparo@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/4] mptcp: Support for IP_TOS for MPTCP setsockopt()
Date: Fri, 19 Nov 2021 12:41:35 -0800
Message-Id: <20211119204137.415733-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211119204137.415733-1-mathew.j.martineau@linux.intel.com>
References: <20211119204137.415733-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Poorva Sonparote <psonparo@redhat.com>

SOL_IP provides a way to configure network layer attributes in a
socket. This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)

Support for SOL_IP is added in mptcp_setsockopt() and IP_TOS is handled in
a private function. The idea here is to take in the value passed for IP_TOS
and set it to the current subflow, open subflows as well new subflows that
might be created after the initial call to setsockopt(). This sync is done
using sync_socket_options(.., ssk) and setting the value of tos using
__ip_sock_set_tos(ssk,..).

The patch has been tested using the packetdrill script here -
https://github.com/multipath-tcp/mptcp_net-next/issues/220#issuecomment-947863717

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/220
Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0f1e661c2032..b452571e8d9b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,6 +598,42 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int err, val;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = inet_sk(sk)->tos;
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		__ip_sock_set_tos(ssk, val);
+	}
+	release_sock(sk);
+
+	return err;
+}
+
+static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
+			       sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IP_TOS:
+		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -637,6 +673,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_setsockopt(ssk, level, optname, optval, optlen);
 
+	if (level == SOL_IP)
+		return mptcp_setsockopt_v4(msk, optname, optval, optlen);
+
 	if (level == SOL_IPV6)
 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
 
@@ -1003,6 +1042,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
+	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.34.0

