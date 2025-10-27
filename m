Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBD1EEA49
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576072; cv=none; b=GVU+RIwOyFJ1sxCuH8HkQ1oNFMnM23fVqyijp1Yj+T7H4KJw938LT5YHJYhffUEe72ZIcitLiLngGVqSRjqJI7ZVZQ7LToV4Spl0/v1eUSdZiCQo3B9KDB1mHVwxGTkMrC7Zjkj8eW0IIakkiyRC6as25W5A635qPkNGsDJ/kcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576072; c=relaxed/simple;
	bh=L8/cCZDSh90zfT7JNOHh2SpJpP3M2J5ozQzwgL5waZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=AE0KgTOWafs6mI2Ob7zsPt9d2DgZBwI7QnVKzmtjKZqkRbTbE7DC9JgOl+rhM/bmwBr8sVat0pAFzfQjaUVSbxJ/vEAZAMA7b7UK3MJSMSaadpWirqXfkMwmctYb4SKYbyaKsX9uqarTYTcwHBySFA/hD4dhOgaGLlMy0xMpjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeY/00dC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeY/00dC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wj0oMK/++rnzwG4s7JJg0lH1gZoGSJiN4TPKITDGSoU=;
	b=IeY/00dCILZIMjxhUj2WVW6bJQ46a71lzh6L4vab5zyB9hHumR6Zi5KOVtZGCOHYs3ls3x
	/GEmxaiKmNy8R6SZsrn/dcwolro2+YLedM/Dx75Rpg3KSRCbPo+oCROUTtGbGIB/qbsLLf
	mYYLhVhyW4NzG3b3PWDrtD///O6Ouns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-NMDrQVtPNFmWLIvIlFlQwA-1; Mon,
 27 Oct 2025 10:41:07 -0400
X-MC-Unique: NMDrQVtPNFmWLIvIlFlQwA-1
X-Mimecast-MFC-AGG-ID: NMDrQVtPNFmWLIvIlFlQwA_1761576066
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3D001954190;
	Mon, 27 Oct 2025 14:41:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B53630001A2;
	Mon, 27 Oct 2025 14:41:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	geliang@kernel.org
Subject: [PATCH v7 mptcp-next 0/4] mptcp: introduce backlog processing
Date: Mon, 27 Oct 2025 15:40:48 +0100
Message-ID: <cover.1761575881.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ll3Z4waquTP4wtJ3wX6jupxdb7dkZJ9wAI3qFQVtyGA_1761576066
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series includes RX path improvement built around backlog processing

The main goals are improving the RX performances _and_ increase the
long term maintainability.

Patch 1 and 2 refactor the memory account logic in the RX path, so that
the msk don't need anymore to do fwd allocation, removing possible drop
sources.

Patch 3 and 4 cope with backlog processing. Patch 3 introduces the
helpers needed to manipulate the msk-level backlog, and the data struct
itself, without any actual functional change. Patch 4 finally use the
backlog for RX skb processing. Note that MPTCP can't use the sk_backlog,
as the mptcp release callback can also release and re-acquire the
msk-level spinlock and core backlog processing works under the
assumption that such event is not possible.

A relevant point is memory accounts for skbs in the backlog.

It's somewhat "original" due to MPTCP constraints. Such skbs use space
from the incoming subflow receive buffer, but are fwd memory accounted
on the msk, using memory borrowed by the subflow.

Instead the msk borrows memory from the subflow and reserve it for
the backlog - see patch 3 and 11 for the gory details.
---
v6 -> v7:
 - dropped merged patches
 - added patch 1/4
 - refactor borrow/account logic, see individual patches for the details

Matthieu Baerts (1):
  DO-NOT-MERGE: mptcp: enabled by default

Paolo Abeni (3):
  mptcp: handle first subflow closing consistently
  mptcp: borrow forward memory from subflow
  mptcp: introduce mptcp-level backlog

 net/mptcp/Kconfig      |   1 +
 net/mptcp/fastopen.c   |   4 +-
 net/mptcp/mib.c        |   1 -
 net/mptcp/mib.h        |   1 -
 net/mptcp/mptcp_diag.c |   3 +-
 net/mptcp/protocol.c   | 112 +++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.h   |  39 +++++++++++++-
 7 files changed, 142 insertions(+), 19 deletions(-)

-- 
2.51.0

