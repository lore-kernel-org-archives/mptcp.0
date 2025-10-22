Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684035BDB7
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143528; cv=none; b=iP9PGRmSp06S6ZXfFG+DlpDmjtxNq7SgeiYmc9z3s4Ac9vO5NyDtMxq/KaS/wiPJBFIrXjEOceziZ23amwhnCisQLshMcuUbPdp33V7DWyYYZLKIpLTE/oEfaK0F1JpS5apRzvO7igh44k7SjoXtdnaqddyKhe2RadOlEicsPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143528; c=relaxed/simple;
	bh=Qa4HZiNtNqZX/7fbFoQtmcVpofQNvxAUva1P+FISLVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=dxrCAg6JxlLBw9BEgrcgtsce+82OmIRGX2ZYvPJjVj9uiIFiYwXf0H/ymE/V1u/YK+U2KzP6q21VfXBt2Nvk3Lt/m351ExP5k0YmGlYtCC/PHF3msYSlyItbECOnUcx7zH4PlflOhYKeRAJQenXWzfS/bNQhFZFabjS/Bjrgqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V33/lbKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V33/lbKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=roUzjohe4tAzqpa4BBcXJeAnLFHL9j6nsqUKyjTsDHA=;
	b=V33/lbKJQfHlIjlZ3+e+NXuVjlyLFBAtYbBdkkpnXgqmA8Rl74TkvvY2/g8xj9IuHjLOsT
	/ubpTewVoAgD3Bqa/sIS2+yfdjK39byfNx1TWgdnJxisW1Cc4sjM54Sf39U2HVg1o0hKj9
	NTVsPjxwQxGO/2Ic2sMaLqeEkdCukV0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-ts5_tQoZO8u9_DPzB6ZyZw-1; Wed,
 22 Oct 2025 10:32:02 -0400
X-MC-Unique: ts5_tQoZO8u9_DPzB6ZyZw-1
X-Mimecast-MFC-AGG-ID: ts5_tQoZO8u9_DPzB6ZyZw_1761143521
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C60A71800365;
	Wed, 22 Oct 2025 14:32:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50A001956056;
	Wed, 22 Oct 2025 14:31:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 00/11] mptcp: introduce backlog processing
Date: Wed, 22 Oct 2025 16:31:43 +0200
Message-ID: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NWX78SGOGYHUcloCU6qOP8i-cOKmbXZQB2DzjX6k60g_1761143521
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series includes RX path improvement built around backlog processing

The main goals are improving the RX performances _and_ increase the
long term maintainability.

Patches 2-4 prepare the stack for backlog processing, removing
assumptions that will not hold true anymore after backlog introduction.

Patches 1 and 5 fixes long standing issues which are quite hard to
reproduce with the current implementation but the 2nd one will become
very apparent with backlog usage.

Patches 6, 7 and 9 are more cleanups that will make the backlog patch a
little less huge.

Patch 8 is a somewhat unrelated cleanup, included here before I forgot
about it.

The real work is done by patch 10 and 11. Patch 10 introduces the helpers
needed to manipulate the msk-level backlog, and the data struct itself,
without any actual functional change. Patch 11 finally use the backlog
for RX skb processing. Note that MPTCP can't uset the sk_backlog, as
the mptcp release callback can also release and re-acquire the msk-level
spinlock and core backlog processing works under the assumption that
such event is not possible.

A relevant point is memory accounts for skbs in the backlog.

It's somewhat "original" due to MPTCP constraints. Such skbs use space
from the incoming subflow receive buffer, do not use explicitly any
forward allocated memory, as we can't update the msk fwd mem while
enqueuing, nor we want to acquire again the ssk socket lock while
processing the skbs.

Instead the msk borrows memory from the subflow and reserve it for
the backlog - see patch 3 and 11 for the gory details.

Note that even if the skbs can sit in the backlog for an unbounded time,

---
v5 -> v6:
 - added patch 1/11
 - reworked widely patch 10 && 11 to avoid double accounts for backlog
   skb and to address the fwd allocated memory criticality mentioned
   in previous iterations.

Paolo Abeni (11):
  mptcp: drop bogus optimization in __mptcp_check_push()
  mptcp: borrow forward memory from subflow
  mptcp: cleanup fallback data fin reception
  mptcp: cleanup fallback dummy mapping generation
  mptcp: fix MSG_PEEK stream corruption
  mptcp: ensure the kernel PM does not take action too late
  mptcp: do not miss early first subflow close event notification.
  mptcp: make mptcp_destroy_common() static
  mptcp: drop the __mptcp_data_ready() helper
  mptcp: introduce mptcp-level backlog
  mptcp: leverage the backlog for RX packet processing

 net/mptcp/mptcp_diag.c |   3 +-
 net/mptcp/pm.c         |   4 +-
 net/mptcp/pm_kernel.c  |   2 +
 net/mptcp/protocol.c   | 363 ++++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h   |  10 +-
 net/mptcp/subflow.c    |  12 +-
 6 files changed, 272 insertions(+), 122 deletions(-)

-- 
2.51.0

