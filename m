Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5D847A
	for <mptcp@lists.linux.dev>; Wed,  1 Mar 2023 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677693399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eOGnkUKCv4DM884coeeqliV7IKS5ounQpAFL5KoPEkQ=;
	b=D0oHY7+HISMSDPuIhH5gyzzkjGr3Ar2EJstYPOIaYLi4VL3GlanrvNuPoZ9UxCI635XVqY
	8icvSHExAD5ucefexz+sgjj8WcwAs9/ck4df1GULcXTH/T/UHl4F3hL2s/Hhn4rhqFz4Vg
	Fbvox6lmNfxluMo/68EOaohvZzk+3rQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-hZgUStNGOmavnsvomiWjmg-1; Wed, 01 Mar 2023 12:56:35 -0500
X-MC-Unique: hZgUStNGOmavnsvomiWjmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F3F7877CA4;
	Wed,  1 Mar 2023 17:56:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEB7D18EC1;
	Wed,  1 Mar 2023 17:56:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net] mptcp: fix possible memory leak on syn_recv race
Date: Wed,  1 Mar 2023 18:56:26 +0100
Message-Id: <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
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

When subflow_syn_recv_sock() loses the inet hash insert race, the
newly created children will be released by inet_csk_complete_hashdance().

In that scenario, without any further hint, the ulp release callback
will keep the ulp context alive, expecting that the msk socket will
later free it.

Anyway the dying child is not linked to any msk socket, and the context
will be leaked, as reported by Christoph.

Address the issue explicitly releasing the context in the critical
scenario.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/356
Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This patch is tested only vs the self tests, I have no actual proof
it really closes 356, but it should at least avoid some real leak
---
 net/mptcp/subflow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index cda6dc4cc6a7..1ca8d30e9276 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -806,7 +806,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	child = listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						     req_unhash, own_req);
 
-	if (child && *own_req) {
+	if (likely(child && *own_req)) {
 		struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(child);
 
 		tcp_rsk(req)->drop_req = false;
@@ -898,6 +898,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req = true;
 		}
+	} else if (child) {
+		/* inet_csk_complete_hashdance() is going to drop the sock
+		 * soon, but context must be explicitly deleted or will be
+		 * leaked
+		 */
+		mptcp_subflow_drop_ctx(child);
 	}
 
 out:
-- 
2.39.2

