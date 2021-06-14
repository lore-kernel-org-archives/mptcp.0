Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8472
	for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623691414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tt5kqQT9TToJVoI3CQHr7lD5P5G+CsAXHleAjnE7yt0=;
	b=So0utEilh1UweQNw5z7H35uUjI65Ce2OKcowaFEW33X3Nhj6P2p8jO5LmHQ5Y6qC0NQMnZ
	20PTLQuhuznPLSPIXXROo/EFNtahXVFsQjKqV1hHZcygzypVq+jqF/mtWzUrbqfP5sanzf
	LdY3QjMxaPTlopN9i35/cKHHjWmHoCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-ItHt_rEbNeu_GrhWl3D51A-1; Mon, 14 Jun 2021 13:23:32 -0400
X-MC-Unique: ItHt_rEbNeu_GrhWl3D51A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68B2891272
	for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 17:23:31 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-44.ams2.redhat.com [10.36.115.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D416C5D6DC
	for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 17:23:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix bad handling od 32 bit ack wrap-around.
Date: Mon, 14 Jun 2021 19:23:22 +0200
Message-Id: <356dce030d0adf2bf6b45888876e2c3f9f553a3a.1623691387.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

When receiving 32 bits DSS ack from the peer, the MPTCP need
to expand them to 64 bits value. The current code is buggy
WRT detectiong 32 bits ack wrap-around: usaging the 'before()'
helper is just meaningless: when the wrap-around happes the
current 32 bit ack value is lower than the previous one, need
plain direct comparison.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/204
Fixes: cc9d25669866 ("mptcp: update per unacked sequence on pkt reception")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a05270996613..7db1e219f24f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -952,7 +952,7 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
 	old_ack32 = (u32)old_ack;
 	cur_ack32 = (u32)cur_ack;
 	cur_ack = (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
-	if (unlikely(before(cur_ack32, old_ack32)))
+	if (unlikely(cur_ack32 < old_ack32))
 		return cur_ack + (1LL << 32);
 	return cur_ack;
 }
-- 
2.26.3

