Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3D2CAB
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 00:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642725339; x=1674261339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6d0wzumL2zpgrbwhNb2ExiuQQiRc8+qhYIDnlEKDhk=;
  b=YFrFCRrOs31fP7LReAir4Lp3cbaEy7oT6ZxcmwmZ9RgMKPSRdwxlhZF3
   AEqM+GBchpNals95Tm7Z0VU8+cPs1r5htnlmnn6OZc/c5OyA7QyoXNlFH
   Pcj/JG+ZkfdjkGKFVByzXGMN+e28mkp2TIKtVA3XXryb839dJFB9KbIyD
   WThMZIWqspkJfZBrDDOCpuB8p0EZpB+8exPD630HFk4weFYUCTJOpm1U7
   ZJbKYPAR2CfiAdTpj+KFplqRt1J/e4GPm/2XyCcfcGqDNuxCAiva9SJXA
   2sPIUCJSJoubHgaXt0nAj09W6rHZfJGP5/HcUyIQ8eebCPvX/5T+670Al
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="232886197"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="232886197"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 16:35:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="531215218"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.220.167])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 16:35:37 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/3] mptcp: fix removing ids bitmap setting
Date: Thu, 20 Jan 2022 16:35:28 -0800
Message-Id: <20220121003529.54930-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121003529.54930-1-mathew.j.martineau@linux.intel.com>
References: <20220121003529.54930-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

In mptcp_pm_nl_rm_addr_or_subflow(), the bit of rm_list->ids[i] in the
id_avail_bitmap should be set, not rm_list->ids[1]. This patch fixed it.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f17a09f7fbf9..782b1d452269 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -791,7 +791,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			removed = true;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
-		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
+		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
 		if (!removed)
 			continue;
 
-- 
2.34.1

