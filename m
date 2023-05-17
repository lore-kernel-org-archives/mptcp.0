Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1D2C739
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684323346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PlTJ5MRCW3+dY7TmKkUrGNMQpDYeteh1kkEWxuTJygQ=;
	b=KYvRU/G1XgjEKV2pt56V0mVAT3FQ/gtk4lRco4a8I5Y5FTUtpWCrBp4yzFZm6YeUzj5or5
	Oo7fr5VRzxIvp2tp0IGp1e7XBvrXwhlYC4l9IJ6sL7nxVc/WP44Ptd+wbbsBEwIJqCPiZQ
	VHKDpwYf+PPlZU9C3AkcJrJwo0+zdmM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-5-wcaNIHM-WbdOFT5mfxHQ-1; Wed, 17 May 2023 07:35:43 -0400
X-MC-Unique: 5-wcaNIHM-WbdOFT5mfxHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E29983815F6A;
	Wed, 17 May 2023 11:35:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 531E163F7E;
	Wed, 17 May 2023 11:35:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 0/4] mptcp: a bunch of data race fixes
Date: Wed, 17 May 2023 13:35:32 +0200
Message-Id: <cover.1684321532.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The first 2 patches are direct response to recently reported KCSAN
splat.

The later 2 are just by code inspection of related code path. Patch 3/4
is there mostly to make the next one simple, even if the race mentioned
in such patch should be real (but very tiny, if possible at all).

Paolo Abeni (4):
  mptcp: add annotations around msk->subflow accesses
  mptcp: consolidate passive msk socket initialization
  mptcp: fix data race around msk->first access
  mptcp: add annotations around sk->sk_shutdown accesses

 net/mptcp/protocol.c | 86 ++++++++++++++++++++++++++++----------------
 net/mptcp/protocol.h | 14 +++++---
 net/mptcp/subflow.c  | 28 +--------------
 3 files changed, 66 insertions(+), 62 deletions(-)

-- 
2.40.1

