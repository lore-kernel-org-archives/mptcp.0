Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15298F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558338; cv=none; b=nGUY9w+40TJGpcjJIigqeJ3nttduFNrsylJBDs/yAp0wa7O7VNm+if5PdAa0AZZkAv0DOwUqWrbd/bzZwSu1rhflfdzyGUl6d/Hzks717rsAb3FfAPw5wEL+kadKc1oVYKsocdMpQeMV52H87d3YI39bngI5/4LMyxZSbAEDyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558338; c=relaxed/simple;
	bh=W/APShdzsrPHD0Vt6vCOHuhqdGiBreiDvU0CRPdO/gw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Z9uRp3Igbg5MfVWuUGJXrUj2iUUGSIwmi5UlStgS2dygltk2igclKnT4Q+BXLtOWIk18qxq4BIhvrzMDLntJDAdEoVrMrVHvHoNGUUemjMuq950hjv2THSkG7rNoiKR+y56UNgMV29o1CkTSmnxpuYp8sxF6ODnGJ7rq5n+F7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6HxQyAc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6HxQyAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B06DC433A6;
	Thu, 18 Jan 2024 06:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558338;
	bh=W/APShdzsrPHD0Vt6vCOHuhqdGiBreiDvU0CRPdO/gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6HxQyAcN/MrYia9ybb33XPeOvn1zXAHOgLaHtrLwme3pHvm4SIwbLvKTJQovMVRN
	 FMQhYf2gPf0LXR2351vA3Tn4Niz0t9IlHPvL+wZboiZ3dH5rb5dasEIFsgrxcijIKf
	 THs+RH3H9dmkRw3hiLKSm/IowyX+8cUrHI+JXOtaradK9Pzw7/yyxr3/XSVTF4f4oK
	 vrpXMB/2iEfBbuPvU+lFVp+nZmzvlk98wBMkjgPiKZ1qPLiUkUEbbEFf9Am/c7nKm+
	 OiMHkSScXntFNZPJKapN6zQHMpYtcRqmaWuvIZCI8Smml4LAslH2Xagu4i9U7cklCD
	 V4SLRj1BsKLZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 07/23] mptcp: implement mptcp_userspace_pm_dump_addr
Date: Thu, 18 Jan 2024 14:11:47 +0800
Message-Id: <603ed98d214c9038bf0091dec4de50d7441a4d88.1705558030.git.tanggeliang@kylinos.cn>
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

This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
from userspace pm address list. Use mptcp_token_get_sock() to get the
msk from the given token, if userspace PM is enabled in it, traverse
each address entry in address list, put every entry to userspace using
mptcp_pm_nl_put_entry_msg().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 60 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7bb3574cc65a..f1582f40f70e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -574,3 +574,63 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
+	sk = (struct sock *)msk;
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		goto out;
+	}
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
+	ret = msg->len;
+
+out:
+	sock_put(sk);
+	return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bfb1bfea83c3..6d21223ec65d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1032,6 +1032,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.40.1

