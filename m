Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB242FC876
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778447047; cv=none; b=syl0ZXZ88KZBmoWi2MhXcbEMxIPK8PqfDWQVkH+4ETSKEkfBC+PzSjhs0tZwcs+E48fTLh03+UztJomJzLA3sXPsQL+mqTN+PTLaCxWqfxvMVPciM0F5c6+x6uEGZukhk1PfOuPVi31AP7kMZBIT1wtyQ2LtiZ8PU7MYu3yuUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778447047; c=relaxed/simple;
	bh=FQuEd9ENGUXt95PgvP3xixpt+m/iQ+PsHhkSD9BSmSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=HEv7DWX6q8u263otX58HLW/ywwX60/9BcJWtmDNKxtqnCePwcTfk2d45bhqS/8XwghHtxz6UzA0ebVppVhbpRayGvNwecOy5qgF7qAQPeThiqCCGiifQfNnK0aczDn9hqKbgss4cBvCChovipiAxn2MvKFZ9BcH9gXegCi7e11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eat4YCQ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eat4YCQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778447045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3LypOP4Rb7PilFO+KBLVeYCnjCTAnt70LnBLEcRx0lY=;
	b=Eat4YCQ52JK2J/SBXbk4vBq+7UhjqgA6i4qAML2EI1Itsz8tZERAN8N7iixNQlJWywqqem
	lC9bHYHXyPcjoJdkXAocKvC0Yur8PPub1Ds++ERYd0caJIrr8I2dhV0/IjwUD1JY5veFaR
	VNuhy4okFtWwQOqgPKkZ39dJWWj1I9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-HxYlMOeONrScm7JvogY6oA-1; Sun,
 10 May 2026 17:04:01 -0400
X-MC-Unique: HxYlMOeONrScm7JvogY6oA-1
X-Mimecast-MFC-AGG-ID: HxYlMOeONrScm7JvogY6oA_1778447041
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C48A2195608D;
	Sun, 10 May 2026 21:04:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2E7C180034E;
	Sun, 10 May 2026 21:03:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next v5 00/12] mptcp: address stall under memory pressure
Date: Sun, 10 May 2026 23:03:35 +0200
Message-ID: <cover.1778446731.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jTHQAdYcVmUOAH73pQQjU5OQFamcirOTXuFaakKXCBs_1778447041
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
Jast a few minor updates over v4 (that was misnamed without revision) to
deal with sashiko's feedback (some was irrelevant/wrong, mentioned as
reported on the previous revision). Changes described in the individual
patches.
Patch 1 should go via net, included here for my own sake :-P

*** BLURB HERE ***

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
 net/mptcp/options.c  |  74 ++++++-
 net/mptcp/protocol.c | 487 +++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |  24 ++-
 net/mptcp/subflow.c  |  11 +
 9 files changed, 492 insertions(+), 189 deletions(-)

-- 
2.54.0

