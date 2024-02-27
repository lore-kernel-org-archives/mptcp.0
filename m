Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729E4A33
	for <mptcp@lists.linux.dev>; Tue, 27 Feb 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998024; cv=none; b=mKBCx//kp9T5RjjWH0wMwaYjcvx7y+f0EAyASnmIxagUiDzVhio4kmiHWAjdLuyyFv0IgTc2nWqnmx2HVdOqIjOH6VNKnzpeQOHv1yY8CrzKhwInN8FsZO7GM1oOSktOEV43MLWIrc8/sTsF1zRJyVEfM79WwPgQhSA/TGIbcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998024; c=relaxed/simple;
	bh=obLOCC1ErFhw9fv+meudzwmhm6dxxQ0WFBvBVFiaXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eybqhgO2vnVjRaOh04pDlC0eWl8q0Vaenh8ydNWxY/N+xfLp9VHvUuIeZr1OCxhveO7v17K+vpQDRTBXJPaGsx7Zjx+AHBMkXeKPfVc4WE0DSfJi/saXpuzWXX3zwlVYHQzG1iXnB59w6nPEgtrgaMQdqy9gugX8MOYjTEkdaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obwcoc5E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obwcoc5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448D2C433C7;
	Tue, 27 Feb 2024 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708998024;
	bh=obLOCC1ErFhw9fv+meudzwmhm6dxxQ0WFBvBVFiaXxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Obwcoc5Es6819HO10Z+glQxb/b9WFFPpYoqcJvSxgEC7leiUwO9/1CGt4qM9NLvxi
	 bbZ15/aJN6CuFqK8aauLbaPYoU1rLW+KNAoDaf1fC1QoUFHokyPzf3TwYSvlCvR27K
	 6rXo2JTtm2RNZdS4qacL/ds7AkA7K9E5jKNp81PniDy0xKS8z6N9eho4EKm9Hg+LWr
	 BkgDsNiYWDMwZoEmKCny2/yWTVUVn3GgZ55B2I/PpC11fZcVCLZX5MQj7FYf2TRUqs
	 /QWcSjKxRjn/W1LgKRW7aTZPT5epBPagpkbT6steumGyDNTIzgPuACcameCkYbUgGh
	 P8r3ZvLHbOFLg==
Date: Tue, 27 Feb 2024 09:40:18 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/7] some cleanups
Message-ID: <Zd09gi9yBjnkGtaS@t480>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
 <ccfa5d4a-3ba8-47b0-8610-8266ac423c12@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfa5d4a-3ba8-47b0-8610-8266ac423c12@kernel.org>

Hi Matt,

On Mon, Feb 26, 2024 at 11:06:11AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/02/2024 09:03, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v2:
> >  - address Matt's comments in v1
> 
> If you don't mind, I think it would be useful to add a short changelog
> per patch, under the commit message using '---' as separator (or using
> 'git notes'): it would help to remember what was discussed, what was
> applied, rejected or (accidentally or not) ignored. One line might be
> enough, but it would be useful.

Sure, I'll use 'git notes' to add notes in the future.

> 
> > Geliang Tang (7):
> >   mptcp: make pm_remove_addrs_and_subflows static
> >   mptcp: drop duplicate header inclusions
> >   mptcp: update set_flags interfaces
> >   mptcp: set error messages for set_flags
> >   mptcp: drop lookup_by_id in lookup_addr
> 
> The five first patches look good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> >   mptcp: add check_id for lookup_anno_list_by_saddr
> >   selftests: mptcp: flush userspace addrs list
> 
> Maybe the 6th patch can be simplified, and the 7th one can be dropped?

Please apply the 5 first patches for me. I changed the states of them as
'Queued' on patchwork, and 'Changes Requested' for the last two.

> 
> Also, please check my comments on patch 7: it is *really, really*
> important for you to explain the *reasoning for why patches were
> created*. Without a clear reason, we cannot accept patches.

Thanks for the note on patch 7. I'll always explain the reason for the
patch in commit logs in the future. I promise.


Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
