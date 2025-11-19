Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07593587A9
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554387; cv=none; b=f9iYgkssuz6UEsYQGcsh1bpZiIvl6gHeMr8+xnaeKUU6vxL8UcNR6kIpnluiduIFUx7rGsV2nqELAAZwXyfsk5Jsm1G4i3HYYoZMuRRpNIR4QVlrWN8G1ZatZ5VOSxta/9RrISWoLIIHHTHo6NsNvO4FSZCAkLWWNn9kV+SiNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554387; c=relaxed/simple;
	bh=pV6wL+Neniwm0WYtCOsE4UxEVlRpLNBLTZrHM3PYhuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=jrpWy/SmBR/SVM5+OoDzqrc29xinnxPlNksQ7uk03NuaqVvRh930cTwaw27GF7MfyonoK8sZe3Ycobe7cO9/04nMrFjKJ3fJohLHVOUnuWHF3HvVbhA58YhUP94WGoy91eWl8K7ukIQHqRCpcKHKkV1uVuaUw6BYsrGJvByy/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dcg3ercW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dcg3ercW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763554384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Bg9c3oNX59bq2PHQqSR4NeTatVWwEtykH/B/iLUU4w=;
	b=Dcg3ercWHAkg6vM66zv/hCp3uTwiYZJLY8KeW8t9uIoeJn2EDjMw/viewJWpkfvfXsmQlz
	Fk3WThryo89ZYszIozLIIavqWItY113G4LXP3UZN7NHZstfojssfgfT0LGjFtd+y5wHXO7
	p2Te/G5Mw1c683JR0nqlWaT2UBLbMcY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-M9vEAHm4M0uEChulOBZJ_Q-1; Wed,
 19 Nov 2025 07:13:03 -0500
X-MC-Unique: M9vEAHm4M0uEChulOBZJ_Q-1
X-Mimecast-MFC-AGG-ID: M9vEAHm4M0uEChulOBZJ_Q_1763554382
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E21918AB419;
	Wed, 19 Nov 2025 12:13:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33C7A19540DF;
	Wed, 19 Nov 2025 12:13:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH mptcp-next v5 0/5] mptcp: autotune related improvement
Date: Wed, 19 Nov 2025 13:12:53 +0100
Message-ID: <cover.1763553361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z0gy5il2OIjjIYagGqq9p4-zD8jGSrN7YwTqp1ADSQM_1763554382
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
---
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

Paolo Abeni (5):
  trace: mptcp: add mptcp_rcvbuf_grow tracepoint
  mptcp: fix receive space timestamp initialization.
  mptcp: consolidate rcv space init
  mptcp: better mptcp-level RTT estimator
  mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h |  80 +++++++++++++++++++++++++
 net/mptcp/protocol.c         | 112 +++++++++++++++++++----------------
 net/mptcp/protocol.h         |  44 +++++++++++++-
 net/mptcp/subflow.c          |   2 -
 4 files changed, 184 insertions(+), 54 deletions(-)

-- 
2.51.1

