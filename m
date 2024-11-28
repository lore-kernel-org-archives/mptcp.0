Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3938DFC
	for <mptcp@lists.linux.dev>; Thu, 28 Nov 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732760077; cv=none; b=oVrwaJno0BvpDxx9Gz8RCbGB0pMPWorLe1CYFGZzscLiOkkJq5BbTxvfCXircJMFG0r4iK/IV5h+Tjh72qZ8fFu+LwhCYzs55wFpnOLbS/7ju6+F9wABgobRDeCB0RpHQvh7f6USCQFF171MQOWUxkr0rFYsMAeQkIBToRHD9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732760077; c=relaxed/simple;
	bh=DvA642ZTfP5qS2Sh0PZKiBwCKetiuta7+NxdLdd/P5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VPv+VJOZuU+Ilprag2gYKyFk8FmMVb5ZCaK6d6uHhTvzAzsegXX/8u88nsDwdMOktbR/2hoqnqa2eafqe0p6szCbzne7PgS17B3ELas61PnqN991m1VwnBgdfwfnwlAaPoebeluz3vCtjwsMK+qAgo+SMWuy2RVgiQXcBmhjX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Elivf2Qc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elivf2Qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F5C4CECC;
	Thu, 28 Nov 2024 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732760076;
	bh=DvA642ZTfP5qS2Sh0PZKiBwCKetiuta7+NxdLdd/P5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Elivf2QcJkzonBFqrcv15wDIl/EMwfmLtmBmCtlN+j2EVrwPJSGCURrGTO2leM8Cf
	 fOSoug2TOXnGcdhJtCWlI/igeQMdX4TiuI1o4d0y5JobnqEebqSd2gG+cRHW9w0ht+
	 4n1zojTRrWLvmFfc+YHdVfj8TosJfSmZg+qRmvpTGipvgGZEUuflmXypMpq/+bw01Y
	 SttMRyeSfORcTCbaEXe/ZX3o0fW+nz13U9R3Nke3wnvFJ9oEfOYj9KINKT3vViUbLs
	 RnO88urW5WemkbhuD245bjTcBgkNoIGD2dmPJ7ltcXXg4eYFzrNKNWtpGNS5uiiSVI
	 q/BR0rWqDrFhw==
Date: Wed, 27 Nov 2024 18:14:35 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 06/13] Squash to "selftests/bpf: Add
 bpf_first scheduler & test"
In-Reply-To: <6ba2d31f4a3fbd72287ac690206f137914e88a0a.camel@kernel.org>
Message-ID: <b6da63e5-1fd5-112d-1b5b-d1a694b55f4c@kernel.org>
References: <cover.1730268415.git.tanggeliang@kylinos.cn> <f3155bd767936df549ff0aaa094b44f9e70323ba.1730268415.git.tanggeliang@kylinos.cn> <aad320b2-aeb4-12b1-5621-2e803827ec77@kernel.org> <6ba2d31f4a3fbd72287ac690206f137914e88a0a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-832995821-1732760076=:70575"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-832995821-1732760076=:70575
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 27 Nov 2024, Geliang Tang wrote:

