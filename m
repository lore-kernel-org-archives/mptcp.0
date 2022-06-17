Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B87F
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655425670; x=1686961670;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ubZBXvjq6EG2W6pPpBceUDNlQkCRbxLyd8CokoDLArg=;
  b=LmAC5UhTgewcriACSwxN+LQRDOXVrWxrmcFtrcwT37XAZNU+cfXYpHlJ
   mtxqHF9cO9FpL/ukg1cycI8SzVPfRW0xz1nwurWyz7iqg9qIPkJ2Dg9l3
   PEVfpei/hHKrTZdPzYlV4wA2x0h5BssccOrnmVOnS+negv/rQ98B0gBfz
   0xp0HXK6yyaPX3jjzSwnouJyfUFfpm0GF7wO2sMHnFIiR8FDBRQMST392
   fDhYRdKm2nW89a5dWJrMB7DTr+EHMImbu6sFcJ3qlno7ZOexISeeYR9G1
   ZlIvXCz2XglX7Cjh0A4cmW638KqK0ZZMaIliLywi7VYjljiMfmCeM5B0Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343345856"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343345856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 17:27:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688059640"
Received: from lhossain-mobl.amr.corp.intel.com ([10.255.231.225])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 17:27:49 -0700
Date: Thu, 16 Jun 2022 17:27:48 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 3/6] Squash-to: "mptcp: invoke MP_FAIL
 response when needed"
In-Reply-To: <0eaffe68b6ffa6ad0465e8f0ec85e896a8a49d7b.camel@redhat.com>
Message-ID: <97bec763-478b-8dd9-917a-8bf1867b13be@linux.intel.com>
References: <cover.1655324843.git.pabeni@redhat.com>  <1deca06703f8666dc199b76f39cd881733741666.1655324843.git.pabeni@redhat.com>  <58c2377-cc90-7f55-9aa5-1a9d6578fd8a@linux.intel.com> <0eaffe68b6ffa6ad0465e8f0ec85e896a8a49d7b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 16 Jun 2022, Paolo Abeni wrote:

