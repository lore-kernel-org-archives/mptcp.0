Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEF2CB5
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693451; x=1671229451;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RqFkuGksiI6R0XGEF4afMW+j7YKqqFmAYKoc85fXM8U=;
  b=mJZ5WmgvnvGkiP8RQ14fa0a8vXLdF6fbFHA7xopeqFwni7OQkLkwyhWv
   UZLViOsqd77DH6AmfzdDL0+1p0ZBujJKR4/NqyPtw2AEWYS04Vbx545si
   yTf4fhmN4LfZms1M6d+2wxlToNBEU+YShT1hQ/o3p3u9nUX5Ds7fV5FCV
   nN+8S/FvOslmk+42WaQRPCTV4JLkGyLU0tRYeM5HYp/oM84RCgmpR36mg
   Osn4dfwuLxa9tutwP4cVuWzYpOL0NT9StZ/6r/Jxdk4Xycp6s7btxJqD1
   PZzDS6TqcWzINT4qhq0zDWUzWoI1tnbamPivuvS8tYrMZ7HR78isaAEm1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393155"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393155"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461223"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 01/21] mptcp: do not restrict subflows with non-kernel PMs
Date: Thu, 16 Dec 2021 17:22:54 -0500
Message-Id: <20211216222314.1244708-2-kishen.maloor@intel.com>
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

All numerical restrictions on # of addresses/subflows
currently apply only to in-kernel PM managed connections.
Thus this change removes limitations on adding new subflows
by non-kernel (e.g. userspace) PMs.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm.c      | 7 +++++++
 net/mptcp/subflow.c | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f8878cc29e3..5f35fe8a5e82 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,6 +87,13 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
+	if (READ_ONCE(pm->pm_type) != MPTCP_PM_TYPE_KERNEL) {
+		spin_lock_bh(&msk->pm.lock);
+		++pm->subflows;
+		spin_unlock_bh(&msk->pm.lock);
+		return true;
+	}
+
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd5fdb639088..b009d0f7fb77 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -62,7 +62,8 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
-	       READ_ONCE(msk->pm.accept_subflow);
+	       ((READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL) ||
+		READ_ONCE(msk->pm.accept_subflow));
 }
 
 /* validate received token and create truncated hmac and nonce for SYN-ACK */
-- 
2.31.1

