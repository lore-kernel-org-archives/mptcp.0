Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86461D5CC7
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504347; cv=none; b=YUAkkXu2oicIZRyMfD1L9mQ4Y7t/9Qtj69XGiP4TYTW0OT8HX+qgsy+4RIAhHL190/SpQs8Mc9lir8ZfEZXMGWFymXEDZqrmOaPRIICLrDB8PABTUxZFvlimm6UXgKVc+Tu/mFY5nOla4FMHr3uuvVAOWSz/mCmffb5qTHkjhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504347; c=relaxed/simple;
	bh=39E3Qt/BQPxvi22gh8TbiA/uG1q2ZHHksOpkJb6wUW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=b0E60wu66Z0MUfuO5N5/+pL2InoK5Oq9yvqcUsw+oJYdQOMVo7liULRS0p2/VphGQg/Whrf1q4p6qM9ZJL+bWHX2W85nc9a8dVpytvNdfiZInPuTFwC+bn7YJxmuYvd1iskMhXjFuQBhtz57vHZ8nGK8iSWo9ZxXWVktCE+yV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y03RRg5t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y03RRg5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762504344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QTLMPEmg51MFUjyT4mV9tf7s6FkJyg+d7Ww81vCNWLU=;
	b=Y03RRg5tmELdrXvtQqiQmmj3QcWdw7NmWtQ/alZO4pZPcW445dfQs9cJcGQ/jgspHVsNTh
	WOPB9Bz5ID0y53iAKiPdx17lvBLrbKOqAUxmYi5HJDCdsL+DsJwP+6Bd+cjqRNuAt1d/IE
	MwDpTW+D4LN9FKOncainaD/xrOFFEiw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527--p6O9UHwNeeyG8gFyPqkGw-1; Fri,
 07 Nov 2025 03:32:21 -0500
X-MC-Unique: -p6O9UHwNeeyG8gFyPqkGw-1
X-Mimecast-MFC-AGG-ID: -p6O9UHwNeeyG8gFyPqkGw_1762504340
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C14A1956050;
	Fri,  7 Nov 2025 08:32:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 236BA1800361;
	Fri,  7 Nov 2025 08:32:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH v3 mptcp-next 0/7] mptcp: autotune related improvement
Date: Fri,  7 Nov 2025 09:32:04 +0100
Message-ID: <cover.1762504059.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uFjB7uqnZOBPKfx8o4r54FJTZW-H0WTkHDMz_Q3xb0M_1762504340
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
v2 -> v3:
  - use __entry->family in patch 1/7
  - more verbose commit message for patch 6/7

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
  mptcp: better mptcp-level RTT estimator
  mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 include/trace/events/mptcp.h |  77 ++++++++++++++++++
 net/mptcp/options.c          |  31 +++++++
 net/mptcp/protocol.c         | 154 ++++++++++++++++++++++-------------
 net/mptcp/protocol.h         |  44 +++++++++-
 net/mptcp/subflow.c          |   5 +-
 5 files changed, 250 insertions(+), 61 deletions(-)

-- 
2.51.0

