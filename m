Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CCB13FF6
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEOA4Ibc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4479AC433C8;
	Fri, 13 Oct 2023 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697198053;
	bh=eXP3NIU1vuBsEbwK0EnHCe3lP1OuA20e9hlYtRjB2Q0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HEOA4IbcYpk9CkDpcIfo4HhfbEQi8MsT/tZg0tGHpKvao5DawwwL5ut4iwdrqh47m
	 7w4EtHo4rJAtDk9wkcwI2l8QsPJiLQd3VUklSyHG/frSYljEUU9SBD2zVhchIFnNTb
	 dPtdwpmz8ESEHJec1rInYYrcm52UonPAA1VSp9GxLm+PPnGe4r2jDcpmB/B05n3jOP
	 5fPdMrjvK79cBzz32e5bpAL7kY7i2us1Gacv/fjXEJGq0vBy1qMW81D+J1FCGpL3Rb
	 ie6NzD7S1qrosPxgv7ZfBGPIBwZkPOdHn+WqqUHyK2bcBdsGVVimLvIXpv5Ce4NliF
	 Eyyfl4ToDQQ1Q==
Message-ID: <182b6946-11a9-46e8-b123-aab473ad5898@kernel.org>
Date: Fri, 13 Oct 2023 13:54:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v16 0/8] userspace pm remove id 0 subflow &
 address
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1697175899.git.geliang.tang@suse.com>
 <8b9e4a05-7b65-4b2a-b4d9-3c5b03a894f9@kernel.org>
 <b783f33b-ae88-4509-9b9e-53736fd4dd5a@kernel.org>
 <20231013113006.GA29962@bogon>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <20231013113006.GA29962@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/10/2023 13:30, Geliang Tang wrote:
> On Fri, Oct 13, 2023 at 11:36:36AM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 13/10/2023 10:31, Matthieu Baerts wrote:
>>> Hi Geliang, Paolo,
>>>
>>> On 13/10/2023 07:46, Geliang Tang wrote:
>>>> v16:
>>>>  - address Matt's comments in v15.
>>>
>>> Thank you for the new version! It looks good to me!
>>>
>>> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
>>
>> Mmh, I missed the errors reported by the CI:
>>
>> not ok 112 - mptcp_join: userspace pm add & remove address
>> not ok 113 - mptcp_join: userspace pm create destroy subflow
>> not ok 115 - mptcp_join: userspace pm remove initial subflow
>> not ok 116 - mptcp_join: userspace pm send RM_ADDR for ID 0
>>
>> Do you mind looking at that, please?
> 
> I can't reproduce these errors. All tests passed on my side.
> 
> I run this command on my Thinkpad laptop:
> 
> docker run \
> 	-e INPUT_BUILD_SKIP_PERF=1 \
> 	-e INPUT_BUILD_SKIP_PACKETDRILL=1 \
> 	-v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
> 	auto-debug
> 
> And this is my .virtme-exec-run:
> 
>   run_selftest_one ./mptcp_join.sh -u
> 
> Every tests passed.

Thank you for looking at that!

Maybe try to reproduce the issue in a loop using:

  run_loop run_selftest_one ./mptcp_join.sh -u

> Is there a difference between my test environment and CI?

The public CI is very likely a slower environment that what you have on
your side. To help to simulate such environment, when the tests start
(because not needed before), I usually run 'stress-ng' in parallel:

  nproc=$(nproc); nproc2=$((nproc * 2))
  stress-ng --cpu "${nproc2}" --iomix "${nproc2}" --vm "${nproc2}"
--vm-bytes 1G --timeout 60m

If it is not enough, I also change the priority of the VM:

  sudo renice 20 <pid of qemu>

I hope it will help!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
