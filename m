Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD23D5C26
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092130; cv=none; b=sbiwkRKxbtIGOOr+1qlCy/TBlWPTO8t5YrdfKdqD8iw8fYC+31UOOZdf2yU7I8DZ0lej68VQ9/9DbySZWhHDITPX7gbzAx7kHYf7YdirVvTKOkBqUb5SPp6OwJnpjAlLgQ/P7yxaCJTOQJAw3q+WOhpdE4G76oOau0gzz7DLrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092130; c=relaxed/simple;
	bh=oXhP65Bb6c4I6YfmJ91tWwg67ouAQLd+6zEA4qz/GUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNhqHYpcDOSHbG8J4QxW9+Tg29huYOMOLghA3yoaTN9dIWnK8wdtyi3WC12pBYJPigMUpFhThnNQJKk9sBOrKhKJ9VOgY4FAe9GIU8vmtm9699CLvbcyIRvZNJGi+u5+XKDb2r2RhiASAVg2OE/YW/icrJid/oHk7fC90ewKgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbNmjb0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbNmjb0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C051F00A3F;
	Fri,  7 Aug 2026 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092124;
	bh=TEBtzxY2vVmIXtmIiWIfHCAIsc2I8Rs/XDueGFwVu4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QbNmjb0tCKDAF/kquBZSq1UjOO4b5/a4e2gtQCJucQk077bDfP9dSwOfltgNyJO/m
	 2Z/p5LGde9Zlbul/ZrQOBAh/Ie9MueBKMH2YMgcrO7hDxykInciUVexGiDQshohPF3
	 G29xqZh8nCraovYhV42SHCC9bPDSnYC7/OIhe2lxIyxikSNxcXJV5YVbHZ820f12Xq
	 oZPctql/XYGi/X6Vc1f73jsC5YeTqCSARrl97AW+04tag+RZ1NKq2yIgDx0R2eurGc
	 7xrTZ4axeTz3RCIcHh8e9jkFo+jPkSVWOPGVzM2pgiV4gyLbEton8ZULx6huockGFm
	 +uzUONC6VQzSw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:52 +0200
Subject: [PATCH mptcp-net v3 5/8] mptcp: pm: userspace: no ID0 exception
 for RM_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-5-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oXhP65Bb6c4I6YfmJ91tWwg67ouAQLd+6zEA4qz/GUk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZ4Uw7ZGMElY7rLJS7neUpOtJg0VBU+6Gln1ecXzRw
 4WXT8tO6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIrjPDfy+exmYrw+rvug7V
 k1d86AopeeWnzm0+c/Yxkc49x3Zp/mf4nzt7s15ZPPNqqzcREbrNy/RNb74P9fyedLAg786zx/c
 q+QA=
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
index 2c13c6273ad3..87f044735c59 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -267,37 +267,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -339,11 +308,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

