Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780779E2
	for <mptcp@lists.linux.dev>; Wed,  8 Feb 2023 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675892660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qcqg6qEQhAIrGWFJPXG9M1eKOCAQP/nzo4Ks5KyRmRg=;
	b=JUQJkx1OLsjws6Uikq2LzfGcTwddOXTGWXUGbiTCU4zNvzH/Ks2sV+xgBvHifuqyy4wxKI
	qHIDCo+E+9MHwFex0d9Hpqr32FE3AUxJiPw/mJU0MLkAjZkKGGcGRFnmhPzZkZ2qonWCn1
	YYl0evlNCYo4NrI0NK62SjC35nbqX5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-RTAKweeVMDKHaqvGrhGaNQ-1; Wed, 08 Feb 2023 16:44:16 -0500
X-MC-Unique: RTAKweeVMDKHaqvGrhGaNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F130811E9C;
	Wed,  8 Feb 2023 21:44:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5236492B00;
	Wed,  8 Feb 2023 21:44:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 0/2] mptcp: tentative fix for issues246 &&
Date: Wed,  8 Feb 2023 22:44:08 +0100
Message-Id: <cover.1675892307.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Sharing these very early, because I can't reproduce the issues locally.
Even the commit messages are early draft.

@Christoph could you please check the relevant repros here?

I *think* there still some refcount problem to address in the new code,
any sharp eyes more then welcome ;)

Targeting -net even if bases on top of corrent mptcp-next, as
the merge window is almost imminent.

Paolo Abeni (2):
  mptcp: use the workqueue to destroy unaccepted sockets.
  mptcp: fix UaF in listener shutdown

 net/mptcp/protocol.c | 27 ++++++++-----
 net/mptcp/protocol.h |  4 +-
 net/mptcp/subflow.c  | 91 +++++---------------------------------------
 3 files changed, 28 insertions(+), 94 deletions(-)

-- 
2.39.1

