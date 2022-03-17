Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235848A2
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647531304; x=1679067304;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HrlYba3+geBltWVQiUd+2w/Aff7LNAiojSaD3N7snHg=;
  b=NYQvCcJgcv9eGdCuAU5yk0FHJ1h6hrhDBj3m59isH3lrbWeJjOstOKU6
   DQ7NtpFVDMI+ddFJZa+uNjoqaqWJeCxwdpqBljwTEFQkuYC7u7p89+WdP
   c4AyUv+Kk4CGNAB8mwIlR73zVAzGTozVCnYanyl5rh9SFpS4PSBi/fVJ9
   bXR9Yv3BhCfUgq8QxB88/DunflVFw0hT2X+mlqvc8wI0tuTIspuc5hj7X
   J23dRsPCadCreg+elK5Ct8oBz3fZb7C3O/ZwOtsynj/CVAMY+qD7Y1P7W
   CbAGaP7t/N9Humc6N3GW2Nz6XEfjPI+rUOb7mFstHnGmm08CKVN/JDlls
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237504878"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237504878"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516804203"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:01 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 2/5] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Thu, 17 Mar 2022 11:34:50 -0400
Message-Id: <20220317153453.665359-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220317153453.665359-1-kishen.maloor@intel.com>
References: <20220317153453.665359-1-kishen.maloor@intel.com>
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
index 2fb78b4b3ca6..59657b7e4788 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -443,6 +443,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
+		subflow->remote_id = mp_opt.join_id;
 		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
 			 subflow, subflow->thmac, subflow->remote_nonce,
 			 subflow->backup);
-- 
2.31.1

