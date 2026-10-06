Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAB3D75DE
	for <mptcp@lists.linux.dev>; Tue,  6 Oct 2026 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287062; cv=none; b=Z6ND2tDYCmR1v5ovph/ZYBTp7R9hc0g9Vyn/JQcWEFavU69SNkIGCk6owIPUTR3a/pAM65ERVpUdayXwneJBrZC28VIMGRMmzEoQk6ajVm4PzxNygwDmTww7cEQTIZJhOdCR1+ZA0ACsnaRcm1lvXj/JvHlQUE9eiDzd4laqWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287062; c=relaxed/simple;
	bh=kKA4kIe5JolGycpkyJbbWIEFH/qK0xn9VlgvCZWhNOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFAaKyL3uw9YOPQTEfDbtaZh+VDHiOkM/0jnmROnAkIio/etzuS2vjlukGVEk6gQl4GYm6H1+37QsNUfYhDyyuuXxoiREDJ1ymNyTvfw/gBGCYO+XVti1uwrno8MSXfIcSI1i4ldojKk8gX+tUSjBeGwLTmdT4hr4uiiSXZSeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSdw9UAu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSdw9UAu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e576377715so12394365ad.1
        for <mptcp@lists.linux.dev>; Tue, 06 Oct 2026 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287060; x=1791891860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bqr7EFo80tshg+V79KvdmIRlvhDOgHoI6OjKUQvN6to=;
        b=eSdw9UAu8FbpwwWv9tHdLglTdf/FZbW+KqJQop+DUlXtB6c/elLY/BYZR3/yUxOSKA
         idkWZ/+TybvODjVjBC3OA3DogzFOU8Tmkivtqc4C4CZn/KhNnLpNLZeSYgNCGJ2uIdHr
         I41WWnAZH7gyU6DQ7MFfqzSA2YouvBLMFH2GzMS6OBcArK/3PYlMlLzKUNxjcAs0Nf9E
         tQcbASNjtqTIIzUN+P+G5g0fRk6rfiFZfx+CmIKxHnIrSqnWfykgC2at0ujPCAQXeLmI
         Os/9c7XsyF/2jtwdHHR00f9Vkz7dYbD46s2xIvWOxKRDe2bqw0wWLke/OKUaupAI1mzm
         O+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287060; x=1791891860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqr7EFo80tshg+V79KvdmIRlvhDOgHoI6OjKUQvN6to=;
        b=2rEJosUhO0HAJUueWOZEZ7ZrMKJAOkrNyq/t3sJFgb/i6FLqRFKMpQvQxWw0kDPoE9
         RE3Ll5hflKttVChl0RgdLCFkgtCVDxPM4KQBw216u2X36p2FCDDtVOrvFHAeCLCMPoMG
         GsAyi8QE6zZ4XsGmoKRjGEJJJ3+qeKBweeM26pbp1vjb/ataXFROpqrtDJIvC8gQdEca
         XNI4LY6ZO3qAVmuh/ncOilWgFanPNrXynzM8zCrK9Aoa1YLHeMCThsb1sDuLGisw67k0
         5CqxqwlIMXrfepb4HOvpmX9UPyyoA9Em4Mcetj2bgg64bFf/l43tQGxuCvnk6V9plHct
         KQWQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1rBKhJ/1yaHKzcE1NL/6Icpws/Az5X6Ai1DOFh2aOSxBd3N8i60tPg12GqjhaZotl8W0sxw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJpb90pmdq1IuS+b0zMosIO795wqZIMTO/FxnyFpEAs/u1Z4UL8
	jQDDbZQajfrkyxlHUbcmnMZ9EjYsXgy+YEIpKj8cCOnxTUKiNRc5bFmE
