Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9959B40
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082944; cv=none; b=uRj9ooMqZKPVHPCgIdW+z2mNctZp82RBbT+zx8UIvzQ5pJh7hfYYmilojTgLOCXClNq/jU+eGRY/Tsp7b5GjZLGZEo3zJpN/S12WFXLumbsgTLg/yBv8pszJ6pQy3gH3FIz1dW6ChjiFlTH73pxmeyxH1nIlzkIONLtXv31bYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082944; c=relaxed/simple;
	bh=ll45SbBaMQm6yuO0TNpI5bttJllom4/dywXo+15t6jA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSj08WTCLK4f7CIBE7cYVx7ICsx8xB0h5srjVXVS2dz8LqvieAF71y4m/HPlzRxvtJvvG4+WRBt7k5vSFbbRN/350bboL70t1Vb7vKao0jJuwL8Kg/vx4mJv3F5CrdO7i40LNTe8OJ3GHrAd7BqyXCJlboYs0+cRQLhtL6hw8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctg3rVUJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctg3rVUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGWUkJJySi1zICpwQxcwHFkXCYeeGFoPlEi/u/PEcxA=;
	b=ctg3rVUJKnGTlEFI+SK77bhPsUwZvvdI+wSEz4A+0NhvKXtfbDMEf4YcXUxcWTvu8rfqJe
	BY8L0yAk4y+53BupzpWRa1sxQhP1niTXfmuJxCye1a1VJZNcLl6O3OktYEjVE2mDYEvkj7
	Yp7i5ZXwIf0l3PD5JH5u9tiUqAUpYKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-IzsxBh_jNt2WJ6dMpc1bDw-1; Fri, 16 Feb 2024 06:28:59 -0500
X-MC-Unique: IzsxBh_jNt2WJ6dMpc1bDw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67F0D85A588
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:28:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB939492BE3
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:28:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 net-next 2/7] mptcp: fix snd_wnd initialization for passive socket
Date: Fri, 16 Feb 2024 12:28:13 +0100
Message-ID: <39016ee4291eb918183f01347361e9ea358981a5.1708082765.git.pabeni@redhat.com>
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

