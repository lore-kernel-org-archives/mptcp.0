Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B516426
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199670; cv=none; b=hy3Dxoah5nT3MvU8hQjaHZoCAnU/0apJ2gVp0hB4mqhqSIS+PzBlaaHPLLSMJbYALiUOuUqQCZGlhfVyMbxNOwaN6U+yCGydd/oFspwcYHDa7HE5bnUWdPCd8heybPW/e9DRmpQT/FG1NwCkvdYouVMsOpWh2jNJ7/3CETFKf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199670; c=relaxed/simple;
	bh=pVu8lm7WumUjuMAxT5sW8UN0V1c+2ffk6wx6aiIZbEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sI/x0E17+55apssojpjFdGvE6vg1PQR6QCTxIcjb3zV74jd59TD7VYf3cr+tfwDFaRbwR/RakUEQaSiN8Nm/lqaq6AwBleufD5hWBfl4dNprck9C8bL8jqjAMjOsCvMB9f9FeB31swfiZWy/1AugSLF1fQCfYW5K5oUS3BDqC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy6jkLO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy6jkLO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFE1C4CEE8;
	Wed,  5 Mar 2025 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199669;
	bh=pVu8lm7WumUjuMAxT5sW8UN0V1c+2ffk6wx6aiIZbEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qy6jkLO2ac3Do37QHggJAJlngVLN/gpWkPWpiAOoCWf0WR054ymlSely9PgiNL2+X
	 dRivD0QZIjxBucOAhzJJzAm4j7ijSnDSONxrG4D4XoWmkYbqhXcmgrZLwq6hczz21J
	 3ap7b1mmvT8coMkJ8uNN+C8b6mXPivNMZWfG79ZRbepC7iE6emWfQA39jJU3T3ZgAY
	 a5cZRlEa1qF96EueQnqb0KtXBFLy8neiFWLBjWeVAchK0xuugeZC4mVNQXZTiWQwWW
	 HyVOgQVzKvMbZRapkALl8pv4kM5QTO5ezHs1dUdeoHsWM7wCHnK2V/ALvyTyfgu2jd
	 fLP9/e+qK76Rw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Mar 2025 19:34:18 +0100
Subject: [PATCH mptcp-next v2 1/2] tcp: ulp: diag: always print the name if
 any
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-mptcp-tcp-ulp-diag-cap-v2-1-d53fd80748eb@kernel.org>
References: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org>
In-Reply-To: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org>
To: mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>, 
 Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2488; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pVu8lm7WumUjuMAxT5sW8UN0V1c+2ffk6wx6aiIZbEM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnyJkyNcER+PwACAi0kfkAKC+p9j/gLe/eNZEUS
 E1H4lTS8z2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8iZMgAKCRD2t4JPQmmg
 c9PQD/9brgpebO5FsrOyR3v+4tRtgCeE5huiMHwRsdLnWRA63z19vmbGK9Qhr0tHTkgKYUpc3RN
 MXLsnF9C2y6jPGiLxKFCZad0fAxLHEG17174ss1auEkOKIEAcs0bQbPj3aGm7RdD3jmGpd7aUvl
 twCuXB6VrVJs/+c0Yx2SqJGfNuLd3d0MlO7yjdWCFBrF/r+3mmg8z80BhBiujtXIZ8GhGMMZdtI
 RQt1xisnof8+Mis5qYSkRZ0ttFGvfpNrXR7cHVTN98BANSTnZwLzBtbtRzowXlehZs5MKOg8m3w
 MkhElbW2E9uKxIQ39WNvMD8ronTPyeJp5V6TgH6zHwwcAZST9IHKGLXvYR0vHsPWRlqq+gvWCRc
 BPgpkK6TkhtJ7R4bYI2+0RrR/lDjbZaRbMsLlrnG+oO2pcRSBzP6NQgZwiPbrYUHMf1OrvUG8a7
 bBnAM9T773BVeBzlu/diLJ9myf+g4XGaEpUU9e0Xkos+m+EXgzAYCXhClk1cKYLBiy6S+px27f3
 Qr8K1SAsHMAmXbKb5rPKZ8jhuGHA6VOAvWikBP93JmbS2zEoq8GgdKoDGJQ1jm+3BVu3XO37zmp
 sglOlbW3tiadXIuNXYPcQYfKIapOa+ks3ytUrPs2secksYmbAVW6LCmTBYB+Dr/tiuC3fmhrHo6
 El8kc1rEkMZUc/w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
to dump ulp-specific information"), the ULP diag info have been exported
only if the requester had CAP_NET_ADMIN.

At least the ULP name can be exported without CAP_NET_ADMIN. This will
already help identifying which layer is being used, e.g. which TCP
connections are in fact MPTCP subflow.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_diag.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index f428ecf9120f2f596e1d67db2b2a0d0d0e211905..d8bba37dbffd8c6cc7fab2328a88b6ce6ea3e9f4 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -83,7 +83,7 @@ static int tcp_diag_put_md5sig(struct sk_buff *skb,
 #endif
 
 static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
-			    const struct tcp_ulp_ops *ulp_ops)
+			    const struct tcp_ulp_ops *ulp_ops, bool net_admin)
 {
 	struct nlattr *nest;
 	int err;
@@ -96,7 +96,7 @@ static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
 	if (err)
 		goto nla_failure;
 
-	if (ulp_ops->get_info)
+	if (net_admin && ulp_ops->get_info)
 		err = ulp_ops->get_info(sk, skb);
 	if (err)
 		goto nla_failure;
@@ -113,6 +113,7 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 			    struct sk_buff *skb)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	const struct tcp_ulp_ops *ulp_ops;
 	int err = 0;
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -129,15 +130,13 @@ static int tcp_diag_get_aux(struct sock *sk, bool net_admin,
 	}
 #endif
 
-	if (net_admin) {
-		const struct tcp_ulp_ops *ulp_ops;
-
-		ulp_ops = icsk->icsk_ulp_ops;
-		if (ulp_ops)
-			err = tcp_diag_put_ulp(skb, sk, ulp_ops);
-		if (err)
+	ulp_ops = icsk->icsk_ulp_ops;
+	if (ulp_ops) {
+		err = tcp_diag_put_ulp(skb, sk, ulp_ops, net_admin);
+		if (err < 0)
 			return err;
 	}
+
 	return 0;
 }
 
@@ -164,14 +163,14 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 	}
 #endif
 
-	if (net_admin && sk_fullsock(sk)) {
+	if (sk_fullsock(sk)) {
 		const struct tcp_ulp_ops *ulp_ops;
 
 		ulp_ops = icsk->icsk_ulp_ops;
 		if (ulp_ops) {
 			size += nla_total_size(0) +
 				nla_total_size(TCP_ULP_NAME_MAX);
-			if (ulp_ops->get_info_size)
+			if (net_admin && ulp_ops->get_info_size)
 				size += ulp_ops->get_info_size(sk);
 		}
 	}

-- 
2.47.1

