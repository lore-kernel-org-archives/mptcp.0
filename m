Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27D262BE
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055478; cv=none; b=KNFhd4ZR1pKXVkGDdCAgCyegF6vV2l9nGYx15L2YpVRENON5xp5+qMfCqhqCSZFeEUSrxpBVo2iqlqPJW4OcaRWMsv8TLo95Cy6P2/H2c7IIPUq9diaeR3bqCh7JfexOAd1wPfM9TSyCt8rhawFH+3/ucYB2iQ84VMtMh0I7O90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055478; c=relaxed/simple;
	bh=RorNkz1jeuedwSxqvJwzMrrW6rysVDqoOC6Idp34ifE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzJwGzUvh98vHfFfQdWVWrtyGwzzZrQOueNJDLzgDnSS0+czH67PZM58aZkZsN45MLWUxUHfZ0Wu1mRDi8zX1NVgoSIDnuuROhJLjvSeh6I4Qi7804V3iGS2Sn+LqrUT4+rTMC6GwmS9G4qVfF5NZOZ/yD5edK0Lw1iMD6EGl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJK9HgHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJK9HgHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639EDC4CEE4;
	Thu, 27 Mar 2025 06:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055477;
	bh=RorNkz1jeuedwSxqvJwzMrrW6rysVDqoOC6Idp34ifE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJK9HgHDOKjCK2PX8yL1zk1a4O3OSGRoPVuPxwxslwxv/4RgexSjAaDaK32ybSsmw
	 VlzqDTS9+u+UIP3/Tiw6c5dBe3KqE17qE2xBK6YNAtSDzq5HwkVQhk4E96HF6Vbuip
	 dCcfaUgXWJqd1AwJRJmDVvNVTtkoG3hN7ingQ0cxMHR/i6SRdowxa4AzbMWoWpjr8q
	 uEzFI1cQF2z2fqfSJW3GgMuLfHXlJkHVDmxuIb5uzZROsP3+1f//2i7D3QkUmsYT6o
	 /Lcwksfd1qvk0EkZLBN2SsGi+PFRKs14BP6fBhXcLKPvRWfjovUU3gN9iC17go6aba
	 JJY1AEVuHjPSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/7] mptcp: pm: update pm lock order in mptcp_pm_worker
Date: Thu, 27 Mar 2025 14:04:14 +0800
Message-ID: <739e3667698915fa690d08c751c1846bd9442df2.1743054942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Later functions that cannot hold the mptcp pm lock will be called from
the PM worker, so this patch modifies the order of holding the lock
at the beginning of this function and releasing the lock at the end.

The new order is to obtain a copy of pm->status while holding the mptcp
pm lock, then read the copy after releasing the lock.

For each PM status flag, hold the lock, clear this flag of pm->status,
and then call each handling function before or after releasing the lock
as needed.

Finally, hold the lock before calling __mptcp_pm_kernel_worker() and
release it afterwards.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c72d2fade555..1e681acaad7f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -932,26 +932,33 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	u8 status;
 
 	msk_owned_by_me(msk);
 
 	if (!(pm->status & MPTCP_PM_WORK_MASK))
 		return;
 
-	spin_lock_bh(&msk->pm.lock);
+	spin_lock_bh(&pm->lock);
+	status = READ_ONCE(pm->status);
+	spin_unlock_bh(&pm->lock);
 
-	pr_debug("msk=%p status=%x\n", msk, pm->status);
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+	pr_debug("msk=%p status=%x\n", msk, status);
+	if (status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		spin_lock_bh(&pm->lock);
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
 		mptcp_pm_addr_send_ack(msk);
+		spin_unlock_bh(&pm->lock);
 	}
-	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+	if (status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		spin_lock_bh(&pm->lock);
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
+		spin_unlock_bh(&pm->lock);
 	}
+	spin_lock_bh(&pm->lock);
 	__mptcp_pm_kernel_worker(msk);
-
-	spin_unlock_bh(&msk->pm.lock);
+	spin_unlock_bh(&pm->lock);
 }
 
 static void mptcp_pm_ops_init(struct mptcp_sock *msk,
-- 
2.43.0

