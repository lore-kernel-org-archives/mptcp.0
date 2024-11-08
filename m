Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C111E3771
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063536; cv=none; b=XWMxsM3/zNlBfpVp8bebilCixzkKHVNMskWhI87sfuH64OUCUPZgvRpx/PPwznA4iwrKeFo+4kJ92qf+W02f8gHiLyqkF+h28iHdupTuSRQnqeEXO1Ql2JOHqiHbq1t/vG+0PYKkMnciUwGE3ooTRdvxLxl7wM51JM9lmCacRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063536; c=relaxed/simple;
	bh=SVP1un2WHlgQFTMUVkMXQb1bpew074b55seoGhnpkwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSdDtz6CbhfSbkTlZmNYdrHj/1Rv70IcJTj1l4McVeM8Y4isZ/t9zav0y7+R0utpEs1xx0OSt+C5sPzYIdIvwITeJnfcdIuNnr71flYvDu5vNYUKB9TtZnFfg2f5fpq5KswIap8F8o1QpwBt+ugWs+KwwAFh/VdfAuMkXHAu7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnjVRB2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnjVRB2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731063533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=trJgYqh2//IpO7XTeIhQvSS1UJXTy5+llm2zGMIXEOQ=;
	b=KnjVRB2ikPCSLB72QPyYKlydPz0sqWpjeClmWimUqxwRcaGDs9cyCZaj4/cNOnrCs9BTqE
	GjyGdCE6PnJu32W6ZDCfREL8Pf5TBm2YkEfOiIsl4+6Peb1MhueX3U16ikzYNfpjyd8V/r
	Q6WHCh+D0/5mpKHmUThebxWXgzUAlaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-fJzHsmBiOMOzOjfDbPrHaw-1; Fri,
 08 Nov 2024 05:58:50 -0500
X-MC-Unique: fJzHsmBiOMOzOjfDbPrHaw-1
X-Mimecast-MFC-AGG-ID: fJzHsmBiOMOzOjfDbPrHaw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 358641955F08;
	Fri,  8 Nov 2024 10:58:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDD271956054;
	Fri,  8 Nov 2024 10:58:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: fix a couple of races
Date: Fri,  8 Nov 2024 11:58:15 +0100
Message-ID: <cover.1731060874.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The first patch addresses a division by zero issue reported by Eric,
the second one solves a similar issue found by code inspection while
investigating the former.

Paolo Abeni (2):
  mptcp: error out earlier on disconnect
  mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

 net/mptcp/protocol.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.45.2

