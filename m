Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0E393DE6
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681005; cv=none; b=KV1vRov2ugY6S/SlD57UD8jVPPxB88JyMO4/ow45zl4sSW+iahlPzNQlOFnVcQf5b7CCdeK0aDYqy0iaJp6/pSed2aWv/94RyI/amWNhDLAHWobd0fVY9EuzExdRKoyk8cmyp8GwYd+jn4BxvtzIRtsPLxIra0QPA2TbA1Xro8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681005; c=relaxed/simple;
	bh=AoEnoDLqXbeFoQVhKOPgLTzlc8sLrUAoI7MwS0V/e5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=L4MLe3l1Ujjjs5csJWAMc6qLGSEz/+pJFfXTP+6VFHlRVHCIaNWUttN+d/zYoPHUbTMslDuoIKKtQVjzUXhvLJUKigrXarnSEcGG/BmRuYcP+TsWmhye9154I4P66MooL2c4AIsH5EyQjeNtPZiUN/dvZf4Psl/0zStzMUZmSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=baUM0N31; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baUM0N31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776681003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7oOsBjoBRNUy1CHbditfQowtuA0dkjgUNA2sTaPBCow=;
	b=baUM0N31F7NlPPnU08S7btgtTM1eSAnp1KfRt2jfOwEaCGS1xdne9Amfwi6ZmAdItLIOpx
	KWeaFhhfaSBdApG2oJ7zh0gN0cLxKQIdQLoMtZwqWigEqc6U7umiAx9iSimqQIDM5zMjI+
	p14lXxR4E5YnLW1EhANpskOHtY/ySds=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-L6nR6ulANcaBqsxMfop0GQ-1; Mon,
 20 Apr 2026 06:29:59 -0400
X-MC-Unique: L6nR6ulANcaBqsxMfop0GQ-1
X-Mimecast-MFC-AGG-ID: L6nR6ulANcaBqsxMfop0GQ_1776680998
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57957180049F;
	Mon, 20 Apr 2026 10:29:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79A07195608E;
	Mon, 20 Apr 2026 10:29:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [RFC PATCH 0/6] mptcp: address stall under memory pressure
Date: Mon, 20 Apr 2026 12:29:24 +0200
Message-ID: <cover.1776680489.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kFbz_9IHO3R6vWWUqGdd6dmoF8SIPTNHiCZXBaDgmEk_1776680998
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is a very early RFC to discuss a different approch to solve the
data transfer stall reported by Geliang and Gang.

There are a few open points documented into the individual patches, the
goal here is describe with some detail the intended architecture.

Note that the diffstat is biases by the quite large patch 2/6, which
contains mechanical transformation of existing code; "real" changes are
noticiable smaller.

Paolo Abeni (6):
  mptcp: move checks vs rcvbuf size earlier in the RX path
  mptcp: sync mptcp skb cb layout with tcp one
  tcp: expose the tcp_collapse_ofo_queue() helper to mptcp usage, too
  mptcp: implemented OoO queue pruning
  mptcp: refine coalescing conditions
  mptcp: unclone skbs before coalescing them, when needed

 include/net/tcp.h    |   4 ++
 net/ipv4/tcp_input.c |  55 ++++++++++------
 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  35 +++++++++-
 net/mptcp/protocol.c | 154 +++++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h |   7 +-
 7 files changed, 195 insertions(+), 66 deletions(-)

-- 
2.53.0

