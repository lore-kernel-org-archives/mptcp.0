Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CF72C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634289945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x0MGC62Za3MFBVBLcuf1wnb9uoNI4u4Hw+IP/KK9168=;
	b=A8IZlLp/KszPmQo6Q2T/0IOcs5CirL/OB5JjkcranygLvoZSOD3lghBbx0pL25sjbF59sl
	MN9Af9mMElZs3DpA2wkNtGG2ewKdilWCnyEqBxUCJW/eHLvKa6bO5zOHTBuJ6B0I7gNtQL
	5S00jtntLnFoaIgzE4uannncdLGcC94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-JYI5XP-mPniz_MtURgL8RQ-1; Fri, 15 Oct 2021 05:25:43 -0400
X-MC-Unique: JYI5XP-mPniz_MtURgL8RQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14DFF56BC2
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F8365D740
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 09:25:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/3] mptcp: refactor memory accounting
Date: Fri, 15 Oct 2021 11:25:22 +0200
Message-Id: <cover.1634289695.git.pabeni@redhat.com>
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

In this iteration I tried to address the RFC comments and issues.
Please see the patch 3/3 changelog for the details.
Added 2 pre-req patches:
- exposing macro for the reclain "magic numbers"
- implementing forward alloc helper


Paolo Abeni (3):
  tcp: define macros for a couple reclaim thresholds
  net: introduce sk_forward_alloc_get()
  mptcp: allocate fwd memory separatelly on the rx and tx path

 include/net/sock.h   |  21 ++++-
 net/ipv4/af_inet.c   |   2 +-
 net/ipv4/inet_diag.c |   2 +-
 net/mptcp/protocol.c | 220 ++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  15 +--
 net/sched/em_meta.c  |   2 +-
 6 files changed, 113 insertions(+), 149 deletions(-)

-- 
2.26.3

