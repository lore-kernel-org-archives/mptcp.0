Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A342D2487
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530993; cv=none; b=AO+8ASxeecPDW7l0QCi12NBTkc3ecKZ9mfOq3rMEkuTlW+icCDk2vWjZ1y5VIhRsObzQ+yUFPK33svKoRYjgJOUkOAnW6oCAFnbeCZ8Mr1I7rya9+ouJlE9Mdye52YyDyiw7/Pe2ft9qv23plWJV23XtVQBUnRifjM4/Qjp1ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530993; c=relaxed/simple;
	bh=qAJPfwsCKGLpKF2eE9S2bZkD2pA5FwfnHEEKVifL/RI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nPDy6JQe7vMgZlWWCb1NxnkQJFUuxrggnRgGi2GA/CvD7k/Fi8XsCTrg4NTbEouTjOd2Z6C7VgaNA58Fg63/uOOmA5GX0sD9S4qTLqxtl9JGKEAl4ceboffd2+HQIIv0skfy66PUhtjlonkBVbinsc46dDZ4v2uFUZt1TgU8lns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYxRonJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYxRonJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77EFC4CEEB;
	Wed, 10 Sep 2025 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757530992;
	bh=qAJPfwsCKGLpKF2eE9S2bZkD2pA5FwfnHEEKVifL/RI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qYxRonJr3KOgwDNDfz4XMAOWi9cGrhbcSjBhRJ2p2cCnTYYRCSgBxm4JCFlgemXwF
	 O6JMp+VeVI6Sc1gr/O9mjbq3fM9owHGfGkifAk+yy07lNhgmG5fHg2sMORFbaoOaGe
	 lxHgS2wa40sLaMFwtbuIu06gFxHQ32rvAsZJIhKwA38WSIH7YbOy02Haaa9/6Dt4Rf
	 lxOLtBZDl1R8+GEDYBgUHUZzagoegJTT1cI4qwS8NdJSQK3/s0R3J1FGl1XdptmzrN
	 tBKarzjq/pcRdQUKPVrXWaikMeen0jxxdpVKIrh9c64sFE+CCSUySZpd5xxIzI4lQg
	 vlp3yZSyVK44Q==
Date: Wed, 10 Sep 2025 12:03:12 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v3 0/5] selftests: mptcp: avoid spurious errors
 on TCP disconnect
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
Message-ID: <13b53a08-0be4-fdf7-d8ef-58671c96e964@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Wed, 10 Sep 2025, Matthieu Baerts (NGI0) wrote:

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
> Patch 3 fixes this issue, but a fix in MPTCP in patch 1 is also needed
> to fix MPTCP behaviour, and simplify patch 3. Patches 2 and 4 improve
> some errors reported by the selftests, and patch 5 helps with the
> debugging. I guess all these patches can be sent to 'net'
>
> Note: Patch 1 will cause errors in Packetdrill, that's normal, see [1].
>
> Link: https://github.com/multipath-tcp/packetdrill/pull/171 [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v3:
> - Patch 2: close some FDs in case of errors (Geliang)
> - Patch 4: mention there are now more bytes (Geliang)
> - Link to v2: https://lore.kernel.org/r/20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org

Hi Matthieu -

Patch 5 I acked separately, one minor fix in the commit message but no 
need for v4.

Patches 1-4 LGTM. Even though it's possible (in patch 1) that a shutdown 
may be attempted on a subflow that doesn't need it, tcp_shutdown() has the 
logic to handle that.

Reviewed-by: Mat Martineau <martineau@kernel.org>


>
> Changes in v2:
> - Patch 1: new
> - Patch 3: no more state filtering needed thanks to patch 1
> - Patch 4: switch from hexdump to od (Mat)
> - Patch 5: new
> - Link to v1: https://lore.kernel.org/r/20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (5):
>      mptcp: propagate shutdown to subflows when possible
>      selftests: mptcp: connect: catch IO errors on listen side
>      selftests: mptcp: avoid spurious errors on TCP disconnect
>      selftests: mptcp: print trailing bytes with od
>      selftests: mptcp: connect: print pcap suffix
>
> net/mptcp/protocol.c                               | 16 ++++++++++++++++
> tools/testing/selftests/net/mptcp/mptcp_connect.c  | 11 ++++++-----
> tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +++++-
> tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
> 4 files changed, 28 insertions(+), 7 deletions(-)
> ---
> base-commit: 1e51af26b216c689f6d75872290bb0de1eeaae34
> change-id: 20250806-sft-mptcp-disc-err-3357b769bcdb
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
