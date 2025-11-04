Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088528032D
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271962; cv=none; b=YALQT7xTVlbe3yEhj1Cw5m73eWGmkopXnPo/MlGPtr80TWDiPoJuiMwy76FLr106w+IqnCdMy7Jw5FLRk3NwvEc0FEDc1rPmSVX9s3HtwLSWX/XTybe+Jj3lnpcTjmozNR+ZM7mDq/gD33AspLY2K64gdLwbLmVX5nM6j+osIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271962; c=relaxed/simple;
	bh=ieLlSgfXaVDdJ8ysZkCBGtoy5aiTOAdlA4WhTfRBlgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Su72Gao+FT9/x2HAIm+37lXBkSz19W+2/cSeqCAHEHnsLrQnkJE9rEr2TZhufvlf3NN3f2NQ8N7+vVJ/71DQAs/YJ+Hnj+gqxv6vIVyLWTBoRTeG7Q8cJhEYHYrlZhoS4guIgPGI63usOHgiDzWcvBMTbCaakTs9pLspi3Tnz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfy0eFhC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfy0eFhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762271959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+TKTM//3k6ah9GUP8nGeEv1+PH1xSw/XSaCyOHTCp30=;
	b=cfy0eFhCs0CaDNu23XkmtqxokdJvB/GniT0Pn9AErQefFp7+VLJj5OEhh+yZOyQdTLlylx
	EdlyiN1kuX2S8qDpFyB9UcX9tiqbE9EdpK/ETvO8ALWhbmbbxpn1ITqNyb+t7sKUmoklFe
	+BbGx92GcEjm+rTIdYgc4PZWQPOkgTE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-bjsnUQPGM6-AnpKnUyjmFA-1; Tue,
 04 Nov 2025 10:59:17 -0500
X-MC-Unique: bjsnUQPGM6-AnpKnUyjmFA-1
X-Mimecast-MFC-AGG-ID: bjsnUQPGM6-AnpKnUyjmFA_1762271956
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74BEC1809A00;
	Tue,  4 Nov 2025 15:59:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.199])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46FB81800451;
	Tue,  4 Nov 2025 15:59:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v8 0/4] mptcp: introduce backlog processing
Date: Tue,  4 Nov 2025 16:59:00 +0100
Message-ID: <cover.1762271864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iDT6yRl6bQ2Dcb38G27hWHpL_1yu5e-v8G8jXmnx_Hw_1762271956
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
---
v7 -> v8:
  - only minor changes: typos, added warn_on().
  - notably no BL loop limiting, as discussed on previous iteration

Paolo Abeni (4):
  mptcp: handle first subflow closing consistently
  mptcp: borrow forward memory from subflow
  mptcp: introduce mptcp-level backlog
  mptcp: leverage the backlog for RX packet processing

 net/mptcp/fastopen.c   |   4 +-
 net/mptcp/mib.c        |   1 -
 net/mptcp/mib.h        |   1 -
 net/mptcp/mptcp_diag.c |   3 +-
 net/mptcp/protocol.c   | 232 +++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h   |  45 +++++++-
 6 files changed, 214 insertions(+), 72 deletions(-)

-- 
2.51.0

