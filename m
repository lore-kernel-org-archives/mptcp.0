Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD618BC03
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381511; cv=none; b=ZzmMSA/k5VWbfKp2TQtKyzkUSalBlptzTsJmRBOZ1I3c6edtwR8bLIZLnAqmLiLU3HVfo1nIYy0SQC0UmJXtzwAh763uyGWZYkz5g9cjiGus8sZzAWRoDD2/j3oWXyqrTaqvRnE7U2rl249497FEtqe+wWUhH0RgYT/Ht79Yycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381511; c=relaxed/simple;
	bh=PEzu/kqofVUIy99dAntCz+2sCUICoK+/v6lcaAG7pi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul2vbwz9mIp3kiG2abQ5S8jpyiyHwZz5QaLtp0X4PZ3hrPM8hZi0UYXODKk5bvu/vIVHourbvQAC1jDLdw4HfjrMcTn7sFGoajikJfIs4akvmBJB/EMD+m8mN3Xp6TFnRO8HAPCGK2MPgI6ZVBAbAHQ6bqdPRSx9QP2jkTt+OkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQsVADld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQsVADld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B610CC4CEC7;
	Tue,  8 Oct 2024 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381510;
	bh=PEzu/kqofVUIy99dAntCz+2sCUICoK+/v6lcaAG7pi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQsVADldtN5ulYeqOAzixAb0JqvyZBSIiDXdHSY3HQlH5ZR9QhZqk78j+CufNXzrI
	 wZyVSf/MBQIcwlzA2h/ttpCjhoZj51vGB5lUeKjUMiY1GHvvp9MMcSCf0ytLhmJK+S
	 /k+tejep3MMgKUGeqIsbH2Vveyfr6d6xHST80pEJZ0vFQvtNXU2i8JoCE5Dk8pja6K
	 d1oZNPItGRbAwK+dC2BHvVaw3b5XkOyg2vQ/S+L0MCeVI2YWMEYwQzOczVoVKZeHG0
	 kcGzXOwzNC6aCGPp2j/2ir8nst45ndlflmdWR7ImJ6/QdfcnPRzrIRkdXCdP/HZBbT
	 6QlCnbGZEe+6Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 03/13] mptcp: reuse sending nlmsg code in get_addr
Date: Tue,  8 Oct 2024 17:58:07 +0800
Message-ID: <fece988fea383050b3047ba5387ca96d245d9a93.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
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
index 886fb7c1468d..8bc38a4cd278 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1796,21 +1796,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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
@@ -1820,21 +1806,6 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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
 
@@ -1850,13 +1821,42 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
index 5c9f740bd9ac..4c4693c5aae9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -634,10 +634,8 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *reply;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -645,20 +643,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 
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
@@ -669,23 +653,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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

