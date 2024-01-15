Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392918636
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv45dW4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705343512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ymn48hAASsfFXqDPdV6S79Mz6bIxq+PovD72lSM1tEo=;
	b=Kv45dW4Zi0I2GdAeDoI61C7rOqeS4rTVVreGDGYfmpwth4rqXtFJyKtxCAtvw5HyLPKVYG
	ATEXpldjOkc7M8ddrixpSIkEtzMLlazYXUbytSFUju1H0DVhzedRx2Z0BTdNHOCpuCBntP
	NGZL2F2jcOGy3fQR5oHwkr/tb9KIOJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-cydwYcwhO8CsAgAV9Tse2w-1; Mon, 15 Jan 2024 13:31:50 -0500
X-MC-Unique: cydwYcwhO8CsAgAV9Tse2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88069881C80
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 18:31:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16D812166B31
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 18:31:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net] mptcp: relax check on MPC passive fallback
Date: Mon, 15 Jan 2024 19:31:43 +0100
Message-ID: <d97d56012abb6e277c4ffc5042ff2f414dbe7959.1705343249.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

While testing the blamed commit below, I was able to miss (!)
packetdrill failures in the fastopen test-cases.

On passive fastopen the child socket is created by incoming TCP MPC syn,
allow for both MPC_SYN and MPC_ACK header.

Fixes: 724b00c12957 ("mptcp: refine opt_mp_capable determination")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - keep it simple don't bother handling DSS OoO pkts (matttbe)
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1117d1e84274..0dcb721c89d1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -783,7 +783,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * options.
 		 */
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK))
+		if (!(mp_opt.suboptions &
+		      (OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_ACK)))
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
-- 
2.43.0

