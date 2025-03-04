Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A71FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088458; cv=none; b=sPIMFLZZEySttPDL7ej8N8dQAI8vXVAAmefOLATB/ebOjwOfusWRaU8Mpv41lrUMLB1vUJMsmSKTgSol64V08vIv7oUw1PqFeOi2EDE3oTvkcWFZ9YneqAOqGLE2kHvtKOMLs/DsfUQg8LcMro3VEsg85B6palI6fmn5twqen1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088458; c=relaxed/simple;
	bh=cYBFZJj6SIuhneFq7DOaEhyk+/fllYGptmTWK49koYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKDZ9EoURPgJZUDzeTI1fVxY+Ddq/vOI4d0naZ0O3Y+FSKPAdILnoPlsxuiFDz65G0hjR3Vf48g5YN15VgjgcxUdtHVHjijie/VNeIQ6uIx71Sy30auMbN+94ZWeWG0VRntkQFWK7ZibyhvqfW/Awx0auv5nAWZiwdiKIYYg4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0p+cqxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0p+cqxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC43C4CEE9;
	Tue,  4 Mar 2025 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088458;
	bh=cYBFZJj6SIuhneFq7DOaEhyk+/fllYGptmTWK49koYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0p+cqxO2L5LMxPOIAqH5BqdXP4umVzwBgyUYaZXX3CKiSCUsVfVdKpRCz8CiPtVF
	 1Ho8vVDwBPFyyRBV9FFneAR2CHl/GTVnLAg+r9dTE28zg9WeaqvOmhZEgDBe0d1QER
	 ZJZBSE3O4r22TWDmqqcVqjav3r0WsbAOr3zPmasyMgmFIsItA3J/yy39ql8g+pjpPC
	 762QxAFQV6TDk2o6auWN3QC2gsmE/7e+0pKiU2UJELIvARhT78O+FMLUeU1HACe3gF
	 OD+BNMmT63wNaSA1wVIcPqkoQhTgyC1NG2A67iS6RQO2Cz2TfxdkxU8un1QOnWoonG
	 0uKm4zTdeyZZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 07/12] mptcp: pm: userspace: register mptcp_pm_userspace
Date: Tue,  4 Mar 2025 19:40:34 +0800
Message-ID: <c208e73f646fcec90f41915362cda0306ba6ffe7.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original userspace path manager as a new
struct mptcp_pm_ops named "mptcp_userspace_pm", and register it
in mptcp_pm_init(). mptcp_userspace_pm_is_release() is a wrapper
of mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  1 +
 net/mptcp/pm_userspace.c | 26 ++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 28ea8bdaa8b0..5018ed3c575f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1028,6 +1028,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_kernel_register();
+	mptcp_pm_userspace_register();
 	mptcp_pm_nl_init();
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 13856df22673..412d6c912148 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -682,3 +682,29 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static void mptcp_userspace_pm_init(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	WRITE_ONCE(pm->work_pending, 0);
+	WRITE_ONCE(pm->accept_addr, 0);
+	WRITE_ONCE(pm->accept_subflow, 0);
+}
+
+static void mptcp_userspace_pm_release(struct mptcp_sock *msk)
+{
+	mptcp_userspace_pm_free_local_addr_list(msk);
+}
+
+static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.init			= mptcp_userspace_pm_init,
+	.release		= mptcp_userspace_pm_release,
+	.name			= "userspace",
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_pm_userspace_register(void)
+{
+	mptcp_pm_register(&mptcp_pm_userspace);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f700cb55bf49..658bc60d4cd8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1162,6 +1162,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_kernel_register(void);
+void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-- 
2.43.0

