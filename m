Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02223F294
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075255; cv=none; b=lHo7KuyYbno239KMPyJNRY3KxstdxwZld/L0AHJGsgFOpB7IRXEKgdh/zBAWdWCNawfjhCKD2BzIIKEzj3r22ZcxBH0yO5FvZXM1PfOAg5kmIRHHSpnE2jdsFkhQjjg2IWIfksQO0gS8c2jplAl1LiFfsiEOnNTsy6KLgWdDyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075255; c=relaxed/simple;
	bh=UQlu4ApwXTVrNVzd9dVUBYQChWw6FIihHGQ3j6/0apY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QwffCbcKYKOoBzuMKN7J/JLsO6CchaRbCST0TV9cQEu1k5Sq5UX+nfI41gDHdMaX+xm6+xRo447Lg0N/F+VrhGRwW6rTKl0sXcBRfH5KiyvHXi6es/Hr29Lr26HN3Oef7nqY48SuJ6KI6Isa5WMSCt+zjN0yCH8R1sgrGe6KixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHtdvuiN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHtdvuiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763075253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oyi4yrMI3UI4WPwbG/khl0MiXAzQd6/mr3x80+9LXB4=;
	b=WHtdvuiNGHSCtEQWjp3fripXQ7xXbCpCmvBOQOgyFDNO5ZjYH/tkHzguPOFGhC3tzJNhfe
	XCl/jKkiIXwunjFVjBLnhznGVNWsQ1w9fA06uT53o3QRBAQVxlpXlcOa8gKrmb1+OBpdqj
	YR6UozlqCazZgLOa/DFd2X+UyF/WVHo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-0N-sMuIJPxGH932pk-fjNg-1; Thu,
 13 Nov 2025 18:07:31 -0500
X-MC-Unique: 0N-sMuIJPxGH932pk-fjNg-1
X-Mimecast-MFC-AGG-ID: 0N-sMuIJPxGH932pk-fjNg_1763075250
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F9BF1956096
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EE73300018D
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/3] mptcp: do not fallback when OoO is present
Date: Fri, 14 Nov 2025 00:05:30 +0100
Message-ID: <1ec1d02676bf90ef3aaca85bf5b0cccc81556548.1763075056.git.pabeni@redhat.com>
In-Reply-To: <cover.1763075056.git.pabeni@redhat.com>
References: <cover.1763075056.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZTX0Etw51ZImt1ToPlpjMQ-MNPC9v9FWqxXkUVqjreQ_1763075250
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
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1b222cd3096a..f5761bff288c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -78,6 +78,13 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 	if (__mptcp_check_fallback(msk))
 		return true;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
-- 
2.51.1

