Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D930CF1
	for <mptcp@lists.linux.dev>; Thu,  5 Oct 2023 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id4LtZKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE3FC433C7;
	Thu,  5 Oct 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696521196;
	bh=Gs0rl8R/djxy5t/BDUDsHlgyla5URs2luWpxHO3cIEs=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=Id4LtZKqFJg2eMVqeECt9AqRUO5Id5l30naqtk7JhDbEiu7jVyYwwvGkXAPadsXuL
	 eUesZf1bxPV+EUT/wm1BEkbNLl6ja5YCsH14B5oDAmJFy/sJdGnc89EHJKMQwnEfYX
	 8PUm9LVCoVIE57M9vHicoZw7WkANLY++9XK+LUIDvv3xbPCCi1tzC+o3PsrsNPCbfP
	 p238DtZCoKVMBH3Li5l2wSqR9UjLsKIk25rckr9NMs2f7Kw6QGgtN7GuL9ZaSN9L+M
	 kVFIFwFKjpAEg7KEY21IJ8kQXbz6BIaGeaO/02kSGAXCZ2WVotc5xaSam45uFA1kE1
	 lBRLIIKRKxavQ==
Message-ID: <be741cdb-340e-403d-9cd4-e9b8f5e5dd6f@kernel.org>
Date: Thu, 5 Oct 2023 17:53:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 00/29] userspace pm enhancements
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <4faab698-f464-43b4-91aa-19177a0ee77b@tessares.net>
 <be43e409-389f-466f-a77f-0b24e29cb4f3@tessares.net>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <be43e409-389f-466f-a77f-0b24e29cb4f3@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/09/2023 23:37, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 28/09/2023 22:54, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 25/09/2023 10:41, Geliang Tang wrote:
>>> v3:
>>>  - drop patch 4 in v2
>>>  - invert patch 10 and 11 in v2
>>>  - rebased
>>
>> Thank you for the v3! And again, sorry for the delays!
>>
>> I think patches 1-11 + 13-14 are OK to be applied (with two small
>> modifications for patch 7 and 11 that I can do when applying these patches):
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> Please note that patch 13 will go to "Fixes for -net". Patch 14 can stay
>> in "Features for net-next" due to other dependences.
> 
> I just did that:
> 
> New patches for t/upstream-net and t/upstream:
> - 505a33d76a32: mptcp: userspace pm allow creating id 0 subflow
> - Results: 05758f924fe3..999b9f7e47a5 (export-net)
> 
> New patches for t/upstream:
> - 1cb016e94837: mptcp: drop useless ssk in pm_subflow_check_next
> - 450deaf6dd71: mptcp: use mptcp_check_fallback helper
> - 6df74a0ced73: mptcp: use mptcp_get_ext helper
> - 03649553fd68: mptcp: move sk assignment statement ahead
> - 6bc1e5144525: mptcp: define more local variables sk
> - b7e3cc69d9fe: selftests: mptcp: sockopt: drop mptcp_connect var
> - 14c099dbd7a7: selftests: mptcp: display simult in extra_msg
> - 7d9e508e1117: mptcp: add mptcpi_subflows_total counter
> - af6ed0819599: selftests: mptcp: add evts_get_info helper
> - 9177dc0b474c: selftests: mptcp: add chk_subflows_total helper
> - bc1edd827cfa: selftests: mptcp: update userspace pm test helpers
> - 0dd61d4e14e8: selftests: mptcp: userspace pm create id 0 subflow
> - Results: 3be1c8ce544a..516baae7a220 (export)

I think these patches are introducing regressions because these tests
are now regularly failing on the public CI:

  - 112 - mptcp_join: userspace pm add & remove address
  - 113 - mptcp_join: userspace pm create destroy subflow

I didn't check in more details but I see they are failing since
export/20230928T213439 and only when running with a debug kconfig (slow
environment), e.g.:

  - https://cirrus-ci.com/task/5444189572300800
  -
https://api.cirrus-ci.com/v1/artifact/task/5444189572300800/summary/summary.txt

Do you mind having a look?

Maybe the connection has been closed when looking at the number of subflows?
Also, it looks like the helper looking at 'subflows_total' with older
versions ss is producing a lot of debug output that can be muted.

Cheers,
Matt