> Hi Mat,
>
> On Tue, 2024-11-12 at 18:07 -0800, Mat Martineau wrote:
>> On Wed, 30 Oct 2024, Geliang Tang wrote:
>>
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> 1. Update sched_init.
>>>
>>> 2. For drop bpf_object__find_map_by_name in test_bpf_sched(),
>>> change the
>>> first parameter of it as bpf_map.
>>>
>>> 3. Implement mptcp_subflow_set_scheduled in BPF.
>>>
>>> 4. Drop bpf_mptcp_subflow_ctx_by_pos.
>>>
>>> 5. Use the newly added bpf_for_each() helper to walk the conn_list.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>> tools/testing/selftests/bpf/prog_tests/mptcp.c    | 15 +++++++++---
>>> ---
>>> tools/testing/selftests/bpf/progs/mptcp_bpf.h     | 14 ++++++++----
>>> --
>>> .../testing/selftests/bpf/progs/mptcp_bpf_first.c |  4 ++--
>>> 3 files changed, 19 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> index b00af99c5c9d..a6574a537679 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> @@ -645,27 +645,30 @@ static void test_default(void)
>>> 	netns_free(netns);
>>> }
>>>
>>> -static void test_bpf_sched(struct bpf_object *obj, char *sched,
>>> +static void test_bpf_sched(struct bpf_map *map, char *sched,
>>> 			   bool addr1, bool addr2)
>>> {
>>> 	char bpf_sched[MPTCP_SCHED_NAME_MAX] = "bpf_";
>>> 	struct netns_obj *netns;
>>> 	struct bpf_link *link;
>>> -	struct bpf_map *map;
>>> +	int err;
>>>
>>> 	if (!ASSERT_LT(strlen(bpf_sched) + strlen(sched),
>>> 		       MPTCP_SCHED_NAME_MAX, "Scheduler name too
>>> long"))
>>> 		return;
>>>
>>> -	map = bpf_object__find_map_by_name(obj, sched);
>>> 	link = bpf_map__attach_struct_ops(map);
>>> -	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
>>> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
>>> 		return;
>>>
>>> -	netns = sched_init("subflow", strcat(bpf_sched, sched));
>>> +	netns = netns_new(NS_TEST, true);
>>> 	if (!netns)
>>> 		goto fail;
>>>
>>> +	err = sched_init("subflow", strcat(bpf_sched, sched));
>>> +	if (!ASSERT_OK(err, "sched_init"))
>>> +		goto fail;
>>> +
>>> 	send_data_and_verify(sched, addr1, addr2);
>>>
>>> fail:
>>> @@ -681,7 +684,7 @@ static void test_first(void)
>>> 	if (!ASSERT_OK_PTR(skel, "open_and_load: first"))
>>> 		return;
>>>
>>> -	test_bpf_sched(skel->obj, "first", WITH_DATA,
>>> WITHOUT_DATA);
>>> +	test_bpf_sched(skel->maps.first, "first", WITH_DATA,
>>> WITHOUT_DATA);
>>> 	mptcp_bpf_first__destroy(skel);
>>> }
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> index 3b20cfd44505..f8c917dc2c1c 100644
>>> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> @@ -42,6 +42,14 @@ mptcp_subflow_tcp_sock(const struct
>>> mptcp_subflow_context *subflow)
>>> 	return subflow->tcp_sock;
>>> }
>>>
>>
>> Hi Geliang -
>>
>> Thanks for the updates to this series. The change to a BPF-based
>> helper
>> does work around the pointer-handling issue, but it's important to be
>> sure
>> WRITE_ONCE() is being handled correctly.
>>
>>> +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) =
>>> (val))
>>
>> We initially added the C version of the mptcp_subflow_set_scheduled()
>> helper because it wasn't clear how to handle WRITE_ONCE() in BPF. The
>> only
>> other implementation I found is in the cilium code (also GPLv2):
>>
>> https://github.com/cilium/cilium/blob/main/bpf/include/bpf/compiler.h
>>
>> It's a lot more complex than the macro added above (using an asm
>> statement
>> to set up the memory barrier). I don't know enough about low-level
>> BPF and
>> BPF toolchains to know that the cilium WRITE_ONCE() technique works
>> everywhere - anyone else have a comment on this?
>>
>> Another concern I have is that a lot of boilerplate BPF code is
>> needed to
>> set the scheduled bit in every BPF scheduler, and it's easy for a
>> scheduler author to just skip the WRITE_ONCE() stuff and possibly
>> introduce subtle write-ordering bugs. The C helper was easy to use
>> correctly.
>>
>> I'm not sure what the correct solution is yet. Geliang, do you have
>> any
>> ideas for an approach that works around the kfunc pointer limitations
>> and
>> also prevents WRITE_ONCE() bugs?
>
> I finally found another solution. We need to define a new BPF function
> bpf_mptcp_ssk_cast() here and set its parameter type to ARG_ANYTHING,
> so that in bpf_burst_get_send(), we don't need to use bpf_core_cast()
> for read-only cast. In this way, the pointer returned by
> bpf_mptcp_ssk_cast() can be passed to any kfuncs, and there is no need
> to implement mptcp_subflow_set_scheduled() and WRITE_ONCE() in BPF.
>
> +BPF_CALL_1(bpf_mptcp_ssk_cast, struct sock *, sk)
> +{
> +       BTF_TYPE_EMIT(struct sock);
> +       if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP &&
> sk_is_mptcp(sk))
> +               return (unsigned long)sk;
> +       return (unsigned long)NULL;
> +}
> +
> +static const struct bpf_func_proto bpf_mptcp_ssk_cast_proto = {
> +       .func           = bpf_mptcp_ssk_cast,
> +       .gpl_only       = false,
> +       .ret_type       = RET_PTR_TO_BTF_ID_OR_NULL,
> +       .arg1_type      = ARG_ANYTHING,
> +       .ret_btf_id     = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> +};
>

