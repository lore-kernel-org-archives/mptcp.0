Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297855E77
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im+YXVCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29486C433C8;
	Thu, 21 Dec 2023 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179547;
	bh=bCj6CAyExMsRc7Cy4rBcJ5++svpXM5+chgBm50Snbmo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=im+YXVCcdJJg4q0XhEAieHuxLK1Ml1ko/Jt6PDTAMfnl3xSntMKKPtKMjlcNLLSY9
	 orAE3+v/DyKLI9HAVESKULQbiabgCWLQRjGlUm9p5ENfw6o7zsy3L1m6aUtwJ9kpI9
	 vhEJ3fCMrN6g6oKxd9WkKc2Knm5gJ/v8Hl/yTf1jdf4xtVV+V0AU4lCtMlYn+3RLXl
	 ZEHgS9AeeP8RwsSA9pf88oz2dveyVtVmEyNpCnwoqISKfHv+ctm37R31Mnb/PBFDz7
	 4jTDFgaf9apoCeuFulBgqdrl528HM2krgI2R3uK2bR8U5rAih710XRz57QiMEUY4Ww
	 MDDGyWHvaD1Kw==
Date: Thu, 21 Dec 2023 09:25:46 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: prevent tcp diag from closing listener
 subflows
In-Reply-To: <fcbef549bf392f4da466e1c8d56399d1e8fdf6c2.camel@redhat.com>
Message-ID: <9871aa1d-4058-80ae-0bed-2d0cf9e915e5@kernel.org>
References: <f6371f65b1ebabc0f308528494ec39c9bdf786fd.1702631517.git.pabeni@redhat.com> <f8f6d53f-4fcb-2531-4fa6-b0afbeb0eabc@kernel.org> <fcbef549bf392f4da466e1c8d56399d1e8fdf6c2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 21 Dec 2023, Paolo Abeni wrote:

> On Fri, 2023-12-15 at 16:47 -0800, Mat Martineau wrote:
>> On Fri, 15 Dec 2023, Paolo Abeni wrote:
>>
>>> The MPTCP protocol does not expect that any other entity could change
>>> the first subflow status when such socket is listening.
>>> Unfortunately the TCP diag interface allows aborting any TCP socket,
>>> including MPTCP listeners subflows. As reported by syzbot, that trigger
>>> a WARN() and could lead to later bigger trouble.
>>>
>>> The MPTCP protocol needs to do some MPTCP-level cleanup actions to
>>> properly shutdown the listener. To keep the fix simple, prevent
>>> entirely the diag interface from stopping such listeners.
>>>
>>> We could refine the diag callback in a later, larger patch targeting
>>> net-next.
>>>
>>> Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")
>>> Closes: https://lore.kernel.org/netdev/0000000000004f4579060c68431b@google.com/
>>> Reported-by: syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/subflow.c | 13 +++++++++++++
>>> 1 file changed, 13 insertions(+)
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 64302a1ac306..1f98bec264a6 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -1981,6 +1981,17 @@ static void tcp_release_cb_override(struct sock *ssk)
>>> 	tcp_release_cb(ssk);
>>> }
>>>
>>> +static int tcp_abort_override(struct sock *ssk, int err)
>>> +{
>>> +	/* closing a listener subflow requires a great deal of care.
>>> +	 * keep it simple and just prevent such operation
>>> +	 */
>>> +	if (inet_sk_state_load(ssk) == TCP_LISTEN)
>>> +		return -EINVAL;
>>> +
>>> +	return tcp_abort(ssk, err);
>>
>> Hi Paolo -
>>
>> I looked around the code to see if there might be issues with an
>> unexpected tcp_abort on non-listening subflow sockets. Closest code I
>> found was mptcp_subflow_reset(), and the main difference seems to be
>> giving the msk a chance to clean up:
>>
>>  	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))
>>  		mptcp_schedule_work(sk);
>>
>> Worthwhile to add that in this override function?
>
> Reporting there the discussion from the last mtg for completeness.
> Async closing of mptcp listener via the worker has proven to be quite
> complex and bug prone. In this case it would probably be safe, but
> given the troubled git history of mptcp_check_listen_stop(), I would
> keep this version for net, and do the complete thing for net-next, with
> no rush.
>

Thanks Paolo, sounds like a good plan.

Reviewed-by: Mat Martineau <martineau@kernel.org>
