Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F92577
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666173753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y7r7YnLY1wgAwTgoY9fjwArfo1xFtIZQl0s3nkpTNEU=;
	b=Ej/uqfOaOuDU7Bl2w27HS04gCS9SBL+RcxoPXaVjzLHLYHE/Bl9Dy8vNk6lAonDMBAgffz
	0KfY77Bkth5wzflNEAHrzJmrPyEeo6d0MrBOIsNNJQg/TljgtVrCQh+WMgejy5ck3rN9Ol
	JX3zMr5CUqnu2IgnzZ/CpieAR+K6z1s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-sRsxGDfuOVaEkfcTDGs-RA-1; Wed, 19 Oct 2022 06:02:30 -0400
X-MC-Unique: sRsxGDfuOVaEkfcTDGs-RA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FD308279A8;
	Wed, 19 Oct 2022 10:02:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0876A200BBD2;
	Wed, 19 Oct 2022 10:02:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev,
	David Ahern <dsahern@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/2] udp: avoid false sharing on receive
Date: Wed, 19 Oct 2022 12:01:59 +0200
Message-Id: <cover.1666173045.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4

Under high UDP load, the BH processing and the user-space receiver can
run on different cores.

The UDP implementation does a lot of effort to avoid false sharing in
the receive path, but recent changes to the struct sock layout moved
the sk_forward_alloc and the sk_rcvbuf fields on the same cacheline:

        /* --- cacheline 4 boundary (256 bytes) --- */
                struct sk_buff *   tail;
        } sk_backlog;
        int                        sk_forward_alloc;
        unsigned int               sk_reserved_mem;
        unsigned int               sk_ll_usec;
        unsigned int               sk_napi_id;
        int                        sk_rcvbuf;

sk_forward_alloc is updated by the BH, while sk_rcvbuf is accessed by
udp_recvmsg(), causing false sharing.

A possible solution would be to re-order the struct sock fields to avoid
the false sharing. Such change is subject to being invalidated by future
changes and could have negative side effects on other workload.

Instead this series uses a different approach, touching only the UDP
socket layout. 

The first patch generalizes the custom setsockopt infrastructure, to
allow UDP tracking the buffer size, and the second patch addresses the
issue, copying the relevant buffer information into an already hot
cacheline.

Overall the above gives a 10% peek throughput increase under UDP flood.

Paolo Abeni (2):
  net: introduce and use custom sockopt socket flag
  udp: track the forward memory release threshold in an hot cacheline

 include/linux/net.h  |  1 +
 include/linux/udp.h  |  3 +++
 net/ipv4/udp.c       | 22 +++++++++++++++++++---
 net/ipv6/udp.c       |  8 ++++++--
 net/mptcp/protocol.c |  4 ++++
 net/socket.c         |  8 +-------
 6 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.37.3

