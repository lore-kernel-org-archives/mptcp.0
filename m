Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B607C0A4
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936136; cv=none; b=hbQK1OlfGF75IlhZxFg4yo4J3i30iV8Fi8jGyYw2D85fIFPONlwpeK0H/7lXjlOSNMFxRtUA11GxaoDzM+zRDtEDXpTttbJrp5tNIolWce1DtBw0GlMqR88JPfTg+ggmtnKB2ZSW68NpCo6UPlFtqRHG/xueBLGfUTwCrkyOctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936136; c=relaxed/simple;
	bh=3c09hhjW2ZL33hXv7/NZkwcWpc9RzcIMXjhksqpnSqQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6GcICuX5mtUBbs7qAtT8HeRql0atHLaecOKifQ+f0Jj0JjSWwPp3uMFpAJm0907YoT+sRsQZnxTNCnuzMjkz+XLqMnEJqRK+e7jQ7T1FIb9F8VxpK40G0GhUTEEbJvj3igLE4bsnaxhVKXMZQKn8lfnmd13uuq9CKgIFuVeDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hzyf0pr0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hzyf0pr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705936133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8hu58Ch7QiWkm3Y33XaxMOGZFyJpKwAwqA7w492g0yE=;
	b=Hzyf0pr04+A5o6NOSv7X41bkIwaK2WgAxB11TUzL3KQWYwQcHB6XWjQNoCvA0vzEo04rR5
	j8dFVzVYXkbun4pjMgOXhHWOTEpQqowBv7t43JN52twR0nNe7bud6LsghlJ2y/BDhMHgtf
	kmasFFCGks95AyDZ4useC7bVw/41lIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-RahBmQRaNPywza2iYlpTPA-1; Mon, 22 Jan 2024 10:08:51 -0500
X-MC-Unique: RahBmQRaNPywza2iYlpTPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 722C810AF991
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 021001C060AF
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/7] mptcp: implement TCP_NOTSENT_LOWAT support
Date: Mon, 22 Jan 2024 16:08:37 +0100
Message-ID: <cover.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

Paolo Abeni (7):
  mptcp: push ad DSS boundaries
  mptcp: fix snd_wnd initialization for passive socket
  mptcp: fix potential wake-up event loss
  mptcp: cleanup writer wake-up
  mptcp: avoid some duplicate code in socket option handling
  mptcp: implement TCP_NOTSENT_LOWAT support.
  mptcp: cleanup SOL_TCP handling

 net/mptcp/protocol.c | 51 ++++++++++++++++++++-----------
 net/mptcp/protocol.h | 57 ++++++++++++++++++++++++++++-------
 net/mptcp/sockopt.c  | 71 ++++++++++++++++++++------------------------
 3 files changed, 111 insertions(+), 68 deletions(-)

-- 
2.43.0

