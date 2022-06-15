Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233A7A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655284624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fcd9SIFmCG8DXZIqI3YDKOCRLl4gyAX4+u/z5XeZyak=;
	b=Zdvw7d6fJ2LxBn6j3yA2nuEDUl6Q5+iJDBwwaW8EErJ3S0uO1/ONvw51s3NnZZ0OZJRDz7
	8CCSVbx+eOVFu7gllJBLk54pnCUqiwAI9+c1SAW9aaFnVFYcskSCe2ETVyuGTVqUp6Q1z9
	boQ0NzrOYBuArYms6nznG5SxFUDBOiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-fFMs0FJbPTKzlWhXepqS0g-1; Wed, 15 Jun 2022 05:17:02 -0400
X-MC-Unique: fFMs0FJbPTKzlWhXepqS0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB16F185A7B2
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCC4C28112
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 09:17:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/5] mptcp: mp_fail related fixes
Date: Wed, 15 Jun 2022 11:16:11 +0200
Message-Id: <cover.1655283387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

While cooking a follow-up for "mptcp: invoke MP_FAIL response when
needed" I stumbled upon a few other MP_FAIL related issues hit my
the self-tests while mangling the above.

All the patches for for the -net tree, and should be applied in-order
around to the squashed-to patch.

Note: with this series I still observe sporardic failures (once every
~200 runs) of tests 95. Given the low frequency here I did not investigate
them yet...

Paolo Abeni (5):
  mptcp: fix error mibs accounting
  mptcp: introduce MAPPING_BAD_CSUM
  Squash-to: "mptcp: invoke MP_FAIL response when needed"
  mptcp: fix shutdown vs fallback race
  mptcp: consistent map handling on failure

 net/mptcp/options.c  |  8 +++---
 net/mptcp/pm.c       |  5 ++--
 net/mptcp/protocol.c | 56 ++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h | 23 ++++++++++++----
 net/mptcp/subflow.c  | 63 ++++++++++++++++++++++++++++----------------
 5 files changed, 111 insertions(+), 44 deletions(-)

-- 
2.35.3

