Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24C288C2B
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781035; cv=none; b=kuqoMLkEWLD7mv5w+3q7MP2whCtlC+7FfIQykZb12bQRB4GRtqihTfK3R1itKTnGJ4tVF9fkw58ERMySKOswt8QmHocu+fiEhrGLftFX0uADw1KWzH9PYGkktr6KMT2KsQvpjUzEW3KxhAFVeyxnkGTipVeAcjlSbDkXBFjayPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781035; c=relaxed/simple;
	bh=+sC1BqVvTxxtbiw2scyDs8dyQmcGChGdZOQLPZJ3i0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8OXHbfjUA61qJmzk6EFn08PfBzJGv1LuwfTZUpEP/wwaDYOwX7koKWw5NBDaNinGd7osnRQmURVQM0iTpobCzcYO5+GeAd6itT9R8QewR68tqM16Wwxd9mYAif/1KdcP/8PkCrG3f3EGU7O0Xto3RYAVivPf6omcSKdyGuskq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leVBXciL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leVBXciL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931D8C116C6;
	Fri, 30 Jan 2026 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769781034;
	bh=+sC1BqVvTxxtbiw2scyDs8dyQmcGChGdZOQLPZJ3i0A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=leVBXciLXVzjgYoxs7asecZ1JnVv9XVupWOb5QOBb+bLbRKXj2rk0MieRnSc6kD2M
	 ytHwlcJomjyXuOWIH2YlhVPk83p0283wN+alNZ2l4g7IoIHPSGXdbKhpMQH1xke0I2
	 0tQtBSdjzwhFTp2QXejaKBW5EinLmvTeAKW7bQxliiM9zv7tcEcIm4ArwggM9V289V
	 xJ+F/O7UCjH16ZUWue4nbmQBJxX3pp4avDTOH9BVNYXZ9+JmsmpwHlWHo0+W+xV+4Z
	 5If9h+A/KUbAMo6pxNR5v6ap8D0pCNOhFtY16d0H22281JPMJAk0ztJjkbvivI19sM
	 n6bleOQPof5Dg==
Message-ID: <e13a0b73a01583e614e2b7e116075a24d9178472.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: diag: sort all #include
From: Geliang Tang <geliang@kernel.org>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 "Matthieu Baerts (NGI0)"
	 <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Gang Yan <yangang@kylinos.cn>
Date: Fri, 30 Jan 2026 21:50:30 +0800
In-Reply-To: <20260130115218-0bdb243f-819d-46aa-a7cb-fd43fefccb8d@linutronix.de>
References: <20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org>
	 <20260130115218-0bdb243f-819d-46aa-a7cb-fd43fefccb8d@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2026-01-30 at 11:53 +0100, Thomas Weißschuh wrote:
> On Fri, Jan 30, 2026 at 11:41:43AM +0100, Matthieu Baerts (NGI0)
> wrote:
> > This file is the only one from this directory not to have all these
> > header inclusions sorted by type and alphabetical order.
> > 
> > Adapt them, to ease the reading, prevent conflicts during potential
> > future backport modifying these lines, and also to avoid having
> > UAPI
> > header inclusions before libc ones, see [1].
> > 
> > Link:
> > https://lore.kernel.org/20260120-uapi-sockaddr-v2-1-63c319111cf6@linutronix.de
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Thanks!
> 
> Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Looks good to me too!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_diag.c | 29
> > ++++++++++++++------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> (...)
