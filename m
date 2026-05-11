Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC643CED5
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517337; cv=none; b=Qenu9J9csadb3/1waZQmAIAaWd2nyHLzNyBYH6v2hfGbJhfYlev1OKXJxD1ta5fGd+W8YZTqH9vKfPFmPom3A2UGmzqFa04Iq0cPd58gPxgsftiXI6QFa72orRXl70ejkEFkrlsV4Zg73xl1Ojmqpa4uKxI/abSdSF787mFoYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517337; c=relaxed/simple;
	bh=6x9jTUtneo8wMp07/xQaqy7u6aiAk1QO8N4K57Hw3y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bcLrMUqUm+/2fEmjN62Pvk0CshP4HxFJO+Nmbs2ZvYdqEYPvXgTpfVPZAGYLBkAqtlEtQC1eB8W2ii8UlRuwm79veL9RcSgUpx5iFxbwmMzWHFdhq8Ud0wzWY0YHkfrCqlZ08zz9r62QZg/Xd1ABC1XzPzmS74Hog+gTRWO1JK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E59wleyg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E59wleyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778517334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgniopmAuRPphdniHN35wHK7IBk9H1H06m2p1jvEYh0=;
	b=E59wleygUjVhV/6rgq6Xsui2IhxorPzwtE3QjTcG7MSrmLV6/LH0E1LVwrUsfeWogYLxOd
	bbq6aImDPGxiSRdENgGu6ij9u7kr4HTxEFLaBIq0p56dte1FTfZBH1lFZ/OPr7fwRE+Zkk
	dRe6PGom8weKwW+va40vuT01Ddja7nA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-sxrjwaSNNz2CSgN05lgqsw-1; Mon, 11 May 2026 12:35:33 -0400
X-MC-Unique: sxrjwaSNNz2CSgN05lgqsw-1
X-Mimecast-MFC-AGG-ID: sxrjwaSNNz2CSgN05lgqsw_1778517332
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44b2b38648eso3697366f8f.3
        for <mptcp@lists.linux.dev>; Mon, 11 May 2026 09:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517332; x=1779122132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgniopmAuRPphdniHN35wHK7IBk9H1H06m2p1jvEYh0=;
        b=VwztevHD+rwx6wExuZp666huhdQuq2r1uwL6LTxBCX/7uNdyzs4kWP78xNjpbRw95o
         4BhayaxmlsksoKnJb3T7Ar7ZaPh8i/O0pDHsdWMQ+ONKVfnVutAexWN7/gDDgPVtba6u
         I8Zsjo/p9ov7KohhmhbSONuY9qeXT5ksy1nuhsrTyySkIVsXPounm0Ms3hM1B+0pBMf9
         YlgaYO1z7eEtpx1w4+8P/Ix9dMr2xdfx5DpXUQ5EBYfw3c/A7cqxaqCBJ2mz4efnq1rs
         y2bDAh5zBEPwHuTxj0OKGTNqZzSeoUSEftEmQ7popkS/yN69MMi9Z1j8Ze0V4ii+X6z4
         SKHA==
X-Forwarded-Encrypted: i=1; AFNElJ+ilZv2tn0KbiV1jriSHnwKeehlqgJUELN0ttDyL+J/ifVdQnTzXeoPBESBZE9p3/BIPmUlBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoD9m3deGSg3yu0LqHjbvDhSxaJ9rrWdu/dFd7huo9iidfijFK
	K5kWx1JHYH54seajlWTjXhl853Pv1SmIR1/BEHn9/VWqoNlfR8cuRCHWKwWmYYCLVcadVW2Bp1l
	8q3TPIEEPK0sxjLc+IB8kCqiK3FP5nXyRjy1AdBp+vnoKpnPQrZoqP8HxBU9fW4uM
X-Gm-Gg: Acq92OEgxWIaoiX8Hs6i9dIDww8HUV39dV7iUQr10Uqoyn9RpH+xERZEc8jCOzoejRe
	i39/4U5OnlF+XaVQvJNBZAcRuflOSoY/er0WklqXvFCNw4NXsnYsubVJjLPaR8iamQGLhnHyxUR
	3Fk7VyZ8yXbD1HwlL3JwLSCKnMz8GaLTdcvOYEH6UFZV2aL9f1VFqvaL5UmtFYP8DAxeP8RtXmf
	Kh/uu6eCm7YcazLRzlNkecI3KP8CTcbcoiCcOnuMTHSxrLJ91y5nYGHQ2mujtesHi+QX1Ul0ECv
	YT8oYmuU5DYsJhaGO75Bcd2BAYohxgskEBweDyhc8CH/TuXiEBNFlmwDbPbePE/7F+MSd2upWgV
	KS4YJ9U91vJLDaaHwUDf+IVmpiHgestbuBkJINaLnKXLi0yObFsJkBMWS
X-Received: by 2002:a05:600c:6299:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48e706f11d0mr174679575e9.17.1778517332062;
        Mon, 11 May 2026 09:35:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6299:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48e706f11d0mr174678925e9.17.1778517331535;
        Mon, 11 May 2026 09:35:31 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7041defesm200808815e9.15.2026.05.11.09.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:35:31 -0700 (PDT)
Message-ID: <0b9d2fbe-5d11-4c73-910a-fb99601ad54a@redhat.com>
Date: Mon, 11 May 2026 18:35:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-next 00/10] mptcp: address stall under memory
 pressure
