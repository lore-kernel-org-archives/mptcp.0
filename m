Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98218A944
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979173; cv=none; b=lQ/zhr7BnM5V1NRrqUaTg0L5vFDv+D1j9vz0rsiaoRrWUWyO8yewnrRiXFwWS/a5H2aw+v+rmIGiWfZUsSxdhV2cPadxIcfnM99/sBs6pFG0dErJnhVugWkO0KHaPA5lKPgruXocTtbTh5O9ArCMD2Zdm3oYq+EjvPHC9+03x1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979173; c=relaxed/simple;
	bh=LFfmL+xwCjN9xVMmbFOxEsG03D4UsLGc95+t3iKpzJQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIlKhWFLQJSDFFH8EUNVgEXQkmfbvCk3odiZO4chi6GWgy7N117ReLRifYAP3WgwQ4mn1LxVHaWOrB5x025YawlYVZ9zDUjr6XNSCB5DWW0TpRw96DR64DZdoKiubegslKqEO4kCdbhpZizs9JUdd2Cs5NJQlgcAlubiYcVXufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0G3cDYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0G3cDYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57FBC4CECD;
	Tue, 15 Oct 2024 07:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728979173;
	bh=LFfmL+xwCjN9xVMmbFOxEsG03D4UsLGc95+t3iKpzJQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=B0G3cDYfLZWJW/Mf2MRtdkHc1oXP/CiZoPArliG873F07N+nTdwGi6atDXCrpwkom
	 drtW3aaD0GJRf7kGYNZw0XY+V+8TY9l07VCcXlCOQ+UDHXol2T+2pM3KZeJMqOaK5A
	 YNDXLErM4zgY7AjY9goEDQKukANKU11/InKrjX7PcTJ/mJodu4eeRXsTbv+m4Cat3H
	 naVpD1D4YoVhKNpwsQ3J60gHNXKMDpJgy3Eis+h1iXHCN9vuuexTJR7FLMQnmy/Nos
	 K9WWAv6i8aT+rgueblnhogTZDUM1JpBnexgs/xDQ4PuKSSf7P9IlBOCXfjqkzTpAe3
	 b87ZJbn2bRrIg==
Message-ID: <c1b0c2e2a421c8fcfd5b29542ffabc60651c08f1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v9 4/7] selftests/bpf: Add mptcp_subflow
 bpf_iter test prog
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 15 Oct 2024 15:59:29 +0800
In-Reply-To: <22b299af-150b-450c-b2c8-6710cf321c2d@kernel.org>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
	 <dffa6284797ec2e3e8c8a1f6891f012bd1efdc20.1728466623.git.tanggeliang@kylinos.cn>
	 <22b299af-150b-450c-b2c8-6710cf321c2d@kernel.org>
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

On Mon, 2024-10-14 at 18:06 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/10/2024 11:45, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds a ftrace hook for mptcp_sched_get_send() to test
> > the newly
> > added mptcp_subflow bpf_iter. This test simulates a typical mptcp
> > packet
> > scheduler, which selects a subflow from multiple subflows of an
> > mptcp
> > socket to send data.
> > 
> > Export mptcp_subflow helpers
> > bpf_iter_mptcp_subflow_new/_next/_destroy,
> > bpf_mptcp_sock_acquire/_release and other helpers into
> > bpf_experimental.h.
> > 
> > Use _acquire() to acquire the msk, then use
> > bpf_for_each(mptcp_subflow) to
> > walk the subflow list of this msk. Invoke kfuncs
> > mptcp_subflow_active() and
> > bpf_mptcp_subflow_tcp_sock() in the loop to pick a subsocket.
> > Finally use
> > bpf_mptcp_subflow_ctx() to get the subflow context of this
> > subsocket and
> > use mptcp_subflow_set_scheduled() to set it as being scheduled.
> 
> Do you think we could have a test not depending on scheduler helpers?
> Without this dependence, we could already upstream this series, and
> get
> feedback without having to wait for the new scheduler API.

