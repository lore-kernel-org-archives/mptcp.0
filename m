Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE53074B7
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628004; cv=none; b=RnWjr6yDm0MQYIfTB2EJ5rY62mSvnjHwKQXhcNFe41wP/zX9CBWzwUTtnOtA2cR7Mq/ABLH3EnOHJ4CkbVU1Qm5YFyC8A4evgrLRNZHZqn0CuD7TTixcCJUR5b2uUyDmfsC7AQgVbKUe89wdYCoGsmvrgM0Sy2jxYecrtEDR8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628004; c=relaxed/simple;
	bh=kUaX/EG/RBGKl7i5HhE+lecIFNy6dVLpLq+kXi4Q5xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=nuMXrmkSZbIiYTuI9JGvpKqZwNYt1LTiJPYvjGizOcO1dEgicmZcpmjpKAcrImv3eXgRjsgwei1+k+8Yt7bwCcVFEWGI+/WGVnWX7VfAHu5g7pwg/3Vp5dr2L6pB/FRRodMg1ielOOscfIPmvRIuLdRizFVXkXmSa9cYERque7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EC4pg0Qy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC4pg0Qy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763628001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o281NNo5OovYGUEZXseeLo3hv+P9wgYPAMixODf2OKE=;
	b=EC4pg0Qy+lPWxtWLbPoaN3WP6yg5kCErKsJPwG0W/y0kRlo5R7LjcFLK4Y4NVZ4iHAepgG
	UjiXZzbJMnby38h5plJWz0fFsDDLX//Ij2wrJlX0pmlzLNOoOjmvXxgf3hdQGR6FQVtGT5
	ZS2VV2mkZWvYZrIkWAuBAL7iwCKUJ+A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-QwXiUa9XPqqSJVyFd30FTw-1; Thu,
 20 Nov 2025 03:39:58 -0500
X-MC-Unique: QwXiUa9XPqqSJVyFd30FTw-1
X-Mimecast-MFC-AGG-ID: QwXiUa9XPqqSJVyFd30FTw_1763627997
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7AA819560A3;
	Thu, 20 Nov 2025 08:39:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8B993001E83;
	Thu, 20 Nov 2025 08:39:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH v7 mptcp-next 0/6] mptcp: autotune related improvement
Date: Thu, 20 Nov 2025 09:39:44 +0100
Message-ID: <cover.1763625391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ew1_FJaIfkwk7uLI6GXDCHlyaAo1vWaETrdog2acm-w_1763627997
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series collects a few follow-up for the backlog refactor, with some
of them posing as fixes just to confuse the enemy.

Targeting net-next as the issues addressed are very old, the change
is quite invasive and, as mentioned, based on the BL refactor.

Overall this:
- introduces a tracepoint similar to tcp useful to track down the issues
  addressed here
- avoid rx drop in corner case scenarios, improving tput stability and
  peak tput over fast link
- refactor the rcv space and rtt estimator, overall making DRS more
  correct and avoiding rcv buffer drifting to tcp_rmem[2], which in
  turn makes the tput more stable and less bursty

Note that after this upstream series will be merged:

https://patchwork.kernel.org/user/todo/netdevbpf/?series=1025209

we want to introduce similar changes in mptcp, too.

I'm sorry for the high frequency spamming; trying to complete this
stuff before ENORESOURCES. Please ignore the previous 2 revisions.
---
v6 -> v7:
   - re added the patches dropped in the last 2 iterations

v5 -> v6:
  - dropped the buggy patch 3/5

v4 -> v5:
  - dropped patch 4/6; it proved to be useless together with new version
    of patch 4/5
  - refactor rtt estimator: use sliding window instead of dropping "too
    high" values

v3 -> v4:
  - dropped already merged patch 1
  - update comment in patch 6/6

v2 -> v3:
  - use __entry->family in patch 1/7
  - more verbose commit message for patch 6/7

v1 -> v2:
  - new patch 1/7
  - old patch 2/4 has been split in 3: 3/7, 4/7 and 5/7
  - refactor both the rcv space init and rtt estimator

Paolo Abeni (6):
  trace: mptcp: add mptcp_rcvbuf_grow tracepoint
  mptcp: do not account for OoO in mptcp_rcvbuf_grow()
  mptcp: fix receive space timestamp initialization.
  mptcp: consolidate rcv space init
  mptcp: better mptcp-level RTT estimator
  mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h |  80 ++++++++++++++++++++++++
 net/mptcp/protocol.c         | 116 ++++++++++++++++++-----------------
 net/mptcp/protocol.h         |  44 ++++++++++++-
 net/mptcp/subflow.c          |   2 -
 4 files changed, 183 insertions(+), 59 deletions(-)

-- 
2.51.1

