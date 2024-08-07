Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B4132117
	for <mptcp@lists.linux.dev>; Wed,  7 Aug 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045044; cv=none; b=rcLHM/t7Z9ZFf+0PNKhSpYeXtiYE9WwUH4YiGuapjZMnR3UpsvQvUjMe65ZICHSIBZ3CvXE1/r1g8LYWJFF95cfWekFG4BA5v8EqcefOLGi3E1DIHLxYF788BZ71bEc89PBwsMhiTS3jGBUBKbEBcuWX2ioFFL7c9IpCx1H7g7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045044; c=relaxed/simple;
	bh=4/MBYz8aOkntdh5ffhF6qhjHsBVZbykKdu3XilgGLbM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vdgi9mvexILbfpGz7z5MEvdE8TIUCZfZfG5RYaEMy+xIrApkCxpjwyp55rLmue63jVfLZAO1HQfxmIksnplDv74CPJ+0qkP87tXq12OvwqEQvFYCg8LzpelRP3Go4+sQHdl3l5o35AEgjsaX+lG0Cgh+GmAlPsGwgxvWfstPuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKy18n0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKy18n0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065E8C32781;
	Wed,  7 Aug 2024 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723045044;
	bh=4/MBYz8aOkntdh5ffhF6qhjHsBVZbykKdu3XilgGLbM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HKy18n0cPz/e5npeq9Xcm85LeCncZvM8O8uxljxYVrVls40SQW+vbi3ERnKrML9kH
	 ukGWbdcr9++ZHjjno6FR2WMPPnIUGRYyAf4Da2puB6M16+5iKw9t7VB6CqOWH9hoeT
	 yP4lXdx9wylVoAZpbKUEtehqXDuaYOnU79BwASMFhQZTrVPwa5jsowJWQpu9BR9qNn
	 Tit/S82Dr1avmf3CH39mQV7qOopT7dLpwSL+pjZF4ArGDZ+PxIBKDYLciXRKWuKZ2Z
	 5SGUszFv/ULkN5ZOEysfQmg9PSgaS6MlDr+lAq7W0oWsp3WW+IptgQN+uqjGtNZmM8
	 6XzVdTaiZGoGw==
Date: Wed, 7 Aug 2024 08:37:23 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v6 05/11] mptcp: pm: send ACK on an active
 subflow
In-Reply-To: <5e7b7057-8c01-491c-8b0e-39a3035657f7@kernel.org>
Message-ID: <bc714a2a-d39f-62c7-6eed-603c06ae5e1b@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org> <20240802-mptcp-pm-avail-v6-5-964ba9ce279f@kernel.org> <e3368a02-2083-b0b2-54c4-3a9662c0d80f@kernel.org> <5e7b7057-8c01-491c-8b0e-39a3035657f7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1689758377-1723045044=:35443"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1689758377-1723045044=:35443
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 7 Aug 2024, Matthieu Baerts wrote:

> Hi Mat,
>
> Thank you for the review!
>
> On 07/08/2024 00:29, Mat Martineau wrote:
>> On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:
>>
>>> Taking the first one on the list doesn't work in some cases, e.g. if the
>>> initial subflow is being removed. Pick another one instead of not
>>> sending anything.
>>>
>>> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> Notes:
>>>  - We could also check if the subflow is not "staled", but probably
>>>    best to do that for net-next only.
>>> ---
>>> net/mptcp/pm_netlink.c | 9 ++++++---
>>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 4000de54c99c..e25cda3909fa 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -768,9 +768,12 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock
>>> *msk)
>>>         !mptcp_pm_should_rm_signal(msk))
>>>         return;
>>>
>>> -    subflow = list_first_entry_or_null(&msk->conn_list,
>>> typeof(*subflow), node);
>>> -    if (subflow)
>>> -        mptcp_pm_send_ack(msk, subflow, false, false);
>>> +    mptcp_for_each_subflow(msk, subflow) {
>>> +        if (__mptcp_subflow_active(subflow)) {
>>> +            mptcp_pm_send_ack(msk, subflow, false, false);
>>> +            break;
>>> +        }
>>> +    }
>>
>> Hi Matthieu -
>>
>> If all subflows are stale, it should still try to send on one (falling
>> back to the original first entry seems as good as anything else?)
>
> Yes, good point, probably something I should do in patch 11/11.
>
> But here, 'stale' is not checked. Probably the __mptcp_subflow_active()
> helper doesn't have a good name. It is only checking the state (fully
> established, and not closed):
>

I think I looked at mptcp_subflow_active() and saw the stale check there - 
sorry about that. This check should be fine as it is.

- Mat

>
>> static inline bool __tcp_can_send(const struct sock *ssk)
>> {
>> 	/* only send if our side has not closed yet */
>> 	return ((1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
>> }
>>
>> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>> {
>> 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
>> 	if (subflow->request_join && !subflow->fully_established)
>> 		return false;
>>
>> 	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
>> }
>
>
> If __mptcp_subflow_active() returns 'false', we cannot send the
> ADD_ADDR. So I think we are good like that, no?
>
> We can drop the patch 11/11 for the moment.
>
>>
>> - Mat
>>
>>> }
>>>
>>> int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>>
>>> --
??>> 2.45.2
>>>
>>>
>
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
>
>
>
--0-1689758377-1723045044=:35443--
