Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E870
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621964258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d344DfVhsugm94awgMQxy3YlOA62b/TbkZN0X6G+QQE=;
	b=iFy/+haeW4ieyDyo8bCU2CGZYoKy6xoNbq+VKXW+mf2qOrAJdkesYjzqracd8m1T1KEFN8
	MznXP4xXsrzvz/77at/dwggo+fFTcxjzx4e9bMEZgFIHEgroSJ8xWgTejhJ8rHxrBADNav
	TAm2r3zv828BUPcXqO/WkuttmOCx6vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-ZcthyrYbM1qC6QyrtzAzfw-1; Tue, 25 May 2021 13:37:36 -0400
X-MC-Unique: ZcthyrYbM1qC6QyrtzAzfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE6F800D62
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 17:37:35 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8C34100E113;
	Tue, 25 May 2021 17:37:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [RFC PATCH 0/4] mptcp: just another receive path refactor
Date: Tue, 25 May 2021 19:37:16 +0200
Message-Id: <cover.1621963632.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Some recent issues outlined we have perhaps too much complexity
in the receive path and memory accounting.

After recent changes in release_cb() we can drop most such complexity
in favour of some more traditional RX/memory accounting schema.

This is the result.

The first 2 patches are actually bugfixes, even if I don't understand
why we almost never hit the condition addressed by patch 1/4 (and
the patched kernel hits hit frequently).

The 3rd patch introduces the major change, and the fouth is just
cleanup.

This could have some negative performance effects, as on average more
locking is required for each packet. I'm doing some perf test and will
report the results.

Paolo Abeni (4):
  mptcp: wake-up readers only for in sequence data.
  mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
  mptcp: move the whole rx path under msk socket lock protection
  mptcp: cleanup mem accounting.

 net/mptcp/protocol.c | 298 +++++++++----------------------------------
 net/mptcp/protocol.h |  20 +--
 net/mptcp/subflow.c  |  15 +--
 3 files changed, 68 insertions(+), 265 deletions(-)

-- 
2.26.3

