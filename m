Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FC171A1
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743386726; cv=none; b=NIH0Dxc/eQuNsv0Y3uYFa/GRWZBj8xV3B4AQUp7QQPhzTUbgO2DOlz/zxwjyLlVddyqamoi41RG6PvG4Z3oKKgh0854XpGuwGaQGkzRkixtDEjJ2YF4Sdth27q4nUANbDCy5ZgGhA3pp4w/YhsUl4QrUrNABu/i4My2UDro9B30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743386726; c=relaxed/simple;
	bh=QkCTxCLW8haSGNooXHiAvPlJR53EDnR9mJ7JvUI2MgA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSRHG2gcNAQdTx5WYkQ9yCp48130B9DTxZ5FmfAFiFlMtZ4ZVtZARM81u8MNpgjrzyvMjhT8eo/maPGhYVE94z+Zkm7kX7DWsnZTkH6D2BOKUr1d8LkClnYf/O9GyqYDy5jLYwWPcx2v9REDZWpeeXhHvH7+ZLi+c3RdEnIkYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX9mqTNg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX9mqTNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3729EC4CEDD;
	Mon, 31 Mar 2025 02:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743386726;
	bh=QkCTxCLW8haSGNooXHiAvPlJR53EDnR9mJ7JvUI2MgA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=PX9mqTNg+bSHN1jutCfU2q7hLnJBDI3Q5FmVpMIsa6arBVRkvHKknlzqWRq7jcIBs
	 c0E1QMIsMj8Ump/xBKxx+hIZQgh0CxGeaDTc0WplJkGmnQ3fjiyqm1OTnNQCXKngTM
	 uEiMwMJI4RLfIs5Ruv0iKBA++VLAC5B4LlD8MNOt3pA53763zhTIjhLaZUbKLaSyMy
	 fFFjysBnz1TVFx6LDddi+GqJa2/lL4kU1NZCsHvXwAOI/I8NTaG9DwvvR6zSLXMqyq
	 V2MQZoWtnzfb1m7BS4dh1Qql5juymhgdtC9BkbBbh4spxyocOfA2ct7mEa8shCdP9a
	 CvplO7pCm241Q==
Message-ID: <7e340c72d4b865a29f794ee9f5e7cab1a7d22df1.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/5] mptcp: fix MPJoinAckHMacFailure, add
 MPJoinRejected
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 31 Mar 2025 10:05:21 +0800
In-Reply-To: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
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

Thanks for this set.

On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
> Recently, during a debugging session using local MPTCP connections, I
> noticed MPJoinAckHMacFailure was strangely not zero on the server
> side.
> 
> The first patch fixes this issue, and the second one validates it.
> These
> two patches can be applied in mptcp-net.
> 
> There is a small refactoring in the 3rd patch.
> 
> Patch 4 adds MPJoinRejected to track when the PM rejects patches, and
> patch 5 validates it.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Except for my two small suggestions in patch 2 and patch 4, the rest of
the code LGTM! No need to send a v2, please update them when merging
this set (if you agree with these two small changes).

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Matthieu Baerts (NGI0) (5):
>       mptcp: only inc MPJoinAckHMacFailure for HMAC failures
>       selftests: mptcp: validate MPJoin HMacFailure counters
>       mptcp: pass right struct to subflow_hmac_valid
>       mptcp: add MPJoinRejected MIB counter
>       selftests: mptcp: validate MPJoinRejected counter
> 
>  net/mptcp/mib.c                                 |  1 +
>  net/mptcp/mib.h                                 |  1 +
>  net/mptcp/protocol.c                            |  4 ++-
>  net/mptcp/subflow.c                             | 18 +++++-----
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 44
> ++++++++++++++++++++++---
>  5 files changed, 54 insertions(+), 14 deletions(-)
> ---
> base-commit: aca18798220853f0d7a8d01c28213e0d3fccfbfc
> change-id: 20250328-mptcp-mpj-reject-addd081553f5
> 
> Best regards,

