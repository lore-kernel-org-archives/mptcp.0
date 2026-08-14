Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D943D501
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714719; cv=none; b=Dyr14ZkbP/TTVZTFIf3FGt58EXIGObCBw2nFQi5pb9JGnP1aqUU8AIxISyK4HoGlOr5VG0FmPRKXD87CpMYNPhUu+7xbOnLlpQdHl1wYBMyjMByBOxJqAkZvlslvs9aC3H1+UrRcAnMrzfXJak2GDEPywWYbAtuAkgpDMO8bGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714719; c=relaxed/simple;
	bh=YNVca8kwsa9TTgDbYHDotr6uBjvRbxXdApwBViP791I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=PbjazeIRMKK0ChsY7twY8FhVVQ/EBbzWV0raWjJYYEipnuZS+CzKwNsR/qrv2YTew3OXyzYEgXVKpXJu3xi2lAs0ip+G5TpYAXekapI+XzTWSJgCsxNTHVE4VJ5B+7sW5eHKGLnEeIYlR29GB8g7fpivYpreV8S/faQDnmO7EoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jS1TqPRi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS1TqPRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786714716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nXmF2XNxumOqD8AlpvlV26DYQ9p/INbdJbBcoecWjaQ=;
	b=jS1TqPRi30dytQRfIa2Ws8zSXq8dlMZ+s116d2UD4PSXE2x9Ws8+0s/mRaDmUdV6Pehim7
	yv+WM4EhPTfiqrQxiNzZO5XzA0Yy5XnfVN/RTTtAiL91hdHm1mgOe7bgpjuLc7a6/T+vmq
	tvB5EGwN/XkbMP7jhrwU1Am0U9UbfGo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-BPQ-hC10MHOpsZByEm6s4g-1; Fri,
 14 Aug 2026 09:38:32 -0400
X-MC-Unique: BPQ-hC10MHOpsZByEm6s4g-1
X-Mimecast-MFC-AGG-ID: BPQ-hC10MHOpsZByEm6s4g_1786714711
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5420C1954B0D
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.145])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86955180034C
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH resend mptcp-net 0/4] mptcp: a few fixes
Date: Fri, 14 Aug 2026 15:38:19 +0200
Message-ID: <cover.1786713351.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zcunZhH9fLiXnGCxZLSmkFQZX4OEIUhciTeoAehhaiY_1786714711
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is mostly a follow-up to the recent OoO queue pruning series.
Explicitly targeting net as we have already a lot of patches pending for
net-next, and no need to rush IMHO.

First 2 patches addresses explicit comments from sashiko, 3rd one is a
somewhat unrelated cleanup I stumbled upon while implementing patch 4.

The last patch fixes another thing implided by sashiko while reviewing
the mentioned series.
---
resent to hopefully trigger sashiko


Paolo Abeni (4):
  mptcp: being below memory limit is a likely() condition
  mptcp: avoid pruning for OoW data
  mptcp: remove unneeded READ_ONCE() annotation
  mptcp: do not reschedule the RTX timer for fallback sockets

 net/mptcp/options.c  |  4 ++--
 net/mptcp/protocol.c | 29 +++++++++++++++++------------
 net/mptcp/protocol.h |  1 +
 3 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.55.0

