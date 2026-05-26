Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE9284B3B
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 06:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777302; cv=none; b=PrHE7ZOIq4QR7ezICOOoFZS79nduNU4KF/SmuecD6GFdtaqrax/fNfp1cGKk/JERMSfHdqlV2XIp0qbhXG87+avpph/nerFw5quvI0bfsVtHvNOAzZcC6jiv3E7Wl09mVq5GwJ9XWS18J8e8i5qSPapO+OdLk16t3DsrEpvYDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777302; c=relaxed/simple;
	bh=vfWLo+9C9cASnj4CegRANxPJGb7Z5SYpxSzoBfQHVj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUbcn+UZt06zZKy8Q030oXsC3ALJ8V/n78/xte+jfxN07Sr6UpcT0jbxxBDsGvqM4olWC6LJnp7nfm78FyYmG0q8SQY3CQf5k4SeoKYl0vJOcZOr3D2UiiDmJvq1h1OlQtW7wbl7IE7Ncxjhle8oSlXN7uOO8ACXpDwEVp6aMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kq9Llxs1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kq9Llxs1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779777299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VTUav0qxeUrb8h/wx1q1Df6kSdlfAURNx74DNnEEU8=;
	b=Kq9Llxs1jItOgwxtgz48l9z6H4cvOYuF1+qbpUhQOZOkUR4N4ZOpvT8ysd9q0uv9oPhw7N
	XFGOOrX/buoDWa/Fj33zveN6Kx5E5UT5kT2VOMo+PIkS1cDWUHR/d8h3PNVZvgjHdT56bu
	lsQ9M5mbDX7Mkz8Wz94q7AotG7n9+0M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-Pe-y9Yk0Pli-MeZE29JzKg-1; Tue, 26 May 2026 02:34:57 -0400
X-MC-Unique: Pe-y9Yk0Pli-MeZE29JzKg-1
X-Mimecast-MFC-AGG-ID: Pe-y9Yk0Pli-MeZE29JzKg_1779777296
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49047e9ca88so29534695e9.3
        for <mptcp@lists.linux.dev>; Mon, 25 May 2026 23:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779777296; x=1780382096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VTUav0qxeUrb8h/wx1q1Df6kSdlfAURNx74DNnEEU8=;
        b=KBwj1GDFjQasVjRi6gVa+bIKSjdLid6M/qceuPx0h6R5yKylnhpdHV1HX2nWPeFNrC
         +33yDNDdVMVcJy20eYjyZucxVCHFDROOszSTv47F8PhjnwkbFu2/75G8krZ7CDqZCk0W
         Oip33DY7fDPreEQ4xKGFZRZy5PvnbmM1W2SC5aJv+wakeb/FbhIMLJWxopOkAiL0s6xP
         vDSL4rE0kpbygaltejqlpLeaMgtLp2j9X7RU00UdM+kt5btgOmC7LfeRTg7vGHYbzjEi
         Oh5Nc4VAoHrwoPLOXDpUPtBcn0Af500YCZ0FKp6uQuzQ6M185EDgxzgvh+5nqDuVfkha
         DRJw==
X-Forwarded-Encrypted: i=1; AFNElJ/LLeQ6S4qOmNVa28d5QDd8KR4MU4XD38PWi5nSG4aATe2AZdNYhEOV76+JF1p06u6vorm3Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2gaUpG4tyTFMC0cCt3O5CcfDI6f+Q14kmRcutsXJ0iZrA8F2m
	l5pvrmZ+BCltAsfAztSxK+M8AmI53Kg8zys/6y4KpdhNmHduX8CaWBAAm6uAppomc2/j/MQfImc
	rNgXnNrJk4cSXbYl5p1ay6qNe4VXsRDjAiwTBMCDedxCPuWAlm9kWnJbr
X-Gm-Gg: Acq92OFB7a1bGIi/pWv25OgHtVAHWllmZ46en1HKzg42ASgBFZtYGDyg2S7VTBHuUy4
	RnkeUVvaKQPjgvfstW8hgfjnyticZzG68p4Dkd8RS9I6Y0RJIXzwzwQOS6BCKjUms1zs1hBCfTc
	QBkJ4ax3cB/Nt1/EE9gquvnt9ZN1lYB2uygJqmpL8sbehr+7fOJFSfavkkYV83Req5CVGHDKCIo
	6Sc45YJ88/plNrU2prdxu5Gu4qOI+G92XdN8Py1V3fhNddooi3Br7S7SwHJRiC0N80XaZ/49YFJ
	GDvy18zIem2KyesAT+Zi4YBKAuZhxLPigAWfHc555UQCdCfR1oSzjR/i11h0i6RlbCEcpjn32RE
	ZRpBH8/Th/OFXql+mRiCJpRoM2qzxy9/UnSTjqFdQCS9EBKypsWdpoSS7bI3g5RvRjr4z
X-Received: by 2002:a05:600c:a402:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490426ddc0fmr199768605e9.25.1779777296326;
        Mon, 25 May 2026 23:34:56 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490426ddc0fmr199768195e9.25.1779777295836;
        Mon, 25 May 2026 23:34:55 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045284855sm302058275e9.0.2026.05.25.23.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 23:34:55 -0700 (PDT)
