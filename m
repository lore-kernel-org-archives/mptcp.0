Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A497F8
	for <mptcp@lists.linux.dev>; Sat,  9 Dec 2023 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyiyoxpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20F1C433C8;
	Sat,  9 Dec 2023 01:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702085271;
	bh=PPVkD8wLrixpbH5mBl4EYMw//6Pfox5aU9OROspcBwI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PyiyoxpRbh6+eQeZ65wbq83hKuvXviFbNQ6SINezI1D2pFitb2PnCQKAg3Eu2OgVK
	 8PzSJ4u3w6M/M7/tsU4Cn+KKjhCKTWmBOG8UadmxQsljLulfBVcSyTfL2lsqJS64s0
	 7KzDcva4WIOuUITQtRMueBHM/XtqLSB/Aj1aniIXr4XMprQwpwdHqa9D/owRlt6FNi
	 obCiqextZyR0S9i0y46yjE3jqmu/fHREQaqqhzR39p/ZFOHdj4+lg6++kQiDzPHOyi
	 NbmX0x4ZXOyLjdSv22QusDgdXZOOBZoyhxbfLZWx3+Gxk6MykdOh84ZSsqagnXT3L4
	 exjBQQMqcXhHQ==
Date: Fri, 8 Dec 2023 17:27:51 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/5] add MPTCP_MIB_CURRESTAB
In-Reply-To: <cover.1701256112.git.geliang.tang@suse.com>
Message-ID: <eb5cf3d6-67f8-f6c0-b1fe-c3ff0e6133e4@kernel.org>
References: <cover.1701256112.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Nov 2023, Geliang Tang wrote:

> v3:
> - add mptcp_set_state helper

Hi Geliang -

Could you rebase this so it applies to the current export branch?

Thanks,

Mat


>
> v2:
> - use ftrace_regs_get_argument instead of regs_get_kernel_argument to
>  fix build warnings reported kernel test robot.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
>
> Geliang Tang (5):
>  mptcp: add mib counter dec helper
>  mptcp: add a current established counter
>  mptcp: add mptcp_set_state helper
>  mptcp: use mptcp_set_state
>  selftests: mptcp: join: check CURRESTAB counters
>
> net/mptcp/mib.c                               |  1 +
> net/mptcp/mib.h                               |  8 +++
> net/mptcp/pm_netlink.c                        |  3 +
> net/mptcp/protocol.c                          | 57 ++++++++++++-------
> net/mptcp/protocol.h                          |  1 +
> net/mptcp/subflow.c                           |  2 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++++
> 7 files changed, 86 insertions(+), 20 deletions(-)
>
> -- 
> 2.35.3
>
>
>
