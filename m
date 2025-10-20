Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7225776
	for <mptcp@lists.linux.dev>; Mon, 20 Oct 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976621; cv=none; b=MrUzg+10DZgXeeJoDL4cr09qUjHtcqcvvwJfikqF+AIRhWXdJsm4Vc9x8Kvw51GmSegWa1VNCSLm93hs3Iz/UnvdKFmsHzOrfuW+3Y4yURvU/FUgtSWSTDxDEKlIvUb9PVJ4W+kFCVLZ8Xi6b+aT9HQrvyh6Qh5NBpUOXx8MbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976621; c=relaxed/simple;
	bh=chnxyvw60Q06LgP4+Ez7YdY+dBqQQS4IVjhJ+Eo53SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Y5odGBT4DNO6yBks0Ng0Yt0HIJrR0bWc/sJITsA7ysYFW3W/3dD9K6z+CmmCqpsi0wws5QoqHvNc26iUdWt+nfun9QRWb1tirMYcSA9QXsmOV0zF87NfqUhGyI5nj2ck1URdpWUGjlahsY+8tQmhIIXqbfZ4o3TnhknzHJo9ylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmkzHhdw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmkzHhdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760976618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+6D+RIFI0C44Jgxy8SqjFsEmCnsjTSMEGlgTsyIBzc=;
	b=SmkzHhdw5Q839dHm7dOcfPzBRyLd/npRiwQuRB7kR7h/S/KsUDYl6Ylh815ueOue1EWkuX
	YpUq8wZ+EjFN/pri91CgUl9mw5n2yiavI2qBB5CYBz6FWmlzoeiVPbTvZXeX7uCF1zH4lD
	1DrIdS7bKom46ko8LwO4rLtOMuvRsSk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-QGadXOWDPGGRVcKDykwJzw-1; Mon,
 20 Oct 2025 12:10:15 -0400
X-MC-Unique: QGadXOWDPGGRVcKDykwJzw-1
X-Mimecast-MFC-AGG-ID: QGadXOWDPGGRVcKDykwJzw_1760976614
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB0AD19560B3;
	Mon, 20 Oct 2025 16:10:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA91C3000218;
	Mon, 20 Oct 2025 16:10:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org
Subject: [PATCH mptcp-net 2/2] mptcp: zero window probe mib
Date: Mon, 20 Oct 2025 18:10:02 +0200
Message-ID: <1873f5bcb2958cc2366664e46d22c18c410748b6.1760976334.git.pabeni@redhat.com>
In-Reply-To: <cover.1760976334.git.pabeni@redhat.com>
References: <cover.1760976334.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aqLOSeStWJu3aUVSiry4vzSoCamt0l8ZbURSqRfkHrQ_1760976614
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Explicitly account for MPTCP-level zero windows probe, to catch
hopefully earlier issues alike the one addressed by the previous
patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 6003e47c770a7c..eb4645a9c5ac07 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,6 +85,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
+	SNMP_MIB_ITEM("MPTcpWinProbe", MPTCP_MIB_MPTCPWINPROBE),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 309bac6fea3252..f83a113700522e 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
+	MPTCP_MIB_MPTCPWINPROBE,	/* MPTCP-level zero window probe */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fe029359b7d7a2..67919ae774cc40 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1396,6 +1396,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 mpext->dsn64);
 
 	if (zero_window_probe) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPTCPWINPROBE);
 		mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 		mpext->frozen = 1;
 		if (READ_ONCE(msk->csum_enabled))
-- 
2.51.0

