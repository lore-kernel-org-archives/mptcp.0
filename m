Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC231F95C
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932022; cv=none; b=fqXnVxWC9QanDLvbOTgov72ZYOJxdEi7KFQhGsIVQm/Yw+akFk9RFZ1xmPTlp92tMgAMyVOMp1SD81cxESqMowZEfYKkxt0qWx3j2SK8morlA/LFyZ5Yc9tJJcnoHQftPGj9/zRdE5OWnhKB4hDeK5AB/CHkmkyXRaTfy20YD3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932022; c=relaxed/simple;
	bh=MsQqJmsslGVp4+rpfxpVwFmErV+KJIOlUCNxL3CWAJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5Qxu1zTrVOk1PvQFPwDZKMqOKMy0eB0LZ6HNmsccChjencYSAdtA6SQAnCnysdEnEGEfYfwCtTVBwKXBcirByjbbfDj1FHuNQ2w2qx4qTgY1geNdRqPt3LuPv7IMShpZBZWZRBUt7U3CvhlEikoACy6rh/vdhcIEVCwzAbKV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F72+snhY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F72+snhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EC6C4CEE7;
	Wed,  8 Oct 2025 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932021;
	bh=MsQqJmsslGVp4+rpfxpVwFmErV+KJIOlUCNxL3CWAJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F72+snhYIylNljV2O8iw7Ma6Rxgf3dQ9uQQnsUr+M1yQ0xvf/SLf0LKZZU5blPqj5
	 Gi94RZDEXGRo6e0B+d78o/ImVv8co8vgT+e80rVysyozw4toDWSSlO0m5H/aq9mCsG
	 RgB1b9hlv4MD3tKhSkQhVY4X6BW2PymLUidah8miyJeKfInKa26ySb052rKBQt+Og/
	 qV++RGj/A+sEkEFksnrNYIPdxwTHPkuoDBRbBjF2SCCrv/ZlRavcsu7udDinhAepqZ
	 0UaPDhaHiVUY3OJsOKR80oTHVRytJHqJbagi+b5dRi5DNMSY/XYQCebBdY2/UZbhvu
	 OAk1gvRt4VKNw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Oct 2025 16:00:01 +0200
Subject: [PATCH mptcp-net 7/7] mptcp: pm: in kernel: only use fullmesh endp
 if any
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-c-flag-add-addr-delay-v1-7-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MsQqJmsslGVp4+rpfxpVwFmErV+KJIOlUCNxL3CWAJQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKe5eX95SmUr8hNDDS6rsDwfftxK7b1Z01kZqjPmPOcc
 4fM9C8GHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNhC2L4K+g0TVLLb1aKg5d0
 0a9S83nxRgV6kv6NHGtu+/c8Plh2npFhs1wYY13kv7divaaW+xsfXM5wmpn313t3G9s3oR/6XYY
 sAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Our documentation is saying that the in-kernel PM is only using fullmesh
endpoints to establish subflows to announced addresses when at least one
endpoint has a fullmesh flag. But this was not totally correct: only
fullmesh endpoints were used if at least one endpoint *from the same
address family as the received ADD_ADDR* has the fullmesh flag.

This is confusing, and it seems clearer not to have differences
depending on the address family.

So, now, when at least one MPTCP endpoint has a fullmesh flag, the local
addresses are picked from all fullmesh endpoints, which might be 0 if
there are no endpoints for the correct address family.

One selftest needs to be adapted for this behaviour change.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c                           | 10 +++-------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  6 +++++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 054d85045381..40a0572b3149 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -609,15 +609,11 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 			 struct mptcp_pm_local *locals)
 {
 	bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
-	int i;
 
 	/* If there is at least one MPTCP endpoint with a fullmesh flag */
-	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
-		i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
-						      c_flag_case);
-		if (i)
-			return i;
-	}
+	if (mptcp_pm_get_endp_fullmesh_max(msk))
+		return fill_local_addresses_vec_fullmesh(msk, remote, locals,
+							 c_flag_case);
 
 	/* If there is at least one MPTCP endpoint with a laminar flag */
 	if (mptcp_pm_get_endp_laminar_max(msk))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 78a1aa4ecff2..e7a498dd5a46 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2952,7 +2952,11 @@ mixed_tests()
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
 		speed=slow \
 			run_tests $ns1 $ns2 dead:beef:2::1
-		chk_join_nr 1 1 1
+		if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_fullmesh_max$"; then
+			chk_join_nr 0 0 0
+		else
+			chk_join_nr 1 1 1
+		fi
 	fi
 
 	# fullmesh still tries to create all the possibly subflows with

-- 
2.51.0

