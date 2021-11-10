Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA332C87
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636547549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5suMMttX3N8nlATW//vfI1dJrjTSgADUa5U9D7iSEmI=;
	b=O8hN204dpNTlO6xX/WrCs6Lq+EJ8kVUQvbQJrxvGHYfs6lvnCxHG5Ne+zK/s038CaPISkn
	IaaFloQvMybkCqjnJA4UXkNG0Ha7/NSRWdBykJQXW8aysYNnSPcx9qV0Kd8Cg+My18PE+X
	fzZuXcRKJ+Ss6s1P/Qohrj/e31jG98g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-XJh9QEdGN46MG0e6y7i7Fw-1; Wed, 10 Nov 2021 07:32:28 -0500
X-MC-Unique: XJh9QEdGN46MG0e6y7i7Fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B44102CB34
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:27 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C64F960854
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 0/7] mptcp: improve accept() and disconnect()
Date: Wed, 10 Nov 2021 13:31:33 +0100
Message-Id: <cover.1636545174.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

As outlined in the public mtg, mptcp_accept() is currently quite
suboptimal, both from performance and code complexity

This series tries to clean it up, enforcing a wider lifetime for
the initial subflow, so that we don't need to acquire additional
references there.

To reach such goal we need to properly define the disconnect()
behavior, which is currently quite incomplete. Additionally allow
user-space to really disconnect established connections.

Disconnect() needs in turn an egress FASTCLOSE implementation,
added here according to option R (reset - the simpler form).

Finally, the self-tests need as pre-req Florian's patches implementing
SIOCOUTQ

RFC -> v1:
 - added patches 1/7, 3/7, 6/7, 7/7
 - added a few missing bits in patch 4/7

Paolo Abeni (7):
  mptcp: keep snd_una updated for fallback socket
  mptcp: never allow the PM to close a listener subflow
  mptcp: implement fastclose xmit path
  mptcp: full disconnect implementation
  mptcp: cleanup accept and poll
  mptcp: implement support for user-space disconnect
  mptcp: add disconnect selftests

 net/mptcp/options.c                           |  57 +++++--
 net/mptcp/pm.c                                |  10 +-
 net/mptcp/pm_netlink.c                        |   3 +
 net/mptcp/protocol.c                          | 144 ++++++++++++------
 net/mptcp/protocol.h                          |  16 +-
 net/mptcp/subflow.c                           |   1 -
 net/mptcp/token.c                             |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 119 +++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.sh      |  38 ++++-
 9 files changed, 304 insertions(+), 85 deletions(-)

-- 
2.33.1

