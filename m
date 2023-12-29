Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C21111A4
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZgtLVZR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgTdm/XOz2Rrnitnhkt+8EUYXC6bzTHAf5eOQaZ3tzw=;
	b=mZgtLVZRhCEfdkPsaqF4zlYC8ab4+doQKfwrMqP3wQ7uQHju3B4xoiheo4x4edTIrZHN0l
	M4l9/jbGeUuqrG5gPwux6H0QbwMD6aL4HDDtnHTBfJ0tsjoKpRrfcgRXXSksih6HqFYi5X
	PGcWlHSJ3ZygdF4F/2Ci7M4+ojlGllY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 08/24] mptcp: implement mptcp_userspace_pm_dump_addr
Date: Fri, 29 Dec 2023 20:47:26 +0800
Message-Id: <495f891a33e13e36402c6a2864820cd0ac32276d.1703853513.git.geliang.tang@linux.dev>
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

This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
from userspace pm address list. Use mptcp_token_get_sock() to get the
msk from the given token, if userspace PM is enabled in it, traverse
each address entry in address list, put every entry to userspace using
mptcp_pm_nl_put_entry_msg().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_userspace.c | 58 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 60 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9df643373c39..98237108ddcf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -576,3 +576,61 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
+{
+	struct id_bitmap {
+		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
+	} *bitmap;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct net *net = sock_net(msg->sk);
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_sock *msk;
+	struct nlattr *token;
+	int ret = -EINVAL;
+	struct sock *sk;
+	void *hdr;
+
+	bitmap = (struct id_bitmap *)cb->ctx;
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+
+	msk = mptcp_token_get_sock(net, nla_get_u32(token));
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return ret;
+	}
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		return ret;
+	}
+
+	sk = (struct sock *)msk;
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (test_bit(entry->addr.id, bitmap->map))
+			continue;
+
+		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+		if (!hdr)
+			break;
+
+		if (mptcp_nl_fill_addr(msg, entry) < 0) {
+			genlmsg_cancel(msg, hdr);
+			break;
+		}
+
+		__set_bit(entry->addr.id, bitmap->map);
+		genlmsg_end(msg, hdr);
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+
+	*((struct id_bitmap *)cb->ctx) = *bitmap;
+	return msg->len;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9b0b3fa65ae5..7c0d592a9a45 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1029,6 +1029,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.39.2

