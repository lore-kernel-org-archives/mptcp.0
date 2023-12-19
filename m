Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146311700
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZS8YKw1f"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702974043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvmV24YhjCerQgKs5nga6WhjgK7IkAE5EYu24MYK6iM=;
	b=ZS8YKw1fro9R3xBo2TtyxmiYYUOwmC3gOYO5+HEXIKrlyl871JNVCrwDFwT5JcRCsLGFbZ
	rxt66Ug93FGh+1P5dEPA/cKNIcyC35NmD0aZ+cXg3Kq43+5z1JCDw5DYZ9G7lsEKkrxmdb
	qIWZIZaj4LrwYIn7VbsZLI7PIMcMKDg=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 11/14] mptcp: implement mptcp_userspace_pm_get_addr
Date: Tue, 19 Dec 2023 16:19:22 +0800
Message-Id: <1b82e297c498833fc3daa4cf4b404226cb5edc60.1702973751.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702973751.git.geliang.tang@linux.dev>
References: <cover.1702973751.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch implements mptcp_userspace_pm_get_addr() to get an address
from userspace pm address list according the given 'token' and 'id'.
Use nla_get_u32() to get the u32 value of 'token', then pass it to
mptcp_token_get_sock() to get the msk. Pass 'msk' and 'id' to the helper
mptcp_userspace_pm_lookup_addr_by_id() to get the address entry. Put
this entry to userspace using mptcp_pm_nl_put_entry_info().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 66 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 68 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0a4cbb9e6e41..cf0c04006baa 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -608,3 +608,69 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	cb->args[0] = id;
 	return msg->len;
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
+	if (!msk)
+		return ret;
+
+	if (!mptcp_pm_is_userspace(msk))
+		return ret;
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
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
+	return ret;
+
+unlock_fail:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+
+fail:
+	nlmsg_free(msg);
+	return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7c0d592a9a45..b4c340439abd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,6 +1031,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
+				struct genl_info *info);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

