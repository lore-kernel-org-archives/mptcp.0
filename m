Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E61313531
	for <mptcp@lists.linux.dev>; Mon,  3 Aug 2026 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762997; cv=none; b=oVTmLp27vy1d0XA8cfLotvOau5CH5qIbvE31o7KO9Rekv3YT+7OO1Br+zknVwbz4iXWbWkaIGCJwrNr5OMl0xT6u/taAIUCeApASgDaa/kc7f2Nfiob5ONiWJDDZbuGeDkYrjJFz7D5YYcp5hQzMQWHMsSA58Z9jVHBoTntWWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762997; c=relaxed/simple;
	bh=8RXMK0OkGfAfbbNAGBMBP4nWRi16kTZnfvOhVNTkvck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uu6B00yyIsWKr0E23kdMe1J6DHEz6Lyx5gK9AWDtw5GB+ZpFeS0hdZkHRZHQd4YvsBBRaZW7F0ym+vdVQKRjFDn6lwN5ftoeXmm7raptQYU2xehFG5upSBZq2NqMVROb0fcsKO/xEJOEc4pWSlkuHx7rOr2Hx7iFJIlY4a5Lt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNhpZfCz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNhpZfCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785762987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzdRbbpPFYy08EoNBkHrDc9rosP5rQCDCdEJJiDjoSA=;
	b=eNhpZfCzvJSU9rcThA6ybFk0E5yrx0xLQ1TwZ+CFZ+KzjSu49gmst8GIfsJ1WU4HSQzfEp
	B6hhcOHltTxQB1DWLlBlNPYaSSiDR5dznMyCgD7YuHK+RCPQynLMfYnWQPlTORxLYmtKHk
	e61RsO0xNu8db+nFGi6TtcxO63cRZK0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Azz0K2WaOOKuv0adla-R_Q-1; Mon, 03 Aug 2026 09:16:21 -0400
X-MC-Unique: Azz0K2WaOOKuv0adla-R_Q-1
X-Mimecast-MFC-AGG-ID: Azz0K2WaOOKuv0adla-R_Q_1785762980
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso14267015e9.0
        for <mptcp@lists.linux.dev>; Mon, 03 Aug 2026 06:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785762980; x=1786367780;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzdRbbpPFYy08EoNBkHrDc9rosP5rQCDCdEJJiDjoSA=;
        b=Tsibekhv0HfOWvVV5M8B+y1Y4JCojHapgI31vFEJ+/tdQucg5NDuHt9G85bmGHt+2a
         KcdKmViXbpCjWf1+MSqyWgqC2ap50gF4TW2YqPy8n1cc5vwaVJFFKpUcli5/a1R+FSPl
         7/VfWkfHPD3W1tlFfcmW52qkDOnVNjVyOs4MkUQdTSVPfPXHRaZz/efNrxgpMsJmDdei
         Ymuu8NerNyoYsn7Vs3lolAih16TytVYQ7MWOgTMOsyvBTTswZTcUrjUdwwdjgbntoAYZ
         1d4T0IZuFNvYxoKG6vitnUlXGJdv0bYNtORNouXWy2GY98and7vmaItRYFNlF9AFfMt8
         70DA==
X-Forwarded-Encrypted: i=1; AHgh+RoxqGe0FkOEsr840zHJEwHGQ4fiowDLqPgpP3zXLCSGcX534hBZ3vb/D7XAz4HKakDPEeCkZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvmMdtb2yW1YKOWuxwIPNXrUI6M7+cF+KxyrcPZY5E2g7BM6ur
	dJw33iko40nXaqGaMXpGgGBY8aITIIuXPP/IBgjb4drEoZw+8zPnQazCnePDUAPi3h8s/+0Lrte
	CKAibqeGP2cRfAf6e2IBJ+qq7xxvdwoJNQ6zvsfk8euBzfGn6f2tQHx0G
X-Gm-Gg: AR+sD11qIA1sPKj8WjFnKhgqVkKfSnKWRBL/0HNBvDNunODYd/fNKwfRQUj48w3zpue
	1IapCiMV2YMrMYmwhpDJZ88TxUg9uAM57PlMqOct8bRVfFhtV/xv8A7IGVZ6BK5wGpwoKJ/ygzD
	76zVeeBEaanjUu//iUkNDeXggmFUpjkBthy1fXChTotffUX7Xx7fPnDy5BpPcAtKfBjFdkMBIt/
	FtsM8Yug+hEFPYJEh23lAIIrmP9jFoTTLcWVkYjV679P3T7ughycf4z8Di5OltaOzwBXnz9411p
	9n8i2a9GqHJiTeFFiJmIbOql18G19QzXc8Ui4UXctf/MFxhl0BauZyeLBh468w8B/2UQlYtURfM
	A64imj+7iOndxLhaD2VJGlPZqzTFpKqVa3eoxyerBdAcynKFdUyW4RxhgDAKYf+n0KRQxkv6M08
	M=
