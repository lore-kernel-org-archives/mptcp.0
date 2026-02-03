Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56431ED8A
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114676; cv=none; b=C7vg2dMIao0mvGGhERttqm13CXL1Y08tlUJ32iQ4Kiu2/bNhfDPfyNS/+2Q/X51s02cQQ6/irQL17L3TigFHFn3axZEY9zxByfIGYXQHgNntPYPEqMSX9vgGBrKiGFfO0jA9U7H4nyMbnVDCiO2P9ib/Uces2sbyC1Und6orxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114676; c=relaxed/simple;
	bh=8EqXSPylvbySNAr5Oei+u1o6rSgjgsVLZjgK41Gu8I8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRc+IUXKb5shkXWEMt0PP1vEpDKpAvUUgwTYE/dWRsLU85YH43uH9pM2xTHovLlOT+sArq956oJy3HNOYna5Fucf7GFrXMCMUkHxPSLevHSEFFx0TXBYPcpfz3g5hUg/fKC6/Wl+CAPYXtVRVNpV5L2cPkXgOLaNM2f31hY+7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvrBuFXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvrBuFXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2D3C116D0;
	Tue,  3 Feb 2026 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770114676;
	bh=8EqXSPylvbySNAr5Oei+u1o6rSgjgsVLZjgK41Gu8I8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VvrBuFXD+nKjZEyMftT5LcJYsO2yW4rhMLOo/IzlM2PKqHOxMrR3aj4k6ldp+nSFM
	 6JkPFseyjY8ayDiKBAqZHH0qnXJCbQtWPIpOZ9M3JkzAeOyyRIJIJcSZbs2TLIz4+6
	 SqA1jtsTPeXmhQpHLjQRej9hjGYjGUyN9q5HdTGRW3oG4j8DkOA3u66m+98NJyv7i1
	 N69T9UfcCogsVAeQUKDbvEAoEV9ugPdw0HhzmWsOUmpgogSVOOB/GiK8CcwejVmIwe
	 JhkjjFRg7/DFV0mc2YxiwKFinXXIFCPs6YC6GkXVeC/kOG43k8Km0C+lw1REfo1Gmi
	 iY44jt0dbTtTA==
Message-ID: <19b28307eb2492546fbf363ede5856447e4fe06d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/3] mptcp: allow overridden write_space
 to be invoked
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Date: Tue, 03 Feb 2026 18:31:09 +0800
In-Reply-To: <3a02e802-56c6-4c99-8f7d-aa618a8f46b7@kernel.org>
References: <cover.1767504329.git.tanggeliang@kylinos.cn>
	 <2efc3455052c3a33cad0c8744b171dfc6e7a6d8a.1767504329.git.tanggeliang@kylinos.cn>
	 <9a2ce3981452685fe178892d0631b289b8d55e01.camel@kernel.org>
	 <3a02e802-56c6-4c99-8f7d-aa618a8f46b7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

Thanks for your reply.

On Tue, 2026-02-03 at 10:42 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 03/02/2026 07:54, Geliang Tang wrote:
> > Hi Matt, Mat, Paolo,
> > 
> > On Sun, 2026-01-04 at 13:29 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > psock may override its own sk_write_space functions. This patch
> > > ensures
> > > that the overridden sk_write_space can be invoked by MPTCP.
> > > 
> > > Note: This patch was initially included in the NVME MPTCP set.
> > 
> > This patch was initially developed to resolve the "timeout" errors
> > observed in the NVMe MPTCP tests described in [1], because NVMe TCP
> > overrides its own sk_write_space. During subsequent development, I
> > discovered that not only NVMe TCP overrides its own sk_write_space,
> > but
> > KTLS and psock also override it. 
> > 
> > Therefore, this patch is needed in all three series. To reduce
> > dependencies between these three series, I propose to merge this
> > patch
> > into the mainline first.
> 
> Just to be sure, when you say "mainline", do you mean our MPTCP tree
> with the export branch?
> 
> Because we are at the end of a cycle here, my priority is to flush
> patches that are ready or fix issues. If I'm not mistaken, this patch
> is
> needed for new features that are not in our tree, not in net or net-
> next
> trees, right?

Yes, it is needed for new features. In this case, merging it into the
export branch first is also an option. It can be sent to net-next in
the next cycle. I plan to submit the KTLS series and the NVMe series to
the KTLS and NVMe communities for feedback respectively. If this
write_space patch enters net-next early, it would be more convenient.

Thanks,
-Geliang

> 
> Cheers,
> Matt
