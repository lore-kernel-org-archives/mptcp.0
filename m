Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599678;
	b=JTlsGhoiTvjUS16019KFXppqMR7KYESKjTnKx7+Zffanp0K6b/BnIY+PmQZjadjgFhuf
	 1XpUmpKYaXmSmuRy64++AkXvIbvBbg/Zsf2Hgr8Dk1yuuzWSMIkF8Kd/oPiUgIBmzbteU
	 KNql91i2j0t/IgEJG57lm//XyFxo6wgcT244sNIPJWLQHDQTIpHbXDjKjwNVeMvMuVZWM
	 DUO8M0199aTOnUV2qK33cZBz84pwR65LD0OUIccXbTWAmYFzqjVnaQs4fVMKlUbIwbv1N
	 zVt0SLvdlA/pxyRcbPxO6s96+UGCtZh3hwq3333zqh88OQKhQcsMuB5VmWdp3Y6mpzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599678;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=466qZiFYSvQUeue/MADYPAUqndRBnnYaTEKY7WOpLeo=;
	b=mfTft6kKxXILvKX2Dulh4YLvAJakHtol28jF3QMZOQiO8UdSyC2Rp/cbyrnB4sR/8mTy
	 hypw7a5bHqCrBUO7pLz8GWaxo7By+xgR4X+WcDPMx43oaxQbPAvBEPbiYFb44ByXVQr+V
	 hds/LE0vSukdejEAK+U5haLGDiv3ncg7L5v6kUCl5y3PBfH8/oRgg+7U6VQswohk1W5PN
	 0tNCJH7mczp9tXZa4IfS7/ZlIQjKqa9RKr6acCKcFvO/88OTvYMb3dT4DryilC4Yi1RCz
	 +6BSMLvLPUMdflCcMpE8cVJy0/VA6x35VTiRmWPEAa800ZDneGte8fWEbRvM57H6yxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ary2ElRn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5E60A261A
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ary2ElRn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145211F000C5;
	Fri, 13 Nov 2026 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599677;
	bh=466qZiFYSvQUeue/MADYPAUqndRBnnYaTEKY7WOpLeo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ary2ElRn+/VyurMule72L+LVkd9chP4t39c+UB8DeZOcnElkdk4ov0Z0viYRQefm5
	 zMf1/WnXcJwWkdDCObyRYgJ3GvSxNoMqmXcjhCTUhrGsD0Th6ZDmn59kAT0jHc/NY/
	 oXGtpu0Qxx8C1MbuJeItpq58DUDSkSHUdEtqYRJd0veB0tNcTg3dKPBrq8Y70oSJNL
	 YmyQlegf7z+C3OoBESprG53CyikNOCdCzzg6xhEIaWlv6OIQPGS5WVCLzpN3/2ITaW
	 basAF+UYfFeBu9+91S5GKFLaXCqrj6SxwIztW9Has9MiIRvzaty3ulB7T3UcDGXI82
	 /Sn1S/JFlL5ew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:51 +0100
Subject: [PATCH mptcp-net 13/34] net: add __sk_net_refcnt_upgrade() with a
 GFP mask
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-13-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2373; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VMuDMJ+QYpChqPbElRGFQ6C9jKJt7DZnMFWfmai9U/A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z92uNd43L9mz3sOoaGfakfezJr446ZuvzyX58NBOH
 yv9zqTejlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkE6jEynPnBoyB8VyqYbcVJ
 zQ8Xduif0Lddfyto1c/df43LNmlkzGJkmPzqi9qH9WvkXdU3X69ombe5IrKkcqcyg5LfhD17ZSy
 m8gMA
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
index d58d38db732d..1f64f08a8131 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1847,6 +1847,7 @@ static inline bool sock_allow_reclassification(const struct sock *csk)
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		      struct proto *prot, int kern);
 void sk_free(struct sock *sk);
+void __sk_net_refcnt_upgrade(struct sock *sk, gfp_t gfp);
 void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone(const struct sock *sk, const gfp_t priority, bool lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index e529ffeaedb9..c9fa717d953e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2434,7 +2434,7 @@ static void __sk_destruct(struct rcu_head *head)
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
-void sk_net_refcnt_upgrade(struct sock *sk)
+void __sk_net_refcnt_upgrade(struct sock *sk, gfp_t gfp)
 {
 	struct net *net = sock_net(sk);
 
@@ -2442,9 +2442,14 @@ void sk_net_refcnt_upgrade(struct sock *sk)
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

