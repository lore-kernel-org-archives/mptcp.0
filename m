Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C035CBC0
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940165; cv=none; b=U0lUEXXtGPbS9wbTQ1guVSJBrVS1W95GsCRnXqUZEB3kcf6J06GtAJnnDehA19sOSfaKJf2jUmRksYqyMdGamtaaLXaFZlGu5SlEeKL0/qIZWxDoyDQNeAuQqAQEja5v7cfzK5Tl6y3o6efWgUPpIwtzdEXL8CRPfreCWh53eyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940165; c=relaxed/simple;
	bh=lS/GtLUL1Ogd/lwRGL81+rt1TWjwvkIbKrQKCx0LNNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mDpZJwHZIJ7Z2PWUN2cjmO7A/OYsxeWC35p6Sg3GqqnX8eTAspwcKfsEy/+4DCFr6pZd2S5zE2wJPt2cUFugXO0YuainF6r297SjGfAmXfX9bNnvVoQty+T8kzICQPxNg/0uj1ejBpHvYGlWLDBcIkzE/WsmBpQp2dHPuiL2PcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZpLJfx2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZpLJfx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtfrC2RvFpORTnpNpgWrp3RGfFCfIJySrJBh7XMsxjY=;
	b=FZpLJfx2dsZUNFgIthLYbCCiNALjR2lq/HFRbW8IAGRqO/MIC+mIPOoxrJbqy4ghCu4kX1
	Z8W2ARMRIViq0Hi+KBjBZU/58A5kQ3WCoViZdEOuNXNFCXjqlmxEggCmoJihMxcQycSAg0
	B9cJJHl/KQ64bFNX+TJhEOt4yVkw5jc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-s0iQheRHNkOibacDhLLzrw-1; Wed, 12 Nov 2025 04:36:01 -0500
X-MC-Unique: s0iQheRHNkOibacDhLLzrw-1
X-Mimecast-MFC-AGG-ID: s0iQheRHNkOibacDhLLzrw_1762940160
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b4961ec4eso312120f8f.3
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 01:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940159; x=1763544959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtfrC2RvFpORTnpNpgWrp3RGfFCfIJySrJBh7XMsxjY=;
        b=uheB+H9Umd1LckmsRAmZ0cfRfQ/uNp3Gw+KmMZS3LBSOSdJ5DP2nLZYJBeEf8hAvx3
         q1aUKCq9C2w99VV76UgkE61fiXLbkXAyvkwqBtqB0Kd1UTsVUTsVIZRZJ9ndD+s2Mnw5
         wMIXTdm785P0hAfZsa1k5Nf1zJsq/Tw3DZyfJNLhVU5Y67pHxeqVEh3jhWDvuYoNjD4z
         Ol/N+4yLYq/RaraGrC2eKSHWndIjHqAeZS8HGvO6C5ch6v8nu1GGlxrULxFLDwrlKrEh
         neajGgJwx37q3+uuAiriSuuinIL/wBwC99OGIPGEIuPcsw1ccCxa6qabHqWWc5tkcQNH
         wsYg==
X-Forwarded-Encrypted: i=1; AJvYcCXEZ6lkGaIHJrN2pbKWv4DD6uKh7L57vtPX/V5GVfnn8VG3lNERvKhpQC0pvbIDHjiDvLTtKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBadJ1LH3/2DMPPYT73yR5IzVboPdwKTXlVWYrolRJgsLIaP66
	o1R/b9RIg+nZgSBgPyih27ZK70ylq522/7CQv74Tb4nlnGf4pp/8hLEn47UJRgfwfBDC1efEyi8
	tdZBZMX7pLVUUfWmUAuthvWrFDmhUvHa6Wk0xtZUB0SlUVOFgBmINwS15TNsivD5H
X-Gm-Gg: ASbGncsSuBpojRXi7WPzdP4bK3RDNvB/gsC+qqtRqHaJrhtSVVwh29+oXGsXiIUSV++
	l7orHlNYnuoNjAPt4WSNVphBwoBlTtl+JcZsQB90jwdh4iZlKlK/VeWyof0PjPs/I5ecHmX8AJf
	x5a7s8bkU13T7PYSb2d28+P8jme+mORNQUz4k2i92qFaLgVDlFOQ1eWTQVZZ5NSZX5YFDULgIWR
	ZhkjuTypS0pLbBGZYGpljIpnvQmk7GRTOrk/x2/3M3Dn2ZgFgilrVuev3RWX5XL2Hm1SbgFWUG0
	A1XznZuREKAF0C2kdBftXlDS+o7v9nGBPLttIe3edX7oQFucHDkZI9yYTgQcGLpzlLa01koEnJA
	6lw==
X-Received: by 2002:a05:6000:40cc:b0:42b:3878:beb7 with SMTP id ffacd0b85a97d-42b4bdb83c8mr1506588f8f.43.1762940159482;
        Wed, 12 Nov 2025 01:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPTn2ddrh0Agv3RfMXRStw4ykZE4VXoksmvjz4PpFFwI1tvjbbiUgmwNPGa1Ay6zBQkBnc9w==
X-Received: by 2002:a05:6000:40cc:b0:42b:3878:beb7 with SMTP id ffacd0b85a97d-42b4bdb83c8mr1506569f8f.43.1762940159087;
        Wed, 12 Nov 2025 01:35:59 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b4789896esm7294992f8f.38.2025.11.12.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:35:58 -0800 (PST)
Message-ID: <209462dc-d6a1-424e-a93f-0414e21e759f@redhat.com>
Date: Wed, 12 Nov 2025 10:35:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 0/3] mptcp: fix memcg accounting for passive
 sockets
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1762551942.git.pabeni@redhat.com>
 <b35ac728-dc25-40db-9fdb-8242e857ed87@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b35ac728-dc25-40db-9fdb-8242e857ed87@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nnu7wIqEMjfieJw76f-NLS6chhEbSq_mFxFk-O5-gVw_1762940160
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 6:26 PM, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 07/11/2025 22:55, Paolo Abeni wrote:
>> It turns out that the splat reported earlier is indeed due to an old
>> bug/missing feature that hit hard on top of "mptcp: borrow forward 
>> memory from subflow", as we can borrow accounted memory from a socket
>> not doing any accounting;)
>>
>> It should land upstream before the above mentioned commit, ence the
>> 'net' target, but it could as well be net-next material.
> 
> Thank you for these fixes!
> 
> They look good to me for 'net':
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

If you don't have applied these patches yet, please wait a bit: I'll
send a new revision including a minor delta to make 'Squash-to: "mptcp:
leverage the backlog for RX packet processing"' smaller/less ugly.

Thanks!

Paolo

