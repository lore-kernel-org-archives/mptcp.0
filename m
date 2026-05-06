Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929B3EBF36
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060045; cv=none; b=FiGQtwrPaRLBsBwqxrmJkDHP2UHhRXA3xPcKoGkHjS6pMXASd/ejP9JDYiRm7kif919j32CQbPxBBnZ7UZeNcslljD0M1VNtIOVf07Q6tlq8iRtqs0bYXkKTsHKDeX1gqO3A4UC1Luhsf4BH50gtpKbQrWduQtyjVME5KVbOsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060045; c=relaxed/simple;
	bh=x7iVO5tMZWyw3kq3MajqynVK23j4DzR3YS2hH6JiM9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qy1V5xzY7zHmlQvBwCZFCs921hUpSWsWQ/yVF7haAXjnFzXt+j5NUt4HR2MInpg+ewyJcgdnOtRyotrKR3CJJH1WL53fyUF0B8yduxb7M60Tq9MBNCa/+3ebjruv97ZcEn4EWpjnx9UjGSgi5zslbGR7ZggfwyRwc78aKOTHi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCoBK9tJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCoBK9tJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778060042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BvQlkstqTg2icphAdrFwR74lVhzcQJAmNqUJYPdTvI=;
	b=KCoBK9tJ7OpFhUCTAjey+DS1/6ulhu9QABrE4fHo4OXGR+J+dUBZUUzTSpe4gmC6t/Eu7I
	mWdWHK2+W1Ww9iMnShrrkeKnrXlnfjEXNiSInzzSHyL7RGammlep656cuub+uOLHz2axvB
	qf4pKJNrhvVIb6oeiKbwnLwviwKeQCI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-6f9TMIjROcCH93WIv5_NPA-1; Wed, 06 May 2026 05:34:00 -0400
X-MC-Unique: 6f9TMIjROcCH93WIv5_NPA-1
X-Mimecast-MFC-AGG-ID: 6f9TMIjROcCH93WIv5_NPA_1778060039
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ba84b4c7130so508478766b.0
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 02:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060039; x=1778664839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BvQlkstqTg2icphAdrFwR74lVhzcQJAmNqUJYPdTvI=;
        b=WNBuCYwICMUPeMMi48Z4UWe5mkgWrCisTjqldnTWp+CiJByf77DSfOvyK2Ig47Q93R
         /KOVT3JvotNzuntRKPk6an5tPE3jWHLvYWth49aMqghMhBDm+dCyrqevhXskX46BglP7
         cnAyO6tL69BeB4iXEoLIERoTnZDLXBlPFg4Cp71I8e/rKkow2m2vP1OyTHh/ITapzkT3
         xoNKvo4CWUvweDExUHXTtMTDSiW3n8xvweY8BGjQ05eAnLG0l94k1JFrbA6+PUe7tlVk
         2lhX6U9dA80nMrBexXJblY7mkMlgvt7FiUY4/Lr1rhN/e18+naX0JW3qTp+qRan7QeAD
         ouwg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZPMCuj3wMRhxtGj6yHlpPf2hUSDxzRK0Dvh1/Z8riQa+sJHYPdnRhYSDrg47HcoXb0oD1bA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDQTyRxyN0Ru3ddQFcvgxE1J4aP9ZIYA+5rq76Ckbo8k5q1JkL
	M3TS/FMHfIHYdXg+BVLSGBg6IDGIrgANGPefdTr5QD1g3oBtC6K3igULoiMCRFJTV9P/Cb526Bu
	ZuGGMEoQzLolvcZBfPa5zdPFGAVcef7q7ns/tY9P0+brYq33DsHig3Jix
X-Gm-Gg: AeBDiev7Gn4PEvvfRxpSTYYijdDykV2OBRN2KvIOPZOVvbshFzI4AUKgPxFxt6PaPFk
	eoTRxlsr/TqUtpHw4yvpT+e2bNVOXcSTIXwNuzWlab3bGzFWDo2vtk1yqtsnBn2edLkFDuj6bz/
	i4ptzsJe+crKEAY+FKWQJLIOGoJ0wmSN8KiWgi9LKwRxDp+C2nN+ZSUWTYlfyJt8SOYT11cgITt
	1wgeWzfB6i6LMUoEO+G8ziiEg2GvXCnGaY0DSUqSznKoYJIJx1irdlSlteQLm1IDBGKqrnAvQ5J
	Vk36xJnFNhu6JaOJWEfamyBYTWlAdJNpVRFf2DQpqlyQgPm9pGjS7rWgCLhLSefTVlNLLYHhfW7
	oEJcohAqvjYSZsduuUVYmDIlqnltLHYOg4b+zTPBTS9SJbLNCa+Q6H8sz7TZPQbyyNpY=
