Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C018B1C
	for <mptcp@lists.linux.dev>; Wed,  4 Oct 2023 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696439878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s2y1GNw6P5NtqevT6czfiJgPXEfqRVrjEapfxfXOu1k=;
	b=LYBhR7gDcm7iSMnH2IDmK7uYL8l8bydV+QsvRtIdn16zgxXRdCmE/Mhi5UPCNJgsl1UnCU
	i8iBv9nzE8YpJj8XhC36xOUc2MQfQfUFdTVIdUbbCTOFs04x3Oq9kd+sUOYvHeUJBsdnZK
	VLitHXKVa1FLh0IVervCSTKWU4TKnd4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-g_uYpp_2NuuQZADAkGBX_w-1; Wed, 04 Oct 2023 13:17:56 -0400
X-MC-Unique: g_uYpp_2NuuQZADAkGBX_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086F428EA6FA
	for <mptcp@lists.linux.dev>; Wed,  4 Oct 2023 17:17:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8EDDC1006B70
	for <mptcp@lists.linux.dev>; Wed,  4 Oct 2023 17:17:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] tcp: check mptcp-level constraints for backlog calescing
Date: Wed,  4 Oct 2023 19:17:51 +0200
Message-ID: <b41dd0ae28701666ba2c59170acedaafdb41726c.1696439853.git.pabeni@redhat.com>
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

The MPTCP protocol can acquire the subflow-level socket lock, and
cause the tcp backlog usage. When inserting new skb into the
backlog, the stack will try to coalesce them.

Currently we have no check in place to ensure that such coalescing
will respect the MPTCP-level DSS, and that may cause data stream
corruption as reported by Christoph.

Address the issue adding the relevant admission check for coalescing
in tcp_add_backlog().

Note the issue is not easy to reproduce, as the MPTCP protocol tries
hard to avoid acquiring the subflow-level socket lock.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/420
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/tcp_ipv4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f13eb7e23d03..52b6a0b22086 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1869,6 +1869,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;
-- 
2.41.0

