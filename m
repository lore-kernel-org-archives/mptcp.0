Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380D79E6
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693566704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AjRcNqXjMMmMAjmFT3IW1Dfkrx+BPknAzGuUBuJqLPo=;
	b=MD9aRdJTiDeLwOtnnsDTfAKqZeCe71/4gNkKeQdjk3h0DCF38HtG2RED8hUOtZPYNePOBd
	ytUnBp19LaeRFKdX5km1tmGif+nSkjOS7CTpvAkaHxVa0ZvjPsO//ckVtyzX6nWaY1dfH5
	hr8o7I0g4JBDbwXBsOqweBcpAaV3KgY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-0c5PK6wVPGG596Z8DTrHZQ-1; Fri, 01 Sep 2023 07:11:42 -0400
X-MC-Unique: 0c5PK6wVPGG596Z8DTrHZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 930481C18C60
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 11:11:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23EB92011545
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 11:11:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 0/2] mptcp: fix another close hang-up
Date: Fri,  1 Sep 2023 13:11:31 +0200
Message-ID: <cover.1693565414.git.pabeni@redhat.com>
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

v3 -> v4:
 - fix off-by-one in timer update/check (sigh, trival math is too
   hard:/)

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

