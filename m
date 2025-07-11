Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22541F3B85
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226213; cv=none; b=iNN4wYGEUS8jXHm247i+ung5mg/zEKoSFJWIURm624wwXmulCRG6kXPRTdqQotkKe6nkGnkyQDw4VaXplA3Vtk9JicTqPy1QP0fUOmWk9hPqYpZ8CwVLilGHBfpOYtqDFINses7K9YL36fIdmGPSBPYaAJIo41P626AMNJluQ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226213; c=relaxed/simple;
	bh=ekbbgZhRvbnvk76Ddv1SI6XUxAMlztZNg/2qyLGVsLo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Jc4l6zz1EcLUeA8nyLVDs/ZzcpGIBIg8A4xSIm6dCXChQbgoVjWqnNTRAiR6iGHtfa1WZKKf1WaVTfQud6kO7Mt2Jwq4c2/ZdOm8HnDCCA5rLTb64r2y4aT9Fsfebe827AUw4tZbCmP5ijtGkMLPI89npWTRVaPGY1xm+7H/M4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6dFGnEh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6dFGnEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752226210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sl4UfrsyzP9qoz2cMMP55RMyRqX02eHGja2JQZr6GXw=;
	b=O6dFGnEhaZ6NNhT4dKx6P6VymCCIKvpfzD5fSQvg4lMzlpLXUMLxfVFfi1ZJryOaGjh6EW
	ns+93Ld2QP8/RNY0V90hURnwYzxOw2JR6kInULBWk5RBCvAOF2kEF3kcL1EjNNS9rbFril
	oLadU4saHQPfeg22vSQkvHLlbXago4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-TA_meyk6NBGGeu56cYjMAQ-1; Fri,
 11 Jul 2025 05:30:09 -0400
X-MC-Unique: TA_meyk6NBGGeu56cYjMAQ-1
X-Mimecast-MFC-AGG-ID: TA_meyk6NBGGeu56cYjMAQ_1752226208
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AFAC18FDE33
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31E8A1800285
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-net 3/5] mptcp: reset fallback status gracefully at disconnect() time
Date: Fri, 11 Jul 2025 11:29:43 +0200
Message-ID: <afbade1a6fa43236499233643000799dae65d977.1752221786.git.pabeni@redhat.com>
In-Reply-To: <cover.1752221786.git.pabeni@redhat.com>
References: <cover.1752221786.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: volXUfroj8QRWTKPhmgT7D0WWKqP8RN37PgUglopZ3g_1752226208
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

mptcp_disconnect() clears the fallback bit unconditionally, without
touching the associated flags.

The bit clear is safe, as no fallback operation can race with that -
all subflow are already in TCP_CLOSE status thanks to the previous
FASTCLOSE - but we need to consistently reset all the fallback related
status.

Also acquire the relevant lock, to avoid fouling static analyzers.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - drop entirely the blocking section
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 49498cdd17f0..46bc5cc5a4d7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3142,7 +3142,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	WRITE_ONCE(msk->can_ack, false);
-- 
2.50.0

