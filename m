Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C278801
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 15:03:57 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so25371036wmq.2
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680793435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o24s/xk+kJ8vlQNQaO0TJWx+r1azYVuqOKxQgPZY6N0=;
        b=8gYEHGzu9jRjhXelqeiTkkIt9+0jm9Riuq0xBBWIhg+UIM4vJJUiQGyDhuRj1vvhZ4
         H1e7pwXFfHaewaHAprA1N5wGk/lZGkNO89Sl+PDoNivlHdlqo1s0EodojhHy7CjceTaz
         8oULfQb+jlgvzZs6qRSx+GqMkbx8A9pcV5pjW5S8N+YjvfTtiN5JVzI5v3zaEbNYuaHW
         Tv/mHgoQPnn/e7gKZCG52lOSw3h8VoYIWgMttkmJIZPMo6h5wuKrBPNt54Tp2pM9wfMc
         rDixCxRz9kdogfclNs5eHCNrkyLMM8xDS4BmfEkSfc1UaHLwSh1uyl8MYPGHl/ZEA/57
         maSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o24s/xk+kJ8vlQNQaO0TJWx+r1azYVuqOKxQgPZY6N0=;
        b=xux5Fj3jcHq1m6RJcgDylLrUEcm84GImvpxz5HrBhTXfNros/OLPPr5LOhVrVC9wo5
         J5exoP02VE2n77ygT7rH7N/+H214941MD7FJ/iFXZXOBeOq5btgLjEcH+dU75DNKrx1y
         KmEyRiVDs1QN1Y7rJH08vTxAAFMQ1sTRKuOxzFHjMuBApSKf011uMoK+p9UHPSqA0jDd
         UsENIqNs6r2f4H5YPQg89Vje8EQjNU67FxjJWcsXyE+PuypS1UDSTts8PXbDSOlWZoNq
         mH0W7GjXM3uOfzc6DwpYCJOpk6AJYZPJtS+vgfN1r4UAf+8p5d+VNmYu6N0i+7FakH6J
         yi9A==
X-Gm-Message-State: AAQBX9dLYwjdZiE5tODO99nN/Zp1MJiLpwYdcvhEu8pgIWDSzNr3UQv0
	19elKw1wQEbaI9F8RxX8qgHGLBcpWY6Xqh0EMmtcSQ==
X-Google-Smtp-Source: AKy350ZNbkeN2vthtcAkMzak8vzE2HF6QZANxPvtHWb9KUInYi526DpqC/qpUbHE4oUSXDcUDRwpQA==
X-Received: by 2002:a1c:ed17:0:b0:3f0:7147:2ecd with SMTP id l23-20020a1ced17000000b003f071472ecdmr1518028wmh.7.1680793435362;
        Thu, 06 Apr 2023 08:03:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:96d8:3be1:720d:ea61? ([2a02:578:8593:1200:96d8:3be1:720d:ea61])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bce13000000b003edcc2223c6sm1846502wmc.28.2023.04.06.08.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 08:03:55 -0700 (PDT)
Message-ID: <a8ff9884-401a-2e04-4a43-962249ba50ad@tessares.net>
Date: Thu, 6 Apr 2023 17:03:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-net 1/2] Squash-to: "mptcp: fix accept vs worker
 race"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <cover.1680733942.git.pabeni@redhat.com>
 <a515310923cd2ac4610ce62aa48b21d6d36a19eb.1680733942.git.pabeni@redhat.com>
 <48cbe7f3-8569-beec-b207-a111e6ff4922@tessares.net>
 <fdb18f114463095b71ba30349a4105e604d12afe.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fdb18f114463095b71ba30349a4105e604d12afe.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/04/2023 15:56, Paolo Abeni wrote:
> On Thu, 2023-04-06 at 11:19 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> Thank you for the patch!
>>
>> It looks good to me but I just have some questions if you don't mind,
>> just to be sure I understood the modifications.
>>
>> On 06/04/2023 00:47, Paolo Abeni wrote:
>>> 2 separate fixes needed for the mentioned patch
>>>
>>> On some exceptional scenarios (e.g. listener socket disconnecting while
>>> the subflow is created) a newly created MPC is deleted by the TCP stack
>>> via inet_child_forget(). When that happen we leak the subflow context
>>> and the msk.
>>>
>>> Address the issue explicitly detecting such scenario and forcing a full
>>> msk shutdown.
>>>
>>> mptcp_subflow_drop_ctx() does not remove the subflow from the msk list,
>>> racing msk lookup done by the NL PM could fetch the msk just before
>>> deletion, and try to free again the subflow.
>>>
>>> Just explicitly remove the subflow from said list.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/protocol.c | 13 +++++++++++--
>>>  net/mptcp/subflow.c  |  1 +
>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 0e4961e87b48..76c1814c0b19 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2378,9 +2378,18 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>>  	 * to deliver the msk to user-space.
>>>  	 * Do nothing at the moment and take action at accept and/or listener
>>>  	 * shutdown.
>>> +	 * If instead such subflow has been destroyed, e.g. by inet_child_forget
>>> +	 * do the kill
>>>  	 */
>>> -	if (msk->in_accept_queue && msk->first == ssk)
>>> -		return;
>>> +	if (msk->in_accept_queue && msk->first == ssk) {
>>> +		if (!sock_flag(ssk, SOCK_DEAD))
>>> +			return;
>>> +
>>> +		/* ensure later check in mptcp_worker will dispose the msk */
>>> +		sock_set_flag(sk, SOCK_DEAD);
>>
>> Is it OK to mark the msk as dead and continue below? I guess yes because
>> there will not be any data to re-inject anyway?
> 
> We don't process any data here (the msk is unaccepted at this point).
> Looks safe/sane to me. Overall this is the MPTCP equivalent of
> inet_child_forget()

Thank you for the confirmation!

>>> +		inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32 -
>>> +							  TCP_TIMEWAIT_LEN -1;
>>
>> Changing the timestamp looks like an ugly hack :)
>>
>> But I guess it is needed not to wait for nothing and there is no clearer
>> way? Or move this logic to the worker?
> 
> I can add another flag inside the msk. I did not do that here to keep
> the patch small, but no objection on my side to clean this path - the
> important thing is let syzkaller crunch this ;)

It might be cleaner yes. But this can be done later, better not to block
the validation. I'm going to apply the two patches and if needed, I can
modify the commit message/content later.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
