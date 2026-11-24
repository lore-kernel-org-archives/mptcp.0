Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563046;
	b=DHHqpXQDABjcad8PRDtyH98D1K9HGqKoS0HkXqAqfQe8Fz12Nc+3TnZm5YzlDp1EHGgh
	 S9PPNd5Rlj8RSsq2gYs0WjywQ7Qw9PeVveXF+7LYkLI9gYFICRDDriH3uChTsCT1rMojx
	 IS8vj8aVXjm34ZjlPIu9lCVEv942Pyuojsp3xYWg+piuuX3hWmY5+SIOL5lTFZbgCa9Tb
	 zm2e3YQb0bq84d7yrzyR2GcT7jJoky/lqHgqBMrTzvWuTfAr4OuaG82/UuCRv9+ER+iwx
	 bE/y14lbYnoHfvdTvgycb8luo6BcWdALZUnYZayBjMJhTRa9GUswoGQwPur8M2E6zYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563046;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lRAlquOZIDf4NvGpi3ysBHcQ5nuCwj6Jp1Q9nPygGNA=;
	b=r/biFebrBjywsFhhhVXvJaxtyHp4Je47+CjRDTwzX2NDI/BxrPDXg0TEeo54aVPfjcv4
	 ahUMdPAkU3+sssMDwyneZ9mF5YuPslG9lXdQTo60mI+qV7gU1nEyWntkjttGsN4l78bYZ
	 iaI/2RL5OKR7PQTijuz2aVAHV7PakFw4cLT/uuvW/f4n2NgUVybazOpPVxEOwLuG7HupB
	 9A9i+7BB7CJmMSUV+uXCp33dg5G+bIHshfqiJpybNUnzp5tQM/95C1ZiUE4wzXg2F/YpY
	 MgBS1gkE6zDsEmZ9RkgSB9g3Wvf47OWOJLxNcHSUdDNCzFL3Wjt6aOc/Es/Gg0KQhdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKQUpztm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932D606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKQUpztm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94AC1F000F0;
	Tue, 24 Nov 2026 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563046;
	bh=lRAlquOZIDf4NvGpi3ysBHcQ5nuCwj6Jp1Q9nPygGNA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IKQUpztmSIK87Of2LCJaP8Rqc9uJNjujaVHsNZY3j5SHetIQr8RrOfL26QNA6O/9N
	 RwCWjn7gByQhIjP3c9jOiN+lSIDKtkwrrSNcTouDqkyrPeYI+VcOXgKf5vsmqZeevy
	 cFvIGkGLRaSb+Ukb0NC0GkmXJi1l1eBuUa6mt5PuEufunHzq8sY55DGysRBHINZ7ti
	 aJ41grCC9BZng+zmy1giTMekZB++k74ib00TIWUQBdsOBFYfe3TyXVtG8LUQuybzJY
	 AP1oQNnSmVBaZL3fxXea7BpvbOfgdpeTQvrR8FRVlX0gVPkj15ycFV+1pHkTHdlmRV
	 1+v2aGC2xTnng==
Subject:
 Re: [PATCH mptcp-next v8 7/7] selftests: mptcp: connect: cover zerocopy mode
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 23:30:45 +0000
Message-ID: <179556304544.3133.4992026873532064641@kernel.org>
In-Reply-To: <0f5e8a01d62f02de8f2b7af3bd49c9e70b960c58.1795421388.git.tanggeliang@kylinos.cn>
References: <0f5e8a01d62f02de8f2b7af3bd49c9e70b960c58.1795421388.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new wrapper mptcp_connect_zerocopy.sh is added to
  TEST_PROGS in tools/testing/selftests/net/mptcp/Makefile.
- [Low] The commit author is 'Geliang Tang <geliang@kernel.org>', but the
  only Signed-off-by line is 'Geliang Tang <tanggeliang@kylinos.cn>'.

--

selftests: mptcp: connect: cover zerocopy mode

This commit adds a wrapper script, mptcp_connect_zerocopy.sh, which runs
mptcp_connect.sh with -m zerocopy. It also adds the script to TEST_PROGS
so that the MSG_ZEROCOPY mode runs as part of the regular mptcp
selftests.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]

This isn't a bug, but the author is Geliang Tang <geliang@kernel.org>,
while the only Signed-off-by line is for tanggeliang@kylinos.cn.
checkpatch reports this as FROM_SIGN_OFF_MISMATCH.

The other patches in the series have the same mismatch. When the series
is resent, could a Signed-off-by be added for the author address, or the
author be changed to match the sign-off?

[ ... ]

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh
> new file mode 100755
> index 0000000000000..0220d29ad68ee
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh
> @@ -0,0 +1,5 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
> +	"$(dirname "${0}")/mptcp_connect.sh" -m zerocopy "${@}"

[Severity: Medium]

The commit message says this "ensures the MSG_ZEROCOPY path is exercised
in the regular test suite". Can this wrapper fail if the zerocopy send
path regresses?

The zerocopy mode was added to mptcp_connect.c earlier in this series.
In that mode, the only zerocopy-specific checks that can fail seem to be
the setsockopt() and getsockopt() calls for SO_ZEROCOPY. Otherwise the
result only depends on the data arriving intact.

wait_for_completions_zc() returns void and leaves its poll loop on
timeout:

tools/testing/selftests/net/mptcp/mptcp_connect.c:wait_for_completions_zc() {
    ...
		if (elapsed_ms >= timeout_ms)
			break;
    ...
}

So if no SO_EE_ORIGIN_ZEROCOPY completion arrives, neither
do_sendmsg_zc() nor its caller is told.

process_cmsg_zc() returns true on the first zerocopy notification:

tools/testing/selftests/net/mptcp/mptcp_connect.c:process_cmsg_zc() {
    ...
		serr = (struct sock_extended_err *)CMSG_DATA(cm);
		if (serr->ee_origin == SO_EE_ORIGIN_ZEROCOPY)
			return true;
    ...
}

It ignores ee_code, so SO_EE_CODE_ZEROCOPY_COPIED is accepted. It also
does not check that the ee_info..ee_data range covers every sendmsg()
call made in the while (sent < size) loop.

On the kernel side, mptcp_sendmsg() clears the flag without an error and
uses the normal copy path:

net/mptcp/protocol.c:mptcp_sendmsg() {
    ...
	if (msg->msg_flags & MSG_FASTOPEN || !sock_flag(sk, SOCK_ZEROCOPY))
		msg->msg_flags &= ~MSG_ZEROCOPY;
    ...
}

Several regressions would still give byte-identical output, and every
subtest would pass:

  - MSG_ZEROCOPY is masked off.
  - mptcp_sendmsg_zerocopy_iter() is never reached.
  - Completions are never sent, or are lost for later chunks (for
    example, a ubuf refcount leak).
  - Pages are always copied.

The only visible symptom would be up to 5 seconds of extra run time per
sending side.

Should the zerocopy mode in mptcp_connect.c fail when no completion
arrives before the timeout? Should it also fail when the reported
completion range does not cover all the sendmsg() calls?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795421388.git.tanggeliang%40kylinos.cn
