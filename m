Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F88F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558352; cv=none; b=NzeB1fG8Sm/NyadOrNYyOjnElthYvJIoJwmr8gNxWasQKxpHx7aJ2iPp1vZieZvM3LoQlaF2k55QZZiCI+TRpMx/0pIeTQ//Z0Qnu2dMNwS2/4BE5SGHnHVN85DhUOUBcTRv9dbAzPDCR/lxdYqYPLvPwLqeQ8V7ULrLYeL92c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558352; c=relaxed/simple;
	bh=zxyC4CL0nD+8Jn1vLH37dOwErw6hURhDw96BatMMezA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=TFdR4MRUSDkE6uWOrfiHkp+JAQ+Zmx548w4S4eiui0nl9PBL51gjj/KM5TSuyuM/zWHY57EW735JvY2D5GAzlPoXQAnmYEHDGWMMQzqUEDjGelLZ8xD0x84x9otR5XmF7nNsSGXQxZXYdtWG/WgmJKCO5W1AtjU4gLOAvG8hBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHcKe2CS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHcKe2CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EB5C433A6;
	Thu, 18 Jan 2024 06:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558352;
	bh=zxyC4CL0nD+8Jn1vLH37dOwErw6hURhDw96BatMMezA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHcKe2CSAM4LTeO8Wwb4YGQ/rDWD4fghsEwZUMWiKg3sqmb1AyBr2sXlqbzhAw89g
	 LDLi1i+xl4F9jhdtMvytSPVJBisRTEnZhR8E+F4NhTUEjACyKW/Q9T8UCOvrCkqiFP
	 u6RuRHUkHgITnmxhF8gYPAzcGkYfbviIFVPpSM0V65aPFAejZ7iICGQRenR7Cmhtt/
	 coTA9a9G71ZTl8rWXlFeV/EnrrrgL03ZQ0TvjMEQ2cKBGEdu/r8OKJfvykFgKFczzf
	 +EZie6jVZRzsYUPMcOkuZNTw2+HVkLr5xsxCF+ZW7KxVgFj0nbt4sQXJyhe3ASgvBL
	 v8L1HCHV+Ma7A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 17/23] mptcp: implement mptcp_userspace_pm_get_addr
Date: Thu, 18 Jan 2024 14:11:57 +0800
Message-Id: <197456a7042927d2f0669e672eec3b37fc43fa2a.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index d1457a443b78..96620038a4e9 100644
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
+	sk = (struct sock *)msk;
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
+		ret = -ENOMEM;
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
index 0dc3891a45d4..e2a8833bca05 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1037,6 +1037,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
+				struct genl_info *info);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.40.1

