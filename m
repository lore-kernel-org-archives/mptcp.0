Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DDC23315F
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207399; cv=none; b=OYLoGWTdwQ6vNVGNQ0WS1myo+drxj9Hvi7xK4jsPTmxmbVujIK2itH6ILhOfHvYDtTFu5omVm1cy1vwzEFbITRGCQVbVF+C1CNepKd29Ii50hNUT4ReNfdlL+MLo28UK2S5/zhZKT3HzmS9/weBfWCA0dDP34GduHgmlDoxs9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207399; c=relaxed/simple;
	bh=yPD+a6rWXny5jdzB8nf3pmoG6QuBA3YA1y9+bCS5HAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3M6IVbLissCmRzyUMH7AdJcQouiUtBZHleN4YViAqzc8mTEhviTPwp1SMiTsxC7vbqb1/z4W/AbMVZuZqmvZOkQswNSc9U07lRETDkCdOT0H3AEWJu2IW6BBBxN9PHTz4SkjJnrkm3oN9WW28RwLCe6c1XmW4CrRMn1nxPlWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFqQzW05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFqQzW05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2945C4CEEF;
	Mon, 17 Mar 2025 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207398;
	bh=yPD+a6rWXny5jdzB8nf3pmoG6QuBA3YA1y9+bCS5HAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GFqQzW05Pm36TE5iYOccvDP56I0KoUgLUAL20V4/jxNfM8Bi4ZnJbRi+q3NxlzRs9
	 zIq+d73D24Yqv3G3B2HZmA2ktWlabRPMkq3C6q132m36uQKYv9AMm6aebHtFnieqUR
	 HVhAQ+a8/bgquI2wlqbxSdUPIe9kWvmmnW8wiYkXhvJ5dnUTWfz/1yLnbvt6IT2na4
	 X6nV5JhK9usteZCc2JTDMlz4RMs0j9izegzXMVibu3hzx+Tmk0YQiXneOrFNKWuISx
	 cHAWzZ/QK4Rv9e97M1zHhI+kYsm4Wo+X2FsDtNXdwYOTfS6IgzncTm5r7v64QJ6pwJ
	 dObcrwNlUoS+w==
Message-ID: <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
Date: Mon, 17 Mar 2025 11:29:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for mptcp_sock
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
 <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn>
 <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 17/03/2025 10:41, Geliang Tang wrote:
> On Mon, 2025-03-10 at 11:30 +0800, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> To make sure the mptcp_subflow bpf_iter is running in the
>> MPTCP context. This patch adds a simplified version of tracking
>> for it:
>>
>> 1. Add a 'struct task_struct *bpf_iter_task' field to struct
>> mptcp_sock.
>>
>> 2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before calling
>> a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL) after
>> the hook returns.
>>
>> 3. In bpf_iter_mptcp_subflow_new(), check
>>
>> 	"READ_ONCE(msk->bpf_scheduler_task) == current"
>>
>> to confirm the correct task, return -EINVAL if it doesn't match.
>>
>> Also creates helpers for setting, clearing and checking that value.
>>
>> Suggested-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>>  net/mptcp/bpf.c      |  2 ++
>>  net/mptcp/protocol.c |  1 +
>>  net/mptcp/protocol.h | 20 ++++++++++++++++++++
>>  net/mptcp/sched.c    | 15 +++++++++++----
>>  4 files changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>> index c0da9ac077e4..0a78604742c7 100644
>> --- a/net/mptcp/bpf.c
>> +++ b/net/mptcp/bpf.c
>> @@ -261,6 +261,8 @@ bpf_iter_mptcp_subflow_new(struct
>> bpf_iter_mptcp_subflow *it,
>>  		return -EINVAL;
>>  
>>  	msk = mptcp_sk(sk);
>> +	if (!mptcp_check_bpf_iter_task(msk))
>> +		return -EINVAL;
>>  
>>  	msk_owned_by_me(msk);
>>  
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 01157ad2e2dc..d98e48ce8cd8 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2729,6 +2729,7 @@ static void __mptcp_init_sock(struct sock *sk)
>>  	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
>>  	WRITE_ONCE(msk->csum_enabled,
>> mptcp_is_checksum_enabled(sock_net(sk)));
>>  	WRITE_ONCE(msk->allow_infinite_fallback, true);
>> +	mptcp_clear_bpf_iter_task(msk);
>>  	msk->recovery = false;
>>  	msk->subflow_id = 1;
>>  	msk->last_data_sent = tcp_jiffies32;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 3492b256ecba..1c6958d64291 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -334,6 +334,7 @@ struct mptcp_sock {
>>  				 */
>>  	struct mptcp_pm_data	pm;
>>  	struct mptcp_sched_ops	*sched;
>> +	struct task_struct *bpf_iter_task;
>>  	struct {
>>  		u32	space;	/* bytes copied in last measurement
>> window */
>>  		u32	copied; /* bytes copied in this measurement
>> window */
>> @@ -1291,4 +1292,23 @@ mptcp_token_join_cookie_init_state(struct
>> mptcp_subflow_request_sock *subflow_re
>>  static inline void mptcp_join_cookie_init(void) {}
>>  #endif
>>  
>> +static inline void mptcp_set_bpf_iter_task(struct mptcp_sock *msk)
>> +{
>> +	WRITE_ONCE(msk->bpf_iter_task, current);
>> +}
>> +
>> +static inline void mptcp_clear_bpf_iter_task(struct mptcp_sock *msk)
>> +{
>> +	WRITE_ONCE(msk->bpf_iter_task, NULL);
>> +}
>> +
>> +static inline bool mptcp_check_bpf_iter_task(struct mptcp_sock *msk)
>> +{
>> +	struct task_struct *task = READ_ONCE(msk->bpf_iter_task);
>> +
>> +	if (task && task == current)
>> +		return true;
>> +	return false;
>> +}
> 
> This v3 has a bug. When I was testing MPTCP BPF selftests in a loop, I
> found that the test would break in some cases. After debugging, I found
> that "task" and "current" were not equal:
> 
> [  520.209749][T11984] MPTCP: bpf_iter_mptcp_subflow_new
> msk=00000000fc8f7370 in_interrupt=0 task=00000000ef28139f
> current=0000000024db2987
> 
> I will try to fix it, but haven't found a solution yet.

(sorry for the delay, I need a bit of time to catch up)

I talked a bit to Alexei Starovoitov last week. He told me that with the
BPF struct_ops, it is possible to tell the verifier that some locks are
taken either by some struct_ops types, or even per callbacks of some
specific struct_ops (WIP on sched_ext side). It is also possible to get
some locks automatically (polymorphism), and there are examples on VFS side.

In other words, it means we don't need to add this "bpf_iter_task",
there are other techniques, but I don't have more details, and I didn't
check in the code. If it is not clear for you and you don't find  other
examples elsewhere (sched_ext? check WIP patches maybe?), then Alexei
said we should not hesitate to ask questions on the BPF mailing list.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

