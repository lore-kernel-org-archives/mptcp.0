Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA9372B58
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179263; cv=none; b=QnvRTtmzkX4shhvSl2fxjvc3xrcZNxP7lMi8k+2aq2YXviOJYyBhsGKz8g40godQn8liZ9TeFn7L2WwU7CBZWPkT40qhZfUu3b/TqYBkVCGf/QvTyaGza2GZsdh+zL/137gTQLd6RH4JPqDumar/kmKzJqnrs6Kg4QJPcD5s0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179263; c=relaxed/simple;
	bh=BJjZbH0aXn0u8NAFLSjMrPy6+uycEk1vK/71WKeknYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRczsH3OZWpQ0SuZHcQre2Fln5VKwkcAXmop4BhXePxvOX5aM3J1i0M2iSJfVGqXgDJW5vKYPJEEayoBCOYSl4LQJHMtrQV3lpjSgSMFCBmZTMKbU30YfLRu0RyRGD7gDL3Y/GblJP1T1LYON1tlpuVJCyrXHLm1b7/T7cJ+SsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jx45MKXw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx45MKXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D812C2BCB8;
	Thu,  7 May 2026 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778179263;
	bh=BJjZbH0aXn0u8NAFLSjMrPy6+uycEk1vK/71WKeknYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jx45MKXwt+ZltaI9xSlJWncupgDqDoem+PgW/InYVhQIwhoaZhAKIsYzNg/8ur8hh
	 faTpACO4RxpaQdHrIRSAscOKgI8q+tAYdHBm+JzWV3c5Io2QBiv3Glc6KJtvOU0hbz
	 DQfNnKU2QJ6RFnvH9sMHHPTOVpGPRQaM8E8+quvv5KtQVZ79+2yMhM/qFaKFVK2Htj
	 Hddvu5Z8jYNPePyyn3xLsRcDbhOyAZZ177eyk1bNuAg01qic/x+x7alqBV2/l7gZCa
	 NUdaqRrxxJQmJ265RsEtbfCS7ERfCNb0SxtU24RXl/VZ15c/03xsZWA6OvWRBAFzTT
	 V6fuaG935iA+g==
Message-ID: <64c2fc6a-5e42-45fb-8ca5-857f177ca7ba@kernel.org>
Date: Thu, 7 May 2026 20:40:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when cloning
 reqsk
Content-Language: fr
To: Yuan Tan <yuantan098@gmail.com>
Cc: caoruide123@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, mptcp@lists.linux.dev,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, enjou1224z@gmail.com,
 bird@lzu.edu.cn
References: <cover.1776149210.git.caoruide123@gmail.com>
 <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
 <5f06a4e8-0b49-4119-94f9-3a8a1e430e0d@kernel.org>
 <CAAVpQUDzh-dGsQpBCZjN3rUsoDc2QjzWh-o5yVWoBWDQNXbjmQ@mail.gmail.com>
 <05a19f8d-360e-41d1-bc8a-0b4caab3d354@gmail.com>
 <027acbe6-ccef-4c4d-8b85-927044326150@kernel.org>
 <CAPuPA7K8Dqsoy7W4ow+c=gpPEKEbEiLErym2mxCyY6bJFO9G-A@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAPuPA7K8Dqsoy7W4ow+c=gpPEKEbEiLErym2mxCyY6bJFO9G-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yuan,

