Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7194A3E
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668426870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tkbNnVV3eWRk2o2C0Gu4Cwm+ugrfmzaqFgJ8ofZV4LY=;
	b=WhWhhXVxMlgYdGuUqVpu1xyp5VOze4J+l1S6RpImPpdJfuMZXJw6P4ZJ6PHGQh26oRkh4b
	6VeBAuoC0BZ2SHCm60uEu01LjWucvi3MdR6qWRup+5C/t71kFVtX7h/rLEHPKE9BuDP9Ih
	pxU0q0lf4nq61FJnE+Mv9iT07qi5AiU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-QUG8CqacNDyFQzgxl44q3g-1; Mon, 14 Nov 2022 06:54:29 -0500
X-MC-Unique: QUG8CqacNDyFQzgxl44q3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 016622A2AD78;
	Mon, 14 Nov 2022 11:54:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 644D84029A7C;
	Mon, 14 Nov 2022 11:54:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 0/3] mptcp: fix checkpatch splats
Date: Mon, 14 Nov 2022 12:54:04 +0100
Message-Id: <cover.1668426733.git.pabeni@redhat.com>
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

This series addresses a bunch of checkpatch reported issues
on TFO-related patches

Paolo Abeni (3):
  Squash-to: "mptcp: implement delayed seq generation for passive
    fastopen"
  Squash-to: "mptcp: implement delayed seq generation for passive
    fastopen"
  Squash-to: "selftests: mptcp: mptfo Initiator/Listener"

 net/mptcp/fastopen.c                              | 10 ++++++----
 net/mptcp/protocol.h                              |  2 --
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 13 +++++++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.38.1

