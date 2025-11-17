Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3632B983
	for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411671; cv=none; b=HxpsXNS0b3+iqYfxy/RO3qG/sVSgvRCGTjGE3xzgtYJDpf2pIMjX9boJb72j3cmBtHWoZwBkoQw8wXFLKK3aGSZp/kywYcTzW6wl+Chwq9qpHQ5TUSFgb3dNzOPQU2i5n92IjGTRLCC3iYo17KiIS5OvOsPwaOfF3uIKvfM+/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411671; c=relaxed/simple;
	bh=viRidDsptbGBtoLkeGiyM6QIGVMDyez61DgRSNF1mcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHNTHdoBPRtKqbJz/TSw/4HNC7Aw9cHOtHz8lvAPRz1SpyDvx5nqZxHpuVgIge28ReLOQIGVwWA0JxNrq+HvM98RZrS7B6LwC2/lGAXAD4g7E5ecAtb11c09jkWAd5m995KVex31NIjeqeyNVEq3C2DSh/nhirSR0Q7dJ+RdDqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjZZgZtj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjZZgZtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763411668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QVC2bYewQBrqMt6cfYCAFU9vwmTmkv4a8QQzACOnhU=;
	b=gjZZgZtjHI+abEq1sWycIPz6aZseenSXtYfaDvDAqAQt9HoSwRKHKpSUz9pEJNCa6wiqJz
	iZwIKb9YqO7wShPJ+rP0YXA0K6xSIOfDwyJ4m83Cp9QceCxzdWW4kmT8lorh3CVsisulPI
	uC3UKyVG3IrWGpFlZ2wo2CnAVp8yh7Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-UypTrzXbNrad04GaqGTBDQ-1; Mon, 17 Nov 2025 15:34:27 -0500
X-MC-Unique: UypTrzXbNrad04GaqGTBDQ-1
X-Mimecast-MFC-AGG-ID: UypTrzXbNrad04GaqGTBDQ_1763411665
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b30184be7so247460f8f.2
        for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 12:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411664; x=1764016464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QVC2bYewQBrqMt6cfYCAFU9vwmTmkv4a8QQzACOnhU=;
        b=IyLzyTdJxgjr20JiWJPDeq4mK/7F6wQ4D0y5a+RIMghTkjAJ0YZt3pUhhMNddkPjkb
         eu8LB/s5pl5K1y8HY4CCt4c2MWXpBdvUr2uwva2Gs3XcCFX4zIX99r52cjEq39+4er0E
         GyRVZ5jZZ+xk7NDY0QJUExlBVFRJUX7wzyMWmBxcIY2umW7Skwy2XAMGm+IshM+FNS+D
         ypyj6l18GymJxXceSUs8rdx7MuS+kD56wui8xztsoBTgD5K5zDXunc8UjxR/2kuw+up9
         MpD0PB1EzG/J1PdTTHq0yIVBF1nPTbrXKjoEVt8zf6Ijz6zuYTwcNmeGhpG5eIHp9D6B
         2YTQ==
X-Gm-Message-State: AOJu0Yxvtd5XTYQGOQDvbW8/wJ/wS7PAjXjuHCetjfxcknkrbRgkiyyY
	C7aSzRx41Kg2Q46f6jq+RB6Ra3LRUUaV1B4TWcfAjrH3RZnVV2eZEWYilAu7fMLSRAhTr18agw/
	C1ZMGYnlgJDg0I5zjRu6D8BGA6+f0AWpLH417g/cs+rc19wKVkATCMXkDJ6m4Uttk
X-Gm-Gg: ASbGncsBuuS48IQM1FDzpuakwR4MJ4fD6Hiu7NwNLGQWC3p9/S4wN3YhpxQz2wMv9y8
	+FPW9R7LgJEBmj+WRAVXuW2BYrSp95NFoYPjDknuwGzgpm7pInbsXQOnAB9N2pyrEtc+Zhyff0T
	FOGR/QAdc0acd9saLvVh844I8DUrP+B1Y69xCe2XD9B3aXTUzn3PuaQJNK9VUPI4Ts+erIj163x
	pyuOiXJVZ0/agnBTt+qgYAtXk+i0Zg01t4OuY0t0xsRwI2yvHS+I8Xc7dVmyz/kKRfrI1tcjqXP
	EvCz/ikUgIJvmvbIv61nFBHHfJ5jqkNH9zYB2omWm+uMdjn21AyC/L8EbFKDH3h3pMmQLZWs+9o
	55gmHoEuvAFxB
X-Received: by 2002:a05:600c:8b23:b0:477:7bd2:693f with SMTP id 5b1f17b1804b1-4778fe60615mr129178095e9.6.1763411664311;
        Mon, 17 Nov 2025 12:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc+r//uuwwZGGMZvKbtbuLR9rg4Icqxzp1V4Q1gRwiuJTHaQMc5u1EjvEkRIhYbo0REZpqXQ==
X-Received: by 2002:a05:600c:8b23:b0:477:7bd2:693f with SMTP id 5b1f17b1804b1-4778fe60615mr129177895e9.6.1763411663813;
        Mon, 17 Nov 2025 12:34:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e953e3sm318844695e9.14.2025.11.17.12.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 12:34:23 -0800 (PST)
