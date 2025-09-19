Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515792C21F8
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297222; cv=none; b=XOG8BltmGEDlEucYE2LIViM6efYjP3dInJcZrxURJAKM8QajVPoZawMLl/cYErwszFFO2PlKU4vHZBXAYcpCJ+GCVV+/iaXG16MfY7zVEKqXHpQ+boEq37jbNi6fiPUuIITxHP3e2z8YiARBqtGH1Il5Fcn5YE6NHY++WJIk6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297222; c=relaxed/simple;
	bh=/2s1FpnzKy7wQxQjA9dR3VGHscoS+9yWtizLS1s3j1U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=hUtvOU1W+dl/bHzSqJvtJhgHPux33Yc0Gb/VStkonHR5ftxz+NmK7ow2u5IJmL7OgFaHOOhQ123ktWJJ3DKM6giILVBN7Z9fR7jE8ZzdslgW2/84cMn2pTG/HvXHfB1l1n8XG+4MMRFzBFhHKyNBdLMHdyVm1hnSFglxTSl5qH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8YNOXaS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8YNOXaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SAjLuedguIwAX+yST1o9kGpt/PDzj6bge/8Xz5qUUh4=;
	b=L8YNOXaSeaVCWKSnJdmHeVFnf3ZRzTkNPy3uiymQ7FryhokrgB2aHih1hl4kBixnHp7ZvA
	ezQLiNRMIwYnePmeHmoOa50e2MKojrXNxjtqQCmxvdTJRDX0EzLaSgCp9kqP41b5GMYMlH
	IRga4/XPuOnoGc8FsLzqLcq86g0aBi4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-Ow49Dx5WNC6q_Sdd94JzCw-1; Fri,
 19 Sep 2025 11:53:38 -0400
X-MC-Unique: Ow49Dx5WNC6q_Sdd94JzCw-1
X-Mimecast-MFC-AGG-ID: Ow49Dx5WNC6q_Sdd94JzCw_1758297217
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AE2019560AE
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.255])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86CF61800577
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 15:53:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next v3 00/12] mptcp: receive path improvement
Date: Fri, 19 Sep 2025 17:53:14 +0200
Message-ID: <cover.1758296923.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ohN9Bihz8J4b3b7xSHgijCzUSE1KP_MSeATgaJx1NJk_1758297217
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

The actual job is done in patch 10, while the others are cleanups needed
to make the change tidy and more follow-up cleanups.

Sharing earlier with known issues (at least on fallback socket) to raise
awareness about this upcoming work.
---
v2 -> v3:
  - (hopefully) addressed CI failures
  - reordered to avoid trainsintly breaking fallback
  - refactor patch 3/12

v1 -> v2:
  - fix compile warn in patch 3
  - removed unneeded arg in patch 4
  - commit msg clarification and rebase

Paolo Abeni (12):
  mptcp: leverage skb deferral free
  tcp: make tcp_rcvbuf_grow() accessible to mptcp code
  mptcp: rcvbuf auto-tuning improvement
  mptcp: introduce the mptcp_init_skb helper.
  mptcp: remove unneeded mptcp_move_skb()
  mptcp: factor out a basic skb coalesce helper
  mptcp: minor move_skbs_to_msk() cleanup
  mptcp: cleanup fallback data fin reception
  mptcp: cleanup fallback dummy mapping generation.
  mptcp: leverage the sk backlog for RX packet processing.
  mptcp: prevernt __mptcp_move_skbs() interfering with the fastpath
  mptcp: borrow forward memory from subflow

 include/net/tcp.h    |   1 +
 net/ipv4/tcp_input.c |   2 +-
 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   4 +
 net/mptcp/protocol.c | 343 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |   8 +-
 net/mptcp/subflow.c  |  12 +-
 7 files changed, 218 insertions(+), 154 deletions(-)

-- 
2.51.0

