Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959314B08E
	for <mptcp@lists.linux.dev>; Fri, 23 May 2025 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985328; cv=none; b=Q4RwP4X1UfSHJqUssgYAhix/5/wWNCjJ14UzsTNKsBsYJLgtXnHgCY+KR1hXPQ633kKdLKaGHs3jeW4e3dyVlB6YZ/PUB4B2QkykyZuhMGpU7uI70hi4fpB3svonVJC2lDEDzgzjGwh3t1pZiP6rJQOdGm700yNNCpAHF849nVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985328; c=relaxed/simple;
	bh=yLya/lQubvZMuauhQ/McHt//gnLYzllztWWZFDEqPms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKUx4QaZ+QzxW5p6Y3yiqjGSRrj1VktWgBk7K+R5c8LN59kO3wn/84ad/wXVUN/9BGJmpnrkEOXFYa780h2Uo4Gz/QV7ZKwxcrhMAQVFSR7dc0HAjfIoYnIlVy8+bKt/lDyR0UKPso814zEeT3FnWAZxIv2Mm9z/VoxDe+5wjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsJA6hwv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsJA6hwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E39C4CEE9;
	Fri, 23 May 2025 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747985328;
	bh=yLya/lQubvZMuauhQ/McHt//gnLYzllztWWZFDEqPms=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jsJA6hwvGm/dS0SqJcyfmhlDtpKtH9pAfyn8zi2KlF4sUKw8/yrtUEcWLNe9P0W6+
	 2bfdpuTXJ5TFHI62aJ7SqQDKCnGaQXbM2V3ODqCBsrz0qkAKIxYEznl5x3V8laj9XV
	 J2SpW1VkL5WBGcr5bH5o7RYYsN6VaWt4VNlMMX4OuhMRqwN5csV70rZhn+HQK8oN5W
	 jXHfIcQWjcEmolxN1AQXx5g4SjCAAb+tJ067V2jqK2W3/8t0TyFfTf+cGigtHMOSo1
	 hn1Y8SPdgkhKyy9QtM/iMHko7aIjQf/ehrmRg0VUFrbIpOwDqGJRxY2mKfzOja9H+o
	 UFsZ8JU5hnzrA==
Message-ID: <43d25991691a6e31e86086c3e91e9331b10e1844.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/2] Squash to "bpf: Export mptcp packet
 scheduler helpers"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 23 May 2025 15:27:35 +0800
In-Reply-To: <5f87dca1-e02b-4d66-9cb4-89d104ca5c39@kernel.org>
References: <cover.1747897261.git.tanggeliang@kylinos.cn>
	 <dfd9d56e608ea3f68297092c9e90134e4807d3d6.1747897261.git.tanggeliang@kylinos.cn>
	 <5f87dca1-e02b-4d66-9cb4-89d104ca5c39@kernel.org>
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

Thanks for your review.

