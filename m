Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10383C1F
	for <mptcp@lists.linux.dev>; Sun, 12 Jan 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736686671; cv=none; b=fqlKcjAebYNHEuHkVm5ld2uzBWbJOgevZEwXDIPFP+Rh7eAvFHqt9RgA+XhMm2ZS1nzazcWRL8pTbFHSRIhUzTCGjJ6sXk500IbiOdSYRaQsegUVxsO+sKq3zNvOMGdpepF6GJ3oHKgbs9ini5mC2I6RL0Kkrq5KQkF83sVur1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736686671; c=relaxed/simple;
	bh=wZnZHhQANFTWBiJPUGVpA4S1jlHATm/6gzXxDKIwDiQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VCZBy9z5FMv30fCBdP3DlsDNYuvEBJAVr529SE2ACmHRL6OU6HZUx5l5pMZnaB4kVyXW3eUVlTDX7EUGRohu1FUtTxwVtKWyxq6mgDMsI+RkxRSzkj+vd0apLKU8GyEGbZmR6/qCm+Lwa0+qXMwg0RlomcrIQ8UnErfTCVMT4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8htPOxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8htPOxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFD5C4CEE2;
	Sun, 12 Jan 2025 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736686671;
	bh=wZnZHhQANFTWBiJPUGVpA4S1jlHATm/6gzXxDKIwDiQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=W8htPOxkoI3zVQsVHrhGIro4mw57b7bXEQwNDqAaO0nTDDgYIMMJZcUUooe5uyNlO
	 1K1rAnRkt3mf+/X/kchG45SAuH+l1/qxzSfPHM2jMkYUwzrTDMTHEmqlCjlUIXbJes
	 l4V1M9pzii6WqHnz62xj1Po2+nvASEJA+tjFSbr7fqY+yfc/fILy45Xvu2+dYGwHVT
	 rmBq4++hHGh6C4d+FYm65YGruse4WqT0k0a4NWP3qgaIj/9YPq0zIIDRRDPBNEyIQp
	 VtuDd7J9pUICVLp5rndUQulUVHBeUuBPwLpuFU3d8YLgyC/CRR5KTFofuHX3t71Ubl
	 ySyV2e9Qa/GSg==
Message-ID: <90124ad5-0195-4b8d-932c-5465de665572@kernel.org>
Date: Sun, 12 Jan 2025 13:57:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v9 0/8] use GENL_REQ_ATTR_CHECK in userspace pm
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
 <fd65072a-7bca-4b15-b184-b1213eecafca@kernel.org>
 <1c4ec8dc-bbdf-4e3c-b31d-306286ed9bbf@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1c4ec8dc-bbdf-4e3c-b31d-306286ed9bbf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/01/2025 13:43, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 10/01/2025 12:21, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 10/01/2025 08:30, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> v9:
>>>  patch 3, move the code using NL_SET_ERR_MSG_ATTR into patch 8.
>>>  patch 7, adjust the location of "pernet = pm_nl_get_pernet(net);".
>>
>> Thank you for the new version.
>>
>> I have one small request in patch 8/8, but I can fix that when applying
>> the patches if that's OK with you.
>>
>> I can also do the modifications in set_flags(), and fix the conflicts
>> when applying "BPF path manager, part 2" (if it is ready)
> 
> As discussed on the "BPF path manager, part 2" thread, I will apply
> patches from these 2 series with the suggested modifications.
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Now in our tree (feat. for net-next) with my/your RvB tag:

New patches for t/upstream:
- 5e429e15a686: mptcp: drop info of userspace_pm_remove_id_zero_address
- 81e5a669e7d9: mptcp: pm: userspace: flags: clearer msg if no remote addr
- 677a8abf8d6c: mptcp: pm: more precise error messages
- b4609c1a21bc: mptcp: pm: improve error messages
- b8f41c31bdfc: mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
- 59b41cafd64c: mptcp: pm: remove duplicated error messages
- 94f4c18c1bd8: mptcp: pm: mark missing address attributes
- 04606ffe7837: mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
- Results: 632bb7330ffe..472c88326ee3 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/2ee1204b47d42c73b7fb3bce9534d89666d24a98/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

