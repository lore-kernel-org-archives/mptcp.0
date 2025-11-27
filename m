Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0C2D948A
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234602; cv=none; b=cHb2aI8TBbJf+yqlWuL8n1gLr7wS9EmE2ASgvIJirxYSoSPtVBVtGwOy9sOuurEgoXXlELQjLD585Zy/of++o/Kdp1KatDEHvMM+ivPD1qy7TdG4EZhQ3yCX9qGrH4HVo0SzY8yYnOdKS0lCDI+8RnhWKlacrYeFtZPwwUNaA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234602; c=relaxed/simple;
	bh=mA6zmlNbtt8j0iLs6N0EjIUiYcFWzGu0qKvb5h0ZWI8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHRzpnrF5HQbRjhOy3dGcH32tUHymZtyXe3BKvu0q790tYpnnta3OhYygo/kGtNMHtgGgt/zO9ylOC4XErFrmWfEv/ZRqae8Y3YlT4pFl+JWWpkf8tnAg2H8sghVJqn1Thsxd3FcjwDy2+aThHZk2lY1KPZTmG8zX5NF/XPQabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl63SzqR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl63SzqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B98C116B1;
	Thu, 27 Nov 2025 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764234601;
	bh=mA6zmlNbtt8j0iLs6N0EjIUiYcFWzGu0qKvb5h0ZWI8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Hl63SzqRMOoGS963b4NCodx1ii66zv1UE8lPUajgy1JpgvmYyoEk2gYbVJIDYFSvR
	 8MGlBmOhHfw4n/gdzAeqay4SnX28AUeNptWRP7JxV30OK56XerslmT1nt2/ZD2QquS
	 sBxRz2TMeKJ2lbzYGT3H+sxH1N8EIqW2FfHDg4+iVIC6o50V7ISbshnTuY+dj4Yw89
	 fDzR7Arn3J/fM+C/pBMVv7v62XpLLXdoOoALK7PBftGXDXnDjfASgfjMrru7Mw0D5i
	 0wpncZnURGU51IZmjD+/cQAnoiF4KMHamWQrg/VLQDgSddFEhcMyudREE3Cats7CHI
	 y+lCr28cLKdxw==
Message-ID: <a89a2d6ebf7151f24aa479898beb9db49b2e2771.camel@kernel.org>
Subject: Re: [PATCH] libnvme: add mptcp trtype
From: Geliang Tang <geliang@kernel.org>
To: Hannes Reinecke <hare@suse.de>, mptcp@lists.linux.dev
Date: Thu, 27 Nov 2025 17:09:57 +0800
In-Reply-To: <2055f284-2b8d-49af-b149-7b341e5d44d5@suse.de>
References: 
	<99f6e63b5c9677f29a9bc8cdd87b2064b258435f.1764206766.git.tanggeliang@kylinos.cn>
	 <2055f284-2b8d-49af-b149-7b341e5d44d5@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hannes,

On Thu, 2025-11-27 at 08:57 +0100, Hannes Reinecke wrote:
> On 11/27/25 02:26, Geliang Tang wrote:
> > A new NVMe target transport type NVMF_TRTYPE_MPTCP is defined for
> > MPTCP in
> > the kernel. Add it to libnvme as well.
> > 
> > Cc: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Geliang Tang <geliang@kernel.org>
> > ---
> >   src/nvme/fabrics.c | 1 +
> >   src/nvme/types.h   | 2 ++
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> > index b0821e96..d3a1c033 100644
> > --- a/src/nvme/fabrics.c
> > +++ b/src/nvme/fabrics.c
> > @@ -73,6 +73,7 @@ const char * const trtypes[] = {
> >   	[NVMF_TRTYPE_RDMA]	= "rdma",
> >   	[NVMF_TRTYPE_FC]	= "fc",
> >   	[NVMF_TRTYPE_TCP]	= "tcp",
> > +	[NVMF_TRTYPE_MPTCP]	= "mptcp",
> >   	[NVMF_TRTYPE_LOOP]	= "loop",
> >   };
> >   
> > diff --git a/src/nvme/types.h b/src/nvme/types.h
> > index 4943e00f..2aa81938 100644
> > --- a/src/nvme/types.h
> > +++ b/src/nvme/types.h
> > @@ -6823,6 +6823,7 @@ struct nvmf_disc_log_entry {
> >    * @NVMF_TRTYPE_RDMA:		RDMA
> >    * @NVMF_TRTYPE_FC:		Fibre Channel
> >    * @NVMF_TRTYPE_TCP:		TCP
> > + * @NVMF_TRTYPE_MPTCP:		MPTCP
> >    * @NVMF_TRTYPE_LOOP:		Intra-host Transport (i.e.,
> > loopback), reserved
> >    *				for host usage.
> >    * @NVMF_TRTYPE_MAX:		Maximum value for &enum
> > nvmf_trtype
> > @@ -6832,6 +6833,7 @@ enum nvmf_trtype {
> >   	NVMF_TRTYPE_RDMA	= 1,
> >   	NVMF_TRTYPE_FC		= 2,
> >   	NVMF_TRTYPE_TCP		= 3,
> > +	NVMF_TRTYPE_MPTCP	= 4,
> >   	NVMF_TRTYPE_LOOP	= 254,
> >   	NVMF_TRTYPE_MAX,
> >   };
> 
> Sorry, you can't do that. You'll need to register a new protocol
> number
> from NVMexpress.org. And that would require a TPAR detailing out the
> mapping between NVMe commands and MPTCP frames.
> Which probably is a bit of an overhead.

Thank you for the reminder. May I ask where I can get the TPAR for NVMe
over TCP? I'd like to see what details need to be included to prepare
for future needs.

> Maybe it's easier to declare it as a TCP 'variant', keeping the
> protocol
> number and 'just' modify the TCP driver.

That does make things much simpler.

On the host side, it's easy. A new NVMF_OPT_MPTCP option can be added,
which can be set through nvme command as follows to create an MPTCP
socket:

    nvme discover -t tcp --mptcp -a 127.0.0.1 -s 4420
    nvme connect -t tcp --mptcp -a 127.0.0.1 -s 4420 -n
org.nvmexpress.mptcptest

On the target side, in v1 I sent you earlier, I reused TSAS (Transport
Specific Address Subtype) field for both MPTCP and TLS. However, that
approach made it impossible to use MPTCP and TLS simultaneously. Since
I'm currently working on TLS support for MPTCP, I believe MPTCP will
soon be capable of supporting TLS.

The approach I can think of to switch between TCP and MPTCP on the
target side is to introduce a Kconfig (e.g., NVME_TARGET_MPTCP). When
enabled, it would create MPTCP sockets instead of the standard TCP
ones. What are your thoughts? I'd appreciate your feedback.

Thanks,
-Geliang

> 
> Cheers,
> 
> Hannes
