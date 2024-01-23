Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312A12E7B
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043810; cv=none; b=ob0+R4t3p+m2WP0zoCHmciCqW/A1M6IiG66RABVcUdSP6svSL4+N92NdEsHJraMJDeLLouQBxZrtFqZUvC6VN/BqOCkmtq8Q1/FnHWEfxXDpA46W7oK3fZSQvk2kTV8Q+2Us2vCgZ7wLKyxzh0Mv0nXZ4ucyV3oyPOu/tlqi0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043810; c=relaxed/simple;
	bh=6DN6X0IfOlET/JczP4UXZ90V3krkkXkefcoUewjgbMA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvXi1XpRgiQ5zb6RairRCvQm+xQWOzvD44aZIXsNtGvB6kRmWdHsh3/dVyMAjH7GTahjpOkxRY+RbvkqLaiIG7EL+zkGXAooAEx2hfuaQEFDc45EL9SBIddcBdlBTSbsMnKh2F/IMVB8ldEPLiDAx6j11FIwKC+FwrYiugAP3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nfxakn38; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nfxakn38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706043807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WRnh123gIhZmFY8eVdybnnd2YOfASOzk8G2ti2wCvng=;
	b=Nfxakn38vSKJk7MA6/U39ISjYzNPmtSqVummZi7gZ7G0Kt4kkD6CNlZ9rgGDAwEOeHzbvN
	k281tLYaGCnbrH3VRaqD1j0B8CUwWjZd3rUbG7daZFRJsPLZYGO0WK/OMqu4NGpaFPN8ES
	VYP/vlRKbaZlN3HRx3b7UG5uwJZw1po=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-7DbDfkkeOCq9GlCyI32rCw-1; Tue, 23 Jan 2024 16:03:26 -0500
X-MC-Unique: 7DbDfkkeOCq9GlCyI32rCw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E021685A59A
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 21:03:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BF31492BFD
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 21:03:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix data re-injection from stale subflow
Date: Tue, 23 Jan 2024 22:03:18 +0100
Message-ID: <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When the MPTCP PM detects that a subflow is stale, all the packet
scheduler must re-inject all the mptcp-level unacked data. To avoid
acquiring unneeded locks, it first try to check if any unacked data
is present at all in the RTX queue, but such check is currently
broken, as it uses TCP-specific helper on an MPTCP socket.

Funnily enough fuzzers and static checkers are happy, as the accessed
memory still belongs to the mptcp_sock struct, and even from a
functional perspective the recovery completed successfully, as
the short-cut test always failed.

A recent unrelated TCP change - commit d5fed5addb2b ("tcp: reorganize
tcp_sock fast path variables") - exposed the issue, as the tcp field
reorganization makes the mptcp code always skip the re-inection.

Fix the issue dropping the bogus call: we are on a slow path, the early
optimization proved once again to be evil.

Fixes: 1e1d9d6f119c ("mptcp: handle pending data on closed subflow")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/468
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 53d6c5544900..a8a94b34a51e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2339,9 +2339,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	if (__mptcp_check_fallback(msk))
 		return false;
 
-	if (tcp_rtx_and_write_queues_empty(sk))
-		return false;
-
 	/* the closing socket has some data untransmitted and/or unacked:
 	 * some data in the mptcp rtx queue has not really xmitted yet.
 	 * keep it simple and re-inject the whole mptcp level rtx queue
-- 
2.43.0

