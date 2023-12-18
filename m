Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038C11720
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U5C6AcaA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702891516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGwYV0voJIRUqJBzl5iZjI7koy5k2JcEawmoV2Jif+0=;
	b=U5C6AcaATsOmzUYAQ9INx3LIOAfw93NiwJihTep6qt42xeTn246BPzoWJkZsbv6fwtzuiy
	6n6DSIYzgF9giry43dP9LCgWOJpXiZ/l45I/Fj7mWl8M/yHcGOFCBLMZyrHHHg9GU8hHah
	mHt10BIBOqlmo18khlGY2wm2EPfAhiw=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 03/15] mptcp: dump addrs in userspace pm list
Date: Mon, 18 Dec 2023 17:23:32 +0800
Message-Id: <313245a67713d1b70a0e52544a195af2f91f0825.1702891194.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702891194.git.geliang.tang@linux.dev>
References: <cover.1702891194.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch renames mptcp_pm_nl_get_addr_dumpit() to in-kernel netlink PM
dump addrs function mptcp_pm_nl_dump_addr(), then invoke both in-kernel PM
mptcp_pm_nl_dump_addr() and userspace PM mptcp_userspace_pm_dump_addr()
dump addrs functions in mptcp_pm_nl_get_addr_dumpit().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 43062cd23ba3..ced8cab36b41 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1731,8 +1731,8 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
+static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1764,6 +1764,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_nl_dump_addr(msg, cb) +
+	       mptcp_userspace_pm_dump_addr(msg, cb);
+}
+
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
-- 
2.35.3

