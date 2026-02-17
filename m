Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5831A548
	for <mptcp@lists.linux.dev>; Tue, 17 Feb 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322079; cv=none; b=gg9gEryBQVtquZ8kgg6ob6nbrD0GRDXXrd8KU1EHSCRu59Pe5ay+gDzYV6NRcozgLOPUQYJs+RtzGnpMJCcTy1/K6jJ5FLtuJ3bN0j2BSP8BPyOtVzCerLku6PKwgy2RzX5iGsmIcxQ7h7mOHKk9lR3BXRm2Vqd/I+4k6ZZvqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322079; c=relaxed/simple;
	bh=9v43X/pQjYqaWShxNO3eKXW+NlNck1VsCJYlQ1IiRlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LIGjbXwH6/MIan2MdIb/VuT1WcTkkdDP+f2lryq1h9DWRbFA6KZFjoRoJnsUiYYbKd59+zgeqeFcEbrxrPW3P7B9BXJUBOBtElZvI+0fzZnUmMuoMsdNtKTN2WWr8uhRdI/XibZY/sAvQZDnRc6GBqQ6ZE29bZJnrLI+xkO6Hss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWMC4meF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWMC4meF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21263C19423;
	Tue, 17 Feb 2026 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771322078;
	bh=9v43X/pQjYqaWShxNO3eKXW+NlNck1VsCJYlQ1IiRlY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IWMC4meFF+qQKTDAadgyBvN7ZHDAStpTSL8IOH+JqGTCEWUHS6rFOJYt33BQdrZfK
	 PhBoF5eBu9ANqGR4fw4EVBInn4fjl4c7ZV8F2NSZQAm7XBu61o37trQbmOUC7uMcSL
	 +a+LsfvcgY5jCbmEOLXQaPnLp6pKC0gS/ZnVBbzfIiMIJUHP2JYAoEv8WQf+I/8G/i
	 v8agGWK2N4WhHsruccyLsAD+ks/Qk8KOY4cqee9GA7d0KaJJS/ABgD2mmuQCuI7TCl
	 5B8bYg6AfF2dGChiLQn6fMmwOsgoOCxYCfZlAam/p5/B2RBWsEAzeRsOq9tAt38+Y0
	 aFRNf2jFV/qDA==
Message-ID: <81fde6e3-83f3-4907-920b-216c9bba1d19@kernel.org>
Date: Tue, 17 Feb 2026 10:54:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: more stable simult_flows
 tests
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
 <604e9832-4fac-b3b2-dfa2-e40e481cf94b@gmail.com>
 <a4f25306-0f9c-4411-aaf3-e2f2d12ca0bc@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a4f25306-0f9c-4411-aaf3-e2f2d12ca0bc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for the patch!

On 17/02/2026 10:45, Paolo Abeni wrote:
> On 2/16/26 11:31 PM, MPTCP CI wrote:
>> Hi Paolo,
>>
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
>> - KVM Validation: normal (only selftest_mptcp_join): Critical: Global Timeout ❌
>> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_dss packetdrill_sockopts 🔴
>> - KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at boot time, rebooted and continued 🔴
>> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
>> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
>> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/22078199700
>>
>> Initiator: Patchew Applier
>> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/92395bd88118
>> Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=1054688
> 
> It looks like the CI exploded above, but it looks like an infra issue.

Yes, indeed...

- For "Notice: Call Traces at boot time, rebooted and continued", it is
not related to MPTCP. I tried to find out the root cause, but I didn't
get it, not get much help:

  https://lore.kernel.org/24ffcb3-09d5-4e48-9070-0b69bc654281@kernel.org

- For "Critical: Global Timeout ❌", I see that there is an issue in the
"expect" code to catch "boot issues" (see above), I will fix that.

- For the "Unstable", yes, it is not the first time, not often, but
clearly not due to your patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

