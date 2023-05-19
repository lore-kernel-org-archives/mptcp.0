Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3386121
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 09:18:06 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96b0235c10bso556007266b.3
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684487884; x=1687079884;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHpClB2D96j86rC4sAIVD1/RSvhTN4J4Dz54hI5AHtY=;
        b=ZrjNJCP8os4A+xtmqi93B39hcFR4T9oTmiYJSzogbz0sQ6dcgfT5llIcmOwizRsHUU
         Nj3MqcSDVgw8MVz9ecu1CCwIzgWx4n8DvT+S14tF/f1zpdm/NHdTwyVI5PTENQh7wI/h
         w/68fPItw8FsRibUDCyH6FJ+JhJLawnOHPB9RYuzU3mTpsw6CZiVkz4vxUe1+yHrcjho
         NmHOddlsMouwcxBaeQhqARCWd3kOo419m7AQBuoOYffAjwjknrG7X4PMB2wb0gfFiIU2
         sMu4zv5Nb7rjJzUwIDUu5jqvJ9i3c63RxtAImJGpPFHGF3I940dOJrYlu+UP7U3b8mgB
         IOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684487884; x=1687079884;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHpClB2D96j86rC4sAIVD1/RSvhTN4J4Dz54hI5AHtY=;
        b=LxuuOJoFGMlS09fZvZG7aamOmRnGYzc3AYa+0C55n0M0idVGEfXcN/LpoV+oey46p5
         prAAT01gSvKCjYufXEs2Gs5dflx6lZ8SaEjvRBZH662GY2jm7JQh7Qjaf8wEde0sQ0C6
         VZiXHWxaT//v4o+Td8BJCYH338tIW1dt9BZd846K+n72hX7jJNHVhKKj0guvKjQ+lxsm
         PLE8E+rCPQaxY7oWb6uPvQScr1ojr5T8GrtRF87EnGUB0Rihm8sSyN5GvfGpNthrCehS
         S42phKD4F7bMKfn/Wo0CiAA4+6Q7WZ34NvA5WLNSN5HYfcHvO0snECBvvA99TAW0phfh
         9XGQ==
X-Gm-Message-State: AC+VfDyunmP4rZ3YvuE6HzZiFHUoOsfYi7X61u8Rtn/XWvFXewTStsMJ
	I5codnKYhgjPHqYsyPJC2uazKg==
X-Google-Smtp-Source: ACHHUZ5uZpVgfCQzgXk7jcjElKX+nB5+/0X/hhwyj3JzF7bP0rfzkcO6hTewKfKA9fUw741/dokipg==
X-Received: by 2002:a17:906:8893:b0:95e:de94:5bea with SMTP id ak19-20020a170906889300b0095ede945beamr827345ejc.56.1684487884559;
        Fri, 19 May 2023 02:18:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id rp20-20020a170906d97400b0096f641c6167sm618771ejb.181.2023.05.19.02.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 02:18:04 -0700 (PDT)
Message-ID: <86d7657d-ca83-1703-57f7-7d0a38db333a@tessares.net>
Date: Fri, 19 May 2023 11:18:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 3/4] mptcp: track some aggregate data counters.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1683212362.git.pabeni@redhat.com>
 <df47acfb7e35b28e3eb4f591f182c383bc2076d7.1683212362.git.pabeni@redhat.com>
 <9962f754-1d08-4982-e55e-63e25a7c365b@tessares.net>
 <b414faa5313b041cf68b4a0d98eb4b2ee16f93ee.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b414faa5313b041cf68b4a0d98eb4b2ee16f93ee.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 18/05/2023 16:17, Paolo Abeni wrote:
> On Wed, 2023-05-17 at 16:26 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 04/05/2023 18:40, Paolo Abeni wrote:
>>> Currently there are no data transfer counters accounting for all
>>> the subflows used by a given MPTCP socket. The user-space can compute
>>> such figures aggregating the subflow info, but that is inaccurate
>>> if any subflow is closed before the MPTCP socket itself.
>>>
>>> Add the new counters in the MPTCP socket itself and expose them
>>> via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
>>> acquire the relevant locks before fetching the msk data, to ensure
>>> better data consistency
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> (...)
>>
>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>> index d2aa02e28917..2265387a5db2 100644
>>> --- a/net/mptcp/sockopt.c
>>> +++ b/net/mptcp/sockopt.c
>>> @@ -888,7 +888,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>>>  
>>>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>>>  {
>>> +	struct sock *sk = (struct sock *)msk;
>>>  	u32 flags = 0;
>>> +	bool slow;
>>>  
>>>  	memset(info, 0, sizeof(*info));
>>>  
>>> @@ -914,11 +916,21 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>>>  	if (READ_ONCE(msk->can_ack))
>>>  		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
>>>  	info->mptcpi_flags = flags;
>>> -	info->mptcpi_token = READ_ONCE(msk->token);
>>> -	info->mptcpi_write_seq = READ_ONCE(msk->write_seq);
>>> -	info->mptcpi_snd_una = READ_ONCE(msk->snd_una);
>>> -	info->mptcpi_rcv_nxt = READ_ONCE(msk->ack_seq);
>>> -	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
>>> +	mptcp_data_lock(sk);
>>> +	info->mptcpi_snd_una = msk->snd_una;
>>> +	info->mptcpi_rcv_nxt = msk->ack_seq;
>>> +	info->mptcpi_bytes_acked = msk->bytes_acked;
>>> +	mptcp_data_unlock(sk);
>>
>> Do you know if this could have a "bad" impact on the performances?
> 
> It depends ;)
> 
> If you do something alike:
> 
> for CPU in $(seq $(nproc)); do while ss -M; do :; done & done
> 
> it will impact mptcp socket performances ;)
> 
> For a more reasonable usage, nothing measurable is expected: once every
> a few minutes? hours? much longer interval? an additional process will
> compete for the mptcp data and socket lock. It's not expected to matter
> much.

In case of debugging, we might want to take these info very regularly.
But then it is a debugging session and it is understandable it can have
an impact. Taking more CPU waiting to get the info is fine in this case,
more than slowing the connections.

> The fact we need to acquire independently the data lock and socket lock
> is a bit not nice - for the user-space requesting the dump. It can
> possibly be avoided implementing some helper to upgrade the mptcp data
> lock to the (fast) socket lock, but at this point I think it would be a
> bit overkill.

Indeed.

>> I mean mptcp_diag_fill_info() is also used on when dumping all the
>> connections via Netlink. I guess the lock_sock_fast() should be fine
>> because it is also used in tcp_get_info() but what about the data lock?
>> Also OK because that's a spin lock and we only copy fields?
> 
> The main impact we have on the data path is the dirtying of the msk
> socket spin lock cacheline, which will possibly cause a cache miss on
> the next data path lock operation, if the dumping happens on a
> different core. Not relevant until we get many of them per socket per
> seconds.

Good point.

Thank you for having shared your point of view!

I'm fine with this!

I guess we don't need to backport the locks you added then, can be seen
as a new feature.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
