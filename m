Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E811F4183
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011273; cv=none; b=PaXsRwgFeKYHiW7l2902GmXbsXvc5u+d8Ra3Dd+aemYmOf94JXlsh76l5WTDikKuR0Dz0/oohXJiUjOQPv+hB+kHuVEitXnkBHIbtygFtKv9vae8WLGjtfefui6rwK+/tQkBRzRNrXiCSUiCSY9poX748wcn4qhL5KJgFhPbj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011273; c=relaxed/simple;
	bh=7qmYRqSb1vj7tTSf90d5jtD82EkdrxlbVuOUrwqA5DY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=roQ9oRAl6Cbve9n4Z9zmwqBwyasrldqi+4u6ZzX5KbWrEOVOsht4MCFPivC7b3ZvSzuaOWl9IQ1cQEgckFPFOtW9+FsRDPPvBYvRxSrQpb6TQWwCiq1Tx0+SZMhSIAj8rsqPH99xU+IVOt58JNPzpNR/A9zyzdXSkX3r+BeDTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umei/5fC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umei/5fC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22983C4CED6;
	Mon,  3 Mar 2025 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011272;
	bh=7qmYRqSb1vj7tTSf90d5jtD82EkdrxlbVuOUrwqA5DY=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=umei/5fCnZ+U/eZEIzvIWc0CKzq4elpf4mKNmbRJ0YyCgdOsFxTJCAFpFEIkoaUUE
	 LcK/iEl59CZAST06NykwstO6vu/4Q3F9LSMrVrOVb9DRRqoZJq9rlc4h+qqdQRS3hh
	 eQVH47tP/8lXi4SNVjZhxU5Oqem9JxFVJpPCLk6mHa7IeUY6AixANg3lDVXMPV2Eut
	 fp/NiQSCQazyGDUeeTGPjI5HIH+gGJZBp4LPdHnePKGa5kVEWmQt/FSgYQSvlxBcJh
	 rR0RcoI35p0W/SdIky+eoVSq9X+9ETHs4xdlhn7nbHRU692Lz3XjX3eoBJS0Jzkqw/
	 8/j1Ats7vchzQ==
Message-ID: <aa9f5476-4885-495a-965b-8e3966b03e4c@kernel.org>
Date: Mon, 3 Mar 2025 15:14:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 00/14] mptcp: pm: code reorganisation
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
 <6dd5447d53d519a848f8b21104d90478802a0372.camel@kernel.org>
 <8e6a57b2-8d45-4c7d-a0d1-ca120eb0114a@kernel.org>
 <d92038d729b02be236e736bc598dc17bd6f71b23.camel@kernel.org>
 <adcbfc72-0eb3-4340-9af5-97e2ffbe12c1@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <adcbfc72-0eb3-4340-9af5-97e2ffbe12c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2025 12:07, Matthieu Baerts wrote:
> On 03/03/2025 11:55, Geliang Tang wrote:
>> On Sat, 2025-03-01 at 12:10 +0100, Matthieu Baerts wrote:

(...)

>>> I think it would be better to apply these patches ASAP, not to block
>>> further developments, or having to rebase this kind of series. WDYT?
>>
>> Patches that move code to another location are not very friendly to
>> backporting, especially large patches like this set, which almost
>> always conflict. When conflicts occur, we need to deal with them
>> manually.
>>
>> All my suggestions are to reduce the workload of manually dealing with
>> conflicts when they occur.
>>
>> If the code is moved in one piece, we can handle it easily. If the
>> function location changes during the code move, we need to move each
>> function one by one, which increases the workload. If the function name
>> changes, we need to compile and verify it at the same time, which
>> further increases the workload. If the code logic also changes, the
>> situation will be worse.
>>
>> It is possible that this patch does not need to be backported, but the
>> subsequent PM code is modified based on the new code location, and the
>> subsequent new features are developed based on it, so there is still a
>> possibility that this patch needs to be backported.
> 
> Thank you for your reply!
> 
> Yes, clearly this series can cause troubles for future fixes in the PM
> manager, but it looks worth it, and the right time to do so with all
> other cleanups.
> 
> Usually, conflicts in smaller chunk are easier to deal with. Now, here
> it is a bit different: big blocks of code are being moved from one side
> to another. The idea is not to backport this series. We might want to do
> that to ease the backport of some fixes, but it feels to me that we
> would either take all patches from this series, or none.
> 
> So far, I think I did the backports of all MPTCP patches having
> conflicts, and my feeling is that the v2 is OK like that. It was good to
> extract all functions renaming in separated patches and only move code
> from one file to another as you suggested after having reviewed the v1.
> This will help for other reviews, but also for the backports, where we
> will clearly understand what has moved where. I don't think we need more.
> 
>> Since all my comments do not involve any code modifications, and the
>> code itself in this set looks good to me, I am also willing to add my
>> reviewed-by tag:
>>
>> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Thank you! I'm then going to apply this series in our tree ASAP.

Now in our tree (feat. for net-next):

New patches for t/upstream:
- caa77b6a80a2: mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
- be18d814ea8b: mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
- c6112330af30: mptcp: pm: remove '_nl' from mptcp_pm_nl_work
- 33602d19dcfd: mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received
- d68e766378ca: mptcp: pm: remove '_nl' from mptcp_pm_nl_subflow_chk_stale()
- 8497c3d80054: mptcp: pm: remove '_nl' from mptcp_pm_nl_is_init_remote_addr
- 6df9239877ee: mptcp: pm: kernel: add '_pm' to mptcp_nl_set_flags
- 901068cd09dc: mptcp: pm: avoid calling PM specific code from core
- dde36f90e966: mptcp: pm: worker: split in-kernel and common tasks
- 309274c12f21: mptcp: pm: export mptcp_remote_address
- 73dff270e144: mptcp: pm: move generic helper at the top
- 6295203b8677: mptcp: pm: move generic PM helpers to pm.c
- 0ac713141723: mptcp: pm: split in-kernel PM specific code
- d96862b4bb41: mptcp: pm: move Netlink PM helpers to pm_netlink.c
- Results: a2a605f37c1b..b084c48057bb (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/f4b35b693104bc77bd7419868548eba9649a4d9a/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

