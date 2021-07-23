Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670470
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627059977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c+oe8dOEuzcQyPE71J2Nk4mam15PHY1Ke4nb+W+fauA=;
	b=eiphfaKxcoFCYAbjLRo49HK9Iezs5Ibp/KS/HhjbSNpII3JoJxAf5lqX5qwuJt2nfidgHE
	WoWgf6A7k9b4NXIykHWQng7fsqMkJPuiCgjq9PJOuMkkqXqqRnrHPz0QZDZ4IfGJ6227yg
	KdIbfBnij6Pou61Bkswm2cOIL6lzhL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-f1N7FCw4MsOTsL6_IK_tVA-1; Fri, 23 Jul 2021 13:06:14 -0400
X-MC-Unique: f1N7FCw4MsOTsL6_IK_tVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E9B6100F762
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:13 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-240.ams2.redhat.com [10.36.112.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14CCE1007604
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 17:06:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: minor out optimization
Date: Fri, 23 Jul 2021 19:06:04 +0200
Message-Id: <cover.1627059686.git.pabeni@redhat.com>
Precedence: bulk
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

This series implements a few ideas discussed in the past mtg,
specifcally:

https://github.com/multipath-tcp/mptcp_net-next/issues/15
https://github.com/multipath-tcp/mptcp_net-next/issues/42

The final goal is shrink the mptcp_out_options struct, which is
always zeroed by the plain TCP protocol in the output path.

Only lightly tested.

Paolo Abeni (2):
  mptcp: optimize out option generation
  mptcp: shrink mptcp_out_options struct

 include/net/mptcp.h  |  26 +++--
 net/mptcp/options.c  | 225 ++++++++++++++++++++++---------------------
 net/mptcp/pm.c       |   9 +-
 net/mptcp/protocol.h |   1 +
 4 files changed, 139 insertions(+), 122 deletions(-)

-- 
2.26.3

