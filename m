Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B520E6
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520051; x=1680056051;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GKhZx0nF/uINtofrjJx97ZVcvMzDhR2KV3qHhBQpcrw=;
  b=nSDeYqTnSeDnlB/vRqtVoHnVw1uBTffDLkC4KY703JyL9UbHwyZtLU22
   9BLJ27hyt7syTVmA0A2pH6aLcsw1gRLEqFGF4A/AUtqqN1phwRW2mnBgg
   L1khLWr4sye4OAV37RTITnZZSy77EV/xDoZW6a7hxobzRxkDsS+1+aLnr
   0QzrUTJf9e5Ums4z7byZeA3XStemO627vWV/qEzjkIMaJWSVpgc47Xk57
   zg2KMaqOMvjdvabKIg3JCaWctf5kOucYdhEOUCO8xewmuBkANrGe35Gdl
   a99WMwsRAeGAytxnsIzWdSV6WGe6OiYCXm9c/wb8kCP4i6MkMPkw8v7tz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345578744"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="345578744"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202544"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:07 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 3/6] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Mon, 28 Mar 2022 22:13:58 -0400
Message-Id: <20220329021401.1196466-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
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
index 9567231a4bfa..a0e7af33fb26 100644
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

