Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6813911AB;
	Mon, 22 Jun 2026 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125060; cv=none; b=DRAZgk3poXgBVhWTFB5+q8yKDcMeMwK6QNiAyGBrFZTl/Ubd/U9dDNa30kgVQ+qx/5BJz3/6OOYPiiq8gxM2GJ11xDZgOfyUwJt/WasICAvD11PlDOBkY9v4+4oA99bj/qAFd/CznNnsOjZo8Xau4LOXxG7cEJN41AgPEVM9MOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125060; c=relaxed/simple;
	bh=Ag/hQ9rRmfp2USAAToXkC9c+6xqCdl3B8rz4gW9w9gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS7ywzmtkcwFPAZgDAs98210Ustke95n34ZIdTxUlIzNEFWy1yKLsmj7wnEG2mVS1v8S4T6jdGC2DhTbMo3Igxn4ZD0ZljyUvNLXXKClpry1MDk5YuvW0c+Q3ZXB8FDuSyaEucq6KuQ6oxZqlUwWimoBP48sXGMk/k7abBnB/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI9nDEOh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI9nDEOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020121F00A3E;
	Mon, 22 Jun 2026 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125059;
	bh=vf5shtTjZbJJ4RO3sH4LEHQNLiU1arvXN5MniILsa7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JI9nDEOhmo0Dy+sAuGHfYD5WxnFg2sROUkghwB/0+U2+QzMr0Hiu6kR7pR5pMFMXO
	 VzPFsL2LDKoSpeAbtXEQ5m9P8H/1BIwilOHfjg/qw3JvDoIjQZajHmC9J9+axcS7bK
	 6RMOAYEaMd0L8pYdqYWXS7a6dA6fLcvPWmvxtUARxXj9zHlom3VzxPn736KEqpMefp
	 WA3Ky9JWL5gBTgeRp7bVq7sFXxf9SUMOBr3T/hIelq0VIpqn6rv/5OsXDcW3mvBkkP
	 +Jbq5KiatF1d5sEG2jP5GjDW9cInnuFCtF6T4sutgxJZPFy7AEbQ5vv6NtIy8aRcZg
	 +X3jWw4R8J2TQ==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 02/17] tls: factor out __tls_build_proto for mptcp support
Date: Mon, 22 Jun 2026 18:43:22 +0800
Message-ID: <c2dd7762ac91e6e2442d424d82d74e7af241c78c.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

tls_build_proto() contains duplicated logic for building IPv4 and IPv6
TLS protocol caches.

Factor out the common code into a new helper __tls_build_proto(), which
takes the saved protocol pointer, mutex, and IP family as parameters.
This prepares for adding MPTCP support by reducing the amount of
duplicated code needed when introducing additional protocol variants.

No functional change intended.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_main.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9675c75bc50c..be824affd1b1 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -968,35 +968,37 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
 #endif
 }
 
-static void tls_build_proto(struct sock *sk)
+static void __tls_build_proto(struct sock *sk,
+			      const struct proto *saved_prot,
+			      struct mutex *prot_mutex,
+			      int family)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct proto *prot = READ_ONCE(sk->sk_prot);
 
-	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
-	if (ip_ver == TLSV6 &&
-	    unlikely(prot != smp_load_acquire(&saved_tcpv6_prot))) {
-		mutex_lock(&tcpv6_prot_mutex);
-		if (likely(prot != saved_tcpv6_prot)) {
-			build_protos(tls_prots[TLSV6], prot);
-			build_proto_ops(tls_proto_ops[TLSV6],
-					sk->sk_socket->ops);
-			smp_store_release(&saved_tcpv6_prot, prot);
+	if (ip_ver == family) {
+		/* smp_load_acquire pairs with smp_store_release below */
+		if (unlikely(prot != smp_load_acquire(&saved_prot))) {
+			mutex_lock(prot_mutex);
+			if (likely(prot != saved_prot)) {
+				build_protos(tls_prots[family], prot);
+				build_proto_ops(tls_proto_ops[family],
+						sk->sk_socket->ops);
+				/* pairs with smp_load_acquire above */
+				smp_store_release(&saved_prot, prot);
+			}
+			mutex_unlock(prot_mutex);
 		}
-		mutex_unlock(&tcpv6_prot_mutex);
 	}
+}
 
-	if (ip_ver == TLSV4 &&
-	    unlikely(prot != smp_load_acquire(&saved_tcpv4_prot))) {
-		mutex_lock(&tcpv4_prot_mutex);
-		if (likely(prot != saved_tcpv4_prot)) {
-			build_protos(tls_prots[TLSV4], prot);
-			build_proto_ops(tls_proto_ops[TLSV4],
-					sk->sk_socket->ops);
-			smp_store_release(&saved_tcpv4_prot, prot);
-		}
-		mutex_unlock(&tcpv4_prot_mutex);
-	}
+static void tls_build_proto(struct sock *sk)
+{
+	/* Build IPv6 TLS whenever the address of tcpv6 _prot changes */
+	__tls_build_proto(sk, saved_tcpv6_prot, &tcpv6_prot_mutex,
+			  TLSV6);
+	__tls_build_proto(sk, saved_tcpv4_prot, &tcpv4_prot_mutex,
+			  TLSV4);
 }
 
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
-- 
2.53.0

