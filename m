Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331235CB95
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760686; cv=none; b=DGrFltFyTk6vfB9VMDp24bSvZlAHSdsqIWJoLg10y9t7O4PtOE1/i9C9yVqJj8gk9lBHzqoS6ergXTHGDiOOyBTsoh9bWWtCF73mGEA+M8X5stmexvmXhuZ/cq+fDDXR4ho1vnQqjbw84K1HNTstky05LCWTGN+q/A3AcJXPyKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760686; c=relaxed/simple;
	bh=YOZC4wBV2XUMlW5Zg00F/+V8KpYkGieZCXBIv8q6ENA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=L5fuJcrQl9tEeb+dyqH9l4kD1qdw/xYF9SP+MMJepupWIbGagGOMCgia/aTMogQdUSiQIQvBvhG1NfZT980Zr8VGWE5U4QH8karsGOnwgT9a8ThsmcpJcRaVdEhd3xkhp7RGEJIgelHDLjeVq3DUXkWGwGipEcEd5ScjScVIXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXU6s4VF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXU6s4VF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787760684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GVLXOXtlzMYSXrMkZJcMo5wkaOeGB5LKWavvbXxoNi8=;
	b=cXU6s4VFi+Ltn65dElIwb1v17ycTnHfktrA3L9wmeLBeZtY1bNAPfWOGOiu0/sqEwiaCH/
	04SukOO1Skms9fTvkOdhrpp2KMDXfYASVV46b5lxWadPaUn8h+8IcydszTqpimfdnYOwoQ
	61oah0DjiEfavyNI0uB0IgQvR9ffFdc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-epH9_510OEurZP33S_d8GQ-1; Wed,
 26 Aug 2026 12:11:22 -0400
X-MC-Unique: epH9_510OEurZP33S_d8GQ-1
X-Mimecast-MFC-AGG-ID: epH9_510OEurZP33S_d8GQ_1787760682
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF55F185512B
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D9A51800605
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 16:11:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/2] mptcp: more cleanups
Date: Wed, 26 Aug 2026 18:10:58 +0200
Message-ID: <cover.1787760635.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9q4zTBitid0dhirbVucIPvwnjiIS45wKuBlvQfdUNTE_1787760682
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Follow-up the the recent fixes, as per sashiko nipa feedback. A new
patch and an update to an exiting one.

See individual patches changelog.

Paolo Abeni (2):
  mptcp: prevent race between disconnect() and rtx
  Squash-to: "mptcp: do not reschedule the RTX timer for fallback
    sockets"

 net/mptcp/protocol.c | 17 ++++++++++++-----
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  7 +++++++
 3 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.55.0

