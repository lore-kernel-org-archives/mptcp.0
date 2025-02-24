Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB971F4289
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392654; cv=none; b=qyQ3tm3fFQ0JFnN28EARf7sTlk0CZW6RteEB9hRkPaEwuQF0Bw6q0dSkbcMH3I8NrKekL2zvgAicxUvAUSVGMwExQbw3k/rWJP4tn+IAYu9fDmkFaeQCdQLoxCDJufJWoku430OwRQz5KjJJZT5vTK1txqOaS+H7FyUQih6Q0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392654; c=relaxed/simple;
	bh=ocGn8r+QjPnpuhaL6OKsUiq5kKfiWgRHr5wRi1g+gps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n5iwRoToDhWgVVFGNFhNjponBrqvs42XmYtYdYDRur8Jj/6g1XO8Nw7+ZyuLNWX8TnGzpFQnacGdI66LNuRxIeEORKzJY0kTtnwe4RDyVUsRHbl1Suk4mZP4l4oF7XYIWenZ9NC99jggs4jAo4oNUVqnQun/viCHqanGX/GjCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnYJTDXr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnYJTDXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE3DC4CED6;
	Mon, 24 Feb 2025 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740392653;
	bh=ocGn8r+QjPnpuhaL6OKsUiq5kKfiWgRHr5wRi1g+gps=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=mnYJTDXrZVy2YxXFtCC0Zwn49Ugi611n9knpw69NR96R4ltslGWb5Gmi9+2EUAVL6
	 JMhiX+KeXMRhVE6s3lwul+7dGzYLK0CNyonGusnaJlDiInrZkB9n2EqTj5dOmHCz3p
	 Y1lcnuwIVijT885egyhCdGPaBJ9wdRzrwYlxTFz0O6a08UPyO6RHPlw8708o9rSRQZ
	 nkWga1xixHHbFUuVxeRnUIN1YhPSlPjpGkkSc2o0KmidO92jy6dSKLTL+LiWzBmBo2
	 pnEYEltuo/S38832Wl4WhXhyKhNhMsXcqyuVhJ14tAwn1EWa2Sa72yh14zwJEhdHBz
	 3gk4HyybyRhLw==
Message-ID: <0341bdc3-0c94-4374-9f04-f841c7dacc03@kernel.org>
Date: Mon, 24 Feb 2025 11:24:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-next v5 4/9] mptcp: pm: define struct mptcp_pm_ops
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
 <5f83856741646b16dde9a741fcfbfa55753eee39.1740019794.git.tanggeliang@kylinos.cn>
 <b7333a19-921a-41e1-9a87-ff70aab3e000@kernel.org>
 <328be50889c11a6358d360d5454f8b7a6ed200b7.camel@kernel.org>
 <3cb661e0-47f9-4775-b15b-f9365208ff17@kernel.org>
 <022f884dd933fcbb6777d8de4e2aecc1a1a99199.camel@kernel.org>
