Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248D111A1
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NZJLf7ig"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ngi46ZjU+8e1bL6bIkm2qigwKMygN+U59Gu9a3yP2qE=;
	b=NZJLf7igtUY8Z84RzR4So44hU8io10Wac63KvRAy7zEIcdq+dk+NrHgdRPQFbX0jEXMZT7
	aMhFwiKFADrxLU1gkcYVog4QZCU6NW927xeVkQHhD35Ahepk6U+warOTuz6/BSpUqVBr1I
	IQ7TfcXrkhm4XhbvdI0pvumreumuVXY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 10/24] mptcp: dump addrs in userspace pm list
Date: Fri, 29 Dec 2023 20:47:28 +0800
Message-Id: <1311ba3fb592c04b6da0ce553acae5f7450e0842.1703853513.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703853512.git.geliang.tang@linux.dev>
References: <cover.1703853512.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch renames mptcp_pm_nl_get_addr_dumpit() as a dedicated in-kernel
netlink PM dump addrs function mptcp_pm_nl_dump_addr(), and invoke a newly
added wrapper mptcp_pm_dump_addr() in mptcp_pm_nl_get_addr_dumpit().

Invoke in-kernel PM dump addrs function mptcp_pm_nl_dump_addr() or
userspace PM dump addrs function mptcp_userspace_pm_dump_addr() based on
whether the token parameter is passed in or not in the wrapper.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm.c         | 10 ++++++++++
 net/mptcp/pm_netlink.c | 10 ++++++++--
 net/mptcp/protocol.h   |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..a251487d3315 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,16 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
 int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
 		       struct mptcp_pm_addr_entry *loc,
 		       struct mptcp_pm_addr_entry *rem, u8 bkup)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b777561eeaa0..0a9826be3593 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1717,8 +1717,8 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1760,6 +1760,12 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
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
index 7c0d592a9a45..d52124490f8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1029,6 +1029,9 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
 
-- 
2.39.2

