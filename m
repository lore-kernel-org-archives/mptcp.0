Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC111718
	for <mptcp@lists.linux.dev>; Fri, 22 Dec 2023 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/gfMpTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7082EC433C8;
	Fri, 22 Dec 2023 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703240819;
	bh=e1qxEUcL8hmm+Jci1pSY+Lton1e3nK5wFjjghZVpnxs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=q/gfMpTGdecjFel3zibFHSJdhnyf0cYmpZqGBcnkIbGSN++UqhQHqyG2G5c//IiHU
	 mtOw98P0Spde6EDg2dGnRBC41Ikvb0dXYh+7+f4XE9NpRAt+7KRM4tUIzXxW0XwN4/
	 gmP29ls2SBqD/1abakjk8S/ynFCb2ChU6vu5D71cKVXZjJJGw6bphS17UrU18oJRqg
	 rflWI2hvCOlYMHzYpjAnMlWg2AAE/PwRpT044XtdsZ2MxY11pSWRpQwwuKP1u3/yDC
	 A/URobTzPCZsxRRCjOigp6zyS1luW97eRIGx3kj9ZF6SZq4RIPSwgsPQdYGRvOW+99
	 89oYuGWQFIX3Q==
Message-ID: <cae968d4-f172-46f0-b0b3-16119173c632@kernel.org>
Date: Fri, 22 Dec 2023 11:26:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net-next] mptcp: cleanup state propagation.
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>
References: <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
 <2763a165e2dce31e8e8d1f0268aaa69c9127a29d.camel@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2763a165e2dce31e8e8d1f0268aaa69c9127a29d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/12/2023 10:16, Paolo Abeni wrote:
> Hi,
> 
> On Wed, 2023-11-22 at 17:21 +0100, Paolo Abeni wrote:
>> When propagating the first subflow state via the release_cb, the
>> msk must actually take to 2 separate actions: state sync-up and
>> send buffer sync-up. Relaying on the specific flags instead of
>> bounding both in __mptcp_sync_state(), allows cleaning up a bit
>> the code.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/protocol.c | 3 +--
>>  net/mptcp/subflow.c  | 5 ++---
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 199b2e09f1ac..4fc038d29623 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3404,9 +3404,8 @@ static void mptcp_release_cb(struct sock *sk)
>>  	if (unlikely(msk->cb_flags)) {
>>  		/* be sure to sync the msk state before taking actions
>>  		 * depending on sk_state (MPTCP_ERROR_REPORT)
>> -		 * On sk release avoid actions depending on the first subflow
>>  		 */
>> -		if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags) && msk->first)
>> +		if (__test_and_clear_bit(MPTCP_SYNC_STATE, &msk->cb_flags))
>>  			__mptcp_sync_state(sk, msk->pending_state);
>>  		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
>>  			__mptcp_error_report(sk);
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 6d7684c35e93..64302a1ac306 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -421,9 +421,6 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
>>  
>>  void __mptcp_sync_state(struct sock *sk, int state)
>>  {
>> -	struct mptcp_sock *msk = mptcp_sk(sk);
>> -
>> -	__mptcp_propagate_sndbuf(sk, msk->first);
>>  	if (sk->sk_state == TCP_SYN_SENT) {
>>  		inet_sk_state_store(sk, state);
>>  		sk->sk_state_change(sk);
>> @@ -436,10 +433,12 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk)
>>  
>>  	mptcp_data_lock(sk);
>>  	if (!sock_owned_by_user(sk)) {
>> +		__mptcp_propagate_sndbuf(sk, msk->first);
>>  		__mptcp_sync_state(sk, ssk->sk_state);
>>  	} else {
>>  		msk->pending_state = ssk->sk_state;
>>  		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
>> +		__set_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags);
>>  	}
>>  	mptcp_data_unlock(sk);
>>  }
> 
> Could you please drop this patch? And not sent it upstream...
> 
> I'm working on a series of pre-req for
> https://github.com/multipath-tcp/mptcp_net-next/issues/464
> and - among many other things - it basically will require reverting
> this patch :(

Thank you for the heads-up!

While at it, I also fixed a compilation issue after the last sync with
net-next.

New patches for t/upstream:
- 6835eade0d25: Revert "mptcp: cleanup state propagation"
- ba09c8c53a73: Revert "Squash to "bpf: Add bpf_mptcp_sched_ops""
- Results: 748f20530b90..4720030d95d3 (export)

(Tests are not in progress)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
