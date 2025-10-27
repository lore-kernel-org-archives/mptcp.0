Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70AC21C9E1
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577118; cv=none; b=PgkFnUD4s+lNAmSI4ZfmVt2uU9uTnOEczFyxlysVOagY5q6QGV35TVaFSKkqFw+6i0WQt83ndipX1TTlmsj+v37YDMKsjhBGfHYreyzG5k4qreWygToMcUyHlSlO/27DlZ3RYDO3IpyPYCnGzrrROI9idY/NqO1/cO+axBjzMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577118; c=relaxed/simple;
	bh=jmp7GPXzsme/3/BJuSw8iMjt58n5Ql4HKP+YbdapEGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=qeBOUbHq0UM/FYHQQI++gxFcycJBVeTA0S1LraJdIZbwDshkqwTvkzfkOTK+GISSnLYChg0UUXx7dn1SpO2meI0wDRZBJr6Amw+juEBK8UrFUBUyZhCl5WZGh8h2USxAyLT6NeLNm+yfbi76IfdbQF0M5GrClcOOzeD9Dk7V3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9KmcT90; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9KmcT90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761577115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ddBU4L9fsCG6RKzskuiVtHOVSivI4Ap3HxbSru+yGsI=;
	b=e9KmcT90SJmbMslSl8C6qt7Rh+H0a/rWC4AaPc9Onp/7L/xE0TM4JxOXULZfHqaTLBAHPI
	k33ubIX5cTIkM6KcoW04m/EXb6kFtNQQB5SLJSzj36COWzfw4sGAL41d/HWNEML7kU1eiE
	r0Pf3LsW23m9U7RbBEX7DIk0SVRJEMA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-QQSpW2kKNuOvuUzkG_7iww-1; Mon,
 27 Oct 2025 10:58:30 -0400
X-MC-Unique: QQSpW2kKNuOvuUzkG_7iww-1
X-Mimecast-MFC-AGG-ID: QQSpW2kKNuOvuUzkG_7iww_1761577109
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 678A61809A00;
	Mon, 27 Oct 2025 14:58:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F167519560AD;
	Mon, 27 Oct 2025 14:58:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	geliang@kernel.org
Subject: [PATCH RESENT v7 mptcp-next 0/4] mptcp: introduce backlog processing
Date: Mon, 27 Oct 2025 15:57:58 +0100
Message-ID: <cover.1761576117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AIY1AmVJXUTBS6bf3WEvwCWIYg-29sdxC6Bv1-YdNSM_1761577109
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
the backlog - see patch 2 and 4 for the gory details.

Paolo Abeni (4):
  mptcp: handle first subflow closing consistently
  mptcp: borrow forward memory from subflow
  mptcp: introduce mptcp-level backlog
  mptcp: leverage the backlog for RX packet processing

 net/mptcp/fastopen.c   |   4 +-
 net/mptcp/mib.c        |   1 -
 net/mptcp/mib.h        |   1 -
 net/mptcp/mptcp_diag.c |   3 +-
 net/mptcp/protocol.c   | 231 +++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h   |  40 ++++++-
 6 files changed, 208 insertions(+), 72 deletions(-)

-- 
2.51.0

