Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB619DF62
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089207; cv=none; b=lEw4Cq2wwJsxSqFLV4u6LNjFRHoTpNkiThk9S1A2pX67h70ZZG7BmBCtMWmR23Afgrx3ahvkilkydFbocgHFS5PXQbC5NsrKLoALjdjdjVYbhO+wUOorRRV3e9nlXN/GHmWX/1/M4HpSYhcxFFz020nkj34EHuarlkcMmDdE6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089207; c=relaxed/simple;
	bh=1DX7BfcMGfTTwyYdnBYmBP2YR3p/FBL6J1Gyd/1bZMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Bj5TDLVDALkQv8Ko8zMmIJQJWg+lA+2N8/fV/JtB82y5nhTIrZUJcZmTGeTdkj4pCoNd4Y4f8P9JAg0KE31WPo4OWwzGNpY2h5kYQvbHeKOHfFwLwbYNe1Ma8h/wNAMKObXMDy8+sEtROQvdY9IkFBKQs7JOfUVimHRz+iRO5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnqe1W/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnqe1W/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D6FC4CEED;
	Mon, 21 Jul 2025 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753089206;
	bh=1DX7BfcMGfTTwyYdnBYmBP2YR3p/FBL6J1Gyd/1bZMU=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=Hnqe1W/2OkwZhFKKGlrOJlWbR1U50EhLqHpqTLR516De/eM2vEL6aHDOPwCSX5+Zc
	 25kuTScc7NQPh4e3kfNvDXCVwNc0feZ7c4Fn8PcsqK3TB0JIaMs2mT7MJetBiK+2Xz
	 rCO1d2v+DomiyXUFq/rF60SRFHDD4ABoNDU29/ZHZhF8u0DsoHnT+iBYp3TTwZsfbp
	 ZO0iFQFUKcnw6TaVtzbJu4ZQr7RBknJ80Y9R0c1KQ3H6A+2oEkawwhGAIR2Rbi7Mv4
	 3ERk7hzcEJ9YVxqbmze+6OU/UJFjitlxN+zEXk+86y6EQSX1NIzceTwD8ZvRrUupz+
	 ZC1JUd+JeaaBw==
Message-ID: <d11affe4-30d6-4d08-8c56-8ac611e9d74b@kernel.org>
Date: Mon, 21 Jul 2025 11:13:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 0/2] tcp: a couple of fixes
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1752859383.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1752859383.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

CC: -netdev, +mptcp

On 18/07/2025 19:25, Paolo Abeni wrote:
> This series includes a couple of follow-up for the recent tcp receiver
> changes, addressing issues outlined by the nipa CI and the mptcp
> self-tests.
> 
> Note that despite the affected self-tests where MPTCP ones, the issues
> are really in the TCP code, see patch 1 for the details.
FYI, the two patches have been applied in the MPTCP tree on Friday. (see
below).

Today, the CI complained about issues with mptcp_connect.sh, with the
"disconnect" tests:

- export:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/16409726187

> # INFO: disconnect
> # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration  4052ms) [ OK ]
> # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   963ms) [ OK ]
> # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
> # (duration  1002ms) [FAIL] file received by server does not match (in, out):
> # -rw-r--r-- 1 root root 14170836 Jul 21 06:12 /tmp/tmp.RA63zyhMfZ.disconnect
> # Trailing bytes are: 
> # �[�����05}�����Oka�<���aH�1-rw------- 1 root root 14029930 Jul 21  2025 /tmp/tmp.BIcGXjzpdJ
> # Trailing bytes are: 
> # �[�����05}�����Oka�<���aH�166 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration  1062ms) [ OK ]
> # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  1062ms) [ OK ]
> # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   998ms) [ OK ]
> # [FAIL] Tests of the full disconnection have failed

Do you think this could be related?


- export-net:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/16409727049

> # INFO: disconnect
> # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration  3797ms) [ OK ]
> # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration  1259ms) [ OK ]
> # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     read: Connection reset by peer
> # (duration  1317ms) [FAIL] file received by server does not match (in, out):
> # -rw-r--r-- 1 root root 19806768 Jul 21 06:13 /tmp/tmp.bjbDDrTOHl.disconnect
> # Trailing bytes are: 
> # �Z�V;*�49�������#1�0��>3�;-rw------- 1 root root 19591200 Jul 21  2025 /tmp/tmp.lJwoEj0wut
> # Trailing bytes are: 
> # �Z�V;*�49�������#1�0��>3�;66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration  1420ms) [ OK ]
> # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  1440ms) [ OK ]
> # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration  1370ms) [ OK ]
> # [FAIL] Tests of the full disconnection have failed

This one is probably unrelated.

---------------------------

New patches for t/upstream:
- ebfd9a78da4b: tcp: do not set a zero size receive buffer
- 038166f66b80: tcp: do not increment BeyondWindow MIB for old seq
- Results: de29714b04e4..132bb933cdf0 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d32ad82dc6d5b162c86b738279bd72f10a943e8e/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

