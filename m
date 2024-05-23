Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211213D2AC
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459038; cv=none; b=K/+UQe15IK2vJQAhiYhAd+n6Vi+cpw4CxfnA9qNwaWGDXjN3erSd9Bn3ZJlB/m7AIubOwRG7b1tVzUvPIla80AqxqA2vsrqNYftWyjOY14th0Q8GE9B/A7Tp8lvb6Hk2Jtoh8x3HEpn9y5N+FEvoJOhZoKEsUYc7krZhSk1M6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459038; c=relaxed/simple;
	bh=r8b9bItFeYGAq4Ce9zzCIjUTJol/Q5lbVQvJ6xKjrtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HH7a9BmFpM9qsJCsv0fosh2lrwG/rXru6eRkgmh+s21qTtVGkwN0SJR9LFnH5JHaRWzlxMtQ51f8hCGlUnrrCrHj8meJujC05Kjg0ZUvq9DfUM/XNxRPBvvMcAo2Ivam/L79bJ+y6cjeohbHPxZtPlyS3CsCZHUY2LJ6dMJBd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST/94iHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST/94iHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4F0C2BD10;
	Thu, 23 May 2024 10:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716459037;
	bh=r8b9bItFeYGAq4Ce9zzCIjUTJol/Q5lbVQvJ6xKjrtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ST/94iHngasBRq8+ZEPoGQqag++gVOAWrIK558Wf/jciT/j9S5QGmfIOFrlK4dJvI
	 OFD8QhwgMp6EjCL1sNwDGz5qnxb2aO+QIVRRCjQJksrCXF0glXh9ZDbJBG81cwS32O
	 uGDgi8FRf9P3htlRwvZSCgjn61BZ+XtXdOXshlSim2DfcYdrst9JUZzMwRkq4U0EeE
	 L3231Edh7FtIWS7VkO1CaWDL/BAnGbxFBJQ2RrejJ5wQ7JW+hAUh0A8GDaI5nYN29f
	 5D/eGh51aaKdC9UNRabBvTovXIxdzTC1vHIl8eBREUVr9ONoOpKGrwZeuWcPTWna+e
	 G6pWQyWViZY0g==
Message-ID: <cac043fe-feb7-4c59-a895-8541f738af1b@kernel.org>
Date: Thu, 23 May 2024 12:10:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 0/4] selftests: mptcp: mark unstable subtests
 as flaky
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
 <be731768-e8ce-2f05-0e49-21909e8cda19@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <be731768-e8ce-2f05-0e49-21909e8cda19@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 22/05/2024 17:38, Mat Martineau wrote:
> On Wed, 22 May 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Some subtests can be unstable, failing once every X runs. Fixing them
>> can take time: there could be an issue in the kernel or in the subtest,
>> and it is then important to do a proper analysis, not to hide real bugs.
>>
>> To avoid creating noises on the different CIs, some subtests have been
>> marked as flaky. As a result, errors with these subtests (if any) are
>> ignored.
>>
>> Note that the MPTCP CI will continue to track these flaky subtests. All
>> these unstable subtests are also tracked by our bug tracker.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v3:
>> - Patch 1/4:
>>  - use SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY env var (Mat)
>>  - clearly indicate 'flaky' in the output / TAP format
>> - Target mptcp-net: these are "fixes" for the selftests. I don't think
>>  we need to add Fixes tag, right?
>> - Link to v2: https://lore.kernel.org/r/20240521-selftests-mptcp-
>> disable-flaky-v2-0-eba143bcbad0@kernel.org
>>
> 
> Thanks for the v3, this version LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the reviews!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 31a8e77f8a8e: selftests: mptcp: lib: support flaky subtests
- 72b77cdcc01a: selftests: mptcp: simult flows: mark 'unbalanced' tests
as flaky
- 15017664727f: selftests: mptcp: join: mark 'fastclose' tests as flaky
- 37d7a595c026: selftests: mptcp: join: mark 'fail' tests as flaky
- Results: c60497ee2fda..dffeea9a0a9a (export-net)
- Results: 1d530a1e5853..40645b1ba57f (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/1dfb0687fdfad507a166c105b9b9963b6055ea37/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/e74ff5f00596022e8aca0d5de76ada6e5aad7066/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

