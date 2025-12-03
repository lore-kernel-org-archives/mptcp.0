Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EB3164B6
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786287; cv=none; b=WPhcFjjkErkTxeQKVH4zPGuIxSllRL82s6Ns4M4dmlvEvkmZ4k8a6m8zlYo0aRevHObAPhIqsNnw9uShzMfpLHEbhVolzyY5f/m0TocclUHr4b8CgXKLuXuHOgII9yQAuwELeSfR7fiFyd44zRxPxsTLuwMA/eaStfP/nroqUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786287; c=relaxed/simple;
	bh=UF0oiwsTFAPiN/OEbZWbXKFJ1M1ADFuKwpjM7rd/9Po=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=QNAn+iaeRr25mo7muIvRjSQ39G1w4oQ280AfQjFe9nLCf/XJZKB1tvVC4p34bcjsqgQAGzFNYSKskYpDdvnlM28K+dooYb727ePWuUFn0P8ZabLyY6ScxoOFlqEoJPoBR9yWQUff0pRuBTtyShcBIpyFyBMeODjRkBnhGT2GOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zdnf4/iD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zdnf4/iD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764786284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YMEpOkwhRJqVsLvrDZITL7/1P+cBaz4PqTSbwXZUBCg=;
	b=Zdnf4/iDUYExuwEL2pBmgiFn9JFhmlswMk6DsUOzjXURMft3K9v6qQEdkSAdA1x+6sKxx4
	YUWCVTL6M8+OUeP7yVIPsNi2XS18q5iNek4IXS2BPYT48oqyTQr5qABgy3mdZ7Du5eRJVC
	sf4XbmOZQSXDG/CDSOmXS1fxfHSAQmg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-PmpeISvmMDe2DOgneiG-ng-1; Wed,
 03 Dec 2025 13:24:43 -0500
X-MC-Unique: PmpeISvmMDe2DOgneiG-ng-1
X-Mimecast-MFC-AGG-ID: PmpeISvmMDe2DOgneiG-ng_1764786282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF0101800358
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA71F19560A7
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/2] mptcp: fix warn on bad status
Date: Wed,  3 Dec 2025 19:24:33 +0100
Message-ID: <cover.1764786151.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oBc6c5oF-Dr5MnDxchywRTqx27XhMluJR7ok2_1feuk_1764786282
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Two somewhat related fixes addressing different issues producing
exactly the same splat (issues/586).

Patch 1 has some cosmetic updates from v1.
Patch 2 is new and addresses Matttbe repro.

Paolo Abeni (2):
  mptcp: fallback earlier on simult connection
  mptcp: ensure context reset on disconnect()

 net/mptcp/options.c  | 10 ++++++++++
 net/mptcp/protocol.c |  7 +++++--
 net/mptcp/protocol.h |  6 ++----
 net/mptcp/subflow.c  |  6 ------
 4 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.52.0

