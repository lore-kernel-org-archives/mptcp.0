Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1E7C0BA
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936136; cv=none; b=iDsj/SlSMGk+jnTVvGMiuBvdTWQqaC0Ay9pdWsC1iYPjszzU71Y9LySeEjYyFWxcOeFiW9BWROEhFjIkeI/q16hebt6eElk+KsrRi6PDOMHShuiiEJLCGOo9oMDPUs2w0XaB1E5YmFRg53ej+4xtwn/cgjFlsRN5FKLFYTmUoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936136; c=relaxed/simple;
	bh=Jm483eD7XCTYbTstZzMYLKIB3V+3PFzZD9vFTDmnOVs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMBwD9E+f0mh3D0+D0HqwUk21bC2mLHRGmAyHT4yOPXdK0JV5wKKhygSGg4coXNHicEN6W7uIUri1vF8YujIu2L/WvF7yuJdsOqZXjH8IPNoaLbEHOU0P9SxV0ratjqQ2/vOilHi+wDGapZJUF2gik7iv/zqcabjh++i7KRzoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqJslBfy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqJslBfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705936134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTGB/FaQW48FTChQHYDDz35Uy2tB9OJ40H8G7HEtVEs=;
	b=GqJslBfygSSGK0VEQTClq+TnJzqt6xucY8QUS2lPz7PV9l8+MIONkp9YK5FY66oIBE+R6Q
	VR+kaOwehacjpwk+2GbWtfLGxKKZB7yI8SJaQtBbZfAKy8OwMRYUSgYTkOCwzjuKYVY7Dw
	rifj597HsFfxkVn9sZbP8g4xNw5vMQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-K5vgEjh9Ou-nks34Sr1iwg-1; Mon, 22 Jan 2024 10:08:52 -0500
X-MC-Unique: K5vgEjh9Ou-nks34Sr1iwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADE81884346
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8C41C060AF
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/7] mptcp: fix potential wake-up event loss
Date: Mon, 22 Jan 2024 16:08:40 +0100
Message-ID: <27f976d6a8f1a88ed5ad3822af43d0fc648ab9f8.1705836321.git.pabeni@redhat.com>
In-Reply-To: <cover.1705836321.git.pabeni@redhat.com>
References: <cover.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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
 net/mptcp/protocol.h | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d05ec76dd7c2..bbc490f36273 100644
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
@@ -845,14 +856,16 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-static inline void mptcp_write_space(struct sock *sk)
+static inline void __mptcp_sync_sndnxt(struct sock *sk, u64 new_snd_nxt)
 {
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (!after64(new_snd_nxt, msk->snd_nxt))
+		return;
+
+	msk->bytes_sent += new_snd_nxt - msk->snd_nxt;
+	WRITE_ONCE(msk->snd_nxt, new_snd_nxt);
+	mptcp_write_space(sk);
 }
 
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
-- 
2.43.0

