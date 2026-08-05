Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6B346E7A
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945164; cv=none; b=uI/e85JJ923WIpfd/53Mz55mVFl3ngMi6OJXaLWAWTV9/mXygZXMhm6MDe7DaVGAU62R7zVusluBqIp684gNOAbdMdwDk87nwgVixTLhQAxtGGF5pCBzf/aGtowkUnZaB1UZ62H8AupZCEaaOO3LrzMDtlKqVmR6qDU7IpdXFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945164; c=relaxed/simple;
	bh=MsePk1m+udbJvMqvLHJwvl0zf0AC1GHwXH7nHfUPUC0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=KmScdRTFJll8/0j/SPts3jGbAdfcjlvIhDctsIp7yH8YnhST9n3A29Rk7uHj3hIq/EX2i1HlQ4DxbigoIIMVqn6H6BZ10wjidrCuZL9MhjfaT4rTht2SbyXRUqifPS2UyvtOO1NmA6FuM6NjWF2IdGSdWQVAeGQTT5X/CNCqWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQL0NrbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQL0NrbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785945161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAE/E8+LofgbrkLvWM7mcgMtp9y4Vi3X0e2zeuRwBfo=;
	b=ZQL0NrbJgAl4ZAHrkJwKFUsa6tUnmlia97aiRoSGWOfiJO5iQ0Pe6klOWEDz6XbXrLOaV+
	Hinydr3qX7TV1cd92HMUcfsqaTWRp2coyTMbnlFFXpl2mWDX7TY4KSkUKg65LRTG/TqxNc
	uS403FHUC+4CHFDSdkkZYkfeuUiFDJA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-nDZpEYqEO0ilROnDWRI4pA-1; Wed,
 05 Aug 2026 11:52:40 -0400
X-MC-Unique: nDZpEYqEO0ilROnDWRI4pA-1
X-Mimecast-MFC-AGG-ID: nDZpEYqEO0ilROnDWRI4pA_1785945159
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EEA318000A2
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 15:52:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B761330001A2
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 15:52:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/7] mptcp: address stall under memory pressure
Date: Wed,  5 Aug 2026 17:52:22 +0200
Message-ID: <cover.1785943854.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: myJOia3oDSQh2xqd_LvEiQabTU81yzffA4B9Ko0qxlI_1785945159
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This *should* address opus-5 feedback, as observed upstream.

Patches 2 and 6 are new, paches 3, 4 and 7 have been updated, see the
individual changelog for the gory details.

Paolo Abeni (7):
  mptcp: move the retrans loop to a separate helper
  mptcp: move the stale logic out of retrans scheduler
  mptcp: let the retrans scheduler do its job
  mptcp: explicitly drop over memory limits
  mptcp: enforce hard limit on backlog flushing
  mptcp: avoid code duplication in __mptcp_move_skb()
  mptcp: implemented OoO queue pruning

 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  32 ++++-
 net/mptcp/pm.c       |  42 ++++---
 net/mptcp/protocol.c | 272 +++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |   2 +-
 6 files changed, 249 insertions(+), 105 deletions(-)

-- 
2.55.0

