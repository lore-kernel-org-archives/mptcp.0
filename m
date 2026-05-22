Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053725A359
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486251; cv=none; b=J6rDQ+lI/bhIc+59wGevUAIgqvC8lUZttqUbaqRG/9KTfsfcFGlps5902i+4sA1fUp9hF7yYnQM+WD5QvDibwaLbPtkuhog+2nQ5CBJ7tHYEYp76WWvtJ6LdPV6cQ9WmYJ0XHwnn5QBmIzLj9XA2sIyzw4AWfI0RuKUIj9GYEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486251; c=relaxed/simple;
	bh=+FWn06QxXFn8LNF8O8vXszH13qx5hX/Kdb0zGYW2KCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=kg/C2Ov9y54nI0bNwW+h80sjCxnXKtFOuBtVmYQHWE3omzDJ8qU+4AcpQiEGEjpmfulbKsO2A9zInq1/WxXzYFIgpMwaOfgNDe7TUT3jBbg/J14qgHZFAxxEn6MGQyJe0gFL0fIbiLK/mOtj/l9u2jB0k8f8Aq/O32mfnHt0x08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoElb+N/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoElb+N/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779486249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K0PbZf7QNX2Xkz78M2JKZcjDXQWPkefZ6f2GUQjlRug=;
	b=SoElb+N/ehDjRn5VoDUmI8m8kCZb/5Z30cFnr/1cTozhJXWiyylVIBnTGuW0ZUUEegyzGT
	S9ugfH+5EtCHEAXy7RiJ0wvvdv3mA0gU13IdzuFO0DaDnODPWlf/Vr/4zQ5NCyV1/OL3zJ
	dJMpLJY57UHFqpgFkXsFBjfaINQNhtQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-n2G1i-uTOKOlxgyaRDB4Kw-1; Fri,
 22 May 2026 17:44:06 -0400
X-MC-Unique: n2G1i-uTOKOlxgyaRDB4Kw-1
X-Mimecast-MFC-AGG-ID: n2G1i-uTOKOlxgyaRDB4Kw_1779486245
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D3DE195609E;
	Fri, 22 May 2026 21:44:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A62DA180056E;
	Fri, 22 May 2026 21:44:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v8 mptcp-next 0/9] mptcp: address stall under memory pressure
Date: Fri, 22 May 2026 23:43:41 +0200
Message-ID: <cover.1779485511.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NiXqm2Ry4U7uhdd-ZS6MlSVH-ado2WRgp8P6Hv8aQkY_1779486245
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This an attempt to fix the data transfer stall reported by Geliang and
Gang more carefully enforcing memory constraints at the MPTCP level.

This iteration introduces a few more fixes for pre-existing issues,
and keep the same trade-off as before: avoiding entirely the collapse
attempt on memory pressure. Collapsing allow faster transfer
(to be more accurate: less slow) under some extreme conditions, but
makes transfer slower and much more CPU intensive for less unlikely
conditions.

As a consequences `multi_chunk_sendfile` and `multiproc*` test cases in
mptcp_data *may* require longer timeout than default[1].

Patch 1 - 4 are actually fixes for pre-existing issues targeting net,
included here just for my convenience.

Patch 5 and 6 make the admission check much more strict for incoming
packets exceeding the memory limits, with some exception for fallback
sockets.
Patch 7 implements OoO queue pruning for MPTCP and patch 5
addresses an edge scenario that could still lead to transfer stall
under memory pressure.
Finally patch 8 and 9 improve the MPTCP-level retransmission schema to
make recovery from memory pressure/after MPTCP-level drop significantly
faster.

[1] In my testing on v8 mptcp_data survived a few hundred iterations
with the default timeout. Some independent testing would be appreciated.
---
v7 -> v8:
  - added patch 3 & 4
  - some change for patch 5 avoiding dumb optimizations that added
    complexity. this also allowed removing patch "mptcp: track prune
    recovery status"
  - address some of sashiko feedback

Paolo Abeni (9):
  mptcp: fix missing wakeups in edge scenarios
  mptcp: fix retransmission loop when csum is enabled
  mptcp: close TOCTOU race while computing rcv_wnd
  mptcp: allow subflow rcv wnd to shrink
  mptcp: explicitly drop over memory limits
  mptcp: enforce hard limit on backlog flushing
  mptcp: implemented OoO queue pruning
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  71 +++++++++----
 net/mptcp/protocol.c | 245 ++++++++++++++++++++++++++++++++-----------
 4 files changed, 237 insertions(+), 85 deletions(-)

-- 
2.54.0

