Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC11624C0
	for <mptcp@lists.linux.dev>; Fri, 22 Aug 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824781; cv=none; b=I+SpvQcicOEG7zqX9JmbKsqoHOdm0/wGZmrsTgia6ahqTiyanRwUqQDF8ZICJDvRuKvJCbrwLrm5tmR+iH49sbUtML9EM8Tw9l/by1p/5yaQjdvcLyaC2hqESZB4cbdFs/2rhXK4ouowZB6DlsUDIx7FG8Wrh7XmTct1PG6AeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824781; c=relaxed/simple;
	bh=TCIqPU9IQf/Hdfq3saQQZ5B7sbHKgunQ3x5s8nNAbl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rV0i5BIDFi3298S6Sk5p6QwzyNJ4Zcyv6pe2DSbfF+RecmU3d9F2wrco5LLHIvcSEN5BD+Dr0PoHjVxj6+pFapGwWpnBE2cKUEvam3CbWkSjXvie4ueYo6nL10/OTFIDsc2aRbqoW6UfXe1v0rbSiQoeE1qh2/3ya5NwAu6ANx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVJU/Oo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVJU/Oo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C727BC4CEED;
	Fri, 22 Aug 2025 01:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755824780;
	bh=TCIqPU9IQf/Hdfq3saQQZ5B7sbHKgunQ3x5s8nNAbl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hVJU/Oo4sIwMfcofTbBbrVUmY48NsKYKch3D0HsbSFB1qQsus95/2P74U+GPOcqZd
	 PHOLnONNAmf44aacwHt42LtmWQHGtJ5vJaxNKARvhxQ8NHwon8BY6ZUU+CBj6I8ZiT
	 soq6muJUtcmg0ErjQ65+8xAVqPsSouKkocdMIdCPbauobx+eK1Q14873DDpB14FAE1
	 uDEUf1wlMoZ8C+5sHHWVs927T0hCxaYYg9jCGno4NLVRbOQVGHcWxJjMj/O9GV16yo
	 glR/d+0DLSEhZZIlCDfHtaxZQnTUsisR3B6qtg4qyVcVP+w0HBiTDowfloTW3a0zCp
	 g/XQcKrJhHMIg==
Date: Thu, 21 Aug 2025 18:06:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: avoid spurious errors
 on TCP disconnect
In-Reply-To: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
Message-ID: <c0c50674-4a5e-c2cc-4dfa-2d820a926425@kernel.org>
References: <20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 19 Aug 2025, Matthieu Baerts (NGI0) wrote:

> This should fix the recent instabilities seen by MPTCP and NIPA CIs
> where the 'mptcp_connect.sh' tests fail regularly when running the
> 'disconnect' subtests with "plain" TCP sockets, e.g.
>
>  # INFO: disconnect
>  # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration   996ms) [ OK ]
>  # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   851ms) [ OK ]
>  # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
>  # (duration   896ms) [FAIL] file received by server does not match (in, out):
>  # -rw-r--r-- 1 root root 11112852 Aug 19 09:16 /tmp/tmp.hlJe5DoMoq.disconnect
>  # Trailing bytes are:
>  # /{ga 6@=#.8:-rw------- 1 root root 10085368 Aug 19 09:16 /tmp/tmp.blClunilxx
>  # Trailing bytes are:
>  # /{ga 6@=#.8:66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration   987ms) [ OK ]
>  # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration   911ms) [ OK ]
>  # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   980ms) [ OK ]
>  # [FAIL] Tests of the full disconnection have failed
>
> Patch 2 fixes this issue, while Patch 1 and 3 improves the errors
> reported by the selftest.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

With Paolo's suggestion for patch 2 (include close-wait state) and mine 
for patch 3 ('od') included, this LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> Matthieu Baerts (NGI0) (3):
>      selftests: mptcp: connect: catch IO errors on listen side
>      selftests: mptcp: avoid spurious errors on TCP disconnect
>      selftests: mptcp: print trailing bytes with hexdump
>
> tools/testing/selftests/net/mptcp/mptcp_connect.c | 10 +++++++---
> tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 12 +++++++++++-
> 2 files changed, 18 insertions(+), 4 deletions(-)
> ---
> base-commit: 27427f653031e9aca497b147b2d8eb86bf12fb9e
> change-id: 20250806-sft-mptcp-disc-err-3357b769bcdb
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
