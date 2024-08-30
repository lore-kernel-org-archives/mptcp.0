Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A144C7C
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001941; cv=none; b=LVLMA+HAR8ATW4jOAcoMJdPgNaZmyHXDjmS54DXpAtdUDAxUxCRWE0WcLbV6lOFxbuLYI6Uq8IBRYu2jWRaTfqYVnnvQQ78xID/1PtluUCX70TtMXg5QwHy3LNaVaDHQn4HbEQNVmOv76OL+WL8b3k+4HM2uYxkUxmBts9DhsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001941; c=relaxed/simple;
	bh=hWSFWLUZjD88D6pLgQ+R4lXUSMVXlHtJujEf59wrTnA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZYc2jyiM9C4gy0TENsgwi4/krV4tdqUg40bQtyBgv1UCQvizeMDERmArTnEoqqWVFV6pV5OqQTiQRZ0753k2vwJvUqRNd0N5yvpJuuZmlzr14RnzKw1LxX8UZ3b+DmjJ3ZfvaHl1bbTx3rroMwgJChcltS00FON1gIvqUsLwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCT5PwQ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCT5PwQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2F3C4CEC2;
	Fri, 30 Aug 2024 07:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725001940;
	bh=hWSFWLUZjD88D6pLgQ+R4lXUSMVXlHtJujEf59wrTnA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OCT5PwQ9pfOBdaQKhbTMfy6BbNtZ9U9xVOLmDbgv6KX9r8lM0Q9OMHP0cMZzIPksG
	 Dd75c+gIb1dapI6Vukvs9386s1BP7ISGrV7zhq4QVg22DnOk5jq4l7qQk5a2gRqdCD
	 WMFlHkbeTRRO1oCIv+fl48xAA0xFqwZYqC9gBj1elEeJ7mOznWCw2yNiY0vbbvCFO6
	 mHmPxFYMR7PRS80Kg2j9bH3GtncQKn+LW3/Javwo43AWlWFBgbPdeeqncHaHS0HAH1
	 A9Eg9AInksEScwq5lqbOKisVRCYDkq164/BTQR05vsbIeiPqERIJ1EwWfTF1tvCFlb
	 YK4Y1IJ3euFjg==
Message-ID: <28d2d806335c2a3cc4eed5bfd386b99c0ce2051d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 1/3] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 30 Aug 2024 15:12:16 +0800
In-Reply-To: <7a04e174-a468-4e8d-9dae-013ca55066cb@kernel.org>
References: <cover.1724899785.git.tanggeliang@kylinos.cn>
	 <bd9b737530f156c6741d158300e7cb625f39dca2.1724899785.git.tanggeliang@kylinos.cn>
	 <7a04e174-a468-4e8d-9dae-013ca55066cb@kernel.org>
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

On Thu, 2024-08-29 at 16:25 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> cc: -Martin (not to annoy him with MPTCP specific stuff)
> 
> On 29/08/2024 04:53, Geliang Tang wrote:
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
> > index bc572e1d6df8..6a7cf71c2795 100644
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
> > @@ -57,3 +58,64 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
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
> > + mptcp_for_each_subflow(msk, subflow) {
> > + struct sock *ssk;
> > +
> > + ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> > +    struct mptcp_subflow_context));
> > +
> > + if (ssk->sk_mark != ++i)
> > + ctx->retval = -1;
> > + }
> > +
> > + return 1;
> > +}
> > +
> > +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk,
> > struct bpf_sockopt *ctx)
> > +{
> > + struct mptcp_subflow_context *subflow, *tmp;
> > +
> > + mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 
> Out of curiosity, why do you need the '_safe()' helper here? Just to
> check it works?
> 
> > + struct inet_connection_sock *icsk;
> > + struct sock *ssk;
> > +
> > + ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> > +    struct mptcp_subflow_context));
> > + icsk = bpf_core_cast(ssk, struct inet_connection_sock);
> > +
> > + if ((ssk->sk_mark == 1 &&
> > +      __builtin_memcmp(icsk->icsk_ca_ops->name, cc,
> > TCP_CA_NAME_MAX)) ||
> 
> In your previous version, you had a patch to set the cc on the other
> subflow, not to change the value of 'getsockopt(TCP_CONGESTION)' seen
> by
> the userspace. Why did you drop it?
> 
> > +     (ssk->sk_mark == 2 &&
> > +      __builtin_memcmp(icsk->icsk_ca_ops->name, "cubic",
> > TCP_CA_NAME_MAX)))
> 
> You cannot check this one (or at least not like that): the default
> TCP
> CC can be changed with a kernel config, it is not necessarily cubic.
> 
> I think it is fine to only check the other subflow.
> 
> > + ctx->retval = -1;
> 
> Should you not mark it as an error if the mark is different from 1 or
> 2?
> (Or maybe not, because that's covered by
> _check_getsockopt_subflow_mark)
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
> > + if (!sk || sk->protocol != IPPROTO_MPTCP)
> > + return 1;
> 
> If this test fails, the check will not be done.
> 
> > +
> > + msk = bpf_core_cast(sk, struct mptcp_sock);
> > + if (msk->pm.subflows != 1)
> > + return 1;
> 
> Same here: if there is no extra subflow, the test is silently not
> done.
> You change 'ctx->retval'.
> 
> Also, it might be good to print something somewhere everywhere you
> set
> this 'ctx->retval' to -1, to be able to easily understand what went
> wrong, no? Can we use bpf_printk() or something similar?

getsockopt() is invoked by connect_to_fd() too, and msk->pm.subflows is
0 in this case. So in v6, I moved this "msk->pm.subflows" check into
_check_getsockopt_subflow_mark/cc.

Thanks,
-Geliang

> 
> > +
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

