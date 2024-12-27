Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960525777
	for <mptcp@lists.linux.dev>; Fri, 27 Dec 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735292420; cv=none; b=iq5f+NyL5VgWYu6soRWWscCPtxCtu/gVtvs1oVQ2/Gr8uLxqQQJ8U9lxjslOHe0yq63v9gW/R2jHwtfmcdP2DQKX50ltJkEKq2XUa0da2KtLEH7CemlsAXTgKeMBViCVb1tIkrSPVZAKlhO8vJsVAcg6cK8lHlA5kmduZ2iNKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735292420; c=relaxed/simple;
	bh=Y6rhWEIkHjy5haKsA8k4i3dQuRlN2rQKse2iLIdQrwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qnu6Tq7TqnpUB2len6LgfOF24W1AvnvWFDsPYO9VQsFgcv2ZpvjyeCJkwou9aCRDvSTAyMgmv4/SY8sj4lGsg9m1YQyCguIdZQSrUOwoGQ7FHigQ25FXsKIZ/4UiFqZBXLiasd4ewC2g2aippvQ1cG6EWnaJQTa5zOknwN4ZcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrWhFRAW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrWhFRAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735292416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ejz+b/024iaJwUINppSQw939RgGENyUyShNtGokxfEI=;
	b=ZrWhFRAWBxm5nnWonJgG56VaO75NFG819rIPGOzHtnPrsB6CJM/UVb8iWd2Kn/Ssz8xCg9
	Lc63QqOgkVew+nUOYrctO929lSQoW4em/PWZ221p+JaRVqUcZhxRJMyGzRU2BA33i0glUc
	+ipG7NFSu1ZzYNwg5EZ3qkrJt9VFTh8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-6Ft3gOSmOLe_A44aCGQC_w-1; Fri, 27 Dec 2024 04:40:15 -0500
X-MC-Unique: 6Ft3gOSmOLe_A44aCGQC_w-1
X-Mimecast-MFC-AGG-ID: 6Ft3gOSmOLe_A44aCGQC_w
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4675c482d6cso124225941cf.2
        for <mptcp@lists.linux.dev>; Fri, 27 Dec 2024 01:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735292414; x=1735897214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ejz+b/024iaJwUINppSQw939RgGENyUyShNtGokxfEI=;
        b=DDCDbd/tQ6DDF7ikAYQoC0mLTAGNpzmuc8e2RcP5QIAh1MYg47wPYh3Wrn2GZlZ1r5
         uHopZihnSKQ8pyXhIWFnZHG3dTl22yLl8lfbL8+Oj2lAljgF0bXI75vxkaWUjNziKzZ0
         pKL9tunn1PgP4dDr91t4m4KmKKv3s8sVUFq8IX4IYu54aTMRe9eh7orehrtlfD5n7SLg
         west5wfzRWsnt7hJJkU2x7H2f3xga48QmkZzj748dgJyOSBw5aiTAxKE4QbKUpfgxo6d
         NjhPRwA9+hwIQrkgJZv+ENbniU08AXK8D2JUTO98v2k0bJDT+WdWGvbQOX1cXbAT9D93
         j0BQ==
X-Gm-Message-State: AOJu0YwkD5vLHSTTRiBgKDDcmJl/oeHKJAfQgYOHSrBSIhsgDVTEplEZ
	EFXiqs7IHLRJf//Vr+gmHgKKozpd+wDvBpDyBdvsoKsoGq6G5nch7dC/6ksXBdAj6R6kTBmasdk
	/uyJIervZOw22bv2/ltrTBLVCncxc6qBlYadVDo+yN2oDX2pGH5vx
X-Gm-Gg: ASbGncuUJza3AQGiWcqaVBwFDxMhAaTlxHNrZp5FYmqp5CGLmZtwqSUKSBiAb86WB9m
	TC/ZrVtZ/eU4lYlCUcDzxNUG9cM5c5Uq+D48bCaVYZGwDQhRlzl0yi80D3clLi3ET2TND9f5x0R
	F543pBRVIGBIXNdV2QVb3RrRw/58uzQ0FyTS01M6c/gdOUsD2M6AiMbALOxSIDuxL492l/KnKs/
	TNO1+d3mgLaLFnAu7suioo4peHc+YO4HMx8B8vhGJtEJLahZxQHNitxUv/wJ0gADlLuM/i+Lbem
	He3gMCY=
X-Received: by 2002:ac8:7fc1:0:b0:467:5d0b:c744 with SMTP id d75a77b69052e-46a4a8cb0ffmr428695601cf.16.1735292414663;
        Fri, 27 Dec 2024 01:40:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECVfDTc4SSiTol4an3+eZe5t0onmbtEfxMbyV29RIycbKvx099BAPC5PueSSigimRt6lgTGA==
X-Received: by 2002:ac8:7fc1:0:b0:467:5d0b:c744 with SMTP id d75a77b69052e-46a4a8cb0ffmr428695421cf.16.1735292414294;
        Fri, 27 Dec 2024 01:40:14 -0800 (PST)
Received: from [192.168.88.24] (146-241-75-10.dyn.eolo.it. [146.241.75.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6a6d1dsm78195321cf.45.2024.12.27.01.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 01:40:13 -0800 (PST)
Message-ID: <e50db525-cf52-4ff1-94bc-3314878b64e4@redhat.com>
Date: Fri, 27 Dec 2024 10:40:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 1/7] mptcp: prevent excessive coalescing on
 receive
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1733486870.git.pabeni@redhat.com>
 <9c5947ad3b55695cb6000900acad5471b7314195.1733486870.git.pabeni@redhat.com>
 <70d5e604-26e1-43f0-a36d-504d2b99c584@kernel.org>
 <22fe2214-b009-46b1-84b9-84559ebe339c@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <22fe2214-b009-46b1-84b9-84559ebe339c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oUJK-iM2usKP6g0oeWmMoGefwrinKlyTqYyHr-Av79M_1735292414
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/24 11:00, Matthieu Baerts wrote:
> On 10/12/2024 13:03, Matthieu Baerts wrote:
>> On 06/12/2024 13:10, Paolo Abeni wrote:
>>> Currently the skb size after coalescing is only limited by the skb
>>> layout (the skb must not carry frag_list). A single coalesced skb
>>> covering several MSS can potentially fill completely the receive
>>> buffer. In such a case, the snd win will zero until the receive buffer
>>> will be empty again, affecting tput badly.
>>
>> Good idea! Thank you for having looked at this!
>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> No fixes tag because the problem is not very visible in practice
>>> currently, but will be apparent after the rx refactor.
>>> Still I hope this could affect positively the simlut flows self-tests
>>
>> The modification looks safe enough to me: it should not make thing worst.
> 
> Do you still prefer not targetting -net for this patch here? Or is it OK
> to do so and add a Fixes tag?

Whatever is easier to do in practice works for me. Perhaps monitoring
the simult_flows ST flakes could give an idea - if that get more
stable/less unstable we should possibly target 'net'.

Cheers,

Paolo

