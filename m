Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889B2505AF
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297232; cv=none; b=M7v0b2+opcT7vUhV/zPZKvRNCtTWieJyDugkjc3vKR4CQ7JxhLDgJjEUJjMf4IRewNiGV0608lOP8dyulf3nK/y9EP6OlT45VPwNayLvcFZZ22EW3hM50YKQcAs9Q+gSUDaYDGi4rvWurStsV6u3uxn6Ns/tCISbBfy0bJioAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297232; c=relaxed/simple;
	bh=OZFVg+889rXVi/oBMKCtybNgRWzxdyOV1T+3O6FiLwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=W6k6IOQIdIRCip4JahlOoq1KZf+kcJUyHLLvnVbz6M4Fdoc76VAzE0RjKMf54BkQ/IhDoWg3yk1Gv5GTHLFXUONvAMwBzL+4o2BI9OC3exnb0rTtHwox+yiDCDUfJ4gWbgRb3R0MYFXX7RbOoAZxCueGtVymTqiSY0/yI6p9xmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNiwMaef; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNiwMaef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGEBFFJ5OwUjJ8s8mWiJ1pdZeMC1VPFCVazhkHxkjb0=;
	b=gNiwMaefPXLmVgjEKf8Jkbf7C/8xo5HRUSb3c7b4CL13pw9bxNWO3zYdEpV9OOkOC9H5Hm
	yXhT1XnZF3DBqOVp1pRWSAoipLyyz4DMjVNfaGMFnHjFXb+twYuDtJcFId9QYRFNMa8wOH
	R/MuHd5v+FC+ZzkrwnkXcnPaIwCJQV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-hY_iyLUgNuKoYKd5X5uFeg-1; Fri,
 19 Sep 2025 11:53:48 -0400
X-MC-Unique: hY_iyLUgNuKoYKd5X5uFeg-1
X-Mimecast-MFC-AGG-ID: hY_iyLUgNuKoYKd5X5uFeg_1758297227
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 826491800298
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D9281800452
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 07/12] mptcp: minor move_skbs_to_msk() cleanup
Date: Fri, 19 Sep 2025 17:53:21 +0200
Message-ID: <fa30e025a9433828ee822241a1a9791b306eee43.1758296923.git.pabeni@redhat.com>
In-Reply-To: <cover.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hvq9qN9BKoxdU5Qs0R94QaWxohVXOqlvVlqjr7reJfI_1758297227
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Such function is called only by __mptcp_data_ready(), which in turn
is always invoked when msk is not owned by the user: we can drop the
redundant, related check.

Additionally mptcp needs to propagate the socket error only for
current subflow.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bd83abefe4965..fce70cdad2a7f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -815,12 +815,8 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 
 	moved = __mptcp_move_skbs_from_subflow(msk, ssk);
 	__mptcp_ofo_queue(msk);
-	if (unlikely(ssk->sk_err)) {
-		if (!sock_owned_by_user(sk))
-			__mptcp_error_report(sk);
-		else
-			__set_bit(MPTCP_ERROR_REPORT,  &msk->cb_flags);
-	}
+	if (unlikely(ssk->sk_err))
+		__mptcp_subflow_error_report(sk, ssk);
 
 	/* If the moves have caught up with the DATA_FIN sequence number
 	 * it's time to ack the DATA_FIN and change socket state, but
-- 
2.51.0

