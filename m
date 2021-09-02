Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306E3FC1
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630597963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nq6GYS6TtjgHW5z9du3pS9lEifi0OMkLwF+qdnAGKKA=;
	b=Iz2Y7jFNk8fICUTBcGNFZNnrYYxzrZU6rt+lsf0N4Q7URckv9NmlQdAagij72CNz1Ur57v
	ImUb8IxShd/3swpF5y0FcEC6bTRO9xuKZ9nunWtGlw08fWhNp2YSPNV4KnRk79K5RU9wDJ
	+n4vDB/pSEOgYL9IKVLlmIG3fp0grwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-exvvY3FcODe-tAYbSncoiQ-1; Thu, 02 Sep 2021 11:52:42 -0400
X-MC-Unique: exvvY3FcODe-tAYbSncoiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37CD184A5E0
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 15:52:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A6ACB5D9DC
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 15:52:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/4] mptcp: just another xmit path refactor
Date: Thu,  2 Sep 2021 17:52:10 +0200
Message-Id: <cover.1630595171.git.pabeni@redhat.com>
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

Eric want to revert the tcp_tx_skb_cache. MPTCP relies on it
for skb allocation. Before the revert we need to refactor our
xmit path.

Patch 1 exposes some needed helpers (endorsed by Eric)
Patch 2 contains the nasty new code
Patch 3 revert some core TCP changes not needed anymore
and patch 4 is Eric's revert.

This iteration should hopefully solve the OoB issues I observed with
the previous attempt, changes documented in patch 2.

Eric Dumazet (1):
  tcp: remove sk_{tr}x_skb_cache

Paolo Abeni (3):
  tcp: expose the tcp_mark_push() and skb_entail() helpers
  mptcp: stop relaying on tcp_tx_skb_cache.
  Partially revert "tcp: factor out tcp_build_frag()"

 Documentation/networking/ip-sysctl.rst |   8 --
 include/net/sock.h                     |  19 ----
 include/net/tcp.h                      |   4 +-
 net/ipv4/af_inet.c                     |   4 -
 net/ipv4/sysctl_net_ipv4.c             |  12 --
 net/ipv4/tcp.c                         | 147 +++++++++----------------
 net/ipv4/tcp_ipv4.c                    |   6 -
 net/ipv6/tcp_ipv6.c                    |   6 -
 net/mptcp/protocol.c                   | 132 +++++++++++++---------
 9 files changed, 132 insertions(+), 206 deletions(-)

-- 
2.26.3

