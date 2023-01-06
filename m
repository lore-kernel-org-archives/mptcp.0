Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0E27739
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673031456; x=1704567456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8j66yE5ZsopPuGlmnjXEvad7t+TtqAEDHQTh0TgPuN8=;
  b=aty/HgITD/PJSfPtatdG6/P170Zg+kKo0my0Ia7LN5zszhGABzj/m746
   D6Uyv0rXOfBP8zokNM/RrVo6logPqTp/4rvY8gQGvnQOn6RT4NpReLEzD
   VZ8quKtl8muMpJwqfIgR9mCMd02usPOD1/zX24rrikaPUGx9emCq48K6a
   YXuh3tKlDqoZ+wVlKZE5Wt7eNYUb68GSc7fMdKbL00YYYm4YWqG5cMzza
   JVQ/p/bQnOKjOqQ0x+kyIa9uBgi44lxbSz/CxCvLjxofy/PMa5Zm/f+zR
   pRPCwpAzZin+h3/3FemchAJ/zClbKDcAQe9AR9AnY+wmnXtqcDDri9sSV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322611211"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="322611211"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="688383428"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="688383428"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:33 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/9] mptcp: use net instead of sock_net
Date: Fri,  6 Jan 2023 10:57:18 -0800
Message-Id: <20230106185725.299977-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
References: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Use the local variable 'net' instead of sock_net() in the functions where
the variable 'struct net *net' has been defined.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 5 ++---
 net/mptcp/protocol.c   | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2ea7eae43bdb..b5505b8167f9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1143,7 +1143,7 @@ void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ss
 			if (!tcp_rtx_and_write_queues_empty(ssk)) {
 				subflow->stale = 1;
 				__mptcp_retransmit_pending_data(sk);
-				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWSTALE);
+				MPTCP_INC_STATS(net, MPTCP_MIB_SUBFLOWSTALE);
 			}
 			unlock_sock_fast(ssk, slow);
 
@@ -1903,8 +1903,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (token)
-		return mptcp_userspace_pm_set_flags(sock_net(skb->sk),
-						    token, &addr, &remote, bkup);
+		return mptcp_userspace_pm_set_flags(net, token, &addr, &remote, bkup);
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c533b4647fbe..62c140f96d77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2723,8 +2723,8 @@ static int mptcp_init_sock(struct sock *sk)
 	mptcp_ca_reset(sk);
 
 	sk_sockets_allocated_inc(sk);
-	sk->sk_rcvbuf = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[1]);
-	sk->sk_sndbuf = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[1]);
+	sk->sk_rcvbuf = READ_ONCE(net->ipv4.sysctl_tcp_rmem[1]);
+	sk->sk_sndbuf = READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
 
 	return 0;
 }
-- 
2.39.0

