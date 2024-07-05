Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87C14431C
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211651; cv=none; b=ZyacmQh4bC5HmrhH29SbbxbwIESIKOl7Ub4yL2OxdEHVZ6sPkqrzyO5ZHDNJLWSWuycExDsNs+xCdC38p7Wbzm3G5GhzJGGi9U1CwoEr7bJvYElEn2jaPO4g4GSBDUGwF684YTJHLR1eKVKxD62H4by9p5NOmmBBVN3P7V5NbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211651; c=relaxed/simple;
	bh=JcJBVsYTeHZc2JPGwO027s9vpqHrCnGk8PnZwsPS5gY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R5I7JtooTFguNfbyevckkoNKYifkVa2ro/yajMJj5miiUVX/o4hdtY/GiZ0Ss2va9Rmz/cMi92kCTLL0/MOFD01bAH6E7Lcgy0tsaXQ5Lc1+qcyREOXbedxdFvgSpvnSm7Rnd69mwMr92NJrv8IBEYe9glED55VfFDMcg4hdhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Si+avCSN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si+avCSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720211648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kLKgO9xGl7EvkE5TJV0rzQ/HwHx9pONAFK15+KA4lr4=;
	b=Si+avCSNI6GFDmeM7vgZ9sRw5ij2hh9dndD4qhmhpWPEplhiaWJTS+pSGUKHqIy0GmJk2A
	YAkYTPuJdlfc5BYHoLYctB82RpsPgI4R469raNqwLhLszsiEEtNXhXVGPOms8iYmUjjw7c
	//5vBBRxmpvOiaZnbN/C3CBkM6xwVPU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-ZJoEKFJPNiSIgIwokC5pXw-1; Fri,
 05 Jul 2024 16:34:04 -0400
X-MC-Unique: ZJoEKFJPNiSIgIwokC5pXw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6735A195609D
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 215D41955F3B
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/4] mptcp: fix signal endpoint readd
Date: Fri,  5 Jul 2024 22:33:46 +0200
Message-ID: <cover.1720211515.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Issues/501 showed that the NL PM currently don't add corectly removal
and re-add of signal endpoint.

Patches 1 and 2 addresses the issue, patch 3/4 introduce a related
self-test, and the last patch address a pre-existing buglet in the
self-test infra.

v1 -> v2:
 - splitted the first 2 patches
 - fixed accounting in mptcp_pm_remove_anno_addr
 - self-tests depends on subflow_rebuild_header

Paolo Abeni (4):
  mptcp: fix user-space PM announced address accounting
  mptcp: fix NL PM announced address accounting
  selftests: mptcp: add explicit test case for remove/readd
  selftests: mptcp: fix error path

 net/mptcp/pm_netlink.c                        | 27 +++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++++++++++-
 2 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.45.2

