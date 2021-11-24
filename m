Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E472
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637770953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BqGxBopKBIuQl4LFMFwzyPSB/+1d9IMMRR5SAolS5xU=;
	b=B2RYNJi0sjfBfd8Tlzh/RdwXwaqAlebAlVm0FrcI7tMype7UhYzsYYhCzQOY2CYrNV7DlR
	+tXu4kPW+cTYYi1489bfKi6Toylp30CI02nqHliA7m8r4yk3gESeroXAgycnN5oPqbZ0N7
	pGKmQKhJh0w9rPy8IKLNCrWXEVv+o88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-Sin3Z6TVOnC73-Y_IB-mrw-1; Wed, 24 Nov 2021 11:22:29 -0500
X-MC-Unique: Sin3Z6TVOnC73-Y_IB-mrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E48C51006AA1;
	Wed, 24 Nov 2021 16:22:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.176])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B24C61002388;
	Wed, 24 Nov 2021 16:22:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH mptcp-next v2 0/4] mptcp: improve subflow creation on errors
Date: Wed, 24 Nov 2021 17:22:10 +0100
Message-Id: <cover.1637770883.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

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

@Phil: could you please have a spin in your testbed? this
should really cover your use case for good - modulo bugs

Paolo Abeni (4):
  mptcp: clean-up MPJ option writing.
  mptcp: keep track of used local endpoint
  mptcp: do not block subflows creation on errors
  selftests: mptcp: add tests for subflow creation failure

 net/mptcp/options.c                           | 65 ++++++++++++-------
 net/mptcp/pm.c                                | 29 +++++++++
 net/mptcp/pm_netlink.c                        |  8 ++-
 net/mptcp/protocol.c                          |  6 ++
 net/mptcp/protocol.h                          |  5 +-
 net/mptcp/subflow.c                           |  5 +-
 tools/testing/selftests/net/mptcp/config      |  1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++++++++-
 8 files changed, 156 insertions(+), 28 deletions(-)

-- 
2.33.1

