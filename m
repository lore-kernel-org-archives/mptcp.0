Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E072222C4
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111849; cv=none; b=Dxhm6zmvc6PUH5lJogDrBZuHkNTzRVF1x2cVgouQUxZJ/pTQX0B7356Qtl/OAHc99dy/An7ahRLP7/stVtDh7W0iN5BrHe8NI4atHGFVX+aQGQ89cFWoxVtpsO3F7DqhYJJV7SFOSZu+hdgOxsg7Sn1OJQYFkMnbKLKLs3fS0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111849; c=relaxed/simple;
	bh=x1UcyToYPmoDo1fv0Kk3fHucczcrVLaKOcXlb3zGeI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=rQNHFaY5G5cXwKaN4ZWiqCglYAWAkNmcCVxYIx30Y2TMnreCN84kKWB08aHbzKTuWGVVbQVpInhx+Nsh7/HXNmYPf44aZ+eFJKeteF5P4ypmerm8F6UtNjx1QfrHdcx/rrnvAt0QK74z8ez64jTcFgPErhqUh6j1Bvbg/p2j7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDXa0526; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDXa0526"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763111846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bR5lLoPIToDlyRuJIFjoSjdIV4CCl8Me8yFHwjOZxJc=;
	b=FDXa0526tqnq7JpC0Ka1vIJERuBJAZsR5uVgm+fuz2AuhwgMHJXm9YlGgydLQwIWpiC61S
	ke9yjXSXRACBwbyL/v5B/aY7CUNEf51fOmESQlK2xe46ilDwuzbKsxzuU+lq5wMVG81BR8
	UrIpEMLmj/+vk7bupAWSJ7SRsZLSpZc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-C0TjLlImMMmguTSiAGNA-w-1; Fri,
 14 Nov 2025 04:17:25 -0500
X-MC-Unique: C0TjLlImMMmguTSiAGNA-w-1
X-Mimecast-MFC-AGG-ID: C0TjLlImMMmguTSiAGNA-w_1763111844
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 570B71956094
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AE5E1800451
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 09:17:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 0/3] mptcp: cg and backlog follow-up
Date: Fri, 14 Nov 2025 10:17:11 +0100
Message-ID: <cover.1763111767.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sxZEC_GioQfGFF0662MbzS2NxD8ir4YdSJYwCCzvSLQ_1763111844
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This tries to fix the existing races in memcg accounting with the
backlog.

Only minor delta over v3: typos, build fix without CG, and reworded
comments/commit messages.

Paolo Abeni (3):
  mptcp: grafting MPJ subflow earlier
  Squash-to: "mptcp: fix memcg accounting for passive sockets"
  Squash-to: "mptcp: leverage the backlog for RX packet processing"

 net/mptcp/protocol.c | 110 +++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |   1 +
 2 files changed, 92 insertions(+), 19 deletions(-)

-- 
2.51.1

