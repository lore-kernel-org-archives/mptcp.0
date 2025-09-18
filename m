Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C0821FF3F
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217366; cv=none; b=IH8xXs67q9e4aNPC4/cxvOqdEYaAc+ynizq4RnD3fLqm+81Kg9t257jzWcs8Irvx21uit2B/wbtiaCYo8KYIT1tj08x47JOmyS/OLQcgiWzPdycfGp57T0bENl33xbbrAhHxMDgvkJf/8DVZuNyBzCcgkAk776zYiSY/a5GS0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217366; c=relaxed/simple;
	bh=cbCG/1K5OzTY7xPIDqad/m51Ubh1XZYoWsFCaY4XB9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8WDbJvSdr56/JTvd+p/HEolioWcuXXx3+iuo2RxakypVqTMQnf++QQ6qKuerYx6bHbICKXHjZRVvFlxnlT7Luz6rJEJDUEipyoCjtQSZlIz49riyjoy2XUlMqD6MzjOw3u/lJy8TajYgzFKK1DvgmjH1Xc8vGke1nbahEu4OkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds0Oq6Xt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds0Oq6Xt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FCCC4CEF0;
	Thu, 18 Sep 2025 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217365;
	bh=cbCG/1K5OzTY7xPIDqad/m51Ubh1XZYoWsFCaY4XB9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ds0Oq6XtFJAsf1cSJlVB1FkfF5qpmvjkJzlcSr2ZURnZzixhV6ofrcGetTiYlQFcb
	 nKJFnQ12H030RCJgkoQr+HeHebNtBjIH4kdCdgo74l11vs+uP3HDL4e0JBZl3dg4d1
	 Pyxfi7lM2s9lw2uXEGrlVgvs2tYCCQFqQo+TsDgoSrEOO+IY4ETHSCTX2DbkGDuyDN
	 Ajt2w/QNOKLyO9okUYlqtklJcXO0XKFSYiD/4fZT9rlLDvbONDmclSKi6vPRfGombt
	 sjsdoo8KzYQOPBSh5fpbZMvqqVI7bBGZkrhsGXxbMrxNaMDU7PGJtSQpBfo+9PbVVR
	 Jv5eI2astc+Ag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:19 +0200
Subject: [PATCH mptcp-next 03/10] mptcp: pm: in-kernel: refactor
 fill_remote_addresses_vec
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-3-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5141; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cbCG/1K5OzTY7xPIDqad/m51Ubh1XZYoWsFCaY4XB9o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuHSEW3mZ/ZTn0F+967P7rY0rTlstmykm+O/Ho6caR
 ++cqBP27ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIpCRGht3sHan5V/7NX1V7
 joHr9ub/Ob3zuPmbJtkGr5/SMFv97iNGho6OrNYls+4/nXv/IV9ce7v7Wo6t8Zs3Tnd7kcSbULi
 nnA8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, this function was quite long with many levels
of indentations.

Each case can be split in a dedicated function: fullmesh, non-fullmesh.

To remove one level of indentation, msk->pm.subflows >= subflows_max is
now checked after having added one subflow, and stops the loop if it is
no longer possible to add new subflows. This is fine to do this because
this function should only be called if msk->pm.subflows < subflows_max.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 112 ++++++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 5bdcfcc26308841c49375ce35205097f30592279..8d5df9b98589e5cd69f16dc54e9140e88a1835e2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -159,74 +159,88 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 	return found;
 }
 
-/* Fill all the remote addresses into the array addrs[],
- * and return the array size.
- */
-static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
-					      struct mptcp_addr_info *local,
-					      bool fullmesh,
-					      struct mptcp_addr_info *addrs)
+static unsigned int
+fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
+		 struct mptcp_addr_info *addrs)
 {
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_addr_info remote = { 0 };
+
+	if (deny_id0)
+		return 0;
+
+	mptcp_remote_address((struct sock_common *)sk, &remote);
+
+	if (!mptcp_pm_addr_families_match(sk, local, &remote))
+		return 0;
+
+	msk->pm.subflows++;
+	*addrs = remote;
+
+	return 1;
+}
+
+static unsigned int
+fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
+			       struct mptcp_addr_info *local,
+			       struct mptcp_addr_info *addrs)
+{
+	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
+	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info remote = { 0 };
 	unsigned int subflows_max;
 	int i = 0;
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
-	mptcp_remote_address((struct sock_common *)sk, &remote);
 
-	/* Non-fullmesh endpoint, fill in the single entry
-	 * corresponding to the primary MPC subflow remote address
+	/* Forbid creation of new subflows matching existing ones, possibly
+	 * already created by incoming ADD_ADDR
 	 */
-	if (!fullmesh) {
-		if (deny_id0)
-			return 0;
+	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+	mptcp_for_each_subflow(msk, subflow)
+		if (READ_ONCE(subflow->local_id) == local->id)
+			__set_bit(subflow->remote_id, unavail_id);
 
-		if (!mptcp_pm_addr_families_match(sk, local, &remote))
-			return 0;
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
+		addrs[i].id = READ_ONCE(subflow->remote_id);
+		if (deny_id0 && !addrs[i].id)
+			continue;
 
+		if (test_bit(addrs[i].id, unavail_id))
+			continue;
+
+		if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
+			continue;
+
+		/* forbid creating multiple address towards this id */
+		__set_bit(addrs[i].id, unavail_id);
 		msk->pm.subflows++;
-		addrs[i++] = remote;
-	} else {
-		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		i++;
 
-		/* Forbid creation of new subflows matching existing
-		 * ones, possibly already created by incoming ADD_ADDR
-		 */
-		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-		mptcp_for_each_subflow(msk, subflow)
-			if (READ_ONCE(subflow->local_id) == local->id)
-				__set_bit(subflow->remote_id, unavail_id);
-
-		mptcp_for_each_subflow(msk, subflow) {
-			ssk = mptcp_subflow_tcp_sock(subflow);
-			mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
-			addrs[i].id = READ_ONCE(subflow->remote_id);
-			if (deny_id0 && !addrs[i].id)
-				continue;
-
-			if (test_bit(addrs[i].id, unavail_id))
-				continue;
-
-			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
-				continue;
-
-			if (msk->pm.subflows < subflows_max) {
-				/* forbid creating multiple address towards
-				 * this id
-				 */
-				__set_bit(addrs[i].id, unavail_id);
-				msk->pm.subflows++;
-				i++;
-			}
-		}
+		if (msk->pm.subflows >= subflows_max)
+			break;
 	}
 
 	return i;
 }
 
+/* Fill all the remote addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int
+fill_remote_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *local,
+			  bool fullmesh, struct mptcp_addr_info *addrs)
+{
+	if (fullmesh)
+		return fill_remote_addresses_fullmesh(msk, local, addrs);
+
+	return fill_remote_addr(msk, local, addrs);
+}
+
 static struct mptcp_pm_addr_entry *
 __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {

-- 
2.51.0

