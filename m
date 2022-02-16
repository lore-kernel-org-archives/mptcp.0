Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D51FA2
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644977511; x=1676513511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qrnYRmJrn6hTTdPY3q7FWl8XGYjIDPWqRW7s3SDCYxs=;
  b=Q54nEi6t3f1pIqMIei5Uzcq3H5jzH7Zx5Drt+YS+omZ0CIKnqL1+3zUg
   UL7hwWMlN25F7SMJt1BpOF5sTgTsQqN1Nh3mZ8eFF66An+DKuHB6N6JYg
   Sk6rmXkmQrCJWhvj7e4rSaUOjbwbLcj/SyWGPX2XkIyHa0CAvSglW7Bu4
   fgbYCW61jC6UsudbZGTQB1tck/Y/CK4YDq/OLamdr7soD0jNsAKl8mIhH
   PyhRBt32QfaR8FjDpdJoS+wUS5SElntWabQqdr8NPDFMiQUX8Mk4BeHx/
   PGReUb9eEqQc5Nlnkyj3mx/LJrRY/2XQSy+ddScE4GwSTgt3n44Du6Dw6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313778512"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313778512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571088818"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.181])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:36 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/8] mptcp: mptcp_parse_option is no longer exported
Date: Tue, 15 Feb 2022 18:11:24 -0800
Message-Id: <20220216021130.171786-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
References: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

Options parsing in now done from mptcp_incoming_options().

mptcp_parse_option() has been removed from mptcp.h when CONFIG_MPTCP is
defined but not when it is not.

Fixes: cfde141ea3fa ("mptcp: move option parsing into mptcp_incoming_options()")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/mptcp.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a925349b4b89..0a3b0fb04a3b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -217,12 +217,6 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return false;
 }
 
-static inline void mptcp_parse_option(const struct sk_buff *skb,
-				      const unsigned char *ptr, int opsize,
-				      struct tcp_options_received *opt_rx)
-{
-}
-
 static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 				     unsigned int *size,
 				     struct mptcp_out_options *opts)
-- 
2.35.1

