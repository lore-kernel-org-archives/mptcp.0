Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA6212FAA
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527435; cv=none; b=H9TRcQCBnb1zlIz+okM/kAdvQooRVIz7B3b+Ntd9TSuxlXlkmUqazRSVbZ1otPJGU/mq8QSNhRO+0633tHnmPhCY5sUJeFOksFaHDBp7tya93X/IvJEZVkKxRNNmdwxr/mfp1nMLwAPtHyQ0SZpByMvx814NcnRRxCByk/szBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527435; c=relaxed/simple;
	bh=XSfpyLO1nDS6CAD1Owt//LWRwU00aNURnkcd2oDgCik=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dtntoyBJGPlhazek0aPpDVJ9TPEXdSF8zX3SO6R3UGxlf7on6zq6xxS6VHHzuKuSQIDdlmpF1PEN2a9vAZIxuYH3b8aAgSqLcoRmrxLCTppFzHs2z3/OiuMsIEYZ/0lfyMAbl2M617pDQaXjA8RQQAUG5L8KakdkFcey27DojTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ro/HuGle; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro/HuGle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736527433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dYKYescewA+B3GZ3lqZuX+qszLD9bRoH16DzbWJL9qw=;
	b=Ro/HuGleZs3U2WbWM568VEQaLYJDyx2QOLU0YQUPgd8idq3fVWNVshlVWvZEJOLhmRZr8f
	0DNNsXxtZHnTtmyx97p1NzzEkSV/eg97xtaeDyaOg8+ItWJRAV9o0sXL2eNWlVsp3XWTCh
	f1Fj2NpuHjymjMr8ZpKRcxEfFZdFRVo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-pIPFu7ztP6Wb7cxfhNN9LA-1; Fri,
 10 Jan 2025 11:43:51 -0500
X-MC-Unique: pIPFu7ztP6Wb7cxfhNN9LA-1
X-Mimecast-MFC-AGG-ID: pIPFu7ztP6Wb7cxfhNN9LA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B202A1955E72
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.199])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D08219560AD
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/3] mptcp: a bunch of fixes for ST flakes
Date: Fri, 10 Jan 2025 17:43:40 +0100
Message-ID: <cover.1736527092.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gVfSCmMcdRQYrFJOMkrA2m858siUV46SJtQN2MBblT0_1736527431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

still under test locally. Sharing early for larger coverage.
Among other things, still to evaluate if patch 1/3 increases the ack
frequency "too much".

Paolo Abeni (3):
  mptcp: be sure to send ack when mptcp-level window re-opens
  mptcp: fix spurious wake-up on under memory pressure.
  selftests: mptcp: avoid spurious errors on disconnect

 net/mptcp/options.c                           |  6 ++-
 net/mptcp/protocol.h                          |  9 +++-
 .../selftests/net/mptcp/mptcp_connect.c       | 44 ++++++++++++++-----
 3 files changed, 44 insertions(+), 15 deletions(-)

-- 
2.47.1

