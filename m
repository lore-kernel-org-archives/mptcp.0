Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F21D6DC9
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151390; cv=none; b=ao0TZpD5tyVHo/eKeMXkSs5ozDWeY878uB6qfCidnXgzVgxrvNIqHFF+2i0mBAN2GQqrDUb1JtJYCv6VjtNcAG9HfXbT6IMkSWntUQQ31s3XWjlEztpFmk00MTe+JxtwSTQnAUTUqlS8pEsjXFfM444gAf/X2VoNTo0R3wL+rDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151390; c=relaxed/simple;
	bh=Zu8JWeqXTgWtIE1j6959Z9bCp1FFLKZWQeFSfyKFJlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFHwUMpGlI/RMyaCQhPDU+caAxWjNJPWVqP4GfQOLeGTisp/8GogpDoRwccglkwQWIKp+SjW2DrBzqqibhIxeytJTm+Y1V3YP5AETpd8eXWRqk4J0/4ZLFjL51/rx37SujMiiK04g/0HngCzXJVp6r5DDCIjfwcsfmApwhfcSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYjOIiEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYjOIiEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE2CC4CED2;
	Mon,  6 Jan 2025 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151387;
	bh=Zu8JWeqXTgWtIE1j6959Z9bCp1FFLKZWQeFSfyKFJlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYjOIiEfwUGSvI+ehTi8NZil63ptVCgwiejdyyTQyM6DtbzS9VrzwrMDwHg3MoA6r
	 KVU80VSfjjWBOcCEcFPutk09HGKXxdIFdvdntRx3rb8vnA9kp1BUA2kx+UY5PKWdex
	 4WgbnOpj/dSZd5ZT2V/RUgMvQZ67GzZhl/6h16prLywlcm575Xv9Rtv6HZpUQjc8I/
	 O9i/Ta643pIyiRBq2HdHy0TINf+R9kpDpzEN1BQJXiwRuO++xWXtPsvxX8iWgxBCnj
	 7MV0xXaLVxO5Xkmb7YBNBf4JM2kK6Ix2BqAfZ+XR/lX7Qa/X7zVxXbhfFS9bkZMxz/
	 GqzJL4OcrQ22Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 02/11] mptcp: userspace pm set_flags id support
Date: Mon,  6 Jan 2025 16:16:07 +0800
Message-ID: <0d06955f697e484c18262a9806520132f07110cf.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to in-kernel PM, this patch adds address ID support to set_flags()
interface of userspace PM, allowing it to work with either an address or
an address ID.

When an address ID is used, mptcp_userspace_pm_lookup_addr_by_id() helper
is used to look up the address entry in the local address list instead of
using mptcp_userspace_pm_lookup_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 40fd2f788196..60db72060e6e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -577,6 +577,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
+	u8 lookup_by_id = 0;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u8 bkup = 0;
@@ -592,10 +593,13 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (loc.addr.family == AF_UNSPEC) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr,
-				    "invalid local address family");
-		ret = -EINVAL;
-		goto set_flags_err;
+		lookup_by_id = 1;
+		if (!loc.addr.id) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr,
+					    "missing address ID");
+			ret = -EOPNOTSUPP;
+			goto set_flags_err;
+		}
 	}
 
 	if (attr_rem) {
@@ -615,17 +619,22 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
-	if (entry) {
-		if (bkup)
-			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-		else
-			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	entry = lookup_by_id ? mptcp_userspace_pm_lookup_addr_by_id(msk, loc.addr.id) :
+			       mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	if (!entry) {
+		spin_unlock_bh(&msk->pm.lock);
+		ret = -EINVAL;
+		goto set_flags_err;
 	}
+
+	if (bkup)
+		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+	else
+		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, &rem.addr, bkup);
 	release_sock(sk);
 
 set_flags_err:
-- 
2.45.2

