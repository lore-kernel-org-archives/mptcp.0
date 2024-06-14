Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054BD52A
	for <mptcp@lists.linux.dev>; Fri, 14 Jun 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384423; cv=none; b=B8AxrCD6ZpoSdp9PWfU7DZE6FzFA5gyy9WpIlIFaWS/kzZeSEfoW7h7fJrpm2i6IepWDsLft0MVrpKEJQhYmZKWQUttl/azjoaezKL5Q02ZO4XUGhlOGb0+ygu0M/NvqVmewDWVkcNga7p010XqQqsZq+DHi3YOgUxMWdVbLOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384423; c=relaxed/simple;
	bh=R+Pl3GeSDt3Ok2hEqto6tsZ1UySoMyirMpufA1YljB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YKeGHzR2fWX9a0ZLbXGfWhQREwgqz2PqeyeE+ktYM7+jc8acI+JtfAe/muTlkUbD14ml3RXIDcSGpCw8PgyOlmXhVHCsNpdGiMs1d7HcPZfFuQpKB5DiqfgjGXQTkzNi7MTMa9AHibpGzLQ8ZlONdx5DQP9/8nUPrMpVbEPxphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTUnpSbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTUnpSbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEE1C2BD10
	for <mptcp@lists.linux.dev>; Fri, 14 Jun 2024 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718384423;
	bh=R+Pl3GeSDt3Ok2hEqto6tsZ1UySoMyirMpufA1YljB8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XTUnpSbJCDozruECoWr4Fz0upkiLymQlRZNcN1OHxXNnukN9JYbV1ytrBhuAH115r
	 AYk70WbTh6dRULkvS+dZVn7sc98dlC55uQPIzBXzT7zDWZv8q11kCerGKrxz8VdmMT
	 Gpgo70I4XOpL8uMRbs6bffGqjp7jhWZocibPCh1dXQs6Yoc9iBjp9IVa0Rc+R6tMlB
	 nKbrbGrMOHzfwAjZ30ABXDlU3eSeHEA70fH8NgciO2kzv0A0649UdRtiPo1O3ufgbF
	 iLp9Kz6ArGYA+Dojt2kJkUIuFiTxRhChaMnSjqIf683M7f2aujlSNySG/GkTSWiSq/
	 3kFCkIebY6W4g==
Message-ID: <3ba46260-7114-4eb2-b95e-12f4f2109a81@kernel.org>
Date: Fri, 14 Jun 2024 19:00:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] selftests: mptcp: userspace_pm: fixed subtest
 names
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-b5cb8274627d@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-b5cb8274627d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/06/2024 18:52, Matthieu Baerts (NGI0) wrote:
> It is important to have a fixed (sub)test names in TAP, because these
> names are used to identify them. If they are not fixed, tracking cannot
> be done.
> 
> Some subtests from the userspace_pm selftest were using random numbers
> in their names: address IDs from $RANDOM, and the client port number
> randomly picked by the kernel when creating the connection. These values
> have been replaced by 'client' and 'server' words: that's even more
> helpful than showing random numbers. Note that the addresses IDs are
> incremented and decremented in the test: +1 or -1 are then displayed.
> 
> Not to loose info that can be useful for debugging in case of issues,
> these random numbers are now displayed at the beginning of the test.
> 
> Fixes: f589234e1af0 ("selftests: mptcp: userspace_pm: format subtests results in TAP")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - The Netdev CI is parsing MPTCP subtests again. Because it is affected
>    by this bug (passed tests are tracked), I suggest to apply and send
>    this patch ASAP: it is only modifying the test name, it sounds safe.

As mentioned here above, already applied:

New patches for t/upstream-net and t/upstream:
- edfe5011523a: selftests: mptcp: userspace_pm: fixed subtest names
- Results: 2ae7e8ada2b1..b7a82c8e4bc4 (export-net)
- Results: e0a0b47b386f..74472bedc83c (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/f2572787c6e2b8b6f29da7ab189f621626827f65/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/2de6052ef9f255dede8ffbb24ec1b8474cf4d955/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

