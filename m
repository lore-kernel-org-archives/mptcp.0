Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC628D8D0
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657653; cv=pass; b=NcjTvPM0gIMXqEgrA2B/yffunjWo40aRM5yDKCAYXMRfoSQukAZKe5MUxEb9/D6iLC+J3qpbk197/Kk+f4sjqobdEsCkEhBD2KjKE63/UXOuuISzA/YGqGkAEE9VWGPWlU4f6i2hDne4qnbGNsoyBxodPkFJSthceLyyAK+Ue1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657653; c=relaxed/simple;
	bh=ZqtrmfH+GbX7R9PzASKgW08hDrKJBUvJ4eyy6PmSRXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJERk/i4K5AwZgZKqgXYijyz32sGCvbFTKY7JnuYssne4A8pn4/CIhQaQ5Ffk9jNLlj4Hc9HDrVJDjCu3Mocpe8rHQ1rW2S7eMHcaYCpxuNI0s/krmI9cLwkrIyhOz81dxrztlIGNwYpcOFStR3AMDbaTLJNkqgIxH7VVaeqSSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=s4n7YxeT reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="s4n7YxeT"
ARC-Seal: i=1; a=rsa-sha256; t=1787657646; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f4y0ImKYY96NBnDhOnM1hSb9GLuQsjnQ8JHqGBfPPyh5cHv4K/WTzQI1IE7FcbUzb+9klKYlHNXha/bTzkCk0sc0oWcjMA+jfNqb93G7XGFd6WJoqXCH+ypz1v+rcHLHAloh+Xa0u9ObX/qNO7rgeAYuba7BGeaJksnB65EeAgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787657646; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5asv36K9TImeRBFHk57t0qwuYBxfiLtpiNp01eqzBDQ=; 
	b=mOmNhX+1YmxxCkG9Z9/OMLtQ+G/YzWnyXCBWO2XNvYO2GcKYk6Yqu631S8OKN0DVkks13vRkzyCEqjn/iXAmPMmp9FP+P6w7LAIoY/xw3E3xkRpQ2LpJWAv5NW/IKV55ffZ66VGMzbNHHIzQMl9BPkPJNWvWwrONYSkhsLUiCO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787657646;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5asv36K9TImeRBFHk57t0qwuYBxfiLtpiNp01eqzBDQ=;
	b=s4n7YxeTfvHTotgbjJmTVkPUHRqNwauq2kdlfKaP1+4XBrQ1jYV7HbSW4iQjcA4D
	pez0q0NtmzWXLn+OxsYDSbzVrGGu665X9/0dh5lRzO3KMP9j1lMJIl0d1EXPgmgxkqD
	Wrbi1BTEx5ka23yZpJO8D5RT3G0O1iDStpp289Ps=
Received: by mx.zohomail.com with SMTPS id 1787657644169131.90227101174446;
	Tue, 25 Aug 2026 04:34:04 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH net-next] mptcp: normalize seq numbers reported in mptcp_info
Date: Tue, 25 Aug 2026 17:03:55 +0530
Message-ID: <20260825113355.3573376-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt report the raw
64-bit data sequence numbers, seeded from the connection's IDSN/IASN.
Since the IDSN/IASN come from mptcp_crypto_key_sha(), these fields
carry an effectively random offset and are not useful to userspace as
absolute values: a caller has to snapshot two getsockopt(MPTCP_INFO)
calls and subtract to get anything meaningful, which is exactly what
tools/testing/selftests/net/mptcp/mptcp_sockopt.c already does.

mptcp_info also reports mptcpi_bytes_sent, mptcpi_bytes_received and
mptcpi_bytes_acked, which give the same information as a plain byte
count starting at 0. The snapshot-and-diff workaround for the seq
fields is redundant once those are available.

Cache the local and remote initial sequence numbers on the
mptcp_sock the same way ->token already is, and subtract them in
mptcp_diag_fill_info(), so mptcpi_write_seq, mptcpi_snd_una and
mptcpi_rcv_nxt also start near 0 for a freshly established
connection.

msk->local_idsn is set at every place write_seq is seeded from
subflow->idsn: the provisional value in __mptcp_sync_state() at
TCP_SYN_SENT, the authoritative one in mptcp_connect(), and the
passive/accept-side value in mptcp_sk_clone_init(). Missing the
first of these would leave a window where a concurrent
getsockopt(MPTCP_INFO) still saw the raw, un-normalized write_seq.

The TCP-fallback path never negotiates an IASN, so msk->remote_idsn
stays at its zero-initialized default there, which is a no-op for
the subtraction and leaves mptcpi_rcv_nxt reporting the plain TCP
sequence number as before.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/protocol.h | 7 +++++++
 net/mptcp/sockopt.c  | 6 +++---
 net/mptcp/subflow.c  | 2 ++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f22d64ab1c53b..47faece545f15 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3764,6 +3764,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	WRITE_ONCE(msk->token, subflow_req->token);
+	WRITE_ONCE(msk->local_idsn, subflow_req->idsn);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
@@ -4204,6 +4205,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	WRITE_ONCE(msk->snd_una, subflow->idsn);
+	WRITE_ONCE(msk->local_idsn, subflow->idsn);
+
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d52..c1a709b2287f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -306,6 +306,13 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	/*
+	 * cached IDSN/IASN, so mptcp_diag_fill_info() can report
+	 * write_seq/snd_una/rcv_nxt normalized to start near 0
+	 * instead of the raw, crypto-derived initial values.
+	 */
+	u64		local_idsn;
+	u64		remote_idsn;
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80cb..fb3dfa88eba5a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1086,7 +1086,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	slow = lock_sock_fast(sk);
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
-	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_write_seq = msk->write_seq - msk->local_idsn;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
@@ -1100,8 +1100,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 
 	mptcp_data_lock(sk);
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_snd_una = msk->snd_una - msk->local_idsn;
+	info->mptcpi_rcv_nxt = msk->ack_seq - msk->remote_idsn;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d2342..70e187694d6a5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -466,6 +466,7 @@ void __mptcp_sync_state(struct sock *sk, int state)
 		 * even for the FASTOPEN scenarios
 		 */
 		WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
+		WRITE_ONCE(msk->local_idsn, subflow->idsn);
 		WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 		mptcp_set_state(sk, state);
 		sk->sk_state_change(sk);
@@ -492,6 +493,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
+	WRITE_ONCE(msk->remote_idsn, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 }
-- 
2.43.0