This set can be upstream as is, no need to wait for the new scheduler
API.

If no scheduler helpers are used in this test, no need to add this
mptcp_subflow bpf_iter at all. mptcp_for_each_subflow() helper in
progs/mptcp_bpf.h can do that.

mptcp_for_each_subflow(msk, subflow) {
	subflow = bpf_core_cast(subflow, struct
mptcp_subflow_context);
	subflows += subflow->subflow_id;
}

No need to use this:

bpf_for_each(mptcp_subflow, subflow, msk)
	subflows += subflow->subflow_id;

> 
> If you remove the use of mptcp_subflow_active() and
> mptcp_subflow_set_scheduled(), that's enough, no?

But "subflow" in mptcp_for_each_subflow() loop can't be passed to a
kernel function:

mptcp_for_each_subflow(msk, subflow) {
	subflow = bpf_core_cast(subflow, struct
mptcp_subflow_context);
	mptcp_subflow_active(subflows);
}

This is not allowed by BPF.

So we add this iter to do this:

bpf_for_each(mptcp_subflow, subflow, msk)
	kfunc(subflow);

In this test, I must pick some kfuncs accepted "subflow" argument to do
this test, so mptcp_subflow_active and mptcp_subflow_set_scheduled are
picked.

Also, This iter is for the BPF packet scheduler, why not test the
actual usage of scheduler helpers in this test?

> 
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../testing/selftests/bpf/bpf_experimental.h  |  7 ++++
> >  tools/testing/selftests/bpf/progs/mptcp_bpf.h |  9 ++++
> >  .../bpf/progs/mptcp_bpf_iters_subflow.c       | 42
> > +++++++++++++++++++
> >  3 files changed, 58 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> > b/tools/testing/selftests/bpf/bpf_experimental.h
> > index b0668f29f7b3..d43690b17468 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -575,6 +575,13 @@ extern int bpf_iter_css_new(struct
> > bpf_iter_css *it,
> >  extern struct cgroup_subsys_state *bpf_iter_css_next(struct
> > bpf_iter_css *it) __weak __ksym;
> >  extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak
> > __ksym;
> >  
> > +struct bpf_iter_mptcp_subflow;
> > +extern int bpf_iter_mptcp_subflow_new(struct
> > bpf_iter_mptcp_subflow *it,
> > +				      struct mptcp_sock *msk)
> > __weak __ksym;
> > +extern struct mptcp_subflow_context *
> > +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> > __weak __ksym;
> > +extern void bpf_iter_mptcp_subflow_destroy(struct
> > bpf_iter_mptcp_subflow *it) __weak __ksym;
> > +
> >  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned
> > int flags) __weak __ksym;
> >  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
> > __weak __ksym;
> >  extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > index c3800f986ae1..e18796361394 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > @@ -43,9 +43,18 @@ mptcp_subflow_tcp_sock(const struct
> > mptcp_subflow_context *subflow)
> >  }
> >  
> >  /* ksym */
> > +extern bool mptcp_subflow_active(struct mptcp_subflow_context
> > *subflow) __ksym;
> >  extern void mptcp_subflow_set_scheduled(struct
> > mptcp_subflow_context *subflow,
> >  					bool scheduled) __ksym;
> >  
> > +extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock
> > *msk) __ksym;
> > +extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
> > +
> > +extern struct mptcp_subflow_context *
> > +bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
> > +extern struct sock *
> > +bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context
> > *subflow) __ksym;
> > +
> >  extern struct mptcp_subflow_context *
> >  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data,
> > unsigned int pos) __ksym;
> >  
> > diff --git
> > a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
> > new file mode 100644
> > index 000000000000..4268e4604c5a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters_subflow.c
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024, Kylin Software */
> > +
> > +/* vmlinux.h, bpf_helpers.h and other 'define' */
> > +#include "bpf_tracing_net.h"
> > +#include "mptcp_bpf.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +int subflows;
> > +int pid;
> > +
> > +SEC("fentry/mptcp_sched_get_send")
> 
> If I understand correctly, this hook will be called twice on the
> client
> connection for this test because the client is sending two times one
> byte, right?

