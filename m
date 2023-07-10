Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AE111A9
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poKr2f2/qEoyTf7d74omHVhbHOtl16PWzdzTg3K1zWw=;
	b=gfNoDq1AOQZvXK8cFNOjytVuF8RcZd/8bihABNNIgabb8B6yQyOIIVpHCClTpN6ziKWEEe
	2yP/59PrWumKy3mbV9ay7BJis2DhVqLKdFLMSTA4by5rwWFANBEtE9a4wWsxUHRPPTy4dG
	qTKby1qVVzZ0QA7UBh+2Qyd3K3Vhc04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-g3wRlHsVOrKltzV0v0d1hg-1; Mon, 10 Jul 2023 08:55:31 -0400
X-MC-Unique: g3wRlHsVOrKltzV0v0d1hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E70ED104458C
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 76ED2C09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 11/14] mptcp: avoid additional indirection in sockopt
Date: Mon, 10 Jul 2023 14:55:06 +0200
Message-ID: <cec8a8b248f869c6b38ddfe58ba7ad8145a5536f.1688993569.git.pabeni@redhat.com>
In-Reply-To: <cover.1688993569.git.pabeni@redhat.com>
References: <cover.1688993569.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp sockopt infrastructure unneedly uses the first subflow
socket struct in a few spots. We are going to remove such field
soon, so use directly the first subflow sock instead.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/sockopt.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 63f7a09335c5..348475dcbc23 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -293,6 +293,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *ssock;
+	struct sock *ssk;
 	int ret;
 
 	switch (optname) {
@@ -307,16 +308,17 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 			return PTR_ERR(ssock);
 		}
 
-		ret = sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
+		ssk = msk->first;
+		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
 		if (ret == 0) {
 			if (optname == SO_REUSEPORT)
-				sk->sk_reuseport = ssock->sk->sk_reuseport;
+				sk->sk_reuseport = ssk->sk_reuseport;
 			else if (optname == SO_REUSEADDR)
-				sk->sk_reuse = ssock->sk->sk_reuse;
+				sk->sk_reuse = ssk->sk_reuse;
 			else if (optname == SO_BINDTODEVICE)
-				sk->sk_bound_dev_if = ssock->sk->sk_bound_dev_if;
+				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 			else if (optname == SO_BINDTOIFINDEX)
-				sk->sk_bound_dev_if = ssock->sk->sk_bound_dev_if;
+				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 		}
 		release_sock(sk);
 		return ret;
@@ -391,6 +393,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	struct sock *sk = (struct sock *)msk;
 	int ret = -EOPNOTSUPP;
 	struct socket *ssock;
+	struct sock *ssk;
 
 	switch (optname) {
 	case IPV6_V6ONLY:
@@ -403,7 +406,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			return PTR_ERR(ssock);
 		}
 
-		ret = tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
+		ssk = msk->first;
+		ret = tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
 		if (ret != 0) {
 			release_sock(sk);
 			return ret;
@@ -413,13 +417,13 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 
 		switch (optname) {
 		case IPV6_V6ONLY:
-			sk->sk_ipv6only = ssock->sk->sk_ipv6only;
+			sk->sk_ipv6only = ssk->sk_ipv6only;
 			break;
 		case IPV6_TRANSPARENT:
-			inet_sk(sk)->transparent = inet_sk(ssock->sk)->transparent;
+			inet_sk(sk)->transparent = inet_sk(ssk)->transparent;
 			break;
 		case IPV6_FREEBIND:
-			inet_sk(sk)->freebind = inet_sk(ssock->sk)->freebind;
+			inet_sk(sk)->freebind = inet_sk(ssk)->freebind;
 			break;
 		}
 
@@ -700,7 +704,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 		return PTR_ERR(ssock);
 	}
 
-	issk = inet_sk(ssock->sk);
+	issk = inet_sk(msk->first);
 
 	switch (optname) {
 	case IP_FREEBIND:
@@ -865,8 +869,8 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *ssock;
-	int ret;
 	struct sock *ssk;
+	int ret;
 
 	lock_sock(sk);
 	ssk = msk->first;
@@ -881,7 +885,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 		goto out;
 	}
 
-	ret = tcp_getsockopt(ssock->sk, level, optname, optval, optlen);
+	ret = tcp_getsockopt(ssk, level, optname, optval, optlen);
 
 out:
 	release_sock(sk);
-- 
2.41.0

