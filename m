Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80378120D
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588510; cv=none; b=mHQnmbzxlAsXXEVTfpkuYM7IahmaBodnFi+YrTNqY/w25u7VVMEVjs8AQo3P9pOInmhc4nX2wG9NOSGMoJvzmcROe9BAR8MFbRi3Ml1gTwj82Wbc1WTwXBxCGbH/0UEHo4gExm77qgWuHmtAU/dlYtfwyKoE0NOcN21+gHSslMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588510; c=relaxed/simple;
	bh=XA7XTpP4DUa1JILPi93Ir+UYwX6oNN+qtg0KGBByFvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLQkXd+LYB7elC1p9UB+bMR2x5mnvGgMlJuJLx91wF+3WdYl1VKNeeNU5s/LiK3WRyFpOqQ4O5lOQ+RZBrnVbUpIzokWaZnrOZJDmYS31eHjzzG1IvGL4TmbQzgDuiibuTiZxEexRj5WaR8LaRbhsxUItS/kKMG0lWfArk0Aj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gab6f6cF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gab6f6cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA67FC4CEC3;
	Tue, 22 Oct 2024 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588510;
	bh=XA7XTpP4DUa1JILPi93Ir+UYwX6oNN+qtg0KGBByFvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gab6f6cFCQVUa3eu2PKwbAq0Dyc3DlklojHg7jyRBX8ewVdWvD9v4BHc3IBHoWrXU
	 kSRIKAskaWJI8znGmx9wtEQqgLXmHDQzzSWk905Hyoth0LnQ7gQ7Q4SPGwiZarK/Qa
	 RxzQNZieEAIGGQVRcnZYFVCvQYzwYpmnsQl6zhE9T+ZpB8p8kOSIm/CRJtQLIczfR6
	 GSdgU+Jp1RU16brwv/lTZ67QgpmT+JjvqFT4t75YDCHHMyu/dfSuXniKEpUsKhG7+N
	 C/WTBSXkRckjGGcu/+9hfQ7eSs/joybVemCwmKcXNm8w8ylJwfNmXkwpb0vNnO8l+B
	 z7fJBGS0dk/wQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 11/36] mptcp: reuse sending nlmsg code in get_addr
Date: Tue, 22 Oct 2024 17:14:19 +0800
Message-ID: <263fa87d40698cdd242666c7290ca76ecdf6ce2d.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
index bfd8bc3dfb86..064fe4d494eb 100644
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
2.45.2

