Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347615D5C1
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298418; cv=none; b=fOSMXAVX51X9KBK1wrdLD8odhzYpBNshXElvZ2WUU1PXV/Iib/V6MiU1TfHIb4E0sbwDtEK5QoupuNOeOL5muoymJ63F3saD11N5oQy1P4wamrQdX13zfMn/w/+1e6oDg0ZGEfawgd/stCCGzvMg8yB1yaGkkLBDpFa5BoOBqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298418; c=relaxed/simple;
	bh=kEMmc02kMK6FOx1V+tinbaU1Ku0mDwmcrqsRmCrdqOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVzIJKsrAlCLr6yTUXaMRw7zEdlzqLb2Yg3oJTjP0nR3r3XmMq4ozdHPJ2wTAxxVcjJTIS7JxGfMFhmRmH+KY+jhhsVcol7ikkjfd0vwLu7Sw/PKlOQYxNvZ1VM+1djWMm0vjJ+GMP/jRgS9YRK59xX/zizgbeSGrR9UB0Lg8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM9pBq9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM9pBq9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87F8C4CEC6;
	Mon,  7 Oct 2024 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298417;
	bh=kEMmc02kMK6FOx1V+tinbaU1Ku0mDwmcrqsRmCrdqOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DM9pBq9A8dHr9KrSXhLgMndN9j2WpUxZNRqe1LUL7eNqzLtOLFj4Nfvhlj8RRFQwm
	 3f/cTAw5oeJvtbaGj+C75Y+w43jSTOyDSdJ5HHCPswgwBdHdCzgf6AsuziP1f4LvCP
	 r0tHRcyG+vzn6tqCZvo3rg8GlAqE7lmpWdbMcitF1Y12/Z0rNxm8ULHgJwmZDGrY3u
	 BbZcLzkOOTIZqa6mmg2OTJQ+tp897oHjaEFsuH9Yz2bVjIB+D/TjnfdDOCn/ahmGYS
	 4ON5XMtf1oH5VLD85TiJqlVpqu1ZaSHQlUD2lTTpcgAi0BIvcspw9UpJM7t/kapqEc
	 zkr3oVDV3CG+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 06/10] mptcp: change remote as mptcp_addr_info
Date: Mon,  7 Oct 2024 18:53:18 +0800
Message-ID: <c3c3da2bc59d9fb46cbf3fc2ea6196c2622a5bc6.1728298100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728298100.git.tanggeliang@kylinos.cn>
References: <cover.1728298100.git.tanggeliang@kylinos.cn>
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
index 58599f32b279..3c5591af0a80 100644
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

