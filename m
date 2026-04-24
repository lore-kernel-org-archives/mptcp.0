Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E3326D75
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039752; cv=none; b=MqJMYtMs4FmHmBsCIUshpoE+3PJ6UFUCxlyt38MtTXdAVFQDbLocoYPg9me9yU0GYlGNwHDdU+qhS5qa6Ot1V5500XIMvmlMKxoUQSnUgvmTvnUyAetD06T4+lu93ZG24fuIql+U6VFnW86f9/BNsVIYou0clJfxx746PN3mnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039752; c=relaxed/simple;
	bh=u85FreTORIoAkwedPiy9LiC+uv7WLHLiGybUVeVm+I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=H9HyvN6DLZ4GvaCOBMr55zJe05OG/746Moafz6kiLXjVVB4S+Avt6xU3gbXmZ55mG9vS8eFz4/pBnw5HByW+PPVPof8Znohw2y2CflmF2DIwnf+r7Hj45LClZRyBvhONmhH1+D0yuORtQ1hCO+sX9qO9PqlfLYYsIlp9qTTlMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDsGc/Xd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDsGc/Xd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777039750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rGNsELFEAy5q6hJEnGwekxbjT06M6k5RdJRJQ4FAs54=;
	b=YDsGc/XdWemqgNCIE2dpno3T2ySv6Rlm9r0AdnxX/kmQmIUsrGiRndmFVamI5sZQuwbbHM
	EDoFO/bjJxMc1OQrEOXRSINyXQrYcA0F282rv1XUWYakjvzt1FjeLcPUkILOjpcNhIJdBd
	W/MUGJs0cTMJM5W2qJIKXBtL9qmapBA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-v_7lm-74Pku_lbEgoBK8dA-1; Fri,
 24 Apr 2026 10:09:06 -0400
X-MC-Unique: v_7lm-74Pku_lbEgoBK8dA-1
X-Mimecast-MFC-AGG-ID: v_7lm-74Pku_lbEgoBK8dA_1777039745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B1FC1801BE8;
	Fri, 24 Apr 2026 14:08:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70CA73007CBB;
	Fri, 24 Apr 2026 14:08:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [PATCH mptcp-next v1 0/9] mptcp: address stall under memory pressure
Date: Fri, 24 Apr 2026 16:08:33 +0200
Message-ID: <cover.1777038888.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LjXlREXhl4JFq_XEtdxg5VhFumnQTLnme8BVQHwMk2I_1777039745
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This an attempt to fix the data transfer stall reported by Geliang and
Gang more carefully enforcing memory constraints at the MPTCP level.

Patch 1/9 moves the bound check before entering the TCP socket.
Patch 2, 3 and 4 are cleanups/refactors finalized to safely re-using TCP
helpers on MPTCP skbs.
Patch 5 makes TCP pruning related helpers available to MPTCP and patch 6
makes use of them. Patch 7 addresses an edge scenario that could still
lead to transfer stall under memory pressure.
Finally patch 8 and 9 improve the MPTCP-level retransmission schema to
make recovery from memory pressure significanly faster.

Note that the diffstat is biases by the quite large patch 4/9, which
contains mechanical transformation of existing code; "real" changes are
noticiable smaller.

Tested successfully vs the test cases proposed by Geliang and Gang.
---
RFC -> v1:
 - dropped old patch 4 & 5
 - addressed AI reported comments
 - added retrans refactor.

Paolo Abeni (9):
  mptcp: move checks vs rcvbuf size earlier in the RX path
  mptcp: drop the mptcp_ooo_try_coalesce() helper
  mptcp: remove CB offset field
  mptcp: sync mptcp skb cb layout with tcp one
  tcp: expose the tcp_collapse_ofo_queue() helper to mptcp usage, too
  mptcp: implemented OoO queue pruning
  mptcp: track prune recovery status
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 include/net/tcp.h    |   8 ++
 net/ipv4/tcp_input.c |  55 +++++---
 net/mptcp/fastopen.c |   1 -
 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  55 +++++++-
 net/mptcp/protocol.c | 328 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  11 +-
 net/mptcp/subflow.c  |   2 +
 9 files changed, 323 insertions(+), 143 deletions(-)

-- 
2.53.0

