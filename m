Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA003876C0
	for <mptcp@lists.linux.dev>; Wed, 13 May 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665883; cv=none; b=fDRaY95R0u5PbjxuZXKvIhU1BeJGlErKrBhY3tomkzOeWxBowoiNLfjGv0TIQV4lDG+5eSpVi/m61cFRVK7zSZzDUx3f7dK9ECph9KDw8zbtptVMIETpfFs9DEcZsz0s0ygVhRZEMco3fKZTIrIA8cLMwyhUEbOx0ehNRyN/LSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665883; c=relaxed/simple;
	bh=Rj7rlSMwSZm26/yRav/bDIkquktUmdWXgRzA1b9symk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UsngKto7SxXyGNjJwD/zw17YEbGmeS1xr6iIQTcD5v5W892xVqtptRcJt9x+tui0SGtlFrdarmdzGGuUSwfh0yRFt/rhF31+6PTNRAIXSJtSeT9imNAcmCNQvyWmcZayrlcivHSlkLsmvixkYVKRNTeM9kVQ9Lqyu2f9D69jGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlDShFjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlDShFjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778665878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f84ILZJ07a1Hgo1n9ackMK//sD0HpYa3eVzC/9dFfo=;
	b=PlDShFjdsgO6AOVsEwf3hHRJFpaz2LhzT6BqReiBWhte0LV7jUe9QPzWfEw4fXkC53jvdo
	v2VioJyzM/T/8A09ESAgyLxTHuysPzmAezEc86Q+klRusR5+GYkRyxOFshd9xh38wIyojQ
	8pzxgsZVAfeoebno+yo6J1qPmUDHr8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-qsFpJjuiOtunj6d7BszThw-1; Wed, 13 May 2026 05:51:17 -0400
X-MC-Unique: qsFpJjuiOtunj6d7BszThw-1
X-Mimecast-MFC-AGG-ID: qsFpJjuiOtunj6d7BszThw_1778665876
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a7994e8ddso41741015e9.0
        for <mptcp@lists.linux.dev>; Wed, 13 May 2026 02:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665876; x=1779270676;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3f84ILZJ07a1Hgo1n9ackMK//sD0HpYa3eVzC/9dFfo=;
        b=ayasu8Fc1F3H6t2qm5z8WtiaMz+gFsAerwFsBAoejsLC6P8HPnFxvLMTMTa5polZjG
         sue5pVz9Z0PNZPg1id6hQ5+PG3Ao5hWXfUUhMwOpDW9iLQAcMahr5qPlkc5W+3JUGC09
         7dDDfuo7hZlzpFT6AzqXDrz0RvRMz/9NeVdyAAC/ZF0mIrhEtV1/UZEzWr+JLbHcpzw0
         6UhwBgiIC0m9thOA3LjFFSOGnuNZE496iTWMN8qtySjmPxPBCzGwqQdbHb15Co5Dup6K
         OiXAm89nWnIxgUW+KGeAXMBn0oaTpkAYRLmE8/fOmMBuCpSGXBllCreYUcT/7uv7g3V8
         trHg==
X-Forwarded-Encrypted: i=1; AFNElJ+tXLJz/D0aUR5A6hjFKVKLZ2n+vk2tSGSTu4K3mfEZyxlaxWWMrLgbuz72WSBNcTuFgjDwkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZSKnPBj6M1mjxBu5etVCrvWcCc/HnbVHOYkgNhi2W7mmA7l1Q
	GzKakpKrg+5DGOOxRJwQVweUFNe/45eRJ0F1JF53dEMZ/98tqfJIWprMsYJ4uky9RIBvRN734MT
	SkHqrAcWXxffuAM6N8WIFpYiRJ6kQ5AXJAZJYN1GGyOYYiBlqXxJ0D38Y
