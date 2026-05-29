Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01933D4FB
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051489; cv=none; b=mSj6izHuU5xL7YD/Q2gEv5EEeLyYFsKEfvdkOVQyZsnlNb8tDxGo0VOvZZWE1nbONkTMJBa/Pqnl3cMIqTH+jaiX+mRbMICdRtr6liu8wvHvT4vK8NvF0WrLtqI/m6DJDS9U86P73uvFP4YDI/PuZVf/W0zTX8sMWUJyOcmDv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051489; c=relaxed/simple;
	bh=E/m+IYSQ11aVsXI6JOy91SnHhdq30y6HNTH1kz+xrtw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=eqmUj2vnFQLWAQPPIazBjNBHea6f/6/ZYwS80wX1E0/noxniIdIp2ZfKvzkrbps4ifIxu+zkjUu2913y4CYF9nxugNK6FcnWx9wpO4rRNTKwoONZ07Jql0jBU5cgj9cIFoQ0n2PHJAJwxPkiFCdg7di13fWvvZOkh9L8GUoPtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USYyC3TA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USYyC3TA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780051487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D+4S6s6dNAIpedRYn5i2goyMKoVMctOh5QqSEoU/JPA=;
	b=USYyC3TAL4KABsMSyju3BnGXFvpPeACnxNL8WYVm45pCQ6Xp0dMkgJ1aXAMF8yfjEyu1VU
	69sxq97aDqCPNX9gLnU3YxZ5dUewnVmrBw324ZzT7ZPFHy7Ad8BlbVY5uTThHa5mJ4lrbo
	0lw2KiMQ4iP6lJVx0hRaSA86AVJWiC8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-QGmBRtokO9m1bC825HStDQ-1; Fri,
 29 May 2026 06:44:45 -0400
X-MC-Unique: QGmBRtokO9m1bC825HStDQ-1
X-Mimecast-MFC-AGG-ID: QGmBRtokO9m1bC825HStDQ_1780051485
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DE2718005B9
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AAD419560A3
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:44:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v10 mptcp-next 0/3] mptcp: address stall under memory pressure
Date: Fri, 29 May 2026 12:44:28 +0200
Message-ID: <cover.1780049797.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kVP8WYZEM86RA1CJJFh9gMirws4aPC45HsP2A1Jx7cc_1780051485
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This brings (hopefully) the final bits required to address the
data transfer stall reported by Geliang and Gang 

Patch 1 is a mostly cosmetic change over a previously accepted patch,
while patch 2 and 3 improves mptcp retranmission to make them reliable:
pruning can require some of them.

The main change over the previous iteration is in patch 3, addressing
sashiko feedback over the previous iteration (missing timer reschedule
in some corner cases).

Paolo Abeni (3):
  Squash-to: "mptcp: implemented OoO queue pruning"
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 net/mptcp/protocol.c | 177 ++++++++++++++++++++++++++++++-------------
 1 file changed, 123 insertions(+), 54 deletions(-)

-- 
2.54.0

