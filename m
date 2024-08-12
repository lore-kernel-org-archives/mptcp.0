Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE8D272
	for <mptcp@lists.linux.dev>; Mon, 12 Aug 2024 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723427708; cv=none; b=MgfJu8rAS1kmyqcbzX0XLkQwT0T0DHyrXn9WlpbHyfOE/83eASlZ7ZXsGm71/q/hIBfIqwExivxenIVn4icf3ZRIJ8Odi9zPi2Kj5UwJL56ZuOlwisFJW3gHZwglap0YzUVoepr1+TAt3nxzhYuopPd5AQsM01clKvX+3wMSiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723427708; c=relaxed/simple;
	bh=t1JYg1ifDJBw6wX0mOO3T24mmCKYjQdxPWPxJbpixCM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVsvr3X++PldhYcgI/b/upCf0dW36NK+xPOrVJC6uM9rz72wgJLYMVgNrvjEhVoOZfvUpQRxcEAtIXRtQ8JGPd6kVluKdvn2d+k6MnhkGAq4vVfAqGeOelI7SAF0DNcCpZvYQWXsi5QLuJrmuh/BKR3H8MmSp19VY/pMNUgK8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcCQR7Md; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcCQR7Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4AFC32786;
	Mon, 12 Aug 2024 01:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723427707;
	bh=t1JYg1ifDJBw6wX0mOO3T24mmCKYjQdxPWPxJbpixCM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=GcCQR7MdP9VZ6KVj6mAm5G30vZw/Lz33Pgzs4KnoiNvHJoApY0hpbENbmvoeHBQ8g
	 SVLyA7LKniM2nle0QCu1yABD/CwBCd702Z+2JZhomuI4ACTymb87qaDuZmtGtPyRTI
	 dqBkzYSsptr9mi5D/DgnpEEpgKZtO9kQPeYDakN4wbN+t67W3Vtrc1p3ezzksoo6PK
	 rxnIhJFlv00wTZnxE7Hjofpy2P1IELsChOjgOTAkVDSwoR8S4spW7U90rdeNG+eTJO
	 84N9zxneHMElpf/xcn9ThRhi2vPKMVw7NaN7D+GRabvtKCGdGIi8SILZzB5eRFnnuK
	 b0UsayHCyLztw==
Message-ID: <f8fba6021728a27a44da1c2f6a9f06db09b43354.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 0/8] mptcp: MIB counters for sent MP_JOIN
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 12 Aug 2024 09:55:02 +0800
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2024-08-09 at 13:51 +0200, Matthieu Baerts (NGI0) wrote:
> Recently, a few issues have been discovered around the creation of
> additional subflows. Without these counters, it was difficult to
> point
> out the reason why some subflows were not created as expected.
> 
> In patch 2, all error paths from __mptcp_subflow_connect() are
> covered,
> except the one related to the 'fully established mode', because it
> should only happen with the userspace PM, which will propagate the
> error
> in this  case (ENOTCONN).
> 
> These new counters are also verified in the MPTCP Join selftest in
> patch
> 5.
> 
> While at it, a few other patches are improving the MPJoin selftests:
> 
>  - Patch 1: a fix when using an old kernel
>  - Patch 3: reduce the number of positional parameters
>  - Patch 4: only one line for the 'join' checks, instead of 3
>  - Patch 6: more explicit check names, instead of sometimes too
> cryptic
>             ones: rtx, ptx, ftx, ctx, fclzrx, sum
>  - Patch 7: specify client/server instead of 'invert' for some checks
>             not suggesting one direction
>  - Patch 8: mute errors of mptcp_connect when ran in the background
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

v4 looks good to me, except for a nit in patch 1.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Changes in v4:
> - Applied Geliang's comments, see patches 2, 4, 5, 6
> - Link to v3:
> https://lore.kernel.org/r/20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org
> 
> Changes in v3:
> - Patch 2: remove fully estab error
> - Patch 5: force bind error + always validate join tx
> - New patches: 1, 3, 4, 6, 7, 8.
> - Link to v2:
> https://lore.kernel.org/r/20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org
> 
> Changes in v2:
> - Patch 1/2: Add "ERR" suffix in variable names. (Geliang)
> - Link to v1:
> https://lore.kernel.org/r/20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (8):
>       selftests: mptcp: join: no extra msg if no counter
>       mptcp: MIB counters for sent MP_JOIN
>       selftests: mptcp: join: reduce join_nr params
>       selftests: mptcp: join: one line for join check
>       selftests: mptcp: join: validate MPJ SYN TX MIB counters
>       selftests: mptcp: join: more explicit check name
>       selftests: mptcp: join: specify host being checked
>       selftests: mptcp: join: mute errors when ran in the background
> 
>  net/mptcp/mib.c                                 |   4 +
>  net/mptcp/mib.h                                 |   4 +
>  net/mptcp/subflow.c                             |  21 +-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 319
> +++++++++++++++---------
>  4 files changed, 234 insertions(+), 114 deletions(-)
> ---
> base-commit: e4105976662ef3faa6520c2c5da3d40505430761
> change-id: 20240724-mptcp-join-tx-mib-84e21ea4b236
> 
> Best regards,

