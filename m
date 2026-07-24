Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50A3A4F2C
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879902; cv=none; b=aH2F2fdB2JNRj1gD97nIHHv6i3PoknqEig4ziij5snnlNrf5udsODTD4l8zivG4cUjQCsCqZno+g8vOHkTSTkIPeR0y6C9DhcNK30aNiR+rHTE7DS8W9JWJj11h3aQkn5iZnBP6xUs5sI9kEMsXnmrzSNMGx7dSIwZHYAbJkmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879902; c=relaxed/simple;
	bh=bw8fPLvr3Cx0nVYoO6qfj1/NxT7amWoBC9z0OewjOwA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k9zfoBKff8qwNJWD+Z6Jroa57ssUbfWeOp9dyb5nnZyM07uALU7LJjvkprzzOwdOhIzmslKYvH0DDXzNirUFCU77GBgt5VhLzlq2lsE17TLJf0HSMi/ec9q86SVBZK00VXJAr5xkoPvBIbyWxVUPnpg5UNCsceRQmDRHxt8vT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VLsqPCkj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qVmabKhg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VLsqPCkj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qVmabKhg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C46DEC011C;
	Fri, 24 Jul 2026 03:58:19 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jul 2026 03:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784879899;
	 x=1784966299; bh=Dzp89xiUIPdJl5hcz02Yk7VG9SGRj/EXaFV5fFe5xZM=; b=
	VLsqPCkjcWadfTZ91tWzBFojd1+uLZKC7M2R56MZV76CB9k0VYwocBPjSsPt7oP0
	oLkj7SSGcEy2QJN4/RllijY8+ptyJjtmtLAhIB4ngLPYcAqQDGC1Sjm0kInKAD6b
	KTtkIuub5ffCnEPYiMClD7hYmTRTSuSYkAfITUnxJH3B3tnkvfE6OToJAHLXNjxM
	DZUhgXLviOiDG89iqkPe8mSl1f6etVQ2oEgv5ItKyYUb1++/MEiP4o16sC6R/zZd
	bSvnBI7QLoRAI8XupAhQbj+rId1wip5OI3l7k/tALBgw5GtvDJ0OvU3UtPFb8jJK
	BFgNfRPdhpMKrp77qYM3iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784879899; x=
	1784966299; bh=Dzp89xiUIPdJl5hcz02Yk7VG9SGRj/EXaFV5fFe5xZM=; b=q
	VmabKhgB5ujEp5Pzann2QoQolakyM/qdwBB7mcjK5SHoaW8BQkMEp3ypnfQN9S2b
	VLfG5ZKUZfrWECMzjvVhTlP8swP/W8rafkg8IruC17MxDbZ3W/ct+PKTQuVZTbDH
	rdaHFac4H8xLguE2K3G5f83+/G0st3pDtdnJiTtvgR+CD2XH2cUfZKHB1VGCuC9r
	/oHtn5acsWkNTthGP9NI9YCh4zNcTy788u0m2O7SrihOR/cGdEfTtrOJDJTeRhs4
	0ZwyUha4150yMDMtBG4P2lg/Tu8NfqJ2hX1xghnSQjB6jNxtQvV04gWOOJw3UprE
	8fE6qB1mavJSODaOJoryQ==
X-ME-Sender: <xms:GhtjahgZIyYl92lWTGazFwpKjwDDCJE9Ub51116EoMZIiVzvexc-DQ>
    <xme:Ghtjag0TLJNi5f02lKJBlj4vHPr_5Dco5c9J1Nuy2JjTKyLjK-zSbs2nWBg_dSW0Q
    BsJNjaLc9I2SPPthlwhmM3hLqWL3-0-6UxRjQrFQcQs_njpnQtEzwM>
