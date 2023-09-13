Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90A22EE0
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694639112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzEV60DkiJb5dP4VdvK6JX9+EWSJ0mn/6J6VcYY01R0=;
	b=HDdVhG28/A+am4dDnBEo8ySRcAYcqMR31I+aqnfXa9uqfJxM7unVut0r1fhkcpw1tCkxet
	JhrckF6DMSkWzv6ujvR1bRyG56m/NI8jmBUJpgraktf/7GCIVy3t77WmoJ3Rjp+JvN6bby
	v0PXg1/MGB21uy2g2AOBTB1+edBcJr4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-SqIlicJVN4qYGEmazgE2tQ-1; Wed, 13 Sep 2023 17:05:10 -0400
X-MC-Unique: SqIlicJVN4qYGEmazgE2tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 860F7800045
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13E8463F9D
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:05:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/3] mptcp: ignore notsent_lowat setting at the subflow level.
Date: Wed, 13 Sep 2023 23:05:01 +0200
Message-ID: <b87770920c83ef051788440f1eee7d52f4969efc.1694638162.git.pabeni@redhat.com>
In-Reply-To: <cover.1694638162.git.pabeni@redhat.com>
References: <cover.1694638162.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Any latency related tuning taking action at the subflow level does
not really affect the user-space, as only the main MPTCP socket is
relevant.

Anyway any limiting setting may foul the MPTCP scheduler, not being
able to fully use the subflow-level cwin, leading to very poor b/w
usage.

Enforce notsent_lowat to be a no-op on every subflow.

Note that TCP_NOTSENT_LOWAT is currently not supported, and properly
dealing with that will require more invasive changes.

Singed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/sockopt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f44b364b0055..453d6c78c25c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1450,6 +1450,12 @@ void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 
 	msk_owned_by_me(msk);
 
+	/* subflows must ignore any latency-related settings: will not affect
+	 * the user-space - only the msk is relevant - but will foul the
+	 * mptcp scheduler
+	 */
+	tcp_sk(ssk)->notsent_lowat = UINT_MAX;
+
 	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
 		sync_socket_options(msk, ssk);
 
-- 
2.41.0

