Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC42765D4
	for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771429706; cv=none; b=HUQsvOsSmj3vFQapNV17Rqp9Y5V2b+9Ea9a1FKzsXFBYVBSEqRUwbH4WKLWNhq5iFO+PenNhqYKFuztJKiK+ZRx/qxV3f0Ki/ok3Mi7Py+CrU03t/v5HBY7RnkGTaMvvLg2dhnwX3efYGQp1XrF11REg602rYGDm91R00BIsLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771429706; c=relaxed/simple;
	bh=hdGNmljsZleLflqNo/xfhnASWvb4hlHcPHK7PTG0gE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bGVFO5USve4EfdKSXblbGvV7aCFwhvSvkFdpIVPfFADNgf2v6PrLwBCKg5MmqLRPJ0Ik28rv6I4n9M6CziGhIY5jto5gsxh7lTUHEzTWzfGGCLR9ERW7BwEtnA6eunQcIUiq1crrwdi/SKdPNcao7ZnhXLxE7064Cwvo5lZMN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpfrsknU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpfrsknU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771429704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhttjQ0HJeqDTHjfQ3+C76tNwtEX8volF0vOI/0FrMk=;
	b=SpfrsknU1SHGuazr0vF1JEYY6fhB7ZF4rqY3/W/uY5QWemUQsas86tbE+ijIIOyFHR5rp0
	a9MEkdeW9I+pvsiY2DqHYoVOJmyaspYMJJKe24rfHPXRxJK+a0u+yIaVCUplgMAKP9QKVq
	38f2mxyxuJD053Z5oIa1pQG093OiBi8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-lU46SbEHPqyISmwBWEzeVw-1; Wed, 18 Feb 2026 10:48:23 -0500
X-MC-Unique: lU46SbEHPqyISmwBWEzeVw-1
X-Mimecast-MFC-AGG-ID: lU46SbEHPqyISmwBWEzeVw_1771429702
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4376b624589so4868536f8f.3
        for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 07:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771429701; x=1772034501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhttjQ0HJeqDTHjfQ3+C76tNwtEX8volF0vOI/0FrMk=;
        b=fG9swr8baAjK5oPSmMxb5hpCndeYXnWU9Vtgf5MGLqG84awUBDdN21GYmC4JLYyC/d
         SsHvw4HlDYXu4h+LEcNbzmkFEa5Mk6rGu0DP17nLnvU5d0DR9rlTtfX+sayWmnpKd83/
         ipScsiarh5Ugq/kYkyp0dYKtEZZLlp+pGIXp4ra01vDG6oxRHAT+EB75CaMhkskWEf4R
         pqRtMeDxtWhZm7OjABzuoOoFV0vwCo9qXGyEBNS/V7i9Eu5+VvAu+gpEjXU8eIJL7J9m
         liWwcRPTQ5Jk2lPO8jyyPGEcQ0fO+jIpx4s/VJtgWqbeIomcqUq+4seeHEqGVIVTSubB
         XwRg==
X-Forwarded-Encrypted: i=1; AJvYcCVEinlOPE47SQfoZnTF0CasVNhsFZT2XNbepqCDXsM/vTSHJKnWsb0j2I/wTcKOjj0LVhjP6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi0yLs4JqNxs4ABA0U6HDVvLccrtSZclSBUGjQ9txv7/E0fJ+f
	vdCMIKQ+NfEnNeiwSkY44AKp3YMP5IGvY3o26Wc+IFHCiiUmUAmR66U/BOSumJZdRkKvLDH1FaX
	LxhOeGue378rqe0+mqzhpYzx8UI/8jx6wvc5tiklnoG+Dqcmvm0boLusaOSZuLGBp
