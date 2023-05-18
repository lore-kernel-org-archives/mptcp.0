Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A324E86
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684429166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qhIn9dkFFUgQzUwwWummtYxx71QHieYgSq+/f9k/L8I=;
	b=VoD6stOT84y/BcG2VJUqLrjvBG0xhkGOd4Qc8gTaxeEsBenD4gX0CfqdUbjw0cLIo5ZCGR
	bwK5awfl1CkYx37Vus7Gdvbet194DpH3q+Q5GG7mvAOsF7ES1B52bxIjqihD7W3yexvF12
	w4zSP8zDej1voiXdtQvuR/8TmLYyvmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-BA5N54e_PxurxIa7R929jQ-1; Thu, 18 May 2023 12:59:23 -0400
X-MC-Unique: BA5N54e_PxurxIa7R929jQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE9CF85A5A3;
	Thu, 18 May 2023 16:59:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F729492B01;
	Thu, 18 May 2023 16:59:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v2 mptcp-net 0/5] mptcp: a bunch of data race fixes
Date: Thu, 18 May 2023 18:59:09 +0200
Message-Id: <cover.1684427027.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The patch 1 && 4 are direct response to recently reported KCSAN
splat.

The patch 2 && 3 are just by code inspection of related code path.
Patch 3/5 is there mostly to make the next one simple, even if the race
mentioned in such patch should be real (but very tiny, if possible at
all).

This iteration addresses a compile warning in patch 2/5 reported by
kbuild bot.

Patch 5/5 is new in this round, fixes an unrelated issue found by code
inspection. I should have posted separatelly

Paolo Abeni (5):
  mptcp: add annotations around msk->subflow accesses
  mptcp: consolidate passive msk socket initialization
  mptcp: fix data race around msk->first access
  mptcp: add annotations around sk->sk_shutdown accesses
  mptcp: fix active subflow finalization.

 net/mptcp/protocol.c | 111 +++++++++++++++++++++++++++----------------
 net/mptcp/protocol.h |  14 ++++--
 net/mptcp/subflow.c  |  28 +----------
 3 files changed, 81 insertions(+), 72 deletions(-)

-- 
2.40.1

