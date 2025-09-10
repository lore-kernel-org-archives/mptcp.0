Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E52BE7B1
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496488; cv=none; b=JPwGB82EhaI+m7QTQh5HFyFGq+cmCbzLgoo2C3YABSpV6VdEX64Tl6LVmp118ifeyBut/Xz1NDp52mYoshDjqa80rVd2+i/3z6tjIoTfGAGLJbLQFidJr/GDNFijaomGxjuzgtu+bdwsyJcCwetVIIRvdLVahpKDeIOtjMDwxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496488; c=relaxed/simple;
	bh=7CkgEiw0K678fWTiQ6y5Sgix7Dcoo/SvgtsddqFBbcA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pt1/t513+CHZyVhlpJFQf/XQ/rJWgkDiZzXUrNX6tJzkp/7hOJ68Ln49xpWbRXnJ188KL4WkMzdp7J9qL3ghTXVlPCa+r6HjBfZ9ZSKUjtZFgCGF+lJQ+4QuNVNThT7PpI4J5MZvO0lhBSc9hvv1idLy3B3+twLogBeB5ggbD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nksn1oCC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nksn1oCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4FC4CEF0;
	Wed, 10 Sep 2025 09:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757496487;
	bh=7CkgEiw0K678fWTiQ6y5Sgix7Dcoo/SvgtsddqFBbcA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=nksn1oCCZj7H7SKj7H1FsSp2v7Mr0eRGo0WqsnydyecVQ2U2DF0aIpbk0F9EAvPLP
	 xjJOVOZ58vPhvva1805YLU8+dnA6x4ew97So0bsFP4TtmIogGtNAkrGG5h2lShyk7E
	 9AvndznZP0lwk2okGMK4WxMHUds13kudJ/JQT7COY8TLE4ZsT0AnQHbTIUEtvFqSkI
	 z92pSuPPG75cXMUeLK1l1XyUZ4xq6qYcaPWNm9edh0ZcNM5y0CVSoT0D/kok0fbB3c
	 sRV3KtLxoON07BhNB7vIzJdDKG19gFs3uYOSkKqKamZ8w688hjXvBJOFomcDlS/ULS
	 byjx54LJcxSMg==
Message-ID: <9cc59995bb51221b0ae1ce9d2c1f42ffa5fb5122.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/5] selftests: mptcp: avoid spurious
 errors on TCP disconnect
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Wed, 10 Sep 2025 17:28:04 +0800
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this v3.

On Wed, 2025-09-10 at 10:55 +0200, Matthieu Baerts (NGI0) wrote:
> This should fix the recent instabilities seen by MPTCP and NIPA CIs
> where the 'mptcp_connect.sh' tests fail regularly when running the
> 'disconnect' subtests with "plain" TCP sockets, e.g.
> 
>   # INFO: disconnect
>   # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration  
> 996ms) [ OK ]
>   # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration  
> 851ms) [ OK ]
>   # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected
> revents: POLLERR/POLLNVAL(19)
>   # (duration   896ms) [FAIL] file received by server does not match
> (in, out):
>   # -rw-r--r-- 1 root root 11112852 Aug 19 09:16
> /tmp/tmp.hlJe5DoMoq.disconnect
>   # Trailing bytes are:
>   # /{ga 6@=#.8:-rw------- 1 root root 10085368 Aug 19 09:16
> /tmp/tmp.blClunilxx
>   # Trailing bytes are:
>   # /{ga 6@=#.8:66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP    
> (duration   987ms) [ OK ]
>   # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  
> 911ms) [ OK ]
>   # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration  
> 980ms) [ OK ]
>   # [FAIL] Tests of the full disconnection have failed
> 
> Patch 3 fixes this issue, but a fix in MPTCP in patch 1 is also
> needed
> to fix MPTCP behaviour, and simplify patch 3. Patches 2 and 4 improve
> some errors reported by the selftests, and patch 5 helps with the
> debugging. I guess all these patches can be sent to 'net'
> 
> Note: Patch 1 will cause errors in Packetdrill, that's normal, see
> [1].
> 
> Link: https://github.com/multipath-tcp/packetdrill/pull/171 [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
> Changes in v3:
> - Patch 2: close some FDs in case of errors (Geliang)
> - Patch 4: mention there are now more bytes (Geliang)
> - Link to v2:
> https://lore.kernel.org/r/20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org
> 
> Changes in v2:
> - Patch 1: new
> - Patch 3: no more state filtering needed thanks to patch 1
> - Patch 4: switch from hexdump to od (Mat)
> - Patch 5: new
> - Link to v1:
> https://lore.kernel.org/r/20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (5):
>       mptcp: propagate shutdown to subflows when possible
>       selftests: mptcp: connect: catch IO errors on listen side
>       selftests: mptcp: avoid spurious errors on TCP disconnect
>       selftests: mptcp: print trailing bytes with od
>       selftests: mptcp: connect: print pcap suffix
> 
>  net/mptcp/protocol.c                               | 16
> ++++++++++++++++
>  tools/testing/selftests/net/mptcp/mptcp_connect.c  | 11 ++++++-----
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +++++-
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
>  4 files changed, 28 insertions(+), 7 deletions(-)
> ---
> base-commit: 1e51af26b216c689f6d75872290bb0de1eeaae34
> change-id: 20250806-sft-mptcp-disc-err-3357b769bcdb
> 
> Best regards,
