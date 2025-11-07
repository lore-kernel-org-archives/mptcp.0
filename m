Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE7221299
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552562; cv=none; b=c5aZX3B9J3UazNOGjgAIfGXtMUwZExpI0NQYZHwcPTqORrTI/m0q9M59l1xdvggw51cZtalQYhLX/KRAVAGS9dg/hJ70yJKJMrui8c3A+aKA5JhJQRtcY6/fx5cqFpF3KWb7GujxQFp6e1QNlgMrrtUBlHWd3dhCFaDqQQjumj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552562; c=relaxed/simple;
	bh=7YNOHm6bO/MmUlpZKmPMu8O4HV6r7sQYDnDQEOMFDaQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=iGhaIu7IjM7nwfP08D3XJVy+dKeUMkolVdQhr+72H0/wVGK8ohVT++iFybr+8G3z/lnfhV0Dwi7AmNRJIEmAmZXiks4Mah66h32eBmw1KbGAtcCWr6XflWCAyK58pAe4lthVXViMhBd/dACCT7SUxGqBeXqUIYkJmak0sRXXQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2mB1nMr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2mB1nMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762552559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4VybVvQwyRPEydYqmlkqb5ZmGnc1NnpW44Tuhta8sOM=;
	b=S2mB1nMrXdZgUDlbrs0K/cCyOHGt1hQxK0HjwqpPGpet6aTtaJh7UFsGJmcWUXxuvYFr6a
	2wyayMkSCG170oWDM+IOhE75ZZgDfGDs9V0e54Jd84n0MvCW19H8bbkQbKT5gZYixEerj1
	xPfxk9KDGbVAk+1LUyrEwhcP4T/GGwk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-M_nx7xToNyufmGl198s8_g-1; Fri,
 07 Nov 2025 16:55:57 -0500
X-MC-Unique: M_nx7xToNyufmGl198s8_g-1
X-Mimecast-MFC-AGG-ID: M_nx7xToNyufmGl198s8_g_1762552557
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04998195609D
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:55:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FC5019560A7
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 21:55:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/3] mptcp: fix memcg accounting for passive sockets
Date: Fri,  7 Nov 2025 22:55:44 +0100
Message-ID: <cover.1762551942.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8oeWxNBqrDSWM0KhAM9h66FuuliNZ52ahDTxGCYqdYs_1762552557
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It turns out that the splat reported earlier is indeed due to an old
bug/missing feature that hit hard on top of "mptcp: borrow forward 
memory from subflow", as we can borrow accounted memory from a socket
not doing any accounting;)

It should land upstream before the above mentioned commit, ence the
'net' target, but it could as well be net-next material.

I think there is still a racing window to produce the splat reported in
#597: if a subflow receive data while the msk is locked, and before the
memcg is initialized on such subflow, it will push the data into the msk
becklog, and later borrow will again try to grab accounted memory from
non accounting ssk.

I have a tentative fix for that one but it's quite ugly and I'll keep it
separate from this series.

Paolo Abeni (3):
  net: factor-out _sk_charge() helper
  mptcp: factor-out cgroup data inherit helper
  mptcp: fix memcg accounting for passive sockets

 include/net/sock.h   |  2 ++
 net/core/sock.c      | 18 ++++++++++++++++++
 net/ipv4/af_inet.c   | 17 +----------------
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++----------
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  | 30 ++++++++++++++++++++++--------
 6 files changed, 72 insertions(+), 34 deletions(-)

-- 
2.51.0