On 07/05/2026 20:23, Yuan Tan wrote:
> On Thu, May 7, 2026 at 1:07 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Yuan, Ren, Ruide,
>>
>> (-netdev list)
>>
>> On 19/04/2026 11:51, Yuan Tan wrote:
>>>
>>> On 4/16/2026 11:48 AM, Kuniyuki Iwashima wrote:
>>>> On Thu, Apr 16, 2026 at 10:45 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>> Hi Ren,
>>>>>
>>>>> On 15/04/2026 11:31, Ren Wei wrote:
>>>>>> From: Ruide Cao <caoruide123@gmail.com>
>>>>>>
>>>>>> TCP request migration clones pending request sockets with
>>>>>> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
>>>>>> subflow_req->msk, but the cloned request does not take a new reference.
>>>>>>
>>>>>> Both the original and the cloned request can later drop the same msk in
>>>>>> subflow_req_destructor(), and a migrated request may keep a dangling msk
>>>>>> pointer after the original owner has already been released.
>>>>>>
>>>>>> Add a request_sock clone callback and let MPTCP grab a reference for cloned
>>>>>> subflow requests that carry an msk. This keeps ownership balanced across
>>>>>> both successful migrations and failed clone/insert paths without changing
>>>>>> other protocols.
>>>>> Thank you for this patch!
>>>>>
>>>>> Indeed, it looks like this path has not been covered by the MPTCP test
>>>>> suite so far.
>>>>>
>>>>> By chance, do you have any simpler reproducer using packetdrill? (the
>>>>> MPTCP fork)
>>>>>
>>>>>   https://github.com/multipath-tcp/packetdrill
>>>>>
>>>>> Also, I see Sashiko is pointing to a potential issue with MP_CAPABLE and
>>>>> the token, also only visible with net.ipv4.tcp_migrate_req=1:
>>>>>
>>>>> https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
>>>>>
>>>>> Are you also looking at that?
>>>>>
>>>>>> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
>>>>>> Cc: stable@kernel.org
>>>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>>>>> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
>>>>>> Tested-by: Ren Wei <enjou1224z@gmail.com>
>>>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>>>>> ---
>>>>>>  include/net/request_sock.h      |  2 ++
>>>>>>  net/ipv4/inet_connection_sock.c |  3 +++
>>>>>>  net/mptcp/subflow.c             | 13 +++++++++++++
>>>>>>  3 files changed, 18 insertions(+)
>>>>>>
>>>>>> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
>>>>>> index 5a9c826a7092..560e464c400f 100644
>>>>>> --- a/include/net/request_sock.h
>>>>>> +++ b/include/net/request_sock.h
>>>>>> @@ -36,6 +36,8 @@ struct request_sock_ops {
>>>>>>                                     struct sk_buff *skb,
>>>>>>                                     enum sk_rst_reason reason);
>>>>>>       void            (*destructor)(struct request_sock *req);
>>>>>> +     void            (*init_clone)(const struct request_sock *req,
>>>>>> +                                   struct request_sock *new_req);
>>>>> @TCP/INET maintainers: are you OK with this new function pointer?
>>>>>
>>>>> Currently, MPTCP is the only user, and "req" is not used, see below.
>>>>>
>>>>>>  };
>>>>>>
>>>>>>  struct saved_syn {
>>>>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>>>>>> index e961936b6be7..140a9e96ad58 100644
>>>>>> --- a/net/ipv4/inet_connection_sock.c
>>>>>> +++ b/net/ipv4/inet_connection_sock.c
>>>>>> @@ -954,6 +954,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>>>>>>       if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
>>>>>>               rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
>>>>> (Maybe TCP with fastopen could be this other user to call
>>>>> rcu_assign_pointer()? (net-next material))
>>>>>
>>>>>> +     if (req->rsk_ops->init_clone)
>>>>>> +             req->rsk_ops->init_clone(req, nreq);
>>>> I think a simple direct call is better.
>>>>
>>>> #ifdef CONFIG_MPTCP
>>>>     if (tcp_rsk(req)->is_mptcp)
>>>>         mptcp_reqsk_clone(nreq);
>>>> #endif
>>>>
>>>  Thank you very much for your suggestion. We will use this approach in
>>> the next version of the patch. Would you like us to add your
>>> Suggested-by tag?
>> For a question of organisation, do you still plan to send a v2
>> addressing the review comments?
>>
>> Cheers,
>> Matt
>> --
>> Sponsored by the NGI0 Core fund.
>>
> 
> Sorry for the delay. Please forgive us that we are all working on the
> patches part-time :)

No problem. This patch is not urgent, but because you originally cced
the security ML, it's adding a bit more pressure to release a fix "quickly".

> Ruide will send v2 this weekend.

Sounds good to me!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

