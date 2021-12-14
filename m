Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABB2CAA
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639501162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rkSCeMcVMJb9CTAlnAiNk0vYbFw2M0zg+NHPla1e+3g=;
	b=CypyoBN2tT9/R6B9GzJHlFLl+7+6RLbHaE9/RVcnhsYMJhWgztRiaPL+4VDKtOWgKV4/hM
	vda5Bz2V2vJHjk6E4SPd99ZM9l/xaArE9NlC2jMqy7q3Z61bXBe0dlwe5FXhhpGvn3fQK7
	/TCKhe/od5mWr1S8km7NrhWqv3icgfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-54d1Qfu5PbC7Cad-q2ERPQ-1; Tue, 14 Dec 2021 11:59:20 -0500
X-MC-Unique: 54d1Qfu5PbC7Cad-q2ERPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E9810B7440
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4CA1059112
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 0/7] mptcp: improve subflow creation on errors
Date: Tue, 14 Dec 2021 17:58:50 +0100
Message-Id: <cover.1639500873.git.pabeni@redhat.com>
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

This iteration tries to add address the feedback on v5, namely
test counter update and locking in write_options. The latter
required quite significant changes in patch 5/7.

Additionally the series now includes the pending cleanup, as
they depends on the previous patches. No changes there WRT the
previous iteration.

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

Paolo Abeni (7):
  mptcp: fix per socket endpoint accounting.
  mptcp: clean-up MPJ option writing.
  mptcp: keep track of local endpoint still available for each msk
  mptcp: do not block subflows creation on errors
  selftests: mptcp: add tests for subflow creation failure
  mptcp: cleanup MPJ subflow list handling
  mptcp: avoid atomic bit manipulation when possible

 net/mptcp/options.c                           |  44 ++--
 net/mptcp/pm.c                                |  24 ++-
 net/mptcp/pm_netlink.c                        | 188 +++++++++++-------
 net/mptcp/protocol.c                          | 158 +++++++--------
 net/mptcp/protocol.h                          |  46 +++--
 net/mptcp/sockopt.c                           |  24 +--
 net/mptcp/subflow.c                           |   9 +-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++++-
 9 files changed, 350 insertions(+), 227 deletions(-)

-- 
2.33.1