X-Gm-Gg: Acq92OESBcApTzmHEQxA0KwsDgXsk9sAHaMRS3ewDQoTZxmKOl2f0TXj+G6YS9FeKjU
	oTuuCDpFZq6X6nHRqoeo/rKimjledzyhyMPvtAKSE+EplBPd1siwD03s6NzM1FPHIoIRhfV5oi/
	HtjFbB4WeVwoMlDk7BulnpvPYowj9Nq/4qmTscs5w8OMXXn46JAz175GVh4hWqB0Idgwb6tz6pu
	sYvYIMPX5RLOMNRS2I+t/yiiqmGbkBhquaWrMhe0vdieTYEohJV/J4YPEG5kp2P75+jEiHzmR4U
	0eah7uyf5rGgqHslE2X7ycBtGRuTpfKqbGx5iXNDHO0ZZdFqYRAoZzrIBdFwTDhTyseHxXGzwfF
	PEJOitR9nH/8OobHXzlIXXM4vwUegV1mjnbRJR9l0dTa3eWJAtshJ5ME=
X-Received: by 2002:a05:600c:8719:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48fc9a0ef72mr30938545e9.8.1778665876129;
        Wed, 13 May 2026 02:51:16 -0700 (PDT)
X-Received: by 2002:a05:600c:8719:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48fc9a0ef72mr30938225e9.8.1778665875622;
        Wed, 13 May 2026 02:51:15 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d7438csm55602075e9.14.2026.05.13.02.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 02:51:15 -0700 (PDT)
Message-ID: <d254a85a-ec80-41ef-88f2-ba8eb97bcb30@redhat.com>
Date: Wed, 13 May 2026 11:51:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-next 00/10] mptcp: address stall under memory
 pressure
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <cover.1777908248.git.pabeni@redhat.com>
 <cc137cc2-718f-41e9-aabd-e65b9fbfd4ee@kernel.org>
 <47cae42a6de0745a423098d1b15bdd71dc2937d6@linux.dev>
 <c20f907e-4727-4814-86a9-38a08cd77ae1@redhat.com>
 <aca5067c398256e04dfae42451a82d42afc7c031.camel@kernel.org>
 <0b9d2fbe-5d11-4c73-910a-fb99601ad54a@redhat.com>
