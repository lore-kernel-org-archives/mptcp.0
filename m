Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E81314A6F
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215710; cv=none; b=ENm6BlzQuthXG6/TF9SROIxvD9Fiv4R1aRWpwl9msAvynKF1UkLWaHrYkwWF/kUpQPUjc5vZ/rzXYZMYUqK9vVPIKvmFr/mIM1w3F7aNgwnws52hIBZbqSlLJzh3EbsN+29RT9tt3xwFHlmKBRSU4W0Xbn49O0Gf8LhYEeFcL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215710; c=relaxed/simple;
	bh=ScA1uYMVI6b6TcWMqHutCPa+PPdcfezP/e5XyoROsKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=oCQJlt90qozAbYWV/l0fp5u1jnJqcGwPzeBrRNi26bAcgeMDKDMPfY92kHC9kzDSM/QAHV7sg6kEl90ERSsG6J+4+WetKIuwXzTN6jaND4e0YIiFdYxdcBst9RYIW9TeA+PBlUs8j44GoR5RTQBof/5zY0b84nP8XBBrESZPOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZMfx3GB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZMfx3GB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cfq2OAa9rpjFdsnNZRking9yMGZjsJnxEkS0qcHhVRE=;
	b=GZMfx3GBA0+cCckU0SEskcYsLbEsuSxCT+7hiXxPoXYwINQvTWZlJrAY4irY7b0auIsL/Y
	BNnHcky+e5oUhYTmVsUbP2YPpBHaHzuJYIonldKDp1Y2x7NQUdoY6+sIrIIfBDgyDLMIuC
	6MO2ZMelbgPH/ecWDo6xsp60v2WHCOE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-QUQVhSj6NRiVqttCVhWzdQ-1; Thu,
 18 Sep 2025 13:15:05 -0400
X-MC-Unique: QUQVhSj6NRiVqttCVhWzdQ-1
X-Mimecast-MFC-AGG-ID: QUQVhSj6NRiVqttCVhWzdQ_1758215704
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C77B819560AA
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F045C30002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 00/12] mptcp: receive path improvement
Date: Thu, 18 Sep 2025 19:14:42 +0200
Message-ID: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wl5C7cRncAsP3P8uTx6L9zyLNznQLi_VaPB7sGf_aZw_1758215704
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
  mptcp: leverage the sk backlog for RX packet processing.
  mptcp: prevernt __mptcp_move_skbs() interfering with the fastpath
  mptcp: borrow forward memory from subflow
  mptcp: make fallback backlog aware

 include/net/tcp.h    |   1 +
 net/ipv4/tcp_input.c |   2 +-
 net/mptcp/ctrl.c     |   2 +
 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   4 +
 net/mptcp/protocol.c | 335 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |   8 +-
 net/mptcp/subflow.c  |  24 ++--
 8 files changed, 217 insertions(+), 161 deletions(-)

-- 
2.51.0

