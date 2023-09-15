Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D508CA7A
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694787555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u37Yh4ZgxKC3Z71iWtfmOLMHbj2JPcOVtbYJwowsG64=;
	b=gDqLV2dxVWbUl88FfbvR/JdOz1cW9I72kK27WI4FDbYI3v+F48By0nvRdENVjLpEbKRWYD
	zDDORLzc0KjLGv1BhDZPtOMEMq/mXyrTGqHSAUA+RZnvCapYv00qA8P0EHUYJ8Cvkb8/hl
	cIekmPdoq0PaFgk6fJe13Vr2lhlbReA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-QPAc2hwVPqmMQNOTbq89CQ-1; Fri, 15 Sep 2023 10:19:13 -0400
X-MC-Unique: QPAc2hwVPqmMQNOTbq89CQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DA061834F80
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 14:19:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E20021B20B1
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 14:19:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 0/3] mptcp: misc improvement
Date: Fri, 15 Sep 2023 16:19:05 +0200
Message-ID: <cover.1694787366.git.pabeni@redhat.com>
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

This series is an initial attempt to address the first 2 points above.
I have a tentative patch for the 3rd, but it's nowhere near passing
the self-tests, so it will have to wait a bit.

v2 -> v3:
 - avoid ingremental updates, always recompute sum(ssk->sndbuf) to avoid
   drift on memory pressure/decrease
 - add some needed comments

v1 -> v2:
 - fixed compiler warning in patch 3/3 && more local testing

Paolo Abeni (3):
  mptcp: consolidate sockopt synchronization
  mptcp: ignore notsent_lowat setting at the subflow level.
  mptcp: refactor sndbuf auto-tuning.

 net/mptcp/protocol.c | 21 +++++++++++++----
 net/mptcp/protocol.h | 54 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/sockopt.c  | 28 +++++------------------
 net/mptcp/subflow.c  | 21 ++++++++---------
 4 files changed, 82 insertions(+), 42 deletions(-)

-- 
2.41.0

