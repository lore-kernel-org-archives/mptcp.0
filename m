Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93545D923
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059202; cv=pass; b=NVTITBo06bZePswk4Irg11Umnqytw5B5mVCpfab9eelCZaxqBA1RucKLYtp88fxnYnH9CcKzIN6bfhzPUvdTk9sOdSjRjcwNB5eq7DCK7MK5Fru/Aqjn+rx2IHoP/1a7pdVnK6SWKfK0wZQmWdyST0qnUejUY+iI5hTZ8QPZZGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059202; c=relaxed/simple;
	bh=WnQ/Okv3g52XD62Xaq8CCaS0a6+RXx6kksivMR/8Xtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFH19BaauLsDlZ99gckEBz9DdM4JIPLNPhLhxFbSHUX0KRuWY8qExxcq1Kvoke9EQjdsspVf5z5ffwejCkabma/568KPh6TUj9t1dwAZfkZQ4ffNp02dZAJflsGdjDBUrVhbUhZkok5By4ZzsHKQvrydwteeFdug3LIb2IMoFKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=DgjFbvXA reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="DgjFbvXA"
ARC-Seal: i=1; a=rsa-sha256; t=1792059197; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j65zmSbNqkZ69+BZEA+sg9c/UgwGYrCJI5UxLkDaYrMDjddoExO5rnqgpsVLHsi+7nDhyrgD4530F/Lj7HcGAScPUTQ8MQwRYGRFs29LnvDRqbXgaJ96iwYDBS6UWEaexVNl2RfkS6ZFvXhjg223GYICrgdgjNxf4/z9FMAnwds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792059197; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aScb/QSukXJw505wEZa2pZ8If/74TQDmWZoXfwoVL/E=; 
	b=cCEdx5mYA/u7CXvRy5jKnEI8maUKJgSUN/HfzmL5M37d3sDmiQjEZS0IKlCl2kqbjx1bkVB9e+OZI2JXxW+KrkPbKEUmsyZxRzho09HB+3lJtqDXMg/r4shYNZQGTF0Ebb/SYQkKwQH5j24ZdRvW1X/IPN74C+CONJfPxQTmNCk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792059197;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aScb/QSukXJw505wEZa2pZ8If/74TQDmWZoXfwoVL/E=;
	b=DgjFbvXAoc+oiQray3vKwiraKafql1vjvQt/VVy/MJehBSCDIaeAqcGXIrnwwWBR
	CTckh5sg1FZyE+8Zq6XdlGLMuxPAarzfSYEVDQeeU0INtOERH+fvAbKPCxMnLkQ4Scc
	1Frgf7UV6bmA8zJj4Nz6mA8t3VxR9Qgp0lZlwamk=
Received: by smtp.zohomail.com with SMTPS id 1792059195381435.28674735880804;
	Thu, 15 Oct 2026 03:13:15 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net-next v9] mptcp: normalize seq numbers reported in mptcp_info
Date: Thu, 15 Oct 2026 15:43:03 +0530
Message-ID: <20261015101303.144541-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Report sequence numbers relative to their initial data sequence
numbers instead of exposing the raw connection-level values.

Keep the sequence-number baselines in the MPTCP socket so diagnostic
reporting does not depend on a subflow context that may be reset.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v8:
- Keep local and remote IDSN baselines in the MPTCP socket, so reporting does not depend on a subflow context that may be reset.
- Normalize mptcpi_write_seq, mptcpi_snd_una, and mptcpi_rcv_nxt relative to their IDSN baselines.
- Initialize the MPTCP_INFO output structure to zero.

v8: https://lore.kernel.org/all/20261014130809.1874184-1-kalpan.jani@mpiricsoftware.com/
---
 net/mptcp/protocol.c |  4 ++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sockopt.c  | 14 ++++++++++----
 net/mptcp/subflow.c  |  5 ++++-
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b474d03620a75..fb47384ace9c6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3178,6 +3178,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
+	WRITE_ONCE(msk->local_idsn, 0);
+	WRITE_ONCE(msk->remote_idsn, 0);
 
 	/* msk does not go through tcp_init_sock(); seed RTO bounds. */
 	icsk->icsk_rto_min =
@@ -3722,6 +3724,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
+	WRITE_ONCE(msk->local_idsn, subflow_req->idsn);
 	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
@@ -4160,6 +4163,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 					     MPTCP_MIB_TOKENFALLBACKINIT);
 	}
 
+	WRITE_ONCE(msk->local_idsn, subflow->idsn);
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	WRITE_ONCE(msk->snd_una, subflow->idsn);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 06a107d4e8392..9238031f3adb0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -286,6 +286,8 @@ struct mptcp_sock {
 						 * lockless access read
 						 */
 	u64		remote_key;		/* same as above */
+	u64		local_idsn;
+	u64		remote_idsn;
 	u64		write_seq;
 	u64		bytes_sent;
 	u64		snd_nxt;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb5..b1e41c967157e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -971,6 +971,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	struct sock *sk = (struct sock *)msk;
+	u64 local_idsn = 0, remote_idsn = 0;
 	u32 flags = 0;
 	bool slow;
 	u32 now;
@@ -1008,9 +1009,11 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_flags = flags;
 
 	slow = lock_sock_fast(sk);
+	local_idsn = READ_ONCE(msk->local_idsn);
+
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
-	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_write_seq = msk->write_seq - local_idsn;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
@@ -1023,17 +1026,20 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	unlock_sock_fast(sk, slow);
 
 	mptcp_data_lock(sk);
+	if (READ_ONCE(msk->can_ack))
+		remote_idsn = READ_ONCE(msk->remote_idsn);
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_snd_una = msk->snd_una - local_idsn;
+	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
+
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
 static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, int __user *optlen)
 {
-	struct mptcp_info m_info;
+	struct mptcp_info m_info = {};
 	int len;
 
 	if (get_user(len, optlen))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d1..cfc703bd5dd69 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -481,7 +481,6 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	if (subflow->remote_key_valid)
 		return;
 
-	subflow->remote_key_valid = 1;
 	subflow->remote_key = mp_opt->sndr_key;
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
@@ -490,9 +489,13 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	subflow->map_seq = subflow->iasn;
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
+	WRITE_ONCE(msk->remote_idsn, subflow->iasn - 1);
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

