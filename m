Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF82C80
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638544818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WCNznKjQEk1Nyqeqbg9B3OLwj+nHJyzKOu4qQgVRZJY=;
	b=huO8RfNo8NOwv4r8HurNMNlpSbb6p08PQgm4l6nE605Nsk1h2T/aoi8CHA/Kxxzeg2Ms2v
	VOkuKPM38fC/hDKwx7GOXLqv56iYue/JCC4WivsfExPTM4o4mAR1bNsTq8tZ2fejPWoo0h
	mvzmI9YCxUZO/WJuLRFfm5pMYxoMjMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-C-K-gn4pPAOv8niT4RKmzQ-1; Fri, 03 Dec 2021 10:20:15 -0500
X-MC-Unique: C-K-gn4pPAOv8niT4RKmzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEEFA83DD23
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 15:20:14 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.192.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F1215F4EA
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 15:20:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 0/5] mptcp: improve subflow creation on errors
Date: Fri,  3 Dec 2021 16:19:37 +0100
Message-Id: <cover.1638544716.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This iteration addresses the issue catched by the pktdrill
test-cases - namely an underflow on pm->subflows counter.
Additionally includes a related fix on pm counters accounting.

Currently when a subflow connection fails - either the TCP
connection is reset by the peer, or the MPJ handshake never
completes - the in kernel PM don't perform any further action.
Notably no additional subflow creation is attempted.

This series is aimed at improving the in-kernel path manager
behavior in the above scenario:
- each endpoint is used only once per connection (patch 2/4)
- on failure we try to move to the next subflow, if any
  (patch 3/4)

The first patch is minor cleanup, and the last patch adds
specific self-tests.

This should address/close:
https://github.com/multipath-tcp/mptcp_net-next/issues/235
https://github.com/multipath-tcp/mptcp_net-next/issues/242

Paolo Abeni (5):
  mptcp: fix per socket endpoint accounting.
  mptcp: clean-up MPJ option writing.
  mptcp: keep track of local endpoint still available for each msk
  mptcp: do not block subflows creation on errors
  selftests: mptcp: add tests for subflow creation failure

 net/mptcp/options.c                           | 65 +++++++++------
 net/mptcp/pm.c                                | 24 +++++-
 net/mptcp/pm_netlink.c                        | 83 ++++++++++---------
 net/mptcp/protocol.c                          |  6 ++
 net/mptcp/protocol.h                          |  8 +-
 net/mptcp/subflow.c                           |  5 +-
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++++-
 8 files changed, 187 insertions(+), 70 deletions(-)

-- 
2.33.1

