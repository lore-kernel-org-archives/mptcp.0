Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6112FB61D
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118812; cv=none; b=HTuDdC4KCKtL5PhHtKMsTelkvyVih3gF3nuev5HzReeGIdFRHAB3XgbcCMDjR4XP6Hs6wpo5TwCa7xye53k3nfdFPyBVFaUw7AL2owTTbsQUr7P6hNrXGkmmN62PpLCG6bGLYrek+JVRR+oZTSV0FQaERd40RJX9cjgovB46sM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118812; c=relaxed/simple;
	bh=xnlybXhe4Gk3+/T7ptK9m5/2M+M5ja4gQq27GB7rFEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=oVlLp/tsDrdNExSpwSXgTY+2h2SD0WWWpzYYAdUK1VYiNgtA0uVaSPiMWbAtHLKRJ+MEPKME66IcW7VjKZF51rSbxUzLkUS4LvVHkRmCJ4hOWRsPamMDd1sTkOgtIjc8135Becjf1DzhAtS9XvfMJE8qn7J3s/3mUXNpXGNfpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ap0++xGg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ap0++xGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761118808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0LDpEXVqV1qq3k8fA75o1w3qUBLgt2mPulvuQWFEYPI=;
	b=Ap0++xGgy3zLw/zwCSh0O80spWYTxyF/p+Me1QMq5U/39InjhJGdmLxb0Vjfp9ihnrkx+M
	qDozg/qknRnupptGTLXZDsE1sFtjTLqNe9blasZsXGYmW9F2wgyiWumLfWJoUsGPJ+PZwC
	EZqDPTc9ANozGdbiqiWAMf6QGqf1F8E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-AmdPjc7IPJSglBul5nyiDA-1; Wed,
 22 Oct 2025 03:40:05 -0400
X-MC-Unique: AmdPjc7IPJSglBul5nyiDA-1
X-Mimecast-MFC-AGG-ID: AmdPjc7IPJSglBul5nyiDA_1761118804
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A484618001D6;
	Wed, 22 Oct 2025 07:40:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A11430001BF;
	Wed, 22 Oct 2025 07:40:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH v2 mptcp-net 0/2] mptcp: restore zero window probe
Date: Wed, 22 Oct 2025 09:39:57 +0200
Message-ID: <cover.1761118636.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EWZYVTnipXeJ_dyqfgd42t5LaGEHT0k9Emz-utGqwoY_1761118804
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It turns out that the issue reported by Geliang on the pending backlog
patches is actually on older one that the new code made more easy
reproducible.

The first patch in the series addresses it[1], the 2nd one introduce new
mibs to hopefully catch this problem sooned.

I have a pktdrill to validate this scenario. I'll share that soon.

@Geliang could you please validate the above in your testbed, on top of
the backlog and splice patches?

[1] at least here, at least with the packet drill reproducer ;)
---
v1 -> v2:
  - drop unneeded delta in patch 1/2

Paolo Abeni (2):
  mptcp: restore window probe
  mptcp: zero window probe mib

 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 8 +++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.51.0

