Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC344171C1
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuDsPBfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705331808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oi01LyR3MHKmVPySf74NbOwpN6EwFxOIF3GSoULix6Q=;
	b=HuDsPBfO24TNZTnZbTwUtTj1H5LooQhfrVqtfjSDxtzaLOGDJm0HMWyqGksvGVJJBvteRo
	4rhiuUT/AYJEHg/VGL1ZYOm1W6u4k9CijjFld3PkjRTbNH/3M9NEawMyKbYUkJyr8MuSUk
	JpsrUWfFTPpfhNKApGplayVFwwy4YeI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-QFIjutX6MgCqt3WiFq8u_Q-1; Mon,
 15 Jan 2024 10:16:47 -0500
X-MC-Unique: QFIjutX6MgCqt3WiFq8u_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27B683C14945
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA9091C060B2
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 15:16:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/4] mptcp: locking cleanup
Date: Mon, 15 Jan 2024 16:16:29 +0100
Message-ID: <cover.1705331716.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is a preparatory work for the TCP_NOTSENT_LOWAT support. The latter
will need tracking more state under the msk data lock.

Since the locking msk locking schema is already quite complex, do a long
awaited clean-up step, moving several confusing lockless initialization
under the relevant locks.

Note that patches 2-4 carry fixes tag, and could target the net tree,
but AFACIS no real race could really happen even prior to such patches
as the MPTCP-level state machine implicitly ensure proper serialization
of the write accesses, even lacking explicit lock.

Patch 1 has no fixes, but still is logically tied to the other patches.
Possibly we could target net-next for the whole series.

Paolo Abeni (4):
  mptcp: drop the push_pending field
  mptcp: fix rcv space initialization
  mptcp: fix more tx path fields initialization
  mptcp: corner case locking for rx path fields initialization

 net/mptcp/fastopen.c |  6 ++--
 net/mptcp/options.c  |  9 +++---
 net/mptcp/protocol.c | 31 ++++++++++---------
 net/mptcp/protocol.h | 13 ++++----
 net/mptcp/subflow.c  | 71 +++++++++++++++++++++++++++-----------------
 5 files changed, 75 insertions(+), 55 deletions(-)

-- 
2.43.0

