Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6A54F81
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 00:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131151; cv=none; b=Ibv9Z0evsLgy8hkWghPpju3CGF9CXsTMdXyHadvgthsAgI5v4qmo6kpB5bv7DV6cDjvbd4xLy1CoLI+fXWbwY13Vny2SLZ59F3p40GAyh26JG9ZgA4T/bhJkrxuGUfjF9+vU7/6Kwoj3qrPRZmmQvE1fvDDSgu9T0hePWe5ymW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131151; c=relaxed/simple;
	bh=5LxG/Lu6ZpHoEferls+icEU/xYvgDcjzjWQJfSG06dw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uvaSSutHlByfcMVL7RjhLITgzSU1dbMzxWxRCEzvUS3swR1ipm4ZP+UqwV76CeMkEfIBF/FFldUnRFJv60zaieLqvnl76vVXoyZqa+G6wGufFzDjhIHJoLawCLfNwclBvcGKqEMScEfHItRexHq06645jO6AldeZQi38Ji8QFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5FtMIf6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5FtMIf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078C0C4CEEB;
	Thu, 14 Aug 2025 00:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755131151;
	bh=5LxG/Lu6ZpHoEferls+icEU/xYvgDcjzjWQJfSG06dw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Q5FtMIf6hgWPVSh6+6curwVr5WpZmV5cSGvr/ZOdDWzHUaqsUTgUU+ks2eKQWd9SF
	 UP1H6tjfVlSfHMaqpueBRxIX+Lo2Sv+AyWUdABQDem3cDSEtJNiI0CipqkBf4/DcxH
	 7y9udPCE3eA0l/Q1Aqlw7e+ES0fDXo9rvzPDcsXHus63JZaUwfpX61rcYjrJWnOrX8
	 EvBxkhaMPrBKD3Byd2GRaiYmkNaDtPm5BWzAYjjl8SJvj2gHRiSJk251EmYkDUjzaB
	 R40tW/xsgbClep8IReUF7X7XdT88KlDKlw4YimJpdjobW6SHO6rdnvwfQCa39dJYpN
	 HEddsciUQ3w1w==
Date: Wed, 13 Aug 2025 17:25:50 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Thomas Dreibholz <dreibh@simula.no>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: pm: kernel: flush: do not reset
 ADD_ADDR limit
In-Reply-To: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
Message-ID: <89bfba12-6c8d-d873-6390-905e5c5da63a@kernel.org>
References: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 6 Aug 2025, Matthieu Baerts (NGI0) wrote:

> A flush of the MPTCP endpoints should not affect the MPTCP limits. In
> other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
> limits'.
>
> But it was the case. Patch 1 fixes the issue, and Patch 2 modified
> pm_netlink.sh selftest to validate the modification on the kernel side.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (2):
>      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
>      selftests: mptcp: pm: check flush doesn't reset limits
>
> net/mptcp/pm_kernel.c                           | 1 -
> tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
> 2 files changed, 1 insertion(+), 1 deletion(-)
> ---
> base-commit: 8353c34f924e5fb87e86e5587e15df160add9a44
> change-id: 20250806-mptcp-pm-flush-limit-c5a2d74fc2ea
>

Series LGTM, thanks Matthieu!

Reviewed-by: Mat Martineau <martineau@kernel.org>


