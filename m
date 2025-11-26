Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6B26A0DB
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201278; cv=none; b=ZYB0FzMP0B76Rr9egmp1Hdnvaige6CS6CDsxpVLn/8oX3OapNQ1k3buGuIrBobH7kBqbOlUy5q9nFXBRAsbdy35xWuaNoE+QluuBdu+q5ae10tPICey13LebSilxirFwKjg0njIezfdTz6Kg/3fZIUEYX0I9LxIoJopcQcr9Y/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201278; c=relaxed/simple;
	bh=djbykHuRLpFEWGWGzbVj7r2dB3nkigWtZwrkuVDbhsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ThBt9KR0OqFKZ4zYaV7Zo4x7UIgZoqRDoQgBfBZOk7jRwPVNE0TeHKwLIKPZSK3K/Gr1qkwrx+Ap7RQcoLKJq3UyEKa12UR3L3zX13Uy8bcCuL7RNSgSLWqs4sM7xWmfVFplk/N9YyJPGZjw1qKOuldVQRaAaXhow0tPNHUSgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+wzygQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+wzygQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94FAC4CEF7;
	Wed, 26 Nov 2025 23:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764201278;
	bh=djbykHuRLpFEWGWGzbVj7r2dB3nkigWtZwrkuVDbhsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=P+wzygQ0prouWPJGVLhPwbYyOYGaMsND1hTSkz+iTXB708efDH4Y5QvqvCrExp5IR
	 3iSEdlAcqiL7JIhRMf85bIOX7zYydDxTGynU2n94hjJW+LRx1Z4m4w06UtTQDtf+Sr
	 Kwby6ZY3Ep1S8AYJYfvGwMvuSTOo+pQZbOJi8JerUu8oWg00DehjCaemcEePAW0Kej
	 AHaKiAnTeyQ3TTEh+wzZ5GmMVCYO3PwyKm+z6w7gCbWIpUHJZbektSnoDB9nIE+73z
	 O+cJNMb/mwiwMc4Rvp5xMInKJA8J8CQW5nL97ihsFPkyswbCQ4nX/cAnYSGHurEAKq
	 t3dMD1vmb7arg==
Date: Wed, 26 Nov 2025 15:54:37 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: pm: ignore unknown endpoint flags
In-Reply-To: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
Message-ID: <032f83ca-b331-9e4f-5739-de91b4a3ff00@kernel.org>
References: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 Nov 2025, Matthieu Baerts (NGI0) wrote:

> This is just a simple fix to ignore unknown endpoint flags. Recently, a
> new "laminar" flag has been added. It can be set on older kernel
> versions without effects -- which is good -- but it is strange to report
> it in the endpoints dumps if it is not supported.
>
>  # uname -r
>  6.17.9
>  # ip mptcp endpoint add 1.2.3.4 laminar  # not supported on v6.17
>  # ip mptcp endpoint
>  1.2.3.4 id 1 laminar
>
> Patch 1 fixes that, while Patch 2 validates that.
>
> Patch 3 is for mptcp-next, to correctly follow the specs and accept u32
> flags instead of u8. This doesn't change anything, but avoids
> confusions.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (3):
>      mptcp: pm: ignore unknown endpoint flags
>      selftests: mptcp: pm: ensure unknown flags are ignored
>      mptcp: pm: align endpoint flags size with the NL specs

Hi Matthieu!

All three patches LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

See my comment on patch 2 regarding an additional fourth patch for 
net-next.

Thanks,
Mat


>
> include/uapi/linux/mptcp.h                      |  1 +
> net/mptcp/pm_netlink.c                          |  3 ++-
> net/mptcp/protocol.h                            |  4 ++--
> tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
> 5 files changed, 20 insertions(+), 3 deletions(-)
> ---
> base-commit: 690b1c68fd1e566ffa60fec98e09292cc9f04a3a
> change-id: 20251125-mptcp-pm-kern-drop-unknown-flags-e4ec71df02e7
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
