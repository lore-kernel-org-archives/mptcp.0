Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B2375ABE
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293931; cv=none; b=uFh1M8BU1YWoji47clOZk0E6QiEp9ZkBvMWNplbTD9ibPwVIg1+Vj94wriaOzfNILEBoV4/it/KuVob8uvAsFiUe3qL4t46lwT8maieifuaurOuIJIEsBGpDWTmbsf7KJkcNqo13aoEIzJNREFdxT33uY+LbVEVj3y5lkH7FqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293931; c=relaxed/simple;
	bh=f0H6LZOlDbu9A6PRvCA4nQ6KiBemt/gzSdpf8yZp6G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ej193vK+qzUjy/23kAfAgZl/0smTvGV7TLu0+U5ENxsryBXf+yjPEH/ELokXzuDnn7DwHssCa10VthoQP0dExrvgW8FzwP95iN/0wRpow9orRCji6/jeoGCtZinvbgplX9XduE8cbleii/Vft44PP0t1TzxhV2uag9eTbBW/SXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei2n5hlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei2n5hlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01C71F000E9;
	Fri, 21 Aug 2026 06:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787293928;
	bh=8qVy6KnSUYM25Iz4GMiZeO2CFKr482CEvuqy7OC0pc0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Ei2n5hlCZtGTb6cQkVBE05h+QLRp3D4AnGrSL6I/UQuD+WBmAipZKAI3pIL4SWrI1
	 4gYvc2Cw58hYm7a2Gs9DrOZ0VjN9wUcqEplqwZuwR4QJ/cQede7CTSBVIiULzijjEG
	 5IGyTLxHojgWM09O8Ur3QkpXEEUihD7QaZcoULUxNNRJ907DMTnbTkDP6X8AAxV6Gu
	 iibWbMVP4QcJEC3HOBMITigw4Ofu9lRNKVA0nmH9WBM/CgkMD16OxDbIcG54CBluR/
	 blufOfcQ43LeHLzroCgaoOtl2qc4Dv9GrCVKljs5lx3iYTEZfUuS5zMq197eXJPTa9
	 kdxSTuMB1sfzg==
Message-ID: <4a6a4ef8-4b3e-4717-9dfe-4f6d7fc14b77@kernel.org>
Date: Fri, 21 Aug 2026 08:32:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/3] mptcp: avoid uninitialised read with MPJ
 with SYN cookies
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
 <e9ea4afd-f549-1fa5-3eac-910b12ad7e4d@gmail.com>
 <0234c8e501a033d22733138b77ce19270fed7401.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0234c8e501a033d22733138b77ce19270fed7401.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 21/08/2026 07:37, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2026-08-18 at 19:20 +0000, MPTCP CI wrote:
>> Hi Matthieu,
>>
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
>> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
>> - KVM Validation: debug (except selftest_mptcp_join): Success! ✅
>> - KVM Validation: debug (only selftest_mptcp_join): Unstable: 1
>> failed test(s): selftest_mptcp_join ⚠️ 
>> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
>> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> 
> This series looks good to me!

Thank you for the review!

New patches for t/upstream-net and t/upstream:
- cba636a2dcab: mptcp: syncookies: remember the request backup flag
- 413a21edd334: mptcp: subflow: no need to copy thmac during ulp_clone
- Results: eeb8d1d44a74..6bb246941708 (export-net)
- Results: 41733b9765ba..aa4bae9bfb46 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/d9e7fa174e7b3c63fafb99573c8c7e1a8ce53b06/checks

New patches for t/upstream:
- 631307ac3350: mptcp: remove thmac from subflow ctx
- Results: aa4bae9bfb46..2f5abecdd265 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/c2aae803b2f7c409357b41bf3e0dbd7eda58a4ee/checks

> nit: You could squash patch 2 into patch 3 if you want, but totally up
> to you.
I didn't: the 2nd patch is -net material, while the 3rd one is for -next.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

