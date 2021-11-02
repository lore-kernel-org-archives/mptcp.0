Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1C2C99
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 20:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635886147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rr3Q/ANp+LjbMnLpx/zhMI1DcfYVKztRSE3NmIZ31Qo=;
	b=g9NWUff8EwPzIziUuQt2hYQtAnGBoo4kqiv52tNgs1sYnnU6lAKkV51V4O+yqf0OOLizct
	15KFvzFBCIoQFz8ZMyqPozD7r0zzuXZ9WMne7IYmQDzHJ67fudAq7FGSbqbO/Nqprd0p7x
	bgln6Td8d1/8Ahf/m51l7qtyQuSGXKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-43dQ-FSJPxCSFFpDAiYp5A-1; Tue, 02 Nov 2021 16:49:06 -0400
X-MC-Unique: 43dQ-FSJPxCSFFpDAiYp5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88F8187D541
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 20:49:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F22F960CC4
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 20:49:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 1/2] mptcp: fix delack timer
Date: Tue,  2 Nov 2021 21:48:58 +0100
Message-Id: <1429df0f9272607ebd8658d9f73e9fbad9165907.1635885975.git.pabeni@redhat.com>
In-Reply-To: <cover.1635885975.git.pabeni@redhat.com>
References: <cover.1635885975.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Eric Dumazet <edumazet@google.com>

To compute the rtx timeout schedule_3rdack_retransmission() does multiple
things in the wrong way: srtt_us is measures in usec/8 and the timeout
itself is an absolute vale.

Fixes: ec3edaa7ca6ce02f ("mptcp: Add handling of outgoing MP_JOIN requests")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
commit message typos added by me
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7c3420afb1a0..2ca077fdf10a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -434,9 +434,10 @@ static void schedule_3rdack_retransmission(struct sock *sk)
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
 	if (tp->srtt_us)
-		timeout = tp->srtt_us << 1;
+		timeout = usecs_to_jiffies(tp->srtt_us >> (3-1));
 	else
 		timeout = TCP_TIMEOUT_INIT;
+	timeout += jiffies;
 
 	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
 	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
-- 
2.26.3

