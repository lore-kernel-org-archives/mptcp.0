Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FA72
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ElP6AzuFUkXM+y5FQdwBaYkYywQr0a2nGgYpX5BAj48=;
	b=M/NwUkRXfB8E9hWQ+9KKLs91T5zl/AyerhFrsozvIROXkExSHSNw05LV4M/ahXWvJuoonH
	U6CFP3/6M5qKpnyk352siLef7QOsqsJ3v2b0MYT1y8ojkRPIDFN1JUJ7QVHxv34IXiTzGZ
	8zKoC3SPx2Ug4TlorERVc381U2Qe/ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368--1lOZd3eOfKOp9AymK3xZA-1; Tue, 13 Jul 2021 17:13:49 -0400
X-MC-Unique: -1lOZd3eOfKOp9AymK3xZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2707100B3AE
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:48 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 394D860C5F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/8] mptcp: refactor active backup
Date: Tue, 13 Jul 2021 23:13:30 +0200
Message-Id: <cover.1626210682.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This series addresses a bunch of issues somewhat related to active
backup handling. The most visible functial issue addressed here is:

https://github.com/multipath-tcp/mptcp_net-next/issues/191

This series also add some specific self-tests, to cover both
active-backup switch-over and proper usage of backup link.

A new netns parameter is introduced:

stale_loss_cnt - the max amount of mptcp rtx timeouts with no progresses
        and outstanding data over a single subflow needed to declare
        such subflow 'stale': no more data will be queue until some ack
        is observed.

Changes from v1:
 - stale_loss_cnt is now configurable via sysctl
 - addressed buglet noted by Mat on v1
 - fixed timeout update issues in patches 1-2
 - fixed splat in __mptcp_clean_una() on reinection
   - the new self-tests are now less unstable

Paolo Abeni (8):
  mptcp: more accurate timeout
  mptcp: less aggressive retransmission stragegy
  mptcp: handle pending data on closed subflow
  mptcp: cleanup sysctl data and helpers
  mptcp: faster active backup recovery
  mptcp: add mibs for stale subflows processing
  mptcp: backup flag from incoming MPJ ack option
  selftests: mptcp: add testcase for active-back

 Documentation/networking/mptcp-sysctl.rst     |  12 +
 net/mptcp/ctrl.c                              |  26 ++-
 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |   8 +-
 net/mptcp/pm.c                                |  21 ++
 net/mptcp/pm_netlink.c                        |  37 +++
 net/mptcp/protocol.c                          | 187 +++++++++++----
 net/mptcp/protocol.h                          |  31 ++-
 net/mptcp/subflow.c                           |   6 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 215 +++++++++++++++---
 11 files changed, 459 insertions(+), 88 deletions(-)

-- 
2.26.3

