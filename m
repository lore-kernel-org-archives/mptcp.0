Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D633FE09
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498746; cv=none; b=Z34bW6G0GuEyfkjrOfNHRUYSZZVMdfe72/KoGiUmq0YYNLRDmR6OLeYeo4bKWQPrb8NVfvK1TJyutYTJRLhIv6AUoSjW/h+RfrNaGuspTdZuAGHD8Q7vkWqjSbXnyvVjoBqtj5Q0vvsuH59xds4nRnp5NFOusH8UHbhDLSZE0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498746; c=relaxed/simple;
	bh=DbC3/HE5knS49vJbD34u92b2ULeu9ixGwx40BtIZBko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCpeBWktW385KCc4Vk5krDXhS8IBSoxRKEDTk2mBp4+MCKQuAUwDxt6E/WrzDhJ1m4NfLovjvE/vX1F5XbRBb6A3HaxJmDHy3hM2VEcmcW1fX24cv/ivpq4L3oafdpMZ44cy/hfTmug2+Thv9w2pqO7S1GnDNyCjIkc8aYbtiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FH26hqq1; arc=none smtp.client-ip=95.215.58.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FH26hqq1"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=DbC3/HE5knS49vJbD34u92b2ULeu9ixGwx40BtIZBko=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788498742; v=1; x=1789103542;
 b=FH26hqq1xuq5XFk3LXDIKwHmwWZrXeJL+tacqxXiJkQfNljz8stjYzNYHwDalBwDhIQ70IsR
 TQFs5bqWRdvOBnNCTYKEqIDTnd1F2KMs1MGQk5UXWAoSKoiwcpGO08GCXHbKRNjRaVqcUzcXSZz
 GmIC9UV9qYnbo+CYUJSiL8T0=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 04a94af7463dd832;
	Fri, 04 Sep 2026 05:12:22 +0000
X-Mizu-Trace-ID: 04a94af7463dd832
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	quanyeyang@proton.me
Cc: geliang@kernel.org,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next v3 3/3] mptcp: pm: userspace: cap extra_subflows on Netlink subflow creation
Date: Fri,  4 Sep 2026 13:11:50 +0800
Message-ID: <20260904051150.1196427-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904051150.1196427-1-cui.tao@linux.dev>
References: <20260904051150.1196427-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quanye Yang <quanyeyang@proton.me>

mptcp_pm_nl_subflow_create_doit() also increments the u8 extra_subflows
counter without any limit: a client with CAP_NET_ADMIN can create more
than 255 extra subflows via Netlink and wrap the counter back to 0,
with the same effects as the MP_JOIN path now bounded separately:
the underflow guards warn on the next subflow close, and
mptcpi_subflows_total reported to userspace is corrupted.

Refuse the subflow creation with -ENOSPC once the counter has reached
U8_MAX, and clean up the local address entry in that case as well.

The same error path is followed after
mptcp_userspace_pm_append_new_local_addr, which should probably not
delete the local address unconditionally, but this is a pre-existing
issue that will be addressed separately.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Link: https://lore.kernel.org/all/20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me/
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/629
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b94fbb483bf9..e7f7d023c246 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -417,6 +417,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	local.ifindex = entry.ifindex;
 
 	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.extra_subflows == U8_MAX) {
+		spin_unlock_bh(&msk->pm.lock);
+		GENL_SET_ERR_MSG(info, "too many extra subflows");
+		err = -ENOSPC;
+		goto delete_addr;
+	}
 	msk->pm.extra_subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -427,6 +433,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err) {
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
+delete_addr:
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
 		spin_unlock_bh(&msk->pm.lock);
-- 
2.43.0

