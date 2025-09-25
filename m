Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920D8488
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790492; cv=none; b=t2F42sM9g8m+ldviMU5ElG4Qb0lA+z4Ddq9A5m2sGfac0P1u7H196jJA/169ZDaTFWU6kRfsDgIkNvU1l2Mr2v03SufYfFcfz4bZVte+q6tKZywFtyrk4HraoxJ4cjMFoXQIa7mVmOYSsu1m/eoA4USZEKm+ltAn6b4gvaaVcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790492; c=relaxed/simple;
	bh=2/0PjhEFbIJRwQxqp5w/H2uKVwclF8Nq+lpJHWw53ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TB+1PogV4XdD2dbxjm+UeRAqP+CzOH4c0CjV66Cb2k6AUplttMZ3mHtfHRPNzxpKwz+3wEuaeKHUk8O91cAvyuV1cXUlnQxIInrM3f/9dwwjEEXqlnvpwR1qVMUHnR2suZ/1bJUF7e37XZxPYQcjZPjKuaxgLcJVcmkXojuPz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJqT1uh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJqT1uh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC1C4AF0B;
	Thu, 25 Sep 2025 08:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790492;
	bh=2/0PjhEFbIJRwQxqp5w/H2uKVwclF8Nq+lpJHWw53ZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CJqT1uh4UaL3Wxl3s9G+9ZIavYMdq09YHkVXZ1qH/z3/l3JKupdM+HpBbiiq4l/47
	 fUC5H2337ZUCMklKdYhU8gSdNclin46vvb3X5O+NKxY7KMIE7nD1Sr+FIOZChRnm2N
	 HjJgyMmBRNVeZJR6nzhWylXySY9lrr04QL06phQiQnyv87Qn/F5gm79l/vNrAbrUfU
	 0UzT7hQXjzy1z5VCRzvE1Geaj0AvJO2UeIRkyITXjSNId2gfoQRNLZn5QWigMsskjU
	 PweN8/Jzkt6wcOZDqa4ygzSqzXyHs2xB3XnF8DDzeVYccfIsXIkCACzGPr2JgED4gx
	 tYOAJg5WBG40Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 10:54:20 +0200
Subject: [PATCH mptcp-next v3 4/6] Squash to "mptcp: pm: in-kernel: usable
 client side with C-flag"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-pm-kern-endp-add_addr-new-v3-4-1697a14ffa7d@kernel.org>
References: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
In-Reply-To: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2/0PjhEFbIJRwQxqp5w/H2uKVwclF8Nq+lpJHWw53ZE=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGjVA1SijQWSw0OMUqrEUUENg5xRwqqp9Jy9FF5oD3YwdWJWj
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmjVA1QACgkQfCLwwvNHCpcRPAEAlsSj
 R87RT2mP+W+62gxJQZqV7Zct1F0Cw/HBtgILieABANP4jr+GvwzT9WkmBt5tPdDFG0+CiAvCr6f
 iXT/1OTwP
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this special case (fullmesh + subflow + c-flag), local_addr_used
should be incremented for new subflows not involving local ID0.

Similar to what is done when receiving an ADD_ADR in the non-fullmesh
case, or in the subflow only case.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index aaaa684d86239fbfa4e237590fc274fa9b7b0347..116d62ed86f78b0242a33a67f77ff875ba00ae30 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -431,9 +431,13 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 		local->flags = entry->flags;
 		local->ifindex = entry->ifindex;
 
-		if (c_flag_case && (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		if (c_flag_case && (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
 			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 
+			if (local->addr.id != msk->mpc_endpoint_id)
+				msk->pm.local_addr_used++;
+		}
+
 		/* Special case for ID0: set the correct ID */
 		if (local->addr.id == msk->mpc_endpoint_id)
 			local->addr.id = 0;

-- 
2.51.0

