Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFFC43E4B1
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480087; cv=none; b=G/0jU/QoDovD94bti5VGaKx9Bl8sra83vQliuaVXYucTfhEh3lNEiSKk5LGpXPRVTLsdkE/mZaDXmtCI8c5tZcRRBom/iI4ynJBTGJBZjj59x9FEnfH0ci7n6NR6PdeU3K850hU+uHAbn0enVixnfSo1joSoKIg3JdAkyKaWUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480087; c=relaxed/simple;
	bh=MiDACbaH6nB+WUNwIeIVEfN84Edm7yEw2HSEp+V3a0s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=qcguQNqXil/8WKpeyH3Op76U9qjHKQT6pTawrsIuHHciJ8cQwkJLddzspLx7SuztcAO1G3DqGKJTVhvYVP+B8G5LTewF/7CNPnKqqu0bOv4IBP9mmJW5Dty5/jq5gQZM2YKdRoBPg0BF3OFINhNh5dHAAfnVGA4RYWgMowp/Od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iu0+FYtd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iu0+FYtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780480085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SybGoe7CzmAPq6es/PJM+QQHpc+/Moek0o/KDRqlFnc=;
	b=iu0+FYtdpFloOgRc4yv7A5pPU4AdUecQFXdEomn/ZhR9F74/UGW1K91THq9JnSBg6srShi
	rv/sYMA0PlWVhAACHgemJUyhtwEzRvkYJYA925tlheMcS4p0Gaw8AnKue3a6n4Cezs+Cg2
	LVFbBpxraf4Jdx/hElSmjUBgKuSLE9Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-Pkz4PPIhPrOKiIxRm3x2cw-1; Wed,
 03 Jun 2026 05:48:03 -0400
X-MC-Unique: Pkz4PPIhPrOKiIxRm3x2cw-1
X-Mimecast-MFC-AGG-ID: Pkz4PPIhPrOKiIxRm3x2cw_1780480083
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3DF9195608D
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 09:48:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 001F9180049F
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 09:48:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v12 mptcp-next 0/2] mptcp: address stall under memory pressure
Date: Wed,  3 Jun 2026 11:47:53 +0200
Message-ID: <cover.1780479980.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6mmb--4nDSyxXzMPP4597FAqebvSjsTuTwKgBOO8K9g_1780480083
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This brings (hopefully) the final bits required to address the
data transfer stall reported by Geliang and Gang 

This series improves mptcp retranmission to make them reliable:
pruning can require some of them.

The only change over the previous iteration is in patch 2, addressing
 sashiko feedback over the previous iteration (possible infinite rtx
loop).

Paolo Abeni (2):
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 net/mptcp/protocol.c | 155 +++++++++++++++++++++++++++++++------------
 1 file changed, 111 insertions(+), 44 deletions(-)

-- 
2.54.0

