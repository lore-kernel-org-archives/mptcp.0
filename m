Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B45FEF9
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423121; cv=none; b=AWRf/a5Queiy+wkgqqrKI0+Ylz7yaFExxRPDOG+rem62EPHf1Ch4PFib1ecgV+MCtByYO9vI6i21xd7NQf8LWbmzcUvfyBeQEarjo3RR5iXYcZ+HMrDTYjWrwk1tYhYX3OPjy1Ft5BXhLFctFkLUsQJ7fNu5IfRbho/De2knMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423121; c=relaxed/simple;
	bh=bxYncz3Oboan33g5M45Geo2f2eqtF0tn+Bs7CD6IdUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xgjn0cFi2KEjWxxeY8t2Dhg88StdMfaxaF3X6dVJdo59v0fyN6HqdrXDucO1+YBqNK+DN2vmU/qzY0UKr1KZeJkhqtBJbQXXXEvXVeC7ExzHcN9YlXN/XXbYM0yRt8iZqSLqvuCKPK3Odx4mIXqmsejHqDDcjP9LgCIMKa2a9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn7jln2f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn7jln2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A0DC43399;
	Tue, 20 Feb 2024 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423120;
	bh=bxYncz3Oboan33g5M45Geo2f2eqtF0tn+Bs7CD6IdUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jn7jln2fcmeTt1F+2FwKSybke7MFYevIa5p8WSYA+egz9kxssgnNqBO5VKEuxV3gZ
	 QQFpb3BKMnDlXccSoyFc++qdRKm4gBijMXBDnx5UL4tpyAwTz4DvSJtrGuKAI98Ntu
	 mJ5NQbvVZpflJXKliU+vIZcsW+TnGzLpWidlULnXHhAnUwz10u9d4NM+EU0Kccicbe
	 knCM8799whpEpPBAAQ3Xeti7bdkLNXP+CUjoUWGQRAtO9MbAl0lbqxzUukSI2BxXBG
	 CmQR1cc6MseiZnrlXh9tPAo+OSE2tHPSQHlArUWA3YXKdDutk3wn3p0GAHKfnAoRy6
	 QhTp0lUxUMR8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 05/14] mptcp: check userspace pm flags
Date: Tue, 20 Feb 2024 17:58:19 +0800
Message-Id: <3c68f7b7bb0daae49055c9c3776656a3782733a5.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), PM flags should be checked in
mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

        id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the PM flags of the entry and check it. MPTCP_PM_ADDR_FLAG_SIGNAL
flag shouldn't be set here, and if MPTCP_PM_ADDR_FLAG_SUBFLOW flag is
missing from the netlink attribute, always set this flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d6b7be3afbe5..3bd13e94b568 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -334,7 +334,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
-	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -360,25 +359,31 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
+	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
+
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
 		goto create_err;
 	}
 
-	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
+	if (!mptcp_pm_addr_families_match(sk, &local.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
@@ -387,7 +392,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
+	err = __mptcp_subflow_connect(sk, &local.addr, &addr_r);
 
 	release_sock(sk);
 
-- 
2.40.1

