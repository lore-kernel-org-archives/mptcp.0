Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD77A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650550839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hp6KD8ZomaIqM8FiVJ8QzD1KYHxW5LaguzEaLz4cTAY=;
	b=KNV2EhVRTr5BTaoJVHPev6vfwaRuR5C+OwGjfclyXnvn6CZWy49psb8URWYyXl0LSWD1yA
	izBpSznUTHVT17nefqpwyz56Eos3jgS/IUKW6foEKBDZ/hG0TXJzH6N1SW/7dTfrXpDEf5
	i7QPhiDWvCODPnkhCPdHYn2sLti4D4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-SX-Ak2dbMhe4CfRQcYOQdA-1; Thu, 21 Apr 2022 10:20:38 -0400
X-MC-Unique: SX-Ak2dbMhe4CfRQcYOQdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1436F185A79C
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.32.181.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BAA5814A4F80
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 14:20:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 0/5] mptcp: improve mptcp-level window tracking
Date: Thu, 21 Apr 2022 16:20:14 +0200
Message-Id: <cover.1650550242.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

I could not access again the host where the issue was su much
noticeable, still in the current setup the tput changes from
[6-18] Gbps to 19Gbps very stable.

 v1 -> v2:
 - pass only the TCP header to tcp_options_write (Mat)
 - fix build issues on some 32 bit arches (intel bot)

RFC -> v1:
 - added patch 3/5 to address Mat's comment, and rebased the
   following on top of it - I hope Eric may tolerate that, it's
   more an hope than guess ;)

Paolo Abeni (5):
  mptcp: really share subflow snd_wnd
  mptcp: add mib for xmit window sharing
  tcp: allow MPTCP to update the announced window.
  mptcp: never shrink offered window
  mptcp: add more offered MIBs counter.

 include/net/mptcp.h   |  2 +-
 net/ipv4/tcp_output.c | 14 ++++++-----
 net/mptcp/mib.c       |  4 +++
 net/mptcp/mib.h       |  6 +++++
 net/mptcp/options.c   | 58 +++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c  | 32 +++++++++++++++---------
 net/mptcp/protocol.h  |  2 +-
 7 files changed, 90 insertions(+), 28 deletions(-)

-- 
2.35.1

