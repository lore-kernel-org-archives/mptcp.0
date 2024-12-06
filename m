Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF11FF7A1
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487017; cv=none; b=qCyI0E8ehX/xop8IL+ICoDQNxk2fmtZ2/Xvk/sycGQKwrRt+/qmRYqJOfBmpLFkUTeN2+B1G9uS3S5eUUyAQLBT9z+hd73X6HuLDg14fSSxVejXEFNCXpu00Ju/ljnW952sBvbSH9dXGE8DQozdr/shoiOvq9RwQIlEGQLZjTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487017; c=relaxed/simple;
	bh=nkwmfx7NPa3JZxNPzZkwS0ns+pGRpYbeHKQS6yPUwvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=TPgJuLV3JP/YfjuTQBBnhNH7kk2n/yqInGGXhnomaJCdu90wl9IwmsVVpP7z6HxU0MqR/ysq/uIZlxw5cgTl0eCrCI9BK4B0a7QwASaNFb35RBx/q0ZAtXrLvTjs8BUb8gGgEP0MIJF7f4WPYyP1/24vBShEpP83hhH700I0n2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R55P60PW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R55P60PW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x6wF4RP8IbYDTw5M02z/JdjS8TXF9CGDu8ng3Uep4RE=;
	b=R55P60PWSJE1ThcorsFJ+0LZvyQnyHQFyNXsjHUK9bh2MQN+fQQB6doezOEAiJc2EYjD1h
	cagto5jNkFZwAQ/zofjtQEV75JiUOzurhtZ0cXsfPf29Bp3bS8M3CuREFzLfwtNLrGhzRw
	r32HwqsySH6tNdEkpU88vGVACTzYnnE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-DG0EmBcVPoebgd0dZuVh9g-1; Fri,
 06 Dec 2024 07:10:12 -0500
X-MC-Unique: DG0EmBcVPoebgd0dZuVh9g-1
X-Mimecast-MFC-AGG-ID: DG0EmBcVPoebgd0dZuVh9g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F1741964CE7
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 114F41955F3F
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 0/7] mptcp: rx path refactor
Date: Fri,  6 Dec 2024 13:09:44 +0100
Message-ID: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FIzelznZFAR3fZd30SAakkWYTyFY8tZVw-b4IwmueBk_1733487012
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is a batch of changes I had sitting in my local tree for a while.
Why another refactor you may ask? Two main resons:

- currently the mptcp RX path introduces quite a bit of 'exceptional'
 accounting/locking processing WRT to plain TCP, adding up to the
 implementation complexity in a misurable way
- the performance gap WRT plain TCP for single subflow connections is
 quite measurable.

The present refactor addresses both the above items: most of the
additional complexity is dropped, and single stream performances
increase measurably - from 55Gbps to 71Gbps in my loopback test. As a
reference, plain TCP is around 84Gps on the same host.

The above comes to a price: the patch are invasive, even in subtle ways:
the chance of destabilizing the implementation is real (ence the
additional, intentional '-next' into the subj).

In any case keeping the patch hidden for longer was not going to do any
good, so here we are.

Changes from v1:
  - fixed several data stream corruption and wake-up misses due
    to multi subflows races
  - added patches 1-3 mainly to address the above
  - added an additional follow-up patch (patch 7) with more cleanup

Paolo Abeni (7):
  mptcp: prevent excessive coalescing on receive
  tcp: fix recvbuffer adjust on sleeping rcvmsg
  mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
  mptcp: consolidate subflow cleanup
  mptcp: move the whole rx path under msk socket lock protection
  mptcp: cleanup mem accounting.
  net: dismiss sk_forward_alloc_get()

 include/net/sock.h   |  13 ---
 net/core/sock.c      |   2 +-
 net/ipv4/af_inet.c   |   2 +-
 net/ipv4/inet_diag.c |   2 +-
 net/mptcp/fastopen.c |   4 +-
 net/mptcp/protocol.c | 259 +++++++++++++------------------------------
 net/mptcp/protocol.h |   6 +-
 net/mptcp/subflow.c  |  33 +++---
 net/sched/em_meta.c  |   2 +-
 9 files changed, 104 insertions(+), 219 deletions(-)

-- 
2.45.2

