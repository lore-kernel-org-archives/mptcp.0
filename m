Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E371CD23
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428988; cv=none; b=pHTpc8t6QOw2kL5xNp9acQ2/rdiO1tO6KThMAVcY8OhMtPbd7qKylW1VG9MmLTMRmYPaOqpotobYKEL9gFMGmGsChko+TRgPsKyp1ZriYMAND3CBD5JWnaEv+wCl7KprqUk7Op4svaK57VWQJKPbJ86rpJmwOP6Z1d8lRLpkC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428988; c=relaxed/simple;
	bh=sX5FbE8Pbm0Ynp7114CU3ikFv9zcrotQgGAx37goFpg=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 X-Scanned-By:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Transfer-Encoding:Content-Type; b=uOdhb02K7W6ePf/Arg3QsV4mBWsbQnc0QUTW9LKQZMaKDW/nPpIXSTf5LDE4uWc3ch31cOvuKWrKIVFRdMRdYGkQQDfxJEWVgpM3p7PUTIFFYQtHp6X3t0lqP/10K+e35+jRKOa5whivzkSajHBGfqFT6pOWgVcNyNc9rZ6WXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLsOvrxJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLsOvrxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FT09gDIvluUFxbY3kzwRCZoIX35ySbqgC6jLcmu8Qv8=;
	b=bLsOvrxJGEDuBiOzEI1NOuw1lvoQyiURKBrc5eiJeFtae4i754H4jt4VvcaWetlwoCL7ci
	Go0GqP2pFq/PPNb4ARID4DcWorCcPUaZoLzgCyyWCWvd16siM6V42YcDsplvDOcYAWFcAw
	/5VzaZAkVWHAXCP6pwagsuPmbIgYf2k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-tzQnuWBbNSulgndgxCAovA-1; Tue,
 16 Jan 2024 13:16:24 -0500
X-MC-Unique: tzQnuWBbNSulgndgxCAovA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 173773869142
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF101121306
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/5] mptcp: annotate lockless access for the tx path
Date: Tue, 16 Jan 2024 19:16:11 +0100
Message-ID: <92930a7b962611507f4bb87671d97f526ece5952.1705427537.git.pabeni@redhat.com>
In-Reply-To: <cover.1705427537.git.pabeni@redhat.com>
References: <cover.1705427537.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp-level TX path info (write_seq, bytes_sent, snd_nxt) are under
the msk socket lock protection, and are accessed lockless in a few spots.

Always mark the write operations with WRITE_ONCE, read operations
outside the lock with READ_ONCE and drop the annotation for read
under such lock.

To simplify the annotations move mptcp_pending_data_fin_ack() from
__mptcp_data_acked() to __mptcp_clean_una(), under the msk socket
lock, where such call would belong.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c | 14 ++++++--------
 net/mptcp/protocol.h |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cebbd0bc32aa..51b00d7e7c89 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1061,7 +1061,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		msk->wnd_end = new_wnd_end;
 
 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
-	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)))
+	if (after64(msk->wnd_end, snd_nxt))
 		__mptcp_check_push(sk, ssk);
 
 	if (after64(new_snd_una, old_snd_una)) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9ad672a10c11..679d4576d2c1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1033,13 +1033,14 @@ static void __mptcp_clean_una(struct sock *sk)
 		msk->recovery = false;
 
 out:
-	if (snd_una == READ_ONCE(msk->snd_nxt) &&
-	    snd_una == READ_ONCE(msk->write_seq)) {
+	if (snd_una == msk->snd_nxt && snd_una == msk->write_seq) {
 		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
 			mptcp_stop_rtx_timer(sk);
 	} else {
 		mptcp_reset_rtx_timer(sk);
 	}
+	if (mptcp_pending_data_fin_ack(sk))
+		mptcp_schedule_work(sk);
 }
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
@@ -1499,7 +1500,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 	 */
 	if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
 		msk->bytes_sent += snd_nxt_new - msk->snd_nxt;
-		msk->snd_nxt = snd_nxt_new;
+		WRITE_ONCE(msk->snd_nxt, snd_nxt_new);
 	}
 }
 
@@ -3210,8 +3211,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
 
-	msk->write_seq = subflow_req->idsn + 1;
-	msk->snd_nxt = msk->write_seq;
+	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
+	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
@@ -3316,9 +3317,6 @@ void __mptcp_data_acked(struct sock *sk)
 		__mptcp_clean_una(sk);
 	else
 		__set_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->cb_flags);
-
-	if (mptcp_pending_data_fin_ack(sk))
-		mptcp_schedule_work(sk);
 }
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3af85643328e..d05ec76dd7c2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -402,7 +402,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (msk->snd_una == READ_ONCE(msk->snd_nxt))
+	if (msk->snd_una == msk->snd_nxt)
 		return NULL;
 
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
-- 
2.43.0

