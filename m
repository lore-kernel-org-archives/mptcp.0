Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC83E44FB
	for <mptcp@lists.linux.dev>; Thu, 25 Jun 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391791; cv=pass; b=AOv/2B4jQ0prdtDMZO5yhBXoVUFTcdP7dOYaiA3wqYkLtXyb1iobzJCQZs3u35Bh+oSqmVnhXqdIv7+bSu54MsxLX1kz475TLg3KfeYep385lWfEKUyR20LOb8rLEACj1Gh8bfyxaO90QLyzPIVMvhWdf3cX18uS4Oc0dNsgEYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391791; c=relaxed/simple;
	bh=9NglwZQvtanSnz92I3Ib6jXIqPlvuKzNKW4mPVeADzo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YTz++wpHvQ8GjjCN7EtbMBdpVKP1xvQSTe5HjPT+/qGds/In44fUzZNGmJ/kL59WWcPKpo3woT1UKAi6iEcNpVFMhVkXqBn4dfImYYRDWpUHYrln3uJCfLVWxEUalg8kzRXF8PQBUF3weGXpxNpV7ihdZSf7ii1ufNLPozdKG+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=QTt9iv1u reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="QTt9iv1u"
ARC-Seal: i=1; a=rsa-sha256; t=1782391781; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fYqE9Qigp9BLOuBeq7iWXZj9NYE+eFTMdRzoGZZ/BeeFBP0E02/ydk1X07cVTT1+g61IY1J54CRTKO3hAecxMbzBvl6EFoMR6rjpRb85G9B2n6yRQaVKM2dHe0sKQPRbat9jRcwjYGjOKdo+tIhc3yKUk45coxm4YzZvpv1uY8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782391781; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bDa4QKmRtf7oqv6ausErkwPqFvuIQUSgw5QfWpPsXfk=; 
	b=iEwCvI8GA5L4zI//Yzp3Yt5pwjrFAJ17pY9KFHay9lG/biI0Jhny2TjEK3ey7cuN1lDYwa61anvPaAIBQTt28D1/ANSsuEQTQz630UOmlYUtEGFuKu4G+iGPj054F1VnY9UFmmIkgkCrYCxqosddeg+gjTtQvKijuCT62kqxXxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782391781;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bDa4QKmRtf7oqv6ausErkwPqFvuIQUSgw5QfWpPsXfk=;
	b=QTt9iv1u3SWF0haZYd8pQ11i3Pxp10BhCVCAES1BieBEfbHAO8CoFD/CWm/iKF4n
	NlW5etcJag6WyeVy5QD/hE7AL+7WN6gLw8jHCkXw0DRpdap4lfk118ayX21s5hbqeLs
	jIOR7L3PSMnNDA/03GXcGqu7J48KUgef0LyVExGE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1782391781017889.2889500902244; Thu, 25 Jun 2026 05:49:41 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1782391779390990.2531764751278; Thu, 25 Jun 2026 05:49:39 -0700 (PDT)
Date: Thu, 25 Jun 2026 18:19:39 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Li Xiasong" <lixiasong1@huawei.com>
Cc: "matttbe" <matttbe@kernel.org>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"shardulsb08" <shardulsb08@gmail.com>,
	"zhangchangzhong" <zhangchangzhong@huawei.com>,
	"yuehaibing" <yuehaibing@huawei.com>,
	"weiyongjun" <weiyongjun1@huawei.com>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Message-ID: <19efed4302e.c99dd85699224.5184519520303229997@mpiricsoftware.com>
In-Reply-To: <5ab3efab-1276-4268-98d0-a9f141e56f8c@huawei.com>
References: <20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com> <5ab3efab-1276-4268-98d0-a9f141e56f8c@huawei.com>
Subject: Re: [PATCH mptcp-next] mptcp: bpf: fix NULL derefs in
 bpf_mptcp_sock_from_subflow()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Li,

