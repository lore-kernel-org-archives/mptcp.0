Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7719D
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650034133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=foj/0Be9Ef29GUOiVw8p6aCaeld57dEn9th8wx8Zv/s=;
	b=VMhm6XUwL/SbW4xJ1+O4x9TGkxZTWQixeA62AbPPM4EKPdVpQDXqqVUqVDY8aGPRMYwLf/
	cwgQlcyxqBFEEgPqnI9scA5txm/8qlU8qXLPWu1drcTdXtiWoXWZSp64IrDcQnzn+kKJBK
	5JR+a6IsGM0ib8QVF/iNm5AbxXbjTpk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-QD8EhhHwODiSDZKvlbp6zg-1; Fri, 15 Apr 2022 10:48:52 -0400
X-MC-Unique: QD8EhhHwODiSDZKvlbp6zg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FD6A1C05158
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 14:48:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95950440AAA
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 14:48:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 0/5] mptcp: improve mptcp-level window tracking
Date: Fri, 15 Apr 2022 16:48:43 +0200
Message-Id: <cover.1650034062.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
 net/ipv4/tcp_output.c | 13 +++++-----
 net/mptcp/mib.c       |  4 +++
 net/mptcp/mib.h       |  6 +++++
 net/mptcp/options.c   | 58 +++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c  | 24 ++++++++++++------
 6 files changed, 84 insertions(+), 23 deletions(-)

-- 
2.35.1

