Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B3286417
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755255653; cv=none; b=BREOQmVEoziSFeoexKZRlAKMScmkYZvzQi+kE7yLsYqI8s2/cPQCBuMWnbOoOt3M4knAOvnGQai91J4d7pC824GKj0RdtmJgvwr0P48cfiCr6jvDKgGtUH3pn6mQFRDOxRyhfhS8Hn0iKxmnW8fp45damkqprYpX6WL2uSbuPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755255653; c=relaxed/simple;
	bh=tIMGLNlVLzrgsLVdKvS3w7uex4B7IEf7fOr+qV8iUFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ0QywADoMxx6FL8Zh8YfkH6fZe3JCGJABF1ryZ/KKzTICuFvULQ6uzFDklFdm4SmktBZeDwCJCU4ixJOlkfcYTil1W9vFgrxYsMl/iA5TpOXWm79kiqKa6sgTOaK73XbfieNNdcrCzZ3JRFybsYNxvsHH3Lcpawl6Y9JzSOu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is0OLzBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is0OLzBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5423C4CEEB;
	Fri, 15 Aug 2025 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755255652;
	bh=tIMGLNlVLzrgsLVdKvS3w7uex4B7IEf7fOr+qV8iUFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Is0OLzBPaIwQDahJGwLc+anjqNCxlueujxINpmTI/XeqK5E2N+J1vQIGZArChdgo2
	 lV9woCj/APQ4V9mjMurXIr/3ZpeGR/U4bsvQbeyerquCweoACzxP0V6AsUdLUyvxTi
	 30gdwp7WSAwow8a20Q+YpKPfnP9Q69VCVrUnYbNgLerYVImzXklrPoAlrRw6hWnGit
	 iPYBEa1uO43YvJh7GeUwP9jkeGZj5q3eMRJ3ZYdMWu8byHDgCO4SIRcTvGLEjWh488
	 tva5Lp4CI7ryGRl+zD5FUd9XxSZQr9EqTFCFNdeRiyCp/MuUsUxl+ahZzR+co1tcVg
	 eXQ/h3Vbv2FOw==
Message-ID: <e8ddeb7f-2603-45c4-8324-d715c2c10630@kernel.org>
Date: Fri, 15 Aug 2025 13:00:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/2] mptcp: pm: kernel: flush: do not reset
 ADD_ADDR limit
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Thomas Dreibholz <dreibh@simula.no>
References: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
 <89bfba12-6c8d-d873-6390-905e5c5da63a@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <89bfba12-6c8d-d873-6390-905e5c5da63a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 14/08/2025 02:25, Mat Martineau wrote:
> On Wed, 6 Aug 2025, Matthieu Baerts (NGI0) wrote:
> 
>> A flush of the MPTCP endpoints should not affect the MPTCP limits. In
>> other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
>> limits'.
>>
>> But it was the case. Patch 1 fixes the issue, and Patch 2 modified
>> pm_netlink.sh selftest to validate the modification on the kernel side.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Matthieu Baerts (NGI0) (2):
>>      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
>>      selftests: mptcp: pm: check flush doesn't reset limits
>>
>> net/mptcp/pm_kernel.c                           | 1 -
>> tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
>> 2 files changed, 1 insertion(+), 1 deletion(-)
>> ---
>> base-commit: 8353c34f924e5fb87e86e5587e15df160add9a44
>> change-id: 20250806-mptcp-pm-flush-limit-c5a2d74fc2ea
>>
> 
> Series LGTM, thanks Matthieu!
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 7f177b98bfef: mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
- d62e61868bae: selftests: mptcp: pm: check flush doesn't reset limits
- Results: e81a6d054101..3f23a1fbaa6a (export-net)
- Results: 6e5604790ba7..7c14230bb733 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/af6558fbffb5f4001db78a0b124920bc4555ae7a/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/0e9edf26da4f62d2781a9cdca55e6e6af18d5c0e/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

