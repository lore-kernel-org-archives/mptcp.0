Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9B6D17
	for <mptcp@lists.linux.dev>; Wed,  7 Apr 2021 00:16:15 +0000 (UTC)
IronPort-SDR: bD/znEsJ0GlqzaUH/3kghKILgVXAJ4b5eY8xyn8DeBw/lckNbTGPU2OvkwcRbWbP1IQG/+P9ba
 J4owRY/e9hcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="192723068"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="192723068"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 17:16:11 -0700
IronPort-SDR: +45XRN7k6CupY5dHVIK4Sktd0j7lIquZ7WKlJ8tGcWaD42bRlbPLIHNOfOtS2lVxuRv8NJajlt
 ASJXZJNGQx3Q==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="458105206"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.254.115.52])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 17:16:11 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 8/8] mptcp: drop all sub-options except ADD_ADDR when the echo bit is set
Date: Tue,  6 Apr 2021 17:16:04 -0700
Message-Id: <20210407001604.85071-9-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407001604.85071-1-mathew.j.martineau@linux.intel.com>
References: <20210407001604.85071-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

Current Linux carries echo-ed ADD_ADDR over pure TCP ACKs, so there is no
need to add a DSS element that would fit only ADD_ADDR with IPv4 address.
Drop the DSS from echo-ed ADD_ADDR, regardless of the IP version.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c7eb61d0564c..d51c3ad54d9a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -624,7 +624,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	int len;
 
 	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk)) &&
+	     mptcp_pm_should_add_signal_port(msk) ||
+	     mptcp_pm_should_add_signal_echo(msk)) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions = 0;
-- 
2.31.1

