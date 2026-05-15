Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A3372698
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836068; cv=none; b=qARobddtqXIs/c9wwf8irrQt4Z9Oyqj9mBi0WQ/Ln04cgxTfHT5UYnMlwctKYf2uHwYz+btjfggTTq3m1y0BrT9ejtDSBgQPzDrJeApgSk63XxP6qCBTDgl6Ejq+Y6cwd9P+MB8g+Zn6DUkNPBhdTp998l3iHod5L2uw8Hu06OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836068; c=relaxed/simple;
	bh=LsMWbkCGBTeRrb8s5Mvy+DmEyb7h+gUqFkVIMUMWXbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=IjNkKAwX7Sb/4n/betUPLiRiV/paZM/2YzppZH447lR0W3y1cLu2JT4yZLbSJHHrmgUf302DOutHTvExyFdJA3v2hcedWwMdz+FK3D/GkjYOBWm8qHOJq0ZjWx3B5AOry0w6aNYM4IToh6t9uWMlKUedcrd+u0mbd3pxkfn3enU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtuvvteN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtuvvteN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UuiZlINuVy9hSPtaZXfSnCB1HtFDEa9mNoxFNKpfLrU=;
	b=TtuvvteN6m5tq8KPT32uCqFt3DSdVE7jqTgWQ1Ndz8ttoedveo9uvJbfU9ueyK6ulJVOFw
	jhZyYvSCZQ7QmwcjN6sL3INOgRJsWuEVFIRI7g/Kse1Rp/d2N67XUeP6dSOPZUh6kRE/Ha
	iA5aHRhdOXw/qG0bvxncrA4NG+iUk7I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-uOJaXN0dMWipR3x5TGqZtg-1; Fri,
 15 May 2026 05:07:41 -0400
X-MC-Unique: uOJaXN0dMWipR3x5TGqZtg-1
X-Mimecast-MFC-AGG-ID: uOJaXN0dMWipR3x5TGqZtg_1778836060
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE5F018005B2;
	Fri, 15 May 2026 09:07:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CFC61800347;
	Fri, 15 May 2026 09:07:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v6 mptcp-next 0/7] mptcp: address stall under memory pressure
Date: Fri, 15 May 2026 11:07:21 +0200
Message-ID: <cover.1778835009.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UUsYvIk1lWDZ1fz-Le74twO_m5_ojlDCY-Uy-Rk8Km0_1778836060
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This an attempt to fix the data transfer stall reported by Geliang and
Gang more carefully enforcing memory constraints at the MPTCP level.

This iteration presents a significant change WRT the previous one,
avoiding entirely the collapse attempt on memory pressure. Note that
this choice represent a trade off: collapsing allow much faster transfer
(to be more accurate: order of magnitude less slow) under some extreme
conditions, but makes transfer slower and much more CPU intensive for
less unlikely conditions.

As a consequence of the above the `mptcp_data.multi_chunk_sendfile`
test-case needs a 240 seconds timeout to complete successfully:

TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)

The solution performing data collapsing would need similar long timeout
for the multiproc tests cases: mutliproc_even, mutliproc_readers,
mutliproc_writers, mutliproc_sendpage_even, mutliproc_sendpage_readers,
mutliproc_sendpage_writers.

Patch 1 is new in v6, and is actually a fix for an old issue (targeting
net), included here just for my convenience.

Patch 2 and 3 makes the admission check much more strict for incoming
packets exceeding the memory limits, with some exception for fallback
sockets.
Patch 4 makes implement OoO queue pruning for MPTCP and patch 5
addresses an edge scenario that could still lead to transfer stall
under memory pressure.
Finally patch 6 and 7 improve the MPTCP-level retransmission schema to
make recovery from memory pressure/after MPTCP-level drop significanly
faster.
---
Paolo Abeni (7):
  mptcp: fix missing wakeups in edge scenarios
  mptcp: explicitly drop over memory limits
  mptcp: enforce hard limit on backlog flushing
  mptcp: implemented OoO queue pruning
  mptcp: track prune recovery status
  mptcp: move the retrans loop to a separate helper
  mptcp: let the retrans scheduler do its job.

 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   2 +
 net/mptcp/options.c  |  67 +++++++++++-
 net/mptcp/protocol.c | 249 ++++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h |   4 +
 net/mptcp/subflow.c  |   1 +
 6 files changed, 259 insertions(+), 66 deletions(-)

-- 
2.54.0

