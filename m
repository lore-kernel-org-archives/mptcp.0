Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10B107A5
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:00:30 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so3321793e87.2
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688745628; x=1691337628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozaSL6NFtj3AcYIJZsMxs9Hvazt74//pXRN9PG5JK4c=;
        b=3aSOnEuaJMEKLuyEQqoQBPc04c3K3AP/10wIMSb1pMOS5wqvCpkFaIqVXwPu9w2Q1Z
         TZ6zL6rO+NG3joIiJgtZm9HFhZZ0KuXe1m44nNaFjPk5oVqfMkTbtXRLrlNq2PLYZ/rh
         XywdPsYYvJLE+9fRjfyoHc2JO73ZRoSfyqgKpRSq+wJ+6bIVBSciby41LoOM4+EaHqaK
         0/XO5OlQ7EKa/W+9Wu4mAZ9qzFA1fFLFS9bPtSzAoDHDdRuu8RYhJHSci4saz6Wiv90I
         G/pFrjZ9+x5E0d5c2g2JL6sAgFKBImUEwGrVPfxKZANkYMYKGnZOfOXEuzYACS1Ilt+G
         Di3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745628; x=1691337628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozaSL6NFtj3AcYIJZsMxs9Hvazt74//pXRN9PG5JK4c=;
        b=e/hFK/1a+pKQRQfgDgwE0uECoYtDh6QGutfqfsctY8Ywaxnd1DSfCHRkbth63TUk6D
         +0qZGCnDeM48Rs+hAe22gG1djgcbtuIMl5rQVlyF8dKpXvABQasCt2UUf2EQClVATYkM
         4fcp3SgnGMi+xKnXMy1WLWLNdxyZQQPeYSJFgG5M3EWHdzCipm+RlbbqRJCRVGTmd7wo
         N8DtXwORT0b1xHIGOmAbC21+PUI61cb4lwzcyHweRb6oad++OWX9Uz/hzREE916i0nOj
         LiPHk3Cg5Cw/zLgAiaANDE/jFP9gxb5g7U/AhxNRHaiWiKyzUz3R6UJq7muYfaaWkpDL
         9hqQ==
X-Gm-Message-State: ABy/qLbU2eodJr4iJUsCdXAp4Rek2rlm5g7H5+4vy5I6MPnHJZ8MsBk4
	WvsWhnEJquuLJQgE7MaqhFI4UCdO5CIG2HlNUYvwqg==
X-Google-Smtp-Source: APBJJlGFzlzPmkeO1EUrS3ClZsjSaqt8mQBOXhkuLVgFqwkwORgmTl2yegz0GaslCEGy3ltUTiSf3w==
X-Received: by 2002:a05:6512:2351:b0:4fb:89bb:bcc4 with SMTP id p17-20020a056512235100b004fb89bbbcc4mr5380137lfu.51.1688745628214;
        Fri, 07 Jul 2023 09:00:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fba137857esm2829186wmd.14.2023.07.07.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:00:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Jul 2023 18:00:15 +0200
Subject: [PATCH mptcp-next 5/6] mptcp: sockopt: set val in a generic way
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-mptcp-unify-sockopt-issue-353-v1-5-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7097;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=MJ9rON4VDzG9iINn5KlIwhpylNaR1a59Mt/HOZd9ajU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkqDaY+3g9vQIDMNgMjXRiIWmdW1GvOWPFNC86g
 JSWUIq7c0KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKg2mAAKCRD2t4JPQmmg
 c8TZEACnc1pfx29uIoXuLOM4Ri4r7ES7BpkZHGwkT1JRSlrPbhef3gIRuf/ZWKO5YV8EzUg0TpK
 zAmJRF0jVhsA74icYt4+Yctw6JvpqIm5JcVX57VDnhaIh64WHRAwL19ML5pKlFRXMjbLdf2Iryz
 YGnBGAfxrvzHytYOv0QkqYyf2zzxYM2KcIwzPmQTp6JQ/NOaYGoAH3n8i7R0AjF6qJf0cFCQfuv
 AoUbeaZ/hdr/yZdxuosI9uFnPnbdcyqLDU3VwV3ogspxtPoL8U73OjI/ap2tPWfZhnTaFBtLIaE
 uvGG0FT8Op4qRHX8ugxew37E4MjkgLTXRELp7D3T9kystzLNcIeH5YoMXBBjcK8+LAiNZAywvsu
 vWDyeBHkyk2XQByaZi1m9Q/1PqfhjIiFEIeJ2ebWFuRwggxTva99XhaBwFhPaKr/8RAbfJaFYQX
 Zi6hO5xY06pHesLKegHbtLOOtJQs4fW0bcLElMKmzXIDWIh4+YgJVBto7TRdAOwihMMUS+njSQ4
 PedzXwVk45mFpHHwsXQJRZbh/gR1q8Av7NXlhH2WkhASuQIj1oi6Y1dp62ydSGnfFDo9cI428s5
 ETSz0UjcWPAOP2QJKiCWfrPAoR2IHSjp2EyxKGRqiXWYZxpVy49ayuLT5T8KoQTD53e8bKUR3K2
 q74OH5nxmQDmexA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, to set socket option, we mostly deal with them case by case
by setting the right field in the socket structure and in fact, copying
what is done elsewhere in SOL_IP(V6). Supporting a new option is then
more complex and we can see some disparities on how things are done
between the different options.

