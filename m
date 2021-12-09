Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF932C9E
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639071051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F+XbRMhrT2H+lzR5fMcQwnyXRk0Vp6n04Elu2yAGRUM=;
	b=Gt7QLRmaTi4bZS3fCSbzjQbm52j9KMv0oWpkPAq9G62NF2SCECtBnr7AMOpYwgtGj7AfW4
	/rtjUwaZoCQa3ny+ogdfj86/OSOnP/C3HNf1B4QZrA8P7pyKNkOUPeTaqGo6oz/0Nbw3P9
	Chh6o+GrpajDjgOlcXOgitjbJqf+l3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-gjlMd7boNouZhg_359067A-1; Thu, 09 Dec 2021 12:30:48 -0500
X-MC-Unique: gjlMd7boNouZhg_359067A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04749100C660
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69E4E5ED27
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 0/5] mptcp: improve subflow creation on errors
Date: Thu,  9 Dec 2021 18:30:37 +0100
Message-Id: <cover.1639070864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This iteration adds tracking for the endpoint used by the MPC subflow,
updated the self-tests accordingly (1 signal tests-case is affected)
and introduces a new test case for the relevant scenario.

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

 net/mptcp/options.c                           |  65 +++++---
 net/mptcp/pm.c                                |  24 ++-
 net/mptcp/pm_netlink.c                        | 142 +++++++++++-------
 net/mptcp/protocol.c                          |   9 +-
 net/mptcp/protocol.h                          |  16 +-
 net/mptcp/subflow.c                           |   5 +-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  79 +++++++++-
 8 files changed, 254 insertions(+), 87 deletions(-)

-- 
2.33.1

