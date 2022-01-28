Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D862C9D
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330320; x=1674866320;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PwE0NguYM09Sq5YI4hK1jOZyJZjZSRflvISwfqFUO10=;
  b=b+QIVWC+yN2ASTxAMHgmZgevl4SabSHYyf9St9XUUeSi4W0lKCNFSx7H
   ZpnsT6GglDRQ01mv9jlReC5yYcFmf1xOnvBCqHzTasyg89DQy+cxProlm
   qmW1LYJ99WRI+STVXk7Q01h2elUaYZQdlA4QVojgVFBYb9T6fCvJr7ncQ
   C71iNFBLwPbQlLrYwdwi02a13ZhVVmAtnlYH33JvDSoqnCiSwq/4hK7BZ
   Xu2A1z6Do2sov4r7bnFItAl1JrW5YkazyG90EHLYbiNWVcfr2vNtAQa+P
   L4upIPp1pKZpmu1+LLQNH2oQCtARLtwbZXC0xXgTXtwg/hxJOOkdmpY9I
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245846910"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245846910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564000996"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:19 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 2/8] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Thu, 27 Jan 2022 19:38:06 -0500
Message-Id: <20220128003812.2732609-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003812.2732609-1-kishen.maloor@intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change reads the addr id assigned to the remote endpoint
of a subflow from the MP_JOIN SYN/ACK message and stores it
in the related subflow context. The remote id was not being
captured prior to this change, and will now provide a consistent
view of remote endpoints and their ids as seen through netlink
events.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a7b2d6fd1c1e..479a4f53bbdd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -444,6 +444,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
+		subflow->remote_id = mp_opt.join_id;
 		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
-- 
2.31.1

