Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB2156653
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310091; cv=none; b=h9IXUayLP6wJKjFD0PrwYedaZR5U2V7jOCDq5oUU1G5zTC1L+TB2LA25cOZhlaD/rqyutmDfhKop5cjCLgVkNbTjspx4MKZIHyrA3Xgzmm4aiq9AXACATpmfVwm83vm3X+QplXGDtjYNVl6NKqH2cCyhU8lqVOYRO0rEOrhzlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310091; c=relaxed/simple;
	bh=n+rZ9HGIyFq1icK3jKrhtcYm8LBmAWKs6/Bp1YmC200=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl9xyarWAogisKv2EDt/MFfCjBFOw3Z16pTTAA5cOCzbwh+rzpe/Y3E5AJdDDUZbqKUAYiAUsk2s5GvpYAgECb73z31yi74ewPpc3jh/RUp62ddqTIcE02W/l39rHoXJRevbwlV5bP/qD4l9/xdcZoZ0YLsAfkK7x93O++jqZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQg1iGDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQg1iGDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B407C4CEE2;
	Wed,  8 Jan 2025 04:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736310091;
	bh=n+rZ9HGIyFq1icK3jKrhtcYm8LBmAWKs6/Bp1YmC200=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQg1iGDQgRCaOqDmimjtHAK4pKxc7H7/zc/dXzO3szpuuzQEaDVdAYN+7m557/Gdu
	 rnMMKKKzwkWi1IPfsDx/w9QPAtCftPZkFUWDuBZ1HKiBmeA4+ki3GnOQURVSUVK/G9
	 gnH2cqyPHjO9WW0jiKuyR8+YojP25fshTU1KNW7Ymt56NFNQNDLW3A+owt1FdYHvo+
	 9k16RPV4hMSW4fuxT9MrM56K2UtWYh4ddm2YAcrPDDsSou+hXUYjq9M5FvIEsDbYuQ
	 205TRjTyRdZzvt+ZKyOVddu9XVrpYN8ziqVCgZsEl4BOpvbE2ElW1nyrwVpS2Rg+ZY
	 wsUhYqLt2YthQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 7/8] mptcp: change rem type of set_flags
Date: Wed,  8 Jan 2025 12:21:11 +0800
Message-ID: <195aa6f1116a0e09ec965acb74e248cc355d77f6.1736308884.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736308884.git.tanggeliang@kylinos.cn>
References: <cover.1736308884.git.tanggeliang@kylinos.cn>
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
index ce3154a87570..a95f52142a33 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -567,7 +567,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
@@ -595,11 +595,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 		lookup_by_id = 1;
 
 	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (rem.addr.family == AF_UNSPEC) {
+	if (rem.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
 				    "invalid remote address family");
 		ret = -EINVAL;
@@ -622,7 +622,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, entry ? &entry->addr : &loc.addr,
-					   &rem.addr, bkup);
+					   &rem, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
-- 
2.45.2

