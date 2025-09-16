Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0137C0FD
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040052; cv=none; b=nOEHh2uxckgCx02YqycOWoryc09low4jlBJAenX2nwhbf7M9nW3EOrAycT6iAXT1p8bYAxwXe3a1mjI8++J8Xty7KSxSDqLhSkOQJ6VgRFHfOk9mXvb4DKDmYhureRT097K4RoGn0SyDI4sBUDjcOsImhcFJWZ+812MDi7Xaevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040052; c=relaxed/simple;
	bh=wGtfcM1RC7Oqx9AZrwhNR+VU/65uCxenBX9upCOM6Vg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=pjU9Elu9dnHlfPXIeMaaaEWqMAgmxSbg9ozeBA5ueUk3g+awOAxtOCf76Wlk4a8UlQAzDvNsoAsv3+smRvGaP9A9zLse7MyMEQsZJJQYKTPlP8Pi/VBXPkQXUbYCtFiyEmlazuACd1CpP74iw1Yu9foAMbPs9jm7H8zF4Lt5mU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaGi3jIk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaGi3jIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/MkmmuVxanWokT1bVhyMxK77ImWhjp+EBWhikCy7jRA=;
	b=MaGi3jIkbGpkdg5wWI4qzl9iOMxdzrHPoHAPiPyUKbU7bhuW9H9RwN6j25h0OQL6qFPvXJ
	5zXCzho0wWAsTy4/CLF1JMkZ+hSIODhXZB5lyR0VDCx2f9j+7vhxVLBtwnsPH/VHjVdbH4
	MAQAmhBTmqqobX6ChPSanNsNDNaTIUg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-OwcwzsxFP26zfF2ozsIXbQ-1; Tue,
 16 Sep 2025 12:27:28 -0400
X-MC-Unique: OwcwzsxFP26zfF2ozsIXbQ-1
X-Mimecast-MFC-AGG-ID: OwcwzsxFP26zfF2ozsIXbQ_1758040048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDDD4195608F
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11FE019560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 00/12] mptcp: receive path improvement
Date: Tue, 16 Sep 2025 18:27:10 +0200
Message-ID: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wNubbgurKt6xxQr_LHwLdd9jrbOMRnor-hlZ5UACFa0_1758040048
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series includes several changes to the MPTCP RX path.

The main goals are improving the RX performances _and_ increase the
long term maintainability.

Some changes reflects recent (or not so) improvements introduced in the
TCP stack: patch 1, 2 and 3 are the MPTCP counter part of skb deferral
free and auto-tuning improvements.

Note that patch 3 could possibly fix issues/574, and overall such patch
should protect from similar issues to arise in the future.

All the others patches are aimed at introducing the socket backlog usage
to process the packets received by the subflows while the msk socket is
owned. That (almost completely) replace the processing currently
happening in the mptcp_release_cb().

The actual job is done in patch 9, while the others are cleanups needed
to make the change tidy and more follow-up cleanups.

Sharing earlier with known issues (at least on fallback socket) to raise
awareness about this upcoming work.

Paolo Abeni (12):
  mptcp: leverage skb deferral free
  tcp: make tcp_rcvbuf_grow() accessible to mptcp code
  mptcp: rcvbuf auto-tuning improvement
  mptcp: introduce the mptcp_init_skb helper.
  mptcp: remove unneeded mptcp_move_skb()
  mptcp: factor out a basic skb coalesce helper
  mptcp: minor move_skbs_to_msk() cleanup
  mptcp: cleanup fallback data fin reception
  mptcp: leverage the sk backlog for RX packet processing.
  mptcp: prevernt __mptcp_move_skbs() interferring with the fastpath
  mptcp: borrow forward memory from subflow
  mptcp: make fallback backlog aware

 include/net/tcp.h    |   1 +
 net/ipv4/tcp_input.c |   2 +-
 net/mptcp/ctrl.c     |   2 +
 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   4 +
 net/mptcp/protocol.c | 338 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |   8 +-
 net/mptcp/subflow.c  |  24 +--
 8 files changed, 220 insertions(+), 161 deletions(-)

-- 
2.51.0

