Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942EE3B39
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 19:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457681; x=1678993681;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HrlYba3+geBltWVQiUd+2w/Aff7LNAiojSaD3N7snHg=;
  b=OmGV0g5s7T5/fgyl5QIC5P8cIuJgBS5hhEe3UnRyAQzrf2x0VigW7BLV
   3zFGdlxXhQswIUGqNreCZCLJ+C5ZWfDaltz2KUwC2IMKOWsQ/99WwJXgQ
   8x8JgLRJJ5iald4SvL/Qfhjy73JexOvmf9c5g/iZFQadxrrkuTLFTaGjW
   8KD+xDjjxoM+G+4bWdUKX34RRaIyqZhAvp87eLdKmXP/mklNrtjtapsxB
   WGePQnlMiGjmBsjTB/90Sw2H8f4oe/75M4aMC2/sU/IYEceIGYv9fpzR3
   aHsAiYgoB0Nd1KOSvfdK7eXwBvzYZcr6/E3kcKHRpHHd+htE7++H/xfvr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255521708"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255521708"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:07:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="644799808"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:07:58 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/5] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Wed, 16 Mar 2022 15:07:44 -0400
Message-Id: <20220316190747.634325-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316190747.634325-1-kishen.maloor@intel.com>
References: <20220316190747.634325-1-kishen.maloor@intel.com>
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

