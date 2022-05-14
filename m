Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B4362
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652487684; x=1684023684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTy6YizjRk/aiQtdxnOlDVnO3Ugko3s9yjx08r1djuo=;
  b=MPH2313MkXle5DSD83LA6Qa/FBnXUZCXZcgeS+sgQ0CWzDOQ2TnnU/ba
   /71lsCX8eOo6gVYb7QNxoC5fcIENz2ibQEY8kPYL2vokFc0uwwWp3xP0f
   VtKs3ZArm0drEC51huS0v0D4brJhF2thGPLnKXSSqRiRdGKT/v9XsrYm7
   nenaUMDXBBsYtePAEijpF4HniJKS+NMTOCzDhgW1nbz8R4SLu5ZDeiO9g
   aTKY43N0KHmrLaMq94IAkUW+5C3AOAl6p0gbfB5RmnMl0baZjuWGEW2pJ
   mkyNmSwi3Mpdv3/1bbtDmTpM2TTq8zVzkaYtufc52yFZ/cevMuujBS9gs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250349601"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250349601"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:21:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="625102789"
Received: from clakshma-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.160.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:21:21 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/3] mptcp: sockopt: add TCP_DEFER_ACCEPT support
Date: Fri, 13 May 2022 17:21:15 -0700
Message-Id: <20220514002115.725976-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
References: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Support this via passthrough to the underlying tcp listener socket.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/271
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 826b0c1dae98..423d3826ca1e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -756,6 +756,18 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optval,
+					  unsigned int optlen)
+{
+	struct socket *listener;
+
+	listener = __mptcp_nmpc_socket(msk);
+	if (!listener)
+		return 0; /* TCP_DEFER_ACCEPT does not fail */
+
+	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -782,6 +794,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
 	case TCP_NODELAY:
 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
+	case TCP_DEFER_ACCEPT:
+		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1142,6 +1156,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
+	case TCP_DEFER_ACCEPT:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
-- 
2.36.1

