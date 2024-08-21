Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D61F2FF7
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233043; cv=none; b=UBojlSkJQgO5GKgx0pA4x5G+arJxa7VjRehDh7JAZUKwCRJucWce81jAYKGDaw7Mf608t5c5UZcsh8VHUo1HHQcN+2B1QEi8+8WB8EtU3R++mJY47wIrcTNvTFO/C49Foy3YlbwiFBscn+SGypFCbgs3LtW2CiN/EInwG1XYSJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233043; c=relaxed/simple;
	bh=R49RCNwJPKJF531IpdU4UAgSJskXC7nlU57G5tJOceo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKZevjEd1aBT86e8UJSoMd2GtCUUx00QBxyZYik2HM9ANPawzmrqyGWm+QZh39jRXOL8s78IICYbuS7DpFGAoBtoNlzclJPxgXWfWOO7yk7lsBGqGLfw1yzMSVNNTaKr1OVUSP5Q4qGIuvNhquGLbD7ff7yZ5zwSmuF8xikpqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWIphCaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWIphCaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B42BC32782;
	Wed, 21 Aug 2024 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724233043;
	bh=R49RCNwJPKJF531IpdU4UAgSJskXC7nlU57G5tJOceo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fWIphCaMELsRle/jdSyW5HvBHXIwZO2yDfR5uXXaFK4emaqOQFhnjpfn3dMMY2PW6
	 5x7jpJ5GMiM7FneqOfpam4fXgcUbP/LtibOMGTA9F5hp8pbfTB60rtAQC0/Rt7sdSo
	 bfHoVZyQF88Tik2fhEvpt99pJ7VItLuhUJ6t/MFTlQTCpLzDzmjsvseyV3yWw72q8U
	 EOIenf5CmE5G3hJzpy7aq6piIlhnykNPbVjTLTluoCFmUj8Q5mMqFGlu+9sT7o+3/R
	 s9D6W/u30x1/KEqknfDdp4hX6QmWKx7wxfrnfdeUTfcW8o4kUsRYsTU7lvxlYPDdhs
	 q2GS8g0yAjJEw==
Message-ID: <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
Date: Wed, 21 Aug 2024 11:37:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
 <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 21/08/2024 10:00, Geliang Tang wrote:
> On Tue, 2024-08-20 at 11:48 +0200, Matthieu Baerts wrote:
>> On 20/08/2024 10:44, Geliang Tang wrote:

(...)

>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> index 69fdcb28249d..2178db94f764 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> @@ -383,6 +383,7 @@ static void run_subflow(char *new)
>>>  {
>>>  	int server_fd, client_fd, err;
>>>  	char cc[TCP_CA_NAME_MAX];
>>> +	unsigned int mark;
>>>  	socklen_t len;
>>>  
>>>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1,
>>> 0);
>>> @@ -407,6 +408,10 @@ static void run_subflow(char *new)
>>>  	ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
>>>  	ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
>>
>> I guess the next steps is to remove these 'ss_search()', right?
> 
> We can keep it for double checks.

I would not mind, even if 'ss | grep' is used in other BPF tests, but I
understood from Martin he prefers not to depend on external tools as
much as possible. It should indeed ease the maintenance.

>>> +	len = sizeof(mark);
>>> +	err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark,
>>> &len);
>>> +	ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)");
>>> +
>>>  	close(client_fd);
>>>  fail:
>>>  	close(server_fd);
>>> @@ -417,6 +422,7 @@ static void test_subflow(void)
>>>  	int cgroup_fd, prog_fd, err;
>>>  	struct mptcp_subflow *skel;
>>>  	struct nstoken *nstoken;
>>> +	struct bpf_link *link;
>>>  
>>>  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
>>>  	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup:
>>> mptcp_subflow"))
>>> @@ -442,6 +448,10 @@ static void test_subflow(void)
>>>  	if (endpoint_init("subflow") < 0)
>>>  		goto close_netns;
>>>  
>>> +	link = bpf_program__attach_cgroup(skel->progs._getsockopt,
>>> cgroup_fd);
>>> +	if (!ASSERT_OK_PTR(link, "getsockopt prog"))
>>
>> I don't know how it works: is this going to fail if the getsockopt
>> program set 'ctx->retval = -1'?
> 
> Yes. ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)") will fail if the
> getsockopt program set 'ctx->retval = -1'.

Good, thank you!