Message-ID: <7523db9a-b95e-46a9-926f-cbd9be464b27@redhat.com>
Date: Tue, 26 May 2026 08:34:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mptcp-next 3/9] mptcp: close TOCTOU race while
 computing rcv_wnd
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <a8ae9961db6c482c439b6cc7e16514d908af61f2.1779485511.git.pabeni@redhat.com>
 <ed237923f5af60e22739deb2d2bc924f62c1ace9.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ed237923f5af60e22739deb2d2bc924f62c1ace9.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FPi8Mx1RpoSy2iRpv7FW_AZY8DIPJQK2EbcPRZy00qA_1779777296
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/26 8:10 AM, Geliang Tang wrote:
> On Fri, 2026-05-22 at 23:43 +0200, Paolo Abeni wrote:
>> The MPTCP output path access locklessly the MPTCP-level ack_seq
>> in multiple times, using possibly different values for the data_ack
>> in the DSS option and to compute the announced rcv wnd for the same
>> packet.
>>
>> Refactor the cote to avoid inconsistencies which may confuse the
>> peer. Also ensure that the MPTCP level rcv wnd is updated only when
>> the egress packet actually contains a DSS ack.
>>
>> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/mptcp/options.c | 36 ++++++++++++++++++------------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 4cc583fdc7a9..4d72f286a485 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -570,7 +570,6 @@ static bool mptcp_established_options_dss(struct
>> sock *sk, struct sk_buff *skb,
>>  	struct mptcp_ext *mpext;
>>  	unsigned int ack_size;
>>  	bool ret = false;
>> -	u64 ack_seq;
>>  
>>  	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
>>  	mpext = skb ? mptcp_get_ext(skb) : NULL;
>> @@ -601,14 +600,11 @@ static bool
>> mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>  		return ret;
>>  	}
>>  
>> -	ack_seq = READ_ONCE(msk->ack_seq);
>>  	if (READ_ONCE(msk->use_64bit_ack)) {
>>  		ack_size = TCPOLEN_MPTCP_DSS_ACK64;
>> -		opts->ext_copy.data_ack = ack_seq;
>>  		opts->ext_copy.ack64 = 1;
>>  	} else {
>>  		ack_size = TCPOLEN_MPTCP_DSS_ACK32;
>> -		opts->ext_copy.data_ack32 = (uint32_t)ack_seq;
>>  		opts->ext_copy.ack64 = 0;
>>  	}
>>  	opts->ext_copy.use_ack = 1;
>> @@ -1298,19 +1294,14 @@ bool mptcp_incoming_options(struct sock *sk,
>> struct sk_buff *skb)
>>  	return true;
>>  }
>>  
>> -static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
>> +static u64 mptcp_set_rwin(struct mptcp_sock *msk, struct tcp_sock
>> *tp,
>> +			  struct tcphdr *th, u64 ack_seq)
>>  {
>>  	const struct sock *ssk = (const struct sock *)tp;
>> -	struct mptcp_subflow_context *subflow;
>> -	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
>> -	struct mptcp_sock *msk;
>> +	u64 rcv_wnd_old, rcv_wnd_new;
>>  	u32 new_win;
>>  	u64 win;
>>  
>> -	subflow = mptcp_subflow_ctx(ssk);
>> -	msk = mptcp_sk(subflow->conn);
>> -
>> -	ack_seq = READ_ONCE(msk->ack_seq);
>>  	rcv_wnd_new = ack_seq + tp->rcv_wnd;
>>  
>>  	rcv_wnd_old = atomic64_read(&msk->rcv_wnd_sent);
>> @@ -1363,7 +1354,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp,
>> struct tcphdr *th)
>>  
>>  update_wspace:
>>  	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
>> -	subflow->rcv_wnd_sent = rcv_wnd_new;
>> +	return rcv_wnd_new;
>>  }
>>  
>>  static void mptcp_track_rwin(struct tcp_sock *tp)
>> @@ -1475,13 +1466,25 @@ void mptcp_write_options(struct tcphdr *th,
>> __be32 *ptr, struct tcp_sock *tp,
>>  		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);
>>  
>>  		if (mpext->use_ack) {
>> +			struct mptcp_sock *msk;
>> +			u64 ack_seq;
>> +
>> +			/* DSS option is set only by
>> mptcp_established_option,
>> +			 * the caller is __tcp_transmit_skb() and
>> ssk is always
>> +			 * not NULL.
>> +			 */
>> +			subflow = mptcp_subflow_ctx(ssk);
>> +			msk = mptcp_sk(subflow->conn);
>> +			ack_seq = READ_ONCE(msk->ack_seq);
>>  			if (mpext->ack64) {
>> -				put_unaligned_be64(mpext->data_ack,
>> ptr);
>> +				put_unaligned_be64(ack_seq, ptr);
>>  				ptr += 2;
>>  			} else {
>> -				put_unaligned_be32(mpext-
>>> data_ack32, ptr);
> 
> This patch makes data_ack and data_ack32 in struct mptcp_ext no longer
> used. Can they be removed from struct mptcp_ext, and update
> mptcp_dump_mpext() in include/trace/events/mptcp.h accordingly?

Thanks for your review.

It looks like mptcp_dump_mpext() always dumped data_ack, but such value
was always 0-set when that function was called? if so dropping the
fields and adjusting the helper could be a separate/later patch?

/P

