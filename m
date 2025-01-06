Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE91D63D7
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151392; cv=none; b=XUUqVie5FVCn6/uL94kNBa3hewdh1awPuJ3/hXBcQqPRF5HDF8fNza13zt3esJzDGUvURZQ28fnOS0T4utDPlaI12dN+vRGIUgoovQbHRsGwcDFRgbPG6xfqJjrAWJ7XbWd3V0Q645q9ve/DZqAZUcdvLNtW4lq5NyhZ5DRhqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151392; c=relaxed/simple;
	bh=Es0fGTSAq3jsM2Gdf56/H16AdROutuivEISaNba6wJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA2P0en3tfozO8xcyrvJGJqU1GjASzuZRinZa/eKQ26AxDyfvx35+ZenmNInxipwbEDsNpF7bZKeYbDI5XL1Qe0G66zLoORrCXhg92UvLCfVCXHd7v1fb0xP+7r8lve/tKVzpTaKjYAxPhY+GuFxRw+TZ1sHqprbjPpORL6K5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7fEx08t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7fEx08t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EC5C4CEE1;
	Mon,  6 Jan 2025 08:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151391;
	bh=Es0fGTSAq3jsM2Gdf56/H16AdROutuivEISaNba6wJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7fEx08tjuYkKeS8Q9vfk5VoqbQ/+7Ug4Ysd0Xbh2B2SDaQyJxg8hUpZQvKu6WYwr
	 KS88doW0JveoOQFMbZbNMTbCjlfKF4LHZPX+bg+RnfW7QIZ5jy6v9irtaTSY1ZyTZf
	 1acM+Wx/6mUmqLNLaPpXvHk/JuN60SNJfbVAkI050lnlSePbvlRKLqQP6tc0FAh70A
	 I8eSCPjkKI3NZeAmTftwxhWs/asL+hd1WFrH/6/x3qWvNvU7tdngv1/B6CYWdo6OaT
	 kFHRYahu1RwEmw8ECup8dL7SL1+M+Anmz0wTqHqpZLsImcvQSmu7YMjkjsyu53Z9iq
	 rsNx8zT2OzzoQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 04/11] mptcp: change rem type of set_flags
Date: Mon,  6 Jan 2025 16:16:09 +0800
Message-ID: <28ae9ea0097ce50c8e4cc076b946d49522aa69e6.1736150983.git.tanggeliang@kylinos.cn>
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
index 51fd84c49474..2a00227e3f35 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -572,9 +572,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	u8 lookup_by_id = 0;
@@ -603,11 +603,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	}
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 		if (ret < 0)
 			goto set_flags_err;
 
-		if (rem.addr.family == AF_UNSPEC) {
+		if (rem.family == AF_UNSPEC) {
 			NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
 					    "invalid remote address family");
 			ret = -EINVAL;
@@ -634,7 +634,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, &rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
-- 
2.45.2