>>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> index 782f36ed027e..2086170e7379 100644
>>> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> @@ -7,6 +7,32 @@
>>>  
>>>  #define MPTCP_SUBFLOWS_MAX 8
>>>  
>>> +static inline int list_is_head(const struct list_head *list,
>>> +			       const struct list_head *head)
>>> +{
>>> +	return list == head;
>>> +}
>>> +
>>> +#define list_entry(ptr, type,
>>> member)					\
>>> +	container_of(ptr, type, member)
>>> +
>>> +#define list_first_entry(ptr, type,
>>> member)				\
>>> +	list_entry((ptr)->next, type, member)
>>> +
>>> +#define list_next_entry(pos,
>>> member)					\
>>> +	list_entry((pos)->member.next, typeof(*(pos)), member)
>>> +
>>> +#define list_entry_is_head(pos, head,
>>> member)				\
>>> +	list_is_head(&pos->member, (head))
>>> +
>>> +#define list_for_each_entry(pos, head,
>>> member)				\
>>> +	for (pos = list_first_entry(head, typeof(*pos),
>>> member);	\
>>> +	     !list_entry_is_head(pos, head,
>>> member);			\
>>> +	     pos = list_next_entry(pos, member))
>>
>> Out of curiosity, are these generic helpers not defined elsewhere? Is
>> it
>> OK not to use the '_safe' version where the deletion of elements is
>> supported?
> 
> It's read only in this test, so list_for_each_entry is enough. I added
> the '_safe' version in v2 too for future use.

OK! (but I don't think you defined list_for_each_entry_safe(). Or is it
defined elsewhere?)

>>> +
>>> +#define mptcp_for_each_subflow(__msk,
>>> __subflow)			\
>>> +	list_for_each_entry(__subflow, &((__msk)->conn_list),
>>> node)
>>> +
>>>  extern void mptcp_subflow_set_scheduled(struct
>>> mptcp_subflow_context *subflow,
>>>  					bool scheduled) __ksym;
>>>  
>>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>> b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>> index bc572e1d6df8..c41418ab8db4 100644
>>> --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
>>> @@ -4,6 +4,7 @@
>>>  
>>>  /* vmlinux.h, bpf_helpers.h and other 'define' */
>>>  #include "bpf_tracing_net.h"
>>> +#include "mptcp_bpf.h"
>>>  
>>>  char _license[] SEC("license") = "GPL";
>>>  
>>> @@ -57,3 +58,34 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>>>  
>>>  	return 1;
>>>  }
>>> +
>>> +SEC("cgroup/getsockopt")
>>> +int _getsockopt(struct bpf_sockopt *ctx)
>>
>> This name seems too generic while what is done here is specific to
>> the
>> 'subflow' test. Maybe: _check_getsockopt_subflows()?
> 
> Changed it to _getsockopt_subflow in v2.
> 
>>
>> (or _check_getsockopt_subflows_mark() and
>> _check_getsockopt_subflow_cc()
>> see below)
>>
>>> +{
>>> +	struct mptcp_sock *msk = bpf_core_cast(ctx->sk, struct
>>> mptcp_sock);
>>
>> What happens if the 'sk' is not an 'msk'?
>> Does it check that the sk is indeed an MPTCP one? (how?)
> 
> Also check msk->token in v2.

Mmh, I'm not sure if this is enough: the offset of 'token' in the msk
structure could point to something unrelated but non-null in another
socket structure, or out of bound. I guess BPF is doing extra checks not
to crash here. But maybe that's OK because it is only reading stuff?

>>> +	struct mptcp_subflow_context *subflow;
>>> +	int i = 0;
>>> +
>>> +	if (!msk || ctx->level != SOL_SOCKET || ctx->optname !=
>>> SO_MARK)
>>> +		return 1;
>>
>> Would it not be clearer to split the two checks? One dedicated to the
>> mark, when getsockopt(SO_MARK) is used, and one for the CC, when the
>> getsockopt(TCP_CONGESTION) is used? By doing that, we would know
>> which
>> one had an issue, if any, not just "something wrong with
>> getsockopt()"?
> 
> Done in v2.

Thanks!

>>> +
>>> +	mptcp_for_each_subflow(msk, subflow) {
>>
>> (might be better to use this helper in our WIP MPTCP BPF packets
>> scheduler examples, instead of converting them to a fixed array)
> 
> Yes, but there are still some access permission issues that need to be
> resolved.

OK, because structures cannot be modified I suppose.

>>
>>> +		struct inet_connection_sock *icsk;
>>> +		struct sock *ssk;
>>> +
>>> +		ssk =
>>> mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
>>> +							   struct
>>> mptcp_subflow_context));
>>> +		icsk = bpf_core_cast(ssk, struct
>>> inet_connection_sock);
>>> +
>>> +		if (ssk->sk_mark != i + 1)
>>> +			ctx->retval = -1;
>>> +		if (ssk->sk_mark == 1 &&
>>> +		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc,
>>> TCP_CA_NAME_MAX))
>>> +			ctx->retval = -1;
>>> +
>>> +		if (i++ >= MPTCP_SUBFLOWS_MAX)
>>> +			break;
>>
>> I guess this part is needed for the verifier, right?
>> Somehow related to "cond_break" explained in this link?
>>
>>   https://lwn.net/Articles/964381/
>>
> 
> Change this as "cond_break" in v2.

Note that you could also modify list_for_each_entry() to add this
'cond_break' (+bpf_experimental.h?), not to have to deal with that each
time mptcp_for_each_subflow is used.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

