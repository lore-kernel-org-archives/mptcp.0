Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA90881F
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693560507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KMBhr+qUEhVGjCYNBFarafJvgDrcR5Mea4mcx1ILDeE=;
	b=QSqwoX8HcX/hOCczpZckCBcQ5TxdTbsod34pPNOwLT7G1piRbJNf9WRfTZdtMPqiOqMXCq
	lqEigL8tCiUZQVb5XXplJ0eJ5f/utD4GoEzix4m7QxlWvCF2iQdqQw9ahZ88OIxL0yFx7T
	hOXh3EsOt3u+vTcYBqhigDszBOT6dHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-iiomezUfMIeDhMlPPFhBig-1; Fri, 01 Sep 2023 05:28:26 -0400
X-MC-Unique: iiomezUfMIeDhMlPPFhBig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13DC9185A78B
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 09:28:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9538F2026D35
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 09:28:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH MPTCP-next v3 0/2] mptcp: fix another close hang-up
Date: Fri,  1 Sep 2023 11:27:43 +0200
Message-ID: <cover.1693560377.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the TCP subflows close silently due to timeouts, the msk socket
can hang-up indefinitely.

Implement an additional close timeout triggered with the last subflow
close event and move the msk to TCP_CLOSE when it fires.

Should address issues/430 and issues/431.

v2 -> v3:
 - fix int overlflow in patch 2/2

v1 -> v2:
 - fix timeout timer scheduling in patch 2/2 (timeout never fired on v1)

Paolo Abeni (2):
  mptcp: rename timer related helper to less confusing names
  mptcp: implement connection level timeout.

 net/mptcp/protocol.c | 122 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  22 +++++++-
 net/mptcp/subflow.c  |   3 +-
 3 files changed, 83 insertions(+), 64 deletions(-)

-- 
2.41.0

