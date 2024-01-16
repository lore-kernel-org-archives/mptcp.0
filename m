Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF46FD0
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LitGjtXu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705376150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oEkwL/JmqycmOix7nK2ej6BIn6WAbB8ugXNB6fkLmU=;
	b=LitGjtXuUdknQ2hIuYxLgEsBXCidoqzVomJqRoZA0CjTuHZ486IK37zySTb3zGObFjMlta
	48K4usj2LMRnZPn7rk3/j8HCPcZoyaWT8uzHQMWYwiJXTpTqchhXM53/gVpXCN9LARtRda
	94eI611PZzQOi85O045qWzq1dTFydYY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 17/23] mptcp: implement mptcp_userspace_pm_get_addr
Date: Tue, 16 Jan 2024 11:35:05 +0800
Message-Id: <0777547b5a46d95e05b5fdd074aaff5314872af5.1705375746.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1705375746.git.tanggeliang@kylinos.cn>
References: <cover.1705375746.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements mptcp_userspace_pm_get_addr() to get an address
from userspace pm address list according the given 'token' and 'id'.
Use nla_get_u32() to get the u32 value of 'token', then pass it to
mptcp_token_get_sock() to get the msk. Pass 'msk' and 'id' to the helper
mptcp_userspace_pm_lookup_addr_by_id() to get the address entry. Put
this entry to userspace using mptcp_pm_nl_put_entry_info().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 74 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 76 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7e4116abcb11..9f1596aa32be 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -641,3 +641,77 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	sock_put(sk);
 	return ret;
 }
+
+int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
+				struct genl_info *info)
+{
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct mptcp_pm_addr_entry addr, *entry;
+	struct net *net = sock_net(skb->sk);
+	struct mptcp_sock *msk;
+	struct sk_buff *msg;
+	int ret = -EINVAL;
+	struct sock *sk;
+	void *reply;
+
+	msk = mptcp_token_get_sock(net, nla_get_u32(token));
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return ret;
+	}
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		goto out;
+	}
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		goto out;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret= -ENOMEM;
+		goto out;
+	}
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
+	sk = (struct sock *)msk;
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
+	if (!entry) {
+		GENL_SET_ERR_MSG(info, "address not found");
+		ret = -EINVAL;
+		goto unlock_fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, entry);
+	if (ret)
+		goto unlock_fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+	sock_put(sk);
+	return ret;
+
+unlock_fail:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+fail:
+	nlmsg_free(msg);
+out:
+	sock_put(sk);
+	return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9537717360ce..f6b472d39227 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1036,6 +1036,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
+				struct genl_info *info);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.40.1

