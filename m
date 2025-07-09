Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABC2E8E0E
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073993; cv=none; b=UXyzNRMt5mL0HKaX/L+7sbulzGgn7X6/4GwzxbYZHrd0DCmkIL3qubuie7g9suLMHIcQa6tPT9dtzi+a/IX8Zr7z6DjWof2YaNdp4R7lcUZmwAqjcmVJs78HyEdOzp/r37vSMQa924IJTJxL0MBOuF76kNlt/quHpGhlWl3ncTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073993; c=relaxed/simple;
	bh=ekbbgZhRvbnvk76Ddv1SI6XUxAMlztZNg/2qyLGVsLo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O7j5vBc1uCEzrANN47UZ1zvayP5BXFNq4rmlx6yJx6NiDFPVDvV10mTKb5t4N21mAP0Mtvf+TtRACODGYQ9+JHyDTmRmg6Hg9PSUUKFeHAReOoXAILGY6g4cvpdTS6TU+NTl5qGpCT+iQ04U1Vp2nCCJQZHI8goFg0cjiVGKtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7BLBuO7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7BLBuO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sl4UfrsyzP9qoz2cMMP55RMyRqX02eHGja2JQZr6GXw=;
	b=R7BLBuO7eHZCVml7jK4bqTdg05QCpJym3DbKl0U1BVjIHLUbyMi9sycPpgPCtSXpSkT3N+
	BDXy8b4g/22HM7IUgKkpPPUG/Lws7BZ5kygV9yyFF5stih2ZS+pHYSn6s2j7pgltU8ZUis
	SkJDcQBLv9rlz9lzRBuLsC49yUHJs8I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-5c_japsEONiVLM8sg8ovEA-1; Wed,
 09 Jul 2025 11:13:09 -0400
X-MC-Unique: 5c_japsEONiVLM8sg8ovEA-1
X-Mimecast-MFC-AGG-ID: 5c_japsEONiVLM8sg8ovEA_1752073988
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACBF91801224
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 15:13:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D07271956089
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 15:13:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 3/5] mptcp: reset fallback status gracefully at disconnect() time
Date: Wed,  9 Jul 2025 17:12:52 +0200
Message-ID: <afbade1a6fa43236499233643000799dae65d977.1752073685.git.pabeni@redhat.com>
In-Reply-To: <cover.1752073685.git.pabeni@redhat.com>
References: <cover.1752073685.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rkUKqdZoYLpQMe5b-ZE0XAjXAo8ODE7JCKwissuLwAw_1752073988
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

