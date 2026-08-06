Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB83B8D48
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027645; cv=none; b=uMxb/xJgNrFqy5OnJtOwR3TtKt5nSnLQ6Tivd3jKSxNBHLXMHGsYDdZCZZdUZ9fCKbqpuufAUReqNDxWrEXs22fsSQlcCJuispakSpxD79YXjkkDoc1HKKfIEBigOBYkyLvBqCbpQBrPThGmks8kOJr9urPKb1NJ2ivDC912H/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027645; c=relaxed/simple;
	bh=R6KDzNQn01ZB2kqMiwKnR/qdOLQX6vy/8GspfidwmuY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=oLSYpV3dg25q2AnA7kHb9zp82tsmUyZV02ggqd3iMeP2p6s0LGRiT2RVbxZonnEZLWTacnVksAYLk4+PeSKzu/TJwa9H2tUJFNkBjucC/iJKv6wH2GzXySOl8pr0I6Ad4p/yo7t/V7l1syQOz4QT5IhOMNq66cEHDov+kvJycD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmD9kfEF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmD9kfEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1oRComswLvTQWZVE/I+5d1tEWM4GCZGNprjTYG2ebGQ=;
	b=PmD9kfEFm3XtW6Ph+Uzjav9qgITL/T17+K3jm5ky9xLLKSuPGsqcnBXp0eEq2vaJ4qswk4
	pBsPMFDdiZuFiXJ3x4pVHxseVTE6ll2WDEZ+RWTEMAObVTaq/gEwSyK2jFZ2RqVVP3izAc
	M1UujoAt5Qc2gi3fdi0WOEh/j1eJZXE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-a03f-nc5OKy_v4zhRSvE1Q-1; Thu,
 06 Aug 2026 10:47:21 -0400
X-MC-Unique: a03f-nc5OKy_v4zhRSvE1Q-1
X-Mimecast-MFC-AGG-ID: a03f-nc5OKy_v4zhRSvE1Q_1786027640
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8607180064B
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E19131956094
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 14:47:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/7] mptcp: address stall under memory pressure
Date: Thu,  6 Aug 2026 16:45:21 +0200
Message-ID: <cover.1786026372.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9DYeRz1yF5sv_yLDkHRtmCTcyEae1yCpp2bsx7ZXZW8_1786027640
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This *should* address opus-5 feedback, as observed upstream.

New iteration takes care of gemini review on v1.

Paolo Abeni (7):
  mptcp: move the retrans loop to a separate helper
  mptcp: move the stale logic out of retrans scheduler
  mptcp: let the retrans scheduler do its job
  mptcp: explicitly drop over memory limits
  mptcp: enforce hard limit on backlog flushing
  mptcp: avoid code duplication in __mptcp_move_skb()
  mptcp: implemented OoO queue pruning

 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  32 ++++-
 net/mptcp/pm.c       |  42 ++++---
 net/mptcp/protocol.c | 290 ++++++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h |  11 +-
 6 files changed, 273 insertions(+), 108 deletions(-)

-- 
2.55.0