In-Reply-To: <0b9d2fbe-5d11-4c73-910a-fb99601ad54a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: za6KYbab-qB4vQ_kwyPqqGyy52fwNjGugNbLlGJgu4Q_1778665876
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/11/26 6:35 PM, Paolo Abeni wrote:
> On 5/11/26 1:11 PM, Geliang Tang wrote:
>> On Mon, 2026-05-11 at 10:29 +0200, Paolo Abeni wrote:
>>> On 5/9/26 9:07 AM, gang.yan@linux.dev wrote:
>>>> May 8, 2026 at 6:49 PM, "Matthieu Baerts"
>>>> <matttbe@kernel.org mailto:
>>>> matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel
>>>> .org%3E > wrote:
>>>>>
>>>>> Hi Geliang, Gang,
>>>>>
>>>>> On 04/05/2026 17:39, Paolo Abeni wrote:
>>>>>
>>>>>>
>>>>>> This an attempt to fix the data transfer stall reported by
>>>>>> Geliang and
>>>>>>  Gang more carefully enforcing memory constraints at the MPTCP
>>>>>> level.
>>>>>>  
>>>>>>  Patch 1/10 moves the bound check before entering the TCP
>>>>>> socket.
>>>>>>  Patch 2, 3, 4 and 5 are cleanups/refactors finalized to safely
>>>>>> re-using
>>>>>>  TCP helpers on MPTCP skbs.
>>>>>>  Patch 6 makes TCP pruning related helpers available to MPTCP
>>>>>> and patch 7
>>>>>>  makes use of them. Patch 8 addresses an edge scenario that
>>>>>> could still
>>>>>>  lead to transfer stall under memory pressure.
>>>>>>  Finally patch 9 and 10 improve the MPTCP-level retransmission
>>>>>> schema to
>>>>>>  make recovery from memory pressure significanly faster.
>>>>>>  
>>>>>>  Note that the diffstat is biases by the quite large patch 4/9,
>>>>>> which
>>>>>>  contains mechanical transformation of existing code; "real"
>>>>>> changes are
>>>>>>  noticiable smaller.
>>>>>>  
>>>>>>  Tested successfully vs the test cases proposed by Geliang and
>>>>>> Gang and
>>>>>>  vs the selftests.
>>>>>>
>>>>> At the last meeting on Wednesday, Geliang mentioned he validated
>>>>> this
>>>>> series. Just to be sure, was it the v2 -- from last week -- or
>>>>> the v3 --
>>>>> from this week, while you were in EU -- that you validated?
>>>>> Because
>>>>> Paolo couldn't reproduce the issue you mentioned on the v3 on his
>>>>> side.
>>>>>
>>>> Hi, Matt
>>>>
>>>> The issue can also be reproduced on v3. I reproduced it using
>>>> Docker's
>>>> auto-debug mode with the mptcp_data.sh selftest:
>>>>
>>>> ‘’‘
>>>> 	Not running all tests but:
>>>>
>>>> -------- 8< --------
>>>> run_loop run_selftest_one mptcp_data.sh
>>>> -------- 8< --------
>>>>
>>>>
>>>>
>>>>
>>>> 	=== Attempt: 1 (Sat, 09 May 2026 06:55:44 +0000) ===
>>>>
>>>>
>>>> Selftest Test: ./mptcp_data.sh
>>>> TAP version 13
>>>> 1..1
>>>> # add_addr_accepted 4 subflows 4 
>>>> # id 1 flags signal 127.0.0.1 10001
>>>> # id 2 flags signal 127.0.0.1 10002
>>>> # id 3 flags signal 127.0.0.1 10003
>>>> # id 4 flags signal 127.0.0.1 10004
>>>> # TAP version 13
>>>> # 1..48
>>>> # # Starting 48 tests from 2 test cases.
>>>> # #  RUN           global.mptcp_v6 ...
>>>> # #            OK  global.mptcp_v6
>>>> # ok 1 global.mptcp_v6
>>>> # #  RUN           mptcp.shutdown_reuse ...
>>>> # #            OK  mptcp.shutdown_reuse
>>>> # ok 2 mptcp.shutdown_reuse
>>>> ...
>>>> # ok 48 mptcp.sendfile
>>>> # # FAILED: 41 / 48 tests passed.
>>>> # # Totals: pass:41 fail:7 xfail:0 xpass:0 skip:0 error:0
>>>> not ok 1 test: selftest_mptcp_data # FAIL
>>>> # time=33
>>>> ’‘’
>>>>
>>>> As Geliang mentioned in the weekly meeting, we will continue
>>>> to debug and locate the problem based on Paolo's v3 patches.
>>>
>>> Thanks for testing. I went over a couple more revisions. I run more
>>> than
>>> 100 iterations successfully on a local build on top of v5 (no
>>> failures,
>>> I stop due to time constraints):
>>>
>>> https://lore.kernel.org/mptcp/f00bdac0-b544-87b8-2ef4-ca4de0f045de@gmail.com/T/#t
>>>
>>> please have a spin as such later version.
>>
>> On v5, mptcp_data.sh works fine in normal mode with the virtme docker
>> image, but in debug mode it's still unstable - failing after several
>> loop iterations.
> 
> How many interactions? Can you please provide a sample of such failure?
> does the failure always happen in the same way/on the same test case?

I could reproduce some failures with several iteration in debug build.
Interesting they pointed out to:
- a pre-existing issue (missing wake-up) that deserves a separate patch [1].
- an intrinsic problem with queue collapsing: it's (very) slow and can
slow down the received a lot. I had to raise the timeout (replacing
TEST_F with TEST_F_TIMEOUT) above 300 seconds to complete 600 mptcp_data
runs without errors.

A working alternative to the latter change is avoid entirely the
xtcp_*collapse() stuff. The trade off here is that such option will make
./mptcp_join.sh -R slower (as more mptcp-level retransmissions will be
needed)

I'll try to share somewhat soonish the fix [1].

/P

