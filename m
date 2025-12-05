Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952330FF30
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764928763; cv=none; b=d7dLauyEUN8vTqWRheWkRwBymq1tYrqW0D0irb2ALQN2NwjRS+xpjZrbgZQzGvgP4tkpJmouq7k1jnhl0kMwMUsMKixGkiyd/lHM1RyFpvTsUmYGWqFGZUvcvcCsiJVj5XhB9AWZJ1hjCyRlPZw/IM4wr25f6XW7m5+DRJ1KSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764928763; c=relaxed/simple;
	bh=0Sq8L+9ZWCwaOS30nha5Y1y0TrxaO3jirg9khPp3T0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=FHifKH57lmD5VBtw72w3ft/RkiWrpMOCSIzSPF8UX5Y9bk9bsYFXc4AbNDR9iH7z1jN5i/yD+zT/uZ5giRlgPnLJaarcJ8ZUsnQxVYsNte24tlACdeEfhd1cosUgYmSsKHF7Hev/+5wll1o5I11ZJySXZUwuXxwwHmaAiybkId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=beOEUeHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beOEUeHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764928753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=04ahjVvzKZVfSBpo64PwtUwwiymR5AdOnJDcmYxpAxw=;
	b=beOEUeHxyw6a4CJEZ5qzCZU79teWb742JREwT+M7Cv0GgBh9HE70s48pRNdNnCPcfoxKAd
	Jr9TqOyA0NC3YWhqmw2lsiQo4z9dmzULMDboEKEVp113VA3oVr2yM3ILfAz2TwImL8Rjqm
	67Dg3dxpauYmq3nazh/hRfJnpnqtCho=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-l-Y_hTK0MVC_xWmhCslFnQ-1; Fri,
 05 Dec 2025 04:59:12 -0500
X-MC-Unique: l-Y_hTK0MVC_xWmhCslFnQ-1
X-Mimecast-MFC-AGG-ID: l-Y_hTK0MVC_xWmhCslFnQ_1764928752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06ADC1956080
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 09:59:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F7013011A86
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 09:59:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 0/2] mptcp: fix warn on bad status
Date: Fri,  5 Dec 2025 10:58:41 +0100
Message-ID: <cover.1764928598.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3JFaKuGi84IBU5knNjg8qrAztD-ifNkRUVscXHg_vyM_1764928752
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Two somewhat related fixes addressing different issues producing
exactly the same splat (issues/586).

Patch 2 now takes in account more edge cases.

Paolo Abeni (2):
  mptcp: fallback earlier on simult connection
  mptcp: ensure context reset on disconnect()

 net/mptcp/options.c  | 10 ++++++++++
 net/mptcp/protocol.c |  8 +++++---
 net/mptcp/protocol.h |  9 ++++-----
 net/mptcp/subflow.c  |  6 ------
 4 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.52.0

