Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862D37D13D
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312953; cv=none; b=rUCpEp0U81MN40YMcPM8BixID7SDKf8utTMrrczdPPbHctMLngcHpWkkLiU7U+acY/Lb59bKeotHbEVEGCYG2m1c4pt3Ewl4QiPIqEL/HwDpcTBSV2iHzngAnsafvf/V3Xb2dZI718jWOrOXfpn8IbuiWuw4oBqzEJGpv+qGd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312953; c=relaxed/simple;
	bh=Sb1DsUEJpHKY3pqDFCVmL7fID0pIlazexQzGitjU55I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=FqdVrkCEN/aPsBnWzuF7/+uHtFAP+xgipu4FFN33CW99XEJXbZbGZxGtr8wUfXwFXQx9ZBRzlt2Gs2hQMcTYNlP4WDb4KNwvlIaTeMaiq/L1eVqqmqPyCir+jZKiaDbJXTUH4K1Az30blYEJTa4035Q64YBTBLM5oiGTMIoozcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIRyu6RK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIRyu6RK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778312950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VGKA6+js3iB6BPTYzSxIV55zyr3VDafKK2tawWOshbU=;
	b=DIRyu6RKUs6JHk1Q+BuEgcqiNoxU6ECOG8hhPVY8XVfaKaKgMmZ+74g1lb8Mv1oEfgaKwr
	Hmmmy1nVHNlaF9oCQ0poseLDVHwBf35hpZYRbUqaxMOURGPa6wxnzrNu/rYZlliKKnZFhA
	zrUBXUtfuYUHTO84qhrFMvlDHz4csRM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-A60AwxSPPgaqOAfqz4JZLQ-1; Sat,
 09 May 2026 03:49:08 -0400
X-MC-Unique: A60AwxSPPgaqOAfqz4JZLQ-1
X-Mimecast-MFC-AGG-ID: A60AwxSPPgaqOAfqz4JZLQ_1778312947
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DA93180034C;
	Sat,  9 May 2026 07:49:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BEB3180075B;
	Sat,  9 May 2026 07:49:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 00/12] mptcp: address stall under memory pressure
Date: Sat,  9 May 2026 09:48:20 +0200
Message-ID: <cover.1778312843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LsPGtY8hNnrtedmyLFXOhSGG7Pw37OdUC1_z_tgRkm8_1778312947
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This an attempt to fix the data transfer stall reported by Geliang and
Gang more carefully enforcing memory constraints at the MPTCP level.

The first path is from Shardul, included here as the condition addressed
by such a patch is frequently hit in the relevant test-cased.

Patch 2 and 3 makes the admission check much more strict for incoming
packets exceeding the memory limits, with some exception for fallback
sockets.
Patch 4, 5, 6 and 7 are cleanups/refactors finalized to safely re-using
TCP helpers on MPTCP skbs.
Patch 8 makes TCP pruning related helpers available to MPTCP and patch 9
makes use of them. Patch 10 addresses an edge scenario that could still
lead to transfer stall under memory pressure.
Finally patch 11 and 12 improve the MPTCP-level retransmission schema to
make recovery from memory pressure significanly faster.

Tested successfully vs the test cases proposed by Geliang and Gang and
vs the selftests.
---
Some notes on each patch WRT ignored or false positive issues noticed
by sashiko so far.
Patch 1 should go via net, included here for my own sake :-P

Paolo Abeni (12):
  mptcp: do not drop partial packets
  mptcp: explicitly drop over memory limits
  mptcp: enforce hard limit on backlog flushing
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
 net/ipv4/tcp_input.c |  54 +++--
 net/mptcp/fastopen.c |  17 +-
 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  73 ++++++-
 net/mptcp/protocol.c | 478 +++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |  24 ++-
 net/mptcp/subflow.c  |  11 +
 9 files changed, 484 insertions(+), 187 deletions(-)

-- 
2.54.0

