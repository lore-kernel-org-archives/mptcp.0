Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA419925B
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543884; cv=none; b=Plq1DXUIkVlkCUCrHi2+pTWOmKWp/BQIoTw9h2CyZGRq/5F3gnbFR8Divrv1aZr70qsJ79utX65ZfpqbEbYyezaFI7YYvRAO+SfRjO3A+G6qNsOwb4RpObLToSsk9Y/ea6zgc7L8BrXxoMdx/p/IISxjqv6K/8G0mv92vgiu1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543884; c=relaxed/simple;
	bh=y8gsH50aU2pSGTI30kGy58y3/qn6jvUYkFqiOUvgkMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qS6iV7jaNOgZEeYpanj6lClxeojim0D890paRVw+N+ryIrmAd8w0wnEgtSE/jewncMv+1Ztyh2BYmE1X8llZqMeUdHeTX5K/hiKgiW7jaQkngI37O0A3BJOs4Z+06ZifitVhc6/IdZOfkrVmcIQIjbtNbkGNsh5QkecmmiNRSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahARoht9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahARoht9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB6AC4CEC3;
	Thu,  5 Sep 2024 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725543883;
	bh=y8gsH50aU2pSGTI30kGy58y3/qn6jvUYkFqiOUvgkMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ahARoht9EiTujKo5gryQeQEB7WQ9FTgZ6TNP+xx/+RFBCK/sMOmbxTVWVKqUklTLh
	 AsLwyV5T2Mhsx9DlX24bSvIgo+ydj64aSB/KMHyOao8nEcj9pYKh39uXAc6iQtVVVS
	 5BqYIBIeaGcbNQI6rHPVk9BwdTssBgXXOxB90TLWcaWLubfKyngboIAHE/MCUwb7dX
	 htHgcl0igc/ZkLYJppH601oQwEV0TjziQUrkPNQXv7WQEkbRFPXa5WWuKX7nAEm0iV
	 dBxqixC/WxGbToEGXhrFlHsPLWQfjxV4H2K1ImYxBVwKb2USDFuL292Bja/FyJisDV
	 UNTpXqJJlw8dw==
Message-ID: <63e9c0e5-d7e0-4519-881f-56c5dd949b07@kernel.org>
Date: Thu, 5 Sep 2024 15:44:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 0/4] fixes for "new MPTCP subflow subtest
 v4"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
 <0d421ac2-173c-4ab4-9b95-95c9251acbd8@kernel.org>
 <2466edbcaa6c6031e35270ecc359c92873cf259f.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2466edbcaa6c6031e35270ecc359c92873cf259f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 05/09/2024 12:59, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, 2024-09-05 at 12:29 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 05/09/2024 04:26, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> v8:
>>>  - drop bpf_printk, use different errnos (-1, -2) instead for
>>> debugging:
>>>
>>> run_subflow:FAIL:getsockopt(client_fd, SO_MARK) unexpected error: -
>>> 1 (errno 1)
>>> run_subflow:FAIL:getsockopt(client_fd, TCP_CONGESTION) unexpected
>>> error: -1 (errno 1)
>>> run_subflow:FAIL:getsockopt(client_fd, SO_MARK) unexpected error: -
>>> 1 (errno 2)
>>> run_subflow:FAIL:getsockopt(client_fd, TCP_CONGESTION) unexpected
>>> error: -1 (errno 2)
>>>
>>>  - move more duplicate code into _getsockopt_subflow.
>>
>> Thank you for the new version! Now in our tree. Because there were a
>> few
>> squashed-to patches + additional corrections + conflicts, please
>> check
>> that the export branch looks OK now.
>>
>> New patches for t/upstream:
>> - a46e44a2ac5b: "squashed" patch 1/4 in "selftests/bpf: Add mptcp
>> subflow example"
>> - df1c9da900a8: tg: remove t/selftests-bpf-Add-mptcp-pm_nl_ctl-link
>>
>> - f259c76495da: selftests/bpf: Add getsockopt to inspect mptcp
>> subflow:
>>   + updated commit message
>>   + added mptcp_bpf.h file
>>   + adapted MAINTAINERS file
>>   + added comments in mptcp_bpf.h about the origin + modifications
>> - 6efeaa2ddfaf: conflict in t/selftests-bpf-add-bpf_first-scheduler
>> - 52d77c8981d3: conflict in t/selftests-bpf-Add-bpf_bkup-scheduler
>>
>> - 5daceaf2c412: "squashed" patch 3/4 in "selftests/bpf: Add mptcp
>> subflow subtest"
>> - a1f7132c9bad: Also drop _ss_search()
>>
>> - d2064c588b9f: "squashed" patch 4/4 in "selftests/bpf: Add bpf
>> scheduler test"
>>
>> - Results: df250dc71896..fb68bc3776eb (export)
>>
>> Tests are now in progress:
>>
>> - export:
>> https://github.com/multipath-tcp/mptcp_net-next/commit/51e2be27cea9c5e4dd17b25cade6fcaf055daf52/checks
>>
> 
> This error occurs:
> 
> progs/mptcp_bpf.h:53:1: error: redefinition of 'mptcp_subflow_tcp_sock'
>    53 | mptcp_subflow_tcp_sock(const struct mptcp_subflow_context
> *subflow)
>       | ^
> 
> mptcp_subflow_tcp_sock() needs to be drop from "selftests/bpf: Add
> bpf_rr scheduler & test".

Thank you for the quick validation!

Fixed now:

New patches for t/upstream:
- e4eee5701eea: selftests: bpf: fix compilation issues, "squashed" in
"selftests/bpf: Add bpf_rr scheduler & test"
- Results: fb68bc3776eb..b0b522c239d0 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/12be656fc07a6c935524652a1b2209f437247465/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

