Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC433555D
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256072; cv=none; b=eQTWsr7c4Uf1waeIFZbjZl+UCgKPoYymIVbb2ewb9txCJ9etXxLIOikU5ceVZpOdwPsYXii8fMCde1BwPvkMeQ92EiaoUVfnp31/5xCZgJ7nIBY37mhljxIpUsBc/IA41UKIooebHP2gGNF+oXcmOX97XBgL6+tV/SOamHAn9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256072; c=relaxed/simple;
	bh=XbCcbr53K34JjU0GuuCrEV7Wtu0jKNbkpo8TldSEDIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixOnZRr5u+nvgocG9iC2c8Laaz1ylcSdCb7hOD8+bKYVL3mMe7V9eEERESMCdtv0ycGbuye4rKEO9hKF440M/Osd8ZiAFOgopz9NS/hm+swtelL8uMFSnafsYaZ3OwC2CxWh3fsnxpwBk3lAubWO+xMVu7nqhSoToZbvXzcSNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZi1GqhJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZi1GqhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912D2C116D0;
	Thu, 27 Nov 2025 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764256072;
	bh=XbCcbr53K34JjU0GuuCrEV7Wtu0jKNbkpo8TldSEDIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VZi1GqhJg4rmbT9l1MCb3Z3dIv1map28L9PtIbcA2EiZ/n9cwQPyfVYSLkAWRYiWh
	 aIhWGZebjhACRt20FjA8+Iym9hta6swfa7kPC8aBPouHYSTp//YLIIcbJD6K2CGHVi
	 euRiZhF/MPC8I/tWvAyHT+goaO2Cbw/p4i5GnMzi6X//XLm7c4qqfgEbHQ/nr0+stO
	 Hlz0me/OLwRq7vARnubHFZ319M+wNK7uyPbD7GxVBTzxvkMRvWtj4AaImD+IugKUDf
	 YrpJgr0KvUdxJbTVnFEKvTI+3JLn9SEegUldrMrLHsyFw2jBR9zK1n3WKHLeqREFqH
	 37jvRXxRPsAYA==
Message-ID: <04b48141-fbec-40e7-a96d-3f25be09e915@kernel.org>
Date: Thu, 27 Nov 2025 16:07:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/3] mptcp: pm: ignore unknown endpoint flags
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
 <032f83ca-b331-9e4f-5739-de91b4a3ff00@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <032f83ca-b331-9e4f-5739-de91b4a3ff00@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 27/11/2025 00:54, Mat Martineau wrote:
> On Wed, 26 Nov 2025, Matthieu Baerts (NGI0) wrote:
> 
>> This is just a simple fix to ignore unknown endpoint flags. Recently, a
>> new "laminar" flag has been added. It can be set on older kernel
>> versions without effects -- which is good -- but it is strange to report
>> it in the endpoints dumps if it is not supported.
>>
>>  # uname -r
>>  6.17.9
>>  # ip mptcp endpoint add 1.2.3.4 laminar  # not supported on v6.17
>>  # ip mptcp endpoint
>>  1.2.3.4 id 1 laminar
>>
>> Patch 1 fixes that, while Patch 2 validates that.
>>
>> Patch 3 is for mptcp-next, to correctly follow the specs and accept u32
>> flags instead of u8. This doesn't change anything, but avoids
>> confusions.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Matthieu Baerts (NGI0) (3):
>>      mptcp: pm: ignore unknown endpoint flags
>>      selftests: mptcp: pm: ensure unknown flags are ignored
>>      mptcp: pm: align endpoint flags size with the NL specs
> 
> Hi Matthieu!
> 
> All three patches LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

> See my comment on patch 2 regarding an additional fourth patch for net-
> next.

Replied!

And applied:

New patches for t/upstream-net and t/upstream:
- 42678c2b1831: mptcp: pm: ignore unknown endpoint flags
- 61aa36a0d8af: selftests: mptcp: pm: ensure unknown flags are ignored
- Results: 643ff4ccf427..5bbaf3d47feb (export-net)

- 7174c458730b: mptcp: pm: align endpoint flags size with the NL specs
- Results: 70279bef46d8..1fea9a6bd10f (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/419c354054eb2e8a2c694be3ef18e8fc35780cc2/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/9e5249109d34f839b6573890fbab202a784b83cb/checks


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

