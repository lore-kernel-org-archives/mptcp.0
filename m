Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9232C81
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635302524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=q8a6W9h5WD71UvBu3ruegFb2ddtPSbP0W5iIL1R7vWQ=;
	b=XJQ3tI2KmDD/PeHdt2vY3y3JcqhThOIHxvhvnVSW+/iFZ/UD3u6ePqlsHJKR5Nerw4l4KD
	ysclZSqu5o/kY/EpXXgQkkASzGJIWd0OJ6GG86fpvjyoJEsB+MuieRFiGa8/T3UjkvIM5l
	8Hn+zt/Lvi3h2C2HesaGaW2HCgQoqRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-1ioKBptUOYe79jPQ33KhqQ-1; Tue, 26 Oct 2021 22:42:03 -0400
X-MC-Unique: 1ioKBptUOYe79jPQ33KhqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 679D110A8E02;
	Wed, 27 Oct 2021 02:42:02 +0000 (UTC)
Received: from nst.lab.eng.brq.redhat.com (nst.lab.eng.brq.redhat.com [10.37.153.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F7365F4EE;
	Wed, 27 Oct 2021 02:42:01 +0000 (UTC)
From: Poorva Sonparote <psonparo@redhat.com>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Subject: [PATCH mptcp-next v3 1/2] Exposing __ip_sock_set_tos() in ip.h
Date: Wed, 27 Oct 2021 02:41:46 +0000
Message-Id: <5d4f5b701e2cfe730d3249260f3eac82784fdd0f.1635300034.git.psonparo@redhat.com>
In-Reply-To: <cover.1635300034.git.psonparo@redhat.com>
References: <cover.1635300034.git.psonparo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=psonparo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Making the static function __ip_sock_set_tos() from net/ipv4/ip_sockglue.c
accessible by declaring it in include/net/ip.h
The reason for doing this is to use this function to set IP_TOS value in
mptcp_setsockopt() without the lock.

Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
---
 include/net/ip.h       | 1 +
 net/ipv4/ip_sockglue.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index cf229a531194..3d65a3be10e7 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -789,5 +789,6 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
 void ip_sock_set_pktinfo(struct sock *sk);
 void ip_sock_set_recverr(struct sock *sk);
 void ip_sock_set_tos(struct sock *sk, int val);
+void  __ip_sock_set_tos(struct sock *sk, int val);
 
 #endif	/* _IP_H */
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b297bb28556e..7fd83f14daae 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -576,7 +576,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 	return err;
 }
 
-static void __ip_sock_set_tos(struct sock *sk, int val)
+void __ip_sock_set_tos(struct sock *sk, int val)
 {
 	if (sk->sk_type == SOCK_STREAM) {
 		val &= ~INET_ECN_MASK;
-- 
2.18.2

