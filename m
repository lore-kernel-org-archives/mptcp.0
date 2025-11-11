Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904325BEE8
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845858; cv=none; b=SxwDt+tEiulQ/87GoIhC2tL0rgs2HXurD2ljOgPq0Ovx0BAsvbLPgSDvljERLbl6yhlAqeB8izzJyTJZ6cZAKIvpiWFxFR37E+KELd3gVyf1dYa/O6TS9fGv4dAG9eWWx6wH48gFINtLW/6TQ171bAMebK2IVW7a7E1qtr6orRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845858; c=relaxed/simple;
	bh=5Xku2oeaDH2r+WnDYAKJU6Jx7K5XH81gDAEILr19Vzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QQjwkBjAesKCzznXxfnDXsxb+brSFWbwkeGG4triXBu3mZYRujUEJWVMwAj4fTWJJb+OprQyfd/mtVvKpNSvrDugZ28ZXnFySZpTDeMRy+Wh9RBgM3hCHTaEnvEiP2vnl2saCeoZ90CYfan3r8aekKMYkz2xTNKS4N+Slf7LFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TH5SxfLo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TH5SxfLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762845854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlvhELsyR66yeRsiYUY3unVLrNM2XeS+HM1sD154JTU=;
	b=TH5SxfLod1ags0JiGZXFolnc76x9fzby2Ft0fuITT7mn6nkA0j2bR0Bu0gP+JsZnIWP0la
	cP7sbIkyNKEVhcKawBDMVaaXxNDKKsEF6hMjLnKMWSb9WHrD7YTfVnTyF1k8+OUDPm4IyH
	bQKya117F1oOB8a+8D3TeVjckVRdmwo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-KZDitfS_OrCJdDScgX1ovQ-1; Tue,
 11 Nov 2025 02:24:13 -0500
X-MC-Unique: KZDitfS_OrCJdDScgX1ovQ-1
X-Mimecast-MFC-AGG-ID: KZDitfS_OrCJdDScgX1ovQ_1762845852
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5E241956063
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2719195608E
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 1/2] mptcp: do not fallback when OoO is present
Date: Tue, 11 Nov 2025 08:24:05 +0100
Message-ID: <fec239b14fa74d96fee25928de089de45f2c99ef.1762845791.git.pabeni@redhat.com>
In-Reply-To: <cover.1762845791.git.pabeni@redhat.com>
References: <cover.1762845791.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hQ4Ve4wBMJYzYWGNyp6DktSdX19HZDfSFnCJGNwo-co_1762845852
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

