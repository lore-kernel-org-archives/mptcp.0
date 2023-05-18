Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931123C90
	for <mptcp@lists.linux.dev>; Thu, 18 May 2023 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684429167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V4K9Ey6dTVLmr0bHqWYyL1al2kiA7jeAwB2tAlPqhg=;
	b=IBZMAx5Yz0EjJ8U/9Gjyc2VnC2lS42PRQqakF6wSh7eiS03FKSoRpkvy6ERQ+iY9J9jWSY
	JMvyTlOEqoUC5Exw0DMo6I3nox6BnX4B8XEmI7UxmW/bfG3YcPp79ry31/A7qyAQBNWYI6
	mw1mMDmAKxtXmI4nMyoXSiWOmeYXp+4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-97bh-G_cPkCa-PbWfi9cCg-1; Thu, 18 May 2023 12:59:25 -0400
X-MC-Unique: 97bh-G_cPkCa-PbWfi9cCg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73E3D3806707;
	Thu, 18 May 2023 16:59:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D7CA3492B01;
	Thu, 18 May 2023 16:59:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v2 mptcp-net 3/5] mptcp: fix data race around msk->first access
Date: Thu, 18 May 2023 18:59:12 +0200
Message-Id: <34cb8d251ae3042e904a7712f207521f351bb294.1684427027.git.pabeni@redhat.com>
In-Reply-To: <cover.1684427027.git.pabeni@redhat.com>
References: <cover.1684427027.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The first subflow socket is accessed outside the msk socket lock
by mptcp_subflow_fail(), we need to annotate each write access
with WRITE_ONCE, but a few spots still lacks it.

Fixes: 76a13b315709 ("mptcp: invoke MP_FAIL response when needed")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 38709c332367..cea9992fec98 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -90,7 +90,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	if (err)
 		return err;
 
-	msk->first = ssock->sk;
+	WRITE_ONCE(msk->first, ssock->sk);
 	WRITE_ONCE(msk->subflow, ssock);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
@@ -2446,7 +2446,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	sock_put(ssk);
 
 	if (ssk == msk->first)
-		msk->first = NULL;
+		WRITE_ONCE(msk->first, NULL);
 
 out:
 	if (ssk == msk->last_snd)
@@ -2762,7 +2762,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->rmem_released, 0);
 	msk->timer_ival = TCP_RTO_MIN;
 
-	msk->first = NULL;
+	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
-- 
2.40.1

