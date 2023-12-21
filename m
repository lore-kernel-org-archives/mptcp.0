Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC146208B6
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bUUyIS11"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703149483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/m652AEYduCVw3OY2MtMoll03Cd/DFXaMbc8I81UhU=;
	b=bUUyIS11o8PqLOip/hd1pf/UfLLls3fNCxgy+hpsuVt51Iv19WYHOui3hIRI/vlndQxp2/
	EdwEmeC0pDrzKchzDDlZ0zlzRB5hrmgA8OGmf0wqQuzoKXKUIOf6Fp5M/dcjpSW6tCnrjG
	NooRJU7NaoCnaDaXhty8pOGS6A380j4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 04/14] mptcp: dump addrs in userspace pm list
Date: Thu, 21 Dec 2023 17:03:18 +0800
Message-Id: <fdb1a17b9823adc94e5a32422718d2d0ddf04a27.1703149203.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703149203.git.geliang.tang@linux.dev>
References: <cover.1703149203.git.geliang.tang@linux.dev>
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
index ac65266727a2..928ff1ab8b23 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1705,8 +1705,8 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
+int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+			  struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1748,6 +1748,12 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
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
2.35.3

