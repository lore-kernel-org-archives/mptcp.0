Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEE2D94B6
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005408; cv=none; b=Ne1vgeSXozTEppQWV6Vfq9lDZgFH99uL765q7I1A/cJTzARbzA5+He6RcIikvwEWggLnPpugEwvlJBApDezESBKqrwM5ce9yFQUAu4dTbtcHinrRppGBzZQz3dV8cH8yJiDwSDlERSMKP+7mt0/lWD32B2VlA7PyoVmVu58Ok6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005408; c=relaxed/simple;
	bh=tg3qB30Jfk8YRDsV5sStuYYRlchyArJMzi23uNq01lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B1gXK7xfA4UVRnAulLHnYKDgNg0KsJ+Ke2spivrMIDoBF0oYXaVHZQ2nqS9Gcoqk3Rtiqslq2AvnNt1a2lBB24dS4j3pKpJ5yFtbnr7x+R8R03uu8og2SJk9ngE/HBcPEvNpDCAZEFOWN8oCmhnhLaJwn6xgJwYv3OkwwrKM8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FP/58Clx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FP/58Clx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760005405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ok/RJovXJ0st6gANOOLGF/w20b27Dv+xy5gpyw7273g=;
	b=FP/58ClxooujknaWkam4gI/UNc8f8n5wJmidOU6KXkmhM0EUCPgTmrJWWZmdkc6w2xTpwZ
	Pyr2lr93v33R4WfoDSqwEccMjosSHtyqukc4//P8dlV1+7ZkDifCH/XAO7K45GZFOltBCN
	0jzpR4MpP9yFaU0ZV+O1q8rdVCV04Ok=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-CVhusnNVMDy4lCld9VBhqA-1; Thu, 09 Oct 2025 06:23:24 -0400
X-MC-Unique: CVhusnNVMDy4lCld9VBhqA-1
X-Mimecast-MFC-AGG-ID: CVhusnNVMDy4lCld9VBhqA_1760005402
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4fa584e7so3869125e9.0
        for <mptcp@lists.linux.dev>; Thu, 09 Oct 2025 03:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005402; x=1760610202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok/RJovXJ0st6gANOOLGF/w20b27Dv+xy5gpyw7273g=;
        b=BpphJJa4DUSpbkHgg7jvoY5v1DTpIPvNpWihZ6r7raFXU7yr2RBBbaE/xuJciaVRS6
         kE6dPPtb1eeizZ+IQqmxeZDvNsVAfUnG83MDE+npWk389v5NQ2UTJK4IN81I12aDkY/6
         KAS2FiNP/VZtFWeeogGxyphkzVPgt6cGTUt7+Ox5mu84hcKuWCdOjzFf3IQDocwbPZgm
         yfel5Yr9ONT5dQfYKCz6dqJgN7Dm1eu4j29Sv1FpWs8FfBzcZise+qQPu4VZwwQYwo7C
         EHtEseQ54dubP5GWdSxDoZzidwn4qdYOLsLiyIIzh5BftFq/VpT3Pb6MgH+/RoSYNQNt
         UWbw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7RGYgFIftYqzaUQY9QJEoOlvhDLSTzrn/yKAt7eR2NF80loAEM3DHSncoyFGqua75I/IRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqfOaJDY6cN0CSweUS/tSp+T0tIum/crf7LbNGCVmU+IZE2tX1
	CtaKLf3s2kIQCJNPPhw11WwsNeeHRXKF39AcpH0EiSq48JQdAhTl1Icf4+zFDRji4tWbjGgQSgZ
	OvXmzZkkjkieXzgX4+cAMUzbiknhz39H2NjPzkAZt4PyjIyuNr/kgEXHNgb5rqOAv
