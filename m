Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF103BB47
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751159; cv=none; b=E+I4QOeN2ohghhcxpTeIs2FLVeQQIGQ/K9equiib/Mgz59CAmfw4pR8MCHePPrRQvCd5oagVC6Upgu4tIMpoZzkUVt0g8NBOTc05OmC2YBi3erl5qB8LCxDAk/jOmJ02AKdB4sZj7WGOk0syGbi/H7BEq2bDaBhBJVnNu0S5ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751159; c=relaxed/simple;
	bh=ll45SbBaMQm6yuO0TNpI5bttJllom4/dywXo+15t6jA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNRjWy24lu94YHYzxBDBLK+9o/tEMBmBRUchrmCutJlyb0CO1Y6XYT92MIllwAlf8kxoeOgvHlmie14IJiK5BmL2Xc0DDGnA6PMF+HLY1vuZgcPqrlpKnbSJW7aAkkDkmyAEMG+wFcSjTlVu7IM7RV+rUKaYjK7LtEGj8MniIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNsJYCIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNsJYCIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGWUkJJySi1zICpwQxcwHFkXCYeeGFoPlEi/u/PEcxA=;
	b=FNsJYCIBSrm+g5Gj0tEcFnkAOBSVZmQC/esFM0+5CQqTuglwOt81TNPRKk8/cwetBnJg2p
	scqenJzsGVz4BhcEeRR2L6BPCwmd5hsHtsgP1W+QdT1e3KnlG4DVdQs58caHgtjqY6kqew
	WifOlvGaW06Hm8tfuWQxFVxQspYdscs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-P23cCicuN72CGtTzbWbsCA-1; Mon, 12 Feb 2024 10:19:15 -0500
X-MC-Unique: P23cCicuN72CGtTzbWbsCA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76CFD106D104
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 066DD492BC6
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [mptcp-next v2 2/7] mptcp: fix snd_wnd initialization for passive socket
Date: Mon, 12 Feb 2024 16:18:57 +0100
Message-ID: <9f25e813223bf51a5f71789bd20940bbf0f462e7.1707739536.git.pabeni@redhat.com>
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

Such value should be inherited from the first subflow, but
passive sockets always used 'rsk_rcv_wnd'.

Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21b3729c65ac..7c3cb97214b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3216,7 +3216,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
-- 
2.43.0

