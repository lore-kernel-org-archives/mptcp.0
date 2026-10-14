Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A84D9F93
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983305; cv=pass; b=ihZU4/ODBRlQC1n+R11V2B2GK5yg5V3+3z79SERY5O9M3PwCGwdq1l+MHahIhpr9lllTd3b3UQ6CW2UoSh6vk9cBr2ZVaewCDIEXVsBmPNwwxzVx0tQeI0MENHmCVbO3rzE6BkOgeqyo42joTVWjRIcD6H4LJK04ckm7DjHDIs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983305; c=relaxed/simple;
	bh=zNpbHZrZoMUZzQYPko+fEe/e4SI7bhgCMd3gWPijZUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYl4rn+fltX9ZI19KJ52A5wXUO7YhG5EXqJc/l1dp2geXX5WXGFG+vrDAHyqkeN3R/+OTKOdrDR3Dze8sGYFwDbol456gBSHExHeBkr09mcdSfNFEtBZQnzoiTuIEyd6SE/iGtUoGsb4328Km4mu0srmsib8OSGwAHv48nGlXxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=W3KdizHy reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="W3KdizHy"
ARC-Seal: i=1; a=rsa-sha256; t=1791983300; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=elJwlJribRfdIPUc06zh4Xd98lQiuEpPh6jUXmZ0z7e7dousi1HM2Yo+sKuUXnQqPqCJGNbOu1gatD7tw4A7V6U6XXed34jKNzu6veGpfVlWDbbKpI5ty9xVUAVBhH8O2xMY6cvd/0HUbEb+/HpO+qyx86466R8T9UWJrdAWBJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791983300; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jN8vCQMOOk0kXcBOfjkQHWInlYZ/y726M/81sXlBrDk=; 
	b=GV4viUnC4nH0kpxoafRUeQD1O3K9s0T/TtD4IRe8BiQUUtHE1xhRO+8RDlHw6bWj4PN77jT+3dbyMdKCPAI3iDxTrTaLGV/F+wfV/60ClTIz24bHVxB6vxFwTgLFUiH2Ua7ohiigmIt8xp6kWzWirYQLtr24Tq3YomhRC8+JCOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791983300;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jN8vCQMOOk0kXcBOfjkQHWInlYZ/y726M/81sXlBrDk=;
	b=W3KdizHyar/O74+PClqlRODkFT4yZIjMgJc2i1dfs1TJCJC2tXTQbthBvdGdKOZU
	b4uPa3bgtXKRUG0lS/yKpP5MMHHCJOh/r+XpiptxmAqwoINNQVNas0xo+nnoKaFZCT5
	GI9kdqmIgNQNxGcG5xVlcu8+nF6t8jZpSXZVHfHo=
Received: by smtp.zohomail.com with SMTPS id 1791983298373325.3490278306999;
	Wed, 14 Oct 2026 06:08:18 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net-next v8] mptcp: normalize seq numbers reported in mptcp_info
Date: Wed, 14 Oct 2026 18:38:09 +0530
Message-ID: <20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The sequence numbers exposed through MPTCP_INFO include random initial
data sequence numbers, making their absolute values difficult for
userspace to interpret.

Report write_seq and snd_una relative to the local IDSN, and rcv_nxt
relative to the peer's initial data sequence number.

Read the sequence baselines from the subflow context under RCU, handle
a missing context, and skip disconnected sockets. Publish
remote_key_valid only after initializing iasn.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

---
Changes since v7:
- Return early for MPTCP sockets in TCP_CLOSE state.
- Access icsk_ulp_data under RCU and handle a NULL context
  when obtaining the local and remote IDSN values.
- Zero-initialize the MPTCP_INFO output structure.

v7: https://lore.kernel.org/all/20260930102804.2796208-1-kalpan.jani@mpiricsoftware.com/
---
 net/mptcp/sockopt.c | 37 ++++++++++++++++++++++++++++++++-----
 net/mptcp/subflow.c |  4 +++-
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80cb..c441c49e7f5f7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1046,7 +1046,10 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
+	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
+	u64 local_idsn = 0, remote_idsn = 0;
+	struct sock *first;
 	u32 flags = 0;
 	bool slow;
 	u32 now;
@@ -1058,7 +1061,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
 	info->mptcpi_local_addr_used = READ_ONCE(msk->pm.local_addr_used);
 
-	if (inet_sk_state_load(sk) == TCP_LISTEN)
+	if (inet_sk_state_load(sk) == TCP_LISTEN ||
+	    inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
 	/* The following limits only make sense for the in-kernel PM */
@@ -1084,9 +1088,23 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_flags = flags;
 
 	slow = lock_sock_fast(sk);
+	/* Hold a reference to the first subflow while accessing its context. */
+	rcu_read_lock();
+	first = READ_ONCE(msk->first);
+	if (first && !refcount_inc_not_zero(&first->sk_refcnt))
+		first = NULL;
+	rcu_read_unlock();
+
+	rcu_read_lock();
+	subflow = first ?
+		rcu_dereference(inet_csk(first)->icsk_ulp_data) : NULL;
+	if (subflow)
+		local_idsn = subflow->idsn;
+	rcu_read_unlock();
+
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
-	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_write_seq = msk->write_seq - local_idsn;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
@@ -1099,17 +1117,26 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	unlock_sock_fast(sk, slow);
 
 	mptcp_data_lock(sk);
+	rcu_read_lock();
+	subflow = first ?
+		rcu_dereference(inet_csk(first)->icsk_ulp_data) : NULL;
+	if (subflow && subflow->remote_key_valid)
+		remote_idsn = subflow->iasn - 1;
+	rcu_read_unlock();
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_snd_una = msk->snd_una - local_idsn;
+	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
+
+	if (first)
+		sock_put(first);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
 static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, int __user *optlen)
 {
-	struct mptcp_info m_info;
+	struct mptcp_info m_info = {};
 	int len;
 
 	if (get_user(len, optlen))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d2342..a3313a3db5a76 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -482,7 +482,6 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	if (subflow->remote_key_valid)
 		return;
 
-	subflow->remote_key_valid = 1;
 	subflow->remote_key = mp_opt->sndr_key;
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
@@ -494,6 +493,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+
+	/* publish last, once iasn and the fields above are fully populated */
+	subflow->remote_key_valid = 1;
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
-- 
2.43.0

