Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035E2FFDCA
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335644; cv=none; b=aXdhRd5Nvlr94SUOj/bUOXTavWGgLBezKPfOjkuXRJgI/hHv8Q5JV+NFdEZ/abMk4HUG8/TYbjwL7uhTfVBiD/FHmdYSs/gtYztWIi94i24gTxhSdl+ZqNz4e4bmJq25e3qEW7zAXGpGKIYJ66z+PWQl624oxTGzcf4/OjXuIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335644; c=relaxed/simple;
	bh=ONEriO5BFP/+j/Sn7r/1WfQMJqrlV+491H1qPll09bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lez+elXYHOuBtxAhZlMJMCELOFW/fCT5PQODOT/zmZejY5r852o4EcVxFK5zu8fTfmQFpGp7BAngOaprIQJqLFsn0kJnxKx2Ava1/gUGJu9SeTcH8nLTlfXcDI7ftkRhAFdYCD+lt32yuMpdGRQV6opts7TuvlGiGZbIltcXEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDpx26I7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDpx26I7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762335640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cwtKqllspJBoO05pANHMdoQMbEhpDOc6LLgFmvuY2o=;
	b=FDpx26I72n7oaqCOn5pJoIZAL5raI1jSb4n88kIdwd27wLRCVIOKSHyhxRJXNQXZZu4Aw3
	C1JKauMKG/xiPVyaISkPVEiX4pn5TxqRhztWtshl6q+H+s6TjhqMfhLH8Pe9a4lfT/8UCz
	sw8irOsGrsbRTZ5COtav/C/a3R1iBvg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Oa_hFKjBOtC0mDdIkQ7FvQ-1; Wed, 05 Nov 2025 04:40:39 -0500
X-MC-Unique: Oa_hFKjBOtC0mDdIkQ7FvQ-1
X-Mimecast-MFC-AGG-ID: Oa_hFKjBOtC0mDdIkQ7FvQ_1762335639
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475de1afec6so2445655e9.1
        for <mptcp@lists.linux.dev>; Wed, 05 Nov 2025 01:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335638; x=1762940438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cwtKqllspJBoO05pANHMdoQMbEhpDOc6LLgFmvuY2o=;
        b=Lp2PMpoXBMKLgtJbmiT6ZLZA/S4nq9/F0IuhYzbchrawKPzyY/2pECQ3NtmzNAEzq+
         1lnhOdjoCXpLpYG2ZuFf7qDx5vU+q6tuhtFce9K2DaOm5Bw/aU80ijaxxQnr/9dzgsJH
         NikaiudGEapRYahTWveKe/o96/HiL7Uu0uOGaU+K4PBM97UrKChOZ2W1/et48eUh783t
         +TPKJa2pEWRUcpQ+eijQ4XbosnYJh80gU2BbHg3EEqxbbHjAIjt2VVeWvPb3+K6WxCzC
         4bZnsqB30esKALWnqY3AMHJAM2kXv4rdaH+T6OZa2ivfhwpowfPqyckQvvMGVULBnecw
         NHaA==
X-Gm-Message-State: AOJu0YxqTMI43LxzlTYaYrX8T+PXaxwVqYSiR4IAi/RHCsosNnQ5p6nW
	ZRce646T9EZiljcHyrX61qX++fboDDwL9DDRM8FhKgZu6tyAEP+2CBaA91wHr6ckLd6vD10UUtM
	GhRF+lekV4ern2o+qZPKW6WK89tQYwbDfSGRzERK69emu7ABA92RhthSrHb1j0RUe
X-Gm-Gg: ASbGncvJn8QigfNNJwbf0r+P7VcdOg0leGiCZgocj4EDX24GyMgHfXArId9gY3ydER2
	AYEc5Of5XHxmPe1efQyLv0k7QFVOmmEYR/+f7T9hKB/XRygRPoSGMXn8yNizEFQN1ECPrMXKvdv
	dhIyyNR8X5A9m0+KG5jpQLb34Vg5nzXyeycBAceSsilSZeIkwO228MyRzdgBEUD1snMBPPkZdju
	2koriwhpeO0FzJF3WYJxLsiUqLQ2MBYqno4+gfh2hrw68BS3W84+dYQbl3qQ8xoxZXMSCR652kR
	m/HPkG8i7Ve2qytYNdPERWoGEwPWUMeHIGmDhXhjA5ewFke+HsvI3//Jqj39sIc7K9GEia25ITn
	0+A==
X-Received: by 2002:a05:600c:8b28:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4775c72668fmr23984035e9.10.1762335638249;
        Wed, 05 Nov 2025 01:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7v4PNgUwRJ1htMVpc79OqL/ex9cm2q7Jgjg9SqrLTTsYjIMkNm12ojRiHd5xgNfd2Xit+Jg==
X-Received: by 2002:a05:600c:8b28:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4775c72668fmr23983735e9.10.1762335637730;
        Wed, 05 Nov 2025 01:40:37 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce329a4sm37300395e9.14.2025.11.05.01.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:40:37 -0800 (PST)
