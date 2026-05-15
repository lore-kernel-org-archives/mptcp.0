Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67042883B
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836068; cv=none; b=LSldvSIxEMO3SKtaxFI3gZsdTEXlmDmHNubYadQ3lXJQvB2IhletJoXtBdXVk8C03b7yhX87ebFj8Jm7u1mCF4YAagZH9ah6HcrjN2ApWGe4TdFcD8D0BKSbfLPy7mdNJotMt9heK9dJD5GHTs5vAnvkLhA8NRQ/9CsdG77xrEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836068; c=relaxed/simple;
	bh=UAjIVcjQcmmVfgXiCQeb37TkKmLwuggZwYX2PwkycJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=MxsmS5kot+gJYdCol/tcwAtWipertV8Uo2qdkPnOXA2YuhUSwIZhNuKLS33vJ3Dan1QT/UwI7ohn5G+rm+7VJZDFu0gZoZAcoecSKj+h0ysMP/C/aWe11lJdDZGz6Plg0KW6lJ7vnn4i9xEaU1hY2B3dm+pvY/S/zsy2HCk9ciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvZ4m0YB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvZ4m0YB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9WHwxYbSBH3YYWlDfF5BQY1R6Rmm2J7nIqcTY6yTgM=;
	b=SvZ4m0YBx3yGtgyFQbizgSXaYckROSkh6mMdr9IOlD8q1RlEwTRjjHAOAT52nDP656Xhow
	hLwNBWU8j8ybYojmfAS4SqFzNDIiPBnqPwdoCMbOJ18bCMegpv29SGy+XPKyH6uqHdBe9X
	frhE+OoctNELf466UfUmF7740z2wlmo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-cFHm2Qq6PL6EuahIzISF-g-1; Fri,
 15 May 2026 05:07:42 -0400
X-MC-Unique: cFHm2Qq6PL6EuahIzISF-g-1
X-Mimecast-MFC-AGG-ID: cFHm2Qq6PL6EuahIzISF-g_1778836061
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 816031956053;
	Fri, 15 May 2026 09:07:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A7161800347;
	Fri, 15 May 2026 09:07:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v6 mptcp-next 1/7] mptcp: fix missing wakeups in edge scenarios
Date: Fri, 15 May 2026 11:07:22 +0200
Message-ID: <98f41ca828a7938005b796eccbff417b8bc32f2d.1778835009.git.pabeni@redhat.com>
In-Reply-To: <cover.1778835009.git.pabeni@redhat.com>
References: <cover.1778835009.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HItXR_w6Z9n6adNxKwBIxd6mcLbGY7NejRBfckBz4DU_1778836061
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ce8372fb3c6a..b3ac1cb370f5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2276,6 +2276,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
 	mptcp_data_unlock(sk);
+	if (enqueued)
+		sk->sk_data_ready(sk);
 	return enqueued;
 }
 
-- 
2.54.0

