Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D616205E0E
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069985; cv=none; b=XJZWTZi3SKFDXbwoL64zYtPPvRNY6wDvxkjj9BzJ5z1EhL8qGbYwBpDunylWmwqkzfEzjvNo2yzhRREESnqeT0Se82H/IkzqgVSTEQGjmT0bwhw29tYY2Ji2d1xknMhd0OABeab5ML5qlOt91zmreRUGtWpTKQlSBERbXyfIAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069985; c=relaxed/simple;
	bh=g4KgSz4gEF1/26hFv8JtHtal+mo1D1dY6Goi+gEOCwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiHo5PeGIKZ4MY0ZhZCkKD4g+WX9MXPHHYF9FldBIKRamHpm8WzYM8gtu+mqE+tYWIHhC+2jpf+knEfUSlq2q5IHHTIzyD9IC0amA/IetKMstPDe291d+O/hHVZ4qvMkSJ1op6WonTyNag4PSdpwVIUq1AP4LXFnbyJ7JnX2e0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iasHek68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iasHek68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76104C4CED6;
	Wed, 16 Oct 2024 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069984;
	bh=g4KgSz4gEF1/26hFv8JtHtal+mo1D1dY6Goi+gEOCwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iasHek68BpLdK/FkRYxwTUPfcVfh4SDpmI8TW/Gk/CUbSHh3xV2EKRTDXw67uZf67
	 ZkIhOudiSyF7TEaQjxpbCvuOpekScxXNp1i7b39EdtSIprBJb5AhNvQeXRy0NdtqpT
	 eeI4yPbSP2MPp+YLED2TvV/PxDaiQSrYC/PQNWNYTmcb5CakbU678uN3iQdmXgqyBZ
	 JNGGXgxXaXMXJ2XJkbZ43rZqeWIOSPl3lIxovAYVOqESVWJi+SOvWuvAmpaAro8swc
	 lny6BVUmQ0ZjFAoLR0EU7xuZ+d/bVsglACQXwkJLLwTlzoJpMh8FdlK4/0PPkqRsBj
	 FvDt1eVAMXQ0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 11/33] mptcp: reuse sending nlmsg code in get_addr
Date: Wed, 16 Oct 2024 17:12:15 +0800
Message-ID: <02bd1fffd31d586945abbb16f59a0254ee1cb699.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With the previous commit, we can reuse the send_nlmsg() code in
get_addr() interfaces between the netlink PM and userspace PM.
They only need to implement their own get_addr() interfaces to
hold the different locks, get the entry from the different lists,
then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 58 ++++++++++++++++++++--------------------
 net/mptcp/pm_userspace.c | 33 -----------------------
 2 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5d9e72fbddf3..173d36f91274 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1797,21 +1797,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
-	void *reply;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
@@ -1821,21 +1807,6 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	}
 	spin_unlock_bh(&pernet->lock);
 
-	if (ret) {
-		GENL_SET_ERR_MSG(info, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
 	return ret;
 }
 
@@ -1851,13 +1822,42 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr;
+	struct sk_buff *msg;
+	void *reply;
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
 	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		GENL_SET_ERR_MSG(info, "address not found");
+		goto fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, &addr);
+	if (ret)
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	return ret;
+
+fail:
+	nlmsg_free(msg);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d1f2b592b47c..dd2ecc9ee6d5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -637,10 +637,8 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *reply;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -648,20 +646,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 
 	sk = (struct sock *)msk;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
-
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
@@ -672,23 +656,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
 
-	if (ret) {
-		GENL_SET_ERR_MSG(info, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	sock_put(sk);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
-out:
 	sock_put(sk);
 	return ret;
 }
-- 
2.43.0

