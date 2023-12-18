Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BD12B92
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KsHM3W10"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702891514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VT602ytGc/YyEW8cf2FVP8n4BkeEbtLefQdnbdFZgc=;
	b=KsHM3W109u6vFINGEhToQPx+ALTtoKJjONQiieDGUHlVaWdzz6Kl4KTbjm5vkYyG+iNJ9+
	O9aCJyZ5j4Ke41y1nVLvzkoXmZv9XsLay4bKR9XkOJxoyyapMxM6K6wvmjpivfVu183f3U
	HzfZ+sDZtE7Z8ivsFHx4D00d7ANF8vI=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 02/15] mptcp: implement mptcp_userspace_pm_dump_addr
Date: Mon, 18 Dec 2023 17:23:31 +0800
Message-Id: <8f08f61a98463a38e6617a01dc789c78b0d414e5.1702891194.git.geliang.tang@linux.dev>
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

This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
from userspace pm address list. Use mptcp_token_get_sock() to get the
msk from the given token, if userspace PM is enabled in it, traverse
each address entry in address list, put every entry to userspace using
mptcp_pm_nl_put_entry_msg().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..a497148039c6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -550,3 +550,42 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(msg->sk);
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_sock *msk;
+	int id = cb->args[0];
+	int ret = -EINVAL;
+
+	if (!info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return ret;
+
+	msk = mptcp_token_get_sock(net, nla_get_u32(info->attrs[MPTCP_PM_ATTR_TOKEN]));
+	if (!msk)
+		return ret;
+
+	if (mptcp_pm_is_userspace(msk)) {
+		struct sock *sk = (struct sock *)msk;
+
+		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
+		list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+			if (entry->addr.id <= id)
+				continue;
+
+			if (mptcp_pm_nl_put_entry_msg(msg, cb, entry))
+				break;
+
+			id = entry->addr.id;
+		}
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock(sk);
+	}
+
+	cb->args[0] = id;
+	return msg->len;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 23d4742f3f30..a05a6745bc31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,6 +1028,8 @@ int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

