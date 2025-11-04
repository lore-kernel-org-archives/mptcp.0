Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932E2BDC29
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293122; cv=none; b=RJZOTqWtJWNRu6RaJUVcAA1SG8hTZmpatr0UFTaR8LYIDyYYmTyjz8sR8zV+Rhpp9ZRaf2l9JHxyxIhCcbzGO6D0X0dYtbw4u634gsXyqC2zUAY24cFsHT5bOZpfZEjgItrXAm4a4mLqVbPIdE5rXi+YxWY+RpZJNg6Sh5WcmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293122; c=relaxed/simple;
	bh=rTM4BGneG8G9iu3XQluirBsnneoUgZBSSJJv2TNUuWU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=bKNNV6KSvZvDqnTgJoop+yfTZAI3syHce0Kygj2Hr2IpyFPROzQI0ZhH6vupyoyGSBmIXU9dypcj505PfjheyAcjRi50YSuAfhDTHdNb3p+HDhpbJy/a+1fdKKe+VkqVR13CKGWNTg4XWwgpIIZgmrE55DVS0KkBkO9RFtggX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9NuqjOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9NuqjOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762293119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sA6bjmlJ9zYH+bnJ3VJwSRf5PTQlk6ACoWjsYjQLilo=;
	b=F9NuqjOLKKp9Ot/9bQG9wDdkxPL2sNdScG8sem1LMfQO2GIqrr9kBerchLTcwrCZ/U9g7v
	NWOr0h1bDS/YuVQchnethXghlKWe5MEio/BKfZULVZ4c67Ys3/PCU7rCCMF7mzUxwn55tG
	sEonwVj1vVT/s0pmiGNAGs2ePnR87nc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-UPzTHuEsOvOZBeHBbPEcVw-1; Tue,
 04 Nov 2025 16:51:58 -0500
X-MC-Unique: UPzTHuEsOvOZBeHBbPEcVw-1
X-Mimecast-MFC-AGG-ID: UPzTHuEsOvOZBeHBbPEcVw_1762293117
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9864D1956046
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:51:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8650F19560A2
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:51:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/7] mptcp: autotune related improvement
Date: Tue,  4 Nov 2025 22:51:34 +0100
Message-ID: <cover.1762292476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bp77Lctc7h8NPpjcHOkIsCauJg6ZmcMXi6mU-Nsbs1Y_1762293117
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series collects a few follow-up for the backlog refactor, with some
of them posing as fixes just to confuse the enemy (or feel the season
mood)

Targeting net-next as the issues addressed are very old, the change
is quite invasive and, as mentioned, based on the BL refactor.

Only patch 2/7 could be considered for net, but still included because
somewhat related to the others and to keep my life easy.

Overall this:
- introduces a tracepoint similar to tcp useful to track down the issues
  addressed here
- avoid rx drop in corner case scenarios, improving tput stability and
  peak tput over fast link
- refactor the rcv space and rtt estimator, overall making DRS more
  correct and avoiding rcv buffer drifting to tcp_rmem[2], which in
  turn makes the tput more stable and less bursty
---
v1 -> v2:
  - new patch 1/7
  - old patch 2/4 has been split in 3: 3/7, 4/7 and 5/7
  - refactor both the rcv space init and rtt estimator

Paolo Abeni (7):
  trace: mptcp: add mptcp_rcvbuf_grow tracepoint
  mptcp: avoid unneeded subflow-level drops.
  mptcp: fix receive space timestamp initialization.
  mptcp: consolidate rcv space init
  mptcp: better rcv space initialization
  mptcp: better mptcp-level rtt estimator
  mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h |  74 +++++++++++++++++
 net/mptcp/options.c          |  31 +++++++
 net/mptcp/protocol.c         | 154 ++++++++++++++++++++++-------------
 net/mptcp/protocol.h         |  44 +++++++++-
 net/mptcp/subflow.c          |   5 +-
 5 files changed, 247 insertions(+), 61 deletions(-)

-- 
2.51.0

