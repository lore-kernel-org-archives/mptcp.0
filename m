Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AF27A477
	for <mptcp@lists.linux.dev>; Wed, 15 Oct 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518867; cv=none; b=qfQeOoa3I9fTclNaJpXl9wqbLE1L46khFI+cjVPz1yS7+L8e15vj2xFJczBpk6IFjbwj8HbmDuw33V1EKKg/4Nfh2eRBrL+XeJn+VZtwTEJhrxSPqau6K/DG2aQgmWME4eCcuj50PMB4CtqX0+b00wwImNh7+TdaeOMu8Px92n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518867; c=relaxed/simple;
	bh=9aIFmomoDkGBGVhrRFSdPqdeFevELkJilAXumilim+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pH0al+1EIL8We/0LOXf+CSbsb9GEftUyKp9CcIIh2d8xXxUCn9ZxF0mi5HHL1dQa9Sfwtg6K6+A0uSpD2/oIUWrCEnzGnq2+sySaYFg6jQ5Od7endoF8szTFV3IB20clZhtCCOhmCJ21TUWl8ZpnRQyfGgmQdd77TfXmW1VgtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxtFKB8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxtFKB8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760518865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfsErz0rcHH+KXLYFvWvaXytMPz/ECbRpqukB/I8f6s=;
	b=PxtFKB8pHFoY3+aR+99GvFf9mshelNl16akylJ2b1V8yZiv403QyQUQ+XHuYniW5ts2E2y
	XzSynTEblnRd0nP/BG6PX0xQsAqzzI72lR1sfmY/JCSZArL9Cs2xIww/992+DzmclNVjYH
	id7OuYCKyAjKHB3bKqktVF4DBmP3jQE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-rfi-fN74O-qSj5ZsWNuxvQ-1; Wed, 15 Oct 2025 05:01:03 -0400
X-MC-Unique: rfi-fN74O-qSj5ZsWNuxvQ-1
X-Mimecast-MFC-AGG-ID: rfi-fN74O-qSj5ZsWNuxvQ_1760518862
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so1854955e9.2
        for <mptcp@lists.linux.dev>; Wed, 15 Oct 2025 02:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518862; x=1761123662;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfsErz0rcHH+KXLYFvWvaXytMPz/ECbRpqukB/I8f6s=;
        b=vJWQ5C9AHpNBOnMGkkO1ejeM4s6Ae3uji6F94DyCVTClyCjTkwXobuvNe5IYMfBZmh
         bdybXMQqqF5gXXlHLHManVKwbjV3rxFtFAVIwel/Ng5i6ekQqGnXQGjRzgEoGW/of/ay
         YFvljmeCSHj34S0Nbmwkm0eNsaUo4/D6ttxu+EtJRtI+2bv/XBTP7CyK28GKuS7F7haD
         lIaAdiv0LMYjxTnKS3a2EuPBUchcGl+3vLfsCxkmjgLclRbWJvgWZJHtHPufnFwyqlis
         0t6glAA0u0lJH0qJRPSObiVhe3xQls/8qAH+hd9tGDvhd3zIH5R+FI0ThPGWimGQxwMZ
         TV6A==
X-Forwarded-Encrypted: i=1; AJvYcCUDxYYZ7rHWfjbjWCdxz5d9G4aIbvdsLj9O7QopgzXYx2BJ9WKrmX5TGn1SqpAGnCm6fqggLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/RSDj6qeilqARrbQOT+Yw2QZuOCKhQ0a0OYtEyp82gNfphvDe
	3lV2yRcgKQp+MAgPBmq41LUnfB7LR3cm3IoWPUU2/II0rGhv7wthj2NrKp6o6gYYVqXEb2/Yq7S
	zgz2r8fbNuonIA13zyjIQzxmqMAprE7c861X0OHR5PjII7X0vTHF4gPXZ4RA1bZHZ
