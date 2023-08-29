Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8D14F6D
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693323571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+k9t5BJeYgzNTj+56yKhnl1tFTKOKTJPLGEVQ+s0z2I=;
	b=GhiiXbeeiWna01Kld2DE+QzIMlnqSb6Lw9w5qrW6AM2JBpP+lX2U3kO+kymf8Lu2W5sONb
	9JHDJCrXomhdCuyju68eVpNA8lGw4cxajddxMgJZk4SRqPsNmde54b5E48h9Q29Lhk9yic
	DhA6KdDf51EZ3IN2pGhsIcMs8m73byQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-DDxK6HO7NCi5p9m-DpJN_g-1; Tue, 29 Aug 2023 11:39:29 -0400
X-MC-Unique: DDxK6HO7NCi5p9m-DpJN_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72C383C17123
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 15:39:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C760040C2063
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 15:39:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 0/2] mptcp: fix another close hang-up
Date: Tue, 29 Aug 2023 17:39:19 +0200
Message-ID: <cover.1693322440.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the TCP subflows close silently due to timeouts, the msk socket
can hang-up indefinitely.

Implement an additional close timeout triggered with the last subflow
close event and move the msk to TCP_CLOSE when it fires.

Should address issues/430 and issues/431.

v1 -> v2:
 - fix timeout timer scheduling in patch 2/2 (timeout never fired on v1)

Paolo Abeni (2):
  mptcp: rename timer related helper to less confusing names
  mptcp: implement connection level timeout.

 net/mptcp/protocol.c | 123 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  22 +++++++-
 net/mptcp/subflow.c  |   3 +-
 3 files changed, 84 insertions(+), 64 deletions(-)

-- 
2.41.0

