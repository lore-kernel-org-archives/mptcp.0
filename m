Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C2199BA
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910853; cv=none; b=AitDmAQqegjOLyLg5Bt49J1CvqFD+B9l5CQiHj3bojvG9l6q2G5uWH7tM/mxVv/wj/S4pfM5o/a+B1eCkXK8RJ/DojKgfdfmV6PHYeo+Af5XdzyxfEsBFPXairflyvDWil3joHVzKsz6h58stMr40AvEn8XjuR4MOtxkzx4tSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910853; c=relaxed/simple;
	bh=NnNcW5v6KIrnHIf30fLgb4sTxTeaPwJ6PDJdCChPznA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ue2aqDonCVfYaHukhbelrEnGLZ0kLUlDuroeQMDY2q4cGBNADoQDq2uBoGdpc/20p1bmHEwkhpKca25BIRKR90s+QV+weU2sAes5F9rL0NluNraEWgW+oneY+hME2MZ7EIcD4gwChoE0Xgy+zY6OvEnulS6sc7ohqbiu8vT5KrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2UQUGWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2UQUGWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFA1C43390;
	Wed, 14 Feb 2024 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910853;
	bh=NnNcW5v6KIrnHIf30fLgb4sTxTeaPwJ6PDJdCChPznA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2UQUGWUrTn/874PwkAYI66E0nxS3uKzGaxfGuXSonWM2oX+JaXaeRit50SB4oqB+
	 EoRioOMPXFzfdi6TdBEsAcaWNR6Xvb53gM4jiSeTmmdZopQz4W+BR3fwtR471IAv1s
	 3yo5HbNlVEYc9ju734Tlszb2qhlFs22x799QCHDy9GQA+EKpL0IJ6P42SGOKVE4OqP
	 zWvyS0Mo7YFao4HIYICFhBanTiA5o/w9v5nqY7ty+Mg+ZlNyb8xD+q+tMidxG3WY8y
	 qlDoXZSCf+S0dXFwFpRt51lJi9bGcewRkglOjNz83Ev66sfwmUc+B5LOInuQoJ3IjY
	 nfhT6tqX9lW3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 02/15] mptcp: implement mptcp_userspace_pm_dump_addr
Date: Wed, 14 Feb 2024 19:39:53 +0800
Message-Id: <6158e1ede3caac589181412df930bcc7155102e4.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
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
index bc97cc30f013..d6b7be3afbe5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -572,3 +572,63 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
index 60de3f997de2..af20833f3157 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1032,6 +1032,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.40.1

