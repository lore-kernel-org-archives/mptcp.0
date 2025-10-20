Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7760E25776
	for <mptcp@lists.linux.dev>; Mon, 20 Oct 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976618; cv=none; b=ZuaTGVDWeBWAPJw/nKX3CW6DGHEW9fHDYm0dHaOp3di1DBqUZ4Z3YiQfFRAh89N7rCkQAT3B0kF62zXCqd5nICe8Ax4Mkttc4OaqFfUdaeKDVkxxy+8cOWlq3nAw8jiPn95eS1bFm+3fMYAg6lw5a/utvvTEjAtdSJw+GcetAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976618; c=relaxed/simple;
	bh=Lt0CDXr6ljAvdSUXwcW0vNi/ttxgoGFf09c65oImVbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=MKUXOkmoRQs079qlVfXh6GGd1vNq9g/2Xuycw5H1JnILpnV3EMvughkDqI04CoFhnEinV5MhnVu7DEbzhBuCB1Rb7lpTsLHolFkS1VIrqn/hkBTyW+2LGCVftHtRKVcw05QqORNEhmQaZFKVT75tCBx8/ZHCgh3qlrZACoodIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX8kV5cx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX8kV5cx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760976615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TctV1MRuv0mT0JzsDs0ZNfA0Gnk1VVB4usaDA1oymVs=;
	b=BX8kV5cxMabB30MHxLUDu769somhJer6io7f435vjGdzAncJQa767P7cmzcuDAPtfWQ5Kk
	Lq8+w7j8JQhcjbSvUJnCV/4G5ke8RqoWdRJlElg37xqVLvDVy3+6rh25pBtABr45+xzhOw
	QbEbDbILuaaH96lDBeAkq9qMQ64NSuQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-jNtUI_fNNP-pGriXPFS8OA-1; Mon,
 20 Oct 2025 12:10:12 -0400
X-MC-Unique: jNtUI_fNNP-pGriXPFS8OA-1
X-Mimecast-MFC-AGG-ID: jNtUI_fNNP-pGriXPFS8OA_1760976611
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CCAB1953995;
	Mon, 20 Oct 2025 16:10:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7482B30001BC;
	Mon, 20 Oct 2025 16:10:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org
Subject: [PATCH mptcp-net 0/2] mptcp: restore zero window probe
Date: Mon, 20 Oct 2025 18:10:00 +0200
Message-ID: <cover.1760976334.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qyvIctVMAHElzqiPpCN-k_pjoT03FgDDdPpdUxc5ywM_1760976611
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It turns out that the issue reported by Geliang on the pending backlog
patches is actually on older one that the new code made more easy
reproducible.

The first patch in the series addresses it[1], the 2nd one introduce new
mibs to hopefully catch this problem sooned.

I have a pktdrill to validate this scenario. I'll share that soon.

@Geliang could you please validate the above in your testbed, on top of
the backlog and splice patches?

[1] at least here, at least with the packet drill reproducer ;)

Paolo Abeni (2):
  mptcp: restore window probe
  mptcp: zero window probe mib

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 15 +++++++++++----
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.51.0

