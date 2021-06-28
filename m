Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77E70
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624896484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w33VeGN84BALJsoVVXuxXW0wwwXLQVr3fZw63FUX+es=;
	b=SnmnKQXmog4DRuX7MipKZ4Dupfwczofzdo5TZXsT8kGU5BSHHM/b2nxy6lzB4PzWmbHQTq
	gS7pLEBjwxoggbn/B9IBmBsswFzkh2uuXCQ4vWHN5ZbXVl15/1J5KuXEKJfFlrMEo07PBD
	DbQp0l20OJy083JHk7HEHwOcsNLfWtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-FYoYVxxJNQumCuFqFy5Umg-1; Mon, 28 Jun 2021 12:07:56 -0400
X-MC-Unique: FYoYVxxJNQumCuFqFy5Umg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B60802EDB
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 15:54:22 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-129.ams2.redhat.com [10.36.114.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A007F60875;
	Mon, 28 Jun 2021 15:54:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [PATCH mptcp-next 0/7] mptcp: refactor active backup
Date: Mon, 28 Jun 2021 17:54:04 +0200
Message-Id: <cover.1624895054.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

This parameter is currently not configurable: I'm undecited if it should
stay under the pm_netlink APIs or under the sysfs. I've a slightly
preference for the latter. Any opinion welcome!

This is only lightly (but painfully) tests, my proposal it to let
it stage in the export branch for some time.

Paolo Abeni (7):
  mptcp: more accurate timeout
  mptcp: less aggressive retransmission stragegy
  mptcp: handle pending data on closed subflow
  mptcp: faster active backup recovery
  mptcp: add mibs for stale subflows processing
  mptcp: backup flag from incoming MPJ ack option
  selftests: mptcp: add testcase for active-back

 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |   9 +-
 net/mptcp/pm.c                                |  21 ++
 net/mptcp/pm_netlink.c                        |  40 ++++
 net/mptcp/protocol.c                          | 132 ++++++++++---
 net/mptcp/protocol.h                          |  19 +-
 net/mptcp/subflow.c                           |   6 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 185 +++++++++++++++---
 9 files changed, 352 insertions(+), 64 deletions(-)

-- 
2.26.3

