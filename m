Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB02139B
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661339904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WX6iLPhcNUQjCEOFokqF6mGfFpIk45tF84KpTdoTwxY=;
	b=h6kloQ0BL1LyCB9ZAIWWWWT05cgEtXmgDqW42tPuEOtVCiIi01tcPDJon0Ota742xncIat
	hGdGsaj2Q+g9YMiFNfxAN4B7lKlbC7e6I5ZrYjIC+qkCEVsjcxm6fwQFgXxast6rdonBrY
	rLaNsVDZAvuBnWjVMZ2q9/MUaltwbiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-Q7Nb7GTlP2aqf1B1GwondQ-1; Wed, 24 Aug 2022 07:18:23 -0400
X-MC-Unique: Q7Nb7GTlP2aqf1B1GwondQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0C5D101A56C
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EDA8492C3B
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 11:18:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: rx path refactor follow-ups
Date: Wed, 24 Aug 2022 13:18:12 +0200
Message-Id: <cover.1661339834.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

A couple of fixes trying to address the self-tests failures
seen after the recent refactor.

Paolo Abeni (2):
  Squash-to: "mptcp: move msk input path under full msk socket lock"
  mptcp: never re-inject data on a single subflow

 net/mptcp/protocol.c | 3 ++-
 net/mptcp/sched.c    | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.37.1

