Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450119BA2
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 07:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695368591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/ZXe0tcWnwqVossIxHJBu6JyoWnr5o+6Dn36Nb4zAR0=;
	b=Sw1/Scx7vEwUL5Zz1mK1asMlJqJ9iili+E9pEF0ZLjc3oWB7V5YQGD9z2FatcG1qeakmwF
	NOtATjjPUoCRNttZiIr7TSU6ST272q+EUu5b+XdA1fn67R2Z26ZQ2Su3X9JqXW+OLotigw
	8HcC9GGKArcjCDsal4zmg/iy5gjRrrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-1aa9_t3oN8yuMzMX9TaIFw-1; Fri, 22 Sep 2023 03:43:09 -0400
X-MC-Unique: 1aa9_t3oN8yuMzMX9TaIFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4CA2101AA6D
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 07:43:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7583B140273C
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 07:43:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 0/4] mptcp: misc improvement
Date: Fri, 22 Sep 2023 09:42:58 +0200
Message-ID: <cover.1695368456.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This series is a follow-up the discussion ongoing here:

https://github.com/multipath-tcp/mptcp_net-next/issues/437

Daire reported several sub-optimal MPTCP behaviour on high-latency
links.

At least 3 different items stands off:

* notsent_lowat setting fooling the scheduler
* sub-optimal send buffer autotuning
* delayed acks being de-facto disabled due to subflow rcvlowat

This series is an attempt to address the first 2 points above.

v4 -> v5:
 - dealing with Mat feedback in patch 1/4 and 4/4

v3 -> v4:
 - added patch 1/4, fixing a pre-existing issue related. That patch
   should likely go via -net, included here because the issue can not
   manifest itself until patch 4/4.
   Despite by best attempt to test this, I thing it would be easier
   to just lest syzkaller crunch it more than a bit.

v2 -> v3:
 - avoid ingremental updates, always recompute sum(ssk->sndbuf) to avoid
   drift on memory pressure/decrease
 - add some needed comments

v1 -> v2:
 - fixed compiler warning in patch 3/3 && more local testing

Paolo Abeni (4):
  mptcp: fix delegated action races.
  mptcp: consolidate sockopt synchronization
  mptcp: ignore notsent_lowat setting at the subflow level.
  mptcp: refactor sndbuf auto-tuning.

 net/mptcp/protocol.c | 48 +++++++++++++++---------
 net/mptcp/protocol.h | 89 ++++++++++++++++++++++++++++++--------------
 net/mptcp/sockopt.c  | 33 +++++-----------
 net/mptcp/subflow.c  | 31 ++++++++-------
 4 files changed, 119 insertions(+), 82 deletions(-)

-- 
2.41.0

