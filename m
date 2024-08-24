Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA0757F3
	for <mptcp@lists.linux.dev>; Sat, 24 Aug 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501854; cv=none; b=IaZGRwyPMOCBf9lr5uj6OFCFZnPeAu8cykubS4ngXnF5/JuY4+geMUdsXKN6+7jvq2Uq8IZr00Jy//MJK5ijbi6h/Iz/H0yCEWDOWFSg/h9a90gfTzdcS4VstjEf88Ua6BwWH3f57Gtt9Mvcx1ZIcEQkGHuCSyZcrnBp8taTa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501854; c=relaxed/simple;
	bh=Y/kTiH1Y2k8Wsb3p1uBwifDugNI60yZLx+TV41GH17k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+1uOFW+rbrpVPQFOfAqKp35yleH6iNCk76FdM4qEfG2g7vKn98ohHoKwgqF8hDXcXnJIA0zvnUX6CD7hB+hNrzLyohTSRPFUrzfJH+t632rSkMd8PxcjNQnvfJpmZKvqE62TO0Giu2zM0q8BBlcTgudjhUib0/vbSLbV/xzZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjJ5azln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjJ5azln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6451C32781;
	Sat, 24 Aug 2024 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724501854;
	bh=Y/kTiH1Y2k8Wsb3p1uBwifDugNI60yZLx+TV41GH17k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EjJ5azlngVAjFOTYhE78xJOf7XxyusPDXPqi5vBHiyd9QVI89MsqxaPw/QRa4ufVB
	 Jj5MTw8/g12iJMXooHhp8WQ5SKJXQr0BrgewB5bRNA4lM+yXCjcEJhwIU6FRIOab++
	 Z8dJ3W1Qw1yHbqAUEJtPXGdSeNtmqa2DNUAfDuneLNi0ttX45JqU9yiYk1VDDgVgEI
	 KfbVFEd9jteo9a6QjIoXulaujViBO19/w5aqnZfaRsiiPn59ITM7NF9Rf2POudJeKa
	 TIxFndi6o3NXpbtS3hTp3Kjrnl7SRK/CLff+ao33O1ehAMLy6mmeR9NcR1hE3xkk/o
	 tB7HaWt1eh0eg==
Message-ID: <ad3aa21a-5634-4bfd-8be1-3207baa6639a@kernel.org>
Date: Sat, 24 Aug 2024 14:17:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 00/12] mptcp: pm: fix re-re-create the ID 0
 endpoint
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
 <9382cd97-6674-d748-5559-d52f33b922fb@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9382cd97-6674-d748-5559-d52f33b922fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 24/08/2024 02:42, Mat Martineau wrote:
> On Fri, 16 Aug 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Even more fixes for the in-kernel PM :)
>>
>> There are a few Squash-to patches fist:
>>
>> - a partial revert for a previous Squash-to patch: probably fine not to
>>  block the send of the original patch then.
>>
>> - improve code coverage
>>
>> - use the right ID with __mark_subflow_endp_available()
>>
>> - small fix for the fullmesh case when re-adding the ID 0 endpoint
>>
>> - set the ID for __mark_subflow_endp_available()
>>
>> Then a few more fixes:
>>
>> - avoid the RM_SUBFLOW MIB counter to be incremented twice
>>
>> - fix re-re-creation of the ID 0 endpoint
>>
>> - validate that in the selftests
>>
>> - avoid duplicated SUB_CLOSED events
>>
>> - validate that in the selftests
>>
>> - ADD_ADDR 0 is not taking into account by the 'add_addr_accepted'
>>  counter, then it should bypass 'accept_addr' & make sure ADD_ADDR 0 is
>>  not sent with a new address
>>
>> - validate that in the selftests
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v2:
>> - New squash-to patches after new issue reported by Arınç: patch 3,5/12.
>> - Patch 8/12 is re-creating the ID 0 endpoint 3 times.
>> - Link to v1: https://lore.kernel.org/r/20240815-mptcp-dup-close-evt-
>> v1-0-5a551d3a66cc@kernel.org
>>
> 
> Hi Matthieu -
> 
> I have one comment for patch 9 that you can add while applying.

Thank you for the review!

> A more general question for self tests, is there documentation around
> for our reverse-compatibility goals for the self tests?

Not really. I mean, the KSelftests doc mentions [1] that "Kselftest from
mainline can be run on older stable kernels", but that's it.

For who this doc would be? Would it be specific to MPTCP?

(I still need to look at having a CI job regularly validating the stable
kernels with the selftests from our export branch)

[1] https://docs.kernel.org/dev-tools/kselftest.html

> Reviewed-by: Mat Martineau <martineau@kernel.org>

New patches for t/upstream-net and t/upstream:
- 62ea9befdf81: "squashed" patch 2/12 (with conflicts) in "selftests:
mptcp: join: check removing ID 0 endpoint"
- 166b2e2e7e55: "squashed" patch 4/12 in "mptcp: pm: reuse ID 0 after
delete and re-add"
- 3760c0b70fd2: conflict in
t/selftests-mptcp-join-validate-MPJ-SYN-TX-MIB-counters
- Results: 410328b9177d..48372820bae1 (export-net)
- Results: 578465d5bbbe..8a29143c4af9 (export)

- 9a20909645a3: mptcp: pm: do not remove already closed subflows
- dfe065fa0ed1: mptcp: pm: fix ID 0 endp usage after multiple re-creations
- e4aed237e502: selftests: mptcp: join: check re-re-adding ID 0 endp
- 67e2bf3f6157: mptcp: avoid duplicated SUB_CLOSED events
- 240550f9423b: selftests: mptcp: join: validate event numbers
- cac1db6d0b63: mptcp: pm: ADD_ADDR 0 is not a new address
- 9ee8e1ef984d: selftests: mptcp: join: check re-re-adding ID 0 signal
- 77eef1cce636: conflict in
t/selftests-mptcp-join-validate-MPJ-SYN-TX-MIB-counters
- Results: 48372820bae1..bbc47d79e5c3 (export-net)
- Results: 8a29143c4af9..c94cd4e2e8ed (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/3e189f6578aa29cfda6c0305cc2e0ba9890440b7/checks
- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/455555bfbecd70ae0502fb68139e3f4f65e91657/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/4964e83f255e59f55e09d09a0447e49dcc77d7a3/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

