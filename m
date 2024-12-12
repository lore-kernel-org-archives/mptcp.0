Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF62153DD
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022710; cv=none; b=i0geSkq44EFxvNLH71+5m5QcuwaBJSoQNtx7EGBHUmixfBv3930DHAP6sXgiaJ0mICwpgo3cXOI2NUy7on4OP5zC9QmVXDwcBBTSm0DrM4ibe0luK8z/qQtYAD0s3a0Xod8O1Ru9QhTbVUa/KBl43XTFhdhiQLreDoU5R/EPouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022710; c=relaxed/simple;
	bh=KHiuvyzuqkN/XACDS95DR4Upw1TRPRzUfOe9aIUvsfw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=PVjeWdUiSWm5YGsMQzE+LTlJkQttoDh9VKWoTrLyIaSncT0hMkaZU6aedw9k4XM0GX94rmfFDg8vFs1Tv7mZ1HFZz+WHndlsgbZ0ZqGJI4I9qKmLVKDv9L2fIAAWQB9CndcL2skvGX6oxQdKIkolMJC6H+TbTGSxn7K7ivfhDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjIdGlBz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjIdGlBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734022707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UVxyvGnHcfHdeUlEvRq5elJMyIkOOy3/3TdF0L2Yf+c=;
	b=GjIdGlBzHINgSXOOriYC5bsH7zh3liz92B/KhMGoVWuyE1fxxshfReNNH2sTPUS38lskWh
	RlLwYK1QKAp8xm98oXYk5eIgQm66RrXXyfty1kIYbXi1qwtSW8ioQ1yPyT4pJ8Ib6lRkkO
	eL2suQ+bwDKkaQ8n+vtQez/tSUry6qg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-Z4kExG8hNHKMydcGH3ivuQ-1; Thu,
 12 Dec 2024 11:58:25 -0500
X-MC-Unique: Z4kExG8hNHKMydcGH3ivuQ-1
X-Mimecast-MFC-AGG-ID: Z4kExG8hNHKMydcGH3ivuQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 155DE1956057
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.108])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F7E9195394B
	for <mptcp@lists.linux.dev>; Thu, 12 Dec 2024 16:58:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: rx refactor follow-ups
Date: Thu, 12 Dec 2024 17:58:12 +0100
Message-ID: <cover.1734022547.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5e8zR5Xu1vnQEOHb59YYrSJF6DAZPBQ0PjDeSBRd8Qw_1734022705
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

a couple of incremental improvements on top of the pending rx path
refactor: patch 1 dismiss __mptcp_rmem(), patch 2 optimize a bit 
__mptcp_move_skbs()

Based-on: <cover.1733486870.git.pabeni@redhat.com>

Paolo Abeni (2):
  mptcp: dismiss __mptcp_rmem()
  mptcp: micro-optimize __mptcp_move_skb()

 net/mptcp/protocol.c | 113 +++++++++++++++++++------------------------
 net/mptcp/protocol.h |  13 ++---
 2 files changed, 55 insertions(+), 71 deletions(-)

-- 
2.45.2

