Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28117215049
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569208; cv=none; b=k7m3ZUE74EL4Kkl+SSc9urZpG8p8mRhOLrZE3YwYwDJCBo5+WOhQUowKHV3bj4H9i6Lm9B7FbKu26e9tHN0j2jmsGI1OJYKxw7oqWQOtw+0g0RLhcPOAhU/6iE0UHd1ei29l+vm2N8wjE87lDCkRnTvsFB/ijUt7enn5U0F6VGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569208; c=relaxed/simple;
	bh=sSSQ2ecWOwTPC20cMCAlgkr9sXUBB0U6QXPhnEuCWto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nsZ4nTn1PUaF5UIStQNOqwDBK+SH8nzmOYYqhRqDUqtnrbe/d5JTSKolGcYont1FYXyhSbBfiBwjeUjlNcLhCWIz3Ks1260BoU2vz2T+DYPGMPB3JxoWdXdmzHRPF5GSvXwMu1rPus2xsqaknhQtbdGGTYAzdQYEXBCX+Hoh0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6rTK5SE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6rTK5SE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2A7C4CEEB;
	Wed, 26 Feb 2025 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740569207;
	bh=sSSQ2ecWOwTPC20cMCAlgkr9sXUBB0U6QXPhnEuCWto=;
	h=From:Date:Subject:To:Cc:From;
	b=u6rTK5SEJR2SNO1XjDDocE/E+aH1WB1mt83DZLBBLpCbYQNxrZXFRPseggsJD422f
	 j8fDYMbyyi2bKEIFEMzRalGr08hQhAOYnKrTP1INM2jiwC4l3FLzD8qsKoQ7KFnphZ
	 FAzBM9PCcQEmQ7b6UFRxrmobzgFebxiwo9NxUaVqFdXYlaylgGHfSHYJhoOcM1BHP5
	 27O6RXzQfVLCXYgtMXFJTTuKBHvBTzyF4Du72uaLkOpbzHpR27OAysrmu4VD42rUhl
	 0YMQqtO6YEloljzbJHVL9y7BC/76GriWc9lFreSz8rbvrM6zccGBUaR1OBkEWwm3dj
	 E7z82cs7Xwt0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 26 Feb 2025 12:26:36 +0100
Subject: [PATCH mptcp-next] tcp: ulp: diag: remove net admin restriction
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGv6vmcC/yWMQQqDMBAAvyJ7dkFDtdiviId0s+pCG5dERRD/b
 tTDHOYws0PkIBzhk+0QeJUok09S5hnQaP3AKC45mMJUhTE1/nUmxYvlp+jEDkhW0b5c832Ta0o
 mSLEG7mW7xy08jedthu44Tr31/NF0AAAA
X-Change-ID: 20250226-mptcp-tcp-ulp-diag-cap-a4d9b7cd91ec
To: mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sSSQ2ecWOwTPC20cMCAlgkr9sXUBB0U6QXPhnEuCWto=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvvp25X8QKZJgEXLCCLtdwxQTkswtTFvXmbLEi
 gknX/zyGfeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ776dgAKCRD2t4JPQmmg
 cwISD/9IqSN+6Kg1UXguMYfJ+a10KlduQwJ3XlmP9VW+3twLgfpmlP+vbp4m4erKR2RyKqS4VCK
 kMbR56w/mLvFyEBKF088sdYsGCU0HbDsfL4/5Js708/r9HTrYOyim85gyLoqDEBBbBRIvwFizC/
 vs3yqrDDXx9RaRmGJfaXc0RS+zGem4Nreo+6PehQJVH49o7IbUPdUkM9dztyrKvD9WIeLXgAGJ5
 kWrihjwx4uJKQZ7YPF17YHBWhcLJalP+T1OQSwdkS9uTkeyv7lCk8ypaGI0Y9c9P5g8hnrU4qWo
 /5njTS/PZNgqA1wg2CJut3HssJ36U45UnHYZCHEWancSo0fPCVbgWghrmbKbgzR7f1UJu1ZWanB
 HDMGELdHaKfwvJdpDQHptFvRw9mWYTNQ990EHZ+jsp3zyji8s2ykKGZWqUMc+pA1QwaywPVpT2/
 ob6bEMm5gzIqVPVMJcR9s+cBClCJ/kkk4DpCdEKq55OWh6e+BISPPi10qTpT25YTfISJlIjbdTs
 mtqrpedB5piI7hDmY0PCshcy0JGsYqHJfzP3LD6e77xuw9wtL3tYTq4r+ZdpMW9F6OpcUCxbH9B
 f+P7r2PPQ6Tg9NLLwR5UxdpclYDGzKBFz/qwn/nPs69h+QcMv0dTEScdxncE4Dg1AU31WWc7hKo
 t0WhnYyTeZ4rkIg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
to dump ulp-specific information"), the ULP diag info have been exported
only if the requester had CAP_NET_ADMIN.

It looks like there is nothing sensitive being exported here by the
MPTCP and KTLS layers. So it seems safe to remove this restriction in
order to ease the debugging from the userspace side without requiring
additional capabilities.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/tcp_diag.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index f428ecf9120f2f596e1d67db2b2a0d0d0e211905..8257bd85e067ee862034c95745216c443113bdb0 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
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
+		err = tcp_diag_put_ulp(skb, sk, ulp_ops);
+		if (err < 0)
 			return err;
 	}
+
 	return 0;
 }
 
@@ -164,7 +163,7 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
 	}
 #endif
 
-	if (net_admin && sk_fullsock(sk)) {
+	if (sk_fullsock(sk)) {
 		const struct tcp_ulp_ops *ulp_ops;
 
 		ulp_ops = icsk->icsk_ulp_ops;

---
base-commit: 1238896935ea03f333a183a32fab666cc0c20e3b
change-id: 20250226-mptcp-tcp-ulp-diag-cap-a4d9b7cd91ec

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

