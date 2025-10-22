Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838342FB630
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118816; cv=none; b=DjRWF+Ng8dE803L7SkLx6g4SzZReshgmZvag+FY9mzhKMJYVSlIrIs7UBrbbbwLQ6smAJh6CuqWyL84XEughP96/U1x/KKbGc9HBjSlx4o01/LBzssTqaHdXtlZGRLIOcpnY82joTtw/JyknSEHxI+Ka0SaCdlTwZfv42Y1OXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118816; c=relaxed/simple;
	bh=T9sDTUNTyYjAfZ8C/pXlFvKQ0UGV9Es6q8eAbCz+TZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=L9wUWT2jVdoQPiXVyYRDNXVTpPtRKjk69DhHnypz1fKACMzEXabQ/Zjzn+dgqKgf2bbMK97U3CYEVkU9B9ZtfBRhP80HzMG5RpILPTEL2xH/IyUKKiUIGB7NeZqtoo9W/zlYYawe2GC49l/QdaJk8oorqkTqbsvVho3y0ro1Flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHLxyCha; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHLxyCha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761118813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HysgOzyA3cF65fSs/kVGVqMSpPl+9M1bxrx5IOBReo=;
	b=HHLxyChaFzn1P4msSri5cHMSzjXL9i894uSPx1fx1OjD+8yANO1T9qbWDYkdFZMKGvAn8o
	cNnmhGRUMJjFt5+E3Jprek74g8BXLop//TPGEfLJzNdR5QsnryNIxu+WQreSiwTiRdqR85
	Ow7VwZhZCsdnjOYJBs6X+tfaWNoT0Ss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-5MudHY9-PPeBPybA7HDWOw-1; Wed,
 22 Oct 2025 03:40:09 -0400
X-MC-Unique: 5MudHY9-PPeBPybA7HDWOw-1
X-Mimecast-MFC-AGG-ID: 5MudHY9-PPeBPybA7HDWOw_1761118808
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D16B618009C0;
	Wed, 22 Oct 2025 07:40:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C49730001BF;
	Wed, 22 Oct 2025 07:40:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH v2 mptcp-net 2/2] mptcp: zero window probe mib
Date: Wed, 22 Oct 2025 09:39:59 +0200
Message-ID: <9c935ea98196be13949542dcfe787e5bc799ae23.1761118636.git.pabeni@redhat.com>
In-Reply-To: <cover.1761118636.git.pabeni@redhat.com>
References: <cover.1761118636.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2ddb6RWbdIqPirf_iMlcvhuDJiPFCILLlXfbUR0VAr8_1761118808
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Explicitly account for MPTCP-level zero windows probe, to catch
hopefully earlier issues alike the one addressed by the previous
patch.

Reviewed-by: Mat Martineau <martineau@kernel.org>
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
index a7fa69cf79f106..7f2690f8d92756 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1395,6 +1395,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		 mpext->dsn64);
 
 	if (zero_window_probe) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPTCPWINPROBE);
 		mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 		mpext->frozen = 1;
 		if (READ_ONCE(msk->csum_enabled))
-- 
2.51.0

