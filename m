Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38034040F
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210114; cv=none; b=QYcoBTQc2ZSJFyakaIeYWcoExaBfzb+c+iut7WivOwM3VsUt40KLnwGpR5JzjhJciBfc7tOcXBJ3/uldziqPcHqHn/dGAweTqmr6AaIME/TjQ/+Jgnm5vrOkVGpPqrK2erawDl9d3gysil82abNn2rOlWx/Seu2uRlmYPlF76eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210114; c=relaxed/simple;
	bh=AhQyW2yrDd7+Ro+y4tNxqHjpUxnVJl37rTzaC17lcic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pmLu7r+TK1+p6b6FlDktcU7mnZcWrFP0A9mt0CX13qvbz8a9xhkQ4/9WFUUnq6UbK0hKdXDpj5zr5JQZbgQQkyE6CGGyahVI11m81maKq3pMkhXnoaUTOZ6HIVUYFweUQueb7DurDCJWe8Ks1YtT7Zr//A29rnuvit82/Kvbg/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH+OmP/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH+OmP/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779210112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4DOF1c46C/r7O3CnWLWVV79RegeLFnzYT9iVFoYJe0=;
	b=ZH+OmP/2F0lfMj0UZpkHFXPXI9Lth9JTpUZls8oJPfFSDEv5/x2mYC3NEfg5RAilnwX002
	nuw7EgnyD6ezP/zhY1/yXt0LW1APPI3h+dWgffRag/szqyH4pikfLmagxvERgpTMvCGmNT
	7iQJAsoNXiR2sPUYS/oahT58GSE+Ozs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-J60y1PfCPA67-2ktye3WrQ-1; Tue,
 19 May 2026 13:01:50 -0400
X-MC-Unique: J60y1PfCPA67-2ktye3WrQ-1
X-Mimecast-MFC-AGG-ID: J60y1PfCPA67-2ktye3WrQ_1779210109
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AAD7180061A;
	Tue, 19 May 2026 17:01:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85943180075B;
	Tue, 19 May 2026 17:01:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v7 mptcp-next 1/7] mptcp: fix missing wakeups in edge scenarios
Date: Tue, 19 May 2026 19:01:35 +0200
Message-ID: <a8674727a7a9cb80d6840c9ca11950caec74ff31.1779210016.git.pabeni@redhat.com>
In-Reply-To: <cover.1779210016.git.pabeni@redhat.com>
References: <cover.1779210016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8IV3B9OAuGrwh-5DdjT67cxwRtHqGv8g_c-WKXq_HnA_1779210109
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v6 -> v7
  - use mptcp_epollin_ready()

Notes:
 - sashiko may raise concerns about thundering herd problems. If
   application uses multiple threads to read on the same socket, that
   could/will happen. Application should not use multiple threads
   to read from the same socket if they want good performances.
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ce8372fb3c6a..f14572fb1975 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2276,6 +2276,8 @@ static bool mptcp_move_skbs(struct sock *sk)
 		mptcp_backlog_spooled(sk, moved, &skbs);
 	}
 	mptcp_data_unlock(sk);
+	if (enqueued && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
 	return enqueued;
 }
 
-- 
2.54.0

