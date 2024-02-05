Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31F40BE7
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148319; cv=none; b=H3+cx5XKJmzbJ2N1P30rqFOKe09shL7IQo9qnvIOynjn3yXKqzI94G5DJzbz/shCWUI5D4ZW60Z1K6/YUkuHhDdB45DlWGz8OC2yLU+MmAxiv87K2ELgO0jd7IgNUSN9h4I8dJGaSBjEf6h+YXdx15N9U2qp/NORkbyVs1USP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148319; c=relaxed/simple;
	bh=XHGOFosHuk7QS97Mvx03FeYIuEM+5+aRfTN7JeecRVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K9+tq/7e4R3scwb8nscFr7dG4TbeuUbL0t9UEL9v9uFBYTgdkwUhG47gGEtU2UtQ1Mhvjg8XdfkWasy24lX1cMq4pju/HhqML5jMQoWh0OG0zLRJkNeaX6cGm9pXf4idLa62O3kz7fXNPAU9KJGviwLNDCvhzzWcwwWd3ktsAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Syr7ocTp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Syr7ocTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v+yMO6L88dM4DukIhXhOPMWwi4PRwhNnWym+B1OZYi8=;
	b=Syr7ocTpPdfCM4Ojm1tyEL0Bxa/M4VGGqfh/mLJ9Qm8mf5TPynVxviyo66JyBxpablOcjk
	oPPR3sTlcC19mMzZUkW395zV2wgBtN9++/6lXAEpD5wRpN3OeMkjOEodZ3EX7Qo90Wm8AW
	5oHyvlXjxqSt2wly2dST8JtUzohtO2U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-j8aL27nIMjS1Z4k874i9Jg-1; Mon,
 05 Feb 2024 10:51:55 -0500
X-MC-Unique: j8aL27nIMjS1Z4k874i9Jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B7D92932481
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BE6C2C38
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 15:51:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/4] mptcp: fix duplicate subflow creation
Date: Mon,  5 Feb 2024 16:51:38 +0100
Message-ID: <cover.1707144963.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

Paolo Abeni (4):
  mptcp: fix lockless access in subflow ULP diag
  mptcp: fix data races on local_id
  mptcp: fix data races on remote_id
  mptcp: fix duplicate subflow creation

 include/net/tcp.h      |  2 +-
 net/mptcp/diag.c       |  6 +++++-
 net/mptcp/pm_netlink.c | 43 ++++++++++++++++++++++--------------------
 net/mptcp/protocol.c   |  2 +-
 net/mptcp/protocol.h   | 15 ++++++++++++---
 net/mptcp/subflow.c    | 15 ++++++++-------
 net/tls/tls_main.c     |  2 +-
 7 files changed, 51 insertions(+), 34 deletions(-)

-- 
2.43.0

