Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27622099
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598961; cv=none; b=jTubPrb0na45crNYBfkIxmRhz15EF12fBH2Zn2LahwWOj3xrOCWI/QKxxGIQUX1ZM1asHiL6mWOLOShK7gVrvIBsOL/+yS9qqUqQqbPcRCEtLbL5wm7tkUiW0/GaZ8fqv0kWK2kQ3v43l13PC/miYh5N79obHIXOf7jwOIn7yg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598961; c=relaxed/simple;
	bh=ndnZY1yiC9PI0q9p9UvGvz2uQmxwEOgYQrJ64BUZ+vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuTmRC/Zb0vPdleNhpzx4Foz/fIFfbGoZmFNssSCy4PXJSVwrqMMVMFYAHK1QuNW0UMdCrQHwxGgDRZyIizk1qhl9qp+HgmPbntM1oAao0IimFkWqvxmY/xfeonQGUVIeKOF2xJ1L8Qcp2DvwC++2ADOwgZjMWxl8Phr5hbC8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxE/GcwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxE/GcwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A7CC433F1;
	Thu, 22 Feb 2024 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708598961;
	bh=ndnZY1yiC9PI0q9p9UvGvz2uQmxwEOgYQrJ64BUZ+vM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rxE/GcwUhrHxTajDx+Xb7CpZVbBUEQgTvLT9BnCblK6572Hda7TDHt/oRw0bG9Wcw
	 VF2p71jOa+bk6bCK6FrL9nRoVO1j4T8erfj9lo5q28h1gqmkaKhiLw65xaHa5otig2
	 ihRK783ysBYg1UJpNLK1eftctxAKDLAgbrIhnzyNhvCNvooU0sgiU50nqjncAc2hJ/
	 CgNUEIn2yXk2djRXHECfIO8GPOn+VT0V1XxjCJmPgY5x3yQlkc6xUpO3YHuwcbvaHt
	 eJ/OPZ2DpKeQLPgMrB+8tecn6++NdXCi2EvRmwHLLRGIX4KYyEQNRUTn8UacwT2Qil
	 Xf8+OV+b1/asw==
Message-ID: <2f6096ac-568f-46a6-9938-3d57ad02536b@kernel.org>
Date: Thu, 22 Feb 2024 11:49:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] selftests: mptcp: don't exit when a symbol not
 found
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <37d9862958848f8f3737eafd1b1ea0bdb63acd91.1708588566.git.tanggeliang@kylinos.cn>
 <338c256c-1492-4ea8-8d3d-eca7e075b0ef@kernel.org> <ZdcibFuKvYXnXF5J@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZdcibFuKvYXnXF5J@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 22/02/2024 11:31 am, Geliang Tang wrote:
> On Thu, Feb 22, 2024 at 09:58:39AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 22/02/2024 8:56 am, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> mptcp_lib_kallsyms_has() will always exit when a symbol has not found, it
>>> breaks the test itself. Unexpected errors occur:
>>>
>>>  007 userspace pm add & remove address
>>>        syn                                 [ OK ]
>>>        synack                              [ OK ]
>>>        ack                                 [ OK ]
>>>        add                                 [ OK ]
>>>        echo                                [ OK ]
>>>        mptcp_info subflows=2:2             [ OK ]
>>>        mptcp_info subflows_total=3:3       [ OK ]
>>>        mptcp_info add_addr_signal=2:2      [ OK ]
>>>        mptcp_info last_data_sent=191:18    [ OK ]
>>>        mptcp_info last_data_recv=40:68     [ OK ]
>>>        mptcp_info last_ack_recv=93:74      [ OK ]
>>>        dump addrs signal                   ERROR: missing feature: \
>>> 			mptcp_userspace_pm_dump_addr$ symbol not found
>>>  Cannot open network namespace "ns1-65d6fb5a-5FviVK": \
>>> 			No such file or directory
>>>  Cannot open network namespace "ns2-65d6fb5a-5FviVK": \
>>> 			No such file or directory
>>>  cmp: /tmp/tmp.a7osJs7Nj0: No such file or directory
>>>  cmp: /tmp/tmp.f02z6brCQu: No such file or directory
>>>  cat: /tmp/tmp.27TzxD2efV: No such file or directory
>>> not ok 1 test: selftest_mptcp_join # FAIL
>>>
>>> To fix this, this patch adds a new argument 'continue' for the helper
>>> mptcp_lib_fail_if_expected_feature() to control whether exit or not.
>>>
>>> Always set this argument to 1 in mptcp_lib_kallsyms_has().
>>>
>>> Fixes: 83013bdf90a ("selftests: mptcp: connect: skip if MPTCP is not supported")
>>
>> I'm not sure to understand why you sent this :)
> 
> Say in the test "signal addresses race test":
> 
>                 if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
>                         chk_join_nr 3 3 2
>                         chk_add_nr 4 4
>                 else
>                         chk_join_nr 3 3 3
>                         # the server will not signal the address terminating
>                         # the MPC subflow
>                         chk_add_nr 3 3
>                 fi
> 
> This code will never run to this block:
> 
>                         chk_join_nr 3 3 2
>                         chk_add_nr 4 4
> 
> Since if no symbal of mptcp_pm_subflow_check_next, mptcp_lib_kallsyms_has exit.

This block will never be executed in our CI, because our CI always run
the selftests linked to the same version of the kernel. In this case,
that would not be normal to execute this block in our CI, it has to
complain because we expect to have this symbol in the latest version.

Other CIs, like LKFT, which are validating stable kernels (e.g. 5.15.x)
using the selftests from the last stable kernel (e.g. 6.7.x) will not
have SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var being set to 1 as
we did in our CI. Then it is fine, tests and checks will be skipped if
some features are missing:

https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2cJxC6Sua3VVzRZmpQYKK2jzzNN/logs?format=html

> You can trigger this by renaming "mptcp_pm_subflow_check_next$" to
> "no_mptcp_pm_subflow_check_next$", an non-exist function name, for test.

I confirm that if you use 'mptcp-upstream-virtme-docker', this env var
will be set to 1 by default:

  SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1

You can unset it on your side, but it only makes sense to do that if you
work on stable kernels (and you use selftests from a more recent
version, not the ones attached to the kernel you are validating).

So yes, in this environment (where we force setting the env var to 1,
not the "default" behaviour), picking a non-existing function name will
cause the test to fail: but that's what we want → we want to be notified
if we picked a non-existing function, like it happened recently:

  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7988706773

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
