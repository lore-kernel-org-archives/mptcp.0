Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289159B40
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082942; cv=none; b=Ep1jcp+6gnx741KuWHND0kycIN2vdPrr70jwUgVQpRCz4xnVZkMc5B5lmWMGf2VfY/DQeQkkGqundtop7oT39bhE8I0TByoj5Kl5YJT5QzIFq5Jbw/eo/LjREc4CEQPsqYzhUHyT761tf9aqtIepotKeAofEMFZy0oPY7RrqOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082942; c=relaxed/simple;
	bh=rbrpJnbf+HXMGwLV51VL83P+0jX30591Cg3coicNbuc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5jbkVbleQcmFN7BDeSq8siz/bHkbn8RmyhYdD0wGubTe3QknZX+/N8WGhcVvLcJGUDCeBI0nFy4xt7KVWf/yE2LumwipD8t/07nOLgJsoVpdeDveDWkE2gHxUDHp0CoMNXi4Lj7P3UVY2Cshon8fwxQ4dhVCsBPk8k+8Wdu/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkdFNC+Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkdFNC+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P5EdnVvlsvDh9OMJr0YHjaaU44vhggr8m57rTvT46no=;
	b=AkdFNC+QBwl24v6aHRKqA0N2qi8x/EsCKsHJZ34BcLuiL3TAJwIiim+IwgbvesC80ZrH24
	5t6ppks947UtG8RyGcAeR2P5FjqQ8uPA5ACWxeGCKUFFwD5+nbEJ8lFNZLRWLhTIFnY26o
	bbscIg2IUS858pAbtHh7jsr+MxnVh1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-gKMyjRL3OW-m3B5BvUnApg-1; Fri,
 16 Feb 2024 06:28:58 -0500
X-MC-Unique: gKMyjRL3OW-m3B5BvUnApg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBD8F3C02B9A
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:28:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B3F5492BE3
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:28:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 net-next 0/7] mptcp: implement TCP_NOTSENT_LOWAT support
Date: Fri, 16 Feb 2024 12:28:11 +0100
Message-ID: <cover.1708082765.git.pabeni@redhat.com>
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

v2 -> v3:
  - typo in patch 1/7
  - dropped unused code in patch 3/7
  - dropped duplicate code in patch 6/7

v1 -> v2:
  - clarifiy commit message in patch 1/7
  - fix possible wake-up bug in patch 6/7

*** BLURB HERE ***

Paolo Abeni (7):
  mptcp: push at DSS boundaries
  mptcp: fix snd_wnd initialization for passive socket
  mptcp: fix potential wake-up event loss
  mptcp: cleanup writer wake-up
  mptcp: avoid some duplicate code in socket option handling
  mptcp: implement TCP_NOTSENT_LOWAT support.
  mptcp: cleanup SOL_TCP handling

 net/mptcp/protocol.c | 57 ++++++++++++++++++++++++-----------
 net/mptcp/protocol.h | 51 ++++++++++++++++++++++---------
 net/mptcp/sockopt.c  | 71 ++++++++++++++++++++------------------------
 3 files changed, 108 insertions(+), 71 deletions(-)

-- 
2.43.0

