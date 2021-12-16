Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FB2CA7
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693451; x=1671229451;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=g3HjRxAW2nKK2T0as/ELLt/oJ+EohLEJGBuBJ9Xk7D0=;
  b=JUXsLOSA0e7hySPXWhwjZnk11NGTz4IF/mUKTD9rbmk4D4UzY52kHcgF
   fdZJs8HlhMj0FcHoAyS7dclzRXdRZO47c1hSq0xqrvz5nLMit3N2H/e3k
   sJGxEYLWoRNK5An8cD1TJTd7/Xbkqqrl+3lJG1tM8VpPODssoiKUVa0x9
   K39wR+Lo5pDG/tOUazg48VdfkelQqxCuJlz/y/E4CcCmfPHFpA2ZDvloL
   NsTVXyTrFKR4rke0C+fU8+vnJUvvj0lxbG2oYMwBKrZ9VILVz5NluzcZf
   +LsInoZY7TRaVJuqWFJlt+Atr+hI5nuEu/bU3uvo8fKaJniGguWxgGyRY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393157"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393157"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461226"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 02/21] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Thu, 16 Dec 2021 17:22:55 -0500
Message-Id: <20211216222314.1244708-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216222314.1244708-1-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
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
index b009d0f7fb77..b75b7b186d34 100644
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

