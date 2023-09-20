Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A311723
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaVRwZY7k2vrZEjvk3yycUV0nUmLiyID2QaFE75+Qag=;
	b=Inhz0TLH5laKM78BAFhlf/TyjPmDg4LFV1BW81HHxvxY84PGBUfO0OrHcDR1obBZkCQ2lx
	4pS04l7fz6r4yyzrjZnsiCu3A0vJZQNO4wzs28mKHUKKSn/ZRLkj2fqw69KnEl7qgR7z1N
	w66N12uKUdwpl8W06Muz420PPs4cguA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-W-cIAZWMNBeRFh64AbvGiA-1; Wed, 20 Sep 2023 08:45:42 -0400
X-MC-Unique: W-cIAZWMNBeRFh64AbvGiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C15FA800969
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F1431004145
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/4] mptcp: properly account fastopen data
Date: Wed, 20 Sep 2023 14:45:34 +0200
Message-ID: <5e4a1ba3dedb8466fe33004f0fffdead2d3f5b18.1695208066.git.pabeni@redhat.com>
In-Reply-To: <cover.1695208066.git.pabeni@redhat.com>
References: <cover.1695208066.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently the socket level counter aggregating the received data
does not take in account the data received via fastopen.

Address the issue updating the counter as required.

Fixes: 38967f424b5b ("mptcp: track some aggregate data counters")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index bceaab8dd8e4..74698582a285 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -52,6 +52,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 
 	mptcp_set_owner_r(skb, sk);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	mptcp_sk(sk)->bytes_received += skb->len;
 
 	sk->sk_data_ready(sk);
 
-- 
2.41.0

