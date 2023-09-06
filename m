Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0836AB7
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 08:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693989033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OO3X6HvMiAE6OIALMYRN0J+FcObSuxDsLE3a3qJ0T3w=;
	b=EKJcHwr36MNv2Ued8uXc5KMZ8UtS6rZUxaDLG8C2FPFfl36n1PwYNkma8KhI54OTziZokU
	SLAczwvk5xR5+TNGL1Y1+vVO1k4eLKOEnuyCTq71NeVNiIRxeq1P+k/GG2GD0MshFzodA7
	/TxzXR47/SfvUA/sHVMKb75isOJ6i4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-tbuln4H2PwK1XUD9VsN08g-1; Wed, 06 Sep 2023 04:30:32 -0400
X-MC-Unique: tbuln4H2PwK1XUD9VsN08g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4B3C8164E0
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 08:30:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.172])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 449221121314
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 08:30:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v5 0/2] mptcp: fix another close hang-up
Date: Wed,  6 Sep 2023 10:30:26 +0200
Message-ID: <cover.1693988314.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the TCP subflows close silently due to timeouts, the msk socket
can hang-up indefinitely.

Implement an additional close timeout triggered with the last subflow
close event and move the msk to TCP_CLOSE when it fires.

Should address issues/430 and issues/431.

v4 -> v5:
 - let the tout always expire for dead socks (Mat)
 - fix comment type (Mat)
 - targeting net, added fixes tag

v3 -> v4:
 - fix off-by-one in timer update/check (sigh, trival math is too
   hard:/)

v2 -> v3:
 - fix int overlflow in patch 2/2

v1 -> v2:
 - fix timeout timer scheduling in patch 2/2 (timeout never fired on v1)

Paolo Abeni (2):
  mptcp: rename timer related helper to less confusing names
  mptcp: fix dangling connection hang-up

 net/mptcp/protocol.c | 124 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  26 ++++++++-
 net/mptcp/subflow.c  |   3 +-
 3 files changed, 88 insertions(+), 65 deletions(-)

-- 
2.41.0