Hi Geliang -

Thanks for continuing to look in to this.

Looks like this would bypass the pointer safety checks in the eBPF 
interpreter, am I understanding ARG_ANYTHING correctly? It's important to 
work within the type system to be sure only valid pointers are used, given 
the exposure to userspace.

- Mat

> With this bpf_mptcp_ssk_cast() function, we can define struct
> subflow_send_info in mptcp_bpf_burst.c the same as in
> net/mptcp/protocol.c:
>
> struct subflow_send_info {
>         struct sock *ssk;
>         u64 linger_time;
> };
>
> without defining a special struct bpf_subflow_send_info like in this v9
> version:
>
> struct bpf_subflow_send_info {
> 	struct mptcp_subflow_context *subflow;
> 	__u64 linger_time;
> };
>
> And invoke this bpf_mptcp_ssk_cast() function in bpf_burst_get_send()
> like this:
>
>        /* pick the best backup if no other subflow is active */
>        if (!nr_active)
>                send_info[SSK_MODE_ACTIVE].ssk =
> send_info[SSK_MODE_BACKUP].ssk;
>
>        ssk = bpf_mptcp_ssk_cast(send_info[SSK_MODE_ACTIVE].ssk);
>        if (!ssk || !sk_stream_memory_free(ssk))
>                return -1;
>
>        subflow = bpf_mptcp_subflow_ctx(ssk);
>        if (!subflow)
>                return -1;
>
>        burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk-
>> snd_nxt);
>        wmem = ssk->sk_wmem_queued;
>        if (!burst)
>                goto out;
>
>        subflow->avg_pacing_rate = div_u64((__u64)subflow-
>> avg_pacing_rate * wmem +
>                                           ssk->sk_pacing_rate * burst,
>                                           burst + wmem);
>        msk->snd_burst = burst;
>
> out:
>        mptcp_subflow_set_scheduled(subflow, true);
>
> The only concern is that this bpf_mptcp_ssk_cast() function is not
> general enough. It's only used in bpf_burst. I'm not sure whether BPF
> upstream will accept adding this function.
>
> Thanks,
> -Geliang
>
>>
>> - Mat
>>
>>
>>> +
>>> +static __always_inline void
>>> +mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
>>> bool scheduled)
>>> +{
>>> +	WRITE_ONCE(subflow->scheduled, scheduled);
>>> +}
>>> +
>>> /* ksym */
>>> extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock
>>> *msk) __ksym;
>>> extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
>>> @@ -52,10 +60,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
>>> __ksym;
>>> extern struct sock *
>>> bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context
>>> *subflow) __ksym;
>>>
>>> -extern void mptcp_subflow_set_scheduled(struct
>>> mptcp_subflow_context *subflow,
>>> -					bool scheduled) __ksym;
>>> -
>>> -extern struct mptcp_subflow_context *
>>> -bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data,
>>> unsigned int pos) __ksym;
>>> -
>>> #endif
>>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
>>> b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
>>> index d57399b407a7..5d0f89c636f0 100644
>>> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
>>> @@ -20,11 +20,11 @@ SEC("struct_ops")
>>> int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
>>> 	     struct mptcp_sched_data *data)
>>> {
>>> -
>>> 	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0),true);
>>> +	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx(msk-
>>>> first), true);
>>> 	return 0;
>>> }
>>>
>>> -SEC(".struct_ops")
>>> +SEC(".struct_ops.link")
>>> struct mptcp_sched_ops first = {
>>> 	.init		= (void *)mptcp_sched_first_init,
>>> 	.release	= (void *)mptcp_sched_first_release,
>>> --
>>> 2.45.2
>>>
>>>
>>>
>
>
>
--0-832995821-1732760076=:70575--
