Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5162EA171
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247100; cv=none; b=gqeQjuvxDK51sNirIiFmUethZrgl+gyzKLlk84wvlIX3CspNB+Rkd2Gp+XAW1YdNl5V1YWxokVqO44eRQgbC5XQ6iTfW5ABm0jFIFCEBx/bViuAGJyFjE6kg7lZpbtDYCPu6ZXDq/KzOI3kFx8PFPZFbKNaC5hb4oi820566mzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247100; c=relaxed/simple;
	bh=JfovlaL/U2Cz15YP5/ltVy2OQ6r/tYSTUof7MUBhiNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+SstAafctDm8BBD294wNS+NM3S+PmOrm4FSvrLlQbbJ+KtL0nXm5nXinnE3gI+FT8Oa3v2BjO/a3ORxsF79BpQiLLmc/eP6ycCa4OQd4FsgLitcqzn8yarNSgSs6DaICo0kskpUcP+W4srKAoTyAz6yDTtJa2EKKEvac9BUl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UluLigYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UluLigYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738E5C2BCB7;
	Wed, 15 Apr 2026 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247099;
	bh=JfovlaL/U2Cz15YP5/ltVy2OQ6r/tYSTUof7MUBhiNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UluLigYyOc7mwjzDmy+S/3gbS89HRhJU+NKMUu/lHucje7oXEyyu8wSJpYyoqLmX6
	 YEMbeLLjzsVRxohGam4al7fmTrGA8In1NFCZ1yylGNmikhT+id6KlmqKN0CVFZpfxr
	 VJQXa/qYYuVeyudfK+OYFVEJM5d9AOD3v2tLvHECcQpe0EkaHv2n7Md6fmylbivt11
	 pWWrCce9n3ovK0Ft+JNzo0tm5troZ4rejThzkLRQSmSVPsQG5Syl+A7mbPCSyL49Tm
	 eEEVQv95kYi4Rk2b12/YN4NuNRJvys0ZWHQBy0dfd9gkRV0xDu92ryEHnBL+iIZmM4
	 fRUf321NSI4Wg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:00 +0200
Subject: [PATCH mptcp-net v5 12/20] mptcp: pm: in-kernel: explicitly limit
 batches to array size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-12-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5699; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JfovlaL/U2Cz15YP5/ltVy2OQ6r/tYSTUof7MUBhiNc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ2pn1/HKtV2OWL3Ofd21w18b1OxeMv+c//jyx9VBT
 Kp/Fp3Q7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIcxIjw6PKTxW3fj6pevAz
 N/fJ6/qzogrb7WXnXJFZoHPjqKe18DlGhuXu+iu6syb/+pLU9Ocg81+ZQxzbL378dP/Y3x1X8ro
 1zjADAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The in-kernel PM can create subflows in reply to ADD_ADDR by batch of
maximum 8 subflows for the moment. Same when adding new "subflow"
endpoints with the fullmesh flag. This limit is linked to the arrays
used during these steps.

There was no explicit limit to the arrays size (8), because the limit of
extra subflows is the same (8). It seems safer to use an explicit limit,
but also these two sizes are going to be different in the next commit.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 906a1d5ab9ed..a678b1c33f56 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -201,7 +201,8 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 static unsigned int
 fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
-			       struct mptcp_addr_info *addrs)
+			       struct mptcp_addr_info *addrs,
+			       int addrs_size)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
@@ -236,7 +237,8 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= limit_extra_subflows)
+		if (msk->pm.extra_subflows >= limit_extra_subflows ||
+		    i == addrs_size)
 			break;
 	}
 
@@ -248,7 +250,8 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
  */
 static unsigned int
 fill_remote_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *local,
-			  bool fullmesh, struct mptcp_addr_info *addrs)
+			  bool fullmesh, struct mptcp_addr_info *addrs,
+			  int addrs_size)
 {
 	/* Non-fullmesh: fill in the single entry corresponding to the primary
 	 * MPC subflow remote address, and return 1, corresponding to 1 entry.
@@ -257,7 +260,7 @@ fill_remote_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 		return fill_remote_addr(msk, local, addrs);
 
 	/* Fullmesh endpoint: fill all possible remote addresses */
-	return fill_remote_addresses_fullmesh(msk, local, addrs);
+	return fill_remote_addresses_fullmesh(msk, local, addrs, addrs_size);
 }
 
 static struct mptcp_pm_addr_entry *
@@ -410,7 +413,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		else /* local_addr_used is not decr for ID 0 */
 			msk->pm.local_addr_used++;
 
-		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh,
+					       addrs, ARRAY_SIZE(addrs));
 		if (nr == 0)
 			continue;
 
@@ -447,6 +451,7 @@ static unsigned int
 fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 				  struct mptcp_addr_info *remote,
 				  struct mptcp_pm_local *locals,
+				  int locals_size,
 				  bool c_flag_case)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
@@ -488,7 +493,8 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= limit_extra_subflows)
+		if (msk->pm.extra_subflows >= limit_extra_subflows ||
+		    i == locals_size)
 			break;
 	}
 	rcu_read_unlock();
@@ -559,7 +565,8 @@ fill_local_laminar_endp(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 static unsigned int
 fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 				struct mptcp_addr_info *remote,
-				struct mptcp_pm_local *locals)
+				struct mptcp_pm_local *locals,
+				int locals_size)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
@@ -586,7 +593,8 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= limit_extra_subflows)
+		if (msk->pm.extra_subflows >= limit_extra_subflows ||
+		    i == locals_size)
 			break;
 	}
 
@@ -620,13 +628,14 @@ fill_local_address_any(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
  */
 static unsigned int
 fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
-			 struct mptcp_pm_local *locals)
+			 struct mptcp_pm_local *locals, int locals_size)
 {
 	bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	/* If there is at least one MPTCP endpoint with a fullmesh flag */
 	if (mptcp_pm_get_endp_fullmesh_max(msk))
 		return fill_local_addresses_vec_fullmesh(msk, remote, locals,
+							 locals_size,
 							 c_flag_case);
 
 	/* If there is at least one MPTCP endpoint with a laminar flag */
@@ -637,7 +646,8 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
 	 */
 	if (c_flag_case)
-		return fill_local_addresses_vec_c_flag(msk, remote, locals);
+		return fill_local_addresses_vec_c_flag(msk, remote, locals,
+						       locals_size);
 
 	/* No special case: fill in the single 'IPADDRANY' local address */
 	return fill_local_address_any(msk, remote, &locals[0]);
@@ -672,7 +682,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, &remote, locals);
+	nr = fill_local_addresses_vec(msk, &remote, locals, ARRAY_SIZE(locals));
 	if (nr == 0)
 		return;
 

-- 
2.53.0

