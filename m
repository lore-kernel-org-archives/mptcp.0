Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254167;
	b=b34yrKPPTENaM5cwMOaCvaLtdl9896wduMHpyca4sGGSoo3z5/5/NqBh9Z/ElcBAppwP
	 jpSO7S9nMrnHAOsLe9Z9C85EgLLJ6mOSEBAA+G5Scvr00Hmn/2B7dS2cPxawQruaC6Ss0
	 0+lzMaWjAlBvFitWImskdVBu1ZJoJXLi7TBxdeDYIRyOQs9uOrv3+KZZ4X6zIJj4cKGMX
	 itlvdhtGpF9LL9+58S3dydWWc44V9pUUq1Zm0svy2RqJSscC9vcVAlK/lL2ppFCcELF7B
	 sg69saEDivOeNjVgIuIDn2blgCd1gx1KBVJ0pvnHRLpveUKb4JMPMTjlT8Gl5VK4C8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254167;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kELscjjjenegsl0ivrV1O4RHg0+yzJhDByyvQsds5yk=;
	b=Y16DEyPTX+I+QKunKw6q2mm7xrZ0+zmmTMovLazPcTHz94d4CIARE8yibn3ZecLTH5wD
	 bIrveHGsZ2Q0eQSWIyBndMKHWVJ6x7H8bspZBc3FbipCYxtuha/9Cv8DvdylIOuilrAaH
	 px0tD3cXyT5dmD/3JXcrLabVRScX8q84Q3wo0k3wc31nRB7W54cuJsYqnnFhxW4WnVON/
	 QRIQKg8eAkl+35SD7H8RQ9Jt8zftqu88PKd6QF2HXSwB4ZQnXwGdhvrcj+Z5pNSoPVbG8
	 3/55wj8QpIcb1xX23STPZmx8gNStMazhNPo1sgx+NIomwMr2v05GZaJzFUUbeKZ/cfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abdlJqyA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32696606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abdlJqyA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608C21F000D4;
	Sat, 21 Nov 2026 09:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254166;
	bh=kELscjjjenegsl0ivrV1O4RHg0+yzJhDByyvQsds5yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=abdlJqyAltEycsqWjty4TkKJLTDe10of7S3IQWzhXM8+UWy1IdwJOPcFR+2tAKalf
	 qsCLvhZSoXRJwD/AERsbOWoP+Qgy9BECsfG/oJNV4dC3E+meXCmWYM02wErZGm2GH9
	 tkUUgAWu1PMgizp8IaaO9+f7tdttu37F6Aevzh7z52u0rkA+Lul4OyPecI4RFvZ9m4
	 AtOM36f656plEE05HpbiOlmFyYDmZMUTxo6SCB0864zAFEKg68K4z/XhHUrPvp30aG
	 kM7xH5u9CClp4fftuPOP/jilUqoV8H0o5mmYwSJN5ujPHjHXrr+KIZnnAa5G1nTOmj
	 s7WBGQ3fnl7rw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:30 +0100
Subject: [PATCH mptcp-net v2 32/62] net: add __sk_net_refcnt_upgrade() with
 a GFP mask
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-32-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2VIvHnRwU8IB+vMrv4KyFTHkq8/NNiY0Q/ImiNY1neY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0+PZ93ybKWKwrfXmjVlrjpV+5lRlmyM6L7BkRX+Yy
 N8FNssYO0pYGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy4Q4jw4eiuOpNm1/P5es9
 d+yESv/nLV+/dk0t98le4xQyjb3nsT7DN/W1vPY9t+ec22pz+ZtPWe29+da6vvlTBHdcnT3tuvs
 sJgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

sk_net_refcnt_upgrade() gives a kernel socket a reference on its network
namespace, with a netns tracker allocated with GFP_KERNEL. The next
commit needs to do that for a socket created in atomic context: the
child of a kernel MPTCP listener, created when an MP_JOIN request is
accepted.

Add __sk_net_refcnt_upgrade(), taking the GFP mask to use, and make
sk_net_refcnt_upgrade() call it with GFP_KERNEL: no functional change
for the existing callers.

The 'Fixes' tag here below is the same as the one from the next commit:
this patch is needed to fix the issue introduced by this commit ID.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/sock.h | 1 +
 net/core/sock.c    | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 5a203809218a..953bd0060fae 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1869,6 +1869,7 @@ static inline bool sock_allow_reclassification(const struct sock *csk)
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		      struct proto *prot, int kern);
 void sk_free(struct sock *sk);
+void __sk_net_refcnt_upgrade(struct sock *sk, gfp_t gfp);
 void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone(const struct sock *sk, const gfp_t priority, bool lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index 6d143faeccc3..832e335d7448 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2407,7 +2407,7 @@ static void __sk_destruct(struct rcu_head *head)
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
-void sk_net_refcnt_upgrade(struct sock *sk)
+void __sk_net_refcnt_upgrade(struct sock *sk, gfp_t gfp)
 {
 	struct net *net = sock_net(sk);
 
@@ -2415,9 +2415,14 @@ void sk_net_refcnt_upgrade(struct sock *sk)
 	__netns_tracker_free(net, &sk->ns_tracker, false);
 	net_passive_dec(net);
 	sk->sk_net_refcnt = 1;
-	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+	get_net_track(net, &sk->ns_tracker, gfp);
 	sock_inuse_add(net, 1);
 }
+
+void sk_net_refcnt_upgrade(struct sock *sk)
+{
+	__sk_net_refcnt_upgrade(sk, GFP_KERNEL);
+}
 EXPORT_SYMBOL_GPL(sk_net_refcnt_upgrade);
 
 void sk_destruct(struct sock *sk)

-- 
2.55.0