Content-Language: en-GB
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <022f884dd933fcbb6777d8de4e2aecc1a1a99199.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 24/02/2025 10:11, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2025-02-24 at 09:26 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 24/02/2025 07:54, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thanks for the review.
>>>
>>> On Fri, 2025-02-21 at 18:23 +0100, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> On 20/02/2025 03:57, Geliang Tang wrote:
>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>
>>>>> In order to allow users to develop their own BPF-based path
>>>>> manager,
>>>>> this patch defines a struct ops "mptcp_pm_ops" for a userspace
>>>>> path
>>>>> manager, which contains a set of interfaces.
>>>>>
>>>>> Add a set of functions to register, unregister, find and
>>>>> validate a
>>>>> given struct ops.
>>>>>
>>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>>> ---
>>>>>  include/net/mptcp.h  | 29 ++++++++++++++++++++++
>>>>>  net/mptcp/pm.c       | 59
>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>  net/mptcp/protocol.h |  5 ++++
>>>>>  3 files changed, 93 insertions(+)
>>>>>
>>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>>> index a41d6c74760f..f51e75d3882d 100644
>>>>> --- a/include/net/mptcp.h
>>>>> +++ b/include/net/mptcp.h
>>>>> @@ -134,6 +134,35 @@ struct mptcp_pm_param {
>>>>>  	struct mptcp_addr_info		addr;
>>>>>  };
>>>>>  
>>>>> +struct mptcp_pm_ops {
>>>>> +	int (*created)(struct mptcp_sock *msk);
>>>>> +	int (*established)(struct mptcp_sock *msk);
>>>>> +	int (*closed)(struct mptcp_sock *msk);
>>>>> +	int (*address_announced)(struct mptcp_sock *msk,
>>>>> +				 struct mptcp_pm_param
>>>>> *param);
>>>>> +	int (*address_removed)(struct mptcp_sock *msk,
>>>>> +			       struct mptcp_pm_param *param);
>>>>> +	int (*subflow_established)(struct mptcp_sock *msk,
>>>>> +				   struct mptcp_pm_param
>>>>> *param);
>>>>> +	int (*subflow_closed)(struct mptcp_sock *msk,
>>>>> +			      struct mptcp_pm_param *param);
>>>>> +	int (*get_local_id)(struct mptcp_sock *msk,
>>>>> +			    struct mptcp_pm_param *param);
>>>>> +	bool (*get_priority)(struct mptcp_sock *msk,
>>>>> +			     struct mptcp_pm_param *param);
>>>>> +	int (*set_priority)(struct mptcp_sock *msk,
>>>>> +			    struct mptcp_pm_param *param);
>>>>> +	int (*listener_created)(struct mptcp_sock *msk);
>>>>> +	int (*listener_closed)(struct mptcp_sock *msk);
>>>>> +
>>>>> +	u8			type;
>>>>
>>>> I guess the type matches net.mptcp.pm_type sysctl knob, right?
>>>>
>>>> I wonder if we should not deprecate this sysctl, and use a string
>>>> like
>>>> with the scheduler. So instead, we could have:
>>>>
>>>>   char			name[MPTCP_PM_NAME_MAX];
>>>>
>>>> And on ctrl.c, we could map pm_type for the moment with a custom
>>>> proc_handler (and even remove this sysctl knob in a few
>>>> releases):
>>>>
>>>>  - 0  → in-kernel
>>>>  - 1  → userspace
>>>>  - >1 → bpf
>>>
>>> Do we need to restrict BPF path manager to only extend the
>>> userspace
>>> type path manager? That is, for all BPF path managers,
>>> mptcp_pm_is_userspace() returns true. If this is the case, there is
>>> no
>>> need to add "type" field in struct mptcp_pm_ops.
>>
>> To me, mptcp_pm_is_userspace() should no longer be needed, because
>> pm->ops will be used instead. So the "type" field should no longer be
> 
> Currently, the path manager must rely on mptcp_pm_is_userspace().
> mptcp_pm_is_userspace() is not needed for get_local_id() and
> get_priority(), but it's useful for address_announced(),
> address_removed(), subflow_created() and subflow_closed(). 

Yes but once all ops are implemented, it should be fine, no?

> Take address_announced() as an example:
> 
> For userspace pm, address_announced() is invoked in
> mptcp_pm_nl_announce_doit(), which is the handler of the command
> MPTCP_PM_CMD_ANNOUNCE [1].
> 
> While for in-kernel pm, address_announced() is invoked in
> mptcp_pm_nl_add_addr_doit(), which is the handler of the command
> MPTCP_PM_CMD_ADD_ADDR [2].
> 
> When we implement a BPF path manager, we must tell the PM core which
> path to use to call its address_announced() interface. So I added
> "type" in struct mptcp_pm_ops, and each path manager needs to set it to
> tell the PM core whether it is a userspace type path manager, and check
> this type in mptcp_pm_is_userspace().

I think there is a bit of confusion here: address_announced() will be
called when the other peer has announced an address. In other words,
when an ADD_ADDR is received, pm->ops->address_announced() will be
called from mptcp_pm_add_addr_received(), replacing:

  if (mptcp_pm_is_userspace(msk)) {
     (...)
  } else (...) {
     (...)
  }

address_announced() could then either:
- return a boolean: handled or drop → the PM will be in charged of
sending the ADD_ADDR echo.

- Or, if it is easier for the BPF PM, an enum could be returned, and in
pm.c, the kernel will either:
  - send add addr echo
  - drop
  - do nothing (the in-kernel PM would schedule the PM worker)

WDYT?

Similar for address_removed(), subflow_created() and subflow_closed().
If I'm not mistaken, the userspace PM does nothing here, because that's
the userspace daemon to react with the events that will be sent.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


