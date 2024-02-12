Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613018646
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751158; cv=none; b=pocsvICprD9BBVu5xAlFJR7sxv0MlGbA5W+GdnV+vJI1+M7Sw4UEZIF64910XDS7fM+Bn96frwOPU5FXHXXdbetxm4yT1drEO5UR08ltfFM/P64kfd5594eIlznlnQgyjQuX8Gp6Juqv1tPQpTQM5KaLo5ZdMO+vUitqtXaAw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751158; c=relaxed/simple;
	bh=M1zMNzZBhmMWDrzBXv4bbK73IJ7Nf5hz8QynK+NUng8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jTgRgt0fF+kzh0ksEEKLluiZBVBOVpS3gRyIJO/scAux4S+LWes3no0oW8vxzVpSQZZYJxEuQCQFUS0R/h1V8k59meFIJwLqjl4ZTJC8zOWW9G4B/b6LIvk0gD3ukL9i5drMvi7kUGabt8eEOddRepQKhS1a3vVhTv/ud411Gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwAqrkwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwAqrkwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m+wlHaKNvY6j8o8m8YzA9UJu/MyNoijDlK0xzbvAN9o=;
	b=AwAqrkwcCWrIodfZvvTkHO2PCcmtw8MFRARgHieWL2KTq5eW7fHoPj/w+APpmxywTMH63d
	++9YzUaQQLD7uEbJ9/uIykTU5VWYgRXWxzaHi/DqGwhsyTNFYwgr5tfr+NMbFhWWBLfbkM
	iCgQkIPoikd8rOi3i+yyE0+WmGaFqSY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-KPUPGRb6Pm-zkI7u4X0osw-1; Mon, 12 Feb 2024 10:19:14 -0500
X-MC-Unique: KPUPGRb6Pm-zkI7u4X0osw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 018C1859703
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8288B492BC8
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [mptcp-next v2 0/7] mptcp: implement TCP_NOTSENT_LOWAT support
Date: Mon, 12 Feb 2024 16:18:55 +0100
Message-ID: <cover.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Patch 6/7 does the magic, all the others are minor cleanup and fix of
buglet exposed by such feature. I'll push a paired pktdrill test.

Note that this relies on the existing accounting for snd_nxt. As I
stated such accounting is not 110% accurate as it tracks the most recent
sequence number queued to any subflow, and not the actual sequence
number sent on the wire.

I experimented a lot trying to implement the latter and in the end it
proved to be both "too complex" and "not necessary".

The complexity raises from the need for additional lock and a lot of
refactory to introduce such protection without adding significant
overhead. Additionally, snd_nxt is currenly used and exposed with the
current semantic both eBPF and the internal packet scheduling.
Introducing a different tracking will still require us to keep the old
one.

More interesting, a more accurate tracking could be not strictly
necessary: as the MPTCP protocol enqueues data to the subflows only up
the available send window, any enqueue data is sent on the wire
instantly, without any blocking operation short of a drop in the tx path
at the nft or TC layer.

The individual patches changelog carry the gory details.

Still sending a single series to outline the functional requirements,
even if the first 3 patches could land on mptcp-net directly.

v1 -> v2:
  - clarifiy commit message in patch 1/7
  - fix possible wake-up bug in patch 6/7

Paolo Abeni (7):
  mptcp: push ad DSS boundaries
  mptcp: fix snd_wnd initialization for passive socket
  mptcp: fix potential wake-up event loss
  mptcp: cleanup writer wake-up
  mptcp: avoid some duplicate code in socket option handling
  mptcp: implement TCP_NOTSENT_LOWAT support.
  mptcp: cleanup SOL_TCP handling

 net/mptcp/protocol.c | 66 +++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h | 57 ++++++++++++++++++++++++++++-------
 net/mptcp/sockopt.c  | 71 ++++++++++++++++++++------------------------
 3 files changed, 126 insertions(+), 68 deletions(-)

-- 
2.43.0

