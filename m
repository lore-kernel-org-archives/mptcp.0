Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB64178395
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742810; cv=none; b=XXlei4YFfSSd9VYyFfshCQlrP4zxl8i9FSGVs9oD7RWQDlcenOkTN8g/P2dR3TyUYwEfCWsld/7aZ0GZqLLd4i7JBq4pBn+iOPTC4vume92pYUSN0EH4hUkB5Rl41A5OUndPgAeDzLiGVbY5oUSBV3pzErFMBE5082WY3vMWGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742810; c=relaxed/simple;
	bh=HgcnOJp7BoG7+XWL3+KkCN8XJ0aLr9B4V4kGhZ6HQQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6TD5CLymDBVaTzo/yD+gEBtw9SN2XzfCbkk4B/a6wEHa5UOip69Gmab8JJOdY03xxL2pWUsbgSLjvj2QtzItQ0RI8Z28zpYyYpp4nXzTy78lT/LYDBPFEcW97uC4CIsl/799ml3sFnvzO+SAwrG7/MYZ1Uj6EAMK+bjgbHmsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLuYHq5X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLuYHq5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8036C4CEC6;
	Sat, 12 Oct 2024 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742809;
	bh=HgcnOJp7BoG7+XWL3+KkCN8XJ0aLr9B4V4kGhZ6HQQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLuYHq5XHvTI3twEbQq+PQ6zYeqUxac6Vl+19T8aw/JA/ULUhRsVwZEVHN9P/jxgf
	 jmouYb+8qFM95b/5t0rsh8Z9ogbh3keK5VqYBKl7mhQwvHxWNaU5R9z7trhwRL1baW
	 xiV1Dxf8gGnCCwPCP4l6YHa+ZsmYxLd+FyuBi/dOIS8bTidBszOPd7b1zVXaa9wpIb
	 vfQMCPahb69DJY/a9DAjc/+tIaIodN7JUyeuJowtsgvHLYnPKldj3ztfLEGLheU0D/
	 CjKKUteHy3xizff+AhhBS3Su7QCA15iv4GD+MU2Aq7wP2XU9tSy5aSR9frifrS/DK1
	 0KCh3H0y5fxGg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 07/11] mptcp: change remote as mptcp_addr_info
Date: Sat, 12 Oct 2024 22:19:47 +0800
Message-ID: <87dd7f80bb8c1f8114326739a911d79fe6e17ef3.1728742592.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728742591.git.tanggeliang@kylinos.cn>
References: <cover.1728742591.git.tanggeliang@kylinos.cn>
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
an mptcp_addr_info type one:

	(struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type parameters.
This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e8edbe3a2600..5305af015ee6 100644
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

