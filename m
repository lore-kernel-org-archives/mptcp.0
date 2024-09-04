Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D084A40
	for <mptcp@lists.linux.dev>; Wed,  4 Sep 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445793; cv=none; b=fJQBcREY/gI9PmEQp5myZANMv2T5i+Sgu1yT8/Omv7idc07/ZjRsTexTJuL8Hjg7kDXF427Oi1lBALqAC+o8t9qbB2uMshmvVw8TzEYG4xVSeuAuoGGTVd0/K0PIRRFV62kvmMiR0zVQYEivVX7CoeO6fTQE0HIp2twQrSZVq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445793; c=relaxed/simple;
	bh=tw/JRwD16Cw7EI9Cavz4i4wRKr/NacNhto1ma+wOIfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krsmWvBlCXt/p8MrZvaz/5DLifrMusvb6gBfGwfmPwEfnobXaV8yi2fWiuFDn99qYRS2CfNLrFdddsuDzK2lcAxLa1A78zCBU1L7Gr97NHM527BMLZPf6eVwWmqPvgrTwLGmEgOVzHPivo1zJdrnTf7jgYShmufpZWG3uIBEzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjgLpQjg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjgLpQjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCE1C4CEC6;
	Wed,  4 Sep 2024 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445792;
	bh=tw/JRwD16Cw7EI9Cavz4i4wRKr/NacNhto1ma+wOIfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DjgLpQjglHZcKcBmvXWiZsgCnp6RVrFdp1kn6FOAbRgUw3Y2i/8O7R242Q4ji7Ejd
	 mplpk1+mlXgVWGRYuHQ43dxaItrXw9R2iwdkZm652qqbmyg3Y8VEgMOVUtZiPbld/d
	 y1FttaG+/cpA/YUMAhYnZagnQpogJ5GE0C9ofFcR/RsfycKh3iG90E3VOJdkI5Bcpb
	 GexrYPmNIPsFnDKzoDWUPwBj3JtDkiBTOcdsLDzg6DY9pmEnKKyd3jtUy2abh3GqIb
	 FnWFhI3MdUvtMAYfoOWy42oZ9EGOX+uYrclZEE/Ex4mtgxmk2BrYRsRJRu+v4S9WDb
	 epVoaCyFhyJ+g==
Message-ID: <ff17bdda-31b8-45a4-9483-fda9b337b8df@kernel.org>
Date: Wed, 4 Sep 2024 12:29:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 2/4] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1725350462.git.tanggeliang@kylinos.cn>
 <2cd5946354c8cf839684274e9ccc52016fbcf717.1725350462.git.tanggeliang@kylinos.cn>
 <b32de9d6-f941-46d0-9805-ad542ef6f5d6@kernel.org>
 <b8394aac-0fc7-4c40-8125-77450737c323@kernel.org>
 <cb3a4103dd195f6d4d2b8f7823609f9a6b20a2c4.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cb3a4103dd195f6d4d2b8f7823609f9a6b20a2c4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 04/09/2024 11:55, Geliang Tang wrote:
> On Tue, 2024-09-03 at 11:16 +0200, Matthieu Baerts wrote:
>> On 03/09/2024 11:11, Matthieu Baerts wrote:
>>> On 03/09/2024 10:04, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> This patch adds a "cgroup/getsockopt" way to inspect the subflows
>>>> of a
>>>> mptcp socket.
>>>>
>>>> mptcp_for_each_stubflow() and other helpers related to
>>>> list_dentry are
>>>> added into progs/mptcp_bpf.h.
>>>>
>>>> Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list
>>>> and use
>>>> bpf_core_cast to cast a pointer to tcp_sock for readonly. It will
>>>> allow
>>>> to inspect all the fields in a tcp_sock.
>>>
>>> (...)
>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>>> b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>>> index 2e28f4a215b5..1053a795eb43 100644
>>>> --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>>> @@ -4,6 +4,7 @@
>>>>  
>>>>  /* vmlinux.h, bpf_helpers.h and other 'define' */
>>>>  #include "bpf_tracing_net.h"
>>>> +#include "mptcp_bpf.h"
>>>>  
>>>>  char _license[] SEC("license") = "GPL";
>>>>  
>>>> @@ -57,3 +58,92 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>>>>  
>>>>  	return 1;
>>>>  }
>>>> +
>>>> +static int _check_getsockopt_subflow_mark(struct bpf_sock *sk)
>>>> +{
>>>> +	struct mptcp_subflow_context *subflow;
>>>> +	struct mptcp_sock *msk;
>>>> +	int i = 0;
>>>> +
>>>> +	if (sk->protocol != IPPROTO_MPTCP) {
>>>> +		bpf_printk("MPTCP Subflow: unexpected protocol
>>>> %u", sk->protocol);
>>>> +		return -1;
>>>> +	}
>>>
>>> Out of curiosity, why did you move this code here and in
>>> _check_getsockopt_subflow_cc()?
>>>
>>> I'm just surprised because recently, you tried to reduce the amount
>>> of
>>> duplicated code :)
>>
>> While at it: it sounds better to have unique error messages, to know
>> where was the error. Here, a few messages are the same, e.g.
>> protocol,
>> number of subflows, sk is null. Do not hesitate to add something to
>> differentiate them: level & optname, a string prefix, the line
>> number, etc.
> 
> No, I think we should drop all these "bpf_printk" messages. I checked
> all other BPF selftests programs, no one use these error messages to
> debug like this. Just "return 1" is enough:
> 
>         if (!sk || sk->protocol != IPPROTO_MPTCP)
>                 return 1;
> 
> If a BPF program fail, its own load log will show:
> 
> libbpf: prog '_getsockopt_subflow': -- BEGIN PROG LOAD LOG --
> 0: R1=ctx() R10=fp0
> ; int _getsockopt_subflow(struct bpf_sockopt *ctx) @
> mptcp_subflow.c:136
> 0: (bf) r9 = r1                       ; R1=ctx() R9_w=ctx()
> ; struct bpf_sock *sk = ctx->sk; @ mptcp_subflow.c:138
> 1: (79) r7 = *(u64 *)(r9 +0)          ; R7_w=sock() R9_w=ctx()
> ; if (bpf_get_current_pid_tgid() >> 32 != pid) @ mptcp_subflow.c:141
> 2: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
> 
> No need to add any line number by ourselves.

Good, that looks OK.

Just to be sure it is readable: here the BPF program failed because the
PID was not the expected one, right? Or is it another error?

Do you mind sharing the output if the CC is not "foo" for example please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

