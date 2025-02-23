Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9918EA2
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320835; cv=none; b=iEhjrvkqKtiHrnfVnoYDPE7+GQlwNgZMKp1qJV34U9tOa5gg8DtH692cVIeoRBjFbte2nEzza7TYFfXhLVqe1UNY6V7OuND6E3HN/V4tRwElE7o8VcLvYkoa1uK4f084c2UC6faNzfcK5970Sha5hxVM70es7cwB2TXjtODEORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320835; c=relaxed/simple;
	bh=GhCzxxxeMESAA5d73n7nTzV9B9qXIWu37yyaj73oZHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no8EVAgcpfBtiUJOtm2Zysm5zGiTaoMQSw8xBtbziS611rSaDXzu8nTqNPlogTO7M63cAlFI7pXz6DP+Tr+U3smWL9h/0IxVJdbjTpbHCcMsVEmIgSKvgXL43YUW33c3PDNPaQr0Sz56hqAMnVvSiwyk9aFNuDsUH8nsBxiYyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KueuZsuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KueuZsuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED15FC4CEE8;
	Sun, 23 Feb 2025 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320834;
	bh=GhCzxxxeMESAA5d73n7nTzV9B9qXIWu37yyaj73oZHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KueuZsuc/qpUdHgBuXJlFWynG8deSf+KzOUog2TF3o/DYaLzu9e4wFWvf3jCwS8SD
	 /eyN+3EjAo1GfogajVgV/3WuzNMrfyVdeLJZmuDKdT2SNJvDPntrkDmHqeFBFInKR7
	 ZuKN98Uef8YfHaBKgjlPmlYHp+E+yxcFiYJBK9bDdVPfZ0knbHYc+KvTlzu9j9OsGI
	 JdgECKdVGr0GOUXBmebzknmDdycyzZNW0SXQysLLEvnKZWK9X6gniQpmHGy31Kb1VB
	 qjNubea7fhe/wMykdr5yWvg0yTkGbwO7pm7XsXS7cS54A5whdPGa8PIr2gdJvj7ZxG
	 HjaPWbi4r3faA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 08/13] mptcp: pm: drop pm_type in mptcp_pm_data
Date: Sun, 23 Feb 2025 22:26:13 +0800
Message-ID: <9bd55b3cfc33211b89d8ad0dc734ff2ed4287ab9.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now pm->pm_type can be replaced by pm->ops->type, then "pm_type" filed
of struct mptcp_pm_data can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 6 ++----
 net/mptcp/protocol.h | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 147d9289e477..9f9e9cf18847 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -604,7 +604,6 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	const char *path_manager = mptcp_get_path_manager(sock_net((struct sock *)msk));
-	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 	int ret;
 
@@ -614,7 +613,6 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->subflows = 0;
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
-	WRITE_ONCE(pm->pm_type, pm_type);
 
 	rcu_read_lock();
 	ret = mptcp_pm_initialize(msk, mptcp_pm_find(path_manager));
@@ -622,11 +620,11 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	if (ret)
 		return;
 
-	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
+	if (pm->ops->type == MPTCP_PM_TYPE_KERNEL) {
 		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
 
 		/* pm->work_pending must be only be set to 'true' when
-		 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
+		 * pm->ops->type is set to MPTCP_PM_TYPE_KERNEL
 		 */
 		WRITE_ONCE(pm->work_pending,
 			   (!!mptcp_pm_get_local_addr_max(msk) &&
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1fea29f52c35..a5b0fbb3a272 100644
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
@@ -1099,12 +1098,12 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 
 static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
+	return msk->pm.ops->type == MPTCP_PM_TYPE_USERSPACE;
 }
 
 static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL;
+	return msk->pm.ops->type == MPTCP_PM_TYPE_KERNEL;
 }
 
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
-- 
2.43.0

