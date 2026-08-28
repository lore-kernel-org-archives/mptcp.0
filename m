Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283040B112
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912302; cv=none; b=WWu+WZwlMw30KCy3DNDx793ujpkDn7MJFskKmoyBPaJoXoX1TJnOZJsPkTyZCYmsy9O/YO3/2XBtbO97CXqIbC2CXirbYwdS+2LeAJmXjCBmBpZPgBtie/+2cwyPkWK260sUv2dIhz3bcjXbmJxCaJ9JETrPaYSob+vxh1FEXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912302; c=relaxed/simple;
	bh=nfB1Pe/AoAfgfuKu1Y6cGu26y5mS82ExAAuzOSNBxlg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=JEdnCoQUvyyBBSLnOSEEaKSx8O67hUl07a+3qdvMAjpVVxRQD3+N5M5bUw8bVxNg0XApIJ4alzoGYvLE3g7JGmKKup7wnf1q1Ar0CmfYR1XUIb3auVYhKQZ1aZUsXnso3478lTerOiOHsuFMKzWUb5LosJuL27EXpc36UoZfh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SV24rAlc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV24rAlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787912298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GN+Gfm/QuFlBTg92twoJvXsR9NrlVwbtjmgpbp4EfjU=;
	b=SV24rAlcuzk+gC4WWEKJWgbRIWw9oQjX4m3Yfl6lQpJAEIvtIbvhn2+njBphSnV2mBSddO
	agG3AO18aBtHaB7Xym0FL+UumK4LcM2ZOZlqFhoDIfN68NRUck+t6Uhgl2N/V+CgN65ceK
	P/6RMPRWqzEfEJjTKaYeEwCF4bGCc7s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-lBRX1-LAOcme4xfoRa7hvA-1; Fri,
 28 Aug 2026 06:18:16 -0400
X-MC-Unique: lBRX1-LAOcme4xfoRa7hvA-1
X-Mimecast-MFC-AGG-ID: lBRX1-LAOcme4xfoRa7hvA_1787912295
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4782188860C
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8BDD3000223
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 10:18:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 0/2] mptcp: more cleanups
Date: Fri, 28 Aug 2026 12:17:12 +0200
Message-ID: <cover.1787911017.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: boUUHXWV2EYUqsFyJUeQqOHRnaVVCrOQAliD51ANX9o_1787912295
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Follow-up the recent fixes, as per sashiko nipa feedback. A new
patch and an update to an exiting one.

This is basically v1 again with hopefully better changelog to avoid AI
slop review (and myself not detecting the latter as such).

Paolo Abeni (2):
  mptcp: prevent race between disconnect() and rtx
  Squash-to: "mptcp: do not reschedule the RTX timer for fallback
    sockets"

 net/mptcp/protocol.c | 18 +++++++++++++-----
 net/mptcp/protocol.h |  2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.55.0

