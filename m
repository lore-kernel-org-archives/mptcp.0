Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C612FB8
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623434263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lNMCSkvQvCmfMPN6940P/QohEDpmPzbyVYQQ2rm767o=;
	b=XkFuu0RZ3y6Hs9z1ttBOfFR+fOmC9R09EbOX71cSuGFoypBc8PQ1SGZgddkUevJHjlPXRk
	8TwSd94EtAeZOHNeggrviaoanIKLjUI3logydQpUEHBvA1FCoS/nEmLuO5XCEX9R39E/HN
	BqqV3g5NC6xWMutMWktpsjkJjICcIM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-VTeKmNyeOje3FM9D5Fo-0w-1; Fri, 11 Jun 2021 13:57:40 -0400
X-MC-Unique: VTeKmNyeOje3FM9D5Fo-0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E150E8015A4
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 17:57:39 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-91.ams2.redhat.com [10.36.115.91])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6C35D9C6;
	Fri, 11 Jun 2021 17:57:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [RFC PATCH] tcp: consistently disable header prediction for mptcp
Date: Fri, 11 Jun 2021 19:57:01 +0200
Message-Id: <982d258452274d2b165b07883307c01a44dbf7f7.1623434219.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The MPTCP receive path is hooked only into the TCP slow-path.
The DSS presence allows plain MPTCP traffic to hit that
consistently.

Since commit e1ff9e82e2ea ("net: mptcp: improve fallback to TCP"),
when and MPTCP socket falls back to TCP, we can the receive
fast path, and delay or stop triggering the event notification.

Address the issue explicitly disabling the header prediction
for MPTCP sockets.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/200
Fixes: e1ff9e82e2ea ("net: mptcp: improve fallback to TCP")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
I could not find a reliable way to disable header prediction
touching the MPTCP code only: the TCP stack can flip header
prediction on in a bunch of points and I could not find existing
MPTCP hooks after such check to revert the change.

So I opted for this TCP change, unless we are able to really
drop TCP fast path ?!? (see commit
31770e34e43d6c8dee129bfee77e56c34e61f0e5)

@Florian: WDYT?
---
 include/net/tcp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e668f1bf780d..17df9b047ee4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -686,6 +686,10 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 
 static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
 {
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
 			       ntohl(TCP_FLAG_ACK) |
 			       snd_wnd);
-- 
2.26.3