X-Gm-Gg: AYBFou23mhgIMPitmUL+DyKg6zcC6LZyAMaN3rmJwJ3wTBhc8YN/7gN8nhBpA1Vhqht
	O3HvWKPXeGyQVI4MJPqXiNzmimYbSM1YBsjD81vPRqSbfffnAbSt+rQ1adMZAr/pA3Sf7b5B+xi
	uFtYp/+BGKNToWlKAYxmy3w0pZu6iCU3/CVckraC+yyhPbwA15eAEG7Mpte4dIFJYwmQYr2nqEu
	FZf+S7cIpdJQZJ41yzlr/cuA34IIJjqf0RkNUd4RNprojgxfeCGIBGpjNDyR1+SWkCkuFibmMzB
	8tqie2XPFmGpdRjAEZMm9/iR4JUUm3IfTZdvs4XX+3wrxoVukFqr1GqnI/DgclME/TIDgiwS1cE
	Kn8s7mW8n3L8GVFJF4qjJyjkwfvzGeK9BNAnbDgiN5OosW3a3tG08qEFRABdr20mOBRvYtmaNmj
	DnYiaQ3qTR1i3xrp6oH3ZmwfxCUwsJkvI2eKl2PW7JkuIwZzIsZsaeOAwLhOqzb9TgyXn85tWnw
	kuAMu4M1EZBSIr7kUhzeKiDsekBe0/ZFipcRzM=
X-Received: by 2002:a17:902:e54b:b0:2e2:be61:a882 with SMTP id d9443c01a7336-2e5dcd90aeemr10289505ad.11.1791287059556;
        Tue, 06 Oct 2026 04:44:19 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecf461sm20805515ad.53.2026.10.06.04.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:44:19 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: security@kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	yimingqian591@gmail.com
Subject: [PATCH net] mptcp: pm: in-kernel: fix C-flag endpoint accounting on family mismatch
Date: Tue,  6 Oct 2026 11:42:27 +0000
Message-ID: <20261006114409.117190-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fill_local_addresses_vec_c_flag() clears the endpoint ID bit in
id_avail_bitmap before checking whether the endpoint's address family
matches the remote ADD_ADDR.  If it does not match, the loop skips the
endpoint without incrementing local_addr_used, leaving id_avail_bitmap
and local_addr_used inconsistent.

Removing that SUBFLOW endpoint later calls
__mark_subflow_endp_available(), which sees the cleared bit, expects
local_addr_used to be non-zero, and triggers a WARN and, with
panic_on_warn=1, a panic.

Keep the endpoints that are skipped during this specific C-flag
iteration available by tracking them in a local bitmap passed to
select_local_address(), instead of clearing their IDs in the per-socket
bitmap.  Only IDs of endpoints actually used for a subflow are now
cleared and accounted for.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Cc: stable@vger.kernel.org
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
---
 net/mptcp/pm_kernel.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a77508132354..a5952dd0ae125 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -120,6 +120,7 @@ static bool has_subflow_daddr(const struct mptcp_sock *msk,
 static bool
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk,
+		     const unsigned long *skip,
 		     struct mptcp_pm_local *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
@@ -135,6 +136,9 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
+		if (skip && test_bit(entry->addr.id, skip))
+			continue;
+
 		new_local->addr = entry->addr;
 		new_local->flags = entry->flags;
 		new_local->ifindex = entry->ifindex;
@@ -401,7 +405,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		if (signal_and_subflow)
 			signal_and_subflow = false;
-		else if (!select_local_address(pernet, msk, &local))
+		else if (!select_local_address(pernet, msk, NULL, &local))
 			break;
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
@@ -574,22 +578,28 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_local *local;
+	DECLARE_BITMAP(skip, MPTCP_PM_MAX_ADDR_ID + 1);
 	int i = 0;
 
+	bitmap_zero(skip, MPTCP_PM_MAX_ADDR_ID + 1);
+
 	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
 
-		if (!select_local_address(pernet, msk, local))
+		if (!select_local_address(pernet, msk, skip, local))
 			break;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-
-		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote)) {
+			__set_bit(local->addr.id, skip);
 			continue;
+		}
 
-		if (local->addr.id == msk->mpc_endpoint_id)
+		if (local->addr.id == msk->mpc_endpoint_id) {
+			__set_bit(local->addr.id, skip);
 			continue;
+		}
 
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.local_addr_used++;
 		msk->pm.extra_subflows++;
 		i++;
-- 
2.34.1











