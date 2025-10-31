Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56F333733
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931765; cv=none; b=s1XyZkp32cVB9TBinuJoBMSBI5W8/7iXzinEVN65xO1Do4buCvohfgywzYJmtYkYUbMEakxiqi/34A559MjPiGANw6eX6ElU8le2eZQK1Y67nueiIPV7fL9HofAwz3spVdPn7iF/1o/RVD322aEfC5br7mOEPb6PBMHUwxu+g5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931765; c=relaxed/simple;
	bh=xPkjWlH6JTM0SpY0TPwokv8x2X38UWaB0Jv0ghG2fI8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=E9CF5lU7LXQQPf//EcrWaMiiV6+SGpG5WafOdo5KargCwXh5HvM7lM+RFmvd0V8pGV2u8EzxhVBaYapyGDbsMg36l80+w7dJtrfFYoi3tvMbtdiCCL/FjJMNh/I5la9RndOO7qIW6Op5BqeGI48rZoe7aGcEt8i/pj6nkaaSiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQsyo4ME; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQsyo4ME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761931762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nE/8WhsDvCbE7A2k/YNqghllRlnTGATtGUdLjy5CgyA=;
	b=HQsyo4MElFTU6yUwlJ0IqlGyR75t33m8jwj5chVYaUwjb+yv7KXYWghWWTvOHLEW1n0EBZ
	Dow+EAG5YZ30NbRQauC3WzJuGqQc84UzyZzj1ZzXBAfcUnuaWhYEGTOQlc9Zx6E3iReYy9
	oKWxPtudVfuGxvmZW2iJYcrs44mIyBI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-jvMJ8xTEPKykH0bspePVfA-1; Fri,
 31 Oct 2025 13:29:20 -0400
X-MC-Unique: jvMJ8xTEPKykH0bspePVfA-1
X-Mimecast-MFC-AGG-ID: jvMJ8xTEPKykH0bspePVfA_1761931760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFD4A1956095
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6FC030001A1
	for <mptcp@lists.linux.dev>; Fri, 31 Oct 2025 17:29:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/4] mptcp: autotune related improvement
Date: Fri, 31 Oct 2025 18:29:06 +0100
Message-ID: <cover.1761931390.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OmSXZ_OjcbZrR1sLAf3d-dzgd4RJpu7ZdiaoBTVcMZA_1761931760
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series collects a few follow-up for the backlog refactor, with some
of them posing as fixes just to confuse the enemy (or feel the season
mood)

Targeting net-next as the issues addressed are very old, the change
is quite invasive and, as mentioned, based on the BL refactor.

Only patch 1/4 could be considered for net, but still included because
somewhat related to the others and to keep my life easy.

Paolo Abeni (4):
  mptcp: avoid unneeded subflow-level drops.
  mptcp: fix receive space time initialization.
  mptcp: better mptcp-level rtt estimator
  mptcp: add receive queue awareness in tcp_rcv_space_adjust()

 net/mptcp/options.c  |  31 ++++++++
 net/mptcp/protocol.c | 177 ++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  15 +++-
 net/mptcp/subflow.c  |   2 -
 4 files changed, 150 insertions(+), 75 deletions(-)

-- 
2.51.0

