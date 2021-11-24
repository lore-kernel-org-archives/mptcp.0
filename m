Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2D2C82
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 12:23:56 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id v1so9612882edx.2
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 04:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jKe5JRUg+NXquqEWUn6yAiUJxGQtiLquJHEwiyrF99c=;
        b=6aFSmBPMA9sSZRR882m4GMGVFAUoM5ng7GtHnm9JRQHVu0t/MWFy1VFAUAAWgt/u9K
         FgGQ+q7bNanaoUrRottL1ufhIR2dyV4nJ+rneuNqr+RF74immkQFJUv19nLvNV7P53RY
         DMnZ7UbI5A36WfGL/P8JOuBJqNIHxVIm2JbIvR31/RsG4XyiKUVbQxXkUUdZd1fdIrKo
         cZN0oEvLZA1amcz2KA8tZLWHGfH25n0rpIKBkhxckYcrPQxhnZiCT0PybMhRbDfUVfEZ
         hMnICVkVydMBMjHTYmT9EiAAeCyCLWR5hZ9bvy+MlFhvNm9V+UfpDq24nSG7zyoFtpIX
         C4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jKe5JRUg+NXquqEWUn6yAiUJxGQtiLquJHEwiyrF99c=;
        b=as9Cf+MkggiqKcgI+ZjMApPwgACFFCUsgJkGfrtT7ELYHVs5DSqzDlJ5yqTM5BtiKw
         bJ5Uc4ZEX4ri67BjunhKl+07gQdI8CJMpAfGcjiYHhDz0Zgsq7IyiSET/YRbqKIr0YoY
         7D69Bq2R93PmR/d7CGFX6j5B9udiK0QPF3URFIqweJx+TEhrHCSOqGax/mo2DxRVCpFo
         tqn8AQGysMKK4Xp5Dfkc+JP+qranFDqdB3nuKB/AO5UtwxZr9sst+Cocl1iks7VZtCMN
         rThjUUZFbd4xnFxFMDjGOFCIlnN+T61H69LFt6/+bUC6VBjJYdgO5MCz8w4k7vUqQEf1
         BMkA==
X-Gm-Message-State: AOAM5312Aiu/NycHw0f0DlrOqfGq4s9AhREZniQ2J2jzlUvDh2IkSmcg
	oCdgyN0yCJ/+FncOE3QHjh701Q==
X-Google-Smtp-Source: ABdhPJxyFK7KeGQu4UB9Xj2aBag10aUeRVcpArVpAyc59A+pZdwjyTdreXaVs8GBS07IjYisiDW11g==
X-Received: by 2002:a05:6402:8:: with SMTP id d8mr25294588edu.61.1637756634874;
        Wed, 24 Nov 2021 04:23:54 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id sb19sm7027962ejc.120.2021.11.24.04.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 04:23:53 -0800 (PST)
Message-ID: <a715c06d-ed74-8f89-7b5b-eed734efff95@tessares.net>
Date: Wed, 24 Nov 2021 13:23:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 2/3] mptcp: do not block subflows creation on
 errors
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: Phil Greenland <phil@quantulum.co.uk>, mptcp@lists.linux.dev
References: <cover.1637684792.git.pabeni@redhat.com>
 <c080cc1785cbe3bb3c049a683f2cc6d55f95f17a.1637684792.git.pabeni@redhat.com>
 <39669a68-eb6f-6602-1469-886266346e48@tessares.net>
 <d6eb410eafef719adefb61bb584eef1e40c01184.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d6eb410eafef719adefb61bb584eef1e40c01184.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2021 11:09, Paolo Abeni wrote:
> On Wed, 2021-11-24 at 10:55 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 23/11/2021 17:37, Paolo Abeni wrote:
>>> If the MPTCP configuration allows for multiple subflows
>>> creation, and the first additional subflows never reach
>>> the fully established status - e.g. due to packets drop or
>>> reset - the in kernel path manager do not move to the
>>> next subflow.
>>
>> Thank you for looking at that!
>>
>> Why the PM could not try to establish all possible paths "in parallel"?
>> Is it because we have this limit of allowed subflows and we wait to know
>> if a path is established to count it as used subflow?
> 
> IIRC, that design choice is to avoid that an MPTCP endpoint could
> easily become a DDoS bot, generating "a lot" of syn in response to
> action from possibly untrusted peer.

The endpoint will only be able to produce a very few SYN+MPJ depending
on the limit that is in place.

Should we maybe do a distinction between local addresses and remote
ones? I mean when the MPTCP connection is established, the PM could open
all paths using different local addresses and then the remote ones one
at a time?
>>> +				/* we are not established yet and "a lot" of time passed
>>> +				 * e.g. due to syn retranmissions. We can attempt next
>>> +				 * subflow creation
>>
>> That's strange to tell the PM "yes, the subflow is established now"
>> while there is potentially (or clearly in case of error (RST) below) an
>> issue :)
>>
>> Should we eventually have another function name doing the same and
>> resetting the stamp variable?
> 
> Yes, in v2 I'll add another pm helper for that.

Thank you!

> Side note: do we still need the pm -> pm_netlink additional layering?
> That was initially introduced to allow multiple in-kernel PM, but
> afaics we are now considering a single in kernel one and e.v. an user-
> space one. Perhpas we can remove some intermediate abstraction?

I think we should keep it. It still makes sense to have a PM controlled
with eBPF for servers having to support a lot of connections and always
doing the same action. Maybe the in-kernel PM can already cover all use
cases for a server, mainly announcing addresses. Or maybe more might be
needed, e.g. announcing an IP or another depending on the initial one,
etc. and in this case, a controlled with eBPF would be interesting (but
could be done as an extension of the in-kernel PM one?)

> (not in this series!)

Of course!

>>> +				 */
>>> +				mptcp_pm_subflow_established(mptcp_sk(subflow->conn));
>>> +				subflow->start_stamp = 0;
>>> +			}
>>> +		}
>>> +
>>>  		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
>>>  			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
>>>  					      TCPOLEN_MPTCP_MPJ_SYN,
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 0f90bd61de01..85986f3b58ed 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -1273,7 +1273,16 @@ void __mptcp_error_report(struct sock *sk)
>>>  
>>>  static void subflow_error_report(struct sock *ssk)
>>>  {
>>> -	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
>>> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>>> +	struct sock *sk = subflow->conn;
>>> +
>>> +	/* subflow aborted before reaching the fully_established status
>>> +	 * attempt the creation of the next subflow
>>> +	 */
>>> +	if (unlikely(!subflow->fully_established && subflow->start_stamp)) {
>>> +		mptcp_pm_subflow_established(mptcp_sk(sk));
>>> +		subflow->start_stamp = 0;
>>
>> Detail: do you need to set it to 0 here?
> 
> So we call mptcp_pm_subflow_established() at most once due to subflow
> timeout or reset. I feared a malicius peer could trigger a lot of
> activity with a e.g. a burst of icmp unreachable.

Good point, thank you for your reply. I thought subflow_error_report()
would be called only once per ssk but then yes, safer to add this check.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
