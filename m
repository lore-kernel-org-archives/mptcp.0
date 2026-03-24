Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D386313527
	for <mptcp@lists.linux.dev>; Tue, 24 Mar 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378717; cv=none; b=nLp+i1wDmJ32Ln8orRUpWmpl2TvGhtFf9KGw33Ef9ueBKuoHOdTVmFpsOxW+P4CTdl5+B0EwNmJZwQqQ83Z6f+AndHnxJQ3m8/m0YsQ8MOulwFwzsnlMzQUp/ObtocpdlXQMyjfISTEtICp8xpEZ9ou6ID3sxYkMopcqIWrc308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378717; c=relaxed/simple;
	bh=KTEqxraSFNW3E3Eq7DzEG6+Ky5D2dc79KFUGsaWiIg4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FmTb1nq/w11Bo/+tpkFMkamGNgbZyuVAqlXHYJ1c/4aWGs1n/ccfZADmBwk4RqkZ2kBbtmnJ6zWZTEX0h2lnBjAsP/bmS3rbXBJg63l5aBex9f6cJmtLprzy1xI8Y7A7883Ibusx7FwU4MAEbI4cdZb++dGLmWaCX6RKiD/LY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVDik6/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVDik6/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435F5C19424;
	Tue, 24 Mar 2026 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774378716;
	bh=KTEqxraSFNW3E3Eq7DzEG6+Ky5D2dc79KFUGsaWiIg4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QVDik6/vLEnDhW7Hf5eVtDv0OaF6wy/yaHm31tkfU2ryfbUYR1/KOCleBXSQVh2rb
	 rmsu++MI5wjAgltYTy0EwSYLBQicpkt9LOH+WrPa2YiOxvQbI7DfeOzMt+MbMK8ctr
	 ja6geDoJiGZgymID9QiLZr9S2YUyzsgki/h3tghPyWDaarsDeY12BukYDNWN71t5fo
	 p1M2iGpVaepw6ghfVp1As6UaD9Dft3QgSx9njNVZZPPYTTnnZq0tHCEtl0WjrZVjhb
	 0GZjaJFMnpPB7GuBLCPqiwg9PJ6an869Ig95oBwTxvZKaW2zj6Q7IejLfNuccPTQex
	 83mNu6+w694ww==
Message-ID: <b7c986c5-5cae-4bdc-889d-9d3608cdbeba@kernel.org>
Date: Tue, 24 Mar 2026 19:58:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC mptcp-next v10 00/14] MPTCP KTLS support
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
 <347b9b69-7fcb-d7eb-a3f8-921d1a6060de@gmail.com>
 <b7ce3e8b-dd6a-49c7-aede-23c846c6dfc4@kernel.org>
 <d229f43010fd00178c87d2acd78bc7519d3c516d.camel@kernel.org>
 <d7e039cb-0cb4-47c4-bbd2-11d890c5d381@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d7e039cb-0cb4-47c4-bbd2-11d890c5d381@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 20/03/2026 09:07, Matthieu Baerts wrote:
> Hi Geliang,
> 
> 20 Mar 2026 08:45:58 Geliang Tang <geliang@kernel.org>:
> 
>> Hi Matt,
>>
>> On Tue, 2026-03-17 at 14:15 +0100, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 17/03/2026 11:41, MPTCP CI wrote:
>>>> Hi Geliang,
>>>>
>>>> Thank you for your modifications, that's great!
>>>>
>>>> Our CI did some validations and here is its report:
>>>>
>>>> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
>>>> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
>>>> - KVM Validation: debug (except selftest_mptcp_join): Critical:
>>>> KMemLeak ❌
>>>
>>> It looks like the leak is linked to the new code. Is that right?
>>
>> Yes, it's related to the changes to shutdown_reuse() in patch 12, and
>> it has been fixed in v11.
> 
> Great, thanks!
> 
>> However, I noticed that v10 and v11 didn't trigger AI review. Any idea
>> why?
> 
> Not sure, maybe the RFC prefix?

Most likely the AI review system doesn't support the Based-on tag you
are using, and it fails to apply the series without the dependence. I
don't have logs to confirm that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

