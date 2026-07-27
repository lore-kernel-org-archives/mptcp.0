Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D04248B2
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172934; cv=none; b=GOjq+RE1rEXcuZN0UoMrymU901QXNMp0AZwAvD5esBqhmdFitMKa80C1ndav1Qidx61tapbrl0oh9TWbagZ7COMgkOr3h9jkiiAVxXR/faGUN4Q4vmNp17v9tnaTu0QD6SuZFw3ai6aU8wDqE8qCfL98+KiUnoNezAqlOTrrL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172934; c=relaxed/simple;
	bh=ex3YVuaXwyzDajq6Z5anTikGQasl6kl8ydQkWXVsnR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYxFaOibnKYiJrMqpoMy1UK5/Ty+cW5q/RoDMXNcOJGZ8YSnT8oWyfyZqTduydUsEkHAZjeSlQ31tMMibldNWsS7I9zFU2ZXu46kxYcaPibZUUPB1qD2406JOHIRGjNPec7ihe/UqL5/JMKVHxraSwSzBTgQI15FVDvEEGMOHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh76W/VA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh76W/VA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6F41F000E9;
	Mon, 27 Jul 2026 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172932;
	bh=ywtwCXSEqVJDkD1HcIxykQ87R3b3FsnotfhhL+dXzIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Sh76W/VA6dmdeBtpoJ2Gpqm/FG+Dr+9KcEAcpnSgK3IZTejc5AmNEJiVwxlzDZPwG
	 GV+OUZnmy+sA5hUDNpdgkWYjxqB3TSSnb5MyJv6EO0iJqWWRq1Yfs235AB0gpjvf6I
	 uT1URFS2R/+Q51QmfDA1HQPAO6pZPgIQsqLe+YExcpYHbYBT8UCnIzoaWLW/W7S3ba
	 h+Z1UYo8HQvO6kAhwL6L+JTe6RyAqvtp63TOaz2q/VEj50oPicEb8Obto0yVIb6bBp
	 4Alpt0P4uuqeuMYpPNQUKGQCnUiVEVkhGOtEz3oNghvQl7T8hHvFPxoLB4xJJ7x7rH
	 WM8N0++bkM7dw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Jul 2026 19:21:52 +0200
Subject: [PATCH mptcp-net 3/6] mptcp: pm: userspace: no ID0 exception for
 RM_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mptcp-pm-userspace-id0-case-v1-3-9877f02a9bae@kernel.org>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ex3YVuaXwyzDajq6Z5anTikGQasl6kl8ydQkWXVsnR8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLSJ++676nhbnzO/oC+0MmvDZ9ifxbF9E2dmPJEJFHd+
 OzlG2afOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbS6cHwz+qc31GdvzcCKyet
 YfyyKL+lVmiOhPt9piKn+JSX/gtt9jMyPI1kunDgwtH9untqym5OChJyj7/LHSbRYHTqm7H0hNn
 P2AE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the first patch of this series, the initial ID0 address is present
in the local addr list when the connection has been created.

Then, no need to have an exception to delete ID0, this can be done like
with other IDs.

Fixes: 84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4c96433590e3..9c7fab6a59bf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -243,37 +243,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
-{
-	struct mptcp_rm_list list = { .nr = 0 };
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	bool has_id_0 = false;
-	int err = -EINVAL;
-
-	lock_sock(sk);
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->local_id) == 0) {
-			has_id_0 = true;
-			break;
-		}
-	}
-	if (!has_id_0)
-		goto remove_err;
-
-	list.ids[list.nr++] = 0;
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_remove_addr(msk, &list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	err = 0;
-
-remove_err:
-	release_sock(sk);
-	return err;
-}
-
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry)
 {
@@ -315,11 +284,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk);
-		goto out;
-	}
-
 	lock_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);

-- 
2.53.0

