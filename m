Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEF13C9A5
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779147; cv=none; b=O58ZmpVJS6mDXIIU7rvWTpCPYnbrCcGvD1nfLqpbzCrPu3CMSbEFid/UPbfp9dRxM3nqaRwgCtixNipyXgtUOXKXFNukNviKNbP/ph0Kyrd8XhFr58/NDIrF/uoJHs9WqA5vZzSXsa07O54mALNGgYY4SH73IholZIUxUHhh7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779147; c=relaxed/simple;
	bh=enf4hLbW4mh9iN4W7ArwQPvXY/1lTUsu4fFjM0qOo34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLzZqISM89SiNhsWl29cU/ZoItPyfVnGh1Oj7FI2s5+A0CK4TirGTCBvhFOsLqdZhcyPEikrV9zVMzWhjo8Vv+Dz1HGIqsHC4/Odj3kU2pNuIM1UMnu90/LYAzoePdc5/nFpc+BEJQ3I3QU20STztV9Sfd1CVH1j+MzwKJUwm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtU+AN+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtU+AN+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B899C32782;
	Mon, 22 Apr 2024 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779147;
	bh=enf4hLbW4mh9iN4W7ArwQPvXY/1lTUsu4fFjM0qOo34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WtU+AN+kwqZg4IHRUpyhLcMdBcLO9QhyzSyZJTR0V/8nfg8EsJInqlpVRSpJgUvir
	 n4+fQsZO2OVaWDOajw5kAoC8nNYTo4HJaqAKeu1ftNHKolLqL1E06cMF4yHWTUnuIO
	 nvhNSIPbXrlsjV2N75Flo9UOSN8VWzuFVSzD+FIDgh3SF7N9X4mzJkw9ec/UTD0pBT
	 pQP4NZV389xj+nZuAN8G6rLrAEdbSQdGaoy2ClqC1izHpNcSB8/axGgM8SY5BbfhRJ
	 QqfEQFy5pPOXg3eLeKJem+BRltEYLlrBR/2NQ3EGixjF+RpBLLpYaIEPZYyqpHS4Wq
	 7f5b7LRBz2Qbg==
Message-ID: <52673f90-84c6-4e3d-9967-a3d0a7335c46@kernel.org>
Date: Mon, 22 Apr 2024 11:45:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Support nonblock for
 send_recv_data
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
 <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
 <12aab271-da72-49b4-ac91-2091b6889856@linux.dev>
 <bec7ade6bfc99f6340fa231cf68f0f4459625dbe.camel@kernel.org>
 <9475c2259b3d32774bc1488dd0d6004f7ddfbf13.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9475c2259b3d32774bc1488dd0d6004f7ddfbf13.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 22/04/2024 08:50, Geliang Tang wrote:
> On Thu, 2024-04-11 at 14:52 +0800, Geliang Tang wrote:
>> mptcp-only
>>
>> Hi Matt & Mat,
>>
>> On Wed, 2024-04-10 at 14:34 -0700, Martin KaFai Lau wrote:
>>> On 4/9/24 11:13 PM, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> Some tests, such as the MPTCP bpf tests, require send_recv_data
>>>> helper
>>>> to run in nonblock mode.
>>>>
>>>> This patch adds nonblock support for send_recv_data(). Check if
>>>> it
>>>> is
>>>> currently in nonblock mode, and if so, ignore EWOULDBLOCK to
>>>> continue
>>>> sending and receiving.
>>>>
>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>> ---
>>>>   tools/testing/selftests/bpf/network_helpers.c | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/network_helpers.c
>>>> b/tools/testing/selftests/bpf/network_helpers.c
>>>> index 137cd18ef3f2..ca16ef2b648e 100644
>>>> --- a/tools/testing/selftests/bpf/network_helpers.c
>>>> +++ b/tools/testing/selftests/bpf/network_helpers.c
>>>> @@ -555,6 +555,7 @@ struct send_recv_arg {
>>>>   static void *send_recv_server(void *arg)
>>>>   {
>>>>   	struct send_recv_arg *a = (struct send_recv_arg *)arg;
>>>> +	int flags = fcntl(a->fd, F_GETFL);
>>>>   	ssize_t nr_sent = 0, bytes = 0;
>>>>   	char batch[1500];
>>>>   	int err = 0, fd;
>>>> @@ -578,6 +579,8 @@ static void *send_recv_server(void *arg)
>>>>   		if (nr_sent == -1 && errno == EINTR)
>>>>   			continue;
>>>>   		if (nr_sent == -1) {
>>>> +			if (flags & O_NONBLOCK && errno ==
>>>> EWOULDBLOCK)
>>>
>>> I still don't see why it needs to be a non blocking IO. mptcp
>>> should
>>> work
>>> with blocking IO also, no? Does it really need non blocking IO to
>>> make
>>> mptcp test work? I would rather stay with blocking IO in selftest
>>> as
>>> much as
>>> possible for simplicity reason.
>>
>> I need some help here.
>>
>> This issue is reported by Matt in "CI: MPTCP BPF tests are now
>> validated", and my fixes ([1] and this patch) aren't accepted by
>> Martin. Is it normal to get EAGAINs in this case? Please give some
>> suggestions.

Thank you for the notification, I missed your previous question.

Regarding Martin's comment about O_NONBLOCK, I understand that with the
current BPF selftests -- so excluding the ones linked to the MPTCP
schedulers -- it is not needed to support O_NONBLOCK.

It looks like it is too early to do such modifications (patch 3), and
probably better to do MPTCP specific modifications only in our tree for
the moment. When upstreaming the new MPTCP BPF selftests, it will be
clearer for BPF maintainers what are our requirements, and such
modifications would make more sense, no?

> It fails in mptcp_sendmsg()
> 
> 1898 wait_for_memory:
> 1899                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> 1900                 __mptcp_push_pending(sk, msg->msg_flags);
> 1901                 ret = sk_stream_wait_memory(sk, &timeo);
> 1902                 if (ret)
> 1903                         goto do_error;
> 1904         }
> 
> sk_stream_wait_memory() fails in the case, and
> tcp_rtx_and_write_queues_empty(sk) is true.

My understanding is that with the current BPF selftests -- so excluding
the ones linked to the MPTCP schedulers here as well -- it looks
unlikely to have a EAGAIN errno, because only blocking IO is being used,
right?

I might be wrong, but with MPTCP schedulers, it is different: with
non-blocking IO, EAGAIN can be seen, and this case needs to be handled.
Actively waiting by retrying directly in the loop in case of EAGAIN is
not recommended, but probably OK for the tests (still, might be good to
add a comment to recommend polling instead). So here as well, such
modifications can stay in our tree for the moment.

Also, what is not clear to me is where we set the socket as the
non-blocking one. Is it only done for MPTCP servers/clients?

> I added a issue #487 to trace this issue.

Thanks!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