X-Received: by 2002:a17:907:3d52:b0:bc4:f43f:f3af with SMTP id a640c23a62f3a-bc56cc2f934mr114265766b.22.1778060039309;
        Wed, 06 May 2026 02:33:59 -0700 (PDT)
X-Received: by 2002:a17:907:3d52:b0:bc4:f43f:f3af with SMTP id a640c23a62f3a-bc56cc2f934mr114258266b.22.1778060037559;
        Wed, 06 May 2026 02:33:57 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc55be66658sm62823666b.28.2026.05.06.02.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:33:56 -0700 (PDT)
Message-ID: <958e6f87-521d-40bf-aad6-e188a12745b5@redhat.com>
Date: Wed, 6 May 2026 11:33:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-next 06/10] tcp: expose the
 tcp_collapse_ofo_queue() helper to mptcp usage, too
To: Eric Dumazet <edumazet@google.com>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 mptcp@lists.linux.dev
References: <cover.1777908248.git.pabeni@redhat.com>
 <eec217c214e8db54355c7708b328c34a92c2bdcb.1777908248.git.pabeni@redhat.com>
 <0c361889-533f-4467-b908-0774dc23f08d@redhat.com>
 <CANn89iJk+0M6hAxx+L8vfLzCzo=_7E141BYty8F4CiBUM2F6hA@mail.gmail.com>
 <1bcbd71b-8b7a-42d1-9726-c8b58e3bc3ad@redhat.com>
 <CANn89iKzAM87Sc+1oyr1LQJcg1qTLHULjq-N1oteLZq9uAz7RA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iKzAM87Sc+1oyr1LQJcg1qTLHULjq-N1oteLZq9uAz7RA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DGZfRnkA0Bf60zouO3pB75XFOZ_fPWjqwkCLnUUqmwc_1778060039
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 6:35 PM, Eric Dumazet wrote:
> On Tue, May 5, 2026 at 8:57 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 5/4/26 9:07 PM, Eric Dumazet wrote:
>>> On Mon, May 4, 2026 at 9:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> I'd like to re-use some existing TCP helpers (tcp_collapse_ofo_queue()
>>>> and tcp_collapse()) in the MPTCP code, to avoid duplicating the non
>>>> trivial logic there.
>>>>
>>>> The idea is that the 'struct sock *' in such helpers could be either a
>>>> tcp_sock* or an mptcp_sock *, and the processed skbs could be sitting in
>>>> TCP level queues or MPTCP ones.
>>>>
>>>> That poses some hard constraints on the sk fields that the helpers can
>>>> access. To make them clear I'm renaming such helpers using an 'xtcp_'
>>>> prefix.
>>>>
>>>> The full patch touching the TCP code is below. For completeness,  the
>>>> whole series is available here:
>>>>
>>>> https://lore.kernel.org/mptcp/cover.1777908248.git.pabeni@redhat.com/T/#me6eda13ec2c70fbb400b6223aa2d07a4fd3bf865
>>>>
>>>> but I guess most of it is not interesting for you/from TCP perspective.
>>>>
>>>> The MPTCP bits are not yet finalized, but I'd like to know it you would
>>>> consider this approach doable or a complete no-go.
>>>
>>> No concerns from my side, if we except the fact that TCP collapses are
>>> a high risk, we might
>>> remove them completely (or at least guard them under a sysctl)
>>
>> I'm sorry I can't follow the above suggestion, could you please rephrase?
>>
>> The patch should not add bugs to TCP collapses for TCP sockets or MPTCP
>> subflows (still tcp_sock). Collapses for MPTCP sockets could become
>> buggy if the tcp_collapse_ofo_queue()/tcp_collapse() implementation will
>> be modified in the future without care.
> 
> I think TCP collapses should be avoided like the plague.
> 
> They were ok 20 years ago, when 'line rate' was 64Kbit :0)

Understood, thanks! It looks like the sysctl is a bit hortogonal to this
patch.

FYI, this work sparked from some TLS-derived self-tests (sending data 1
byte segments with OoO) hitting the collapse condition with MPTCP. I
think a similar test would call for collapses even with plain TCP - the
main difference is that with MPTCP and multiple subflows OoO are
physiological/frequent events.

Thanks,

Paolo

