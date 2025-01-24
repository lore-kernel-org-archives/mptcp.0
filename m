Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB841D5AC6
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709870; cv=none; b=tcCNmBe2pgnfA9+HSsAoFriOlAGOy0JdxjMcAY3CQVLszthN7A5kt2NgE5GhWUExOGtQlNvM6aHguPitPEFymXTm+aueTnYF12sC9MxGCdXIe6Nhj+oryN/PWBt+CUHsltV211o5c9ngXBtIzRiZ9et5hvf/MwgNxzEONh96Qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709870; c=relaxed/simple;
	bh=ikimO1VKpqZ3Gn4pIIUy0cWPTTJTVHD6QtN5C0aNjUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=p5MNXVRsTEgczF9aJsDLl2oOhFw6Bw/BJhb6KPgXSDUhMdRH3awbouApHUF81e/NooAfsMpDQ3gyziKckgsxcyezBR89ncf0Z073ebYMJRPHuEB8twurg5tngZhenPvSYBzlranmAGvNABurKHpJupEsYumlKPyU75Sfkl2B6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAz8v128; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAz8v128"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916A4C4CED2;
	Fri, 24 Jan 2025 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737709870;
	bh=ikimO1VKpqZ3Gn4pIIUy0cWPTTJTVHD6QtN5C0aNjUE=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=RAz8v1285JKnC5G3XF+BDWlDv83Si4Ja1iJaBeKXWYVFXVEUr4JR7ibjlBZHjcn1/
	 vgPrQhxxKQrjxONEKrWxZTCvyEGvT+IE+02yaoHyHQfAy/ndRkBhLNkhsWTAI3P0pz
	 ZBXFwc+geqFsCPA3gZXwB335qhi+Lhv8sfEYm6oIGLp8syAuuXOWXHJpSb6rU4ybCd
	 qZcVQiKiAgxrtxv+CvAqYZ5J9P08ysFMSCinz8huiTJIxlHdnUdg+oFAWaS+UCCkJ/
	 tJkl/bDa4A/qZE2PfftzvBRnYrsngLyGTgrVW6clzNSeqocAhg6ZXn7IYGtLiTKFE+
	 xtXnS/FDFUu2g==
Message-ID: <378683da-ce3e-4c6d-b933-265d404a716c@kernel.org>
Date: Fri, 24 Jan 2025 10:10:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next/net v2 4/7] bpf: Add mptcp_subflow bpf_iter
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-4-ae244d3cdbbc@kernel.org>
 <fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fdf0ddbe-e007-4a5f-bbdf-9a144e8fbe35@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

(only with the MPTCP list)

On 24/01/2025 01:47, Martin KaFai Lau wrote:
> On 12/19/24 7:46 AM, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> It's necessary to traverse all subflows on the conn_list of an MPTCP
>> socket and then call kfunc to modify the fields of each subflow. In
>> kernel space, mptcp_for_each_subflow() helper is used for this:
>>
>>     mptcp_for_each_subflow(msk, subflow)
>>         kfunc(subflow);
>>
>> But in the MPTCP BPF program, this has not yet been implemented. As
>> Martin suggested recently, this conn_list walking + modify-by-kfunc
>> usage fits the bpf_iter use case.
>>
>> So this patch adds a new bpf_iter type named "mptcp_subflow" to do
>> this and implements its helpers bpf_iter_mptcp_subflow_new()/_next()/
>> _destroy(). And register these bpf_iter mptcp_subflow into mptcp
>> common kfunc set. Then bpf_for_each() for mptcp_subflow can be used
>> in BPF program like this:
>>
>>     bpf_for_each(mptcp_subflow, subflow, msk)
>>         kfunc(subflow);
>>
>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>   - v2:
>>     - Add BUILD_BUG_ON() checks, similar to the ones done with other
>>       bpf_iter_(...) helpers.
>>     - Replace msk_owned_by_me() by sock_owned_by_user_nocheck() and
>>       !spin_is_locked() (Martin).
>>
>> A few versions of this single patch have been previously posted to the
>> BPF mailing list by Geliang, before continuing to the MPTCP mailing list
>> only, with other patches of this series. The version of the whole series
>> has been reset to 1, but here is the ChangeLog for the previous ones:
>>   - v2: remove msk->pm.lock in _new() and _destroy() (Martin)
>>         drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2] (Andrii)
>>   - v3: drop bpf_iter__mptcp_subflow
>>   - v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
>>         it in _next() (Andrii)
>>   - v5: use list_is_last() instead of list_entry_is_head() add
>>         KF_ITER_NEW/NEXT/DESTROY flags add msk_owned_by_me in _new()
>>   - v6: add KF_TRUSTED_ARGS flag (Andrii, Martin)
>> ---
>>   net/mptcp/bpf.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>> ++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>> index
>> c5bfd84c16c43230d9d8e1fd8ff781a767e647b5..e39f0e4fb683c1aa31ee075281daee218dac5878 100644
>> --- a/net/mptcp/bpf.c
>> +++ b/net/mptcp/bpf.c
>> @@ -35,6 +35,15 @@ static const struct btf_kfunc_id_set
>> bpf_mptcp_fmodret_set = {
>>       .set   = &bpf_mptcp_fmodret_ids,
>>   };
>>   +struct bpf_iter_mptcp_subflow {
>> +    __u64 __opaque[2];
>> +} __aligned(8);
>> +
>> +struct bpf_iter_mptcp_subflow_kern {
>> +    struct mptcp_sock *msk;
>> +    struct list_head *pos;
>> +} __aligned(8);
>> +
>>   __bpf_kfunc_start_defs();
>>     __bpf_kfunc static struct mptcp_subflow_context *
>> @@ -47,10 +56,54 @@ bpf_mptcp_subflow_ctx(const struct sock *sk)
>>       return NULL;
>>   }
>>   +__bpf_kfunc static int
>> +bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
>> +               struct mptcp_sock *msk)
>> +{
>> +    struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
>> +    struct sock *sk = (struct sock *)msk;
>> +
>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
>> +             sizeof(struct bpf_iter_mptcp_subflow));
>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
>> +             __alignof__(struct bpf_iter_mptcp_subflow));
>> +
>> +    kit->msk = msk;
>> +    if (!msk)
> 
> NULL check is not needed. verifier should have rejected it for
> KF_TRUSTED_ARGS.
> 
>> +        return -EINVAL;
>> +
>> +    if (!sock_owned_by_user_nocheck(sk) &&
>> +        !spin_is_locked(&sk->sk_lock.slock))
> 
> I could have missed something. If it is to catch bug, should it be
> sock_owned_by_me() that has the lockdep splat? For the cg get/setsockopt
> hook here, the lock should have already been held earlier in the kernel.

:)

So from what I understand: either we need these checks because this
helper could technically be called when these conditions are not met. Or
we don't need them, and we can have sock_owned_by_me() (without the
return that was in the v1) for lockdep.

> This set is only showing the cg sockopt bpf prog but missing the major
> struct_ops piece. It is hard to comment. I assumed the lock situation is
> the same for the struct_ops where the lock will be held before calling
> the struct_ops prog?

Can we restrict the use of this helper only for some specific callbacks?
Or for only some specific struct_ops?

Last time I looked, I thought that you could only restrict it like that:
"this helper can be used by (any) struct_ops". But then does it mean
this helper could be called from a TCP BPF CC ops or another unrelated
one for example? How can we avoid that?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

