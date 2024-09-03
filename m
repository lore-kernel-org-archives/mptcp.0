Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9759200137
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350422; cv=none; b=SlE+xhyWCNnXIia7+FS4YS0dPmZdiQ2A06zLd9ADt7lewu/N3dlyHK+JVBEIiWlt6a0LFx0fptefUGfTTWv7cAUORSzLGDTRRKCjpGtsJ7w91mVxqIQKq5y0teXHu2YHDbB9QEmlx/W6f5fftwUVocw7yqWY2XBxbHgPj3OmRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350422; c=relaxed/simple;
	bh=hu51Ht4/uTU6lqSupiDdW3z1WDvS/yTTDSSTqNm/07Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IyXqY8dLgJKLVVhhsSPkLVUYoavtISNWIHaG6pKPO1uZjXcUCUt2CjZN4igglKXzWaVS5BNRW9rT8DCCm+VgWfvwwroIr5OT93zUXKTTA/NOUFgCP4hwgHDoqJ5hm6tIMy/gO6ugVqRNwICkC5RAo5zHmKG0ymJGyO1nK1m/7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPyVF9SN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPyVF9SN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BDFC4CEC6;
	Tue,  3 Sep 2024 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350422;
	bh=hu51Ht4/uTU6lqSupiDdW3z1WDvS/yTTDSSTqNm/07Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FPyVF9SN7kJIP9qpJUBdSR45auvAmx8XVnkUaX56+n5nACxsBHOyQEgJRWR5Y4+yH
	 3bzxh2z1buO+oApnoOMzBykEU6XrEF3NBcF9gt0iQYpdLMjF+x4uVinOV/oPAGziFY
	 QEYAr5YplCzVnOyH3b2dBGstjnvfehCCsQI5n7R5SbmQQi+cYf1YlcdRliibv8l0Tp
	 ca6eFW1/nOd4v656QWbIJRcZ3MAqxOkNuVcFqHGwL7+vv+erAbugp7pA7WDo+/tABa
	 ZwkjEXdZ8YYtNXKRbw2YQCdHyZZAdTmEp1BxfbvyPM61fIRig0pW08RZT4P1dxALFT
	 yl7un0c8W6HKA==
Message-ID: <80605ef1b8687bbf4925577014781ef128ea5112.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 2/4] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 03 Sep 2024 16:00:18 +0800
In-Reply-To: <6d54b731-b8a5-4d2c-8569-82ae84fb4b75@kernel.org>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
	 <0ce049060df256e7376516e4d94af71264a69da0.1725000687.git.tanggeliang@kylinos.cn>
	 <6d54b731-b8a5-4d2c-8569-82ae84fb4b75@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2024-09-02 at 18:47 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the new version. I still have one opened question about
> what is printed in case of error: do we have enough info to debug
> issues? Please see below.
> 
> On 30/08/2024 08:55, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds a "cgroup/getsockopt" way to inspect the subflows
> > of a
> > mptcp socket.
> > 
> > mptcp_for_each_stubflow() and other helpers related to list_dentry
> > are
> > added into progs/mptcp_bpf.h.
> > 
> > Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list
> > and use
> > bpf_core_cast to cast a pointer to tcp_sock for readonly. It will
> > allow
> > to inspect all the fields in a tcp_sock.
> 
> (...)
> 
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > index 2e28f4a215b5..18396532f016 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > @@ -4,6 +4,7 @@
> >  
> >  /* vmlinux.h, bpf_helpers.h and other 'define' */
> >  #include "bpf_tracing_net.h"
> > +#include "mptcp_bpf.h"
> >  
> >  char _license[] SEC("license") = "GPL";
> >  
> > @@ -57,3 +58,71 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
> >  
> >   return 1;
> >  }
> > +
> > +static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk,
> > struct bpf_sockopt *ctx)
> > +{
> > + struct mptcp_subflow_context *subflow;
> > + int i = 0;
> > +
> > + if (msk->pm.subflows != 1) {
> > + bpf_printk("subflows=%u", msk->pm.subflows);
> 
> I think the message should be a bit longer, e.g.
> 
>   "MPTCP Subflow: expected 1 extra subflows, got %u"
> 
> It looks like you didn't reply to my question from v5: if there is an
> issue with the verifications that are done in BPF, are these
> bpf_printk
> printed somewhere? e.g. if you force it to fail here, do you see the
> new
> message in the logs of the BPF selftests?

Yes, bpf_printk works. These logs are found in
/sys/kernel/debug/tracing/trace if force it to fail here:

      test_progs-75858   [003] ...11  2338.270065: bpf_trace_printk:
MPTCP Subflow: expected 1 extra subflows, got 1

> 
> If the test is unstable, we need to have a way understand where is
> the
> issue exactly, not somewhere where we set 'ctx->retval = -1'. The
> best
> would be to have a comprehensive message like what I'm suggesting
> here.
> If not, we should at least have a unique retval or errno somehow.
> 
> > + ctx->retval = -1;
> > + }
> > +
> > + mptcp_for_each_subflow(msk, subflow) {
> > + struct sock *ssk;
> > +
> > + ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> > +    struct mptcp_subflow_context));
> > +
> > + if (ssk->sk_mark != ++i)
> > + ctx->retval = -1;
> 
> Please add an error message here, e.g.
> 
>   MPTCP Subflow: expected %d mark, got %d
> 
> > + }
> > +
> > + return 1;
> 
> (no need to change if you prefer, but your helper is always returning
> -1, maybe it doesn't need to return anything?)

Set the return value to ctx->retval in v7:

ctx->retval = _check_getsockopt_subflow_mark()

> 
> > +}
> > +
> > +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk,
> > struct bpf_sockopt *ctx)
> > +{
> > + struct mptcp_subflow_context *subflow;
> > +
> > + if (msk->pm.subflows != 1) {
> > + bpf_printk("subflows=%u", msk->pm.subflows);
> 
> Same here.
> 
> > + ctx->retval = -1;
> > + }
> > +
> > + mptcp_for_each_subflow(msk, subflow) {
> > + struct inet_connection_sock *icsk;
> > + struct sock *ssk;
> > +
> > + ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> > +    struct mptcp_subflow_context));
> > + icsk = bpf_core_cast(ssk, struct inet_connection_sock);
> > +
> > + if (ssk->sk_mark == 2 &&
> > +     __builtin_memcmp(icsk->icsk_ca_ops->name, cc,
> > TCP_CA_NAME_MAX))
> > + ctx->retval = -1;
> 
> Same here.
> 
> > + }
> > +
> > + return 1;
> > +}
> > +
> > +SEC("cgroup/getsockopt")
> > +int _getsockopt_subflow(struct bpf_sockopt *ctx)
> > +{
> > + struct bpf_sock *sk = ctx->sk;
> > + struct mptcp_sock *msk;
> > +
> > + if (!sk || sk->protocol != IPPROTO_MPTCP) {
> > + ctx->retval = -1;
> 
> Same here.
> 
> > + return 1;
> > + }
> > +
> > + msk = bpf_core_cast(sk, struct mptcp_sock);
> 
> Just to be sure: this cast can never fail, and no need to check if
> 'msk'
> is NULL, right?

Yes, no need to check if msk is NULL.

Thanks,
-Geliang

> 
> > + if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
> > + return _check_getsockopt_subflow_mark(msk, ctx);
> > + if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
> > + return _check_getsockopt_subflow_cc(msk, ctx);
> > +
> > + return 1;
> > +}
> 
> Cheers,
> Matt

