Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D303B8944
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101085; cv=none; b=T1A/7qywmpt6GA+djTr+O3ioxdEMaG3Q4amCcqv45XP9C0Dd6iSACYPbei3RtKVd3hNZrCu01hBXbCLe1KQ/In6waA0naCGmwwWGIdaKAmUiAmkE1KSx3xfW49pze1Y6nZfN6cBT5QTmH8x2b8k5Uk/KPDs72AaH57FUDqQgnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101085; c=relaxed/simple;
	bh=9qQahMlf5fRfMx3Fy2oVFvg0IsDMOrh6WMMUm8UetIw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJsmlhYpLA3tMyUeJ6i9+JpAY1Y+bGKHZ0R6zdfyEFrkty47HLPkBwLv07MtFgjLda4EYmhlDKsnFUzTXj5bef7/1BDaEsU8oqTe5EJ76qbA6KWw71JhuHGMKo9Tq8FhGdOkd9R26HBMFsDnX2Xkriq4jp9TyaRZ+R3MPGhDxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdfGhdMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdfGhdMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994AA1F000E9;
	Sun, 30 Aug 2026 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788101084;
	bh=DwU6kM2XjsMfxkQDvIQc441WeVa5oclMs7b+dOrDphc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OdfGhdMfYOIg/MTpbWd+UgY5dsU/2/cU+K8eqVqqR2Nt+hwu5q6QDlUjbu0iSDiSf
	 Xb8GiZOyFsNO1LZhdeYwrfSlkflSSlemvK32Oqki+EaXRW5YPqyUC6WR/QlNX6GZOk
	 CgwvaZb9fcem71+WHAcnWD5uzIOI8G0nPh7kWIQHd30ShXxo0CSUc/qDhH90B799dQ
	 PY9/KvS2WDK13GekBTzko4Vgl1YodRd/vzVExutQMtgEaqwff5/CKOZIqNaKgufuLT
	 jDUCyv2e46a3/SyYUtN7oXUhJsgU6ELgNbQ8TE19vE+Oix8VjUXZaDxiMO4vkhm3yg
	 btBmdP4Ey70lA==
Message-ID: <7b0959cdb6001d66f51f171b29b275f12e00f0f8.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 5/6] mptcp: trim the duplicated skb head at
 receive enqueue
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 30 Aug 2026 22:44:41 +0800
In-Reply-To: <0ac1a2d7-1426-4218-968b-deeea450a48c@redhat.com>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
	 <81bd1e2fa9c959927bf0d1cae718a9da72164b5b.1785150300.git.tanggeliang@kylinos.cn>
	 <15adac30-7d7f-4637-91b7-3310f64cdb13@redhat.com>
	 <4651fc61637f8be39654decec137010ffcd81991.camel@kernel.org>
	 <0ac1a2d7-1426-4218-968b-deeea450a48c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Paolo,

On Thu, 2026-07-30 at 17:00 +0200, Paolo Abeni wrote:
> On 7/30/26 3:15 AM, Geliang Tang wrote:
> > On Wed, 2026-07-29 at 10:08 +0200, Paolo Abeni wrote:
> > > On 7/27/26 1:29 PM, Geliang Tang wrote:
> > > > The linear readers (recvmsg, read_sock, read_done) cope with
> > > > that
> > > > by
> > > > computing a per-skb offset = copied_seq - map_seq and skipping
> > > > it.
> > > > But
> > > > consumers that treat the receive queue as a single contiguous
> > > > byte
> > > > stream cannot: the TLS strparser builds an anchor whose
> > > > frag_list
> > > > is
> > > > the receive-queue skbs and reads it with a plain
> > > > skb_copy_bits(),
> > > > which
> > > > has no per-skb offset knowledge. A record spanning such an skb
> > > > boundary
> > > > then reads the duplicated prefix and gets corrupted.
> > > 
> > > The above raises a question.
> > > 
> > > AFAICS, the critical skb layout is also possible with plain TCP -
> > > possibly is just less likely. How does TLS deal with that? I read
> > > the
> > > above as the TLS stream get corrupted, which sounds suspiciously
> > > too
> > > fragile to me?!? Or did I miss something?
> > 
> > My description was inaccurate. This only occurs in the MPTCP out-
> > of-
> > order scenario. It does not happen with TCP.
> 
> I mean: even for plain TCP skbs can sits in the receive queue with
> some
> heading bytes overlapping with already received ones, and skipped at
> read time due to `copied_seq`, how comes that TLS has no problem is
> such
> a case?

This issue is actually a bug in TLS, which has been fixed upstream by
commit 9466ef3ec972 ("tls: fix RX desync on overlapping skbs").

As a result, this workaround is no longer needed in MPTCP. The proposed
patch, as well as .skb_get_header() interface mentioned in the cover
letter, are now useless and should be considered obsolete.

Thanks,
-Geliang

> 
> /P
