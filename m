Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE713CA4BF
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648877; cv=none; b=Qz45QjxjE0k1YVsLjTR5rFyvdK3t5xStJfg3B1e+blMeBYcbjb9rOQVAq1H+COBIPCLopuV19AIiIeE8Y5VGchFqMwO5e2kn/7ZTfNao10/qfZpF5reNKwJQ481wWzgMNI5KDCwogP1cgxR6PQMlEUJV5bgglwr4E71fm7MBIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648877; c=relaxed/simple;
	bh=GIHDlLt40zoXbEMxElwXzJV7BzchBvpU15zYMgzu3cQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u4IEtxLYMUiV/8aQp+5LlEaXr8j/6s7dqSB1QLUjLeMRqE9Ha4ulCm/EO8SfXgMumCsqlkMMCAzgyk0Y2La4fvs4biwo8dTikCVnbZjMmoTfIOdrHGR67hW6PN0i2zCV5myYR86RIthQiPfjQxM4DATvxgUWE/Q/BtCluuJZWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1V0Z8N5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1V0Z8N5"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c795a47186bso816199a12.0
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777648875; x=1778253675; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUoJ2iH+bFZue4nx6prfQBVHmEzn4jpOhLoQwSUJV28=;
        b=K1V0Z8N5Pfaox7DvovNrpBxyGDst9yjY7hoHK4POi91jwcygtUkynn0ZgzvqprhZ7H
         PANfQEUw3gURZ4fckftQ9Wmujt1Yz/FSiabQTdYteJONXr0R/SWxgGfkc/pucok8i+Qo
         E/6CQR1nWnr4LkvOgCZNmj/GGlKuh5JanvxAZi+7gvVtYG8a3eddMB0GPVY1fcIkLoKZ
         Mulwz0uED6lf38SMSLn4fK0kml/0SXWO6xJy76wxAk2Pattt8veK+O8Iq7HAHcyUYUvS
         O2xXJS+uDuv+9sHF9y8gU5kPEpTJvb/tPhYqoqpBgJWX1fNX7svtJOMEhMpdNOUroeEZ
         7Faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777648875; x=1778253675;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUoJ2iH+bFZue4nx6prfQBVHmEzn4jpOhLoQwSUJV28=;
        b=Mk1mKcaup3lbtwvQXwiHZfTbbamh5mSm9DNzX/xY7T2m7CDDiLFblIQqMh/2vqLEcf
         4JGFIfVuhYACQ4rXPh27wSpDXBoQyZXczyDRcmtbi2d6SbukbRWJQekiLErvoB4CvGO2
         GPvRXx4OhnRJSmEuDF2ljUwOQhXV71xOe9H1aPrEPL2mfaDk45TJFuZN/qnN94eOAyo5
         JrrC6rjA5T00ZjpnTW440uDeGykXGA13MGRvGg/S0ZZcybOswF2EeqvoMV1OGJDRe3jM
         tDjicjhG55R7lTdV7z2Az6ZccJVYcu7Hxr5YD1NRYI360/w7zEBpLzHeoslVhetlhsIT
         WZyQ==
X-Gm-Message-State: AOJu0YxISU+RW/J59tJ+tK5/jV6ppImbAQjqUxQLZnCy4LnDa+MqgTVl
	eYdnbwBHfmLQd6Y9wSGIBRGr0ZexMJqHbhpQTiUiHA4FDf7SRfsW+QYlmhDOig==
X-Gm-Gg: AeBDievomsaWmLESneQ5X65iXxlUHgG8JmxQ+oxdK32sDmF1EwmlBVchzJ6uJ/pA9J6
	lVJRh3kFWZteIx6VGqIQc17AqT+cgMp1Xc/Gk8SDpgIQSg1zGQ9g95kGkZmJtZrgh4c9N5wBeUz
	vexRp4duzdH2Lh8w83WGgLmMdxf6XQOxC4yWaEfrl1ltnPEm0qT5ZPw6gVCzckhAygYLskmJbqM
	eNTf8u7EmQs5tKeT9SUfmqqqfEli9c2l3WPBPy8EYcahq1O8FL4xX2640s5RyvFT/pLuVyKrzfu
	lxJIx1lLhtamQatPQSRgg5XYw/knkaiogu1083RSpu2gUuQaLLDr5OGSz/ntbeRaQry6lkJLKkM
	31lGN9RVLMcILse9/Y5o/Yl8phwFaCjBh//7CUAf32KxQvpQG5oRKhxtJpMUZENwRnZb13MhesW
	tvfF0AFCGWV0sn4F4OAIAZa8msbjymgLjbyJG/s4SRJ1eCU76cdP2cATPHqqC77N4=