X-Gm-Gg: ASbGncuEza/dF6YXRmux2Fo2P7Vh7LBQMn1S/FQAE0h0He8N+J+k878CGAWGLo0XxvS
	CSGbyzCxO2Z5M/eL7eq76OZh+da3MXZeXmf2ReUdabuk6jHiz6O4K5GVmeD7NmZ5neGmK0mlCI8
	x606Mi7T2FEUa1nnJq4oJnL2cWVX5YGBEDHAi3OFY6E8+0xr3ZDcBVP4wvfitf68VN2K617Tm00
	pOQ0UsUDUnqbzzvBN6628bXsPj+lzdioZzPvfiQeDNUVsizpGkgAA8kMO/QsPt3EGYSTnEzrx+I
	ebhlUZkKPzFcz4i0zUYYdrAuv0WKPCfV9rUwbl8a08WNBqJiRXRdVPHJIlqOGAh/cDUz+RlfTyY
	zW1XEPVN/KiWVxXiENw==
X-Received: by 2002:a05:600c:19d2:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-46fa9a96712mr46469265e9.14.1760005402171;
        Thu, 09 Oct 2025 03:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUsV5sZBuh0g6TRT+ertczCyaj/OtmQnf8hB6WLQfjplV3eO3U/1Qxv/FTZ7OQ2so4FqbHzw==
X-Received: by 2002:a05:600c:19d2:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-46fa9a96712mr46469035e9.14.1760005401683;
        Thu, 09 Oct 2025 03:23:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d4caa4sm78229335e9.12.2025.10.09.03.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 03:23:21 -0700 (PDT)
