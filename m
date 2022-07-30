Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0023CB
	for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659168299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T7yqnIjjWojhpp2CQ0rk0v2WtqlReKVFubAteBoz6Cs=;
	b=U3OESVytpi7mqcem+Fd/aJmLlQBv30P5vilTS0WqcS3zsbPrOeRWoZ9cR8H2wx/UBVk3TZ
	VxEuKR4IHpFIoFKCMxVwdeAfgagsqtMV5TIb6spTmUJjgLb1ObRawk/lwwit1fUvhWSLWB
	m1BRdCJwfyW4zpcufNNKWPJguql+2c0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-NXMqEBqtOO2duaqGICgSdQ-1; Sat, 30 Jul 2022 04:04:57 -0400
X-MC-Unique: NXMqEBqtOO2duaqGICgSdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01C513C01DA2
	for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 08:04:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85C852026D64
	for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 08:04:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 0/4] mptcp: just another receive path refactor
Date: Sat, 30 Jul 2022 10:04:38 +0200
Message-Id: <cover.1659165378.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is a refresh and rebase of an already shared work:

https://lore.kernel.org/mptcp/cover.1621963632.git.pabeni@redhat.com/
[1]

The motiviation for refreshing this is:

https://lore.kernel.org/mptcp/YtVhyGSsv1CWvPz4@xsang-OptiPlex-9020/

specifically it looks like that properly attaching mem_cg to the
msk socket would be (much?) easier if the RX path and the fwd memory
allocation would be under msk socket lock protection.

The first 2 patches are proably worthy even without the refactor,
but specifically the 2nd one is required to get a good mptcp-level
acking behavior when we move the rx under the socket lock.

The 3rd patch does the real work, and the 4th is a follow-up cleanup.

Back at [1], I measured relevant performance regressions in some
specific cases. I've done the same test here and I now see little to
noise changes. I guess that is mostly due to the better acking
strategy already introduce with commit 949dfdcf343c ("Merge branch 
'mptcp-improve-mptcp-level-window-tracking'") and refined here.

v2 -> v3:
 - dropped obsoleted comment in patch 2/4
 - fixed compile warning in patch 3/4

v1 -> v2:
 - fix build issue in patch 3/4 due to PEBKAC
 - added missing commit messages(!!!) in patch 3/4 & 4/4

Paolo Abeni (4):
  mptcp: move RCVPRUNE event later
  mptcp: more accurate receive buffer updates
  mptcp: move msk input path under full msk socket lock
  mptcp: use common helper for rmem memory accounting

 include/net/mptcp.h  |   2 +
 net/ipv4/tcp.c       |   3 +
 net/mptcp/options.c  |   1 -
 net/mptcp/protocol.c | 219 +++++++++++--------------------------------
 net/mptcp/protocol.h |  12 ++-
 5 files changed, 68 insertions(+), 169 deletions(-)

-- 
2.35.3

