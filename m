Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204732BCF5
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405089; cv=none; b=L7lMNsSHOjV6iTm29IpMC/lD3d+/2qhJhb29FhEt8SvnLDHNFaHjrtjUOQCCQgK1A8nJ3qGeOm1IjM23dhBjxdp18sS1DnCxRiOItv+AmCOO7uYfc6Du2cCtYcpiJL49a2LodHFr3ukLo5b2ON+2+IRbHEIjav/o6oCSG4xSkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405089; c=relaxed/simple;
	bh=mi0LUhl8GvBUkX4yt5Gkswr+Q/TFrXbrROrbJ7zs8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N46ZKqIecwLS453speZAnzuExr2I4mKSpeAfoRrBOog+o1deWnuyJj4WaVXSsTLszk2NRUFzQmmUrz31fHgramzeper2ves5WWgc4ynbOWDGDDcKvap/9WAP8GIMfXOd6jYxwuTyYkX0EUaMWYeawJ1GvXwhIzzg0Z2z/MSMrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h1NKLlh1; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h1NKLlh1"
Date: Tue, 14 Oct 2025 09:24:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760405085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTbG8J+pLGV2jcLPufFMJ424lARET+25k5+oUYdp3TM=;
	b=h1NKLlh1JHrf7MNgQHbwDEhjtKJxzLsnbXpM8S6j3lxWYtTOfwP/ZKLkQeZmIXBmwKbb7Q
	AJK5OcsIDFiqIb9dg0YqoUvjMNYrjVb6iPkawbxZcjbCpZwOp1i+GYDqNea5gYJzQQsxh2
	CUV3IKnYe5Hjm7QQV/nU7BScQkHgR/g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH] gen_initramfs.sh: use 'date -u' to get Timestamp
Message-ID: <aO2mV6BMsmMAcreU@yangang-ThinkPad-T14-Gen-1>
References: <20251013101946.248420-1-yangang@kylinos.cn>
 <70e9b1e4-41c4-41ba-a684-f6a0b7d7644c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70e9b1e4-41c4-41ba-a684-f6a0b7d7644c@kernel.org>
X-Migadu-Flow: FLOW_OUT

> On Mon, Oct 13, 2025 at 12:28:08PM +0200, Matthieu Baerts wrote:
> Hi Gang,
> 
> On 13/10/2025 12:19, Gang Yan wrote:
> > There exists a compilation error in the latest version of
> > mptcp-upstream-virtme-docker:latest:
> > '''
> > 	ERROR: Timestamp out of range for cpio format
> > 	make[4]: *** [<KERNEL_SRC>/usr/Makefile:76:
> > '''
> > 
> > The reason is the output of 'date -d0' is 'Sat Jan 1 00:00:00 UTC 0000'.
> > After using 'date -u', the output is correct.
> 
> Thank you for having looked at this. I already sent a fix in
> mptcp-upstream-virtme-docker:
> 
> 
> https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/commit/52aa674
> 
This fix works well in my enviroment.

Thanks,
Gang
> The issue is in fact in Rust CoreUtils:
> 
>   https://github.com/uutils/coreutils/issues/8898
> 
> 
> Then, I don't think we need to modify the kernel source. Here are a few
> workarounds:
> 
> - Use date's GNU version: ln -sf gnudate /usr/bin/date
> 
> - Do not generate the initramfs if not needed: -d CONFIG_BLK_DEV_INITRD
> 
> - Set KBUILD_BUILD_TIMESTAMP to "-1"
> 
> WDYT?
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 
