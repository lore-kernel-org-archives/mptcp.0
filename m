Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250928507C
	for <mptcp@lists.linux.dev>; Tue, 15 Jul 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598988; cv=none; b=rb4mqmiEPUp5GkcO8xKKsa1QVFqv320c8WE0Yrf0tfgetdx60rAl2kfS/ubX/Oi1r+Bv3yk9606GmOebs8wTg7ZS3FMQDceemfGXUQ6Mer7LHgPd0KTNs2NM45vMKY9/ZWMbAOPO6i3xL4JdCfWo6tvNS8ZwTurtbUPA/NHcTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598988; c=relaxed/simple;
	bh=O39zN+D4ykWCpzK0BhPVt6/IL786cVkrNjGl9IFtwwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CYpTJyRCMBAH6sCP1UObCZWegoFXhDF/ipcxtPrsVaREG1o0nNkhaE/fSAhuJ/zDcAv0TR5N9h0aT1ePg1RvsiwWmN+FHdlyaRYDMAaaai4ejULbqcoPFDpxfZlBhu5H4mFnkZd0BvB/06GzBqG/M87WIlvZ+rc8y/TnMbLwePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtlec1QS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtlec1QS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BEFC4CEE3;
	Tue, 15 Jul 2025 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752598987;
	bh=O39zN+D4ykWCpzK0BhPVt6/IL786cVkrNjGl9IFtwwQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Rtlec1QSjCO8skzTG6vdWYSTOxnKb7OvPOXIjtARmv0rlbkZjQY5ClUeBJYoie+xL
	 IfPc3q0o84F9BVDOL860itEyM/aUISq1A3gjZ2JE9q6QwoRoHMKNnj87WG42+rkNUf
	 Lh3+bv8FiSO+2eI09s61YRpDOJ5gJ7gUoFEKG7eue7vgA6QuJwi8gfBa+mvBA34lHu
	 XGhwBQZh2kqG81JyaldkEBZuf6MjpbV+LU7I4IRU7jHrICIGoSnaVqli0cM83e3CV0
	 S0MatvZCat9zNibwyJXxEdRcHqFeAv64LCJ/v/SlM2L0jPTWtwdSGe1tPJAB+/WFED
	 kEDA19NVX269w==
Message-ID: <4ea5a054-7e07-4b4c-aa5d-79542c79e89c@kernel.org>
Date: Tue, 15 Jul 2025 19:03:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/2] Fixes for "selftests: mptcp: connect: cover
 alt modes"
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
 <e33e7262b9c30069bfe9666114ca796707a8324c.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e33e7262b9c30069bfe9666114ca796707a8324c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 15/07/2025 11:52, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-07-15 at 11:49 +0200, Matthieu Baerts (NGI0) wrote:
>> Without that, all mptcp_connect*.sh subtests have the same name, e.g.
>>
>>   mptcp_connect: ping tests  ## from mptcp_connect.sh
>>   mptcp_connect: ping tests  ## from mptcp_connect_checksum.sh
>>   mptcp_connect: ping tests  ## from mptcp_connect_mmap.sh
>>   mptcp_connect: ping tests  ## from mptcp_connect_sendfile.sh
>>
>> In such case, the CI will only see one subtest, not 4 different ones.
>>
>> To fix that, MPTCP_LIB_KSFT_TEST env var can simply be set.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> LGTM!
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the quick review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- b3ad2903fba4: "squashed" patch 1/2 in "selftests: mptcp: connect: also
cover alt modes"
- 66d7601242b5: "squashed" patch 2/2 in "selftests: mptcp: connect: also
cover checksum"
- Results: c38c723b6c8e..dc8fe14f5e8b (export-net)
- Results: 422cf9363443..a5f1eec0881b (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/d202fc514d0d69e212781052c8ca20c6990f11f3/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/8a2039d246ee0028762f2304f8878e433afab20d/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

