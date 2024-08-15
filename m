Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6A149C6F
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754769; cv=none; b=cADUOaoYcc0eDQ16xzhnI4nXHcanqUpCnKPcYelgZ9/vBH8wnV2mlX9lzlYXAUiox32UWyVySeeX4UxWNpLOnYVOdV1cuCP1NbIZg5TFni+WEBJJm633uVIswVSM9VYYdWk9ePX6bHpgOHFVFJobpoT9AjgBFmTuf/fD5olzPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754769; c=relaxed/simple;
	bh=CY/dBHTp2w67SptUG1aeyE724qNvFJ0H98mr29KmlwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVNZf+jXIYax3j/bjcvtxPDJO9w+AvyWp4MFYNt2kW4Z58wGJoONVt8zqrvRsZFki4i77p/aWoaXk9SvH48RCsSYVmHTzWYFsj1O9UqnioiXLAEHFXbSPv5bas046+LtzGxTdx1tzFNSetvToWsdBO0EnhBVBdq3A7JVM+UExNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErvklZJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErvklZJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39391C4AF0B;
	Thu, 15 Aug 2024 20:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754768;
	bh=CY/dBHTp2w67SptUG1aeyE724qNvFJ0H98mr29KmlwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ErvklZJ0RhfY85S9oSmUkbIf5k7GNj4BY58rcYyxm+9qBYGH2sLktsCVaxlhoJK4S
	 3aS/ZZUntoOyCHtEfz9V0d0wpMdDUmomkw/rZ4XZiFFtPsxn5q8bvWt/1HaHzV3MSZ
	 kufOVAH+VbyK1YI5CSIBEtpYwOaPe9QP1o1M0cFMf0aT59M9Ln94/myE/wAYgM1wOb
	 GX+EuPI4rBUGOLjpzptU8uE/CWcZYq6stDd5IN2OlL28UGcy/N7owynl8cu73emn+H
	 BDF45zxwCMmeTXH+P7ocyOOv4HIa8tJMr7pJlb4Qve6SAHerIrqGskw4VYUWoF+UPb
	 fWkeTkKZet0cA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:46 +0200
Subject: [PATCH mptcp-net 05/10] mptcp: pm: fix ID 0 endp usage after
 multiple re-creations
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-5-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CY/dBHTp2w67SptUG1aeyE724qNvFJ0H98mr29KmlwQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJHAAv9Oiv7ndOxc2YD4erbLW3/OFNm/kXO
 Ng8MFqzs4GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c9gvD/9bKWTYRimQ7YocAuySKT2WZrfeHOEy4xaINOcQzdnqDCvRaNET6Hh06cGicKchJlW3JPH
 b1YSpTBAXSIFIRlsH5rpmhwLbEN4W8ygA/xzUPe4IoICyUQJHPGZO0T3UpdBxuKeBjZta6GFyFT
 mAYjSWQeBaiWMFexoko8+ImzKzPTZdRz3CI2q4G7pXeJuE0kU+UnyUTgi6r8ZPAL978nz3YlpFS
 Yyc/dkkiPcCy1XL5FItgf5sqaqm7sTBYl6pPwz5FUzxHWMUVDPA37VYtsOUVs7RL8KHbghUvrq1
 MFVmdMuBraoV2kDIfbUy83s0Bha+8rQHDlISEGBJlwhr7YZqCLjVeeh5fwnUPR2mpLN9B9nBWTc
 k3oRr/9eFUj1Whk5L59K4K8voIluh7/IR6sTJLzLT5gQ+mP1sk8cBf+9GGkCK8cghKYU8YfPzy3
 8c3Jybxcp/T7he5ncc0VdfU81OuaTW3GjWTX9lOBHwA96eCGhtqyXPxnE55jVtI8FLqDI4E5rk9
 vjQ3XQ9t9bWVrnQUcjoQNnS+j6BNPUUlhnibdU0f4QBx/gh1XBEFafvLY64srYG4VosMsMYi+53
 VYFZ2n+yKq1RgqAAwnFIMC/Ksr7Oa0TmPGU9mmHakj5vpDPCTD14kO4njT882CLikf1pQuHdzbW
 hu7A64VNk3E4vag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'local_addr_used' and 'add_addr_accepted' are decremented for addresses
not related to the initial subflow (ID0), because the source and
destination addresses of the initial subflows are known from the
beginning: they don't count as "additional local address being used" or
"ADD_ADDR being accepted".

It is then required not to increment them when the entrypoint used by
the initial subflow is removed and re-added during a connection. Without
this modification, this entrypoint cannot be removed and re-added more
than once.

Reported-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/512
Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7ca9dbbd5f14..e44f539e6a56 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -619,12 +619,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
 
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
@@ -754,7 +755,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		msk->pm.add_addr_accepted++;
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);

-- 
2.45.2

