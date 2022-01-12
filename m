Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3E2CA1
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025769; x=1673561769;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RqFkuGksiI6R0XGEF4afMW+j7YKqqFmAYKoc85fXM8U=;
  b=SzikfJ66KRI1BpEfspMdWysylzbQ7eWcD469xpFSDn8rzXJ55W+ljo/B
   NctRh1wkpvSJ8v8LrGPVtC7ESg7JVByqk3kiCJ1yykHU/1zacljYp0UR/
   Ot0AFie+psM1PBCIPsmUpkQLw+wUFXrQLUsho8hHP8njkiD/Zx/P6o3zh
   2zmYPIqkO67cpz4h6s/1D+BmDvZ1dw8dJBeFHZWEqZKolzTciz7lWOLkg
   vf0fV3/5pgaaVy8YWWZUiJjFNinrShzYkY+VukGIe4fF1nsTJYJ8Qwtto
   IhKmDThLSVj+2oXOqLb2AZohQ34nmIoNZmBEJG1kTzEYFVotwnQdkVvHF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213928"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213928"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907330"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 01/21] mptcp: do not restrict subflows with non-kernel PMs
Date: Wed, 12 Jan 2022 17:15:03 -0500
Message-Id: <20220112221523.1829397-2-kishen.maloor@intel.com>
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

