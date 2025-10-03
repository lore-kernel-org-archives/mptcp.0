Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5A1FDE01
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500121; cv=none; b=CmEb/EP/eejF9R/RCUHSoPMFdf6fjT4dYlMA0pBNBF2Vviq9ZjufaV+a9ynJ55vE1yjc66aHv0ReAgCg5iDfvLZukZ9VMtvZ0XuavKbnX0Ka7kKFeWqGQZ+Y74xretEu137nhKkVSj5w/KtjH5xvzMXuHdaRtYKi4/SiXAJwolo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500121; c=relaxed/simple;
	bh=BOpNU5r86U7QWUNcxXP1N+ahapdohtHv0f7TPRwrBMc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=iWPenHKewGQdvc8himq/YKBfbAy7NuP8sClQQPdHWnLuOui3XFccinRliB/HZ41cs0H8hNDHzYou4Rd1POlotORIMDPcm4DU5NnPWWPIUyA6VKtUGNvZZiRQNspquIHxzbsAUkG25g2Ez4v/VN9zNRQMjf4KOF90wCg+LWqYnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXwV/hMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXwV/hMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1hRKwNi51rfgQAncXnrC8ZBvS07gGaGNI+uWdzeNxhU=;
	b=HXwV/hMe0wr5Df1GWPwa+qn6HSUqouJuxNE2FBM4yXZQIQNWuiOhDbNU8cD69Q2FVc+cBx
	sOqrF9Io1Q9MHufSR85HgIkDGO7VcPlcgmGJfvJTBg4I1J7HBAusVmD+4DB8o8Qg+ZRtU+
	h+epNad3Ek65c9LPu8QVR3P5yjYj17w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-KDUYTMOXNTm4Ol7cICKcMA-1; Fri,
 03 Oct 2025 10:01:54 -0400
X-MC-Unique: KDUYTMOXNTm4Ol7cICKcMA-1
X-Mimecast-MFC-AGG-ID: KDUYTMOXNTm4Ol7cICKcMA_1759500114
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C91CD1800592
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E819D18004D8
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 0/8] mptcp: introduce backlog processing
Date: Fri,  3 Oct 2025 16:01:38 +0200
Message-ID: <cover.1759499837.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zFvaH-4yoSQL0R-qCov6sFbWS-z6VBK7nVRCyBgyp38_1759500114
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series includes RX path improvement built around backlog processing

The main goals are improving the RX performances _and_ increase the
long term maintainability.

Patches 1-3 prepare the stack for backlog processing, removing
assumptions that will not hold true anymore after backlog introduction.

Patch 4 fixes a long standing issue which is quite hard to reproduce
with the current implementation but will become very apparent with
backlog usage.

Patches 5 and 6 are more cleanups that will make the backlog patch a
little less huge.

Patch 7 is a somewhat unrelated cleanup, included here before I forgot
about it.

The real work is done by patch 8. There are significant changes vs the
previous iteration, as it turned out we can't uset the sk_backlog, as
the mptcp release callback can also release and re-acquire the msk-level
spinlock and core backlog processing works under the assumption that
such event is not possible.

Other relevant points are:
- skbs in the backlog are _not_ accounted. TCP does the same, and we
  can't update the fwd mem while enqueuing to the backlog as the caller
  does not own the msk-level socket lock nor can acquire it.
- skbs in the backlog still use the incoming ssk rmem. This allows
  backpressure and implicitly prevent excessive memory usage for the
  backlog itself
- [this is possibly the most critical point]: when the msk rx buf is
  full, we don't add more packets there even when the caller owns the
  msk socket lock. Instead packets are added to the backlog. Note that
  the amount of memory used there is still limited by the above. Also
  note that this implicitly means that such packets could stage in the
  backlog until the receiver flushes the rx buffer - an unbound amount
  of time. That is not supposed to happen for the backlog, ence the
  criticality here.

This survived a few hours of selftest iterations in a loop: should
address all functional issues observed in previous iterations (and
possibly includes different ones ;)

Paolo Abeni (8):
  mptcp: borrow forward memory from subflow
  mptcp: cleanup fallback data fin reception
  mptcp: cleanup fallback dummy mapping generation
  mptcp: fix MSG_PEEK stream corruption
  mptcp: ensure the kernel PM does not take action too late
  mptcp: do not miss early first subflow close event notification.
  mptcp: make mptcp_destroy_common() static
  mptcp: leverage the backlog for RX packet processing

 net/mptcp/pm.c        |   4 +-
 net/mptcp/pm_kernel.c |   2 +
 net/mptcp/protocol.c  | 306 +++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h  |   7 +-
 net/mptcp/subflow.c   |  12 +-
 5 files changed, 215 insertions(+), 116 deletions(-)

-- 
2.51.0

