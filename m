Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048B3398E
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730268658; cv=none; b=lNodndGPgR7psC1GT3vrw6zf+m2CezJK0Im3YxFhCelTogH0abuJsms1c2ruums74DAm5RbEDvP6soWJqloDKXnL4Wo05ShQd/cp8tpoGp+5OHSvKFdAeVwCvjAat5cVEinrc4nBk1wQxLWT3YwlwW9Jd3R7MldkBoKfO9r5NQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730268658; c=relaxed/simple;
	bh=bgcJI9o+HDpsRmCDdCwRU187zlp71oMZqvGjnM7fDJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=es6LSh4F0eDr0gpGmIDr8x3vxWdSBPx6rmxG6uXjp0JNI6x2cxUwz85lcdcis7aPTKbq9OCQtG76F01ulo1sJBSgQS3iLfMw0Bk0Eh5XYhquM9MTccayx7gJzxvZaf+CnUwhjvpeQFeXUYGHt2mGrU/upeAPSUoJIxlrDNUEpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT4TFGgu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT4TFGgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD7C4CEE6;
	Wed, 30 Oct 2024 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730268658;
	bh=bgcJI9o+HDpsRmCDdCwRU187zlp71oMZqvGjnM7fDJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XT4TFGguSlB8XCAqRnEuWGeUYFHELAAk6tk70KpR6z/3tsCeWbRtTUiGkFZyLdTd/
	 dUhtB8jpjFWkYQFiGLUAa6p4s6KHOVwXb9LAhBAi4/gvjPg86mBXPIr/IQdgH/Mvjy
	 PY7uuFx18gOQAInY9hzas5cIRWLcK7Q6lKggj4lEduBzaHqwHhRckqszD7IC3REeOy
	 cBxlvcu0Zbau8FxJWxc+gzqX2vFuXvBDbZRoGFBwWDC7zZYckhluz9rg5u6rlIY/m5
	 fgA8OIhBtfds1eJ18z8iJb0HjZz4Ti1yiBF3o+6P2EzypSaiTSCBLqkozWRtlF0vZ/
	 iqo2p5sXbMuwg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 03/13] mptcp: add mptcp_validate_scheduler helper
Date: Wed, 30 Oct 2024 14:10:27 +0800
Message-ID: <c97c5bfc8d44d87f30f43d3215d5cf306aecc052.1730268415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730268415.git.tanggeliang@kylinos.cn>
References: <cover.1730268415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

New interface .validate is added in struct bpf_struct_ops recently, this
patch implements it as a new helper mptcp_validate_scheduler() for struct
mptcp_sched_ops.

In this helper, check whether the required ops "get_subflow" of struct
mptcp_sched_ops has been implemented.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ab4e88b40efc..46bc7adb4763 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -744,6 +744,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_sched_init(void);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 73a24b9c96ff..d7be9c453488 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -71,10 +71,23 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 	rcu_read_unlock();
 }
 
-int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->get_subflow) {
+		pr_err("%s does not implement required ops\n", sched->name);
 		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	int ret;
+
+	ret = mptcp_validate_scheduler(sched);
+	if (ret)
+		return ret;
 
 	spin_lock(&mptcp_sched_list_lock);
 	if (mptcp_sched_find(sched->name)) {
-- 
2.45.2

