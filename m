Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656C5FB8D
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836344; cv=none; b=QLM7YEufDS8FNcTH13JLhA9w+5cr7qelepiE7zO10/bDidYfKO+YCov5wyHzQJyvxGn08ogJVOcDg460BRBUHcuqArDPU3kkGyDlbRkcoW3KJl64LZRglbf5WAFx1W7QFY7Xhg4cai+p1PJM3LC+zCE91n39z+lQCl/EdT6JQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836344; c=relaxed/simple;
	bh=gh6HpSPXnzJFd4/icZVokKjY6H9OmxckuVNj1nqvuTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6r6AeWwH679APYbeNvCt37iZnF57I49I9DTYTyHIie5G54YSTu7yLlkV5oSG2LyvqJI1LtSkSwKk9EDObOK/80DkjSI2JFBYKbO0eQoHrRhOlfalfHXj6DBNBSv+G0e0S0MrugFfYZQgv2P+vdL5cu3CGlm2iHZsGle1eUgdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3XDd0Pa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3XDd0Pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31E4C433C7;
	Tue, 13 Feb 2024 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707836344;
	bh=gh6HpSPXnzJFd4/icZVokKjY6H9OmxckuVNj1nqvuTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f3XDd0PaP+K2K/x078BnZ+g2DPncMo2sJW3XPw270WF7DwBHxtABQwbeRO/ZLaxVi
	 9qkSQosqKMB3S4QG54BKBImFPSaY61mE9oHqpLr01xlQukvPsn6RaDXFkVAykLwl2R
	 9CKleHP5QVbmb8DJB4zHvYnbICBR3j5S0ad/JIuoPymGKbSyXwNkuP289esezxkDgh
	 f8ZcfcQjP9+UIbmA6YM22tWFhLISU9vRU4DXihkEeI37ibumO9EQYguibdmn3eo4BF
	 fU3VN2KcuN4Ejdwsu9e25XrnqIJfNTp1PijRN6s1vzjKA/cExQKOyAz9h9gijkqPkE
	 zqHja6aZQjt4g==
Message-ID: <4b764f2a-f654-4ac7-89d4-74a34b07f0e2@kernel.org>
Date: Tue, 13 Feb 2024 15:59:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 1/3] selftests: mptcp: pm nl: also list skipped
 tests
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
 <20240207-selftests-mptcp-fix-5-15-v1-1-005b0cdb135a@kernel.org>
 <CA+WQbwtXWKNpKDQ1sMF-7E-ewx1Mh09sHijO76OgVR_xotLkew@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+WQbwtXWKNpKDQ1sMF-7E-ewx1Mh09sHijO76OgVR_xotLkew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 13/02/2024 14:35, Geliang Tang wrote:
> Hi Matt,
> 
> Matthieu Baerts (NGI0) <matttbe@kernel.org> 于2024年2月8日周四 02:18写道：
>>
>> If the feature is not supported by older kernels, and instead of just
>> ignoring some tests, we should mark them as skipped, so we can still
>> track them.
>>
>> Fixes: d85555ac11f9 ("selftests: mptcp: pm_netlink: format subtests results in TAP")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
>> index 8f4ff123a7eb..79e83a2c95de 100755
>> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
>> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
>> @@ -194,6 +194,12 @@ subflow 10.0.1.1" "          (nofullmesh)"
>>         ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
>>         check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
>>  subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
>> +else
>> +       for st in fullmesh nofullmesh backup,fullmesh; do
>> +               st="          (${st})"
>> +               printf "%-50s%s\n" "${st}" "[SKIP]"
> 
> I prefer to use "[ SKIP ]" here.

I would prefer too, but in this file, we are currently using:

  [ OK ]
  [FAIL]

I think it is then better to continue using 4 letters between the [], no?

  [ OK ]
  [FAIL]
  [SKIP]

If we want to change the format, and even add colours, we can do that in
net-next, not as part of a fix for -net.

> Otherwise, this series looks good!
>
> Reviewed-by: Geliang Tang <geliang@kernel.org>

If you don't mind, when a whole series is OK for you, can you share your
"Reviewed-By" tag on the cover-letter please? By doing that, your tag
will be "propagated" to each patch. While here, 'b4' will see it as only
valid for patch 1/3, but not the rest of the series.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
