Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED79462
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680204146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=98nZe6AShvj5wQrLODzsRIxvxo93z1jQKYRh5WUlPeg=;
	b=Wf1Mc2sa722E229IGHy4xcHUj+7kZ/31+p2t1Slf75bFO7AUFjGwfQZWWZ9bXSbUbpNFVk
	KWXIddwAaMjGoClr79ah2X7ltGPu+vlkP1zg+x2oSqhGzmYigXMUxyaGvwHPPdDjrU4Q75
	s7syawkSK8CW3/araZg/HO8Rutrn/Uw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-DNEM8ei2Na60bYQmel2Ftg-1; Thu, 30 Mar 2023 15:22:22 -0400
X-MC-Unique: DNEM8ei2Na60bYQmel2Ftg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52FCC100DEAD;
	Thu, 30 Mar 2023 19:22:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B7FE01121330;
	Thu, 30 Mar 2023 19:22:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v3 mptcp-net 0/2] mptcp: a couple of fixes
Date: Thu, 30 Mar 2023 21:22:15 +0200
Message-Id: <cover.1680204074.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

dump cover letter to trigger the CI, see the individual
changelog for the details.

Note that patch  2/2 introduces a behavioral change that hits
the packetdrill test close_before_accept.pkt. The msk socket
will be CLOSED after accept if the first subflow is closed
before accept.

v2 -> v3:
 - fix locking in patch 2/2 as spotted by Matttbe

Paolo Abeni (2):
  mptcp: stops worker on unaccepted sockets at listener close
  mptcp: fix accept vs worker race

 net/mptcp/protocol.c | 54 +++++++++++++++++-----------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 20 deletions(-)

-- 
2.39.2