X-Received: by 2002:a05:6300:218d:b0:3a0:babd:b959 with SMTP id adf61e73a8af0-3a3d1d55597mr6817310637.9.1777648875057;
        Fri, 01 May 2026 08:21:15 -0700 (PDT)
Received: from [0.0.0.0] (softbank060083182156.bbtec.net. [60.83.182.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582e193sm3659689b3a.2.2026.05.01.08.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 08:21:14 -0700 (PDT)
From: Li Xiasong <xiasonglee@gmail.com>
X-Google-Original-From: Li Xiasong <xiasong.lee@gmail.com>
Message-ID: <a4f4494f-4a5f-4628-a2a2-5babf3a2f02f@gmail.com>
Date: Fri, 1 May 2026 23:21:11 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: cover ADD_ADDR
 tx drop and list progress
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, weiyongjun1@huawei.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, Li Xiasong <lixiasong1@huawei.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-3-lixiasong1@huawei.com>
 <177755524217.1566930.4447011567120793753.b4-review@b4>
In-Reply-To: <177755524217.1566930.4447011567120793753.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Matt

Many thanks for the review and for pointing these out.

On 4/30/26 9:20 PM, Matthieu Baerts wrote:
> On Thu, 30 Apr 2026 19:20:26 +0800, Li Xiasong <lixiasong1@huawei.com> wrote:
>> Extend add_addr_ports_tests with IPv6 signaling cases that exercise
>> ADD_ADDR tx-space shortage when tcp_timestamps are enabled.
>>
>> Add one case to verify ADD_ADDR tx drop accounting via
>> MPTcpExtAddAddrTxDrop, and another case to verify PM still progresses
>> to later signal endpoints after the first one is dropped.
>>
>> This covers both failure accounting and the non-blocking behavior of
>> the announce list after a tx-space drop on pure ACK.
> 
> Thank you for this new test!
> 
>>
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index beec41f6662a..59beddb487e3 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1828,6 +1828,22 @@ chk_add_tx_nr()
>>  	fi
>>  }
>>  
>> +chk_add_drop_tx_nr()
>> +{
>> +	local add_drop_tx_nr=$1
>> +	local count
>> +
>> +	print_check "add addr tx drop"
>> +	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$add_drop_tx_nr" ]; then
>> +		fail_test "got $count ADD_ADDR drop[s] TX, expected $add_drop_tx_nr"
> 
> Nit, just to avoid a checkpatch warning, maybe rename add_drop_tx_nr?
> 'expected'?
> 
>   -> WARNING: line length of 84 exceeds 80 columns
> 

Thanks, I’ll rename the variable to `expected` and shorten the fail
message to avoid the 80-column warning.

>> @@ -3278,6 +3294,37 @@ add_addr_ports_tests()
>> [ ... skip 22 lines ... ]
>> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
>> +
>> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
>> +		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
>> +
>> +		speed=slow \
> 
> Do you need 'speed=slow' here? Having a longer transfer is typically
> needed when endpoints are manipulated during the transfer, or when a few
> there are >= 3 signal endpoints. I don't think that's needed here. Or
> did you experimented any issues? (if yes, makes sure you are on top of
> our export/export-net or for-review/for-review-net branches)
> 

I’ll remove `speed=slow` unless I can show it is actually needed.

>> +			run_tests $ns1 $ns2 dead:beef:1::1
>> +
>> +		chk_add_drop_tx_nr 1
>> +		chk_add_tx_nr 1 1
>> +		chk_add_nr 1 1 0
>> +	fi
> 
> It feels like the second test covers the case tested by the previous
> one, no? I would only keep the second one, best to avoid redundant
> tests, this selftest is already slow enough :)
> 

I originally split this into two cases to validate accounting and
forward progress separately, but I agree the second one already covers
both, so I'll keep only that one in v3.

Thanks,
Li Xiasong


