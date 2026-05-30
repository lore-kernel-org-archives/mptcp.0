Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5B306752
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780153198; cv=none; b=BnKADdtf5afAJTSm7hcqGX4QsoaKq+QzNGTcQwxswNCM3tTxi1jkexT88rUfuJWk39sFYos1WhK1ZvbfYpOKc3Ge4oIGDDkvoKrJs9IpzS7u+/kzr2wMelsxn15x5iiKWZMwPJQbQ9GgqGgM/vSSNvXmNnSd4uBJUiFrKi2tk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780153198; c=relaxed/simple;
	bh=AAH5gabAm4Xt3yKWOnqarAZGgDO7b7DQ4kr7B9ghIQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=k6lZ9Zj1RF2/xNczKQMLXYJKRvbITmTwDC7uzvx4aBo/7Pq1cEqUltpKj7C5fxMxegVDbFFHOnasqNuJW5ejSwxFxMy3TOdnlBIV40awcxsDRiAVGwXG16ZvnXbL3RLB9TElt1INMcS4L+PrT4e57+IZ7oiGhFA+ZxLdteXiwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzApxWga; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzApxWga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780153196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pafmn65uBzdB0KM9ZCz2AtOTcWjEUblYJJj9P6G1HxI=;
	b=HzApxWgagQBVHEjznF7PrY8MGX1TB6qObjnVmQI/Wji4PP95mQrYHSVfeWFZtdb7ax+bWp
	dGQyt7qACZ552VSTDol468GYyzRyMpMrFZbW+au5ImQb3r+u6ChClXxx+lbnm77p6Xx4K6
	FatoQoi0wGDjx0jOuybms/FV1lrooVM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-sv6A0uhwN7ygJ8SLDh2V7g-1; Sat,
 30 May 2026 10:59:54 -0400
X-MC-Unique: sv6A0uhwN7ygJ8SLDh2V7g-1
X-Mimecast-MFC-AGG-ID: sv6A0uhwN7ygJ8SLDh2V7g_1780153193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C53819560B5
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 14:59:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 964211800352
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 14:59:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v11 mptcp-next 0/2] mptcp: address stall under memory pressure
Date: Sat, 30 May 2026 16:59:47 +0200
Message-ID: <cover.1780152380.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YKhBgI8tuZG0gxB7aB6NiwHOGsVurAw0ZSRMDcycVqY_1780153193
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This brings (hopefully) the final bits required to address the
data transfer stall reported by Geliang and Gang 

This series improves mptcp retranmission to make them reliable:
pruning can require some of them.

The only change over the previous iteration is in patch 2, addressing
Geliang and sashiko feedback over the previous iteration (bad WARN
condition).

Paolo Abeni (2):
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 net/mptcp/protocol.c | 156 +++++++++++++++++++++++++++++++------------
 1 file changed, 112 insertions(+), 44 deletions(-)

-- 
2.54.0

