Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F338138A
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1649673623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AAijhWMEFY2O9P3WsUCyqJWj6rGaEmhht/BN7sTyxv4=;
	b=SZEP/11yHPQFAGG1Sws+EXsqruuAv9DgGqIk3MhrRie/Ce2HBWTI5zIlPMQZyq/36ts9dM
	2iwcMQnVFi2gdcRcJGLu7Gi1A7Cm0WFYDLoGgFMN1H97KT3+yZsSRJljrE7aKX9eLg/o3A
	e9slGWqSl3+VwYruhJKO+LxOHMSJF0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-QA3t55n_PxW_6__DZ6YuYw-1; Mon, 11 Apr 2022 06:40:22 -0400
X-MC-Unique: QA3t55n_PxW_6__DZ6YuYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8026F185A7A4
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0150640E80E0
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [RFC PATCH 0/4] mptcp: improve mptcp-level window tracking
Date: Mon, 11 Apr 2022 12:40:01 +0200
Message-Id: <cover.1649672265.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

I've been chasing bad/unstable performances with multiple subflows
on very high speed links.

It looks like the root cause is due to the current mptcp-level
congestion window handling. There are apparently a few different
sub-issues:

- the rcv_wnd is not effectively shared on the tx side, as each
  subflow takes in account only the value received by the underlaying
  TCP connection. This is addressed in patch 1/4

- The mptcp-level offered wnd right edge is currently allowed to shrink.
  Reading section 3.3.4.:

"""
   The receive window is relative to the DATA_ACK.  As in TCP, a
   receiver MUST NOT shrink the right edge of the receive window (i.e.,
   DATA_ACK + receive window).  The receiver will use the data sequence
   number to tell if a packet should be accepted at the connection
   level.
"""

   I read the above as we need to reflect window right-edge tracking
   on the wire, see patch 3/4.

- The offered window right edge tracking can happen concurrently on
  multiple subflows, but there is no mutex protection. We need an
  additional atomic operation - still patch 3/4

This series additionally bump a few new MIBs to track all the above
(ensure/observe that the suspected races actually take place).

With this series tput in the critical scenario raises from ~26 Gbps
(ranging in 4-30 Gbps) to ~43 Gbps (with min > 33 Gbps)

I guess patch 3/4 is the most debatable - expecially for RFC compliance
Any feedback more then welcome!

Note: still in patch 3/4, I'm unsure that the th->window update is
strictly necessary from functional perspective (e.g. possibly the atomic
operation is enough), I'll try to test that, too.

Paolo Abeni (4):
  mptcp: really share subflow snd_wnd
  mptcp: add mib for xmit window sharing
  mptcp: never shrink offered window
  mptcp: add more offered MIBs counter.

 include/net/mptcp.h   |  2 +-
 net/ipv4/tcp_output.c |  2 +-
 net/mptcp/mib.c       |  4 +++
 net/mptcp/mib.h       |  6 +++++
 net/mptcp/options.c   | 61 +++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c  | 24 +++++++++++------
 6 files changed, 81 insertions(+), 18 deletions(-)

-- 
2.35.1

