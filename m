Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F82173
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025768; x=1673561768;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=g3HjRxAW2nKK2T0as/ELLt/oJ+EohLEJGBuBJ9Xk7D0=;
  b=bLeWKLqEz5kFxiVtk64HR5MUOpBDl34WAATFlJCGuTCroXbYbp75dH7I
   ShRoLv7AmvusYzP4wp7EpIcoO5pYOFXQzfhF9Y0Y54kL0bIn2RqaatoDK
   ScQIHDtRMGzCfHf/MrT468n2oRdvL+6eOkj8A8JCC66TAw0QQgepNut9U
   1FnlJgROY7OIEs8bBLGnBx6FhK8dxbXSdiXPSwHfU4PLLFVaCEVp6dwWG
   N9S+SlxSqiVDpapNZea0iN5mv/35zVTTu0A29Gwmjf6yRuW/mndUpgE5a
   32gkslQqBj4LToypg6BzCx295wIbXpIMBzG4B39GL8y2OCgGeK6uwsGcw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213929"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213929"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907332"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 02/21] mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
Date: Wed, 12 Jan 2022 17:15:04 -0500
Message-Id: <20220112221523.1829397-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112221523.1829397-1-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
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

