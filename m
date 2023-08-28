Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E06AD9
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693220615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s+67ysOBFKoMp+hX0vc4Rk1vjnaNmQt4Y1sBJ/5Ey3k=;
	b=aG4CDbWGng7e8WcGow1gjGBbEs3TBHXJg9fOBFJHz+VWBDtc1wf/MlpFTdjQTd4kdiE8To
	yI9/TouPqAQ5xjKXP7Rrs+gPMgUeUzUcmjOBFOHQI5Wi9rqJY2Rpf97YqXF7t6+GP7/UX6
	b2OvzkDrQKtHsXzXFgypOxcJhrjCsa4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-JHE75IBTPnqzu4ndD78Xhg-1; Mon, 28 Aug 2023 07:03:34 -0400
X-MC-Unique: JHE75IBTPnqzu4ndD78Xhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6C9138210A6
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 11:03:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.159])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66A6AC15E6A
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 11:03:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: fix another close hang-up
Date: Mon, 28 Aug 2023 13:03:27 +0200
Message-ID: <cover.1693220454.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the TCP subflows close silently due to timeouts, the msk socket
can hang-up indefinitely.

Implement an additional close timeout triggered with the last subflow
close event and move the msk to TCP_CLOSE when it fires.

Should address issues/430 and issues/431.

Paolo Abeni (2):
  mptcp: rename timer related helper to less confusing names
  mptcp: implement connection level timeout.

 net/mptcp/protocol.c | 120 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |  22 +++++++-
 net/mptcp/subflow.c  |   3 +-
 3 files changed, 83 insertions(+), 62 deletions(-)

-- 
2.41.0

