Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418A3D6CD2
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089527; cv=none; b=JjqzoVtGuVDKJdxauEDz2AB0NI0/nUoWVvSoMIcpAzdKx2tzi0aqRxYNxYDnLhhs3GKVVqcU7uP4w54CI2SaBJ7PWkk4h8FNqUpFo+M5nPbdttoZZzNkdGVcHp35N2x9ssOlpY9NgKe1Uv9hsPNbXj+2OzXupVTfg5VXtZcWgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089527; c=relaxed/simple;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RECmHnapVZwNaFQcIUSeOhRIGZcagu0EZBryc4qlh5Y4leSNJS59ql2to2o0bDgITnB81cXWkvPhDL6QX4cgSMk3/fC1ntNY1Gb02s56qdBIFctVLMXkxU1+m+F4ibBeoE4OYusVebcBC6HV1/hz6jnD1hdLFPKK1kgynGrSDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0HBLdnH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0HBLdnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE7CC2BCB6;
	Mon, 13 Apr 2026 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089527;
	bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J0HBLdnHXDpMXkRR2GL+hBPaAWwWnFWE9N+DqEDEnLV4pX4cmUOft5ZX24zkQI++4
	 NoQ6ye7sj2vw1dPKUkyu09FzgYSfzoeyGd6fx9+O6FFnP7rhQEowgtaPXyr1AMwwCh
	 ijCSLjrQ6B1vMmmrWP3JIC7kM1q40JiNOSVg5TNoO7u8cS36JpdlgLzXOEUmUsH5uO
	 ofDjYlFSvyzlwpwP0z7d4D1d1X7ZeHmYtLKaJoEemwKKlWFkOR4q1xtVNfRLcSiA7v
	 M9JIz4XtaJ+YNDdyBH6AhuxoB3MeRyt/wmjY6cbMpl7WUtebrIgyiQLkC4JCVmAxtv
	 i8NhfQsMrKo5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:47 +0200
Subject: [PATCH mptcp-net v3 01/19] mptcp: pm: kernel: correctly retransmit
 ADD_ADDR ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-1-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qU2gO4U+rLHR/oV2lgldodaiCkxfghI5r1NFCTslTiA=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGnc+aigg3aTfs0T61nYyEZay9FeaWr6dcAd31i0bTEuh9qKt
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmnc+agACgkQfCLwwvNHCpez7QEA++Tf
 oE0efvR/ofYyU4S40p/quD/76GBsZ4mObv+nYGcBAI+5ocTRCEwOn+lEVMfAdEXhjH2UKKNQfzu
 kGRdSk38O
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When adding the ADD_ADDR to the list, the address including the IP, port
and ID are copied. On the other hand, when the endpoint corresponds to
the one from the initial subflow, the ID is set to 0, as specified by
the MPTCP protocol.

The issue is that the ID was reset after having copied the ID in the
ADD_ADDR entry. So the retransmission was done, but using a different ID
than the initial one.

Fixes: 8b8ed1b429f8 ("mptcp: pm: reuse ID 0 after delete and re-add")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7895fb5f982e..906a1d5ab9ed 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -347,6 +347,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < endp_signal_max) {
+		u8 endp_id;
+
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -360,19 +362,20 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
+		/* Special case for ID0: set the correct ID */
+		endp_id = local.addr.id;
+		if (endp_id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
 
-		/* Special case for ID0: set the correct ID */
-		if (local.addr.id == msk->mpc_endpoint_id)
-			local.addr.id = 0;
-
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_addr_send_ack(msk);
 

-- 
2.53.0

