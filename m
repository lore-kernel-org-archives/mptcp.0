Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3830F7FA
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785664; cv=none; b=S1n7/DN4dGfQ8EMAIsCrmZVJBqhYNxI5osTAjpQw5RtWqW6yEMW4mEaKXlpAbKNwLCSDplxhda/9r8QRRNH/caorqI4fZMApc49GWFEyiQTNiM2HAKLJvhQF4uWjDY7A/xbXGG3KX+XDJDYsOzZCCikpr8tEuEBfLZAh0pP9sRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785664; c=relaxed/simple;
	bh=5Xku2oeaDH2r+WnDYAKJU6Jx7K5XH81gDAEILr19Vzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RQGEl+gEYD4SWAbJ1P1ylu6E+VhqmANKADpmiRD1+39+9PA9oqUHAMse6duefPJMyrLanYv4+/PtqbdynU9Jk5kGqj1d13wxhRVN3tXtRJCMwCOWtwNmOGZqfnOdrkZGettGCf3rBz3+Vmf/YdUMTy2ZR4tj6YDyajc6ds+8brI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DG8gbMIP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG8gbMIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762785661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlvhELsyR66yeRsiYUY3unVLrNM2XeS+HM1sD154JTU=;
	b=DG8gbMIPawSpzCgvDPPxhHW8bweKvMDwJhc9u8fyfYDTTCyg/n3MmvCorvWq8DezpOIsVp
	9KlFU2To4v/znxBAUqn2YrWLU/F7du1JPP1ktss/RMKyCjkCY4laxphlG/Zu8CdGId0FOr
	4bY0ExUU3iAAC3EvWn1detN68wBYGRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-H-jyxClkP5qGTaMY_SPKUQ-1; Mon,
 10 Nov 2025 09:41:00 -0500
X-MC-Unique: H-jyxClkP5qGTaMY_SPKUQ-1
X-Mimecast-MFC-AGG-ID: H-jyxClkP5qGTaMY_SPKUQ_1762785659
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1B7D180047F
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:40:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C75EE196FC91
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:40:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: do not fallback when OoO is present
Date: Mon, 10 Nov 2025 15:40:45 +0100
Message-ID: <fec239b14fa74d96fee25928de089de45f2c99ef.1762785316.git.pabeni@redhat.com>
In-Reply-To: <cover.1762785316.git.pabeni@redhat.com>
References: <cover.1762785316.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tYeVd4Kg33dJpdT3GDMuA5Fqqk1QSw_VCzEj0ntiY80_1762785659
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In case of DSS corruption, the MPTCP protocol tries to avoid the
subflow reset if fallback is possible. Such corruptions happen in
the receive path; to ensure fallback is possible the stack additionally
need to check for OoO data, otherwise the fallback will break the data
stream.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: this does not avoid the WARN(), but fixes the inconsistend
read() behavior; the ingress data is OoO, we should not ack it
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6b08e1de358..7b966f105f89 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -646,7 +646,8 @@ static void mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
+	    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
 	}
-- 
2.51.1

