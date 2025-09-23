Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106D3164A1
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644167; cv=none; b=ENFbEcZhWljU+xtlYCqsc6H4nXsyz4rdd4KS251ROooz997gYCx9ojwIm4SKxfet5iPSCeaBTIG5FvLXGuec8cO3EMiHZrUoJbi7emc060WmAoZQEu6oLuXIUBA0irp5Ee176S/3aZaIZ/kxXnotg4ao/KHXLXL6KS4tKUlmYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644167; c=relaxed/simple;
	bh=yMncpFFp5VnkyB0Ly1fxXn79qXEgrBQj2oYrKBVrhXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jpj9edEqmQ6Tkbb4JVCtsawMHptMxCBcck4i544dI/+Jvaoi2d34sKoEkOcdPPXHP4ksX4U0fvUpcUQK+ZGj+FLZ1usDwFnIyEQC5Y8f0VvEQV7QAkTruJuO5luSYYag/oxsAkm0TjYUck+ik98p/tClVgSDdSdp9E+NeYgKdG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6tWruts; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6tWruts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758644163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqiIz1IW6YhQewV9J2BO/Oc7JN5+tz2BN+RG8zUQPiM=;
	b=Z6tWrutsPdnmnfWN5Q+19bMHjvo3IKdzCcePCOjRyvAUUmLbFSSSqkjMkhWie/EF5dFQVT
	yoqBp2GDTwBO1uYwlCCiF2Tikn1l99EVHrfz1jkM/LLDjoBQMgjEhw6d8Fa/Enesupuf/j
	sY1W5zgy9YX7f3nmL5o9ISxp/9JsCd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-_0yrjnfIOoiVGY6w_djtPg-1; Tue, 23 Sep 2025 12:16:02 -0400
X-MC-Unique: _0yrjnfIOoiVGY6w_djtPg-1
X-Mimecast-MFC-AGG-ID: _0yrjnfIOoiVGY6w_djtPg_1758644161
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so2546495e9.3
        for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 09:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644161; x=1759248961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqiIz1IW6YhQewV9J2BO/Oc7JN5+tz2BN+RG8zUQPiM=;
        b=rxER4l1FRUN+u2bMKhMOhjf48Nnt782wum1GAwG7TJ//8dt7jsu5M2LW4ZP5zbhbdS
         8PoNjv2vPzGV6aRaaYuOItWuxZ70uIBZPBRbMWudAlxtJowiVVk0Mm+eyoOYxH7ccaf2
         WGe9f4p3Oc5zmSYxnNAP6QvNGxKMY34UqpJBaYSKXMlkE6qS69K/LYJ9syIyrOmrzMUh
         JnCY1SpUEvjaBKZqMmWtgL240JVP09Olnag+TijUalOSeH4kTLn6p1prkwytmgKCQaiz
         Dgim1MnBj2gsnvUH3PMpOgietT1F/VhsXG3sdJj9kA/gfFlW9RD7uaaxrJEsmVfKK2Qg
         rWqA==
X-Forwarded-Encrypted: i=1; AJvYcCWZNOaVD7gdt6CYqrRPuvN2rKXOsU9wbROIfZqO15HguCT0Unr9OBY7xRRYt4UEhzNUMEjoNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXin8bCNq+B2/c1gkFpSaote7A+zHjpFpv+qgEeTbE5km1rT+2
	yUhsDoK++vAq8hrQMXG/11lbvcTlR+nAtkKibvTamspjA8d2i7DwBagL3+2nkH8HOjIOYDDGidr
	UHCYuzbq26OAIlOz5bAyor4kqzMje0QXL7LsAYDMvHys6kIE5phEDYJfUQx8jICYm
X-Gm-Gg: ASbGncs7dJlJypY/XjSpVbYVoNRI358E2iKdaCk1DIdvfHqdTYlLzlPYaf00UouBEAU
	syTXcJnF65ZU93nuzozOHTPdImNuOJgrDw2pjMGeyweHtqKrxK4J/sd0ZJXQpbthxSIaYnk4H3m
	RycaWYhvBxfaj3FTyW4YkzF3Emgv7AGVz7ud0P1CVMhnfZHYHlB1FHh0hWs1gRx1C9ewgDoO7fQ
	6vrv10qhMniaQluZb3diM0QB41KoZ4hPN8DTt+Ufu5KnV4n8gij4+Gm1uXBla45Pta6YgpTpgxU
	bRzgTkH291JWhcq1EBQXht0SlY9MR8pN3rUpttOvyHJehkQEfW19fMlVcZNZ6Hbs+Z/D6L/2dK5
	tdSV1KaJZ831l
X-Received: by 2002:a5d:64c7:0:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-405cb7bba1amr2209430f8f.47.1758644160917;
        Tue, 23 Sep 2025 09:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGClt8WE+gv/EGmiPgGppTmtntAppLVNjEouvhJVHab+6HQh/EYuNyt4cIsnZh1oljC6eGuxA==
X-Received: by 2002:a5d:64c7:0:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-405cb7bba1amr2209414f8f.47.1758644160487;
        Tue, 23 Sep 2025 09:16:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f99178390csm11824472f8f.44.2025.09.23.09.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:16:00 -0700 (PDT)
Message-ID: <cbc8cc0f-7806-4807-869d-e9d6d2fe6ce5@redhat.com>
Date: Tue, 23 Sep 2025 18:15:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MPTCP next v3 00/12] mptcp: receive path improvement
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1758296923.git.pabeni@redhat.com>
 <4e5d00ca-1317-4f98-952b-e7ac058c52b7@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4e5d00ca-1317-4f98-952b-e7ac058c52b7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: my2s_yVR6CdF0Zz6MWPoXnGtu0P7WlNcsooyZy1oLPU_1758644161
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/25 11:13 PM, Matthieu Baerts wrote:
> On 19/09/2025 17:53, Paolo Abeni wrote:
>> This series includes several changes to the MPTCP RX path.
>>
>> The main goals are improving the RX performances _and_ increase the
>> long term maintainability.
>>
>> Some changes reflects recent (or not so) improvements introduced in the
>> TCP stack: patch 1, 2 and 3 are the MPTCP counter part of skb deferral
>> free and auto-tuning improvements.
>>
>> Note that patch 3 could possibly fix issues/574, and overall such patch
>> should protect from similar issues to arise in the future.
>>
>> All the others patches are aimed at introducing the socket backlog usage
>> to process the packets received by the subflows while the msk socket is
>> owned. That (almost completely) replace the processing currently
>> happening in the mptcp_release_cb().
>>
>> The actual job is done in patch 10, while the others are cleanups needed
>> to make the change tidy and more follow-up cleanups.
>>
>> Sharing earlier with known issues (at least on fallback socket) to raise
>> awareness about this upcoming work.
>> ---
>> v2 -> v3:
>>   - (hopefully) addressed CI failures
> 
> Sadly, the CI doesn't seem that happy, but only in debug mode:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17863851247
> 
> If it is easier for you, I can already apply (and send to netdev?) some
> of these patches? e.g. 1-7/12?

I did a bit more testing. AFAICS patch 10 introduces a few chances of
additional failures (even on top of Geliang's patches) I *think* patch
1-7 and 12 are safe.

Thanks,

Paolo