X-Gm-Gg: ASbGncuCLNCy3NSiB4ISy8Gumwizb87EmNoYL8nA5dgc0YaZeyN+wjhHGlI8oJeyCIm
	pni7hNwJPXLTI5Sl7AgJt6KN7oY07l6gYAQQjdxpru/KegpWvluA7usDbBb0X3XWQBjf6RMQs9+
	XLM699sX8nzqCFh/dhpDJjMJe75LcPZU+M6s2ztjNTPqAP97LoOEZBbMg4OX9+IZGVpqubyrCX4
	ws+FJCJRLzH0mNeDx9fCD0Nkz2v6BLsyzR8GA8v0/KkabZ4z5emNHoJFI1Wj6VS/87Q1NvAteXR
	Xdkc0ybrDKsN/1DxzbVuki4N1QIIewfeWp7WjEnf/8MUD1u44HaIWUqi4Xk5kTATrso6rWGzDlV
	aVg==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-46fa9b11794mr196239655e9.37.1760518861869;
        Wed, 15 Oct 2025 02:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0aA+RlzyS4p4XpBJzeD+4TL4kQr0pypx9Cl0q5OSm++krqAWFLYCUSRiYxwy1TNl3x1qtNA==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id 5b1f17b1804b1-46fa9b11794mr196239375e9.37.1760518861371;
        Wed, 15 Oct 2025 02:01:01 -0700 (PDT)
Received: from [192.168.111.78] (ip-217-65-133-14.ptr.icomera.net. [217.65.133.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf71dsm26898851f8f.29.2025.10.15.02.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 02:01:00 -0700 (PDT)
Message-ID: <281e24d1-da6a-493e-9d12-66bd3cdd7ed4@redhat.com>
Date: Wed, 15 Oct 2025 11:00:59 +0200
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
 <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com>
 <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com>
 <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
 <20a3df573803203df6b672d1ecd606e242e84b20.camel@kernel.org>
 <ef0495fe4e1012bb4b68a72361bdeb39872d96b6.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ef0495fe4e1012bb4b68a72361bdeb39872d96b6.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kv9pWx0mGYMNYwlGmWLqP6skWNnLABcSFpwU_gCYs6Y_1760518862
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 11:07 AM, Geliang Tang wrote:
> On Fri, 2025-10-10 at 20:22 +0800, Geliang Tang wrote:
>> Hi Paolo,
>>
>> On Fri, 2025-10-10 at 10:21 +0200, Paolo Abeni wrote:
>>> On 10/9/25 3:58 PM, Paolo Abeni wrote:
>>>> @Geliang: if you reproduce the issue multiple times, are there
>>>> any
>>>> common patterns ? i.e. sender files considerably larger than the
>>>> client
>>>> one, or only a specific subsets of all the test-cases failing, or
>>>> ...
>>>
>>> Other questions:
>>> - Can you please share your setup details (VM vs baremetal, debug
>>> config
>>> vs non debug, vmg vs plain qemu, number of [v]cores...)? I can't
>>> repro
>>> the issue locally.
>>
>> Here are my modifications:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/geliang/mptcp_net-next.git/log/?h=splice_new
>>
>> I used mptcp-upstream-virtme-docker normal config to reproduce it:
>>
>> docker run \
>> 	-e INPUT_NO_BLOCK=1 \
>> 	-e INPUT_PACKETDRILL_NO_SYNC=1 \
>> 	-v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>>         --pull always ghcr.io/multipath-tcp/mptcp-upstream-virtme-
>> docker:latest \
>> 	auto-normal
>>
>> $ cat .virtme-exec-run 
>> run_loop run_selftest_one ./mptcp_connect_splice.sh
>>
>> Running mptcp_connect_splice.sh in a loop dozens of times should
>> reproduce the test failure.
>>
>>> - Can you please share a pcap capture _and_ the selftest text
>>> output
>>> for
>>> the same failing  test?
> 
> The pcap captures (gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
> connector.pcap, gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
> listener.pcap) and the selftest text output (selftest_output) are
> attached.

Looks like the 'stuck' scenario is quite consistent. The receiver filled
it's receive window, and sent an ack shortly after when re-opening, but
the sender did not react to such ack.

The perf instrumentation I mentioned would be very useful. I tried to
capture it myself, but so far I failed - the repro run for several
hundred iterations without issues and finally podmad stuck (podman bug
apparently, or local resources exhausted).

Did you have better luck collecting the perf trace?

/P