On Thu, 25 Jun 2026 17:10:54 +0530, Li Xiasong wrote:
> This still seems incomplete for the lockless access pattern used here.
>
> icsk_ulp_data is an __rcu pointer, but mptcp_subflow_ctx() does a plain
> forced dereference of it. Since this helper can run without the socket
> lock, this path should use rcu_dereference() or rcu_dereference_check()
> when loading the subflow context.

Agreed. I will replace the mptcp_subflow_ctx() call with:

	ctx = rcu_dereference_check(inet_csk(sk)->icsk_ulp_data,
				    lockdep_sock_is_held(sk));

This satisfies lockdep for both the locked and lockless (tracing BPF)
callers without requiring an unconditional rcu_read_lock() at the call
site.

> ctx->conn is also checked and then read again:
>
>     if (ctx && ctx->conn)
>         return mptcp_sk(ctx->conn);
>
> For a lockless access, it should be loaded once, for example with
> READ_ONCE().

Agreed. I will load it once:

	conn = READ_ONCE(ctx->conn);
	if (!conn)
		return NULL;
	return mptcp_sk(conn);

> I don't think this fully closes #622. That issue also mentions a stale
> ctx->conn / UAF case during teardown, while this patch only addresses
> the immediate NULL-deref cases.

You are right, and I should not have used Closes: for that reason. The
UAF case is real: subflow_ulp_release() calls sock_put(ctx->conn) without
clearing ctx->conn, so a BPF tracing program firing on the subflow
destruction path can observe a non-NULL ctx->conn that points to freed
memory.

I see two approaches to fix it properly:

1. Add WRITE_ONCE(ctx->conn, NULL) in subflow_ulp_release() before the
   sock_put(), so the READ_ONCE() check in this helper catches the
   teardown window. This is the minimal change but I want to confirm with
   the MPTCP maintainers that no other user of ctx->conn in the release
   path relies on it remaining set across the sock_put().

2. Wrap this helper in rcu_read_lock()/rcu_read_unlock() and ensure the
   parent mptcp_sock is freed via call_rcu rather than immediately, so a
   reader inside the critical section is guaranteed a stable object. This
   requires auditing the mptcp_sock free path which I have not done yet.

Since this patch carries a Fixes: tag against an old commit and targets
net, I think the right split is:

  - v2 of this patch: fixes the two NULL-deref cases with
    rcu_dereference_check() and READ_ONCE(), changes Closes: to Link:
    so the issue is referenced without claiming full resolution, and
    updates the commit message to explicitly note the UAF case is known
    and out of scope.

  - A follow-up patch against net-next: addresses the UAF/lifetime
    issue once the correct approach is agreed with maintainers.

Does that split seem reasonable? I am happy to discuss the preferred
approach for the teardown case before sending v2.

Thanks for the careful review.

Cheers,
Kalpan Jani


