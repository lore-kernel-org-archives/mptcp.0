Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB82C9D
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643873116; x=1675409116;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=31Rn1fVGrhzOGv3WF3Z/oTSCRdUAxWa4OxdrNJxlX2M=;
  b=dMwnQ9NKhs+9pCgDLX/HKjCOMM7YgG0OWUWe5qsfW/xJk2wddW7aYMCQ
   iwsgArHWShwjKmu5JQqir0HAI9J6iFsEmjVjOUu5VYVNhdSdofqRzF7Ed
   2Wg7ecXngRmMnDe6buEYCXnv1iYHGCB5dJArJtBcb1ebuy1vyZ0lfS9yU
   BrcYlktTp8W+XE6nwUEvRUr54tsQfWJVY9MnbuW0khaflHbRoNU+xmOBx
   zfQhila75P5uZjCezIwl/gP8qojDEEdfta9JY+nSurJmvyKv/3kBFf4kL
   Sb8z2fA3z/c8AJoGlfiBOjuT27YFvxCFh7Z6q4TSep5dxahjd9viE1LWL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272580769"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272580769"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="535118714"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:13 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 1/8] mptcp: bypass in-kernel PM restrictions for non-kernel PMs
Date: Thu,  3 Feb 2022 02:25:01 -0500
Message-Id: <20220203072508.3072309-2-kishen.maloor@intel.com>
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

Current limits on the # of addresses/subflows must apply only to
in-kernel PM managed sockets. Thus this change removes such
restrictions for connections overseen by non-kernel (e.g. userspace)
PMs.

This change also ensures that the kernel does not record stats inside
struct mptcp_pm_data updated along kernel code paths when exercised
by non-kernel PMs.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v4: rephrased commit message, add API mptcp_pm_is_kernel(), bypass
accounting fo non-kernel PM managed connections
---
 net/mptcp/pm.c         | 6 +++++-
 net/mptcp/pm_netlink.c | 3 +++
 net/mptcp/protocol.h   | 9 +++++++--
 net/mptcp/subflow.c    | 3 ++-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f8878cc29e3..3e053b759181 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,6 +87,9 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
+	if (!mptcp_pm_is_kernel(msk))
+		return true;
+
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	pr_debug("msk=%p subflows=%d max=%d allow=%d", msk, pm->subflows,
@@ -179,7 +182,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	bool update_subflows;
 
 	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
-			  (subflow->request_join || subflow->mp_join);
+			  (subflow->request_join || subflow->mp_join) &&
+			  mptcp_pm_is_kernel(msk);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 93800f32fcb6..bf24c1a74e1d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -795,6 +795,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!removed)
 			continue;
 
+		if (!mptcp_pm_is_kernel(msk))
+			continue;
+
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f37f087caab3..ac8b57d4f853 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -804,9 +804,14 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline bool mptcp_pm_is_userspace(struct mptcp_sock *msk)
+static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL;
+	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
+}
+
+static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
 }
 
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 88ee94adc38c..8c25a1122bfd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -62,7 +62,8 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
-	       READ_ONCE(msk->pm.accept_subflow);
+		(!mptcp_pm_is_kernel(msk) ||
+		READ_ONCE(msk->pm.accept_subflow));
 }
 
 /* validate received token and create truncated hmac and nonce for SYN-ACK */
-- 
2.31.1

