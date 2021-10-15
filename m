Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE422C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634312440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y1Qp2gue/qgzLs9eRX8D41y229lD9w3ZmXVVqDS42RM=;
	b=AAeCnshWMkMpujlvzAxesEJStjYFdKoWNUhzJPJjlpED6BvLKJExLmkcKdrNiNSL0VPVvS
	HrHazFzU6VdoDR6/VJdPvcjlprN/jAMLvQYoKGE+WtZ+6a3Roqk3i0AtY6DL6H4HGBtyDF
	ezFpxeo5ylfypugtMEAHtVN4imKu46Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-g-n-thQJMCq2lt2DVvD-5A-1; Fri, 15 Oct 2021 11:40:39 -0400
X-MC-Unique: g-n-thQJMCq2lt2DVvD-5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCBC68015C7
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 15:40:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2743CADD9
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 15:40:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 0/3] mptcp: refactor memory accounting
Date: Fri, 15 Oct 2021 17:39:36 +0200
Message-Id: <cover.1634312286.git.pabeni@redhat.com>
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

This iteration address a fwd alloc memory leak.
Please see the patch 3/3 changelog for the details.

Paolo Abeni (3):
  tcp: define macros for a couple reclaim thresholds
  net: introduce sk_forward_alloc_get()
  mptcp: allocate fwd memory separatelly on the rx and tx path

 include/net/sock.h   |  21 +++-
 net/ipv4/af_inet.c   |   2 +-
 net/ipv4/inet_diag.c |   2 +-
 net/mptcp/protocol.c | 225 ++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  15 +--
 net/sched/em_meta.c  |   2 +-
 6 files changed, 117 insertions(+), 150 deletions(-)

-- 
2.26.3