X-ME-Proxy-Cause: dmFkZTGDRD4CuaKmLi56PDUpO+fodq6giodQyGoALqiKEoqcgJsVwoaK+JyQ2LFDV2pG2Q
    XzQpplbElnL46bw+Lz4jAdAbUaEGAennVI9rZ5r7/gF/ovk4S+PEPv1TT1rh5fOB+MhcwO
    Wumc2sUDt0L9Zr5mwW2/5FTr6L1VrgfmRt0n77OtDthMMWMtbhrrxkvnO5MGkgIAg1d9+1
    gzM2sLp9rTAt9UdOob7/Qo4GkvBX5Jdcvo8YUBN9VuAo3hit7nRfvAiivi2CA4mLlMNAnM
    1Qty64LE6wTptMwVE1MgevO0vXb+IQk26ZPDOo7z2sfQwYgle2arHlxuKFCNZlyTmuZTgV
    N+Dx+Uq2kSFMCPW3VyngWbkEZJtp0VfC4Cq6xGYEI3QcknrEzk5PaAihZRKCkV3K3AEnBs
    tKZuIg58cYx4njq1ZBVp8rRLGQt/jdltNvuLN8/OBgAO6245g7E/h5E2fca6l7+06gcdQY
    NcJ49t8OZ3y6X1uUFverjYPnYAfs5X8r5B//lSPlSiF5tncCX/d6XONGmTtQZ1t8tJ2swL
    520KgJ3C5RkYOcXZGI5XEuOmkN7lJyUKVlJLUKFfPD48ll+6/0hAuT+WrbFRukeUWqkbaZ
    bcWKGnJX5f6VIXRbjvTvQEOdV0GnNz9y4DJ7M1vdzg6QPHuq4Cch+DAukTVw
X-ME-Proxy: <xmx:GhtjakK5rfkvsXJijrbQsnd9TntFXlHTjfYa0bqLR18Lh5Ics7DW4A>
    <xmx:Ghtjah87YUE0CHEPTtvjOcJnsuxmRDdmM5Yv3gZG-ppVXBQVMrSObw>
    <xmx:GhtjavI7WUEYyprDkBWZoROHrRFb_WHcqvHvePH772F0mFQa0_AmrA>
    <xmx:Ghtjauk_iGwAZMAYmhO9lGTiDWUudXuks2RJ9NPTs9ph2gnT8JQxZA>
    <xmx:GxtjaoMXw-gN1gbxMtAF50tDHx6HeFD2rurG9pzpwIj32fqa6i6rDZQ2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C3F31182007E; Fri, 24 Jul 2026 03:58:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Aod5Nz7QKUWJ
Date: Fri, 24 Jul 2026 09:57:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Matthieu Baerts" <matttbe@kernel.org>,
 "MPTCP Linux" <mptcp@lists.linux.dev>
Cc: "Frank Ranner" <frank.ranner@intel.com>,
 "kernel test robot" <lkp@intel.com>
Message-Id: <ceb3b719-0a4c-4998-9a14-1eac1d574bb2@app.fastmail.com>
In-Reply-To: 
 <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
References: 
 <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: fix BUILD_BUG_ON on legacy ARM config
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 7, 2026, at 18:48, Matthieu Baerts (NGI0) wrote:
> The 0-day bot managed to find kernel configs that cause build failures,
> e.g. when using the StrongARM SA1100 target (ARMv4).
>
> On such legacy ARM architecture, all structures are apparently aligned
> to 32 bits, causing build issue here. Indeed, on such architecture,
> 'flags' size is not equivalent to sizeof(u16) as expected, but to
> sizeof(u32).

I just saw the patch get merged upstream and wanted to clarify that
this is ARM OABI (CONFIG_AEABI=n), which is technically unrelated
to the CPU type. It has a lot of problems and should hopefully
go away soon.

While I'm testing randconfig builds on Arm all the time, I specifically
don't test OABI kernels.

I had to check that this isn't actually ABI or wire protocol though,
otherwise dropping the BUILD_BUG_ON() would be hiding bigger problems.

> Instead, use memset(). It was not used before to ensure a simple clear
> operation was used by the compiler. But at the end, it shouldn't matter,
> and the compiler should optimise this to the same operation with or
> without memset() when -O above 0 is used. So let's switch to memset() to
> fix this issue, and reduce this complexity.

The optimization will not be used on architectures that build
with -ffreestanding (apparently m68k, mips, sh, i386). We probably
don't care about performance on those or we would have changed
that already.
 
      Arnd
