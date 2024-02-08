Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79D4C3BF
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424979; cv=none; b=eBqXp1o7RHukVzfnqehptUZxYBEcs7AfQnrFnm5lTKLS5JR2X/5+oTtiqiSR8hoCoZdpg8gvQhYpvsUmGXNFTtwbIvYp6shY2P1ot1TtEL44+/W6MlYjeTF0TmVWf/YZPGAEI9NEi7gDHVOt0Fv5u09SaN0i44znOP6tcpQKSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424979; c=relaxed/simple;
	bh=avqaK0hTAc3eHzw9LQQok7m1fsGC84xTiQVVPcmVhOE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hIQy9Yxqqsdua9yIlVgZJvY98COTsF/e5HWSZtJ/nNeutPU+uziqPTCtH3GeohjG+D4RHHJRulde1F/qvYgMWKUmPH/8aFccKDk96ANqmQ2g2RR5hAisU8xdSgHxaAIF3tN3amOc7ViHgSQXyESkm5puzBJBAy3og3yFsPsNTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJbmazdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJbmazdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707424976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X+T3pDSE4GzBtwDl/7Y9gY4js69jjM8G/+wEHS3v5ao=;
	b=IJbmazdnMFWO+/0Fom3LpQhgIUEXG2eJSLvAo2T3ZpDRXjAxZVuCBG1auXKcX7xMiMWQD4
	yVyhWVaMKE0ZTwcBEAi+OosjsK1lg8OhXz5YDqb1WxowKDkE6ph/Fhvc4yeBHMAaURO5Uq
	T7pO/QImuelbWBGQkrR4rKQpjvkTpRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-I4lEULo9OfehtNQYaqwiyA-1; Thu, 08 Feb 2024 15:42:55 -0500
X-MC-Unique: I4lEULo9OfehtNQYaqwiyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D040F8489E7
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60D4BC08EF7
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 20:42:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/4] mptcp: fix duplicate subflow creation
Date: Thu,  8 Feb 2024 21:42:44 +0100
Message-ID: <cover.1707418323.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

As reported by Mat, the in kernel PM can, in some edge scenarios,
unexpectedly create multiple subflows with the same local and remote
address.

The real fix is implemented by patch 4/4 with some more accurate check
at subflow creation time.

Patches 1-3 are roughly optional pre-requisities, added to avoid
introducing more data-races with the actual fix. Patch 1/4 is a bit
debatable, as it changes the existing ULP API, but I could not find a
better solution and there is some similar prior art:
commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info")

This address feedback from Mat on v1, see the patches changelog for 
the details (no changes in patch 1/4).

Paolo Abeni (4):
  mptcp: fix lockless access in subflow ULP diag
  mptcp: fix data races on local_id
  mptcp: fix data races on remote_id
  mptcp: fix duplicate subflow creation

 include/net/tcp.h        |  2 +-
 net/mptcp/diag.c         |  8 +++++--
 net/mptcp/pm_netlink.c   | 45 +++++++++++++++++++++-------------------
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.c     |  2 +-
 net/mptcp/protocol.h     | 15 +++++++++++---
 net/mptcp/subflow.c      | 15 +++++++-------
 net/tls/tls_main.c       |  2 +-
 8 files changed, 54 insertions(+), 37 deletions(-)

-- 
2.43.0

