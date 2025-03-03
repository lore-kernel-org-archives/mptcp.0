Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E013C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975934; cv=none; b=kM0rWst/8/XunPW+8Yr33cpYcTMzcM6d8VTY3wShqGES2m4aE/4PusKXXYDwRMzDXDUTOuVX39kiEnM1O5LMH36wdrLFDgtFDfjg3LLGt7nzCsahyyfNgpu7k++KnBxCn8r05+HnwFsiz2Wt3e8dI7nDFvMU9I26Q1UDNrlB5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975934; c=relaxed/simple;
	bh=ad+WiPmb19YEiCLPz8bVQzer6IKn62XuM6seOWgZep4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah281z8oSW/4CXP/Xe8z1v0Yi0i+ajUdvvc5sApHcmFMmi17EkTbkhy5DIDvYznkJV6Nt+C9/ONLFeq7P8L16GdF7TncQoOMuVAqq5jp8YXOS3BDm5SOtf9WMqDrC/4Kqdei6+YnKXpdZYZ85RI2gYJEEdgC6jaUJvtICBw2oRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjp6OVgr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjp6OVgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067E8C4CEE4;
	Mon,  3 Mar 2025 04:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975934;
	bh=ad+WiPmb19YEiCLPz8bVQzer6IKn62XuM6seOWgZep4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qjp6OVgrfQVyZbUVl0nP8zNknyy1NVdU+SUOBxVMrrJcTjcemDb4zF9gjEn2gz/2U
	 yTsuuagyeHfrAtDnL885jZzKepZ3THUYDVIMhEYN1N9cRwpwV7RMyynpgyGI8UQpFi
	 C+U0khbjbVxevT0zqOg96qwtx8thewkwX0YZaBR56Bn/Yxqw8wa9ASzyxmBlWquP4X
	 scOv8Kpl1Sat3/jIxE6tRM5W9sHMWQCjalp8stQ0qKaOvwji0NCEPO6UBzJEWFLSSv
	 qXsdyFPByJ+nsuEbbm01m3wzFHcLT5FlTo0vnMc1vT5WVnNr+rJhzA7O3wVeRfx3wj
	 6cKkZL4tcOLEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 08/11] mptcp: pm: drop pm_type in mptcp_pm_data
Date: Mon,  3 Mar 2025 12:22:56 +0800
Message-ID: <599fa718f11e3311f95deaaeac0534889698c66d.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now pm->pm_type can be replaced by pm->ops->name, then "pm_type" filed
of struct mptcp_pm_data can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 4 +---
 net/mptcp/protocol.h | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e8b34f2ecb35..1ce58d16370a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -979,7 +979,6 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	const char *path_manager = mptcp_get_path_manager(sock_net((struct sock *)msk));
-	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 	int ret;
 
@@ -989,7 +988,6 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->subflows = 0;
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
-	WRITE_ONCE(pm->pm_type, pm_type);
 
 	rcu_read_lock();
 	ret = mptcp_pm_initialize(msk, mptcp_pm_find(path_manager));
@@ -997,7 +995,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	if (ret)
 		return;
 
-	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
+	if (mptcp_pm_is_kernel(msk)) {
 		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
 
 		/* pm->work_pending must be only be set to 'true' when
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 172450455c2a..56eeee1cbccc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -233,7 +233,6 @@ struct mptcp_pm_data {
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
-	u8		pm_type;
 	u8		subflows;
 	u8		status;
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
@@ -1101,12 +1100,12 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 
 static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
+	return !strncmp(msk->pm.ops->name, "userspace", MPTCP_PM_NAME_MAX);
 }
 
 static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
+	return !strncmp(msk->pm.ops->name, "kernel", MPTCP_PM_NAME_MAX);
 }
 
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
-- 
2.43.0

