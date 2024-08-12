Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE817E8E5;
	Mon, 12 Aug 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475493; cv=none; b=p+tP8BsBjYb65Tb23SFXRHilM92QIFLARn77Er6lLVQdaDbDOkV+xUBo4EwKtgs2FOIT3oVRh52MIGZMDwtfwOuizO1+azyXv73tlc7VnmnFGFpnPCltQYEmqN3+UiOJvmxaPh1th9w/DzVav3KfQCaMZvzUdHXxzLFPRCOx9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475493; c=relaxed/simple;
	bh=RXRckz+a+2LpxED8Imj7XMlhsf3yTSnnbG7MEKnW3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoI0slXUiADcQNJYePWEppC92Ko1KegIGDcSOw1r+w1T49bFFBb9xHNTmkXe2ii69nf0fZTfQDHfokwZbHotvs/KuppwX53e4m0pm9QH7t4zP8PQaQq+J9bvPz8WqmqA959rRMsE+ZWxPSk9Kn5dMORAMHypRBDDcqQsrTPD1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PTU2kLD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PTU2kLD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3825C32782;
	Mon, 12 Aug 2024 15:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723475493;
	bh=RXRckz+a+2LpxED8Imj7XMlhsf3yTSnnbG7MEKnW3FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTU2kLD51gPLq60F6I6BhWsC/o98Pdp5sw7E4nileditcvJIvjMxFJN6fkhFO0Ayd
	 RHxpaKcfcQT3yS/daM9kfRV90TNjzksrjSERAtflri9R6Llp1yuuvsPp6uVmgo6cC9
	 oDwf27RiNstwIMmS3A4eFBfcawcbyOWYRDw2xCe8=
Date: Mon, 12 Aug 2024 17:11:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 6.10.y 0/5] Backport of "mptcp: pm: don't try to create
 sf if alloc failed" and more
Message-ID: <2024081207-countless-sterling-42c3@gregkh>
References: <2024081244-smock-nearest-c09a@gregkh>
 <20240812150213.489098-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812150213.489098-7-matttbe@kernel.org>

On Mon, Aug 12, 2024 at 05:02:14PM +0200, Matthieu Baerts (NGI0) wrote:
> Patches "mptcp: pm: don't try to create sf if alloc failed" and "mptcp:
> pm: do not ignore 'subflow' if 'signal' flag is also set" depend on
> "mptcp: pm: reduce indentation blocks", a simple refactoring that can be
> picked to ease the backports. Including this patch avoids conflicts with
> the two other patches.
> 
> While at it, also picked the modifications of the selftests to validate
> the other modifications.
> 
> If you prefer, feel free to backport these 5 commits to v6.10:
> 
>   c95eb32ced82 cd7c957f936f 85df533a787b bec1f3b119eb 4d2868b5d191
> 
> In this order, and thanks to c95eb32ced82, there are no conflicts.

All now queued up, thanks!

greg k-h
