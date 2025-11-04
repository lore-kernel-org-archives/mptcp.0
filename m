Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077D346776
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293135; cv=none; b=W1ZJc2poeM7/fojc6XXFY9cflk9ajoP7ko9M/Cs1oos/gLqV0SSWW3OuttYXkBEY5PLEeiWJfE07WcecO478ru8KZU3N+h0wqmjrchh0WseyXELKVNzIs6EPNTWXWDbqrGtUigYd03lOnGDn6sGV1NjcJxp0XnLYrn3oPayf0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293135; c=relaxed/simple;
	bh=cQtygeHmS0T4Fb8OK4PX2TgRnKAB9pNZGKcIqyRKGlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ttDvbs4ZlWE4kh5Q/1dcYnVLHpExjIn18iy+Uc7BhDyhJV88CQqDjbXvLUEsZc6BuUjYXWnGbzol86zJhT1WE4/Y+ezjS4p4nhvBgHEp5b3mACd2zKDe+MDLFbI55TFliETbXI+2onhVveIBjpnx5RO9/HFBpW4Gu1/IlVed0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=augKDP3i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="augKDP3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762293132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zznC7FJgXOMRZVH7xPPMHGah7C+BgELZa2Qbf29YCCw=;
	b=augKDP3ir3qn9p6mvCQYEaERmzPS/xe4kDP7g1NewN11EHtWvA4UE91Y8/yILnEtrIbzEc
	ltWnzK4MrQEm1Xkxgno+T0VS7KIcAjB2DR/vnPPGbaghPx3FA+VQw4gZ67D7R0b/ceW7wc
	B3K8IpoYfMfNUzsCZGkR1hi/P3DVpHI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-j1qKVhPkMImYLDsenNbEoQ-1; Tue,
 04 Nov 2025 16:52:11 -0500
X-MC-Unique: j1qKVhPkMImYLDsenNbEoQ-1
X-Mimecast-MFC-AGG-ID: j1qKVhPkMImYLDsenNbEoQ_1762293129
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B451180065F
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6ACEA19560A2
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 7/7] mptcp: add receive queue awareness in tcp_rcv_space_adjust()
Date: Tue,  4 Nov 2025 22:51:41 +0100
Message-ID: <639f98b0d408d8acef5876b58e05d343091418c3.1762292476.git.pabeni@redhat.com>
In-Reply-To: <cover.1762292476.git.pabeni@redhat.com>
References: <cover.1762292476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4LNPHb1Zvk7Wzv_FUEdJvfS0QT1rT_YKaadwRhxgdCo_1762293129
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is the mptcp counter-part of commit ea33537d8292 ("tcp: add receive
queue awareness in tcp_rcv_space_adjust()").

Prior to this commit:

ESTAB 33165568 0      192.168.255.2:5201 192.168.255.1:53380 \
	skmem:(r33076416,rb33554432,t0,tb91136,f448,w0,o0,bl0,d0)

After:
ESTAB 3279168 0      192.168.255.2:5201 192.168.255.1]:53042 \
	skmem:(r3190912,rb3719956,t0,tb91136,f1536,w0,o0,bl0,d0)
(same tput)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 414cca078541..4b1944e40d91 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2134,11 +2134,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (rtt_us == U32_MAX || time < (rtt_us >> 3))
 		return;
 
-	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
+	copied = msk->rcvq_space.copied;
+	copied -= mptcp_inq_hint(sk);
+	if (copied <= msk->rcvq_space.space)
 		goto new_measure;
 
 	trace_mptcp_rcvbuf_grow(sk, time);
-	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
+	if (mptcp_rcvbuf_grow(sk, copied)) {
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
 		 * the mptcp rx queue fast enough (announced rcv_win can
@@ -2152,7 +2154,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 			slow = lock_sock_fast(ssk);
 			/* subflows can be added before tcp_init_transfer() */
 			if (tcp_sk(ssk)->rcvq_space.space)
-				tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
+				tcp_rcvbuf_grow(ssk, copied);
 			unlock_sock_fast(ssk, slow);
 		}
 	}
-- 
2.51.0