Message-ID: <95bcf240-7603-4f53-aa34-8f8baf9c5776@redhat.com>
Date: Mon, 17 Nov 2025 21:34:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 mptcp-next 5/6] mptcp: better mptcp-level RTT estimator
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1762940290.git.pabeni@redhat.com>
 <bf25344f52c064882ade22ceafec095d4dead682.1762940290.git.pabeni@redhat.com>
 <b1660aec-6b7e-4c71-d121-b570085ffb65@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b1660aec-6b7e-4c71-d121-b570085ffb65@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vilhYsXKoU_OhIgjilIX5c-P6dX3klxxHh-_INISJjI_1763411665
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/25 2:43 AM, Mat Martineau wrote:
> On Wed, 12 Nov 2025, Paolo Abeni wrote:
>> The current MPTCP-level RTT estimator has several issues. On high speed
>> links, the MPTCP-level receive buffer auto-tuning happens with a frequency
>> well above the TCP-level's one. That in turn can cause excessive/unneeded
>> receive buffer increase.
>>
>> On such links, the initial rtt_us value is considerably higher
>> than the actual delay, and the current mptcp_rcv_space_adjust() updates
>> msk->rcvq_space.rtt_us with a period equal to the such field previous
>> value. If the initial rtt_us is 40ms, its first update will happen after
>> 40ms, even if the subflows see actual RTT orders of magnitude lower.
>>
>> Additionally, setting the msk rtt to the maximum among all the subflows
>> RTTs makes DRS constantly overshooting the rcvbuf size when a subflow has
>> considerable higher latency than the other(s).
>>
>> Finally, during unidirectional bulk transfers with multiple active
>> subflows, the TCP-level RTT estimator occasionally sees considerably higher
>> value than the real link delay, i.e. when the packet scheduler reacts to
>> an incoming ack on given subflow pushing data on a different subflow.
>>
>> Address the issue with a more accurate RTT estimation strategy: the
>> MPTCP-level RTT is set to the minimum of all the subflows, in a rcv-win
>> based interval, feeding data into the MPTCP-receive buffer.
>>
>> Use some care to avoid updating msk and ssk level fields too often and
>> to avoid 'too high' samples.
>>
>> Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v3 -> v4:
>>  - really refresh msk rtt after a full win per subflow (off-by-one in prev
>>    revision)
>>  - sync mptcp_rcv_space_adjust() comment with the new code
>>
>> v1 -> v2:
>>  - do not use explicit reset flags - do rcv win based decision instead
>>  - discard 0 rtt_us samples from subflows
>>  - discard samples on non empty rx queue
>>  - discard "too high" samples, see the code comments WRT the whys
>> ---
>> include/trace/events/mptcp.h |  2 +-
>> net/mptcp/protocol.c         | 77 ++++++++++++++++++++++--------------
>> net/mptcp/protocol.h         |  7 +++-
>> 3 files changed, 55 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
>> index 0f24ec65cea6..d30d2a6a8b42 100644
>> --- a/include/trace/events/mptcp.h
>> +++ b/include/trace/events/mptcp.h
>> @@ -218,7 +218,7 @@ TRACE_EVENT(mptcp_rcvbuf_grow,
>> 		__be32 *p32;
>>
>> 		__entry->time = time;
>> -		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
>> +		__entry->rtt_us = msk->rcv_rtt_est.rtt_us >> 3;
>> 		__entry->copied = msk->rcvq_space.copied;
>> 		__entry->inq = mptcp_inq_hint(sk);
>> 		__entry->space = msk->rcvq_space.space;
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 4f23809e5369..9a0a4bfa25e6 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -870,6 +870,42 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
>> 	return moved;
>> }
>>
>> +static void mptcp_rcv_rtt_update(struct mptcp_sock *msk,
>> +				 struct mptcp_subflow_context *subflow)
>> +{
>> +	const struct tcp_sock *tp = tcp_sk(subflow->tcp_sock);
>> +	u32 rtt_us = tp->rcv_rtt_est.rtt_us;
>> +	u8 sr = tp->scaling_ratio;
>> +
>> +	/* MPTCP can react to incoming acks pushing data on different subflows,
>> +	 * causing apparent high RTT: ignore large samples; also do the update
>> +	 * only on RTT changes
>> +	 */
>> +	if (tp->rcv_rtt_est.seq == subflow->prev_rtt_seq ||
>> +	    (subflow->prev_rtt_us && (rtt_us >> 1) > subflow->prev_rtt_us))
> 
> Hi Paolo -
> 
> It's still this "ignore the new rtt for this subflow if it more than 
> doubles" clause that concerns me. subflow->prev_rtt_us is only used in 
> this function, and it seems like there will be cases (especially with low 
> rtt values) where this could ratchet down and get stuck at a low value. 
> This would make the subflow get ignored forever for msk-level rtt updates. 
> If there's only one subflow then the msk rtt could become constant.
> 
> Is the TCP-level rtt noisy/random enough that this is unlikely to happen?
> 
> Are there other characteristics of the "apparent high RTT" that would 
> allow us to avoid this ratcheting-down behavior? For example, if the 
> "apparent high RTT" was usually just one high outlier it might make sense 
> to set subflow->prev_rtt_us = 0 when this condition is detected so the 
> value will get reinitialized on a later sample.

Thanks for the thoughtful review.

I must admin here I'm walking on thin ice because I'm not sure I'm
really aware of all the rtt estimation implications...

AFAICS MPTCP is interested only in the minimum of all the "currently
active" subflows (i.e. receiving data from the peer): RTT is used only
to guestimate the correct/needed receive buffer grow.

If MPTCP gets "stuck" with "too low" RTT values, DRS will not
update/grow the receive buffer anymore.

When designing the heuristic implemented here, I was mainly concerned
about closing subflows. i.e. the msk socket has 2 subflows: one with a
very low rtt, the 2nd with a very high rtt and the first one closes, the
"all time min" strategy yield irrelevant/too low values.

A possibly better strategy that should avoid your concern could be
computing the minimum on the last N rtt samples captured by all the
subflows, without any "too high filter". I'm reworking this patch around
that idea and will share it shortly.

/P


