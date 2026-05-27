Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF1345749
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878785; cv=none; b=AJn/+s8RmcJhrQN3WKOewsMFs/h9yvbjnm0lfSXLDBn/3KYsNCYsL3fYfHj1BtyKDjY2NiF2koxtIJ8FU6bHMax8r/icKDEm5+f6bPZ9QQDow/D0qQaGzXDpyEclAZPxbpzd/KsLpY3CNMJkYNc0tv02lPUg1A9NMq2Ba1PHmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878785; c=relaxed/simple;
	bh=4KYEhqkmeZ95rSL7q66nLHC7SzSdmFxmin4fV2C3PpY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=hIgulg6hI7WZruXMxBVWP5HlYTZ5dWoNpf6XwDFDJpuT51BXjrmOeICZdQLw2jPYOvMiDaWRV1hBSRzwFRHTW2WR+E+aFVpeucnJFrSXGVD9zdErmBlvbjaoWYUI/IlS3YqrWD5UcJoFtkEIOwoVD/I5Xx9HqG2dA9Qc4+eSz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKNwVhRf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKNwVhRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779878782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4HG5gZIRIGFVEoIRPKxTjzCX+dTAWuqSrJu5+HD0MCQ=;
	b=MKNwVhRflo+20UEpqAFz1yXQ2mFGfYowZz6tgihNreKJb03+sowupI/F5LAudfSBGZH5me
	Lv7Toi55NVOGGYu4Nz8jPCxIv7jaAjijZUQJWLAsdF5wmwxDP6mmsnKT8dNRpCmv5j4DV1
	5YOfBw4tivXN+lZYUe3e9+3D5iReGaI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-q5mgEHe8Ob6LmZudbXdTbg-1; Wed,
 27 May 2026 06:46:21 -0400
X-MC-Unique: q5mgEHe8Ob6LmZudbXdTbg-1
X-Mimecast-MFC-AGG-ID: q5mgEHe8Ob6LmZudbXdTbg_1779878780
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA1951956048
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAF1119560AB
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v9 mptcp-next 0/6] mptcp: address stall under memory pressure
Date: Wed, 27 May 2026 12:45:30 +0200
Message-ID: <cover.1779876523.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KHnxyajnCGuKQe3l06PeAl4PBYyRVGdI_3XMtqzM9SA_1779878780
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This an attempt to fix the data transfer stall reported by Geliang and
Gang more carefully enforcing memory constraints at the MPTCP level.

This iteration introduces has no significant change over the previous
one; the already merged patches has been dropped, and the remaining ones
rebases on top. The main delta is the commit message for patch 4, here
completely reworderd, as its content become obsoleted in the past
reworks.

Note that `multi_chunk_sendfile` and `multiproc*` test cases in
mptcp_data *may* require longer timeout than default[1].

Patch 1 is actually a fix for a pre-existing issues targeting net,
included here just for my convenience.

Patch 2 and 3 make the admission check much more strict for incoming
packets exceeding the memory limits, with some exception for fallback
sockets.
Patch 4 implements OoO queue pruning for MPTCP.
Finally patch 5 and 6 improve the MPTCP-level retransmission schema to
make recovery from memory pressure/after MPTCP-level drop significantly
faster.

[1] In my testing on v8 and v9 mptcp_data survived a few hundred
iterations with the default timeout. Some independent testing would be
appreciated.
---
v8 -> v9:
  - dropped already merged old patches 1-3
  - reworded commit message in patch 4

Paolo Abeni (6):
  mptcp: allow subflow rcv wnd to shrink
  mptcp: explicitly drop over memory limits
  mptcp: enforce hard limit on backlog flushing
  mptcp: implemented OoO queue pruning
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  35 +++++-
 net/mptcp/protocol.c | 247 +++++++++++++++++++++++++++++++------------
 4 files changed, 218 insertions(+), 70 deletions(-)

-- 
2.54.0

