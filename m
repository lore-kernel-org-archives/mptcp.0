Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F01172F
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 09:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695200975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sF3fEgGpKNzN71pblHJeipiC10NLa9EycAQf6znDM2o=;
	b=Wp8OPRFMA9swYJd/1pZ+TPFYDXJd049jCK4NMAzuio6+yOyKmFKKGjhk+cL/1UBsXnvndp
	8qfwifRkHlPcdSX/RTMV9HWCee9ZtPyvwWyzTHSbLzw1cpuctuOa2uz/T1Ix7OtjroSzEX
	qpTkO3d4yKg26JvYrs6XfZFtzk4iHLs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-mr6cMiWrM-Kcqt9LTQds0A-1; Wed, 20 Sep 2023 05:09:19 -0400
X-MC-Unique: mr6cMiWrM-Kcqt9LTQds0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAA173801BCC;
	Wed, 20 Sep 2023 09:09:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 241BB2156701;
	Wed, 20 Sep 2023 09:09:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-next v4 0/4] mptcp: misc improvement
Date: Wed, 20 Sep 2023 11:09:08 +0200
Message-ID: <cover.1695200723.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

v3 -> v4:
 - added patch 1/4, fixing a pre-existing issue related. That patch
   shoud likely go via -net, included here because the issue can not
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
 net/mptcp/sockopt.c  | 28 +++-----------
 net/mptcp/subflow.c  | 27 +++++++-------
 4 files changed, 111 insertions(+), 81 deletions(-)

-- 
2.41.0