On Thu, 2025-05-22 at 17:13 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/05/2025 09:05, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Define .filter as Martin suggested.
> 
> Thank you for the v2.
> 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/bpf.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 2b0cfb57df8c..c7a9d1393786 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -317,9 +317,30 @@ BTF_ID_FLAGS(func,
> > bpf_mptcp_subflow_queues_empty)
> >  BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
> >  BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
> >  
> > +static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog
> > *prog, u32 kfunc_id)
> > +{
> > + if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids, kfunc_id))
> > + return 0;
> > +
> > + if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
> > + return -EACCES;
> > +
> > + /* .filter is called sometimes before prog->aux->st_ops is set,
> > + * then prog->aux->st_ops is NULL. If return -EACCES in this case,
> > + * an error occur:
> > + *  bug: bad parent state for iter next call
> That's interesting. Did you have this after having removed the
> register
> for BPF_PROG_TYPE_CGROUP_SOCKOPT?

Yes, I have removed this.

> 
> With this extra "prog->aux->st_ops != NULL" check, it sounds like the
> filter could allow other ops to use these KFunc, and thus that's an
> issue.
> 
> Do you have more details about the error, and what exactly caused
> this?

bpf_iter_mptcp_subflow_next in the kfunc_set caused this:

# #198/5   mptcp/first:OK
# libbpf: prog 'bpf_bkup_get_send': BPF program load failed: -EFAULT
# libbpf: prog 'bpf_bkup_get_send': -- BEGIN PROG LOAD LOG --
# 0: R1=ctx() R10=fp0
# ; int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk) @
mptcp_bpf_bkup.c:20
# 0: (79) r2 = *(u64 *)(r1 +0)
# func 'get_send' arg0 has btf_id 37366 type STRUCT 'mptcp_sock'
# 1: R1=ctx() R2_w=trusted_ptr_mptcp_sock()
# 1: (bf) r1 = r10                      ; R1_w=fp0 R10=fp0
# 2: (07) r1 += -16                     ; R1_w=fp-16
# ; bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) { @
mptcp_bpf_bkup.c:24
# 3: (85) call bpf_iter_mptcp_subflow_new#53836         ; R0_w=scalar()
fp-16_w=iter_mptcp_subflow(ref_id=1,state=active,depth=0) refs=1
# 4: (b7) r7 = 0                        ; R7_w=0 refs=1
# 5: (b7) r9 = 0                        ; R9_w=0 refs=1
# 6: (b7) r8 = 0                        ; R8_w=0 refs=1
# 7: (05) goto pc+16
# ; if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) || @
mptcp_bpf_bkup.c:25
# 24: (bf) r1 = r10                     ; R1_w=fp0 R10=fp0 refs=1
# 25: (07) r1 += -16                    ; R1_w=fp-16 refs=1
# ; bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) { @
mptcp_bpf_bkup.c:24
# 26: (85) call bpf_iter_mptcp_subflow_next#53838
# bug: bad parent state for iter next callprocessed 11 insns (limit
1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
# -- END PROG LOAD LOG --
# libbpf: prog 'bpf_bkup_get_send': failed to load: -EFAULT
# libbpf: failed to load object 'mptcp_bpf_bkup'
# libbpf: failed to load BPF skeleton 'mptcp_bpf_bkup': -EFAULT
# test_bkup:FAIL:open_and_load: bkup unexpected error: -14
# #198/6   mptcp/bkup:FAIL

> Maybe we should report this issue to BPF maintainers, because what
> you
> did sounds incorrect for a filter, and they didn't have to do that in
> QDisc.

Since QDisc's kfunc_set does not include an iter next function.

This can solve the problem by putting this iter next function in
another kfunc_set, but it is not a perfect solution:

'''
BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW |
KF_TRUSTED_ARGS)
BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
BTF_ID_FLAGS(func, mptcp_subflow_active)
BTF_ID_FLAGS(func, mptcp_set_timeout)
BTF_ID_FLAGS(func, mptcp_wnd_end)
BTF_ID_FLAGS(func, bpf_sk_stream_memory_free, KF_RET_NULL)
BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)

static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog,
u32 kfunc_id)
{
        if (!btf_id_set8_contains(&bpf_mptcp_common_kfunc_ids,
kfunc_id))
                return 0;

        if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
                return -EACCES;

#ifdef CONFIG_BPF_JIT
        if (prog->aux->st_ops != &bpf_mptcp_sched_ops)
                return -EACCES;
#endif

        return 0;
}

static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = { 
        .owner  = THIS_MODULE,
        .set    = &bpf_mptcp_common_kfunc_ids,
        .filter = bpf_mptcp_common_kfunc_filter,
};

BTF_KFUNCS_START(bpf_mptcp_iter_next_kfunc_ids)
BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT |
KF_RET_NULL)
BTF_KFUNCS_END(bpf_mptcp_iter_next_kfunc_ids)

static const struct btf_kfunc_id_set bpf_mptcp_iter_next_kfunc_set = {
        .owner  = THIS_MODULE,
        .set    = &bpf_mptcp_iter_next_kfunc_ids,
};

...

ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
                                &bpf_mptcp_common_kfunc_set);
ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
                                       &bpf_mptcp_iter_next_kfunc_set);
...
'''

WDYT?

Thanks,
-Geliang

> 
> > + */
> > + if (prog->aux->st_ops &&
> > +     prog->aux->st_ops != &bpf_mptcp_sched_ops)
> > + return -EACCES;
> > +
> > + return 0;
> > +}
> > +
> >  static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set =
> > {
> >   .owner = THIS_MODULE,
> >   .set = &bpf_mptcp_common_kfunc_ids,
> > + .filter = bpf_mptcp_common_kfunc_filter,
> >  };
> >  
> >  static int __init bpf_mptcp_kfunc_init(void)
> > @@ -327,8 +348,6 @@ static int __init bpf_mptcp_kfunc_init(void)
> >   int ret;
> >  
> >   ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > - ret = ret ?:
> > register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
> > -        &bpf_mptcp_common_kfunc_set);
> >   ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> >          &bpf_mptcp_common_kfunc_set);
> >  #ifdef CONFIG_BPF_JIT
> 
> Cheers,
> Matt

