Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC269D27
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082944; cv=none; b=PZxIvgeUOeepPL+h0riKXAQ0BnKQqfOWgxh0179csLJu+TlKwGARXT6AqMn1QGtuhxoxlt6suNmHkgRRvPOBL8TL2widbTfvB6buBxKvhR36NdzLbfmjCxo7guLlbTZt7l04cYrwpLVb5MQB4Mz448ZTmnufM1cz15gke44TP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082944; c=relaxed/simple;
	bh=RtUnwu+1Ul9il5JJ8Hfr4wYGrKKHEGFnAD6E9x21t6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VffgwU98OKs0vmRBdJPINNjHuBYAne5nM6C8G2zq7RZcpGT9eMJbXFv4R7Dt8RIZGJ1BdFDfqD+eL0ro+6iQn9xfJx1vdFpxDbpxFRVtExdOVMzVLo+r0f5sTYp+lSx4IwSR7BWibK0G6ZLqNtmZOofZZUcyVdTt/1Xt/UitW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EM68JTRX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EM68JTRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trpcIJ7GcqYETDUHn/BDCywGhHrSa9xj2JYTJio2InU=;
	b=EM68JTRXYUkqSuTlgYWhNjma12tUgApZrCshbA/894bNA66LUwyz06dEMlqz+RAbP87/T2
	DjxjCNZm83eATgihDoTVk450jGWFq780edm5SRNg/5Z9yXWZDRhYVJhAwvaOYUu9b9tuqL
	5ddoZ9Yta+4BFxex1lm+WxAC5UZTbeQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-kg1BJwtJP3WVirBkMHa10A-1; Fri, 16 Feb 2024 06:29:00 -0500
X-MC-Unique: kg1BJwtJP3WVirBkMHa10A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EA65185A781
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1E7F492BE2
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:28:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 net-next 3/7] mptcp: fix potential wake-up event loss
Date: Fri, 16 Feb 2024 12:28:14 +0100
Message-ID: <d502c4829953c4e43f429b894ab38a91dbf6da27.1708082765.git.pabeni@redhat.com>
In-Reply-To: <cover.1708082765.git.pabeni@redhat.com>
References: <cover.1708082765.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After the blamed commit below, the send buffer auto-tuning can
happen after that the mptcp_propagate_sndbuf() completes - via
the delegated action infrastructure.

We must check for write space even after such change or we risk
missing the wake-up event.

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - drop unused __mptcp_sync_sndnxt() - Mat
---
 net/mptcp/protocol.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 486fff865803..738705207652 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -797,6 +797,16 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
+static inline void mptcp_write_space(struct sock *sk)
+{
+	if (sk_stream_is_writeable(sk)) {
+		/* pairs with memory barrier in mptcp_poll */
+		smp_mb();
+		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
+			sk_stream_write_space(sk);
+	}
+}
+
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -815,6 +825,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
 
 	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
 	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
+	mptcp_write_space(sk);
 }
 
 /* The called held both the msk socket and the subflow socket locks,
@@ -845,16 +856,6 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-static inline void mptcp_write_space(struct sock *sk)
-{
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
-}
-
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
 
 #define MPTCP_TOKEN_MAX_RETRIES	4
-- 
2.43.0

