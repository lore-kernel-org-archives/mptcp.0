Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD321065
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684863454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kq0u4bvR6HcoK62sX/Va7OTPYvfcPi+kxnBE1eoxCI4=;
	b=XwaILLYyVJW7UDtbORt1CQMk1S+mcUbi+gitkSWUjRgTmKocepXLQPQ96Hx2B33xR9samr
	WL9oIBko7VuXVJ8GPYH0V1Z29QbkzLpraeQTP2WY+1bQVpfPTaCt1S5qg6HrWrJNHQaoVC
	mQsVzuAgJMjdzRG1axYXOihkNx/PCvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-A2OzKBhaNoC5dJpkrvZabw-1; Tue, 23 May 2023 13:37:33 -0400
X-MC-Unique: A2OzKBhaNoC5dJpkrvZabw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFCBC85A5BF
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FDC3140E95D
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 17:37:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 0/6] mptcp: add some more diag info
Date: Tue, 23 May 2023 19:37:23 +0200
Message-Id: <cover.1684863309.git.pabeni@redhat.com>
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

This is a follow up to the topic discussed in recent pubblic mtg.

Introduces unique id for accurate subflow stats tracking and
aggregate mptcp counters, plus some minimal self-tests.

The tests themself do not take in account support for running on
older kernel.

This is on top of "mptcp: a bunch of data race fixes".

There should be non trivial conflicts with:

"mptcp: use get_retrans wrapper".

v2 -> v3:
 - address Matttbe comments on patch 1, 2 and 5, see the indivdual
   patches changelog for the details

v1 -> v2:
 - introduce MPTCP_FULL_INFO instead of overloading a tcp_info field
 - add related self-tests
 - fix a couple of subflow_id initialization bugs

Paolo Abeni (6):
  mptcp: add subflow unique id
  mptcp: introduce MPTCP_FULL_INFO getsockopt
  mptcp: move snd_una update earlier for fallback socket.
  mptcp: track some aggregate data counters.
  selftests: mptcp: explicitly tests aggregate counters
  selftests: mptcp: add MPTCP_FULL_INFO testcase

 include/uapi/linux/mptcp.h                    |  21 ++++
 net/mptcp/options.c                           |  14 ++-
 net/mptcp/protocol.c                          |  24 ++--
 net/mptcp/protocol.h                          |   9 +-
 net/mptcp/sockopt.c                           |  97 ++++++++++++++++-
 net/mptcp/subflow.c                           |   2 +
 .../selftests/net/mptcp/mptcp_sockopt.c       | 103 +++++++++++++++++-
 7 files changed, 253 insertions(+), 17 deletions(-)

-- 
2.40.1

