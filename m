Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1D1CD1B
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428986; cv=none; b=PBb94C+DaEouY/1IaeKMFL0S7KPxjQwNneXVCkWjforqQs0SoKMTy1LMrKSFDi+KQZ2DiJXWIEqy2LqIQwxPNXrXCwzydKvrWfcbluXtqKyLmtH2cbVfw7bZVlGv7aFBnFGol7AX6a6wPwhwdSRRFQE60hk2hNrNyayJmDQH06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428986; c=relaxed/simple;
	bh=Ckoz91tqwfpC8OTv4ryEApO4IRZUtDwDgVCZ58plhTk=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:
	 Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Transfer-Encoding:Content-Type; b=NU/zqyXjQqDgisqh1y8Z1gpjXubBbIkQfgodrmyKmxHVtjw7oegMMlnhNnc69kc1ZYJUk3wvW2lyzOwfbdfxn7q8kf+nKALyH5vf1Zstu4TxcKrkwoEG3NoIPTZBgp/PUfuS6dgyDgUAUfSKAeCX2YEZfcR8GbDnXBMG/zaf5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUF2rgqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUF2rgqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qd/L++BSzU9fQ6IWVMm/P4NmWmDeQP3vTRcdcWwirRg=;
	b=jUF2rgqIU594JCSDBG80iOiLY4injpuPnVmkTm+uiM3Gr5q2LRtwJLUFRqx/rsm+YrFOiY
	YoQbCyYCsjVWcQloZQf3GY70Ing6XhLK+nhlZ6VSWrYRgZLcIhlDuS/fnw1eK1m/FKa012
	HNZpWPmhgW4Q1HKfPhqux/jCmuuRtlc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-5vK75vSvOXKeAYWJpVPxkg-1; Tue,
 16 Jan 2024 13:16:22 -0500
X-MC-Unique: 5vK75vSvOXKeAYWJpVPxkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FA5B299E74A
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 202891121306
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/5] mptcp: annotate lockless access
Date: Tue, 16 Jan 2024 19:16:09 +0100
Message-ID: <cover.1705427537.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is the 2nd preparatory series for the TCP_NOTSENT_LOWAT support.
The latter will need tracking more state under the msk data lock

The mptcp locking schema is already quite complex. We need to clarify
and make consistent the lockless access already there or later changes
will be even harder to follow and understand.

This series goes through all the msk fields accessed in the RX and TX
path and makes the lockless annotation consistent with the in-use
locking schema.

As a bonus this should fix data races possibly found by fuzzers - even
if we haven't seen many such reports so far.

Patch 1/5 hints we could remove local_key and remote_key from the
subflow context, and always use the ones in the msk socket, possibly
reducing the context memory usage. That change is left over as a
possible follow-up.

Paolo Abeni (5):
  mptcp: annotate access for msk keys
  mptcp: annotate lockless access for the tx path
  mptcp: annotate lockless access for RX path fields.
  mptcp: annotate lockless access for token
  mptcp: annotate lockless accesses around read-mostly fields

 net/mptcp/options.c    | 20 ++++++++---------
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 10 ++++-----
 net/mptcp/protocol.c   | 51 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h   |  8 ++++---
 net/mptcp/sockopt.c    |  2 +-
 net/mptcp/subflow.c    | 10 +++++----
 7 files changed, 54 insertions(+), 49 deletions(-)

-- 
2.43.0

