Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AF23D7ED
	for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361771; cv=none; b=mrQlKNV5vikwTMw81pFr3pGWPts4EjEV6Jaf5cx+9vOGGPg4Q38NniT/9d/x35Ra2/7/cHtCvGDI/zhQiabG2hW6uOnyRnQIUFBFouxpT7MAMR3AoVOKFsINvXNwgkN6KinfGl9w3f6Zfr05erd910AYSdaK5VhLm5/XJhF2IP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361771; c=relaxed/simple;
	bh=7uO8zJvAN/PPUB/xDZmSfGiHxGRREtJMau1lGN6o/oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ0qJ4fpD0J7e1IeAkF0ArIL/XlPSIBj89iKES2cMZstn+D/U8ARYDklNEE2UigtWH1Cwfl15rPaylwzWCBh6Z84IcD1YrzLRPlSKSJLqPPh5K16hBTFWxFGUhWfYeJGb5FCQrpDoiV0eh8j47zRP2NcsuPS+zsP3S7C/0oaddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jf3K/58t; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jf3K/58t"
Date: Mon, 13 Oct 2025 21:22:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760361766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlcQnxLqwKeEibprwdfh3ycwySmdE/VtKXgFNQCD924=;
	b=Jf3K/58tAV1VKMQdT2J3WrWqQseXbUO2kpVmdxw5nKGkuuqvJrd6oTEHKhZ1C/HIvpmcMV
	S1Px7hPxCc5kOAyhzk+OzfZihJC52FG6F6zW8+ATusvrqo0NAM5buZ0qnVjcISQ0zvbuvc
	usfGY/M/RrJJb70uj8rHHrI4YVI9wTo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH] gen_initramfs.sh: use 'date -u' to get Timestamp
Message-ID: <aOz9HkqEE_2FfNQX@yangang-ThinkPad-T14-Gen-1>
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

On Mon, Oct 13, 2025 at 12:28:08PM +0200, Matthieu Baerts wrote:
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
> The issue is in fact in Rust CoreUtils:
> 
>   https://github.com/uutils/coreutils/issues/8898
>
Thanks for this information.
> 
> Then, I don't think we need to modify the kernel source. Here are a few
> workarounds:
Sure!
> 
> - Use date's GNU version: ln -sf gnudate /usr/bin/date
> 
> - Do not generate the initramfs if not needed: -d CONFIG_BLK_DEV_INITRD
> 
> - Set KBUILD_BUILD_TIMESTAMP to "-1"
> 
> WDYT?
Still, I have another question: Is the compilation error too strict when
failing to retrieve the date? Would throwing a simple error be enough by
default? Or would it be better to provide a default value when the date
cannot be obtained, ensuring the compilation can be completed?

WDYT? It's just a normal discussion.

Thanks,
Gang
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 
