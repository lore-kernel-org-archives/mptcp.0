Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE086AD6
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539746; cv=none; b=ZOgbCMPDfP6kgKcH3wwAy4faEbeD3lh47YET1TeC/KmrMPv8K2/HylypLgJA9BrVJSSBHseR9U47KBQ2JgUN2XQZo3EgGjahAQp+btr5B2jt0zqgN5joaGYx2gvXvNP3Bq6R38m3sWrpFUN1OjgjiF+Ec1oRHBAhML4WzIj2cHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539746; c=relaxed/simple;
	bh=PFR8KchSLjAKo3ExLr/BrBo+ZQLu3CoOy4iClD/tK6o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eV58CEYv1rxuhwP0zCqDIwMQ/gCGd5L4uUC4o3DID45JyDjRbrtZaVXdBsVHPpxgw7SjGks4XN2oR9a/2dQkSTtnnCGQ8ImQZnRTb7ICJq9x6usX8b2lyDMjnFelnBXX2bRC/CxA10P0zToqGHtf1f7NKkO192m1F5QB+h7Km+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0537/nz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0537/nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708539742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tdOPFVXlX0/wbCu0/oZqMQpFiAMh8v0ZSD26qozc8ds=;
	b=U0537/nzRUbLBIebTVshNbb6LgYixnAV341B+0I/+G3KttUPt/wrtd/p0Q98atFXIf69BV
	Xjlhxr5mbe9BOC7PDKEJ0kAx7OYmq6PN+p01uA0QqHeCAainjfqujP3HkAPlWgB/h7EhgB
	2MvjLvHJCyl70wS6SYcWhnccQEgu7K8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-JPPwPC2SM_Obnfacn0LKlQ-1; Wed,
 21 Feb 2024 13:22:21 -0500
X-MC-Unique: JPPwPC2SM_Obnfacn0LKlQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFC7E3C0C118
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 18:22:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EEC5492BE9
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 18:22:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 0/2] mptcp: fix another deadlock issue
Date: Wed, 21 Feb 2024 19:22:14 +0100
Message-ID: <cover.1708539640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Eric reported and diagnosed another possible deadlock problem with
the MPTCP diag code. The first patch address the issue, and the second
adds self-test coverage for the relevant codepath, to get lockdep help
to catch future similar issues.

v2 -> v3:
 - cope with very slow env

v1 -> v2:
 - fix (avoid) feature detection in patch 2/2 (Matttbe)

Paolo Abeni (2):
  mptcp: fix possible deadlock in subflow diag
  selftests: mptcp: explicitly trigger the listener diag code-path

 net/mptcp/diag.c                          |  3 +++
 tools/testing/selftests/net/mptcp/diag.sh | 30 ++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.43.0

