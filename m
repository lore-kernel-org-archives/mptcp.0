Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925E22627
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684963785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O+oRnCzKJ6Rwiii3IRHpoxBCCIi41nsqSt6K+1B/2V8=;
	b=aYLTvZcOxSXE/f2jtnk+6a/6HTsPzTOLNz9DYcOgbyFDItbsLP3QCRnRg6XRxolNWz70k+
	AiFdf99ExolKMrn2XJPb0/1XQ9Om2+Nd60qWIGhvYeIWOoVlxGVJBRX8//HO/g/M0IXnTr
	R4QFMbEXbnumDj+V4JgY9/K/RSfUsSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-x3-ky-7HMZ2PwUTYOiWflg-1; Wed, 24 May 2023 17:29:42 -0400
X-MC-Unique: x3-ky-7HMZ2PwUTYOiWflg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49FBB800969;
	Wed, 24 May 2023 21:29:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97E1D407DEC3;
	Wed, 24 May 2023 21:29:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v5 mptcp-next 0/6] mptcp: add some more diag info
Date: Wed, 24 May 2023 23:29:13 +0200
Message-Id: <cover.1684962909.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is a follow up to the topic discussed in recent pubblic mtg.

Introduces unique id for accurate subflow stats tracking and
aggregate mptcp counters, plus some minimal self-tests.

The tests themself do not take in account support for running on
older kernel.

This is on top of "mptcp: a bunch of data race fixes".

There should be non trivial conflicts with:

"mptcp: use get_retrans wrapper".

v4 -> v5:
 - changed again binary layout for MPTCP_FULL_INFO structs (Matttbe)
 - fixed 32bit build issue
 - reordered the patches, less controversial first

v3 -> v4:
 - change binary layout for MPTCP_FULL_INFO structs (Florian)

v2 -> v3:
 - address Matttbe comments on patch 1, 2 and 5, see the indivdual
   patches changelog for the details

v1 -> v2:
 - introduce MPTCP_FULL_INFO instead of overloading a tcp_info field
 - add related self-tests
 - fix a couple of subflow_id initialization bugs

Paolo Abeni (6):
  mptcp: move snd_una update earlier for fallback socket.
  mptcp: track some aggregate data counters.
  selftests: mptcp: explicitly tests aggregate counters
  mptcp: add subflow unique id
  mptcp: introduce MPTCP_FULL_INFO getsockopt
  selftests: mptcp: add MPTCP_FULL_INFO testcase

 include/uapi/linux/mptcp.h                    |  29 ++++
 net/mptcp/options.c                           |  14 +-
 net/mptcp/protocol.c                          |  24 ++-
 net/mptcp/protocol.h                          |   9 +-
 net/mptcp/sockopt.c                           | 155 +++++++++++++++++-
 net/mptcp/subflow.c                           |   2 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 118 ++++++++++++-
 7 files changed, 332 insertions(+), 19 deletions(-)

-- 
2.40.1

