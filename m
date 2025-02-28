Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27681494DF
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713243; cv=none; b=knxUrwKJVGn7EYF2QmuIpUkdePOiXxNd0hI6jR+576pyX54PbAEW+xcsck8mHDGTI7MD7ThozVGe7ZX6Q1zlsaDFqDnwPk42KTJdcFVPrkmXF8z8ScaBtjeTfMtgA5/0XstxgGJbEzSdPTGtOuy6pqdIXSeUIhahfk732FvVxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713243; c=relaxed/simple;
	bh=qHSVe8H6JEQvQxNGbT/3mHK8prXER+2GqiUyNlzu9JI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOrm/kEG0/9MH7mtIF+gNFOZVtzDVVCB2pbosNs/+DUmXjfmEcOqFGcgQg4i2IlhzmKCqFbAz1tyio64mtwEj+egsv3trknA5o+GXQ02n2kq1M+Sa37iv7hSVWCUVleSHN6iqDo2uSgBU6/JWren/pSmhxCLyh+XFTPo4E3O3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxhnHCtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxhnHCtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97124C4CEDD;
	Fri, 28 Feb 2025 03:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740713242;
	bh=qHSVe8H6JEQvQxNGbT/3mHK8prXER+2GqiUyNlzu9JI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=nxhnHCtLX6nEy3gICq+5E5FfxZCYCm42a0ClM3piaBrqywz6z1IUNHEgH9RMEgB+D
	 3VsAvHOeQqPEcYBEk8zGIgYaH6kHKhno/ArrMzJFDFsLVmjsNuUCNgJTGjKozcSaaM
	 UIXRzN+zSe0RnEF/CrhLMpJn8Y3Z7KDH0f90Ms/YZ/YU0hSnRP4roub2EFj1Qe67qT
	 +qKJ79FSgBl2mwZyGUFg5Pfb/tNNNboCE8SjqOoXvYh6vVZb/6Fx+fAGFlzwe4l4Ht
	 tN1k9Hth5F8apkik84cAazfs+Yp2sEwcGWyQ2n4//pJ81URICpfmKno7GbCXAPFuev
	 Cp4CQTnxjnEJA==
Message-ID: <ec9413f7d72c88231a72e3aebcda847ad15a16d2.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 0/7] mptcp: pm: code reorganisation
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 28 Feb 2025 11:27:18 +0800
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-02-27 at 21:08 +0100, Matthieu Baerts (NGI0) wrote:
> I have been thinking about that during the past couple of months, but
> now, with the recent modifications done by Geliang, and the
> associated
> reviews, I really think it is time to reorganise the code around the
> path-managers to avoid confusions, and a mix of code used in
> different
> conditions.
> 
> Here is a first proposition, feel free to comment! :)
> 
> Please look at the last patch for more details about the why and why
> now.
> 
> I hope this will not cause too many issues with the in-progress
> patches.
> I tried only to move the code around, and minimise the functions
> renaming. Then, to switch to the new code, it might be easier to
> simply
> copy your modified code from the old place to the new one. In other
> words, duplicate the net/mptcp directory, then do a rebase, resolve
> the
> conflicts with 'git restore --ours', then reapply the modifications
> by
> copying your old code to the new place. If it is too difficult,
> please
> let me know.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Geliang Tang <geliang@kernel.org>
> 
> ---
> Matthieu Baerts (NGI0) (7):
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_work
>       mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_or_subflow
>       mptcp: pm: avoid calling PM specific code from core
>       mptcp: pm: worker: split in-kernel and common tasks
>       mptcp: pm: code reorganisation
> 
>  net/mptcp/Makefile       |    2 +-
>  net/mptcp/pm.c           |  685 ++++++++++++----
>  net/mptcp/pm_kernel.c    | 1410 +++++++++++++++++++++++++++++++++
>  net/mptcp/pm_netlink.c   | 1934 ++----------------------------------
> ----------

Patch 7 has too many changes to review, so I suggest splitting it into
multiple small patches for review, and then merging them into a large
patch after review.

I think it is possible to make "move the code from pm_netlink.c to
pm.c" as a separate patch, and "move the code from pm_netlink.c to
pm_kernel.c" as another separate patch. Moreover, these two patches
only involve the movement of code, without any renaming or relocation
of functions, and these changes should be done by separate patches.

In addition, we can try to keep the original positions of the functions
that were originally in pm.c, such as mptcp_pm_addr_families_match,
mptcp_pm_schedule_work, and mptcp_pm_add_addr_send_ack.

WDYT?

Thanks,
-Geliang

>  net/mptcp/pm_userspace.c |   11 +-
>  net/mptcp/protocol.c     |    5 +-
>  net/mptcp/protocol.h     |   37 +-
>  7 files changed, 2051 insertions(+), 2033 deletions(-)
> ---
> base-commit: 6b32949274eb9e32fe867ba9a8f8cb98587ecf36
> change-id: 20250227-mptcp-pm-reorg-code-13227530bd05
> 
> Best regards,

