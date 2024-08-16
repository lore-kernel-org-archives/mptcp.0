Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F07817
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806133; cv=none; b=PFdPvJdLur0D+59GEXTJlJJdNAcQ5mBP6+zy3rAkM5n168kgH4zDEcAFMtOLNtD8JhBDwoEaACSWkUb/8IPimFY7ePA8IjbdpAF4uGfgrRWvwkdEeG7dSnpB3XI3/WcuB84oKkZJEZtu6EFcEcrcYxIQuzOLWrfXhATReAxR6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806133; c=relaxed/simple;
	bh=1yncGT3b55dm+a3Yu88dvG3n/OFXQHesEWhO1+HNfT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ol+oUZLh7LhgiplRzJIDlEdFgNeEC7gMgmDGMBJJI2M1anRaV+ZFhWFE1EldA5hEO/6TNuERZfsIltK4ghe+Ukj1s5M/zyCN43jdKtqKR5lOcGqRGiJwSUvHZBmIcqBIzohvnCqBnqa+Pm41unZwThjGXGzJpNVGEQqFNUIGPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9VRNxmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9VRNxmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C76C32782;
	Fri, 16 Aug 2024 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806132;
	bh=1yncGT3b55dm+a3Yu88dvG3n/OFXQHesEWhO1+HNfT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I9VRNxmxn+jFjiFAQbTkPKTu/WSUATNvjs+0bmxlbT5M4SBzFSfMVv1OsIbyw2F9f
	 WFwUuk8GYJeHCEf3OiV/SqZqFU42j9U3GpgaG/4qhTR3gyKvmr2gn6IwzzJDNwEUUv
	 9k25ApTeRWKJav71qATWn4zVhEx4I0qDtGx9q1kPAQDiw5W2KFxjQsquJ8kDUxDv1T
	 TCz8JFq+tN3gfu2HKR4QCcaLphggvpeR9bNn2uBccc6mQXtY7nYW7Yoz0H5blamZJo
	 QdswWwritmzl42rpTaKc3t/eeqWIV/4V0PyDYX2J1oYAVzxpMaDgL/UAlpvTCCu8jS
	 D+WyT7zfwoUFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:01:58 +0200
Subject: [PATCH mptcp-net v2 04/12] Squash to "mptcp: pm: reuse ID 0 after
 delete and re-add"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-4-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1yncGT3b55dm+a3Yu88dvG3n/OFXQHesEWhO1+HNfT4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGux3lMFE0rporNgkmfAdvlsMM4Lrwwu63E1
 NDM3vKAVQyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c7rzD/9n4aRqKfNBRq44ZXGwlOdkum0NuZb5mbaiVImMrBwRvAMvFMMH/lg2waNEx/ULg26zwHh
 jctm6Z2P8Bw4PZbvGRyHGolFq1Ts2wue3WOQ9XgJ9owzppq5tl5EMMUwS0/i/MiZC50DkJzoH7E
 Jb+vu7r/UT5xdcEEwzOl1yGDmZvLL0D/8DnI/q9pEZTx5svkRhifIT0HVyH9seFHsDMMLITAG+N
 rtufUoB3u/cgSA4OU78+gwmB4H7uXqsOqCnZb6IQks7BqGE/upU+DeJ1l12YF1NYpLKAXezoo5x
 rBX3tTbxRrhHhTlTHEBt8halrMMZZj908GVLwFjvuSXxE+IfimfoiZFkMYhi6eK7gXpHxBSNDNA
 BQmiy4m99hdJDZJPf+5FM0drHcWhC8IQSSHAOiswtG8WgyeO/4M/iI9aguDlUZzEICU8pgaWcL1
 s7czOBNtdZ5wbstm44/9iRI97IBbenV01EUCuD1+rjbKd6qq96Pcy7gjDlMT8L4IRZy1ix3/WC/
 ljygSaeWNQj6UY/lkW4bNRto6kTRkCzWPw9BB6jWQl+KDklRJi8H2AdZJ0muElarrXN3O+FNkKN
 cjauEQRt+/bF3gi6tasqWRkpORgOtVK9dlYVhHePqjQ5I8Cc5NRcq7ZGwpwaGJkoGXiTDSK2KTo
 sSlwTAkYsPG95UA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Set the address ID to 0 before calling fill_remote_addresses_vec(): for
fullmesh cases, a bitmap will be created after having looked at all
subflow IDs matching the local one. The ID visible on the wire (e.g. 0)
should be compared to, not the one of the global endpoint (cannot be 0).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3784eb5e2044..eba3c0e2ec0d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -621,14 +621,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
-		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
-		if (nr == 0)
-			continue;
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
 
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
+		if (nr == 0)
+			continue;
+
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
 			__mptcp_subflow_connect(sk, &local, &addrs[i]);

-- 
2.45.2

