Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5E3FD3
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 14:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630592445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CagHAmyFIUC4/jkKL3vahCAO1FvP5cLvi6nlDidtGJ4=;
	b=UYF/hH9EtLbYg207n3/2nbsDXOE4YNcA7POolmRYSYCX0Fp0AJwnAU9zF4WbNUoG1HeHhC
	5rWodtbl4NI9bi9FoZcMBSm+PDDDSu2miN7YYv0Y4WMAaoGvX1uPfzlUEp4nh7xWWEmIMI
	Z1vgq/kcTydAFcab4fL5reAEXm3P/jE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-O0nnxecnPkCCEDKAXgwlUg-1; Thu, 02 Sep 2021 10:20:44 -0400
X-MC-Unique: O0nnxecnPkCCEDKAXgwlUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88CBD802C80
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 14:20:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.237])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EA1B11042A40
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 14:20:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/4] mptcp: just another xmit path refactor
Date: Thu,  2 Sep 2021 16:20:28 +0200
Message-Id: <cover.1630591985.git.pabeni@redhat.com>
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

Eric want to revert the tcp_tx_skb_cache. MPTCP relies on it
for skb allocation. Before the revert we need to refactor our
xmit path.

Patch 1 exposes some needed helpers (endorsed by Eric)
Patch 2 contains the nasty new code
Patch 3 revert some core TCP changes not needed anymore
and patch 4 is Eric's revert.

This is only lightly tested, and I already got a slab out-of-bound,
even if I could not reproduce it easily. Sharing early to give to
hopefully give more testing in our CI.

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
 net/mptcp/protocol.c                   | 131 +++++++++++++---------
 9 files changed, 131 insertions(+), 206 deletions(-)

-- 
2.26.3

