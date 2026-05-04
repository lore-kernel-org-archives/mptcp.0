Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C743E0C40
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909222; cv=none; b=bqxaumYGrWXyTRWVU8pF89HSaMMnQ6ja5038fccHvNhcBt8sL8Y9Kyp4csUu/nld2Nwck1Q8bh+qPYcwMnlQ3VVAqtT4Unoz/pzxbaNwTzy3wEpIHuyMRpfk9ZI+QkLKK7IyuQT1iAXdOq/X4jbw6NLaAYrCv4Ku0bmpP8wzGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909222; c=relaxed/simple;
	bh=bl2uobt9X+LcEmp3tRpjIqgNJFM/Zi9zDtlcXlPf274=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=FOGIljN2yDXFD4nmUkXsZCeYiCrve2U/ULS50525MNf6wMVQWj7YDtQ3a0toyjr+7iZR0+GXpOTjh6HGAfBTUfTsUnlrb8vbAUSQnFEsKdmr0acC/h9jvLHCEjFAKPsR6rTfspg31IT6usz3wj0OyWAjmlIJVf4L+yER8ysAlJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHLPEbwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHLPEbwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777909219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1uc36C1BG42g9R0yvqAduA5mfWNYeIwkO/6I1a3xQj0=;
	b=JHLPEbwik+MqXaFSSy3BCGCBpRFYvg7Rb8sai1JY/aoycF+4W+98U2chFiXxnarp0AuFbO
	b/buxRajtK+VWE3oJhzc0rKvTrTOYqx4j7mLNkcvle/Awpykiw3J4yrLGua1Ch/NwbhQ4X
	v8abDv6Qg6p4UKwfHrLZBv5RIYzt690=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-4R80UiZPMCKMAUAAITx9WQ-1; Mon,
 04 May 2026 11:40:17 -0400
X-MC-Unique: 4R80UiZPMCKMAUAAITx9WQ-1
X-Mimecast-MFC-AGG-ID: 4R80UiZPMCKMAUAAITx9WQ_1777909216
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06949195608B;
	Mon,  4 May 2026 15:40:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CE7F19560A6;
	Mon,  4 May 2026 15:40:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v3 mptcp-next 00/10] mptcp: address stall under memory pressure
Date: Mon,  4 May 2026 17:39:55 +0200
Message-ID: <cover.1777908248.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QLZ9OheSm1SP0QlpI4KIJD1PIyLsMsks3siKMaP2KI0_1777909216
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
Some notes on each patch WRT ignored or false positive issues noticed
by sashiko so far.

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
 net/mptcp/fastopen.c |  17 +-
 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  64 ++++++-
 net/mptcp/protocol.c | 399 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  24 ++-
 net/mptcp/subflow.c  |  11 ++
 9 files changed, 414 insertions(+), 170 deletions(-)

-- 
2.54.0

