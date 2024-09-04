Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EE1CCEDB
	for <mptcp@lists.linux.dev>; Wed,  4 Sep 2024 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443743; cv=none; b=ZBitP/9Tm/1S0yfd75/w0z+LdvrlM07N3Jh6EEvzaF7SwjEFKRWgrqnPHJEfNPg6ycQUNCMP99mJcJueyAfWvPSUXXYc7EXMljxjqqjXvpk6UlGu/UGgOVmlJgXhiY/xOBcUUH7l+VvWAOiKJlCBBz8HGWj6qJUANtdDSiC1Z9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443743; c=relaxed/simple;
	bh=97oAX0OMo9LyzOcoqfldPQCgBVTtyvQV4+3S9FjMyoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUKGfDODJqZciQ4t4TIvrWc6nMlEzN5Sg57fQbfy/bbuVEbKiT3FIEK5E45XpkWZVLbHnNSh/pbL1kZ2DWktJ7tTkLcb1B9dNRj0O7jpYHoEOlXZ+hCLJ1kx1xsyS7fZq/W4VKr4jrPP7X2fPVEKoAoCuGTCR5KmlklN8IVqOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJ2ZRT4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJ2ZRT4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7D1C4CEC2;
	Wed,  4 Sep 2024 09:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725443743;
	bh=97oAX0OMo9LyzOcoqfldPQCgBVTtyvQV4+3S9FjMyoY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=vJ2ZRT4faYc4sBEIi/o3x7oTXMsh5EQ1X4BFOKl+X6ixX1B49EGvxkSn7e45xCJtv
	 Uz6uiKEppdMfIfLjLKyhljFWpAb31Nw9PEUKOJgGLpjoGSpFnyoj+IJGSZuAvR/OvQ
	 SP9kTc91yO+h+1dcLRGgUgpY76ZGPgogQMLDJCkyOsjHic1V+5Ir954QdOOoCR7/Kv
	 JI9VCLEhDESM+QsEJAzy+M2vu08040TlfoTsS9R8ZhekOHGfAHDHeCgv7Iujxgjsbe
	 0Ac72DohX5iIDPX0K2GsAdd8ZLYPxzU6KbkeNTnOtxhoDhK1wWri00tQ6D5nlGu2EO
	 aC5UlPAGZnzmA==
Message-ID: <cb3a4103dd195f6d4d2b8f7823609f9a6b20a2c4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 2/4] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 04 Sep 2024 17:55:38 +0800
In-Reply-To: <b8394aac-0fc7-4c40-8125-77450737c323@kernel.org>
References: <cover.1725350462.git.tanggeliang@kylinos.cn>
	 <2cd5946354c8cf839684274e9ccc52016fbcf717.1725350462.git.tanggeliang@kylinos.cn>
	 <b32de9d6-f941-46d0-9805-ad542ef6f5d6@kernel.org>
	 <b8394aac-0fc7-4c40-8125-77450737c323@kernel.org>
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

On Tue, 2024-09-03 at 11:16 +0200, Matthieu Baerts wrote:
> On 03/09/2024 11:11, Matthieu Baerts wrote:
> > On 03/09/2024 10:04, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > This patch adds a "cgroup/getsockopt" way to inspect the subflows
> > > of a
> > > mptcp socket.
> > > 
> > > mptcp_for_each_stubflow() and other helpers related to
> > > list_dentry are
> > > added into progs/mptcp_bpf.h.
> > > 
> > > Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list
> > > and use
> > > bpf_core_cast to cast a pointer to tcp_sock for readonly. It will
> > > allow
> > > to inspect all the fields in a tcp_sock.
> > 
> > (...)
> > 
> > > diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > index 2e28f4a215b5..1053a795eb43 100644
> > > --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > > @@ -4,6 +4,7 @@
> > >  
> > >  /* vmlinux.h, bpf_helpers.h and other 'define' */
> > >  #include "bpf_tracing_net.h"
> > > +#include "mptcp_bpf.h"
> > >  
> > >  char _license[] SEC("license") = "GPL";
> > >  
> > > @@ -57,3 +58,92 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
> > >  
> > >  	return 1;
> > >  }
> > > +
> > > +static int _check_getsockopt_subflow_mark(struct bpf_sock *sk)
> > > +{
> > > +	struct mptcp_subflow_context *subflow;
> > > +	struct mptcp_sock *msk;
> > > +	int i = 0;
> > > +
> > > +	if (sk->protocol != IPPROTO_MPTCP) {
> > > +		bpf_printk("MPTCP Subflow: unexpected protocol
> > > %u", sk->protocol);
> > > +		return -1;
> > > +	}
> > 
> > Out of curiosity, why did you move this code here and in
> > _check_getsockopt_subflow_cc()?
> > 
> > I'm just surprised because recently, you tried to reduce the amount
> > of
> > duplicated code :)
> 
> While at it: it sounds better to have unique error messages, to know
> where was the error. Here, a few messages are the same, e.g.
> protocol,
> number of subflows, sk is null. Do not hesitate to add something to
> differentiate them: level & optname, a string prefix, the line
> number, etc.

No, I think we should drop all these "bpf_printk" messages. I checked
all other BPF selftests programs, no one use these error messages to
debug like this. Just "return 1" is enough:

        if (!sk || sk->protocol != IPPROTO_MPTCP)
                return 1;

If a BPF program fail, its own load log will show:

libbpf: prog '_getsockopt_subflow': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int _getsockopt_subflow(struct bpf_sockopt *ctx) @
mptcp_subflow.c:136
0: (bf) r9 = r1                       ; R1=ctx() R9_w=ctx()
; struct bpf_sock *sk = ctx->sk; @ mptcp_subflow.c:138
1: (79) r7 = *(u64 *)(r9 +0)          ; R7_w=sock() R9_w=ctx()
; if (bpf_get_current_pid_tgid() >> 32 != pid) @ mptcp_subflow.c:141
2: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()

No need to add any line number by ourselves.

> 
> Cheers,
> Matt

