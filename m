Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60C191
	for <mptcp@lists.linux.dev>; Sun,  5 May 2024 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714867788; cv=none; b=HGsWrxiZLDg4Qu0gfr8viL0PkGX33ZV6cK63TEtH6ps2Sa0/ESkDwXf6CgWdmVnc8W7wu5BYjPtyVTfm4Le013GZgQTHr+iXEPRnPJAzDcDyj8ecid6qMiUeNUGOyrhIGWbSSLvBg7MFveI/NJReCSUlfMs8w+2vdnZveFvhWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714867788; c=relaxed/simple;
	bh=21XKS0HHvtP0NoFjnBSoC8sTkSgRoiPJ4qTxporDQsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8C5P3u/R/EBsReh9cwjKXg5c557yJcDMa640/Dh15oDTurwIlYeCxWUjc75C5eM3UA7TzZ0PYUKtT9UfY5pWwX8Tx1pCTI/fCcokcBdFgdZ2xmSnWgLpiqPTG8GmgX/OcKvm+suEee0RErGKO0VfzTpykmOhHjV5g5YjtCIWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K23FdeOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K23FdeOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1728DC072AA;
	Sun,  5 May 2024 00:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714867787;
	bh=21XKS0HHvtP0NoFjnBSoC8sTkSgRoiPJ4qTxporDQsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K23FdeOwmINi5I1Kujx0jlDw4WGEmd/wawqQ7XLIAXMCVMxq8HnslVxRKU+aq1TRP
	 uyYjtUcJBevXlu6Xsqo1Z+1UuBfOIirE61atsg6ZK7H/ERkCyoFWC5647Py7A3flkM
	 1/1vMy1ESfJQwCcJfPR8IvUKhOXn9gNs1sKl/vcxpwy+Ra/bMQa3EQQ0lZ7ul/5PlY
	 XvxVqCn+VlXgaPS747Ck3Dfj7+BcUt7Bis7VVN88GV+8PzZGfnod6GAuCVEJk6Ne0H
	 MZaZbek6CqLPMyQUnL6KjY6shcxlowLzZ8JTptHzCxv4r8a3WE3Btu/ZanpGs085MN
	 hk+yKax0o4KAg==
Date: Sun, 5 May 2024 08:09:42 +0800
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] mptcp: Spring cleaning
Message-ID: <ZjbORgdQzABhzrzi@T480>
References: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>

Hi Matt,

On Thu, May 02, 2024 at 07:23:03PM +0200, Matthieu Baerts (NGI0) wrote:
> This series fixes some warnings reported by CheckPatch and CLang.
> 
> The behaviour is not supposed to be modified, just some simple fixes.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This series looks good to me, thanks.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
> Matthieu Baerts (NGI0) (4):
>       mptcp: prefer strscpy over strcpy
>       mptcp: move mptcp_pm_gen.h's include
>       mptcp: remove unnecessary else statements
>       mptcp: include inet_common in mib.h
> 
>  net/mptcp/ctrl.c         |  2 +-
>  net/mptcp/mib.h          |  2 ++
>  net/mptcp/pm_netlink.c   |  1 +
>  net/mptcp/pm_userspace.c |  1 +
>  net/mptcp/protocol.c     |  5 +++--
>  net/mptcp/protocol.h     |  2 --
>  net/mptcp/sockopt.c      |  2 +-
>  net/mptcp/subflow.c      | 32 +++++++++++++++++---------------
>  8 files changed, 26 insertions(+), 21 deletions(-)
> ---
> base-commit: c3c3514169a8e548fba51d0694b86a72f89acce0
> change-id: 20240502-mptcp-cleanup-clang-checkpatch-8eb4a4843ff6
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