To: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1777908248.git.pabeni@redhat.com>
 <cc137cc2-718f-41e9-aabd-e65b9fbfd4ee@kernel.org>
 <47cae42a6de0745a423098d1b15bdd71dc2937d6@linux.dev>
 <c20f907e-4727-4814-86a9-38a08cd77ae1@redhat.com>
 <aca5067c398256e04dfae42451a82d42afc7c031.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aca5067c398256e04dfae42451a82d42afc7c031.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EEwrmPZvbSJReGOlcAkd05uLlPJZnpJCeOcDr4z7kqM_1778517332
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/11/26 1:11 PM, Geliang Tang wrote:
> On Mon, 2026-05-11 at 10:29 +0200, Paolo Abeni wrote:
>> On 5/9/26 9:07 AM, gang.yan@linux.dev wrote:
>>> May 8, 2026 at 6:49 PM, "Matthieu Baerts"
>>> <matttbe@kernel.org mailto:
>>> matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel
>>> .org%3E > wrote:
>>>>
>>>> Hi Geliang, Gang,
>>>>
>>>> On 04/05/2026 17:39, Paolo Abeni wrote:
>>>>
>>>>>
>>>>> This an attempt to fix the data transfer stall reported by
>>>>> Geliang and
>>>>>  Gang more carefully enforcing memory constraints at the MPTCP
>>>>> level.
>>>>>  
>>>>>  Patch 1/10 moves the bound check before entering the TCP
>>>>> socket.
>>>>>  Patch 2, 3, 4 and 5 are cleanups/refactors finalized to safely
>>>>> re-using
>>>>>  TCP helpers on MPTCP skbs.
>>>>>  Patch 6 makes TCP pruning related helpers available to MPTCP
>>>>> and patch 7
>>>>>  makes use of them. Patch 8 addresses an edge scenario that
>>>>> could still
>>>>>  lead to transfer stall under memory pressure.
>>>>>  Finally patch 9 and 10 improve the MPTCP-level retransmission
>>>>> schema to
>>>>>  make recovery from memory pressure significanly faster.
>>>>>  
>>>>>  Note that the diffstat is biases by the quite large patch 4/9,
>>>>> which
>>>>>  contains mechanical transformation of existing code; "real"
>>>>> changes are
>>>>>  noticiable smaller.
>>>>>  
>>>>>  Tested successfully vs the test cases proposed by Geliang and
>>>>> Gang and
>>>>>  vs the selftests.
>>>>>
>>>> At the last meeting on Wednesday, Geliang mentioned he validated
>>>> this
>>>> series. Just to be sure, was it the v2 -- from last week -- or
>>>> the v3 --
>>>> from this week, while you were in EU -- that you validated?
>>>> Because
>>>> Paolo couldn't reproduce the issue you mentioned on the v3 on his
>>>> side.
>>>>
>>> Hi, Matt
>>>
>>> The issue can also be reproduced on v3. I reproduced it using
>>> Docker's
>>> auto-debug mode with the mptcp_data.sh selftest:
>>>
>>> ‘’‘
>>> 	Not running all tests but:
>>>
>>> -------- 8< --------
>>> run_loop run_selftest_one mptcp_data.sh
>>> -------- 8< --------
>>>
>>>
>>>
>>>
>>> 	=== Attempt: 1 (Sat, 09 May 2026 06:55:44 +0000) ===
>>>
>>>
>>> Selftest Test: ./mptcp_data.sh
>>> TAP version 13
>>> 1..1
>>> # add_addr_accepted 4 subflows 4 
>>> # id 1 flags signal 127.0.0.1 10001
>>> # id 2 flags signal 127.0.0.1 10002
>>> # id 3 flags signal 127.0.0.1 10003
>>> # id 4 flags signal 127.0.0.1 10004
>>> # TAP version 13
>>> # 1..48
>>> # # Starting 48 tests from 2 test cases.
>>> # #  RUN           global.mptcp_v6 ...
>>> # #            OK  global.mptcp_v6
>>> # ok 1 global.mptcp_v6
>>> # #  RUN           mptcp.shutdown_reuse ...
>>> # #            OK  mptcp.shutdown_reuse
>>> # ok 2 mptcp.shutdown_reuse
>>> ...
>>> # ok 48 mptcp.sendfile
>>> # # FAILED: 41 / 48 tests passed.
>>> # # Totals: pass:41 fail:7 xfail:0 xpass:0 skip:0 error:0
>>> not ok 1 test: selftest_mptcp_data # FAIL
>>> # time=33
>>> ’‘’
>>>
>>> As Geliang mentioned in the weekly meeting, we will continue
>>> to debug and locate the problem based on Paolo's v3 patches.
>>
>> Thanks for testing. I went over a couple more revisions. I run more
>> than
>> 100 iterations successfully on a local build on top of v5 (no
>> failures,
>> I stop due to time constraints):
>>
>> https://lore.kernel.org/mptcp/f00bdac0-b544-87b8-2ef4-ca4de0f045de@gmail.com/T/#t
>>
>> please have a spin as such later version.
> 
> On v5, mptcp_data.sh works fine in normal mode with the virtme docker
> image, but in debug mode it's still unstable - failing after several
> loop iterations.

How many interactions? Can you please provide a sample of such failure?
does the failure always happen in the same way/on the same test case?

Thanks!

Paolo

