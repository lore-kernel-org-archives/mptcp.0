Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3D18C335
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430821; cv=none; b=tWIqBLRqT6Ng3GoeVQjKyunbAwHmR060g14efZTLW0UMa3UNUH6C3fVdzTl49dpWvawEunIeR0GZiNS6fEnvKxWXqyQCCQuNvsyHJKCEHk+FeBFU+H8yOhMwLEFyr4Vj4TB2Zl37Npli/wx0YyeKnL8dG14ofqvl2dbPvfh6hLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430821; c=relaxed/simple;
	bh=CYFo/NMmSqADyB2fs6SLmMfUbE1VtRgfnzxoE/YGMkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KEAJZ6IkyS+RGOvo2yrBpHsVq/rMI9SPcFhKvbZBe68Se7fAdUiQNGlNjHteRrOBWkjSKXJEbF6weToABg6Wbpg0cXN6Yn/jZSNNA9mgzb0xTIRzMkf2yThUa3YMIXV1Rx66WAL3qLoIYimcuPgxSwkwqlHONSpIBzSgtmCW9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvFH267w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvFH267w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA24C4CEC7;
	Tue,  8 Oct 2024 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728430819;
	bh=CYFo/NMmSqADyB2fs6SLmMfUbE1VtRgfnzxoE/YGMkw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hvFH267w8248g2ZRtjdBXZOz0JieazRdA/0/rWXjHTuAd6CfoE/dLspD0B9dsPsAF
	 2yjSgpSnYrYS8n3/mp6sXPwcAut9gXUmqWFQ1mWsV5rNFZIh3Lu4drqz2RID6MnG+g
	 Sa9pfgl3SWcTM11uPgjO+ksmfkIw6iU6lmfzR4dSBh7iw7CYnsUfwmSt4fBX3r2wRv
	 0IlVvNws1Ksbp+P0UgNrURhe95IQKha0Cbo5aWQW74ZUqx3hdXlEc5/kJz2o/mC05w
	 7AHYJPH0vGM/G4qaIY/jwdhb0f2QU+EygHhv5XxqembKR2phqmG2xRVaP7XLtdLhb8
	 VLmh1XlTMEdew==
Date: Tue, 8 Oct 2024 16:40:18 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
    Cong Wang <cong.wang@bytedance.com>, 
    syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: prevent MPC handshake on port-based
 signal endpoints
In-Reply-To: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
Message-ID: <538e38b3-e485-5b0f-0ae2-93fb1d9c0ee9@kernel.org>
References: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 8 Oct 2024, Matthieu Baerts (NGI0) wrote:

> This is a new version for the series sent by Paolo, related to the
> lockdep splat Syzbot reported a few weeks ago, and for which Cong Wang
> sent a different attempt (Thanks both!).
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v3:
> - patch 1: reduce comments to fit under 80 chars
> - patch 2:
>  - Add Fixes tag + comment about it
>  - Add my Co-dev tag instead of RvB
>  - Add a note about the new helpers in the commit message
>  - move cappid declaration under capout
>  - move 'cat $capout' to cond_stop_capture
>  - move 'local port' declaration above to keep the reversed Xmas tree
>  - use 'retl' var instead of 'ret' to avoid a clash with the one used
>    in fail_test(), which would not have marked the whole selftest as
>    failed in case of problem only with this test.
> - Link to v2: https://lore.kernel.org/r/20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org

Hi Matthieu -

v3 looks good to me, one minor change is to fix the "signl" typo in the 
subject line of patch 2 when applying.

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> Changes in v2:
> - patch 1:
>  - moving and renaming the MIB counters
>  - move comments/functions on one line when possbile
>  - rename subflow_reset_req -> _endp
>  - use MPTCP_RST_EPROHIBIT reason
> - patch 2:
>  - fix shellcheck issues
>  - capture: handle $capout
>  - fix indentation issue
>  - helper for the port
>  - stop the capture after transfer like before
>  - move new test to 'add addr ports' ones
>  - move the validation part to a new helper
>  - add missing 'check' names (subtitles)
>  - skip if no counters
> - Link to v1: https://lore.kernel.org/r/833cae5982ac5d5b3236845c6db4315e634f5705.1727974826.git.pabeni@redhat.com
>
> ---
> Paolo Abeni (2):
>      mptcp: prevent MPC handshake on port-based signal endpoints
>      selftests: mptcp: join: add test-case for MPC attempt towards signl ep
>
> net/mptcp/mib.c                                 |   1 +
> net/mptcp/mib.h                                 |   1 +
> net/mptcp/pm_netlink.c                          |   1 +
> net/mptcp/protocol.h                            |   1 +
> net/mptcp/subflow.c                             |  11 +++
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 117 +++++++++++++++++-------
> 6 files changed, 101 insertions(+), 31 deletions(-)
> ---
> base-commit: 2ce52e0f26d35f97f56615bb7854afa633f5d231
> change-id: 20241007-mpc-hs-port-13a6c6c11b38
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
