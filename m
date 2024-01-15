Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E117586
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hym5l0V0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G9IyLlNQvTDl0/1tAqXyWhNRvbg24OTYwtFLu9ZpWr8=;
	b=Hym5l0V0hzsjl+G/zmkPraLVI6+vWdg7/fbUYk3+RWmjnJYYd+xQahHE2gI9920d5h83w8
	nkCaQUtKfVV7u3n5mIijcimLW12FMNgcuSGJGteO8/YB3+pgzCWSE66v1ZlCDKa9spFVai
	r86J+AL+1MeF7xM5k3jk4PAoUJekKdQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-lcC9BWVJN1iK3lztLpF1xg-1; Mon,
 15 Jan 2024 09:56:16 -0500
X-MC-Unique: lcC9BWVJN1iK3lztLpF1xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C3681C04B61
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 14:56:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEBDD1C05E1A
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 14:56:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: relax check on MPC passive fallback
Date: Mon, 15 Jan 2024 15:56:11 +0100
Message-ID: <4d9707b72d37cec9b4b6725bfcf3ae03010e0d51.1705330501.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

While testing the blamed commit below, I was able to miss noticing(!)
packetdrill failures in the fastopen test-cases.

On passive fastopen the child socket is created by incoming TCP MPC syn,
allow for both MPC_SYN and MPC_ACK header.

While at it, additionally allow for real OoO packets, as the RFC
mandates.

Fixes: 724b00c12957 ("mptcp: refine opt_mp_capable determination")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1117d1e84274..90984b053adc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -783,7 +783,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * options.
 		 */
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK))
+		if (!(mp_opt.suboptions &
+		      (OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_ACK | OPTION_MPTCP_DSS)))
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
-- 
2.43.0