Yes, in the first call, the subflows are not been added yet, so it is
called twice. I will add this check to skip the first call:

       if (msk->pm.server_side || !msk->pm.subflows)
               return 0;

> 
> > +int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
> > +{
> > +	struct mptcp_subflow_context *subflow;
> > +	struct sock *ssk = NULL;
> > +
> > +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> > +		return 0;
> > +
> > +	msk = bpf_mptcp_sock_acquire(msk);
> > +	if (!msk)
> > +		return 0;
> > +	bpf_for_each(mptcp_subflow, subflow, msk) {
> > +		if (subflow->token != msk->token)
> > +			break;
> 
> Out of curiosity, why is this needed? Is it needed for the verifier?
> Or
> just an extra check?
> Can you add a comment here explaining why this is there please?

I'll drop it.

> 
> > +
> > +		if (!mptcp_subflow_active(subflow))
> > +			continue;
> > +
> > +		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
> 
> Do you get 'ssk' just to use bpf_mptcp_subflow_tcp_sock() and
> bpf_mptcp_subflow_ctx()?

Yes, almost every BPF scheduler use these helpers, so test them here.

> 
> > +	}
> > +	bpf_mptcp_sock_release(msk);
> > +
> > +	if (!ssk)
> > +		return 0;
> > +	subflow = bpf_mptcp_subflow_ctx(ssk);
> > +	mptcp_subflow_set_scheduled(subflow, true);
> > +	subflows = subflow->subflow_id;
> 
> Here, it looks like you only check if the last subflow is in the
> list.
> 
> Would it not be better to count the number of subflows in the list?
> Or
> if you want to read something from 'subflow', you could add all
> subflow_id?
> 
>   subflows = 0;
> 
>   (...)
> 
>   bpf_for_each(mptcp_subflow, subflow, msk)
>       subflows += subflow->subflow_id;
> 
> By doing that, we will catch if one is missing, and the order is not
> important.

Yes, "subflows += subflow->subflow_id" is much better.

> 
> If still want to use bpf_mptcp_subflow_tcp_sock() and
> bpf_mptcp_subflow_ctx(), maybe you can save other fields from the
> last
> subflow: the token to compare it with the one in the msk? Or the port
> number or the address?

Sorry, I don't fully understand your last paragraph. But I stored the
dport number in the code below. Is it the same as what you thought? If
so, I'll send a squash-to patch for it.

int pid;
int ids;

SEC("fentry/mptcp_sched_get_send")
int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk)
{
        struct mptcp_subflow_context *subflow;
        struct sock *sk = (struct sock *)msk;
        struct sock *ssk = NULL;
        int subflows = 0;
        __be16 dport;

        if (bpf_get_current_pid_tgid() >> 32 != pid)
                return 0;

        if (msk->pm.server_side || !msk->pm.subflows)
                return 0;

        msk = bpf_mptcp_sock_acquire(msk);
        if (!msk)
                return 0;
        bpf_for_each(mptcp_subflow, subflow, msk) {
                if (!mptcp_subflow_active(subflow))
                        continue;

                subflows += subflow->subflow_id;
                ssk = bpf_mptcp_subflow_tcp_sock(subflow);
                dport = ssk->sk_dport;
        }

        if (!ssk)
                goto out;
        subflow = bpf_mptcp_subflow_ctx(ssk);
        if (dport != ssk->sk_dport || dport != sk->sk_dport)
                goto out;
        mptcp_subflow_set_scheduled(subflow, true);
        ids = subflows;

out:
        bpf_mptcp_sock_release(msk);
        return 0;
}

Thanks,
-Geliang

> 
> > +
> > +	return 0;
> > +}
> 
> Cheers,
> Matt

