Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6ED1D0BAF
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881332; cv=none; b=MeD0sTwGtSQXJFUgMv/c7keup6NInpozkYooXZxu/TPZvpMij53S7B6xF7eHE7LBP8inJilS85yPEdRZFqDlvO2EOIwbWIanrNgcSeC8LYSWBGh/lF6w/pE3GOS3glqVnM6sKy6TjTGbJboIQoD3CQGX3ftSUrj4lL4TyXRakBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881332; c=relaxed/simple;
	bh=GVHf7qUuTah6a55QfZ2IslORg40skKkTiSidD872Jto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNq72ILjuxrkt2tmYoIoP5mVyPa9SIvZdHgakBJoXZRnSAxsQ9FURmlQJH2OnFeRxKMJLeWjkcVu4lQVscvhFFqdy6oELHr4ohOrWaH1QxHQKlIWHlOkLK1lAYZMdDYHk5Ri4h+SBi9DA3PjE90Hld2otSarF4v9T2IqkMgUoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L54/1+CC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L54/1+CC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D6EC4CED8;
	Wed,  2 Oct 2024 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881332;
	bh=GVHf7qUuTah6a55QfZ2IslORg40skKkTiSidD872Jto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L54/1+CC+GgD2eOSy3hu90UpOh1/5ENXdkpkMqZEouA8SzIk6Pux/HToeCMqD/4eY
	 HibHZqRwf1N7mIC8+MjAccCl2b1xWrOD+0xpphj3fhBjOzbmGiL6WXyWeGyxHZkBrN
	 2CehD+gttgpkSxj0EQdlKya26B+78QXdkNxBLIJjHqqdPzdKOQDdJAu8DjsM80MMFt
	 P6tLiIWxzzFP/ZY1EBt8FM8VzCdbZPz8WbGG+TQsbt8zcgAVRWcEVe7EEnA8Dc/h0n
	 QgEyQoSWY9fXOH7czaHZkR4QK6vdS34TdrcE0X0y1di0vxeG7P8cb5R1VmfrPK43z/
	 aiat2sHV2Umqw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/9] mptcp: change remote as mptcp_addr_info
Date: Wed,  2 Oct 2024 23:01:55 +0800
Message-ID: <7d0cc64bb775c622d0fd003dfbe566e486ef750e.1727881073.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727881073.git.tanggeliang@kylinos.cn>
References: <cover.1727881073.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined as
an mptcp_pm_addr_entry type address, while the remote address is defined as
an mptcp_addr_info one:

	(struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type parameters.
This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7f62a45bae76..f4a4fa465136 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -540,9 +540,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -559,13 +559,13 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 		if (ret < 0)
 			goto set_flags_err;
 	}
 
 	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
+	    rem.family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
@@ -575,7 +575,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
-- 
2.43.0

