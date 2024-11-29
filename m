Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FD1A08AB
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732902318; cv=none; b=gcz81lyYalCxm4H/xdzNkT5bk+aj4BOCTULTzw/CF3+SeRpFiK0LGyCbHujvdZxrkoBxNkk7xYeWjp7Z3dJM438eW5Y0ByPuv8JcjDcVT9h2Luj/QwzIMIBV0svtJgZalRHgH9WcvKtfNmL/MdTvLk28avWyq+L/wnu82YB16Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732902318; c=relaxed/simple;
	bh=KZY1FSGPxNt4Q+Zyz4px+8Yt2lNdZjxCoX54P+PvLUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=QRJfVLIH9stOXB6OylOh088FxiiCwaH3rIS2+XJyzbvK0SniWFgHDOqv2soptdFv6gnUuK2sGNnGMs8YljeDj9Rguleo9SVOhCSZ+LpuEceV1xQgn/QsA9Y3dqLn+t+jWucjV+CAVTbq0rXdq9GNYYIn0iO5/kMw9SDWhlx+kQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwGUXt0y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwGUXt0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732902315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5K8vmZCnf84e6U6p+9W2G53lLGgAmzk/7mdh8pqwhSo=;
	b=cwGUXt0y1vaoiKNhw3z+tfVZwldzUQyw5OTOJn0LOXL1Ld4Spj63+UBUQiu7drB1zNRRAf
	afiIt3oMO41dRte30/VWOQUXTpqKXttEvaNM560uPeK95CdK0zTBte+zL3gR0V0UHNnM5u
	GVrU1RYZP2+ypcLWzljrV+h/YYjKhTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-6h0y0L5XNdWwFEnYe4wT6w-1; Fri,
 29 Nov 2024 12:45:14 -0500
X-MC-Unique: 6h0y0L5XNdWwFEnYe4wT6w-1
X-Mimecast-MFC-AGG-ID: 6h0y0L5XNdWwFEnYe4wT6w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06DC4195608C
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3407D1955D45
	for <mptcp@lists.linux.dev>; Fri, 29 Nov 2024 17:45:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next-next 0/3] mptcp: rx path refactor
Date: Fri, 29 Nov 2024 18:45:02 +0100
Message-ID: <cover.1732902181.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L99iwNTmBeUv8JC6fhnbBrUr8yzHTMZ2WO5oYoGTgRQ_1732902313
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is a batch of changes I had sitting in my local tree for a while.
Why another refactor you may ask? Two main resons:

- currently the mptcp RX path introduces quite a bit of 'exceptional'
 accounting/locking processing WRT to plain TCP, adding up to the
 implementation complexity in a misurable way
- the performance gap WRT plain TCP for single subflow connections is
 quite measurable.

The present refactor addresses both the above items: most of the
additional complexity is dropped, and single stream performances
increase measurably - from 55Gbps to 71Gbps in my loopback test. As a
reference, plain TCP is around 84Gps on the same host.

The above comes to a price: the patch are invasive, even in subtle ways:
the chance of destabilizing the implementation is real (ence the
additional, intentional '-next' into the subj).

In any case keeping the patch hidden for longer was not going to do any
good, so here we are.

Paolo Abeni (3):
  mptcp: consolidate subflow cleanup
  mptcp: move the whole rx path under msk socket lock protection
  mptcp: cleanup mem accounting.

 net/mptcp/fastopen.c |   4 +-
 net/mptcp/protocol.c | 202 +++++++++----------------------------------
 net/mptcp/protocol.h |   6 +-
 net/mptcp/subflow.c  |  33 +++----
 4 files changed, 66 insertions(+), 179 deletions(-)

-- 
2.45.2

