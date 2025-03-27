Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278CC8EB
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055476; cv=none; b=ttrLbZ1lJQeFIXazJr8iz5hTHOJS0kHWhjX72bNgJYe07xEbk3oaFIO2vGd0N47OkKh7ZDWVw382l9IvLjRbQKFkJxeSHbV0DE7vrUOlktHqVTFtDXGWGLr7HiwsNfcNLe/M5vaAnSYcn1q3ROgM4onfSDNsV6T3BfG8Wg++cnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055476; c=relaxed/simple;
	bh=DTNLKgHaD8BgM9ml80LClI3y5O/zlNbj5kofR4RnwNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkiOHjvgLTmR+KfJoudNfklhNmnRENjeEQ9MlkZ6/77R8rwRC6hBiGCu4o9knOzh43qqmNS9VrTGyWHqhYMtpnePV723QDLRlP9Eb5F0F4SnOOiBb5KRulgD6rNjZll2HpIj8aaNxuJj80chI8w7K29RV4HoCH/flEcp65S0ITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/yhEZAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/yhEZAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB029C4CEDD;
	Thu, 27 Mar 2025 06:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055475;
	bh=DTNLKgHaD8BgM9ml80LClI3y5O/zlNbj5kofR4RnwNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/yhEZAVo4gwOHw2DyUu7x/URcfHFa0OAE5jzMQQo7hcMIjmHNuI6KDEKDoBfVxIR
	 MVDstjVl2RXWiEwSaIQMmi08aHYB5Nti+CEl8avgWWe98Swgg9veeZPke9W/t5YR2d
	 HmZvHSP3txj5roYtC7j/GRcDFi8nrpCWqT2ta6hLTuQufooGQ++jF0Zy8+GCQlt8Y+
	 jToKutPA+ctJ3XWe1MRauEfQt+j3u/eZBMvrlf6znkX9gX4+mIsh24p089ezsyhMX0
	 rfXlZnYCOOGEd80SARH+FCxIdHNa6YzfWnSVCps1F0v6SgcwHfdbM+lsEUHQU1z+W/
	 fYJXm8qtUwwQg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/7] mptcp: pm: use accept_new_subflow in allow_new_subflow
Date: Thu, 27 Mar 2025 14:04:13 +0800
Message-ID: <4de819beea2e553b61718a3b4c9b6180979961e0.1743054942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch reduces the dependency on mptcp_pm_is_userspace() to identify
userspace PM from in-kernel PM by using mptcp_pm_accept_new_subflow()
helper in mptcp_pm_allow_new_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c        | 27 ++++-----------------------
 net/mptcp/pm_kernel.c | 10 ++++++++++
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1c8395d3baa9..c72d2fade555 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -461,34 +461,15 @@ bool mptcp_pm_accept_new_subflow(struct mptcp_sock *msk, bool allow)
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
-	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk)) {
-		if (mptcp_userspace_pm_active(msk)) {
-			spin_lock_bh(&pm->lock);
-			pm->subflows++;
-			spin_unlock_bh(&pm->lock);
-			return true;
-		}
-		return false;
-	}
-
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-
-	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
-		 subflows_max, READ_ONCE(pm->accept_subflow));
-
-	/* try to avoid acquiring the lock below */
-	if (!READ_ONCE(pm->accept_subflow))
+	if (!mptcp_pm_accept_new_subflow(msk, true))
 		return false;
 
 	spin_lock_bh(&pm->lock);
-	if (READ_ONCE(pm->accept_subflow)) {
-		ret = pm->subflows < subflows_max;
-		if (ret && ++pm->subflows == subflows_max)
-			WRITE_ONCE(pm->accept_subflow, false);
-	}
+	ret = mptcp_pm_accept_new_subflow(msk, false);
+	if (ret)
+		pm->subflows++;
 	spin_unlock_bh(&pm->lock);
 
 	return ret;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index ee3915d33e04..5cc35ee122ff 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1403,11 +1403,21 @@ static bool mptcp_pm_kernel_accept_new_subflow(struct mptcp_sock *msk,
 					       bool allow)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	unsigned int subflows_max;
 	bool ret = false;
 
+	subflows_max = mptcp_pm_get_subflows_max(msk);
+
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
+		 subflows_max, READ_ONCE(pm->accept_subflow));
+
 	if (READ_ONCE(pm->accept_subflow)) {
 		if (allow)
 			return true;
+
+		ret = pm->subflows < subflows_max;
+		if (ret && pm->subflows == subflows_max - 1)
+			WRITE_ONCE(pm->accept_subflow, false);
 	}
 
 	return ret;
-- 
2.43.0