Message-ID: <95c083c8-12ca-46f4-8de7-30bea39c4bb0@redhat.com>
Date: Wed, 5 Nov 2025 10:40:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-next 1/7] trace: mptcp: add mptcp_rcvbuf_grow
 tracepoint
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1762292476.git.pabeni@redhat.com>
 <5b1042b7f934b9a749dee435b7494a414adb57ce.1762292476.git.pabeni@redhat.com>
 <076e1386-240e-f23e-f95a-876e7284a346@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <076e1386-240e-f23e-f95a-876e7284a346@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yzm2KfWnj0BeVPFrdfXbg_N-2wcZyGEOjW8XEl_17po_1762335639
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 1:24 AM, Mat Martineau wrote:
> On Tue, 4 Nov 2025, Paolo Abeni wrote:
> 
>> Similar to tcp, provide a new tracepoint to better understand
>> mptcp_rcv_space_adjust() behavior, which presents many artifacts.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> include/trace/events/mptcp.h | 74 ++++++++++++++++++++++++++++++++++++
>> net/mptcp/protocol.c         |  3 ++
>> 2 files changed, 77 insertions(+)
>>
>> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
>> index 085b749cdd97..71fd6d33f48b 100644
>> --- a/include/trace/events/mptcp.h
>> +++ b/include/trace/events/mptcp.h
>> @@ -178,6 +178,80 @@ TRACE_EVENT(subflow_check_data_avail,
>> 		  __entry->skb)
>> );
>>
>> +#include <trace/events/net_probe_common.h>
>> +
>> +TRACE_EVENT(mptcp_rcvbuf_grow,
>> +
>> +	TP_PROTO(struct sock *sk, int time),
>> +
>> +	TP_ARGS(sk, time),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(int, time)
>> +		__field(__u32, rtt_us)
>> +		__field(__u32, copied)
>> +		__field(__u32, inq)
>> +		__field(__u32, space)
>> +		__field(__u32, ooo_space)
>> +		__field(__u32, rcvbuf)
>> +		__field(__u32, rcv_wnd)
>> +		__field(__u8, scaling_ratio)
>> +		__field(__u16, sport)
>> +		__field(__u16, dport)
>> +		__field(__u16, family)
>> +		__array(__u8, saddr, 4)
>> +		__array(__u8, daddr, 4)
>> +		__array(__u8, saddr_v6, 16)
>> +		__array(__u8, daddr_v6, 16)
>> +		__field(const void *, skaddr)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		struct mptcp_sock *msk = mptcp_sk(sk);
>> +		struct inet_sock *inet = inet_sk(sk);
>> +		__be32 *p32;
>> +
>> +		__entry->time = time;
>> +		__entry->rtt_us = msk->rcvq_space.rtt_us >> 3;
>> +		__entry->copied = msk->rcvq_space.copied;
>> +		__entry->inq = mptcp_inq_hint(sk);
>> +		__entry->space = msk->rcvq_space.space;
>> +		__entry->ooo_space = RB_EMPTY_ROOT(&msk->out_of_order_queue) ? 0 :
>> +				     MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq -
>> +				     msk->ack_seq;
>> +
>> +		__entry->rcvbuf = sk->sk_rcvbuf;
>> +		__entry->rcv_wnd = atomic64_read(&msk->rcv_wnd_sent) -  msk->ack_seq;
>> +		__entry->scaling_ratio = msk->scaling_ratio;
>> +		__entry->sport = ntohs(inet->inet_sport);
>> +		__entry->dport = ntohs(inet->inet_dport);
>> +		__entry->family = sk->sk_family;
> 
> Hi Paolo -
> 
> __entry->family isn't referenced in the TP_printk() below.
> 
> Other than that, the series is looking good. I still need to work on 
> understanding the last 2 patches, even with the commit messages & comments 
> the behavioral changes/consequences aren't clear to me yet.

patch 7/7 is just 'inspired' by similar tcp change (commit
ea33537d82921e71f852ea2ed985acc562125efe) the goal is making DRS
converging faster to the right size. It should not have any downside.

patch 6/7 'fixes rtt estimation'; with the current algo there are some
major issues:
- max() is simply wrong, as we need to react reasonably fast. If a link
has extreme high latency and another is very fast, DRS will converge
very slowly. This is addressed using min()
- the subflow rtt is biased by mptcp; i.e. on the rx side is the time
measured between an ack and the next data. If the connection is CPU
bounded, and the scheduler picks a different subflow in response to an
incoming ack, the rtt estimated by acked subflow on the rx side could be
much more higher then the actual delay. This is addressed explicitly
filtering out "too high" rtt value (i.e. double than previous sample)
- the most subtle but very effective problem. When the link latency is
very low (i.e. I have 2 hosts b2b connected) the first rtt sample will
be much higher than the next ones (in my scenario 40K us vs 80 us, note
the missing 'K'), because the first sample includes all process
scheduler and the socket creation overhead. With the current algo I see:

	mptcp_rcv_space_adjust() // time  = ~40K us
	  mptcp_rcv_space_init() // msk rtt = ~40K us, ssk rtt = ~40K
	  mptcp_rcvbuf_grow()	

	mptcp_rcv_space_adjust() // for 40K us keeps increasing `copied`
	...
	mptcp_rcv_space_adjust() // time = ~40K us, copied is very high
	  // ssk rtt ~= 80us, msk rtt = ~80 us
	  mptcp_rcvbuf_grow() // set sk_rcvbuf to tcp_rmem[2], because
			// `copied` accumulated data for much more than
			// one rtt

  the root cause of the problem is that the msk rtt is updated with a
period equal to the previous rtt sample, which in turn is too high at
connection start.

The solution is keeping the msk rtt up2date with the subflow ones, with
update every rcvwin. In theory could be at every incoming packet, but it
would be useless because the subflow update the rtt every rcv wnd and
touching too often the msk field could cause performance regressions.

Side note: the msk rtt needs periodic 'reset'/'refresh' because
otherwise it could not deal with events like 'subflow with lowest rtt is
closed'. Such reset happens every <rcv wnd> * <number of subflows>
incoming bytes.

Please LMK if the above helps.

Cheers,

Paolo
	

