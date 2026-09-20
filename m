Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B2283142;
	Sun, 20 Sep 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909854; cv=none; b=g7k+gc8Nt8M4kS3ceyOd0tudUb4SMMbtFk3sSALWO1eq81Ik6dFGkGMK8lJTWcN16z64wmxLNObCxfTASZYe5B7z6OBCdI+8SnMbCFHSmvV2X7omRMW95rsk4mXXoAujE9II8VlJ2Qz6BfLtSTZm6usgE73SwC+qneheIeJ7w6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909854; c=relaxed/simple;
	bh=neSMIAcBkCTJzjQEqnxQGyOx53XujLrC/UeWsykPT04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIUP6kYQh/wkkf1gY5nzKnDzN/KqrFxVBZMf6TvQ8DJoNpTaef95qvMjO4WXtLliDdL9mGNlmDQIHM+PaDnY/D3hLkJ6mjdxkaT18mz4sR4hial2nC66gQSzYETTHpKhS9loNwgLoe81HkjPUPB8Yiqa9z2kmqda/EHKWeusRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LPOzzS7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPOzzS7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302771F000FF;
	Sun, 20 Sep 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789909847;
	bh=bDoCChAhdF9K6ioGHOLDHkrSm/Nef9TgJuvucnLPSsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPOzzS7X9I2ESGXxmIUd9+eULHcdFf+/d29UIf+C+gMfAHkXTNiN2yIocVaZbMyK1
	 WslT3Hl6pEA1XCd2Ox4wjJ66cTbSqCPzjcBixqPd0+FRQ+guwhPtzuGAppnQBGjuM7
	 DHilLqaW5MPoVBq5v736kr9OJpfUJJrfbRn9+tPY=
Date: Sun, 20 Sep 2026 15:10:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, mptcp@lists.linux.dev
Subject: Re: Patch "mptcp: annotate data-races around
 subflow->fully_established" has been added to the 6.12-stable tree
Message-ID: <2026092026-throwback-iron-bdce@gregkh>
References: <2026092037-islamic-default-0aca@gregkh>
 <20260920074855.D7DFF1F000FF@smtp.kernel.org>
 <3b729163-10e6-44ad-bcde-24da5e8a11c1@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b729163-10e6-44ad-bcde-24da5e8a11c1@kernel.org>

On Sun, Sep 20, 2026 at 11:33:47AM +0200, Matthieu Baerts wrote:
> Hello,
> 
> On 20/09/2026 09:48, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] mptcp: build failure due to READ_ONCE() on bit-field
> 
> Mmh, I missed the fact this commit has already been backported in commit
> 477aa7116a76 ("mptcp: annotate data-races around subflow
> ->fully_established"), but mostly reverted by caa4a79f74f3 ("mptcp:
> remove unneeded READ_ONCE() annotation").
> 
> I don't know what's better here: either we leave it like that, and I can
> fix the size of the bit-field. Or we drop patch 1 and 2, and I resolve
> the small conflict on patch 3/5: commit 2b0f561f21b2 ("mptcp: avoid
> unneeded actions on subflow reset"). I can send a v2, and we can drop it
> if the other solution has been preferred.

Your v2 looks good, thanks for that, I'll go replace the patches with
those.

greg k-h
