Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116522C80
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 23:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9234AC433C8;
	Fri, 14 Jul 2023 23:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689377855;
	bh=AYjXebdtbYc/f7TMOTRcyumZ28Px/DcL88hJMFzIQr4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Nk0qBJr4cEJNc8uJfxecA8G31EmX+7jXOm1dETbvlwig+wvv5tvuOwuba9zoswLzw
	 5WbyJ1J/AKVfmejdopFYstcRm4GEyUuad5v8XMVXk2iMmBVUMKRULtB2fe1X2u5jXZ
	 jxSG7kU1x9ThBG2uIp4FmWkf4C+PqPjjq2jatc2actAVproN7aivH68v8GMXZRQsew
	 zxrbqiumfAZi/5DVSowuf1NS+/09TrDk9FJIwNtpOvs4IhnnxwtSlypYf0OphfHyAa
	 Tl4LXg38V6rv439uuNt4p8M5RKHjpTAINDOmJWqg+KCg72nDxbDmZfZhBEpKbzi74L
	 44U4OX6FsXGMg==
Date: Fri, 14 Jul 2023 16:37:34 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: mptcp: pm_nl_ctl: display
 errors if any
In-Reply-To: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
Message-ID: <05f43fb0-66e2-e737-85c8-96e6aac50091@kernel.org>
References: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 13 Jul 2023, Matthieu Baerts wrote:

> Recently, I wanted to understand why the userspace_pm.sh test was
> failing on some arch according to lkft reports. There was nothing in the
> logs apart from seeing the expected event had been missing. I then
> realised the output of pm_nl_ctl was muted but also this tool was not
> looking if there were errors after having sent some Netlink commands.
>
> I don't think it is a good idea to mute the output and ignore errors,
> especially here in the tests where we do want to validate these Netlink
> commands. So now the tool checks for errors and the output is no longer
> discarded.
>
> Note that I didn't manage to read the error message set by the kernel. I
> think the rtattr pointer in nl_error() is wrong. I think it should get
> info from &err->msg instead of nh. Anyway, here we at least print errno
> and just in case someone wants to have a look, it is easy to test:
>
>  ./pm_nl_ctl ann 1.1.1.1 token 12 id 0
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Changes in v2:
> - Patch 1/2: mute expected errors in selftests
> - Link to v1: https://lore.kernel.org/r/20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net
>

Thanks for the fix, v2 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> Matthieu Baerts (2):
>      selftests: mptcp: pm_nl_ctl: always look for errors
>      selftests: mptcp: userspace_pm: unmute unexpected errors
>
> tools/testing/selftests/net/mptcp/pm_netlink.sh   |   6 +-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  33 ++++---
> tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 +++++++++++-----------
> 3 files changed, 75 insertions(+), 64 deletions(-)
> ---
> base-commit: 3ee02a7d38ae4c5fc98a3f833f2a6f44f4b4b15a
> change-id: 20230705-mptcp-issue-368-pm_nl_ctl_ack-bb1625f5bdda
>
> Best regards,
> -- 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>
>
>