From: Li Xiasong <lixiasong1@huawei.com>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, <shardulsb08@gmail.com>, "zhangchangzhong"<zhangchangzhong@huawei.com>, "yuehaibing"<yuehaibing@huawei.com>, "weiyongjun (A)"<weiyongjun1@huawei.com>, "mptcp@lists.linux.dev"<mptcp@lists.linux.dev>
Date: Thu, 25 Jun 2026 17:10:54 +0530
Subject: Re: [PATCH mptcp-next] mptcp: bpf: fix NULL derefs in bpf_mptcp_sock_from_subflow()

 > Hi Kalpan,
 > 
 > I noticed this patch has been on the list for a while, so I took a look
 > and have a couple of comments.
 > 
 > On 6/12/2026 3:26 PM, Kalpan Jani wrote:
 > > bpf_mptcp_sock_from_subflow() is reachable from tracing BPF programs via
 > > bpf_skc_to_mptcp_sock() on an arbitrary socket, without the socket lock
 > > held. It assumes sk_is_mptcp(sk) implies a valid subflow context whose
 > > ->conn points to a parent mptcp_sock. That invariant does not hold in
 > > two lifecycle windows:
 > > 
 > 
 > This helper can indeed be called without holding the subflow socket lock.
 > 
 > > - Fallback: subflow_ulp_fallback() clears icsk_ulp_data before clearing
 > >   tcp_sk(sk)->is_mptcp, so a concurrent reader can observe is_mptcp == 1
 > >   with a NULL context, dereferencing NULL via mptcp_subflow_ctx(sk)->conn.
 > > 
 > > - Init: subflow_ulp_init() sets is_mptcp = 1 while ctx->conn is still
 > >   NULL. As mptcp_sk() is a container_of() on a non-zero offset member,
 > >   mptcp_sk(NULL) yields a non-NULL bogus pointer that passes the verifier
 > >   NULL check (RET_PTR_TO_BTF_ID_OR_NULL); on CONFIG_DEBUG_NET the
 > >   mptcp_sk() WARN_ON dereferences it directly.
 > > 
 > 
 > These two NULL cases look real to me.
 > 
 > > Load the context once and reject a NULL context or NULL ->conn before
 > > casting.
 > > 
 > > Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
 > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622
 > 
 > I don't think this fully closes #622.  That issue also mentions a stale
 > ctx->conn / UAF case during teardown, while this patch only addresses the
 > immediate NULL-deref cases.
 > 
 > > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > > ---
 > >  net/mptcp/bpf.c | 9 +++++++--
 > >  1 file changed, 7 insertions(+), 2 deletions(-)
 > > 
 > > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
 > > index 08bb037f0951..f40905fbe7d4 100644
 > > --- a/net/mptcp/bpf.c
 > > +++ b/net/mptcp/bpf.c
 > > @@ -193,8 +193,13 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 > >  
 > >  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 > >  {
 > > -    if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
 > > -        return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 > > +    struct mptcp_subflow_context *ctx;
 > > +
 > > +    if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk)) {
 > > +        ctx = mptcp_subflow_ctx(sk);
 > > +        if (ctx && ctx->conn)
 > > +            return mptcp_sk(ctx->conn);
 > > +    }
 > >  
 > >      return NULL;
 > >  }
 > 
 > This still seems incomplete for the lockless access pattern used here.
 > 
 > icsk_ulp_data is an __rcu pointer, but mptcp_subflow_ctx() does a plain
 > forced dereference of it.  Since this helper can run without the socket
 > lock, this path should use rcu_dereference() or rcu_dereference_check()
 > when loading the subflow context.
 > 
 > ctx->conn is also checked and then read again:
 > 
 >     if (ctx && ctx->conn)
 >         return mptcp_sk(ctx->conn);
 > 
 > For a lockless access, it should be loaded once, for example with
 > READ_ONCE(). However, READ_ONCE(ctx->conn) would only avoid the double
 > load / NULL case. It would not provide a lifetime guarantee for the
 > returned parent mptcp_sock.
 > 
 > During teardown, subflow_ulp_release() drops the subflow-owned reference
 > to the parent mptcp socket with sock_put(sk), and ctx->conn is not
 > cleared.  I am not sure under what conditions the subflow context could
 > still be observable by BPF after that point, since this is called from
 > the subflow socket destruction path.  It would be helpful to clarify
 > whether such a window can actually be reached, and if so, what protects
 > the returned parent mptcp_sock.  If the window is real, clearing
 > ctx->conn before sock_put() and ensuring the parent mptcp_sock is
 > RCU-safe (or not returning it without an extra reference) might be
 > needed.
 > 
 > So the added NULL checks look like a useful improvement for the immediate
 > NULL-deref cases, but I am not sure they fully cover the lockless access
 > and lifetime aspects of this helper.  It would be good to clarify the
 > expected lifetime guarantee for the returned parent mptcp_sock, or extend
 > the fix so that this helper cannot return a parent socket whose
 > subflow-owned reference may already have been dropped.
 > 
 > Thanks,
 > Li Xiasong
 > 
 > 
 > 


