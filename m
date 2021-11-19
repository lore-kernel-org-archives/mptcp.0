Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099702C87
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637332123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNIjVdNfrH1EBdflai/IJbkOIg9YwNJFT/WnhVIR6xY=;
	b=DsiyH8G09gGV1i7XBSVNeA5SyYW2gO2CGF/eEZdWmpcQCUugj9lB8tZPv2klJ7ro/3uABN
	ip1QpvqXUoy+Nimhkvv8A2asW5lYoREu5vM1GVu1eSjMqLqj43zFIIdd2sPbtm/5c91fet
	dBI2SIbwXjZcctTw+CmjfvcDy62j2v4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-JRDxYi44Of6EnXS1JfR1Sg-1; Fri, 19 Nov 2021 09:28:39 -0500
X-MC-Unique: JRDxYi44Of6EnXS1JfR1Sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 736B518125C9;
	Fri, 19 Nov 2021 14:28:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 80A2660657;
	Fri, 19 Nov 2021 14:28:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 1/2] mptcp: fix delack timer
Date: Fri, 19 Nov 2021 15:27:54 +0100
Message-Id: <3168be19fb4e9c79ff5fe1af1b0b700c39770c43.1637331462.git.pabeni@redhat.com>
In-Reply-To: <cover.1637331462.git.pabeni@redhat.com>
References: <cover.1637331462.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11

From: Eric Dumazet <edumazet@google.com>

To compute the rtx timeout schedule_3rdack_retransmission() does multiple
things in the wrong way: srtt_us is measured in usec/8 and the timeout
itself is an absolute value.

Fixes: ec3edaa7ca6ce02f ("mptcp: Add handling of outgoing MP_JOIN requests")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau>@linux.intel.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7c3420afb1a0..2e9b73eeeeb5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -434,9 +434,10 @@ static void schedule_3rdack_retransmission(struct sock *sk)
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
 	if (tp->srtt_us)
-		timeout = tp->srtt_us << 1;
+		timeout = usecs_to_jiffies(tp->srtt_us >> (3 - 1));
 	else
 		timeout = TCP_TIMEOUT_INIT;
+	timeout += jiffies;
 
 	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
 	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
-- 
2.33.1

