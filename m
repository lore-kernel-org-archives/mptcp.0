Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9172
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629481469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pi4k/5UtarekVAzzZ8Cf5ha8OImqZLcgZd0Z+OoLktw=;
	b=KHuqU2OG6NEym+AOTPzot1Gpc0wOGLk54p/8oPGW1Jtln+U8QhCy9ZoxGqXhUmq3Ol9Hv2
	+mBbEvFLrCMNIxLHbQJ2WanoB3xCh6/3wywlQ0KiWF0ErFnGtzXMZMUqsR1dXWNhtI8Eas
	KaqcHpIbKIfgJXKQrnEKzhM/n6xltVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-7gsex1zcOey5W74zVkzRoQ-1; Fri, 20 Aug 2021 13:44:27 -0400
X-MC-Unique: 7gsex1zcOey5W74zVkzRoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0F898015C7
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 681AA5D9D5
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 17:44:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp 0/2] mptcp: a couple of fix - almost
Date: Fri, 20 Aug 2021 19:44:11 +0200
Message-Id: <cover.1629481305.git.pabeni@redhat.com>
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

This are couple of changes poped-up while investigating
issues/219. They does not address the mentioned issue,
but the first one should fix an actual bug, the other
is more a cleanup, so the target tree is undefined ;)

Paolo Abeni (2):
  mptcp: fix possible divide by zero
  mptcp: make the locking tx schema more readable

 net/mptcp/protocol.c | 73 +++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

-- 
2.26.3

