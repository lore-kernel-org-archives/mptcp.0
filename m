Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C5333032B
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125398; cv=none; b=UOhASbuw9Jz0ZJ6nh3prFQQlV9FKj+0TZYpfUCJSowxjcPpq5CgmrT5Hd6usX5QfUSxRt7cUiEOOizeTFH9v9N5FtFapjP7ldYrs/kTE3vAmSpfG4AiQfILE64sKY7npit51BnV4zhLGLArNSVCjk9yvBgB9cSraCMhnvPtQxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125398; c=relaxed/simple;
	bh=LZCZcF5DeYb9Gj1d8JP6yUZ+kJSs7b3dTjEsHm+sATI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEblBCKGApLh4iTFbNn363wFQtYRlmHsyBhV+3jCGdfkE3oXFpsnPA1Gc6qhyOBkDsLWnjfK/eKwFUWoUNT8qtflt9fLQjDbJVGiYrqvMfzWay3oMkVCvBRRWJVLO0I4gA7Ls0Wyp2WXWUgeUM/jM36ivMIaCZ6BUeaUK+CJBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBiF7ddr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBiF7ddr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25341F000E9;
	Fri,  7 Aug 2026 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786125395;
	bh=HO1h7t1We3/qdo/4LTBJN3KSgrydGzHKag+HUOBN/bA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MBiF7ddrW2velX3Ap05keCEx1iN6HCNOT5C6wOKGnw8o+iAo1RhroY9MnkULm6sU5
	 DkOxZmceGTpk3PccLhcqcrdeBLoiTWupMe05vkdgcXci1M9fzFRUhkQt86erMsVqkk
	 ndlBWfnc+S6mSSxMq1/iUxcFZLDcEOn1XVcdwde6mj6xmUZMaYJO/XD/YXCcA8Wbu8
	 yxquWRvbEvgJBsW5CSRhEdWRnOhgE/dixD/rZK61V3lhfmwvaNAgiF8/fQ75Np3Bmw
	 dHdaQt0H7VLJYuW14g7HKsF9Oiuz10nyBLXId2AUqc9u33JVaoF1FS/4gjsPNXWPXj
	 QxNLQR2ZKC2gg==
Message-ID: <14204e65-db4b-477d-83b3-9cd79a26bcc7@kernel.org>
Date: Fri, 7 Aug 2026 19:56:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 0/2] mptcp: per-event MIB counters for MPTCP_RST_EMPTCP
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 pabeni@redhat.com, kalpan.jani@mpiricsoftware.com, janak@mpiric.us,
 shardulsb08@gmail.com
References: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260611203219.3448354-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 11/06/2026 22:32, Shardul Bankar wrote:
> MPTCP_RST_EMPTCP (reset reason 1) is currently used as a catch-all for
> several distinct conditions across subflow setup, authentication, and
> data-path validation.  This series adds per-event MIB counters at each
> of those use sites and validates them from mptcp_join.sh.
> 
> Patch 1 adds seven counters (MD5SigReset, MPJoinSynAckNoMPJoin,
> MPJoinAckNoMPJoin, MPJoinAckNoCtx, MPJoinNoIdFound, DssReset,
> MPJoinNotEstablished) and increments them in mib.c/mib.h, subflow.c and
> protocol.c.
> 
> Patch 2 adds named env-var expectations for each counter: the
> JOIN-related ones in chk_join_nr() and the two reset ones in
> chk_rst_nr(), both on fixed namespaces.  It also adds one test inside
> signal_address_tests that triggers MPJoinSynAckNoMPJoin from the
> existing ns1/ns2 setup.
> 
> v4 (this version):
>   patch 1: add MPJoinNoIdFound for an MP_JOIN that carries a valid token
>            but for which the path manager returns no local id; it
>            reaches the same MPTCP_RST_EMPTCP that MPJoinNoTokenFound
>            only counts the no-token half of (Matt).
>   patch 2: move the MPJoin* checks into chk_join_nr() with fixed
>            namespaces, leaving only MD5SigReset and DssReset in
>            chk_rst_nr() (Matt); rename the env vars (join_* / rst_md5sig
>            / rst_dss); the new test uses mptcp_lib_wait_local_port_listen()
>            and asserts with chk_join_nr().
Thank you for the v4, and sorry for the exceptionally long delay!

The new version looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>


New patches for t/upstream:
- 4ef5be975394: mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP
resets
- 69359746fd42: selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters
- Results: b67053e5e63b..25452f1bb469 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d53994ceed37c0dd4cd6c780d5f0a108c7f5bab2/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

