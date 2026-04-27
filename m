Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A323EDAB2
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319539; cv=none; b=eVk6nOB8zwEtdPEnqULJzwwGmUuKzTDmgmcx2SnQaFqb7QxlsyXVUEgNlc9iD5veZc/R47rJ4blaj1XQLz+Eu/gQ58KoIEr5RjAAJr6Wq/0ecuoqb6ItDIUz/V2/GPJAFKzGPXYN+jMywi6f8MASq/fmwpO0hAI5mkY85CWQiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319539; c=relaxed/simple;
	bh=kl6ssvMe5N7o4YKf3jsIS60URC3+0dFz5HDYFVtTnvw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=AW+41YVjhWtsf6p7HX41d8Ko/se/7NHvg5H/K18Df2ykiLRx0T3fV7ojK1rNhAB7zOg7KKTupZyRF7Fl9pNuyP2pJbp/BE5n7zdG3YdtKyo/b/BXASW31RZmdpRjvWVmDtelTNVhEhqZf4xvQ2n7UGdSIJmsU18fS0MkVXSvblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEvryy/Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEvryy/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777319537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NQpxJfNzKVF4PT5cm2zw5CyANaWv5SN1Wl/s4rfbVo=;
	b=AEvryy/YGfe7PAKJbDI4Po+eVsBY1w/NLlgeHqKsVueBVJibO0TLnsFQRwSV8YbtP8J8c9
	Aw+61JtoNtTRohe6u7kLMdFAC8G7Ajc/14Uw2nuEz+ix/kCuPqmZ8Cf8HA4yEjIr2fGCg7
	np3GtNS0ogFm8Ny75tPgOWgxuhK+DIM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-Ff6hmJO1PY-FXoyO7NULuQ-1; Mon,
 27 Apr 2026 15:52:15 -0400
X-MC-Unique: Ff6hmJO1PY-FXoyO7NULuQ-1
X-Mimecast-MFC-AGG-ID: Ff6hmJO1PY-FXoyO7NULuQ_1777319534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F243A1956095
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35463300070A
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 19:52:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 00/10] mptcp: address stall under memory pressure
Date: Mon, 27 Apr 2026 21:51:58 +0200
Message-ID: <cover.1777318959.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZnvUuDIvQT1XgtFFPcFW63tbfCh8_rhUHe2MFHeWSns_1777319534
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This an attempt to fix the data transfer stall reported by Geliang and
Gang more carefully enforcing memory constraints at the MPTCP level.

Patch 1/10 moves the bound check before entering the TCP socket.
Patch 2, 3, 4 and 5 are cleanups/refactors finalized to safely re-using
TCP helpers on MPTCP skbs.
Patch 6 makes TCP pruning related helpers available to MPTCP and patch 7
makes use of them. Patch 8 addresses an edge scenario that could still
lead to transfer stall under memory pressure.
Finally patch 9 and 10 improve the MPTCP-level retransmission schema to
make recovery from memory pressure significanly faster.

Note that the diffstat is biases by the quite large patch 4/9, which
contains mechanical transformation of existing code; "real" changes are
noticiable smaller.

Tested successfully vs the test cases proposed by Geliang and Gang and
vs the selftests.
---
Notes:
- Sashiko apparently can't understand that mptcp_data_lock() &&
sk not owned by the user-space is equivalent to the sk socket lock. As a
consequences marks incorrectly as racy a few accesses under the data
lock to the sk_rcvbuf.
- mptcp_join with "4 subflows with under pressure" may require longer
than default timeout, as the transfer in such condition can be really
slow.

Paolo Abeni (10):
  mptcp: move checks vs rcvbuf size earlier in the RX path
  mptcp: drop the mptcp_ooo_try_coalesce() helper
  mptcp: drop the cant_coalesce CB field
  mptcp: remove CB offset field
  mptcp: sync mptcp skb cb layout with tcp one
  tcp: expose the tcp_collapse_ofo_queue() helper to mptcp usage, too
  mptcp: implemented OoO queue pruning
  mptcp: track prune recovery status
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 include/net/tcp.h    |   8 +
 net/ipv4/tcp_input.c |  55 +++---
 net/mptcp/fastopen.c |   9 +-
 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  58 ++++++-
 net/mptcp/protocol.c | 403 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  18 +-
 net/mptcp/subflow.c  |  10 ++
 9 files changed, 398 insertions(+), 169 deletions(-)

-- 
2.53.0

