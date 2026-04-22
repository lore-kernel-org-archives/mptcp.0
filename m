Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F2B37DEAA
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876051; cv=none; b=Wb+FImxAMpn2rgNGnzwe6XvViiW9n+gba+nfDDfi/L3gi6JmqdmRC0o1p5uX0BwH6At7digbt6I2YS8VEyzlC82S+lcP2Ju2kaHmuG18Rkv6qRVMeiYQU9VJK0sGSvq3A5g8vNvIqVtFIE4evD+ruvG7+ADjCAvV7mxxovOSEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876051; c=relaxed/simple;
	bh=JfovlaL/U2Cz15YP5/ltVy2OQ6r/tYSTUof7MUBhiNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bd4pR2e/TWocesqFOce+0FY5UH1TEaJk+TF2vFx1fafhL4WweDbjlzUItezJ1tFrkK7WHExOOfv8PXPF2WFLj1R760N8Ojs5A3FO1Nu/Ul0JoFzXN5eZsQQxVpKDMotTVjA0a+Ew9TtGtBS479j83tsmmjoewU4NvT1n5UFUnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTy/TF1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTy/TF1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8187DC2BCB2;
	Wed, 22 Apr 2026 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876050;
	bh=JfovlaL/U2Cz15YP5/ltVy2OQ6r/tYSTUof7MUBhiNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RTy/TF1khsOurjIOYwwhNCjTBmhs3lW8SXYlHtsdbps5/tYqQAOhcs5NnEqjQbRSe
	 9YoEHawzuGyzXL2PybR0E+pLT9X7KvYR4C68jV7h5+2atKJiLQ8aDbWs46r6ysiiwP
	 Vy2LfZArkKjU14rJnjSuvnKSBCmQCf5/9LtwexsQi9uckqfrisir+gkHO68lBuw1oL
	 8V+mh05OsjClI7VjyG/mgXyqmKoE1GZ9GHxGKJQNVUNbb1tu0KzA5QEbyiarsV85N7
	 ii3MAfvH6Lq2lN1lQmMQqz1i7fksQibSQykEN58WbSAl6UrIWgAC4nicxpIoN8xtdq
	 bAk/iuNbM+4bg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:26 +0200
Subject: [PATCH mptcp-net v6 12/19] mptcp: pm: in-kernel: explicitly limit
 batches to array size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-12-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5699; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JfovlaL/U2Cz15YP5/ltVy2OQ6r/tYSTUof7MUBhiNc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GK+Md/hpmjIP8aUIy9ubT2VHbug9urnpPd1abIpj
 EpZq2b5d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkp4Lhr3xpppvhStf8u288
 LHi7suzro8XT705dmcprUHx+B3OZKsM/HT2Pf7uqslQ9g70kpuV+TjT68+/Bhpo651X5YZ883z5
 lAwA=
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

