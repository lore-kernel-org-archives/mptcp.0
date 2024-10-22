Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023117BED2
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588506; cv=none; b=SwoukXby25ZXNLxoZvHtf26y6lZbWpAcxgk2ZZS3ojtK7gQd3FJ8hCYHIB322mChdtPBqbCUkxuB+PtapRsXpfDpOm/B188m5PGTw64BRAa0uHZEthkaqrxIpIF0Fr/HsMKQC8btSV4ZhZ0A8noVDfWIEI4HECJPHbvk85ic4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588506; c=relaxed/simple;
	bh=Myc4j4LK0suzkdy2qgWdirWF8DTCsxCv9r6VkkjZme8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd6eqMebDcS5/l4igByE1ui4uNgm08pNUt3ApQSM6XyryT0cn3knf3zMXUMvAUrHFtyPikGUka3iNfwWc5VgIHKjNs2ouiPfaSgSL/v3z0JLeelrCNbC8ECxwzSap9nCZZ8YU1OGYs4Fl9hSev39rvqngSHR2qfjildPhPkE6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2LPcX7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2LPcX7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C22C4CEC3;
	Tue, 22 Oct 2024 09:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588505;
	bh=Myc4j4LK0suzkdy2qgWdirWF8DTCsxCv9r6VkkjZme8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2LPcX7H9ky+nbnV6uHzM/WK11QibrTWwil/7NJupVbd4pCUDGAj/9N5kEycjwsxa
	 AyGZmJiKLRQMjjfN4mrf490+Ck1xd4N5nIsm9DDTC1vR4vr6if7WOwUFFZAA9ZhZHf
	 WPmPujXunVchkrlbDOecoAuElOMrgysJrykVqbOQIlJ41Rm729f8ZrdevQipyx9fiS
	 yutN3WcTZq66O4YfXuiIaTGQTlx5l2kE9IjA9igEVYkY7u+WpIj4yxDS04fWKbcTjo
	 kL0gLxI6BC73EKvK1lA0n76CZys44FUXosJbuNmz2DOW8+UVXeQySADtvhNMGv2ag+
	 tJQdSMaZ2DYyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 08/36] mptcp: drop skb parameter of get_addr
Date: Tue, 22 Oct 2024 17:14:16 +0800
Message-ID: <cb541d5091d585954d3172145ce7b454c5d9d0e6.1729588019.git.tanggeliang@kylinos.cn>
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

The first parameters "skb" of all three get_addr() interfaces are now
useless since mptcp_userspace_pm_get_sock() helper is used. This patch
drops these useless parameters of them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  3 +--
 net/mptcp/protocol.h     |  3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8b4815d0df53..90279732d226 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,7 +1792,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1842,16 +1842,16 @@ static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+		return mptcp_userspace_pm_get_addr(info);
+	return mptcp_pm_nl_get_addr(info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(skb, info);
+	return mptcp_pm_get_addr(info);
 }
 
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 79ae32c921b7..e61cc1805cee 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -632,8 +632,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b6e66bfca2e5..b991c65b0a72 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1128,8 +1128,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

