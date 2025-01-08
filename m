Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B68139CF2
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300665; cv=none; b=ujUiM5MN0jv9THVIGOMLd1lfoFgNIlmymNh2D+4Z+jnsGceFFbV8MJVDq5G+dJBMdKvq3VInc1O/EkYO3ax/86MwQr1UEtBXZPyMrNb3bmE3gUNsuqLRRIoU0btO4KLF71vvQ/fxbZ/2JAzINwrwgkuknLzgpKsmhldFfGi59SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300665; c=relaxed/simple;
	bh=/v+Lww7LFz6yGbabYhG0P65FdRLrBMBcX0CKiZajfGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA5rBfwNADXMlMNAHfQ6AM+Vu8h40kmwrU1elyaSPUbOjqJo/wn/9OSlP1zqIsiGK3Nt79cKzxq2O91YPX8VlTW+yvJgWYtRMU1SHCRiYI/9gfANYc9PVb7xT7RQCnoLbeIkp1cd8ZRXD3ACNdbp9PPMUUCukg4AKDV98LSYIZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHSX9a0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHSX9a0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A802BC4CEE0;
	Wed,  8 Jan 2025 01:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300664;
	bh=/v+Lww7LFz6yGbabYhG0P65FdRLrBMBcX0CKiZajfGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHSX9a0N+5iyEMnAGoUqrBjFuZVCzuP822IwNyj1tnVoh25bXNYYKg4gzMrqDCVvy
	 +b3UQ6Md7mj+z7c8RJ7Z96Q+Tn0Gq3JJ8PJu/J1ZU5S8aMtRHZRhUKZiJs15pkMJVv
	 t46aZakAUZZOT4eUjhljkI4sFEaCHC6jiwqkpMCwWsuf5MW9/+IUbzUVCiYndk+DvO
	 D10XZyMtcDhSAFtVGrRe93N+icRRWxVblZS9e9UgADsQ0FOKU5dvZeiLy6agWVULNv
	 qW3D2zM8AWRQpFD1IoJ/qXWkyfoZVOcSDBPUfS+kRETGQjfRMsz/qxJ/ooK9V+xaLP
	 4QSi2Mv7I4DOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v8 4/8] mptcp: pm: improve error messages
Date: Wed,  8 Jan 2025 09:44:05 +0800
Message-ID: <e874dbaa4aea1b221d9becd0dcf14abda24ac29b.1736299989.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736299989.git.tanggeliang@kylinos.cn>
References: <cover.1736299989.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Some error messages were:

 - too generic: "missing input", "invalid request"

 - not precise enough: "limit greater than maximum" but what's the max?

 - missing: subflow not found, or connect error.

This can be easily improved by being more precise, or adding new error
messages.

v2: add a comment in mptcp_userspace_pm_set_flags().

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   |  6 ++++--
 net/mptcp/pm_userspace.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8..a60217faf95d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1875,7 +1875,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		GENL_SET_ERR_MSG(info, "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+					"limit greater than maximum (%u)",
+					MPTCP_PM_ADDR_MAX);
 		return -EINVAL;
 	}
 	return 0;
@@ -2003,7 +2005,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing required inputs");
+			GENL_SET_ERR_MSG(info, "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2cb42091bd08..f5372e0a0dd9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -190,7 +190,7 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		GENL_SET_ERR_MSG(info, "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -428,6 +428,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
@@ -552,6 +555,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (!ssk) {
+		GENL_SET_ERR_MSG(info, "subflow not found");
 		err = -ESRCH;
 		goto release_sock;
 	}
@@ -627,6 +631,10 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
 
+	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
+	if (ret < 0)
+		GENL_SET_ERR_MSG(info, "subflow not found");
+
 set_flags_err:
 	sock_put(sk);
 	return ret;
-- 
2.45.2

