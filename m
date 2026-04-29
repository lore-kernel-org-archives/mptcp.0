Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7133DEDD
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448349; cv=none; b=Gp+5OPLYOxnE+sWJEYzQ8RSz1EWd8R9d/Uw/n3RSfaWRM6DWdm0o9LNW3wxD0rPypRlZBHzjjfUzaE+rMlv0NYxsNier7GCsnahwVD0kA2ngiQPNxzuAVk8Uqdhvwt6XQrR1O3GSJXUb1Xg1qnldN+LTFVucrpdh1kwNlglcaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448349; c=relaxed/simple;
	bh=tTLfUZyR2ki1fDl9OuX1qdqrYBetNtKKcj/GFZ08q6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgCJVt5rJzzhPFAsESEnCcQVSILXIaa6vKnIkf+UJE6TQai4FPTUNPtTTDp0agK0OyLIAKBZ6S3m1zUuABWpzzeGLjrA4etElqKM9yGDzyz924x2aFh/BpZNL8vd7Id6BFAsiNzzgwaxn4IssPlry+99Y50WLTgFvQsnht1oa7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYITXZZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYITXZZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59957C19425;
	Wed, 29 Apr 2026 07:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777448349;
	bh=tTLfUZyR2ki1fDl9OuX1qdqrYBetNtKKcj/GFZ08q6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PYITXZZEZJv2di9yexOLix075pgRIXpqcJIga7mDUnFD1iyU7HMCSAecLYkdvDkhm
	 JnDjzol/t8bSX7jqojGSoFdbmgTm2DgDiXSGwM6vGApkcPh3ZIDN9KuYUlIYB71P/T
	 /eIkZTZBggKot9w0ab8XYID7NQwAqQyHwHMbX+vj7JXOfcQGiedNpxuKVtvAszUm2l
	 Q2tIpzvm/oxODenC6JeEHq0rp14E9OR6oTXNyh4P9JqgI6j//VtaHanXWWJ+4RFyan
	 hyTcdul4o+F+d+cF5XPBI1cM0nlj2UTxvdVh20bNC6p2ZOEhcFeYZ/gosyne8ZxD72
	 9v6eDq3Cn5x2g==
Message-ID: <cd32f04b-0ebe-4075-852b-b4ebe083d9c3@kernel.org>
Date: Wed, 29 Apr 2026 09:39:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v6 00/19] mptcp: pm: increase limits, and
 related fixes and cleanup
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
 <8a91a5e4-1fa2-6c06-8cc4-89a4f3d87d36@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8a91a5e4-1fa2-6c06-8cc4-89a4f3d87d36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 29/04/2026 02:09, Mat Martineau wrote:
> On Wed, 22 Apr 2026, Matthieu Baerts (NGI0) wrote:
> 
>> The initial intension was to increase the limits, but some fixes were
>> needed, then when looking at the code around, other fixes had to be
>> added too. So now I ended up with multiple fixes (including one early
>> exit while at it), followed by patches increasing limits with some
>> adaptations required before, some to validate the modifications, and one
>> small improvement in the selftests.
>>
>> The patches with a Fixes tag are for -net, the rest for net-next.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v6:
>> - patch 4: fix label name in commit message + mention next patch.
>> - patch 7: use min() to improve clarity (Mat)
>> - patch 15: fix typo.
>> - patch 20: removed: will be sent in another series after that one.
>> - Link to v5: https://patch.msgid.link/20260415-mptcp-inc-limits-v5-0-
>> e54c3bf80e4e@kernel.org
> 
> Hi Matthieu -
> 
> v6 LGTM, thanks for the updates.
Thank you for the review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 4cd1d0bb0a77: mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
- 24d6e9230abb: mptcp: pm: ADD_ADDR rtx: fix potential data-race
- 1d62197aebe7: mptcp: pm: ADD_ADDR rtx: allow ID 0
- 3e8311058b8a: mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
- c7492016b448: mptcp: pm: ADD_ADDR rtx: free sk if last
- 999a20ff8f59: mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
- 20269ec49bd8: mptcp: pm: ADD_ADDR rtx: skip inactive subflows
- a91b0640998b: mptcp: pm: ADD_ADDR rtx: return early if no retrans
- 09b51d25b19b: mptcp: pm: prio: skip closed subflows
- 53421f820dd0: selftests: mptcp: check output: catch cmd errors
- f1dcf11f1a08: selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
- Results: 90cb02b20cf2..2a1f2d9ea26c (export-net)
- Results: f68dc562c883..eff6f637e315 (export)

New patches for t/upstream:
- 43bbf39ee203: mptcp: pm: in-kernel: explicitly limit batches to array size
- aec0321c2d29: mptcp: pm: in-kernel: increase all limits to 64
- a6d8f6739145: mptcp: pm: kernel: allow flushing more than 8 endpoints
- db7b26d14b03: mptcp: pm: in-kernel: increase endpoints limit
- 4097388c8d85: selftests: mptcp: join: allow changing ifaces nr per test
- b72b1d12a597: selftests: mptcp: join: validate 8x8 subflows
- 67c280697ab2: selftests: mptcp: pm: validate new limits
- dade65b5a91d: selftests: mptcp: pm: use simpler send/recv forms
- Results: eff6f637e315..d56fb1eba9f2 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/6f73a831d415e285b7e49565b9079495b7274a89/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ea2792a55b2660faf08c4a65ad46d7b87adf6f1c/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