X-Gm-Gg: AZuq6aKZ07496cBFucZSBv1twSCgiP5ZqpMSl5/yKckXCD3DV4yR4zYCTB3/iXZK0Vb
	Mu5/SEzYkBiu4TQaVbiwRZtU/mP5mioHZ8KprNmrGNX1K2jZY3BZjtyx2jUX9xHrsmkbVTqk7nz
	9AgaioB3sE6cs0vGAQjiGASZ2yOqt8cZ1a+/7mM2wGMmkU9CTwCTOcLENfELwbHkRXIZF+xgjk/
	kNHZpqi+IeIJHQLeGy1XAG7aefpM+af3Iwy16koF/cDXqBHleUWgvegRJ976BZNMqaOTnUQDbt+
	0S2jN1yjS8SYSpTe85Cm1CZz9JjEkPKz89psuQl3anZhrGMjdERO/2UC4MsMWXEHWbTQUDNQUk2
	/R5WWXrI40Xjfv4O5K35SLxo7
X-Received: by 2002:a05:6000:2407:b0:435:a7fa:249a with SMTP id ffacd0b85a97d-43796b0548dmr31796014f8f.61.1771429701368;
        Wed, 18 Feb 2026 07:48:21 -0800 (PST)
X-Received: by 2002:a05:6000:2407:b0:435:a7fa:249a with SMTP id ffacd0b85a97d-43796b0548dmr31795966f8f.61.1771429700855;
        Wed, 18 Feb 2026 07:48:20 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439567aad3csm8262703f8f.36.2026.02.18.07.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 07:48:20 -0800 (PST)
Message-ID: <e196b480-eaec-4e47-89eb-7ecb6ca7d58f@redhat.com>
Date: Wed, 18 Feb 2026 16:48:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] selftests: mptcp: more stable simult_flows
 tests
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
 <45ade886-44c0-4889-b825-82fa12fb03cc@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <45ade886-44c0-4889-b825-82fa12fb03cc@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: epHw5NzHjWND4kuaFOtB8VevKYuNISu0e6zNsNkBMak_1771429702
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 1:13 PM, Matthieu Baerts wrote:
> On 16/02/2026 22:20, Paolo Abeni wrote:
>> By default, the netem qdisc can keep up to 1000 packets under its belly
>> to deal with the configured rate and delay. The simult flows test-case
>> simulates very low speed links, to avoid problems due to slow CPUs and
>> the TCP stack tend to transmit at a slightly higher rate than the
>> (virtual) link constraints.
>>
>> All the above causes a relatively large amount of packets being enqueued
>> in the netem qdiscs - the longer the transfer, the longer the queue -
>> producing increasingly high TCP RTT samples and consequently increasingly
>> larger receive buffer size due to DRS.
>>
>> When the receive buffer size becomes considerably larger than the needed
>> size, the tests results can flake, i.e. because minimal inaccuracy in the
>> pacing rate can lead to a single subflow usage towards the end of the
>> connection for a considerable amount of data.
>>
>> Address the issue explicitly setting netem limits suitable for the
>> configured link speeds and unflake all the affected tests.
> 
> Thank you for having taken the time to analyse this, and provided a fix!
> Bufferbloat is a plague, even in the selftests!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I suggest applying this in -net, hopefully to help to validate stable
> kernel versions.
> 
>> Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  tools/testing/selftests/net/mptcp/simult_flows.sh | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> index a9c9927d6cbc..d11a8b949aab 100755
>> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
>> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
>> @@ -237,10 +237,13 @@ run_test()
>>  	for dev in ns2eth1 ns2eth2; do
>>  		tc -n $ns2 qdisc del dev $dev root >/dev/null 2>&1
>>  	done
>> -	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1
>> -	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2
>> -	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1
>> -	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2
>> +
>> +	# keep the queued pkts number low, or the RTT estimator will see
>> +	# increasing latency over time.
>> +	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1 limit 50
>> +	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2 limit 50
>> +	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1 limit 50
>> +	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2 limit 50
>>  
>>  	# time is measured in ms, account for transfer size, aggregated link speed
>>  	# and header overhead (10%)
>> @@ -304,7 +307,7 @@ run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
>>  # we still need some additional infrastructure to pass the following test-cases
>>  MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
> 
> By any chance, did you check if your modification was helping this case
> as well? If not, I can try on my side when I have the opportunity (no
> urgency anyway).

I'm still investigating the overall scenarios, but AFAICS we still need
the FLAKY annotation there.

/P

