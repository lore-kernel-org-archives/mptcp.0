Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C841409122
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210116; cv=none; b=ZhGUn2OQhne+7vJEvxwxKWrK2I41eJvhrkEjtsg3XXHrOkVtQqjh35x2OBzEFxm4d7aKe0uMnpXy6AD6RJEsg/dTOpkgQlVnAyg9Ehv9CanA4D58sI+89kyp2PE95o9S2wD9ejKDm+FFDjoDssesVtdAjFu+eY1n4d9OawVRnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210116; c=relaxed/simple;
	bh=HmnowYhmuQ+2r46Q3i0Y78z/Ma5zCNdgG4TMi++SeU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=DnmuYQPHkcNC58ZU7NJIM9ySik6w13rnETZxNsJV4g8hZB9kCy5wLZfeikq0w2pB10fyUeYEt9MZmLi1X32N3k0EQuhsRsiaWkE0gllbqaEOOK/INpVSumNuaT8pmUB9t8pv4Wdx5w1bEbudzA9vcomzXRg593o6zLliFfAD6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3xptMnE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3xptMnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779210114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cAPibSEgYWc7DRjVOiKlCFwDuwzhwO2M+ZK15kkRM1I=;
	b=A3xptMnEGo4E0LDmGUfyhtMz67+ItOhXK4Dw41H9Si5mhGuv+z+fzrC3IDEGa+WIQvquYC
	PKhgnhdJ85+A7PCEJ1VRUcS2r8nwnDFJxdaQxojVEJHxtG+rt4ciO7eIJ1rQwcsFI9Of1I
	HA7lYkpGGhSGHRNwIFWcFUtIC9dLiak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-WxI_s3nFN264zO4q6pa0rA-1; Tue,
 19 May 2026 13:01:48 -0400
X-MC-Unique: WxI_s3nFN264zO4q6pa0rA-1
X-Mimecast-MFC-AGG-ID: WxI_s3nFN264zO4q6pa0rA_1779210107
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC447180044D;
	Tue, 19 May 2026 17:01:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68CCA1800357;
	Tue, 19 May 2026 17:01:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v7 mptcp-next 0/7] mptcp: address stall under memory pressure
Date: Tue, 19 May 2026 19:01:34 +0200
Message-ID: <cover.1779210016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PBDNd0dbLG0QaL83yyE-UN_uSoMA5K2lJFi8fKIZUcg_1779210107
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This an attempt to fix the data transfer stall reported by Geliang and
Gang more carefully enforcing memory constraints at the MPTCP level.

This iteration presents a significant change WRT the previous one,
avoiding entirely the collapse attempt on memory pressure. Note that
this choice represent a trade off: collapsing allow much faster transfer
(to be more accurate: order of magnitude less slow) under some extreme
conditions, but makes transfer slower and much more CPU intensive for
less unlikely conditions.

As a consequence of the above the `mptcp_data.multi_chunk_sendfile`
test-case needs a 240 seconds timeout to complete successfully:

TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)

The solution performing data collapsing would need similar long timeout
for the multiproc tests cases: mutliproc_even, mutliproc_readers,
mutliproc_writers, mutliproc_sendpage_even, mutliproc_sendpage_readers,
mutliproc_sendpage_writers.

Patch 1 is new in v6, and is actually a fix for an old issue (targeting
net), included here just for my convenience.

Patch 2 and 3 makes the admission check much more strict for incoming
packets exceeding the memory limits, with some exception for fallback
sockets.
Patch 4 makes implement OoO queue pruning for MPTCP and patch 5
addresses an edge scenario that could still lead to transfer stall
under memory pressure.
Finally patch 6 and 7 improve the MPTCP-level retransmission schema to
make recovery from memory pressure/after MPTCP-level drop significantly
faster.
---
v6 -> v7: 
  - address some of sashiko feedback, see individual patches for the
    gory details.

Paolo Abeni (7):
  mptcp: fix missing wakeups in edge scenarios
  mptcp: explicitly drop over memory limits
  mptcp: enforce hard limit on backlog flushing
  mptcp: implemented OoO queue pruning
  mptcp: track prune recovery status
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   2 +
 net/mptcp/options.c  |  66 +++++++++++-
 net/mptcp/protocol.c | 247 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h |  18 ++++
 net/mptcp/subflow.c  |   1 +
 6 files changed, 270 insertions(+), 66 deletions(-)

-- 
2.54.0

