Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAC366811
	for <mptcp@lists.linux.dev>; Fri,  6 Mar 2026 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778219; cv=none; b=XtNlf3truBZpuRWgBOHnT+SzeNH3UZhVcXszfGVhHaMyj9taGtLqMt2xIHE+fcjxsB/KOF1L5L01QWq/BV4fOhz8zTXBsoVQXClDyDebfu8TXuIGD50i7mYpWyj+HJCrlrsYarAg/UtFQRN0QANBE43RsGPDQ27biDOGC/gS994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778219; c=relaxed/simple;
	bh=hN1aS5W93Hg7N0jbakiyjndLVWU/uJ28dBnpZkAdovM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Di4aeZ9myvGmPI4L3E3CYdNhEI53/KCMOHmQwTpTV+0FVdkq1BwfRFFbUCDhSsxq0ISI+YPclM0x9au8BaSDqpEbwqTuO0zl98ueBHFVj2v/bwYlkaUj+Y8vKVywHFzep3pAVT8VsC8UcKP4j7f4teeNnvB/QQ1qgvJxMRKtTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mp3v2Y+B; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mp3v2Y+B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772778215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iX5jIRkk8IJ8nr3b5a7E1T+diBiy+u8oKQGYKXloZd4=;
	b=Mp3v2Y+BAbxAmtWrJPS6eeSnwxJDEnAvW74IMxVNIkQyfcnqJmuckLRkEa/JiuJ/Ip8qmh
	2I3cZktjsPfkP832KLtUHjq7UXAmhr4FhX/vVogawY06JnYNzk56WPs/7xT+L6W9FaG+NS
	QYDqUjMzsc2PW/897C7n7h4WyauaJm4=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [RESEND PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
Date: Fri,  6 Mar 2026 14:23:16 +0800
Message-ID: <20260306062316.1333680-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

After an MPTCP connection is established, the sk_sndbuf of client's msk
can be updated through 'subflow_finish_connect'. However, the newly
accepted msk on the server side has a small sk_sndbuf than
msk->first->sk_sndbuf:

'''
MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first->sndbuf:2626560
'''

This means that when the server immediately sends MSG_DONTWAIT data to
the client after the connection is established, it is more likely to
encounter EAGAIN.

This patch synchronizes the sk_sndbuf by triggering its update during accept.

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/602
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---

Notes:
    Hi Paolo, Matt,
    
    Sorry for the late response for this patch. I've been analyzing this
    issue recently, and the basic picture is as follows:
    
    The root cause is a timing gap between msk creation and TCP sndbuf
    auto-tuning on the server side:
    
    1. When the server receives the SYN, mptcp_sk_clone_init() creates the
       msk and calls __mptcp_propagate_sndbuf(). At this point, the TCP
       subflow is still in SYN_RCVD state, so its sk_sndbuf has only the
       initial value (tcp_wmem[1], typically ~16KB).
    
    2. When the 3-way handshake completes (ACK received), the TCP stack
       calls tcp_init_buffer_space() -> tcp_sndbuf_expand(), which grows
       the subflow's sk_sndbuf based on MSS, congestion window, etc.
       (potentially up to tcp_wmem[2], ~4MB).
    
    3. However, this auto-tuning happens deep in the TCP stack without
       any callback to MPTCP, so msk->sk_sndbuf is never updated to
       reflect the new subflow sndbuf value.
    
    4. When accept() returns, msk->sk_sndbuf still holds the small initial
       value, while msk->first->sk_sndbuf has been auto-tuned to a much
       larger value.
    
    In contrast, the active (client) side doesn't have this issue because
    subflow_finish_connect() calls mptcp_propagate_state() after the TCP
    sndbuf auto-tuning has already occurred, ensuring proper synchronization.
    
    Thanks
    Gang

 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5676b37f8f4..17e43aff4459 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4232,6 +4232,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
 
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
-- 
2.43.0

