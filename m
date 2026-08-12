Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACD3BC673
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529812; cv=none; b=bZse0Mhtmdwcuv/WYTELZf7susWJC0ePRBRJuv3MHjhPl8bm7ZpY4yNd+bioXru+gMt4WGK4Av/u+2ZWAcWbzUcqzFDY3JjNnLPDQDNTtRA9evDsmUmp0HixFKl4O/NxqjwT8c/BpcqVA00SEjR6da46XmqL+3VLIKr68kd0HBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529812; c=relaxed/simple;
	bh=SLcM2cRjkPGzbif1RVTeBlpMfBUbASdMhO8gBWsxkYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uugyTNShXfRvYRajdoQbhsY9PgPud7TZ+CW+AHuorTzG2I2zGR9UieeiN7lJYn6HWZd08haVkPEzyF9gtiFi2fVf4wokF3Kqxk/244DldcrqcHaiXAcN1FtatQkVa4mfuKZK1RM3bDK2YxM06mwOhqoAGmYa7eBMdcRFaI4lYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyXCTgai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyXCTgai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37531F00A3D;
	Wed, 12 Aug 2026 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786529811;
	bh=j+GxwtrvbX1qlI+9zBcJzlVswPAzuEHaaHgO6OEKSa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GyXCTgaiCf5vuQ64jsz/g4ACAeX0g5aGmGnsTPMXT16f6Kq/XTCZ3jQgTR9Jl3BAr
	 kggp2OG1imKios69hUf66K5hLd/CBMF+Xc6uca1rVDmECekOvFzizBlMxTi94EeHb2
	 nTQXTTrQUfQU+itTbs+DHzqREk2oIF2wpz07lFvlTIBLzdhl3XqQgjX4PTi2dHi8La
	 QiBWAIdDK9gNck/y0Jy3+8oT4v4NPnJBUymqg25wYK6ZIseiN/uwlb0H7scA5QZTmS
	 LqN0fTuJkdQ0FXWJAD6D8p6sUNwgxUBvoQdGT+P1STMgH6KscxuhDqlc55jOEDJ9tc
	 w9IbwXTYqgGlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 2/2] mptcp: add MIB counter for received
 invalid options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gang Yan" <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260812100550.148670-3-gang.yan@linux.dev>
References: <20260812100550.148670-1-gang.yan@linux.dev>
 <20260812100550.148670-3-gang.yan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:16:50 +0000
Message-Id: <20260812101650.D37531F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typographical error in the newly added MIB enum name `MPTCP_MIB_INV=
ALDOPTIONRX` which is missing the 'I' (should be `MPTCP_MIB_INVALIDOPTIONRX=
`).
--

--- Patch [2]: [PATCH mptcp-next 2/2] mptcp: add MIB counter for received i=
nvalid options ---
commit 250b62cf8675c7680c8a9a998feb6bec184832c8
Author: Gang Yan <yangang@kylinos.cn>

mptcp: add MIB counter for received invalid options

This commit adds a new MIB counter to track when an MPTCP option is silently
ignored during parsing. This serves as evidence of potential peer attacks.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/628

> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 1ebdb55e95343..ae0751addd64b 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -98,6 +98,7 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
>  	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
>  	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
> +	MPTCP_MIB_INVALDOPTIONRX,	/* Received an invalid MPTCP option */

[Severity: Low]
This isn't a bug, but is there a typo in this enum name? It looks like it
is missing an 'I' (INVALDOPTIONRX instead of INVALIDOPTIONRX).

>  	__MPTCP_MIB_MAX
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812100550.1486=
70-1-gang.yan@linux.dev?part=3D2
