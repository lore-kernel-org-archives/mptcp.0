Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562154C68
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647558299; x=1679094299;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GiJRkzBbiNXfy3KcKC95cXuHIvtFfxdO0CETTIUQJGY=;
  b=GJgzUsV1VgMTsiCW1TmgimlIwtIUltb56jqKbX1ADdtIrWuAABOXdUiF
   awnURt98ZBFXRjNBrUq3xDo92pr5Jv2hMKjGXFLd+HJEv9s46vXFmh8Qm
   btS/k3S0ByDX3gsPfm24PDp4GHK2ggztXkjg8CsmiVHM9XzPlFCBluxCa
   ayMlHOLAWM9q6VDVC13dttuUAR9KVF1WmohiDNtEGMjTbO0VYBdoIpxzb
   3f3bJHn7CKXKipOEJqURk1/3LzHsr5QXwkcb3DhgitaMfq8cTePZw5pUM
   2YZRXhqAoK3Buf2CRvBjtrKqUvyKqZJODADjvtxoe3JrejiT3uXQjGbXh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257189951"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="257189951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="499015057"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:55 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 3/6] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Thu, 17 Mar 2022 19:04:46 -0400
Message-Id: <20220317230449.763778-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220317230449.763778-1-kishen.maloor@intel.com>
References: <20220317230449.763778-1-kishen.maloor@intel.com>
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
index e10a1cc916d6..43d6cc9be512 100644
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