X-Received: by 2002:a05:600c:3f0d:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4980c673891mr238817815e9.13.1785762979851;
        Mon, 03 Aug 2026 06:16:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0d:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4980c673891mr238816565e9.13.1785762979395;
        Mon, 03 Aug 2026 06:16:19 -0700 (PDT)
Received: from [192.168.188.217] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b67529sm240193505e9.8.2026.08.03.06.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 06:16:18 -0700 (PDT)
Message-ID: <3e83bad9-833e-4946-b29f-cd006ecdc981@redhat.com>
Date: Mon, 3 Aug 2026 15:16:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/5] mptcp: let the retrans scheduler do its
 job
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
 <20260731-net-next-mptcp-oooq-pruning-v2-2-24838164fa21@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-2-24838164fa21@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PvOC4Bz82nng1ApDMnWurur-bo14SCNbiBIRmS6ECPA_1785762980
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:24 PM, Matthieu Baerts (NGI0) wrote:
> @@ -2851,14 +2849,88 @@ static void __mptcp_retrans(struct sock *sk)
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_data_frag *dfrag;
> +	bool need_retrans;
> +	u64 retrans_seq;
>  	int err, len;
>  
> -	mptcp_clean_una_wakeup(sk);
> -
> -	/* first check ssk: need to kick "stale" logic */
> -	err = mptcp_sched_get_retrans(msk);
> +	mptcp_data_lock(sk);
> +	__mptcp_clean_una_wakeup(sk);
> +	retrans_seq = msk->snd_una;
>  	dfrag = mptcp_rtx_head(sk);
> -	if (!dfrag) {
> +	need_retrans = !!dfrag;
> +	mptcp_data_unlock(sk);
> +	if (!dfrag)
> +		goto check_data_fin;

Clashiko notes that the above will not kick the stale logic anymore when
all send data has been acked, and there is pending, unsent data.

That is intentional and safe: if no data is in-flight, we don't need
stale subflows detection.

> +
> +	for (;;) {
> +		bool already_retrans;
> +		u64 sent_seq;
> +
> +		/* The default scheduler will kick "stale" logic, that in
> +		 * turn can process incoming acks and clean the RTX queue;
> +		 * ensure that the current dfrag will still be around
> +		 * afterwards.
> +		 */
> +		get_page(dfrag->page);
> +		err = mptcp_sched_get_retrans(msk);

Clashiko noted that the above can cause bad accounting for the stale
logic. This needs to be fixed.

> +		if (err) {
> +			put_page(dfrag->page);
> +			break;
> +		}
> +
> +		/* Incoming acks can have moved retrans sequence after
> +		 * the current dfrag, if so try to start again from RTX head.
> +		 */
> +		mptcp_data_lock(sk);
> +		already_retrans = !before64(msk->snd_una, dfrag->data_seq +
> +					    dfrag->already_sent);
> +		put_page(dfrag->page);
> +		if (already_retrans) {
> +			__mptcp_clean_una_wakeup(sk);
> +			retrans_seq = msk->snd_una;
> +			dfrag = mptcp_rtx_head(sk);
> +			need_retrans = !!dfrag;
> +		} else if (after64(msk->snd_una, retrans_seq)) {
> +			retrans_seq = msk->snd_una;
> +		}
> +		mptcp_data_unlock(sk);
> +
> +		/* `already_sent` can be 0 for `dfrag` belonging to the RTX
> +		 *  queue due to __mptcp_retransmit_pending_data().
> +		 */
> +		if (!dfrag || !dfrag->already_sent)
> +			break;
> +
> +		/* Can fail only in case of fallback. */
> +		len = __mptcp_push_retrans(sk, dfrag, retrans_seq);
> +		if (len < 0)
> +			goto clear_scheduled;
> +
> +		retrans_seq += len;
> +		msk->bytes_retrans += len;
> +		dfrag->already_sent = max_t(u16, dfrag->already_sent,
> +					    retrans_seq - dfrag->data_seq);
> +
> +		/* With csum enabled retransmission can send new data. */
> +		sent_seq = dfrag->already_sent + dfrag->data_seq;
> +		if (after64(sent_seq, msk->snd_nxt))
> +			WRITE_ONCE(msk->snd_nxt, sent_seq);
> +
> +		/* Attempt the next fragment only if the current one is
> +		 * completely retransmitted.
> +		 */
> +		if (before64(retrans_seq, dfrag->data_seq + dfrag->data_len))
> +			break;
> +
> +		dfrag = list_is_last(&dfrag->list, &msk->rtx_queue) ?
> +				NULL : list_next_entry(dfrag, list);
> +		if (!dfrag)
> +			break;
> +	}
> +
> +	/* Attempt data-fin retransmission only when the RTX queue is empty. */
> +	if (!need_retrans) {

Clashiko noted that an error path could reach here with an outdated
`need_retrans` value. It needs to be fixed.

/P

