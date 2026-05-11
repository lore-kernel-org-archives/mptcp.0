Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF82F99B8
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488188; cv=none; b=BCFNUUzyu5DrmKlxz9gbLngFYjerZsqkh2LMLmWfcnfuZhVYFj8kq6hKo/OmwIZIRt51xUTvf9ZEdYpvKzIseDQ45Sk1p9GfSoilOgY8a4cwIz4zERC9QNVi8aj2P0tyNXNnESGXAAhH/AWUK9Mz8h5s+KADHiiDXl5OHttiTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488188; c=relaxed/simple;
	bh=wqoP0b8URB7+0MOZ9h8MAF/yhurwwrL4yGIuV+aTdyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tvNRaMznENKhdsALo5JMAdNyOEvatKqMnye/LkTr6b6TeILmJ87VXhUIQh8TXgdbTHxzSdt9axg8TlT8FWKTGVIUcvM6GSDHj75jg0Xe2lUraOTYltVpW6JQ3ZtNqLzLtL6T+DlTzpbpzeW0/HLR/zC+EOxvvKtjhVw1jVcGgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JF5/jDB7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF5/jDB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778488181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14ljqo/tu6OQYxLSa8kM9nry08+W9CQImRzvrrEwqPM=;
	b=JF5/jDB7WovSiIczRBXnM/TuLiL/yx8DWUqGLUgIcoVMY7hag/9xUfFkHEq4M3Ts7izghe
	XTn5smKoCXLHwaonqluibrrTbc8YXBvWNqXZqCUGzESe++iWWi/4YnB5G/qsXLTOEC7Uhw
	Kx5agk+p51LpYH2nERv3s5O3oHUsUrc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513--zW81oWmP8-b9TiY3GjQ6Q-1; Mon, 11 May 2026 04:29:39 -0400
X-MC-Unique: -zW81oWmP8-b9TiY3GjQ6Q-1
X-Mimecast-MFC-AGG-ID: -zW81oWmP8-b9TiY3GjQ6Q_1778488179
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so3181339f8f.1
        for <mptcp@lists.linux.dev>; Mon, 11 May 2026 01:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778488178; x=1779092978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14ljqo/tu6OQYxLSa8kM9nry08+W9CQImRzvrrEwqPM=;
        b=Hpi6u1ja6G0J/+Jo7cC+I6XZ12MzwadSLaW9iDMEe5EE43YgLJbKY4DWh02VnIisH8
         lv8m8KVKQmT3oUKEAkdPL1JfG+eIJ8wgGgvTycadk9RbOPnVuCBLl2xqOM2Yxqkb6jXH
         HtnA0lio4b/4zSr+EXaTOWFQlY7BHnBDXdPd3ZNQUVZfEsXtkg6SPjfV+HAqDgMCbeEY
         WhWMcPbCxiJNb9RS+se4BO/xb5xO2YOH4gB7b6FbPR6un2H8jjQjZQdn2Z+7dKgko7bS
         WEgjjppp0jmjKzuVb9/4VOt3kdDTcIn3lBkIOK4DMU/xtAQoICkj6C2a9EUV4D27pBEV
         xzew==
X-Forwarded-Encrypted: i=1; AFNElJ98Q9Vs+oaYOz3HOjlZE57LSynU4TXpuVi/jgTgIA0I0k3bvf/p/DpkpbMjOJ4KXs/I8AFNLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtbjOtOeKReNZmnj1nT7f6lVCECxcFqsPZLUTv11aS8YnvW76I
	s267AtAydKVVUzrS6KC0MUPUN1GHh7YQoolhT70g8V/a6AXFpAuW4Ur4V+kNY3hFvr6f0TUIBLg
	NAWhaeIRywXbVFWDGmBNKtjLv6nrTlm+6Dkf1tJeV6V30k9J1zrNXVHkC3uOyO4cb
X-Gm-Gg: Acq92OHLrkTSSkkBfQsPf2nW2gsk4DqWJa1xqcyoRvvy/rqRCKS65NeLEmvDXxfaazI
	MfNNeY4cF/UjJ2xOX2HDWpTxYd7MiDwjFCuBisy39WIMkT5auwNrLbmOMifMMB6Yi/0S1ppR3XV
	Zk3uA+IxAWDro6grsCobRS+fs/hMfngxW9LFsJgneuNXxYihB22n4/vIY5iYIsOF9ZpE/H9XCM7
	zkUcy0qf+QSDVzK+NA+br3UKruzQW8ETpME9MVcyWMh69fdg/WrSAGAbHtNw4l6fEmfyCejp3Oa
	srFlck2asthOKEtZLWCwMzFzreQPg8ZfgChCCCcLYh1I2MeSD/shVc87/SNvs5BRUpr/bSjf85X
	ZZFlKb02IBAm4KDMQz1A0lx+yzVZFJUFHY/ZIvhUQWPgIblRbIsYWLah0
