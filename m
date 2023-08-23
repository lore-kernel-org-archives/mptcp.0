Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDAF8834
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692779333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LR8gbC78UWdKS8IizESrKdvfKccFNAgUa2GUwnnkoIw=;
	b=D6bB1A7FTy1NdsoaTqGokIXCjPPoZWLRNRUVNbUWZxvL67tIL8v0QllTeiRSdOaD6wswtb
	binbUPzVpNg5x2mIfVj4kduRFt+E22wVFiMXP2lB+w0lk/ZfrhadP8bsNYKs3ofw0E37g/
	8zG9qgPLLm7a2EQ0x0p1sjl9bMIl+0E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-NuHDVE4wPMeoAJ8-bq-6dw-1; Wed, 23 Aug 2023 04:28:51 -0400
X-MC-Unique: NuHDVE4wPMeoAJ8-bq-6dw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4910E8D40A1
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:28:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD38C492C14
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:28:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 0/2] mptcp: fix missing close transition
Date: Wed, 23 Aug 2023 10:28:39 +0200
Message-ID: <cover.1692779220.git.pabeni@redhat.com>
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

This is an attempt to address the 2nd issue reported in:

https://github.com/multipath-tcp/mptcp_net-next/issues/427

See the individual patch changelog for the details. The cover letter
is here mainly to trigger the CI.

v1 -> v2:
 - fix compile warning reported by the CI

Paolo Abeni (2):
  mptcp: move __mptcp_error_report in protocol.c
  mptcp: process pending subflow error on close

 net/mptcp/protocol.c | 41 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 36 ------------------------------------
 2 files changed, 41 insertions(+), 36 deletions(-)

-- 
2.41.0

