Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9C247280
	for <mptcp@lists.linux.dev>; Mon,  1 Dec 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587965; cv=none; b=Ae6M0cJL6XhG6yR0I2KmQq3KDczKMnYQMf6kq57qe8uBuAej1N1cadehjZKMTvUdqtnwuhTVD2M3Vwfs5miiHl5fG4Zq501NzwbziDhtWjpDBRZUMmKLPdLk4HKvWytTNt6E1xXXItU+kicwy3YdEkOgO0XqeleXCby3PejEivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587965; c=relaxed/simple;
	bh=HelmBrNOGPxnECAahrI/AYz/q47MmmsHP6zQrECTiHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=EZZ8lO8/+HfQ0ZuAfhwCUwEGeVIfewtFUqdVDiKTZ4aJFeg5+96y435TE7RqJIfXln7ExhPPj3kzqFcmc+uD1NabVAz7BuPLYZQH7WMebNX910Fovt1mMMj1KRcvX4ZCfaLTmW0Pgny+oN8c3lZQh9AsA7efRmRVf2RvFAileXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOCm4jCL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOCm4jCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EACC4CEF1;
	Mon,  1 Dec 2025 11:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764587964;
	bh=HelmBrNOGPxnECAahrI/AYz/q47MmmsHP6zQrECTiHA=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=kOCm4jCLFvkGoHKEMaVanbmjZpGA3VNYyZx4zlISAXtcDBUNl3hzUWQxYjIjLe5E0
	 e1TVxBZknaTY3/OsXHBzm4u9zqYzX2fTLuzRGHLcpkIkuKhljVDl/5dL8YVQ8w8ftS
	 8/PpRkAPL0k5Cs1ipaPDkUCtILZ+0iuEJxBTnt4vaHPCC4UdhwsB/NNGWN/7m9L82p
	 i74O3yTpOakbpmSYeHxm7MpOK22nHOw2wGHyrSMpr1cwAdN0FeicKrc/j+Te283qVv
	 bhqrppd1vzsMPz4MOG5y05aWqjAdl1OTKq5VQUD/whSTac9m1XRRy7wm44q7yGBjT7
	 iD7pm3CaGeFVw==
Message-ID: <5ab9decf-e350-4ff6-bd0d-ba23b501f224@kernel.org>
Date: Mon, 1 Dec 2025 12:19:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fallback earlier on simult connection
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com>
 <7bc3d452-b6f3-ce84-f163-a2fbefa71e55@gmail.com>
 <cb41f3a1-2a45-496d-9dba-784a81dc2de2@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cb41f3a1-2a45-496d-9dba-784a81dc2de2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 01/12/2025 12:10, Paolo Abeni wrote:
> On 11/28/25 2:35 PM, MPTCP CI wrote:
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_syscalls selftest_simult_flows 🔴
>> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
>> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_syscalls 🔴
>> - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
>> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
>> - KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp 🔴
>> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/19764025304
> 
> As mentioned, pktdrill failures are expected - test need to be updated.
> 
> The simult flows and btf failures are unexpected, but looks unrelated
> from this patch.

Thank you for having checked! (Sorry, I'm lagging a bit behind)

Regarding the simult_flows tests, the last job checking the sync with
net/net-next also has a failure:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/19812973527

So not a regression due to your patch, but I hope there is not one due
to other changes!

(The last job also mentioned issues with a new packetdrill test, I'm
going to look at it, then apply your patch!)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