X-Received: by 2002:a05:6000:2181:b0:44f:b82f:2d18 with SMTP id ffacd0b85a97d-452e81764a0mr19463081f8f.11.1778488178285;
        Mon, 11 May 2026 01:29:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2181:b0:44f:b82f:2d18 with SMTP id ffacd0b85a97d-452e81764a0mr19463043f8f.11.1778488177719;
        Mon, 11 May 2026 01:29:37 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454922715b9sm25305020f8f.36.2026.05.11.01.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 01:29:37 -0700 (PDT)
Message-ID: <c20f907e-4727-4814-86a9-38a08cd77ae1@redhat.com>
Date: Mon, 11 May 2026 10:29:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-next 00/10] mptcp: address stall under memory
 pressure
To: gang.yan@linux.dev, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1777908248.git.pabeni@redhat.com>
 <cc137cc2-718f-41e9-aabd-e65b9fbfd4ee@kernel.org>
 <47cae42a6de0745a423098d1b15bdd71dc2937d6@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <47cae42a6de0745a423098d1b15bdd71dc2937d6@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lNdsT0bktPPmq0QeyT8X_WH9uPJodNtiJXc7b74wkG0_1778488179
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/9/26 9:07 AM, gang.yan@linux.dev wrote:
> May 8, 2026 at 6:49 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
>>
>> Hi Geliang, Gang,
>>
>> On 04/05/2026 17:39, Paolo Abeni wrote:
>>
>>>
>>> This an attempt to fix the data transfer stall reported by Geliang and
>>>  Gang more carefully enforcing memory constraints at the MPTCP level.
>>>  
>>>  Patch 1/10 moves the bound check before entering the TCP socket.
>>>  Patch 2, 3, 4 and 5 are cleanups/refactors finalized to safely re-using
>>>  TCP helpers on MPTCP skbs.
>>>  Patch 6 makes TCP pruning related helpers available to MPTCP and patch 7
>>>  makes use of them. Patch 8 addresses an edge scenario that could still
>>>  lead to transfer stall under memory pressure.
>>>  Finally patch 9 and 10 improve the MPTCP-level retransmission schema to
>>>  make recovery from memory pressure significanly faster.
>>>  
>>>  Note that the diffstat is biases by the quite large patch 4/9, which
>>>  contains mechanical transformation of existing code; "real" changes are
>>>  noticiable smaller.
>>>  
>>>  Tested successfully vs the test cases proposed by Geliang and Gang and
>>>  vs the selftests.
>>>
>> At the last meeting on Wednesday, Geliang mentioned he validated this
>> series. Just to be sure, was it the v2 -- from last week -- or the v3 --
>> from this week, while you were in EU -- that you validated? Because
>> Paolo couldn't reproduce the issue you mentioned on the v3 on his side.
>>
> Hi, Matt
> 
> The issue can also be reproduced on v3. I reproduced it using Docker's
> auto-debug mode with the mptcp_data.sh selftest:
> 
> ‘’‘
> 	Not running all tests but:
> 
> -------- 8< --------
> run_loop run_selftest_one mptcp_data.sh
> -------- 8< --------
> 
> 
> 
> 
> 	=== Attempt: 1 (Sat, 09 May 2026 06:55:44 +0000) ===
> 
> 
> Selftest Test: ./mptcp_data.sh
> TAP version 13
> 1..1
> # add_addr_accepted 4 subflows 4 
> # id 1 flags signal 127.0.0.1 10001
> # id 2 flags signal 127.0.0.1 10002
> # id 3 flags signal 127.0.0.1 10003
> # id 4 flags signal 127.0.0.1 10004
> # TAP version 13
> # 1..48
> # # Starting 48 tests from 2 test cases.
> # #  RUN           global.mptcp_v6 ...
> # #            OK  global.mptcp_v6
> # ok 1 global.mptcp_v6
> # #  RUN           mptcp.shutdown_reuse ...
> # #            OK  mptcp.shutdown_reuse
> # ok 2 mptcp.shutdown_reuse
> ...
> # ok 48 mptcp.sendfile
> # # FAILED: 41 / 48 tests passed.
> # # Totals: pass:41 fail:7 xfail:0 xpass:0 skip:0 error:0
> not ok 1 test: selftest_mptcp_data # FAIL
> # time=33
> ’‘’
> 
> As Geliang mentioned in the weekly meeting, we will continue
> to debug and locate the problem based on Paolo's v3 patches.

Thanks for testing. I went over a couple more revisions. I run more than
100 iterations successfully on a local build on top of v5 (no failures,
I stop due to time constraints):

https://lore.kernel.org/mptcp/f00bdac0-b544-87b8-2ef4-ca4de0f045de@gmail.com/T/#t

please have a spin as such later version.

Thanks,

Paolo

