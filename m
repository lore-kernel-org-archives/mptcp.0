Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121F746B
	for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692690218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DOUbcuwTkt4hxD0A5qhD2Omqjw/f9iZraPkSBpFCkOY=;
	b=BwB84KSA96SzAUVT2SA2Y3khrNY8vuzIMHyQdlDyUWrpXpTqz3pTVbAfruEWT79pZEGpeJ
	AqQFkI6k9x4Z960Ge5j1f7d+e5Psqa8mSUT2lqo9ialHpUNLgEfMYsxKbFM2SO6VfHGwex
	PFaeqy03zpRtiJsd7efrOkjSPq4+Kyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-y9AmFg3XNi6lFTuLi_mX6g-1; Tue, 22 Aug 2023 03:43:36 -0400
X-MC-Unique: y9AmFg3XNi6lFTuLi_mX6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71D151875840
	for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 07:43:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0284B2026D4B
	for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 07:43:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/2] mptcp: fix missing close transition
Date: Tue, 22 Aug 2023 09:43:24 +0200
Message-ID: <cover.1692690157.git.pabeni@redhat.com>
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

This is an attempt to address the 2nd issue reported in:

https://github.com/multipath-tcp/mptcp_net-next/issues/427

See the individual patch changelog for the details. The cover letter
is here mainly to trigger the CI.

Paolo Abeni (2):
  mptcp: move __mptcp_error_report in protocol.c
  mptcp: process pending subflow error on close

 net/mptcp/protocol.c | 41 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 36 ------------------------------------
 2 files changed, 41 insertions(+), 36 deletions(-)

-- 
2.41.0

