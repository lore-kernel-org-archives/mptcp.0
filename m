Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42E3CBE95;
	Sun,  6 Sep 2026 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788699754; cv=none; b=GKxP30AJGV1GG2lfEBmCPh/Zl2e35V8NWp1dZ7iu/t8ZUoT8uaEx0H/pQoPu27RlN0utGoXp7ieoAWMKyJl9T3NzAL6IHDAgVe8e87HEREcioAT+mPK+LVerEP4LPFqPevpurVNlglfDFF9no0O2mAzmTZPth8xPAd414KB0S5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788699754; c=relaxed/simple;
	bh=RoZSynXINsnY4kcykrIm1F6JHkKpqmpgiU1qINcyFoY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCAkB8Cn6U3byvLK1ugk7z1ZemF+IfM4WnCAbZLHbuXPdSScRSzSy7PA/UsmJJ0CtMTlb7G58gm/TljIamjRee9Es4wB5fVpb+MSzVkH4wUsW1gC5Sh4xvu72DO/1rsCtZj0UPictA8mqVnYs3aou4aTy3mXAC8TkITTis2/KkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+C1UbYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+C1UbYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5FB1F00A3D;
	Sun,  6 Sep 2026 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788699752;
	bh=0cIr20SgyYsmowM+F5dpGSzOf6uJvJVZfeS0li5MJ+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J+C1UbYdKZOmL3/xYkjrNfIamNNtWJN+BpMTvmHBplqlYOmee3NCejPO6DU/4cEo8
	 noos7MdhI+peAB4JRPUlUxGGiBLjxhBQFkEBd42Iu4+PtJ2RpRVRkD/OhXKxj0ixQU
	 Rfb0A1ferniDTw+snH2wJvKrnYRqOmxo0YmnUGjEd3oQplXq+USm+5ZAGkf/fv3Cdn
	 L7Kttq43ig7dYf8wxcR3kgUI7z/UzZgI4JyyiKE3DYro6o0gFUbbYTTWAjZoKjd7wT
	 CNBSAEzURPVh6atzUQyC1m8rmki9VJ+KBi/SuwsldCaeRoyILVFetuE50E9ILxgckf
	 cM00SOSfPHyYw==
Subject: Re: [PATCH net v5 2/2] mptcp: fix MP_CAPABLE token migration when
 cloning reqsk
From: netdev-bot+sashiko@kernel.org
To: weir@nebusec.ai
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com,
 kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai,
 caoruide123@gmail.com, sashiko-bot@kernel.org
Date: Sun, 06 Sep 2026 13:02:30 +0000
Message-ID: <178869975079.219967.3467671214711709218@kernel.org>
In-Reply-To: =?utf-8?q?=3C93dafd2c918b42d635b03e7d3d83f6f2cff49697=2E1788202?=
 =?utf-8?q?924=2Egit=2Ecaoruide123=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C93dafd2c918b42d635b03e7d3d83f6f2cff49697=2E17882029?=
 =?utf-8?q?24=2Egit=2Ecaoruide123=40gmail=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The new non-OOM failure path in mptcp_sk_clone_init()
  (net/mptcp/protocol.c:3780-3786) downgrades an already negotiated…

--

mptcp: fix MP_CAPABLE token migration when cloning reqsk

This moves MP_CAPABLE token ownership from an original request socket to
its inet_reqsk_clone() copy under the token bucket lock, and makes
mptcp_token_accept() and mptcp_token_destroy_request() re-check
token_node under that lock instead of warning.  mptcp_token_accept() now
returns a bool, and mptcp_sk_clone_init() destroys the provisional msk
and returns NULL when the token cannot be claimed.

Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e1f08f71cdb16..30067f2a7ca8f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3764,6 +3777,14 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
>  	mptcp_rcv_space_init(msk, ssk);
>  	msk->rcvq_space.time = mptcp_stamp();
>  
> +	if (!mptcp_token_accept(subflow_req, msk)) {
> +		list_del_init(&subflow->node);
> +		WRITE_ONCE(msk->first, NULL);
> +		sock_put(ssk);
> +		mptcp_sk_clone_destroy(nsk);
> +		return NULL;
> +	}
> +

[Severity: Medium]
Is this new failure path completely silent from a user's point of view?

In subflow_syn_recv_sock() the NULL return is turned into a fallback:

net/mptcp/subflow.c:subflow_syn_recv_sock() {
	...
	if (ctx->mp_capable) {
		ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
		if (!ctx->conn)
			goto fallback;
	...
}

but the fallback label only bumps a counter when the local fallback bool
is set:

net/mptcp/subflow.c:subflow_syn_recv_sock() {
	...
fallback:
	if (fallback)
		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
	mptcp_subflow_drop_ctx(child);
	return child;
}

Reaching the ctx->mp_capable block requires having already passed:

	if (!ctx || fallback) {
		...
		goto fallback;
	}

so on the token_accept failure path fallback is false and nothing is
counted.  Every sibling failure site in the same function increments
something (MPTCP_MIB_MPJOINACKNOCTX, MPTCP_MIB_MPJOINACKNOMPJOIN,
MPTCP_MIB_JOINACKMAC, MPTCP_MIB_JOINREJECTED).

At the same time the two WARN_ON_ONCE() calls that used to fire for
exactly this state are dropped in this patch, in mptcp_token_accept():

-	/* pedantic lookup check for the moved token */
 	pos = __token_lookup_req(bucket, req->token);
-	if (!WARN_ON_ONCE(pos != req))
-		hlist_nulls_del_init_rcu(&req->token_node);

and in mptcp_token_destroy_request():

 	pos = __token_lookup_req(bucket, subflow_req->token);
-	if (!WARN_ON_ONCE(pos != subflow_req)) {
+	if (pos == subflow_req) {

The changelog describes this as trading "an exceptionally rare fallback
for eliminating the warning", but with no dmesg output and no MPTcpExt
counter, is there any way left to observe that a negotiated passive
MP_CAPABLE connection was downgraded to plain TCP, either in the field
or from the mptcp selftests?

Would it make sense to increment MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK
(exported as MPCapableFallbackACK, documented in mib.h as "Server-side
fallback during 3-way handshake"), or MPTCP_MIB_TOKENFALLBACKINIT, on
this path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788202924.git.caoruide123%40gmail.com
