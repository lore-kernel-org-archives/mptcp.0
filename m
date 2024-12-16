Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC21C3318
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337900; cv=none; b=h8pJiY138PjtREYmzVvefcmI6RsbKbuZvktHbgyxcGeqn0ycTx5R0+RzBTWd9fTwdEXCvRKqLBiEJPj6xkzQyYc1rNukU+ARs594eTswCz2jIGLWAcYGUB7hj/Ds0fRAHVPgDWzb12m+09d6p51Xv/xMnQfm/lGWXTkWfX1j9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337900; c=relaxed/simple;
	bh=09r2oCcy6d0GaBR+ZIPfPwkVUNSAVpCp+j7rRtxe1K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQrU0RtUAotJ2QLqj0Jux3IBXFWCiRMJ4Yv/5vTxcBso51IV+gn/Of8CqzpK6nzCeWt+j+sKEtcprKF2v+a0TQbatgJTDBH8F9bRqNgTopRA2ywYvjeHwe2YvtNHpqmYNVqckuaD5z70dsfb8JKHfGl9ViUgIXobTiOxIfIksHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv+5+kvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv+5+kvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADFAC4CED0;
	Mon, 16 Dec 2024 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734337900;
	bh=09r2oCcy6d0GaBR+ZIPfPwkVUNSAVpCp+j7rRtxe1K0=;
	h=From:To:Cc:Subject:Date:From;
	b=Yv+5+kvsDrEHHKax3YeXsNphexn+8JZe1rwH5J5nIIjSIbeit/nV9SLccAStutaWJ
	 tyj62c9XKe9Xtg4HFdEFNSjJNjUElVzLhDjNRVg2sjDcpkOIBMdeekEh5dyQiy6Gdc
	 h45V1N7p2llvMbuvXWHcKhtLfh1eW7zJ2NxwTH6/24Dpxlb3t1c5ForW/BZMsm2b4o
	 5/vSXx0G5XuWubBxp1iEfddZRdkfP05ymm4nX5VwDAxq2J5eIN1c7//eI7Fhm2jd89
	 uEALHmT2YOY0XNWTXrKE/WWsXMlHxLlrgvtUBHXfKd4kqK5vfDksFfB97sK5EM307i
	 Z0CvmmMJZJdjg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3] mptcp: use GENL_REQ_ATTR_CHECK for token
Date: Mon, 16 Dec 2024 16:31:34 +0800
Message-ID: <d9c76c6c008c770046f665a4a4e93735fd121399.1734337790.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A more general way to check if MPTCP_PM_ATTR_TOKEN exists in 'info'
is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN) instead of
directly reading info->attrs[MPTCP_PM_ATTR_TOKEN] and then checking
if it's NULL.

So this patch uses GENL_REQ_ATTR_CHECK() for 'token' in 'info' in
mptcp_userspace_pm_get_sock().

'Suggested-by: Jakub Kicinski <kuba@kernel.org>'
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v3:
 - use GENL_REQ_ATTR_CHECK in mptcp_userspace_pm_get_sock only
 - drop GENL_SET_ERR_MSG as Matt suggested (thanks)

v2:
 - use GENL_REQ_ATTR_CHECK in get_addr(), dump_addr() and set_flags()
   too.
---
 net/mptcp/pm_userspace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 740a10d669f8..04405fc5a930 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,14 +175,13 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
+	struct nlattr *token;
 
-	if (!token) {
-		GENL_SET_ERR_MSG(info, "missing required token");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
 		return NULL;
-	}
 
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
-- 
2.45.2

