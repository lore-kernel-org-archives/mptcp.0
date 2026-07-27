Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149B3F4DC1
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146677; cv=none; b=jLKbG/eoe1j6z0wPCmBD7JRygCiwyyEFCao44qqJQGHgO1jMBS2pdsEeKxM2VdAE6OoJAQyG+osYIxPGSBlfKW89dTlEGF0QfjVeAqS8Cs0CBV+J8QTDHXYoQEZlgIgnG9sqyZlp80p0NpTCQIpIq7PYE2AoSs01gU/qiV6V+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146677; c=relaxed/simple;
	bh=4X08AzDT6894OXzAewbi6nOY7pddKMXfglY7uPq2fhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVUsyZvXqKYzBuhH/8Gie0hhRMSopqxWdhNFodRWTMrwBR5qQXg5p/ocw8UeXrFdyvKrcxdSg3IDmLdNIVV3REr4q8DuZZfg+VhpxieY9gj5vBBGO6qz3QNWzW1xRGxRNE3i4IIWxfgqbzd1oC8SNGh0BHVnhSj+2/eEYUyB9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP9Di4ja; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP9Di4ja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785146673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta/jzJ8cmDw1phAiCMyIDZTyrf1COW+lWmj1v6LuA2Y=;
	b=UP9Di4jaLqtuLxQXVwYkCKNdvUI2lKPAmMrWaXXAQ5bRWa9+SIDBwhgEg0mb0xphCNoRkH
	42goC80VR+aK53jEMA5+KE0RN3YSyZr2Fk2Y/mSC++c7Mw9g7QWOaEjhNbwg1/lCyqRfPO
	+T+PgjircKBctEGulCqUqapPSvymtLo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-JcK2DFirPFCEk5iK6xpA6A-1; Mon, 27 Jul 2026 06:04:30 -0400
X-MC-Unique: JcK2DFirPFCEk5iK6xpA6A-1
X-Mimecast-MFC-AGG-ID: JcK2DFirPFCEk5iK6xpA6A_1785146669
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47eaa4006a1so1250849f8f.0
        for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 03:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146669; x=1785751469;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ta/jzJ8cmDw1phAiCMyIDZTyrf1COW+lWmj1v6LuA2Y=;
        b=SowPAvsbQX/gd9X0fU8oUFXi9LJ3vaJEACEBaFErYuT3S2z2w6VEQjATCbzCPxrZvI
         FFhbAn5yQ+Ylesl1p6YCgPYWKz7DGTe07LysBsDwvVbpU108kn3hBhel+5q/d1yDipvX
         /eFI1ZWz+JmvUMdqWOHihDnlRxWWeVWk7YB8mqaSzj5+A5oFwuDND7dXfJuCgOdJjHHA
         xFTIoEdv9mHEo8FuiiLW4aLSGD44T8mordfyjiKuiRDwODYB6HRQcU8cFeb0AFXRQUZl
         Iu2AFOd/GtWg4ec+Rr+xSINWqQAu8kAqcXmtJlpCUejp7M/LBsMrvW7HA1ASiODiqbrK
         gTPA==
X-Gm-Message-State: AOJu0YxbneLVVt6ZNtCf9q4u5gLJoMakDz3yr860rqmPwJBqzr2IAxTE
	WR2+H9JbhitL+HhLKMTFw27xpX7LGmOmoeoM3DSHBQnDh0Y1qc/A748HKLw/QRAKofTy9WjduHD
	XWRFqrX+ZpZNSYZsXa0Pupz5R/+VWxQMAMry6oOOkDmxAv4+F3OqM2hr9
X-Gm-Gg: AR+sD11y6i5plO5wnoRK0rqOpKR04w95nCKXUDX3PxBfBOPzaM9Z/izYnEYHsGjAvqI
	CgE6R0KpIKXqul6hZQbR7WazzQVwcNskNy1yWbumiKTgrQJuNOMFYIKxFWyDDea8LYhT7aNNXNy
	DmPNXvdD7AQq+wLZGfvHmeZlh8TGiUME8uUz0xtJ8VEFWJ+Zh2Xuelhz09GsUR7Gf2SekZfcX+J
	1KPTohhaPUYB1YXNDSaJ5QSH1L+1od84CfagGGHww949sP0dLVsXUHl3Relsc7klNSn8XL2EF0X
	vxyUysFOxfoQ5UQZSE9npydpbZKGoAHG+riFt5yW2Qz/ZsKqftr8pHEedJca8jN9ylJOUTfvTwI
	kr6l/JqUYs26YnFI9LPVHb1fEDzsI4fMaRTzViBDYJ+DJp8vLM0qEjIPeTqEXFNqGeHS7QdMlhB
	zcgA==
