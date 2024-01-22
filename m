Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D27C09E
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936136; cv=none; b=DuAGVVlconH5SsW+hACz5Obd8Ymqcy5p0nV20EHGGlIeNGVcCB6a/Lk0vtxYUbqnIy3hICoCkhst5jmdNF8ibAo3l91Btl+Krsd+FFUF/s17GnLflhIYvdIDcGPzHLQs12LGiWvJyLEtbLhHdAK+Ehb6UFeadiafv8rffvx+CNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936136; c=relaxed/simple;
	bh=cfSWfF26bkzGFut5qdlu5ktfWfKBGxtCCrelM2Kxmq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAStqmIgDALA1XCiF1L2gt003tHM3hMHf8exFUbtUHWrfvek06K0oGzP3cV0z7zk6jXBZohYlBj3Rjc9tj4nXN1Enp5Fwe9t2F/OFEbnL9hRkiNxElOtmu55n9jLsi48VwKUUaPrHI3IwCEETNZF9b1FAFp0nfxG1MW5zLlO+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EE1VAgBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EE1VAgBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705936133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6UEF+Ej27BnwaNlYKPVRxmeAbOwB/OBF4lFqGVZ+Fg=;
	b=EE1VAgBsFX+3kWXZJIxpEF1hxYgxnslEf+n5Y86pPwDpc9QjHw9eSY/JtVuW0hdKBhPY2F
	Au/qaCK4I+ZvK7tgL+YeIIxR2sy98prtLyFfUtKLebvFNLh/ofW+JPtqEomJiZZnZtA76p
	5//UCR1sqcuZI9pKpkg8a//fOQAlwwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-JjyMShYlPWO0KPJJJuZaTA-1; Mon, 22 Jan 2024 10:08:52 -0500
X-MC-Unique: JjyMShYlPWO0KPJJJuZaTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED44D85A596
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB5C1C060AF
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/7] mptcp: fix snd_wnd initialization for passive socket
Date: Mon, 22 Jan 2024 16:08:39 +0100
Message-ID: <14ed71656159324df35d706466b6da75a60d114a.1705836321.git.pabeni@redhat.com>
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

Such value should be inherited from the first subflow, but
passive sockets always used 'rsk_rcv_wnd'.

Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4d7131f96ebf..7a47834bf6ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3218,7 +3218,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
-	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
+	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 
-- 
2.43.0

