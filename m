Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA332BB16
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825765; cv=none; b=PTGusjOFriShs3b8GiF/m+x7hYPz8M2G1Bdun1XiMUTFAggVCUChX4z9XZU6EhNuBApJaZeF1s7AT+jZDm+51WFaMgrw0Vlp5Uo20JnfaOObEgImL5eW08bVeSoL0vs8k5bT0DYJrid2HNguMDvycOzOvwJ9bI4IE0M3Sn+/GmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825765; c=relaxed/simple;
	bh=6HCUlSoMuBGgaqtWxR2FDmiEE5g9kFXXNUwkAtLC3YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpgDFNRLFAD1mgDbtS18R3jPNYUjkkKHeEEVkzEfTlyEbL0vFtV9isqWqeZk9/hPTpYq0kwp2DykNNsrI2cstV/xfhHa9w9TtIUGd7cwFHY7n8jnp/gwN4Q2fAAQDXnVsCvFrLCEjAcIWPYxaE9zNEZW73hYF6FAZsTaAE759RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5QLRSuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5QLRSuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E576C433F1;
	Tue, 13 Feb 2024 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707825765;
	bh=6HCUlSoMuBGgaqtWxR2FDmiEE5g9kFXXNUwkAtLC3YE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K5QLRSukDwutTuVWHIoWbdxkos5/KoTUx6huVBJ1Hr3qJVfe5IL3sm1sN5kRh3moS
	 PQg66f9sU6oPv/Tj3x5Wvlm0ZGXzchbJJxQSKnOZbS10te28zrfVhM5Jbi1k4wLwFa
	 RQNv9mw7DvJO+pWtmhVeSsJswL8eiHBrX2PJyz+55LFK9Ujk3fwhJC8dk7Znjr8eaW
	 NN1rafaEBjavnLd3kejYTZ1A7ow+5Du3c6M9Zh8MJK1uA96P5FTcrMzgAgXIPZaCi6
	 6rxQiTklvUTXMPRVo0n2Xz8eZO1jPXy5edZeu5+/Xz8L0pxIh9UGpo0QYGiaHTZbWQ
	 u95KXwzAZpgsQ==
Message-ID: <8253246b-9fbd-4dd9-940f-59667905de85@kernel.org>
Date: Tue, 13 Feb 2024 13:02:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v6 00/15] add helpers and vars in mptcp_lib.sh
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
References: <cover.1703158128.git.geliang.tang@linux.dev>
 <ZcrvUkBhCbOvcfPX@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZcrvUkBhCbOvcfPX@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/02/2024 05:25, Geliang Tang wrote:
> On Thu, Dec 21, 2023 at 07:31:03PM +0800, Geliang Tang wrote:
>> v6:
>>  - rebased with:
>>  v3 fixes for CURRESTAB
>>  v5 dump for userspace pm
>>
>> v5:
>>  - rebased with "userspace pm enhancements" v13
>>
>> v4:
>>  - rebased with "userspace pm enhancements" v12
>>
>> v3:
>>  - merge squash-to patch for v2:
>>  Squash to "selftests: mptcp: add mptcp_lib_ns_* helpers"
>>  - add a new patch:
>>  selftests: mptcp: simult flows: define missing vars
>>  - update patches:
>>  selftests: mptcp: export event macros in mptcp_lib
>>  selftests: mptcp: export cin/cout/sin/sout vars
>>  selftests: mptcp: netlink: fix positions of newline
>>  - update some commit subjects and commit logs.
>>
>> v2:
>>  - add more patches.
>>
>> Geliang Tang (15):
>>   selftests: mptcp: add mptcp_lib_evts_* helpers
>>   selftests: mptcp: userspace: capitalize test_name
>>   selftests: mptcp: userspace: print colored output
>>   selftests: mptcp: capitalize ok/fail/skip
>>   selftests: mptcp: netlink: drop duplicate var ret
>>   selftests: mptcp: export ret into mptcp_lib
>>   selftests: mptcp: extract mptcp_lib_check_expected
>>   selftests: mptcp: export event macros in mptcp_lib
>>   selftests: mptcp: add mptcp_lib_verify_listener_events
>>   selftests: mptcp: unify namespace names
>>   selftests: mptcp: add mptcp_lib_ns_* helpers
>>   selftests: mptcp: add ss mptcp support checks
>>   selftests: mptcp: add mptcp_lib_check_tools helper
>>   selftests: mptcp: add mptcp_lib_cleanup helper
>>   selftests: mptcp: add mptcp_lib_check_output helper
> 
> New version of this series was sent out, please change them as
> "Superseded" on Patchwork.

Thank you for the notification!

Sorry, I'm taking a long time to do the review. But I will do it.
Because I took so long to finish it, I can do the rebase of the other
patches if you prefer, that's the least I can do.

I marked patches 5/15 and 12/15 as superseded. Best to not mark them all
like that if the new version is not published.

Should I "drop" others?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
