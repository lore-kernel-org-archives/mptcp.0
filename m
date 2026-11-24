Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526773;
	b=Ab9+8kBnnrh47WbrqJLuEwOYu0UoqWTVNI0tepZwAWWoTKF/sx9bdzdgDiCppIWZw9MB
	 0YNAFLsuGY19oqDmL6Ti5ML7ljfITj3XXhqT1Ju9wxGffHeAm8V1VwCWjYkWRf75CL3Pw
	 15Dh+4tNINPKohxz6laI/Kif1n0powjfDCfvXHED8CUPcsSRTGus0da5Jg1gvgrUDWqpl
	 YxonpvSxcfHnThhui+ZnkboOU+i24mYrWANXyGAclujsK+m9BFNDPDrLD8/hgnC9qqu3E
	 zxrYexvjFq0OBZFwSU2Tv7kabDXL5l+mnpcHO/9crhLVmY5HiyA8/4zinQVdxcXzwhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kz0t8oBESZodiEmssbz2bY2o3ZLD3qqhLqHDIQsZIsY=;
	b=dnKnn+XchsirnDqt1hCvA+zMmTcQxwPZaZ934mvchOEdQ568wVYOMW9qswwvdgWczoFY
	 h6uHl2QA8SldGL5AMzgAQd67lHrZGSLs+tyB7NKGjrsZ8NtdfsB3OTlJ+RUZgjUbXB4eH
	 c4o5hrULmbobgibSHDUNqgXSJRHnydLPs8ErTrFEXhMWc8TBQ9b6EjZ67vJGSRirs1eT7
	 1SZC2DsHmeYlj44kdz3067LPSgbREnrSNru4on6FE0I3ZHZva2HKnM+FaN7s8ITKDg7TJ
	 Hz7fSX+8VaBelrtCDWmGp9/6e9cRrUm/67VUMMNM5nOt75sHEtqhf7StjmrYwR5iRDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6Dyew3P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C4606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6Dyew3P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A521F000CA;
	Tue, 24 Nov 2026 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526773;
	bh=Kz0t8oBESZodiEmssbz2bY2o3ZLD3qqhLqHDIQsZIsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6Dyew3P0ixNZi6m5kFjVaZgMjpV9wd7puvGlqxiA0cq8+1B7/AbYQ8srx6dtDksM
	 dOLwqvqemj6wkTnI8bM6PDvQ19Q6MniXS+0VLQLTcIgrjvDB7oDAcVwByKnl6vbd0Y
	 w7AH1XHmtW6y1LUnZ2o6fS6a0GvLpUKEevPsl+zMc5lBRn3Lv7jThN4cs7rNZ+WXHM
	 NOmBvq1Jhi0KTt6YSVLdy8EizwCZbSIP8GT4skT6IjXG3cRv6oUvC5F/nc0W//+zTt
	 WOYHYI1511LSNzRC+4YODs1rSY/BBOwqLLaNMjKoKNE4c1yIBwoVD4fVHZcZKHSDVD
	 wDW8x3vPsvvyQ==
Message-ID: <sashiko-outbox-231206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 08/10] mptcp: pm: don't let listeners pin their
 netns
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
References: <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org>
 <20261123-net-mptcp-misc-fixes-7-4-rc5-v1-8-278042217e8d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:26:12 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] mptcp: netns leak in subflow_syn_recv_sock() on non-MP_JOIN
  syncookie ACK
--

commit 6179aee66fd5371bdb738c5d1e0414c3ccde4437
Author: Josef Bacik <josef@toxicpanda.com>

mptcp: pm: don't let listeners pin their netns

This commit skips upgrading the network namespace reference count on
subflows created for kernel MPTCP sockets, and instead takes a network
namespace reference in subflow_syn_recv_sock() when cloning a child
socket from a kernel listener.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 20d5062350742..3e674c21bdb2a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -844,6 +844,22 @@ void __mptcp_subflow_fully_established(struct mptcp_=
sock *msk,
>  	WRITE_ONCE(msk->fully_established, true);
>  }
> =20
> +/* Children of a kernel listener need a netns ref for their timers */
> +static bool subflow_child_get_net(struct sock *child)
> +{
> +	struct net *net =3D sock_net(child);
> +
> +	if (likely(child->sk_net_refcnt))
> +		return true;
> +
> +	if (!maybe_get_net(net))
> +		return false;
> +
> +	__sk_net_refcnt_upgrade(child, GFP_ATOMIC);
> +	put_net(net);
> +	return true;
> +}
> +
>  static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>  					  struct sk_buff *skb,
>  					  struct request_sock *req,
> @@ -912,6 +928,11 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> =20
>  		tcp_rsk(req)->drop_req =3D false;
> =20
> +		if (!subflow_child_get_net(child)) {
> +			subflow_add_reset_reason(skb, MPTCP_RST_EUNSPEC);
> +			goto dispose_child;
> +		}
> +
>  		/* we need to fallback on ctx allocation failure and on pre-reqs
>  		 * checking above. In the latter scenario we additionally need
>  		 * to reset the context to non MPTCP status.

[Severity: High]
Can this still leak the network namespace when SYN cookies are active on
an in-kernel PM listener?

subflow_check_req() rejects non-MP_JOIN SYNs when listener->pm_listener is
true, and for an MP_JOIN SYN under SYN cookies tcp_conn_request() sends a
SYN+ACK with a valid TCP syncookie and frees the request_sock.  If the
peer replies with a third ACK carrying that syncookie but omitting
OPTION_MPTCP_MPJ_ACK (for example, a plain TCP ACK or one carrying
OPTION_MPTCP_MPC_ACK), cookie_tcp_reqsk_init() calls
mptcp_subflow_init_cookie_req(), which does not check
listener->pm_listener and returns 0 with subflow_req->mp_join =3D=3D 0.

When tcp_get_cookie_sock() then calls subflow_syn_recv_sock(),
fallback_is_fatal is false because subflow_req->mp_join is 0.
subflow_child_get_net(child) upgrades child->sk_net_refcnt to 1 before
the fallback and ctx->mp_join checks, and subflow_syn_recv_sock() returns
child with tcp_rsk(req)->drop_req =3D=3D false (via goto fallback for a pla=
in
TCP ACK, or via ctx->mp_capable after cloning listener->conn).
tcp_get_cookie_sock() then queues child into the PM listener's
icsk_accept_queue, where nothing ever accepts it, pinning the network
namespace indefinitely.

Checking listener->pm_listener in mptcp_subflow_init_cookie_req() (or
rejecting non-MP_JOIN children of a PM listener before upgrading
child->sk_net_refcnt) would prevent queueing unaccepted children with a
netns reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-net-mptcp-=
misc-fixes-7-4-rc5-v1-0-278042217e8d@kernel.org?part=3D8
