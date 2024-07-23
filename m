Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F28143747
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772118; cv=none; b=Zo11B68v18Eos7q2lloWjoQ+oGxHP+O9qH+PB+adRIWr/scd3lYYSxSawfW5LFZhBNkt3BE9c8E3ejklYvk0K6UEo8rdfhAv6vaYrQUA8nE77XDE5GbruWQ93als8LDPL75kBlkmx78467SHMSwrWzxgT9XXnuOhsvpBWMUY8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772118; c=relaxed/simple;
	bh=krZNWggrWjVcl9hXlrFka7DZF2U2f1uQLs8mjxVeJVc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QmeBc5eHG04uvCLXnBlVdoZxhEUrJhsS/AvIFxVV2ahjM0tWZ1n/5PHwiDvPQ/BNtNov4zMbTMVZTab4qGjyNUYdMqWcsw3mCofoKCmSjxm4AAjo6hw4PXjvOBDi1k6KOOycNBKEsweZ2nBOD4UDXh05QmJHWF2BHKD+qgdOuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COSnbM7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COSnbM7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DCFC4AF0A;
	Tue, 23 Jul 2024 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721772117;
	bh=krZNWggrWjVcl9hXlrFka7DZF2U2f1uQLs8mjxVeJVc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=COSnbM7qN8z0/HsdXesyREHvIesKu/koomFSbDwggP8u8RtCpbGjmtmJwu237E7TO
	 mCWOcblYPFYB0Q+cSgLHgX1ZLXjxFafFqR4EFLs1mcgiXFV1I7vwWhGAFu/4pCgpva
	 cZe+aD0ji4tEYk6Mj0ZJ9xi2oLUE7NZ4kUu9/KoCr08og25rqAIWwxFVW1CS/U0o6R
	 T3Ff0cBXLmc32UIuhWdriFLCw5Yu0/gW4Ps/Ir6h8wOrYAs3Q7EExa/03P4Sni01Si
	 oqeeGmcnTRhEDZJz2TLZ+ofrbPsnl+5l1LGB3X8L9Ng+XTEVEU/l/vLScrLVAALfF9
	 NWQw2v6/opEXw==
Date: Tue, 23 Jul 2024 15:01:56 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v4 21/23] mptcp: pm: avoid possible UaF whend
 selecting endp
In-Reply-To: <20240722-mptcp-pm-avail-v4-21-15bfd73de384@kernel.org>
Message-ID: <8c95f30b-617a-f72b-b729-844f158e50e7@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org> <20240722-mptcp-pm-avail-v4-21-15bfd73de384@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jul 2024, Matthieu Baerts (NGI0) wrote:

> select_local_address() and select_signal_address() both select an
> endpoint entry from the list inside an RCU protected section, but return
> a reference to it, to be read later on. If the entry is dereferenced
> after the RCU unlock, reading info could cause a Use-after-Free.
>
> A simple solution is to copy the required info while inside the RCU
> protected section to avoid any risk of UaF later. The address ID might
> need to be modified later to handle the ID0 case later, so a copy seems
> OK to deal with.
>
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://lore.kernel.org/45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Hi Matthieu -

Minor subject line typo - "whend"

- Mat
