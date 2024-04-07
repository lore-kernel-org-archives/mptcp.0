Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B3A171C2
	for <mptcp@lists.linux.dev>; Sun,  7 Apr 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486328; cv=none; b=mmOBa/mJWYnt5hwi7No15z0pm2eJKbJ9vlVC8XlcYM8gVJ17HHKRMA8PMVjfVeu9j6rZ9QtL2+hZebd30RlQQATxaAv0HXtL6PRp81oW4B+4wQz/348NNxWni0IL3r8KrXpo37eTqGKmKwn8yD2AiyOu5qoot8gdA+aiWplW6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486328; c=relaxed/simple;
	bh=eSSrLw+h2+ymvm3W8hgx4e3RZcevK1hk8++bbfGpR5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N72zFVXD0fF0wg7sLNHjW6B7Tg0Jj3ptJUQVxjxhhHL4ySIrzNcHDrZ5FyWA7JLdRQgduKMlEgHll3HId3s6WF4NjE3NV5cCgnsRgu4+GfaQjgnKvAMPKrZm8eH4VazTJv077Fl/t46XgQcNWYqLEFduvrX71KeKn35b9r8RcNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2nuE8LK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2nuE8LK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CFBC433F1;
	Sun,  7 Apr 2024 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712486328;
	bh=eSSrLw+h2+ymvm3W8hgx4e3RZcevK1hk8++bbfGpR5k=;
	h=From:To:Cc:Subject:Date:From;
	b=g2nuE8LKIAy01CL4hjg/GgiSTBAkCp9VAtNJUUu8RrRv2JhC1SV4ClrvWPVAN4nSD
	 5ZQgTqfTIK0RyYfidA88P+64HzJqx8HQP1rwGOAgo6S1agOSgyh3WKZ1wkNetathER
	 lOz2CvFh5QvSIDRSENl7SkKE5Kx6iQc4SfvHADuYn0edu+fjYQzkrxxNs++Sw5z0Li
	 6bh/CGwEafehMIvr0uGdofNDAzTbZxpN5cbe/XkvCN+p6SrAN92DL+iz+wCbudmdNv
	 NWgpyGrvFhQHlKvdpTv/YEdR/L1eeKBaPLQqFX/wWuj6YOWBiaPtZoOhQZ00F1eykZ
	 tznWPG7GdK97g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2] Squash to "mptcp: add last time fields in mptcp_info"
Date: Sun,  7 Apr 2024 18:38:40 +0800
Message-Id: <7930751788d3bc8155898d4a22bdd6efca8cfde0.1712486293.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Please append the following lines into the commit log:

'''
Since msk->last_ack_recv needs to be protected by mptcp_data_lock/unlock,
and lock_sock_fast can sleep and be quite slow, move the entire
mptcp_data_lock/unlock block after the lock/unlock_sock_fast block.
Then mptcpi_last_data_sent and mptcpi_last_data_recv are set in
lock/unlock_sock_fast block, while mptcpi_last_ack_recv is set in
mptcp_data_lock/unlock block.
'''

v2:
 - move the entire mptcp_data_lock()/mptcp_data_unlock() block after
the lock_sock_fast()/unlock_sock_fast() block.
 - can't move it inside lock_sock_fast()/unlock_sock_fast() block, this
   causes a deadlock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2ec2fdf9f4af..40b262b2c24a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -896,9 +896,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	struct sock *sk = (struct sock *)msk;
-	u32 now = tcp_jiffies32;
 	u32 flags = 0;
 	bool slow;
+	u32 now;
 
 	memset(info, 0, sizeof(*info));
 
@@ -927,12 +927,6 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
 	info->mptcpi_flags = flags;
-	mptcp_data_lock(sk);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
-	info->mptcpi_bytes_acked = msk->bytes_acked;
-	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	mptcp_data_unlock(sk);
 
 	slow = lock_sock_fast(sk);
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
@@ -944,9 +938,17 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
 	info->mptcpi_subflows_total = info->mptcpi_subflows +
 		__mptcp_has_initial_subflow(msk);
+	now = tcp_jiffies32;
 	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
 	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
 	unlock_sock_fast(sk, slow);
+
+	mptcp_data_lock(sk);
+	info->mptcpi_snd_una = msk->snd_una;
+	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_bytes_acked = msk->bytes_acked;
+	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
+	mptcp_data_unlock(sk);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
-- 
2.40.1

