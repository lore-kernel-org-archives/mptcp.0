Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4B29CA
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694639110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w+yg7Aid0RZZYi26UG+GoC7/sfju+lIEYt9zpPzhRv4=;
	b=XM5E/cF+sG4xgssIPMUtcnr3Zgv0HsGq9GptQSjrbjzRYLI7kRt+h0LpKSYowYe0iNZS8I
	nXIKZc0CwOmwBIFeQ/EcGTRxTCSk8JX7vEtnBS15295s2xVtR8z8ie/wO4Dp9Eu5celgpi
	HLH0cEaVPNe1nYGFMoJPaL1i8rfm/T0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-pQ_1s6iGMSyL8Rj60pqtVg-1; Wed, 13 Sep 2023 17:05:09 -0400
X-MC-Unique: pQ_1s6iGMSyL8Rj60pqtVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0569C185A797
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87A207B62
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/3] mptcp: misc improvement
Date: Wed, 13 Sep 2023 23:04:59 +0200
Message-ID: <cover.1694638162.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This series is a follow-up the the discussion ongoing here:

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

Sending out early after very little testing.

Paolo Abeni (3):
  mptcp: consolidate sockopt synchronization
  mptcp: ignore notsent_lowat setting at the subflow level.
  mptcp: refactor sndbuf auto-tuning.

 net/mptcp/protocol.c | 27 ++++++++++++++++++++++++---
 net/mptcp/protocol.h | 32 +++++++++++++++++++++++++++-----
 net/mptcp/sockopt.c  | 28 ++++++----------------------
 net/mptcp/subflow.c  | 21 ++++++++++-----------
 4 files changed, 67 insertions(+), 41 deletions(-)

-- 
2.41.0

