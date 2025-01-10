Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A4212F84
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527438; cv=none; b=nvfLY4eyTZZUkgSUE0jtOqjN7v9o4dy8rfh17pU9c4BX9GSqBcupjh7ajgSBI83HHm41hh+P5ieRFcrL8TLo0h3Oa8ZjtQb73x2n41TIx5v0l8mh2+s8cRuqgWYO466O8k6enuJk0DV+VsWuNOAeskcDkTqcjPWhUiRSah8ljPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527438; c=relaxed/simple;
	bh=H/y6Hh//Q3vTvzcCWKV3VqZFJu0R2gsESuHhldAu1dg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=h6pVoblWv1pIvenmWN7qncXy+ghU/CQ7A7lkzGUd/HQl28+fZZff55mz4QF7tRCYYmefx6S0hBr+wj74hzsJ9PzBKdJy6g5BvcW1eJAWvBkWkH93quCc4cSRSt193UvZUGgiGnE3MZZsYUBc0dkJw8tODN4wlOPqrDaO4Md52bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWffWFnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWffWFnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736527435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnIArNNgScXhlnjKjtgnldUDoG+9nvhLpKF15zSsgRM=;
	b=EWffWFnR8Ae+VgRRveGrASJG+eEO5FM8RXI3DtRI/dN72vYf/U/sMQNTQWdDi/XIxsmqCJ
	3yfjBVdsnZdCao+UzaB414EKhV5bQX2T9+kozHp4h6IN+5fddXr2XmNdec6GT8k0qI5B8k
	xjW+VXuuGnRC3CPnLOvuOIefq/Nuh+0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-f1kMG64LP02szDtnwkmK3A-1; Fri,
 10 Jan 2025 11:43:54 -0500
X-MC-Unique: f1kMG64LP02szDtnwkmK3A-1
X-Mimecast-MFC-AGG-ID: f1kMG64LP02szDtnwkmK3A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 600E719560A3
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.199])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E4AF19560AD
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/3] mptcp: fix spurious wake-up on under memory pressure.
Date: Fri, 10 Jan 2025 17:43:42 +0100
Message-ID: <c079dbf2285713c5c56f1568467eb9d03f08ec90.1736527092.git.pabeni@redhat.com>
In-Reply-To: <cover.1736527092.git.pabeni@redhat.com>
References: <cover.1736527092.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zZrZii87mUXPgcNamDZEb_dPaHNgYetOOMhB5zxW1Ks_1736527433
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The wake-up condition currently implemented by mptcp_epollin_ready()
is wrong, as it could mark the MPTCP socket as readable even when
no data are present and the system is under memory pressure.

Explicitly check for some data being available in the receive queue.

Fixes: 5684ab1a0eff ("mptcp: give rcvlowat some love")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a93e661ef5c4..73526f1d768f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -760,10 +760,15 @@ static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 
 static inline bool mptcp_epollin_ready(const struct sock *sk)
 {
+	u64 data_avail = mptcp_data_avail(mptcp_sk(sk));
+
+	if (!data_avail)
+		return false;
+
 	/* mptcp doesn't have to deal with small skbs in the receive queue,
-	 * at it can always coalesce them
+	 * as it can always coalesce them
 	 */
-	return (mptcp_data_avail(mptcp_sk(sk)) >= sk->sk_rcvlowat) ||
+	return (data_avail >= sk->sk_rcvlowat) ||
 	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
 		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
 	       READ_ONCE(tcp_memory_pressure);
-- 
2.47.1

