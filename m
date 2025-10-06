Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790E19C553
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738339; cv=none; b=ApSpKegTtoFvAeym08WP86LjD6iusjsynXUcIxeeBcSrA7Rm7MYSe3QfQLPYKK8IgDLTX+Okk4zCm5KhEA3+gHALPGghzPcszfHToZ+2wVZn+ulAmfBNunyKvaoBVWVM3IRdzx1SUWedU9Y10b7vOrXvlJtzm+FiPxtsO8W8uQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738339; c=relaxed/simple;
	bh=xcLF6/KEMSCeJZoPircaP38E5mN7nePweMiDBTB6dd4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=CybTWh3fq1zesvrAL3pdvpUZMFuMr51F5HNYiSSVPRxFUKhrTnS+jMaWC9WO2hZFnYZQ0gJy5pwuIACiEim1P9zNrNKpJMPgk20aqH1PVMnosTS4zwXeho9mP1LcQRIi9t2Qj3A9ARU6mJAfZ52tWVYkjozZbK1tGlZBrY/LdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ruo48ZoI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ruo48ZoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s9a3Jy37mCW/LqTOQb0+2yxJu/QQfOajibOTOjp3Uqo=;
	b=Ruo48ZoIj3mqp6akhkUnSsC5lRo5MxxY+6RJtL6G3SxWk3m4xJ287hpYtilwqHawFrkVYX
	/KJAVbsdg7vKFYiGOIbbX1TTjWjlB0xAI2E3BtzxepBiSTm01VuE4Xu100JgYW4gtXe7Tv
	6LeEYDQrBkj/RqiGAxBYXhct9UIqNQk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-DtmJorQeMpGCKtUlkWIyQw-1; Mon,
 06 Oct 2025 04:12:16 -0400
X-MC-Unique: DtmJorQeMpGCKtUlkWIyQw-1
X-Mimecast-MFC-AGG-ID: DtmJorQeMpGCKtUlkWIyQw_1759738335
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 680D81800285
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A5FE1800577
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
Date: Mon,  6 Oct 2025 10:11:59 +0200
Message-ID: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mxzMViPJWC2hISIRtRpck5foLoWhnPyLPV1CBmyb_ac_1759738335
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series includes RX path improvement built around backlog processing

The main goals are improving the RX performances _and_ increase the
long term maintainability.

Patches 1-3 prepare the stack for backlog processing, removing
assumptions that will not hold true anymore after backlog introduction.

Patch 4 fixes a long standing issue which is quite hard to reproduce
with the current implementation but will become very apparent with
backlog usage.

Patches 5, 6 and 8 are more cleanups that will make the backlog patch a
little less huge.

Patch 7 is a somewhat unrelated cleanup, included here before I forgot
about it.

The real work is done by patch 9 and 10. Patch 9 introduces the helpers
needed to manipulate the msk-level backlog, and the data struct itself,
without any actual functional change. Patch 10 finally use the backlog
for RX skb processing. Note that MPTCP can't uset the sk_backlog, as
the mptcp release callback can also release and re-acquire the msk-level
spinlock and core backlog processing works under the assumption that
such event is not possible.

Other relevant points are:
- skbs in the backlog are _not_ accounted. TCP does the same, and we
  can't update the fwd mem while enqueuing to the backlog as the caller
  does not own the msk-level socket lock nor can acquire it.
- skbs in the backlog still use the incoming ssk rmem. This allows
  backpressure and implicitly prevent excessive memory usage for the
  backlog itself
- [this is possibly the most critical point]: when the msk rx buf is
  full, we don't add more packets there even when the caller owns the
  msk socket lock. Instead packets are added to the backlog. Note that
  the amount of memory used there is still limited by the above. Also
  note that this implicitly means that such packets could stage in the
  backlog until the receiver flushes the rx buffer - an unbound amount
  of time. That is not supposed to happen for the backlog, ence the
  criticality here.
---
This should address the issues reported by the CI on the previous
iteration (at least here), and feature some more patch splits to make
the last one less big. See the individual patches changelog for the
details.

Side note: local testing hinted we have some unrelated/pre-existend
issues with mptcp-level rcvwin management that I think deserve a better
investigation. Specifically I observe, especially in the peek tests,
RCVWNDSHARED events even with a single flow - and that is quite
unexpected.

Paolo Abeni (10):
  mptcp: borrow forward memory from subflow
  mptcp: cleanup fallback data fin reception
  mptcp: cleanup fallback dummy mapping generation
  mptcp: fix MSG_PEEK stream corruption
  mptcp: ensure the kernel PM does not take action too late
  mptcp: do not miss early first subflow close event notification.
  mptcp: make mptcp_destroy_common() static
  mptcp: drop the __mptcp_data_ready() helper
  mptcp: introduce mptcp-level backlog
  mptcp: leverage the backlog for RX packet processing

 net/mptcp/pm.c        |   4 +-
 net/mptcp/pm_kernel.c |   2 +
 net/mptcp/protocol.c  | 323 ++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h  |   8 +-
 net/mptcp/subflow.c   |  12 +-
 5 files changed, 233 insertions(+), 116 deletions(-)

-- 
2.51.0

