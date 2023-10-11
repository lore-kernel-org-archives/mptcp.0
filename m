Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE891F18A
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEe416sA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697037823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2tzKJKmmiHgpmcwwc5VDA2d6SZCk2lq2AEu1KZ7V8Ec=;
	b=UEe416sAuu85V1gsN6PyveiKMaMuvk2HJ0QPpuJ2VUk15yABspBV32n1THV2iXWL+fhvsk
	HvWSL2ATufL+FY2LQBetZOYYwfKBGXombx3IcZQsywGvxWWE09orPrBGs4Qa9pd+aWrqeG
	S73V+LSI7PYT2+uyuyQJuRcgPFVKQzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-8zfdfu8MMh2KFl_qlzmVKw-1; Wed, 11 Oct 2023 11:23:42 -0400
X-MC-Unique: 8zfdfu8MMh2KFl_qlzmVKw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59EFA86893E
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 15:23:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB9F5492B04
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 15:23:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2] tcp: check mptcp-level constraints for backlog coalescing
Date: Wed, 11 Oct 2023 17:23:13 +0200
Message-ID: <f1e771e52c4dce3db4884ac0e629d363d1676b75.1697037788.git.pabeni@redhat.com>
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

The MPTCP protocol can acquire the subflow-level socket lock and
cause the tcp backlog usage. When inserting new skbs into the
backlog, the stack will try to coalesce them.

Currently, we have no check in place to ensure that such coalescing
will respect the MPTCP-level DSS, and that may cause data stream
corruption, as reported by Christoph.

Address the issue by adding the relevant admission check for coalescing
in tcp_add_backlog().

Note the issue is not easy to reproduce, as the MPTCP protocol tries
hard to avoid acquiring the subflow-level socket lock.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/420
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - !coalesce (mat)
  - typo in commit message (mat)
---
 net/ipv4/tcp_ipv4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a441740616d7..4d66a8ab3b98 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1870,6 +1870,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    !mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
-- 
2.41.0