X-Received: by 2002:a05:6000:25c3:b0:47f:9763:9864 with SMTP id ffacd0b85a97d-47f9feb30ddmr9504570f8f.19.1785146668590;
        Mon, 27 Jul 2026 03:04:28 -0700 (PDT)
X-Received: by 2002:a05:6000:25c3:b0:47f:9763:9864 with SMTP id ffacd0b85a97d-47f9feb30ddmr9504522f8f.19.1785146668082;
        Mon, 27 Jul 2026 03:04:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f96b9abc0sm26997158f8f.32.2026.07.27.03.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 03:04:27 -0700 (PDT)
Message-ID: <6ffced08-a83a-4262-b6d3-f1e31599848e@redhat.com>
Date: Mon, 27 Jul 2026 12:04:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mptcp-next,v5,07/12] mptcp: sync mptcp skb cb layout with tcp
 one
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <8acd04596a44fa0a03e39f9f3d10a2e301b52763.1778446731.git.pabeni@redhat.com>
 <20260722100104.1241778-1-geliang@kernel.org>
 <190a8af0-1a1c-4bb8-a129-c245511f54f1@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <190a8af0-1a1c-4bb8-a129-c245511f54f1@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OMgKZakZef7Q_LE9HEarcvWdqqvoQVbzIUnJlY3y1vg_1785146669
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 12:25 PM, Matthieu Baerts wrote:
> On 22/07/2026 12:01, Geliang Tang wrote:
>> Hi Paolo,
>>
>> Patches 6 and 7 turn out to be very helpful for simplifying my MPTCP KTLS
>> support implementation.
>>
>> To let KTLS obtain an skb's sequence number, I had defined a get_skb_seq
>> operation in [1]. The TCP implementation was:
>>
>> static u32 tcp_get_skb_seq(struct sk_buff *skb)
>> {
>>       return TCP_SKB_CB(skb)->seq;
>> }
>>
>> and the MPTCP one was:
>>
>> static u32 mptcp_get_skb_seq(struct sk_buff *skb)
>> {
>>       return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)->offset;
>> }
>>
>> After Patch 6 removes the CB offset field, the MPTCP implementation collapses
>> to simply:
>>
>>       return MPTCP_SKB_CB(skb)->map_seq;
>>
>> And after Patch 7 changes map_seq from u64 to u32, the get_skb_seq operation
>> is no longer needed at all. The two control blocks now expose the sequence
>> number identically (same type, same offset), so I can define a single
>> TLS_SKB_CB accessor that works for both TCP and MPTCP without any
>> per-protocol dispatch:
>>
>> struct tls_skb_cb {
>>       u32 seq;
>> };
>>
>> #define TLS_SKB_CB(__skb)     ((struct tls_skb_cb *)&((__skb)->cb[0]))
>>
>> static_assert(offsetof(struct tcp_skb_cb, seq) == 0);
>> static_assert(offsetof(struct mptcp_skb_cb, map_seq) == 0);
>>
>> The static_asserts guarantee at compile time that both layouts keep the
>> sequence number at offset 0, so TLS_SKB_CB(skb)->seq reads the correct
>> value regardless of the underlying protocol.
>>
>> I have reworked the entire MPTCP KTLS series on top of patches 4-8 of this
>> series. Building on the removal of the CB offset field, I also added a patch
>> that trims the duplicated skb head at receive enqueue. With that in place,
>> KTLS can retrieve the record header via skb_copy_bits() directly, so there
>> is no longer any need for a dedicated MPTCP helper like the
>> mptcp_skb_get_header() I introduced in [2].
>>
>> Looking forward to your next version of patches 4-8. Happy to help out with
>> them if that's useful.
> 
> That's good if these patches are helping you, but I don't think Paolo is
> going to work on a new version for these patches. The attached series --
> mptcp: address stall under memory pressure -- has been applied, and it
> didn't need these patches at the end.
> 
> I don't remember why these patches were not needed, but I guess you can
> always cherry-pick them on your side, and modify them if needed.
The goal behind that patches was to reuse for mptcp the tcp ofo queue
pruning helper. Discussion with Eric pointed out that ofo queue pruning
is actually a bad thing, so I just omitted that for mptcp and dropped
the pre-req patches.

Patch 6 could have some merit on its own, as IIRC reduced the
conditionals in fast-path and cleaned-up the code a bit.

/P

