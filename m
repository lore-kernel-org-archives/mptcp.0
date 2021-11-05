Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02632C9B
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636109369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=83Nsg6PcCvNxJ82jpEI1Gf/ZLuPYzIQXu+ne860RdPg=;
	b=UBSWsL3fJRuP5xTW5ZoPJj/nZffT9FlqkfYDFOIowDOya+Bz6ZUK87N6O0CMPmKUAc6ioI
	CDKUAcPBY/ijCcjGU9KcY6iBoa5A3+52zTjpw0ZZMUYGB6Xfq3zWCtZMRVLxaPS865a+44
	cYvHRe2Qb0soVByjOKStDmd7FzHXroY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-hhG3D9Q9NrGu4EdJsDJrcw-1; Fri, 05 Nov 2021 06:49:28 -0400
X-MC-Unique: hhG3D9Q9NrGu4EdJsDJrcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2236B101AFA9
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.132])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 831A35D9D3
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 10:49:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [RFC PATCH 0/3] mptcp: improve accept() and disconnect()
Date: Fri,  5 Nov 2021 11:49:09 +0100
Message-Id: <cover.1636107361.git.pabeni@redhat.com>
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

As outlined in the public mtg, mptcp_accept() is currently quite
suboptimal, both from performance and code complexity

This series tries to clean it up, enforcing a wider lifetime for
the initial subflow, so that we don't need to acquire additional
references there.

To reach such goal we need to properly define the disconnect()
behavior, which is currently quite incomplete.

Some additional self-tests is likely required, 

Paolo Abeni (3):
  mptcp: never allow the PM to close a listener subflow
  mptcp: full disconnect implementation
  mptcp: cleanup accept and poll

 net/mptcp/pm.c         |  10 ++--
 net/mptcp/pm_netlink.c |   3 ++
 net/mptcp/protocol.c   | 120 ++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h   |  15 +++++-
 net/mptcp/subflow.c    |   1 -
 net/mptcp/token.c      |   1 +
 6 files changed, 102 insertions(+), 48 deletions(-)

-- 
2.26.3

