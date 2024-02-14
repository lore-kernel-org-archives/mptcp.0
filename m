Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7E199B9
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910856; cv=none; b=vFDr5QvvGMsLCHyUy0LVCASFdvCxqz3SXCfGg3vi1lsf9RATmwK8WQxKJsXh05vC+zYE5idpWhI569GVi+Gp31l88QjiGAQLeZeuMjZIlUiiJ8SKShSDfY4Oc4tXGo3z1veuUR1u4MB162QBsiDVbJjZThEgNWjRuKcHD7RJawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910856; c=relaxed/simple;
	bh=LHf+YgswIMLzbn0gjyexwJoCVmjLqy7HoSQZHKmmHkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzI11AEExO1WvL/ZBfSq7woMi5i4WPIpY5jIRPBIqqIwltj3WxSsIHGsYBSyq5cBHTQ+mZEwnEZgO9aNjC7E8cjjjyyWTjalaEcd9UyDvWjHVlujMn2so1uYRbdbPnMHsy6AJA3P+jvaEz7/D3qjmhV213d1BXXS1YT6wyOC7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkKCMpoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkKCMpoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8C1C433B1;
	Wed, 14 Feb 2024 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910856;
	bh=LHf+YgswIMLzbn0gjyexwJoCVmjLqy7HoSQZHKmmHkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkKCMpoN8nnPNItW5TxD2VOvfBErGTmJnKha3USthjHT+0WrcBN2YQq0WdQSaJL9M
	 mgWaWs5DKglCRPSOiKp7yiBmrQMWjf1srCbmK9oRBB4UwgS8FSIamiFTjMBZgiYQAo
	 i8JMxlldGvlW6BvF/hYELthkzT2Vk+J0xGXM9pBftzXAyfnpPW1ccS/C0kHuNVVu6E
	 9qbQt4bXEV8zLqMjArcbtkaBM2VihyUAPm6AGa4cRt77poLuQJD4yuDL9QbKlFPHPd
	 DlkW5kg95vPb3hzKv5nTwRGqTavw5I/Jg9m1sL8whAaqJNAljh08+op4OLEY6BJ1JG
	 CJWhgmp9SBCFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 04/15] mptcp: dump addrs in userspace pm list
Date: Wed, 14 Feb 2024 19:39:55 +0800
Message-Id: <264a3315dba8287a77eb3ec6b3ea21b2ffa2228f.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch renames mptcp_pm_nl_get_addr_dumpit() as a dedicated in-kernel
netlink PM dump addrs function mptcp_pm_nl_dump_addr(), and invoke a newly
added wrapper mptcp_pm_dump_addr() in mptcp_pm_nl_get_addr_dumpit().

Invoke in-kernel PM dump addrs function mptcp_pm_nl_dump_addr() or
userspace PM dump addrs function mptcp_userspace_pm_dump_addr() based on
whether the token parameter is passed in or not in the wrapper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         |  9 +++++++++
 net/mptcp/pm_netlink.c | 10 ++++++++--
 net/mptcp/protocol.h   |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 53e0b08b1123..193198cec74a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,15 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
 int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
 		       struct mptcp_pm_addr_entry *loc,
 		       struct mptcp_pm_addr_entry *rem, u8 bkup)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5cca84c6b87b..7b15bb4f12c1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1722,8 +1722,8 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1765,6 +1765,12 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index af20833f3157..657d23a9678c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1032,6 +1032,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 
-- 
2.40.1

