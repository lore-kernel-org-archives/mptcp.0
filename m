Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6B3C46E
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751162; cv=none; b=Fmvw205ZoExjRO4wMTth1uNogN0TmdxpwsLU9ixLv6e2akrxvlYPwec65bdro6AcuUtuTq3k3FJn2L/WWTWF5NSSunhHyrmoyoX+2HLhhee10qDVcYqK0JeRw+vgbZyARq8fSWHml0NagsA881CqkJcxlg1LqDnTgy/T8DsC5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751162; c=relaxed/simple;
	bh=t8/ZoM848qwA9+zJRoRQ7XhlQxeyjQKBxNh15fbAK/o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtdfTk1hyipyhsCCSnB/jYsE4hvO5cq2X4V8LYGijv2EqcAtoGbwQKuuA8SxHyoy5F8D0Wotne7Hv85t3bfQhj86ANzA+pdPjVKIlY+HzfCQZhOAk9MCABmv7za11jcULZzYtTwcPoVdMwhlwwyy2Hq9y+1ImJRT38Sh8QFSmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVSy/bMt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVSy/bMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0DrMtvQcxjTsXf2TMqJhxqBs2wEDSNf66eJx/HFkOfY=;
	b=QVSy/bMt5bo/NIP7IUpm75JdtKJfJzl3jupp4+xDVVDncfKi+/+yeGhYbQFZC6RT8FPziF
	j9sGsVSsVsVqAxOFG0X3mpmAT0lsS+RD+YUHvNOcIMrkZXajLSxZFMF6sTjSaTmApVHdSP
	4UonnVlWZmhyBlmtKdDv8u4zHCEAkCU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-ATS31gtMNniGNjAk9irpCQ-1; Mon, 12 Feb 2024 10:19:16 -0500
X-MC-Unique: ATS31gtMNniGNjAk9irpCQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 387BB185A780
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB79E492BC8
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [mptcp-next v2 3/7] mptcp: fix potential wake-up event loss
Date: Mon, 12 Feb 2024 16:18:58 +0100
Message-ID: <78924a15f3d86f989fa286f10ef88670b790eb89.1707739536.git.pabeni@redhat.com>
In-Reply-To: <cover.1707739536.git.pabeni@redhat.com>
References: <cover.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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
index 486fff865803..2e197262a42e 100644
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

