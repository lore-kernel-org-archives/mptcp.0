Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F12CA1
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643873116; x=1675409116;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=t0F+LtZuBQhBzOAqb3kTvTyZmkbo6vTLqs3duOIuOUY=;
  b=TBl6e94gHuSWLjiAUrdOArLZahDxqUAtwmnMawUpFlbXXk0HL5KSspq+
   JHAXjRFFOLKoohW3VLpWA6mqyuujK4rQ6+6NjTPtKBOS3H1YHQlMGsSps
   8fTk80cpKfw29HlUpprOvxoa6QmUvLmejST18c1jEc8SWHgFJHmYTTHk8
   XxwL/tuDI/+oCC9E+TxqmeMqWuBNEIcpbqcQoIInmpFlrWMD+5HzUqqWN
   PcfukvfKHEAD79TFAZS0YGze2azVvYxJVMtqpw/+rULMgBE56/mGS6gCt
   Bhu6/KZeBCJ08EjA/agAO20eE2RtUxOTmckRh/Ea6DEoEbckyAvaLj90C
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272580770"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272580770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="535118717"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:13 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 2/8] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Thu,  3 Feb 2022 02:25:02 -0500
Message-Id: <20220203072508.3072309-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203072508.3072309-1-kishen.maloor@intel.com>
References: <20220203072508.3072309-1-kishen.maloor@intel.com>
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

