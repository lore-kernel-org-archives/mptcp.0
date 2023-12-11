Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086A20B30
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d1D09yd6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrPploiPxOVaghVbgemLXjDd4h7BqxC92EWy9NB6oqg=;
	b=d1D09yd615HMh4I8FqXJIgCXazjYP9Ze+s19g32XKiOd9Rfi7kOs9vKABUfspVDP4hhhMD
	N0Ruu+cwYmvWimGGMs2WgftjYG3BrHtFHKOqK+tzHxaMvAhkZ0aWtzVr+1BcC+wk+ijZZH
	joXtOF4w70RFh6x1bigD4OjNe+JSqx8=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 08/12] mptcp: add mptcp_pm_nl_put_entry_info helper
Date: Mon, 11 Dec 2023 16:15:30 +0800
Message-Id: <e291fa628b93d5762552acb0933288f7c7db1ebc.1702282411.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702282411.git.geliang.tang@linux.dev>
References: <cover.1702282411.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch extracts the nlmsg related code from mptcp_pm_nl_get_addr_doit()
into a new helper mptcp_pm_nl_put_entry_info(). It will be used in the
userspace PM get_addr().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 55 ++++++++++++++++++++++++------------------
 net/mptcp/protocol.h   |  2 ++
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6756b9ee7afc..0c1ea3c42584 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1656,6 +1656,37 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+int mptcp_pm_nl_put_entry_info(struct genl_info *info,
+			       struct mptcp_pm_addr_entry *entry)
+{
+	struct sk_buff *msg;
+	void *reply;
+	int ret;
+
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
+	ret = mptcp_nl_fill_addr(msg, entry);
+	if (ret)
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	return ret;
+fail:
+	nlmsg_free(msg);
+	return ret;
+}
+
 int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
 			      struct netlink_callback *cb,
 			      struct mptcp_pm_addr_entry *entry)
@@ -1684,26 +1715,12 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
-	struct sk_buff *msg;
-	void *reply;
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
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
-
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
@@ -1712,20 +1729,12 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock_fail;
 	}
 
-	ret = mptcp_nl_fill_addr(msg, entry);
-	if (ret)
-		goto unlock_fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
+	ret = mptcp_pm_nl_put_entry_info(info, entry);
 	spin_unlock_bh(&pernet->lock);
 	return ret;
 
 unlock_fail:
 	spin_unlock_bh(&pernet->lock);
-
-fail:
-	nlmsg_free(msg);
 	return ret;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a05a6745bc31..a82a42c57c3d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1025,6 +1025,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
 			      struct netlink_callback *cb,
 			      struct mptcp_pm_addr_entry *entry);
+int mptcp_pm_nl_put_entry_info(struct genl_info *info,
+			       struct mptcp_pm_addr_entry *entry);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.35.3