Message-ID: <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com>
Date: Thu, 9 Oct 2025 12:23:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1759737859.git.pabeni@redhat.com>
 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
 <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 00ZsDnSEsyvKwkF-DA5w1dIjs9grKF2TOE7I1XrMOV0_1760005402
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/9/25 11:02 AM, Geliang Tang wrote:
> On Thu, 2025-10-09 at 09:52 +0200, Paolo Abeni wrote:
>> On 10/9/25 8:54 AM, Geliang Tang wrote:
>>> On Wed, 2025-10-08 at 09:30 +0200, Paolo Abeni wrote:
>>>> On 10/8/25 5:07 AM, Geliang Tang wrote:
>>>>> On Mon, 2025-10-06 at 19:07 +0200, Matthieu Baerts wrote:
>>>>>> Hi Paolo,
>>>>>>
>>>>>> On 06/10/2025 10:11, Paolo Abeni wrote:
>>>>>>> This series includes RX path improvement built around
>>>>>>> backlog
>>>>>>> processing
>>>>>> Thank you for the new version! This is not a review, but just
>>>>>> a
>>>>>> note
>>>>>> to
>>>>>> tell you patchew didn't manage to apply the patches due to
>>>>>> the
>>>>>> same
>>>>>> conflict that was already there with the v4 (mptcp_init_skb()
>>>>>> parameters
>>>>>> have been moved to the previous line). I just applied the
>>>>>> patches
>>>>>> manually. While at it, I also used this test branch for
>>>>>> syzkaller
>>>>>> to
>>>>>> validate them.
>>>>>>
>>>>>> (Also, on patch "mptcp: drop the __mptcp_data_ready()
>>>>>> helper",
>>>>>> git
>>>>>> complained that there is a trailing whitespace.)
>>>>>
>>>>> Sorry, patches 9-10 break my "implement mptcp read_sock" v12
>>>>> series. I
>>>>> rebased this series on patches 1-8, it works well. But after
>>>>> applying
>>>>> patches 9-10, I changed mptcp_recv_skb() in [1] from
>>>>
>>>> Thanks for the feedback, the applied delta looks good to me.
>>>>
>>>>> # INFO: with MPTFO start
>>>>> # 57 ns2 MPTCP -> ns1 (10.0.1.1:10054      ) MPTCP    
>>>>> (duration
>>>>> 60989ms) [FAIL] client exit code 0, server 124
>>>>> # 
>>>>> # netns ns1-RqXF2p (listener) socket stat for 10054:
>>>>> # Failed to find cgroup2 mount
>>>>> # Failed to find cgroup2 mount
>>>>> # Failed to find cgroup2 mount
>>>>> # Netid State    Recv-Q Send-Q Local Address:Port  Peer
>>>>> Address:Port  
>>>>> # tcp   ESTAB    0      0           10.0.1.1:10054    
>>>>> 10.0.1.2:55516
>>>>> ino:2064372 sk:1 cgroup:unreachable:1 <->
>>>>> # 	 skmem:(r0,rb131072,t0,tb340992,f0,w0,o0,bl0,d0) sack
>>>>> cubic
>>>>> wscale:8,8 rto:206 rtt:5.026/10.034 ato:40 mss:1460 pmtu:1500
>>>>> rcvmss:1436 advmss:1460 cwnd:10 bytes_sent:115312
>>>>> bytes_retrans:1560
>>>>> bytes_acked:113752 bytes_received:5136 segs_out:85 segs_in:16
>>>>> data_segs_out:83 data_segs_in:4 send 23239156bps lastsnd:60939
>>>>> lastrcv:61035 lastack:60912 pacing_rate 343879640bps
>>>>> delivery_rate
>>>>> 1994680bps delivered:84 busy:123ms sndbuf_limited:41ms(33.3%)
>>>>> retrans:0/2 dsack_dups:2 rcv_space:14600 rcv_ssthresh:75432
>>>>> minrtt:0.003 rcv_wnd:75520 tcp-ulp-mptcp flags:Mec
>>>>> token:0000(id:0)/32ed0950(id:0) seq:2946228641406205031 sfseq:1
>>>>> ssnoff:1349223625 maplen:5136
>>>>> # mptcp LAST-ACK 0      0           10.0.1.1:10054    
>>>>> 10.0.1.2:55516
>>>>> timer:(keepalive,59sec,0) ino:0 sk:2 cgroup:unreachable:1 ---
>>>>> # 	
>>>>> skmem:(r0,rb131072,t0,tb345088,f4088,w352264,o0,bl0,d0)
>>>>> subflows_max:2 remote_key token:32ed0950
>>>>> write_seq:6317574787800720824
>>>>> snd_una:6317574787800376423 rcv_nxt:2946228641406210168
>>>>> bytes_sent:113752 bytes_received:5136 bytes_acked:113752
>>>>> subflows_total:1 last_data_sent:60954 last_data_recv:61036
>>>>> last_ack_recv:60913                                       
>>>>
>>>> bytes_sent == bytes_sent, possibly we are missing a window-open
>>>> event,
>>>> which in turn should be triggered by a mptcp_cleanp_rbuf(), which
>>>> AFAICS
>>>> are correctly invoked in the splice code. TL;DR: I can't find
>>>> anything
>>>> obviously wrong :-P
>>>>
>>>> Also the default rx buf size is suspect.
>>>>
>>>> Can you reproduce the issue while capturing the traffic with
>>>> tcpdump?
>>>> if
>>>> so, could you please share the capture?
>>>
>>> Thank you for your suggestion. I've attached several tcpdump logs
>>> from
>>> when the tests failed.
>>
>> Oh wow! the receiver actually sends the window open notification
>> (packets 527 and 528 in the trace), but the sender does not react at
>> all.
>>
>> I have no idea/I haven't digged yet why the sender did not try a zero
>> window probe (it should!), but it looks like we have some old bug in
>> sender wakeup since MPTCP_DEQUEUE introduction (which is very
>> surprising, why we did not catch/observe this earlier ?!?). That
>> could
>> explain also sporadic mptcp_join failures.
>>
>> Could you please try the attached patch?
> 
> Thank you very much. I just tested this patch, but it doesn't work. The
> splice test still fails and reports the same error.

Uhmmm... right, in the pcap trace you shared the relevant ack opened the
(mptcp-level) window, without changing the msk-level ack seq.

So we need something similar for __mptcp_check_push(). I can't do it
right now. Could you please have a look?

Otherwise I'll try to share v2 patch later/tomorrow.

Cheers,

Paolo


