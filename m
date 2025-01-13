Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCA233134
	for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757339; cv=none; b=PPtKipOWFrKMFtQNYTg8RbtYT5b58zeAWr88Ok628hYgdRb+87j/q7AYwS1qyZsofvfdDzRKOu/qOUBta474MkL0FFK7NvxGq6V1C1+PUCMhcrxYX63XhIdjyz2GGFLqqSiLMNvN/JAgNiUt7troOgH2krzNcD+p1sBKmmoHpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757339; c=relaxed/simple;
	bh=Fx3aebyuhUfAuPtmJDN1fjP31/gwMpOZ7U7OIn5T2fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ha2EDBmjoEBMoJwiP01EwZI7Q/eO4sXymsFIStR+iMN/qzIJgG8lynWqfkRkTl93n4/iFnhJ1n5U9GmQ+QBjLo3LRUdJv7ktmPRkQ2CqlpLM5U7QKvAuAWbsybUhwxzRJwzWSJRi3HAv6/Rj6uF7OqheoEYx+OrnmNxEXxxSNQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPpBCNMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPpBCNMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736757336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qmV+w5bMOWBR2Vm257grawinoYe73Zjb5utrQdiVzs=;
	b=EPpBCNMoL/+JlSgtfxd9CJEs68GYbirVZhwMNsMyMleoiT2hQW/6MBmkKMw2uA+52OMHC3
	9Lb8tYV0Pv/HYbsajEnxyUfgUDKZ42fcaZbgyFFHc2Ed8L+H9ukZ+nt7+f57jVKR/Aqx0P
	kK5lWhBe8ZX1PDjaek6KfBQdsd6ei4M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-NIoFRf-uPK6no37Fv9Rfqg-1; Mon, 13 Jan 2025 03:35:32 -0500
X-MC-Unique: NIoFRf-uPK6no37Fv9Rfqg-1
X-Mimecast-MFC-AGG-ID: NIoFRf-uPK6no37Fv9Rfqg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38a35a65575so2875030f8f.1
        for <mptcp@lists.linux.dev>; Mon, 13 Jan 2025 00:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736757331; x=1737362131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qmV+w5bMOWBR2Vm257grawinoYe73Zjb5utrQdiVzs=;
        b=A3sZcTIxwXBAT8MFpAt1im84gAnQt+j0H13D++lvue3FRLiR81Hs/IEGeZYKt/I+r8
         UBNMy5wuyzfpkrClQk3jXDI4DD2/teNhPRiDMZd90xyw9Sb9PNCvGOipyeoh0xycpkXE
         kv6Ww7ARXLZnRLidz64xe0cg+mybjMhpctWroMC3PqKqwcKbj/k20P635nzEsAwpObHP
         YzowJFwdnHqC1c6YicJ+jIVXqv4grLiP3N+diWmrZFiNafLEzPXba4BjYmpuuZxI1bQa
         iSkEvTFTq4fCba48qjcIKTzetNVlsV1GU5OKndF5S/fmUbuQ0gKvBD6A6ooDMSNpYTXh
         tAtA==
X-Forwarded-Encrypted: i=1; AJvYcCWlUDH99MZTu0z1NHDqUhj8RHmGdYbhz2sDJA+VtqdOp4OJ6hU36Wssj1fuJT3EwYHOgZhuKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxofIKF3YPONmx7xeXSaDlokJm5ZEQeIU4Y+0y3xwXFMaroJ8Yo
	hOh8vFO5OVRcdIaFiAvQHh7EXKf2TMWotz0V69EMBkXddtUgmJAwwGApTSPiUOkg2v9sUsDbR/z
	5r7BUVlKodQMQclD44VCDGFutVlxwN253wY+I4TFjlDvLmkOSuKb1
X-Gm-Gg: ASbGncswxdFC0JcANU7HmN+DjNO3kTAT3soatxlqXPFJOAUt/y1O1TVdCUwirxiGlYK
	TLPkdlsTlINhnf3tcD00eABvrLhKVYYIRlkuLeS0jKA6ycQ6TwTeFP7/8H1J8uPsY+URhWN58dP
	F98SSrKyc2Gx5uK5h4CE713FK2zWyTqEPF2VNxvLMYdpOvxkX5q/kTnD5DO62dpSoz+g47Az0bS
	5B6WSRp8MjuHP/14XMhMrkZAnMmMewK63prtQabGKXjALTmzljjR2Nk1kWM6MZPzOL2I+KASNhb
	KnL1xfDRLYg=
X-Received: by 2002:a05:6000:1542:b0:38a:a047:6c0b with SMTP id ffacd0b85a97d-38aa0476d5amr7169822f8f.35.1736757331602;
        Mon, 13 Jan 2025 00:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBQZLWFvAasoP4u7vtzHNQ49++wEYKH4qPDQHay6/gL9PVe8Lt21sXUR06V+i9Sek9hh/Y3g==
X-Received: by 2002:a05:6000:1542:b0:38a:a047:6c0b with SMTP id ffacd0b85a97d-38aa0476d5amr7169796f8f.35.1736757331274;
        Mon, 13 Jan 2025 00:35:31 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1f2esm11606821f8f.98.2025.01.13.00.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 00:35:30 -0800 (PST)
Message-ID: <6d5ca592-6023-4368-a7e6-8fe99366f426@redhat.com>
Date: Mon, 13 Jan 2025 09:35:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 0/3] mptcp: a bunch of fixes for ST flakes
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1736527092.git.pabeni@redhat.com>
 <76550d25-1422-41a1-af00-f65a6ba24505@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <76550d25-1422-41a1-af00-f65a6ba24505@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L8gi3yG25Fifcl4tdriDgAWKihH9RY6H8EpPt-v516E_1736757332
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/25 12:39 PM, Matthieu Baerts wrote:
> On 10/01/2025 17:43, Paolo Abeni wrote:
>> still under test locally. Sharing early for larger coverage.
>> Among other things, still to evaluate if patch 1/3 increases the ack
>> frequency "too much".
>>
>> Paolo Abeni (3):
>>   mptcp: be sure to send ack when mptcp-level window re-opens
>>   mptcp: fix spurious wake-up on under memory pressure.
>>   selftests: mptcp: avoid spurious errors on disconnect
> 
> Thank you very much for these fixes!
> 
> They look good to me and the CI, and the mptcp_connect.sh has
> successfully run 1250 times on my side:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Great! thank you for the additional testing!

I suggest to send them to netdev soon, to hit -rc8 and possibly spend
some more time on upstream PW before.

Cheers,

Paolo

