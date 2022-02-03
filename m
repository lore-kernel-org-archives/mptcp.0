Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B822CA1
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858022; x=1675394022;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t0F+LtZuBQhBzOAqb3kTvTyZmkbo6vTLqs3duOIuOUY=;
  b=U+FQPvOKaC23ciWDyiWPcbA/fzqd9NeEFzeBVDMTDbt+RMj8oR6lyQeF
   qg03m2U7AWHjbqn7M+knfcDI4hm/hIbCTMup/KJiuETU9R/0rz+EguxqY
   d5GG1aOzwLkyLs2ZKopIpKgHnZRvqjAIZanuWGBORNoWIK2bX6fZIchl2
   dL3u61HN9qmrh3IltPW1NvRZ/riSdKjQEn9gr85eODzVi6j9eakajKia8
   w3Rp7swQewqYEF/mSP/SvLWduzz7JoOuZMd1lADIZFrnQbFd7tWsEZtJl
   ThrIQtDmMg6OVLlzpu/4EqjzSaJkGso/V90M/v5HbPWnVBfT48X2FV3RW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308795478"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="308795478"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="771658253"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:39 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 2/8] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Wed,  2 Feb 2022 22:13:25 -0500
Message-Id: <20220203031331.2996457-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203031331.2996457-1-kishen.maloor@intel.com>
References: <20220203031331.2996457-1-kishen.maloor@intel.com>
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
index 8c25a1122bfd..d3691b95401a 100644
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

