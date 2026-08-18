Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6C3D0BE5
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039574; cv=none; b=hCPfbivaW61kGXVWdJpWBKsSdKowwPFodzVsHOHJkjxo72PEF8CpvfEyARdQywn0C7at+2yMbk1RRJKfP5OA9f3FvJR/VAHXv55SP1sY6MDajeeWxGJuEq8BaZFTQWQ25Rcsx44mFATCwqJ3wNXPxVwbmVbTKfu3DxFt7kLVN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039574; c=relaxed/simple;
	bh=M7SSfqKh356DEGs0gz2uwoFAHM45/yVX54xnxdRrC/o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lW21Mfk57gUQOmYLw4u4RFq1//JJVeo55nhYaKv6OB6DgURO9//y1vCkZo0mbUbzcgps3u2/lXoj+skTm2125WsP0zYi8KGL4LiNpRNIja8AvWlDBJ+wsSLWa6itOUok1kIPP8tqlFDW/6YR8bCx95WZPpS+blp1913erIL9+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivywm5DL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivywm5DL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378C51F000E9;
	Tue, 18 Aug 2026 07:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787039573;
	bh=CEWFh+Eo4PuRoSIm+eJ7coPCUzN9NBC5eXBRhy95bcg=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=ivywm5DLaAOFYfGjXKIMUxI0lTMWPtjisFoY9A+UVXSmvHEv73zojVSo/x3Eqw2ZY
	 HSoEr6NJdVMu+dvOCnMDVGaHZe8dHQbMv5F6OvrKGlQPQjuemhWe85YDceL2ei+lue
	 354mEpgtjMSThiUu0CBuzDEmP2oea33TlSoSZzwKlkwzQnELtOI8rOm76cfTtjE4R1
	 U61zEiD3VYX7ox42uEOG5shqpAtdQ7R1KIiHQcv7yY2J9zT5lx/cC+hyEPEUfDyO3d
	 83BkOthI6GeuNtQfDp7UmZsdlZOfAE4bFkNIdR/6GWWY1SKWANY7N+he6W2dgEeYqO
	 vicoTPvXUYU/A==
Message-ID: <2a74fda9614c9a11b8789a33dcda21378660534c.camel@kernel.org>
Subject: Re: [PATCH resend mptcp-net 0/4] mptcp: a few fixes
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	mptcp@lists.linux.dev
Date: Tue, 18 Aug 2026 15:52:48 +0800
In-Reply-To: <ccf9480a-712d-4d37-80f1-3db80b7a4409@kernel.org>
References: <cover.1786713351.git.pabeni@redhat.com>
	 <ccf9480a-712d-4d37-80f1-3db80b7a4409@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2026-08-15 at 19:19 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 14/08/2026 15:38, Paolo Abeni wrote:
> > This is mostly a follow-up to the recent OoO queue pruning series.
> > Explicitly targeting net as we have already a lot of patches
> > pending for
> > net-next, and no need to rush IMHO.
> > 
> > First 2 patches addresses explicit comments from sashiko, 3rd one
> > is a
> > somewhat unrelated cleanup I stumbled upon while implementing patch
> > 4.
> > 
> > The last patch fixes another thing implided by sashiko while
> > reviewing
> > the mentioned series.
> 
> Thank you for this series, it looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I will wait for the net-next → net merge to apply them to export-net.

If you have time, could you please merge this series into the export
branch at your earliest convenience? My ongoing series, "Reduce the
differences between TCP and MPTCP for TLS usage", conflicts with this
one.

Thanks,
-Geliang

> 
> Cheers,
> Matt
