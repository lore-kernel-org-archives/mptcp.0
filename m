Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15171862A
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695313; cv=none; b=q157dvz742xQwsYNN3pCnQZVfFlXi4XXIc/QmCHA1XVs0/ek3fa1kfKgWvNbbA5H/nmiq5w5OjVWG8hKwtPIGD0cSHh4rBUaj3Z5/4x3wJf5gLqOIexbzKDxc3Tr/Md8OgSRQ+f/zUORfbEu2QBYTNV9JotlymR39SCzK4KlWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695313; c=relaxed/simple;
	bh=nESGS0q4UDszcKb6K6bt9tEDBof/91jPGDrGreh+ae4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfErQSQ2/ATJ53WTZTCuP+CsWAcTVjZ6j8P2nJWtWkAZHoX879hgckDVycsPEzJbMGFWmmFeqrpxoeDTcVtsf2I2FbSA+TuSIAT494FZjLlF0Z5Y3D7O7GETHO0ko/7pfYDqdu6smk/ZStSjamr0ZPxTgPlIsdDvvNBZLfUU66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9OD44o/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9OD44o/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B6C433C7;
	Fri, 23 Feb 2024 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695313;
	bh=nESGS0q4UDszcKb6K6bt9tEDBof/91jPGDrGreh+ae4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E9OD44o/sQygR0T3cEmUTwLGrjn9oGMxX+Y+0+CTBalFrS1A1FbBrAx1brDUxgXrq
	 0tnip52addc8aRc3mvCI3f6Qo0yBvL2a4/zngCJnZuu6FrGPpwpk2E5J8YndFdtU6c
	 2p/M6Ywf1dRojRjL4En051YrYnLYXWshgj5r+L5JTEFVsSEVArV2zkfIKgY8/w9l+4
	 Mp+xCfoWiIyrQVAtKasVguQyFMx8I5nLWpSZVOzLpQ19KjKlUBbUG36jrWaseIxj7D
	 QZ9hVkC7FkNfsKfiMMWduuW+/SFRMddScuebyqnEEYcc6WI4jK7Vq/aqJB89NwVwNq
	 qyxbleL20iFfg==
Message-ID: <56195453-820e-4e97-9ec0-4785768d6f70@kernel.org>
Date: Fri, 23 Feb 2024 14:35:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/6] selftests: mptcp: fix shellcheck warnings
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
 <cc409b04-ccb8-b6d2-8e2e-1791a776af2c@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cc409b04-ccb8-b6d2-8e2e-1791a776af2c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 22/02/2024 9:01 pm, Mat Martineau wrote:
> On Thu, 22 Feb 2024, Matthieu Baerts (NGI0) wrote:
> 
>> shellcheck recently helped to prevent issues. It is then good to fix the
>> other harmless issues in order to spot "real" ones later.
>>
>> Note that 3 scripts were already compliant: mptcp_join.sh, mptcp_lib.sh,
>> and userspace_pm.sh. mptcp_lib.sh was compliant from the beginning.
>>
>> The modifications are minor, mainly because SC2086 has been ignored:
>> Double quote to prevent globbing and word splitting. This is
>> recommended, but the current usage is correct and there is no need to do
>> all these modifications to be compliant with this rule. New files, like
>> mptcp-lib.sh, should not have that rule ideally. Ideally new code other
>> existing files should use double quotes when needed.
>>
>> Once applied, I'm planning to add a check on the CI side to catch new
>> issues, not to have to check that manually and report issues when
>> applying patches, like I had to do a few times very recently.
>>
>> The last patch is not related to shellcheck, but I found this while
>> looking at the scripts: in userspace_pm.sh, we launch 'pm_nl_ctl events'
>> once, then kill it, then relaunch it using the same temp files.
>>
> 
> Regarding your note in patch 6, I don't think it's a big enough issue to
> backport it.

Good, easier not to backport it.

>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Matthieu Baerts (NGI0) (6):
>>      selftests: mptcp: diag: fix shellcheck warnings
>>      selftests: mptcp: connect: fix shellcheck warnings
>>      selftests: mptcp: sockopt: fix shellcheck warnings
>>      selftests: mptcp: pm netlink: fix shellcheck warnings
>>      selftests: mptcp: simult flows: fix shellcheck warnings
>>      selftests: userspace pm: avoid relaunching pm events
>>
>> tools/testing/selftests/net/mptcp/diag.sh          | 14 ++--
>> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 76
>> +++++++++++++---------
>> tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++--
>> tools/testing/selftests/net/mptcp/pm_netlink.sh    | 14 ++--
>> tools/testing/selftests/net/mptcp/simult_flows.sh  | 10 ++-
>> tools/testing/selftests/net/mptcp/userspace_pm.sh  | 29 ++++-----
>> 6 files changed, 98 insertions(+), 59 deletions(-)
>> ---
>> base-commit: 482712b4b5fc44b30dcd54409cbab4ec7e405294
>> change-id: 20240222-selftests-mptcp-shellcheck-80338a0300c5
> 
> Series LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (feat. for next):

New patches for t/upstream:
- 235be4449155: selftests: mptcp: diag: fix shellcheck warnings
- 07f49a9477f8: selftests: mptcp: connect: fix shellcheck warnings
- a20c511f445b: selftests: mptcp: sockopt: fix shellcheck warnings
- e2f73e8be7b1: selftests: mptcp: pm netlink: fix shellcheck warnings
- 581e384d1545: selftests: mptcp: simult flows: fix shellcheck warnings
- 46330f024779: selftests: userspace pm: avoid relaunching pm events
- Results: 80144e8d21c6..7f64b53905ca (export)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