> On Wed, 2022-06-15 at 17:59 -0700, Mat Martineau wrote:
>> On Wed, 15 Jun 2022, Paolo Abeni wrote:
>>
>>> This tries to address a few issues outstanding in the mentioned
>>> patch:
>>> - we explicitly need to reset the timeout timer for mp_fail's sake
>>> - we need to explicitly generate a tcp ack for mp_fail, otherwise
>>>  there are no guarantees for suck option being sent out
>>> - the timeout timer needs handling need some caring, as it's still
>>>  shared between mp_fail and msk socket timeout.
>>> - we can re-use msk->first for msk->fail_ssk, as only the first/mpc
>>>  subflow can fail without reset. That additionally avoid the need
>>>  to clear fail_ssk on the relevant subflow close.
>>> - fail_tout would need some additional annotation. Just to be on the
>>>  safe side move its manipulaiton under the ssk socket lock.
>>>
>>> Last 2 paragraph of the squash to commit should be replaced with:
>>>
>>> """
>>> It leverages the fact that only the MPC/first subflow can gracefully
>>> fail to avoid unneeded subflows traversal: the failing subflow can
>>> be only msk->first.
>>>
>>> A new 'fail_tout' field is added to the subflow context to record the
>>> MP_FAIL response timeout and use such field to reliably share the
>>> timeout timer between the MP_FAIL event and the MPTCP socket close timeout.
>>>
>>> Finally, a new ack is generated to send out MP_FAIL notification as soon
>>> as we hit the relevant condition, instead of waiting a possibly unbound
>>> time for the next data packet.
>>> """
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/pm.c       |  4 +++-
>>> net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++--------
>>> net/mptcp/protocol.h |  4 ++--
>>> net/mptcp/subflow.c  | 24 ++++++++++++++++++--
>>> 4 files changed, 72 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index 3c7f07bb124e..45e2a48397b9 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>>> @@ -305,13 +305,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>>> 	if (!READ_ONCE(msk->allow_infinite_fallback))
>>> 		return;
>>>
>>> -	if (!msk->fail_ssk) {
>>> +	if (!subflow->fail_tout) {
>>> 		pr_debug("send MP_FAIL response and infinite map");
>>>
>>> 		subflow->send_mp_fail = 1;
>>> 		subflow->send_infinite_map = 1;
>>> +		tcp_send_ack(sk);
>>> 	} else {
>>> 		pr_debug("MP_FAIL response received");
>>> +		WRITE_ONCE(subflow->fail_tout, 0);
>>> 	}
>>> }
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index a0f9f3831509..50026b8da625 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -500,7 +500,7 @@ static void mptcp_set_timeout(struct sock *sk)
>>> 	__mptcp_set_timeout(sk, tout);
>>> }
>>>
>>> -static bool tcp_can_send_ack(const struct sock *ssk)
>>> +static inline bool tcp_can_send_ack(const struct sock *ssk)
>>> {
>>> 	return !((1 << inet_sk_state_load(ssk)) &
>>> 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
>>> @@ -2490,24 +2490,56 @@ static void __mptcp_retrans(struct sock *sk)
>>> 		mptcp_reset_timer(sk);
>>> }
>>>
>>> +/* schedule the timeout timer for the nearest relevant event: either
>>> + * close timeout or mp_fail timeout. Both of them could be not
>>> + * scheduled yet
>>> + */
>>> +void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout)
>>> +{
>>> +	struct sock *sk = (struct sock *)msk;
>>> +	unsigned long timeout, close_timeout;
>>> +
>>> +	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
>>> +		return;
>>> +
>>> +	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
>>> +
>>> +	/* the following is basically time_min(close_timeout, fail_tout) */
>>> +	if (!fail_tout)
>>> +		timeout = close_timeout;
>>> +	else if (!sock_flag(sk, SOCK_DEAD))
>>> +		timeout = fail_tout;
>>> +	else if (time_after(close_timeout, fail_tout))
>>> +		timeout = fail_tout;
>>> +	else
>>> +		timeout = close_timeout;
>>> +
>>> +	sk_reset_timer(sk, &sk->sk_timer, timeout);
>>> +}
>>
>> Hi Paolo -
>>
>> The above function seems more complex than needed. If mptcp_close() has
>> been called, the fail timeout should be considered canceled and the
>> "close" has exclusive use of sk_timer. subflow->fail_tout can be set to 0
>> and sk_timer can be set only based on TCP_TIMEWAIT_LEN.
>
> I agree the above function is non trivial, on the flip side, it helps
> keeping all the timeout logic in a single place.
>
> Note that msk->first->fail_tout is under the subflow socket lock
> protection, and this function is not always invoked under such lock, so
> we will need to either add more read/write once annotation or split the
> logic in the caller.
>
> Side note: I agree a bit with David Laight wrt *_once preoliferation,
> possibly with less divisive language:
> https://lore.kernel.org/netdev/cea2c2c39d0e4f27b2e75cdbc8fce09d@AcuMS.aculab.com/
>
> ;)

Heh - yeah, I saw that exchange too :)

>
> *_ONCE are a bit hard to track and difficult to verify formally, so I
> tried hard to reduce their usage. Currently we have only a single READ
> operation outside the relevant lock, which is AFAIK the 'safer'
> possible scenario with such annotations. All the write operations are
> under the subflow socket lock.
>
>> TCP_RTO_MAX for the MP_FAIL timeout was kind of arbitrary - the spec
>> doesn't say what exactly to do. We didn't want the connection to be in the
>> "unacknowledged" MP_FAIL state forever, but also didn't want to give up
>> too fast.
>
> This function don't make any assumption on the relative timeout length
> and should fit the case if we will make them configurable someday
>
>> Given that, do you think the complexity is justified to possibly reset the
>> subflow earlier in this "unacknowledged MP_FAIL followed by a close"
>> scenario?
>
> IMHO yes ;) But if you have strong opinion otherwise I can refactor the
> code...
>

I do think it's better to cancel the MP_FAIL timeout once mptcp_close() is 
called. It's not just about the code in mptcp_reset_timeout(), it doesn't 
seem meaningful to continue MP_FAIL handling after close and to have 
various scenarios to consider/test/etc. for timeout or MP_FAIL echo 
ordering.


--
Mat Martineau
Intel
