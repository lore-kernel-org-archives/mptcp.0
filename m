Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3E10F2
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992665; cv=none; b=VhwPDSWinqh5ePWGkdPfQ0JqO0u8mob2Y1KYGzOtkqYK21cylWBgZuAzCu0qC3IlBlTThyAVxRPuMcq33C55stYFOR4odk7ljgJUOQ/37rxDvv9OjrC8Fryp6K5iwtLVIvUh/005gQqezXQVwk8xxR/4bzVldeI3g+g53hAq50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992665; c=relaxed/simple;
	bh=ktDV1r4ozzlATJZUeCwPFjtrOdtH2otCbxx7SVVWd5o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=LbtT41asFE0cL+IqYSB7ZV6z2OXMCSRJ/VXjUhq3GuadirO32R/d24JET/tZkBxHZQLE58C5OOo1ewSPLlggttvl3aM1hvlseBYN3vGKQxqCEpfvYLN8AxebfBQ4SdB7cmqoHfye2VeAoU+SpJoOIkpUhowoy16z4cpJT5omlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvGwpoTR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvGwpoTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OsF5HQo0yFKPq4FWNHvX+lqZnXHR4i9BOsygmklt5FA=;
	b=HvGwpoTRyCx30jNP4/508glO91bg2clk2l6kP1opOiGm35cUKWIxrv+PMs+cA07iRp/xNK
	QlcDl9rb1KSHsjNa5b/eDFHYpFs4F2g5MqZyYBuL4sCRfv4+O3IBlsCGtZMP9HAPU/yoYU
	60BPssh/QWmgw7zdDZBfsEcSbEvt97k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-gGnKRQRUPz2gGPJn2FSu1A-1; Wed,
 12 Nov 2025 19:11:00 -0500
X-MC-Unique: gGnKRQRUPz2gGPJn2FSu1A-1
X-Mimecast-MFC-AGG-ID: gGnKRQRUPz2gGPJn2FSu1A_1762992659
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E9B618002C7
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:10:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8497830044E0
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 00:10:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 0/3] mptcp: cg and backlog follow-up
Date: Thu, 13 Nov 2025 01:10:49 +0100
Message-ID: <cover.1762992570.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xK7NzXxhQwC1bTh4VsP3DKlt-J68ZjD2JUpZDDjNbDU_1762992659
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is a v2 of:

https://lore.kernel.org/mptcp/ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com/

It turns out the previous revision was prone to a lot of ugly race.
Addressing them needs a some pre-reqs.

Races are due to MPJ subflows racing with accept() and possibly adding
non accounted memory to the backlog while the account code is trying to
handle backlog_len.

Paolo Abeni (3):
  mptcp: fix grafting corner case
  Squash-to: "mptcp: fix memcg accounting for passive sockets"
  Squash-to: "mptcp: leverage the backlog for RX packet processing"

 net/mptcp/protocol.c | 104 +++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |   1 +
 2 files changed, 87 insertions(+), 18 deletions(-)

-- 
2.51.1

