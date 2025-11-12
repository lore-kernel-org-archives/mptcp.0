Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114C2FD7D8
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940480; cv=none; b=KDGBE2g6khpmf3IhyAkRiyLmC7RCbhw58HtZhZGg/X39hmledLzz8cAaBVmYMXSxD+l82yCV9LpSa52JIUGQt+v65GySG6HoD8ejTzkoK35kE16KC7Lez5stSYN1I5SSAPB0f5YJO0b5IJYuFzX1nfOjPdVDb9pMnjrAuhrIWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940480; c=relaxed/simple;
	bh=nvkJMNnPorRX+p7Vwwngg3fYSy1lFj4Dawvk65LwaS8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=jGvL/T63EVS0kUfrB8HbLKKopCEiKxtlEafj1Gbj4L24zYU/XDDPnV+xZq1QM6zmAYzHCtgxBUqagUmb9WE3oav3MEW6/rgFzLC/ccIgVyZeYzsbh14s1zJ/rfqsb0OAc+T13BR6a0tkknTKEoETp4s+syT5P5pMFrRtiqGjIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVSh3AzV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVSh3AzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CDiXZ1JceYumZQfI3J0zumE3UPZ6ib5hEww8tByj6aM=;
	b=fVSh3AzVnV1YBhUcfOfxCdcCpCTsKbByG05jgZjP4Pqu9TcHQhEEAf1w3zXnhP9IXTh7q0
	XM3w1WIv7ptxZQpvTwNK9VqfkKxF5qq+c2PI4cE0o0CElKctZh7vdgxcKCdZYB7L00Xvq5
	Pukq0Xh/xyYn11qmVMsw0fF+Pqi2sNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-gsepmz1UONGqSDsms0ggSw-1; Wed,
 12 Nov 2025 04:41:15 -0500
X-MC-Unique: gsepmz1UONGqSDsms0ggSw-1
X-Mimecast-MFC-AGG-ID: gsepmz1UONGqSDsms0ggSw_1762940472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F85919560AD
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E0091955F1A
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 0/6] mptcp: autotune related improvement
Date: Wed, 12 Nov 2025 10:41:00 +0100
Message-ID: <cover.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qf5qMmeVHMEMklcFBU8NrxyxJXKL-udkNif8fE5nEaE_1762940472
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

Paolo Abeni (6):
  trace: mptcp: add mptcp_rcvbuf_grow tracepoint
  mptcp: fix receive space timestamp initialization.
  mptcp: consolidate rcv space init
  mptcp: better rcv space initialization
  mptcp: better mptcp-level RTT estimator
  mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h |  77 +++++++++++++++++
 net/mptcp/protocol.c         | 157 ++++++++++++++++++++++-------------
 net/mptcp/protocol.h         |  43 +++++++++-
 net/mptcp/subflow.c          |   5 +-
 4 files changed, 220 insertions(+), 62 deletions(-)

-- 
2.51.1

