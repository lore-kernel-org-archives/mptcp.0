Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B8305948
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589275; cv=none; b=XTq3EAPE8pz2kPVUvQH+mm2cp5X8ikN+4z1tT1HFcM8Ot3orVC42mP4sLOCvPVf86+d4Cz0FcC52eku+JFptYF0OThqWod1sVOmlf+rruYb64QtCHLdEwdgOWEblB9QBAqMokDGSGjH0DnFIeJHlpC4dmhGVV3drEEjy3NU7r1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589275; c=relaxed/simple;
	bh=F69Y2dO5eqdDyzIJ+3u0TUMbPscc4TzF1PF63T4Z0fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=dBM0ZJ7ccqATqUbHKTn/0f0G5MJL3GkBRHK65qsD5E8qFLnM3igCP0+IKVt3N5mA45VwJDm/bThjOZ+wO9cd7t2ws5H6fz54ojeJzGPrQlAxsLTcVWF8z9n5V76UjnMdeGmycBJMxyA/yBcRFfJ4KWSFA3QTJT2+wvjaNhlRYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWzzZlGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWzzZlGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763589273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o4vo8LuqTPl/57uMNKNRw1eIve8CHd3oqJLF04+HWl0=;
	b=fWzzZlGb0D/xbu8ozkW4XiD6Zy36Twio8t3UwwZTzxk3JOvoFuFV13HGUYYo+IOogYZ4WF
	nHewEycVxJqpuePDf+3zhOVM0Dk1lqF7c9ZkFUsk9vJLMzHTquOvytS93aCeh7cpTcxA+4
	BAt5MLAGleF3uWxwQ592aNyQVEWCZJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-utUQGxAeMgeDwcftx9wNog-1; Wed,
 19 Nov 2025 16:54:31 -0500
X-MC-Unique: utUQGxAeMgeDwcftx9wNog-1
X-Mimecast-MFC-AGG-ID: utUQGxAeMgeDwcftx9wNog_1763589270
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C580C19560A3;
	Wed, 19 Nov 2025 21:54:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF92F180049F;
	Wed, 19 Nov 2025 21:54:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH mptcp-next v6 0/4] mptcp: autotune related improvement
Date: Wed, 19 Nov 2025 22:54:19 +0100
Message-ID: <cover.1763588352.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2TDEtSS_eJXrwB0nU-lGG11Pel3acyuFG1PbDdM7PwM_1763589270
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
---
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
*** SUBJECT HERE ***

*** BLURB HERE ***

Paolo Abeni (4):
  trace: mptcp: add mptcp_rcvbuf_grow tracepoint
  mptcp: fix receive space timestamp initialization.
  mptcp: better mptcp-level RTT estimator
  mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h | 80 ++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c         | 83 ++++++++++++++++++++----------------
 net/mptcp/protocol.h         | 43 ++++++++++++++++++-
 3 files changed, 169 insertions(+), 37 deletions(-)

-- 
2.51.1

