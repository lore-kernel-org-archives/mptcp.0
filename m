Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF01D90B6
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020274; cv=none; b=PSf/Op2DrP1hrVixjtznzv8nzVtwFdNO7f9R+0TJT/X5IadJ92pkwUFZc/vp+mUwIH+oy9zmwou9Le0HS51czYvxorqlO78H61yvMPiAcgWyJ26fPtHD9ZlQ77SjhG8Cts7j2ycp3klFh+/IpJ1IU5O/M1SGqIQ+rpcRqdp8eZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020274; c=relaxed/simple;
	bh=/C5nQ+j9mfPU+MQmgap/V3MqkJfJcpkrTD+IxlsNIKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEA6dOBeBmBd95sxwA3nFcsQMNXo45GGKYW+n95X9cjLB9GYqRlBDvjHP+NEnFC2AQKeVmY7LEPYHY1xiuERow32ecMM2YBmH5asXxqUg6muGR/vZibompA841MixiKlqV51VVbahRyKH7ppFnNeNb1g6tZDbhsv8ADH9sEx+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu2eufnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu2eufnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E46C4CED6;
	Thu, 20 Feb 2025 02:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020274;
	bh=/C5nQ+j9mfPU+MQmgap/V3MqkJfJcpkrTD+IxlsNIKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hu2eufnxA68r1TgqIgqunvXI1r4bAZd9A4IjWxAPu3Fk48NAzrbnMo0DAdJtSg/8Z
	 X+PW84HmHdzcDMWFv5V9EM94zuLaKrZk0sgVCDg2qFxrybwvneB34UGZl7/MNOBMrH
	 bKR5cVMtof7QuMFLy+OH9lAUr2OpbAF8nKQ5YdO+4sMLfPxogRpQjgl3zSTbvlsXLe
	 DVmxTMAoB19L5qG66nnlDzHArdnktPjpfDVOhchGhxK/kqjMPM11Gy/D5U6snbyfC7
	 x1JSbJbCy5B3Cfg5aLpRwgbv2oT3DYZhsS9R3wfUqkR9srnHEQzYiHc7dvl430nKCt
	 vCzBYGMXgj+Dw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 9/9] mptcp: pm: drop is_backup helpers
Date: Thu, 20 Feb 2025 10:57:33 +0800
Message-ID: <a3c99f2c228affd88af5ad0ae7584aaaeab5fca9.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now mptcp_pm_nl_is_backup() and mptcp_userspace_pm_is_backup()
helpers can be dropped, and mptcp_pm_is_backup() can directly
invoke get_priority() interface through "ops" of "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 9 +++++----
 net/mptcp/pm_netlink.c   | 8 --------
 net/mptcp/pm_userspace.c | 9 ---------
 net/mptcp/protocol.h     | 2 --
 4 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d2cc93e21bee..ea92e72c383f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -447,13 +447,14 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_addr_info skc_local;
+	struct mptcp_pm_param param;
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_is_backup(msk, &skc_local);
-
-	return mptcp_pm_nl_is_backup(msk, &skc_local);
+	if (!msk->pm.ops || !msk->pm.ops->get_priority)
+		return -ENOTSUPP;
+	mptcp_pm_param_set_contexts(&param, NULL, &skc_local);
+	return msk->pm.ops->get_priority(msk, &param);
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 33b19ff7a313..3859642792db 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1188,14 +1188,6 @@ static bool mptcp_pm_nl_get_priority(struct mptcp_sock *msk,
 	return backup;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
-{
-	struct mptcp_pm_param param;
-
-	mptcp_pm_param_set_contexts(&param, NULL, skc);
-	return mptcp_pm_nl_get_priority(msk, &param);
-}
-
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b233d8469a48..be578f5c3195 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -165,15 +165,6 @@ static bool mptcp_userspace_pm_get_priority(struct mptcp_sock *msk,
 	return backup;
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
-{
-	struct mptcp_pm_param param;
-
-	mptcp_pm_param_set_contexts(&param, NULL, skc);
-	return mptcp_userspace_pm_get_priority(msk, &param);
-}
-
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct mptcp_sock *msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d06add105df5..45c948142839 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1130,8 +1130,6 @@ void mptcp_pm_param_set_contexts(struct mptcp_pm_param *param,
 				 const struct mptcp_addr_info *addr);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-- 
2.43.0