Instead, we can rely on ip(v6)_setsockopt() to set the different values.
By doing that, we uniform the way we deal with the different options and
we can also go through the BPF et Netlink hooks if needed. We can also
easily support new options later.

Note that there are still two cases where we still need to deal with the
end values directly, thus with something specific case by case:

- For SOL_TCP socket options because we cannot store them in the MPTCP
  socket. Note we can also store info in the different subflows (and
  create a first one if there is no subflow) and retrieve info from
  there.

- To sync the socket options when a new subflow has been created to
  minimise the work. But maybe it is fine to call some getsockopt() /
  setsockopt(). We could also save a list of setsockopt() that have been
  done in the past and only re-do these ones. That should help with the
  maintenance of these socket options and ease the support of new ones.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/353
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 148 ++++++++++++++++++----------------------------------
 1 file changed, 50 insertions(+), 98 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f0007fa7a0a8..a17739683fdb 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -385,51 +385,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
-static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
-			       sockptr_t optval, unsigned int optlen)
-{
-	struct sock *sk = (struct sock *)msk;
-	int ret = -EOPNOTSUPP;
-	struct socket *ssock;
-
-	switch (optname) {
-	case IPV6_V6ONLY:
-	case IPV6_TRANSPARENT:
-	case IPV6_FREEBIND:
-		lock_sock(sk);
-		ssock = __mptcp_nmpc_socket(msk);
-		if (IS_ERR(ssock)) {
-			release_sock(sk);
-			return PTR_ERR(ssock);
-		}
-
-		ret = tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
-		if (ret != 0) {
-			release_sock(sk);
-			return ret;
-		}
-
-		sockopt_seq_inc(msk);
-
-		switch (optname) {
-		case IPV6_V6ONLY:
-			sk->sk_ipv6only = ssock->sk->sk_ipv6only;
-			break;
-		case IPV6_TRANSPARENT:
-			inet_sk(sk)->transparent = inet_sk(ssock->sk)->transparent;
-			break;
-		case IPV6_FREEBIND:
-			inet_sk(sk)->freebind = inet_sk(ssock->sk)->freebind;
-			break;
-		}
-
-		release_sock(sk);
-		break;
-	}
-
-	return ret;
-}
-
 static bool mptcp_supported_sockopt(int level, int optname)
 {
 	if (level == SOL_IP) {
@@ -700,94 +655,65 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int optname,
-						   sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_msk(struct mptcp_sock *msk, int level, int optname,
+				sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct inet_sock *issk;
-	struct socket *ssock;
-	int err;
 
-	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
-	if (err != 0)
-		return err;
+	/* We cannot use tcp_setsockopt() with the msk */
+	if (level == SOL_IP)
+		return ip_setsockopt(sk, level, optname, optval, optlen);
 
-	lock_sock(sk);
+	if (level == SOL_IPV6)
+		return ipv6_setsockopt(sk, level, optname, optval, optlen);
 
-	ssock = __mptcp_nmpc_socket(msk);
-	if (IS_ERR(ssock)) {
-		release_sock(sk);
-		return PTR_ERR(ssock);
-	}
+	if (level == SOL_TCP)
+		return 0;
 
-	issk = inet_sk(ssock->sk);
-
-	switch (optname) {
-	case IP_FREEBIND:
-		issk->freebind = inet_sk(sk)->freebind;
-		break;
-	case IP_TRANSPARENT:
-		issk->transparent = inet_sk(sk)->transparent;
-		break;
-	default:
-		release_sock(sk);
-		WARN_ON_ONCE(1);
-		return -EOPNOTSUPP;
-	}
-
-	sockopt_seq_inc(msk);
-	release_sock(sk);
-	return 0;
+	return -EOPNOTSUPP;
 }
 
-static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
-				       sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
+				   int optname, sockptr_t optval,
+				   unsigned int optlen)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int err, val;
+	int err;
 
-	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	err = mptcp_setsockopt_msk(msk, level, optname, optval, optlen);
 
 	if (err != 0)
 		return err;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
-	val = inet_sk(sk)->tos;
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		__ip_sock_set_tos(ssk, val);
+		tcp_setsockopt(ssk, level, optname, optval, optlen);
 	}
 	release_sock(sk);
 
 	return 0;
 }
 
-static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
-			       sockptr_t optval, unsigned int optlen)
-{
-	switch (optname) {
-	case IP_FREEBIND:
-	case IP_TRANSPARENT:
-		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
-	case IP_TOS:
-		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
-	}
-
-	return -EOPNOTSUPP;
-}
-
 static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
 					  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *sock;
+	struct sock *ssk;
 	int ret;
 
-	/* Limit to first subflow, before the connection establishment */
+	/* Limit to first subflow */
 	lock_sock(sk);
+	ssk = msk->first;
+	if (ssk) {
+		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		goto unlock;
+	}
+
 	sock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(sock)) {
 		ret = PTR_ERR(sock);
@@ -801,6 +727,32 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
+static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
+			       sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IP_FREEBIND:
+	case IP_TRANSPARENT:
+	case IP_TOS:
+		return mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
+			       sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IPV6_V6ONLY:
+	case IPV6_TRANSPARENT:
+	case IPV6_FREEBIND:
+		return mptcp_setsockopt_all_sf(msk, SOL_IPV6, optname, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {

-- 
2.40.1

