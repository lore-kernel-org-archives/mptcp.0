Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1868
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638812096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rMYZFuseQJeFZ1LgdRW5ZjlMsA5LdelfbJN2j6XDydc=;
	b=A9NXfJQSxBC7UJy82pYroemdixP3RIoPhQXxX7oay+TnqQ39Bt7SOXc71TXHxaF8bCUdyb
	q5FjC0UZ5FXe4hIqFsj3WGC9tk2POQRKA+x45cWv8KwLXPzOqtiNnUTPCcU7tBsgy+rKNo
	isogLsnqgmPblcx7MhorSf7D1IKXr2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-XKXAMIowO9mG3-UnUlOsIw-1; Mon, 06 Dec 2021 12:34:54 -0500
X-MC-Unique: XKXAMIowO9mG3-UnUlOsIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 996A61927800
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:34:53 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 07F304ABA6
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:34:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: a couple of cleanups
Date: Mon,  6 Dec 2021 18:34:45 +0100
Message-Id: <cover.1638811854.git.pabeni@redhat.com>
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

The first patch was already shared as RFC, this iteration
addresses a couple of bugs there.

The second patch removes a bunch of conditionals and atomic
operations in the fast path, but the performance impact is
actually below noise level. Still I think it's worthy, as the
unneeded atomic operations are confusing.

Paolo Abeni (2):
  mptcp: cleanup MPJ subflow list handling
  mptcp: avoid atomic bit manipulation when possible

 net/mptcp/pm_netlink.c |   3 -
 net/mptcp/protocol.c   | 149 ++++++++++++++++++-----------------------
 net/mptcp/protocol.h   |  31 ++++-----
 net/mptcp/sockopt.c    |  24 ++-----
 net/mptcp/subflow.c    |   9 ++-
 5 files changed, 89 insertions(+), 127 deletions(-)

-- 
2.33.1

