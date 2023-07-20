Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE51383
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689834874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FDNmbIEomNENAP02v04N+mgW2mn3SPxpbD+0GmOmj/g=;
	b=FQ7pLlGs51aabCrEiCxC9G5tTxFUGQZJYN55qg3XMjNs3Qi9MelzFvgGBVU0NS+MSEAMSn
	d6r0F2UbPuoA0/1wtgyvNcUT0CQZP70cNEU5l5KAyazuayViOQ/+CdKVevu0dlYxgv/GiZ
	OaKp3Qlcbve1XA0yextHuhCHLXIbVUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-12xOuenvNfa0JIodyEkriw-1; Thu, 20 Jul 2023 02:34:32 -0400
X-MC-Unique: 12xOuenvNfa0JIodyEkriw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A73800B35
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BFE61454142
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: subflow removal follow-ups
Date: Thu, 20 Jul 2023 08:34:24 +0200
Message-ID: <cover.1689834758.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

A couple of follow-up to the recent refactor.

Patch 1 address the serious issue reported by Christoph/syzkaller.
Patch 2 is just a cleanup.

Anyhow everything is useless untill we fix/revert the tcp induced
mptcp breakage ;)

Paolo Abeni (2):
  Squash-to: "mptcp: avoid unneeded mptcp_token_destroy() call"
  Squash-to: "mptcp: avoid additional __inet_stream_connect() call"

 net/mptcp/protocol.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.41.0

