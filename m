Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48142313527
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666914; cv=none; b=L7valZxb8R+7NEnbtOPteNCBrP7khpwca5E5jk/oX4qmmLN6FKyCrcus2MBf6DwOsYMO4cdT3xmYB70sJJ6WmQeQAFq1NVDhT556aNVnCLo3i7trPF33PXkWyZgo7+XEHdVq2rqZGgR3C3KjuWpJoNNnevzOTlkBu/0hS8W5Eq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666914; c=relaxed/simple;
	bh=NdcrS/aZ/3S3Lwz/Bf974DEfo1V/VG6SVUX9CVuoPhg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AqScyYNayIbwOgUx3zWweRPZVwigkt8DY+XUNq59EvT6dbaxqD9ViTUIMkDabexEZMfrF3R5grknvM0icHjTuTgyNYj7KOlmdXm1sHO2qfq3083B1sbAecAvDfAtOmgATwsfSWDJc6ePcdlo7Kh22DZqRL8hHPlSr2Gdbu+HMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pl33CANi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pl33CANi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43BCC4CEF5;
	Tue, 23 Sep 2025 22:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666913;
	bh=NdcrS/aZ/3S3Lwz/Bf974DEfo1V/VG6SVUX9CVuoPhg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pl33CANiO2sujHMRzkMH8whnWLbAbUi7Pb5Wnt+ZAUS6ri05e79SDJ68HC8/5j7uB
	 9ulWfdqQPxg1M/B9bNM5TnE6CwYXHVcuP5TzBY+hjHrTfpl4+vwsbPIgnr69n/Xr71
	 2p25y0YF4lU+4CuqUadp8IV8nZkC865B4Wk/TDpUfB2OglG3vqfQc/X3Fpwd29PS2/
	 HRMltDIqPCfMHZKntIKEB5E8eqZJjEC1EkuIh2xtsUdXJLjpqaj0/+aUAIko1TYEfs
	 mefMxH/nABVowygLY2gptq3aPTVX5Mrd5d4wdrLraIxDIwTN0TA5xQkExSCJAQ4uVN
	 Ukfy37N7kZ2VQ==
Date: Tue, 23 Sep 2025 15:35:13 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v2 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
Message-ID: <ebe7ccc4-70fd-41e5-80e1-12fbdc345adf@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 23 Sep 2025, Matthieu Baerts (NGI0) wrote:

> Currently, upon the reception of an ADD_ADDR (and when the fullmesh flag
> is not used), the in-kernel PM will create new subflows using the local
> address the routing configuration will pick.
>
> It would be easier to pick local addresses from a selected list of
> endpoints, and use it only once, than relying on routing rules.
>
> Use case: both the client (C) and the server (S) have two addresses (a
> and b). The client establishes the connection between C(a) and S(a).
> Once established, the server announces its additional address S(b). Once
> received, the client connects to it using its second address C(b).
> Compared to a situation without the 'address' endpoint for C(b), the
> client didn't use this address C(b) to establish a subflow to the
> server's primary address S(a). So at the end, we have:
>
>   C        S
>  C(a) --- S(a)
>  C(b) --- S(b)
>
> In case of a 3rd address on each side (C(c) and S(c)), upon the
> reception of an ADD_ADDR with S(c), the client should not pick C(b)
> because it has already been used. C(c) should then be used.
>
> Note that this situation is currently possible if C doesn't add any
> endpoint, but configure the routing in order to pick C(b) for the route
> to S(b), and pick C(c) for the route to S(c). That doesn't sound very
> practical because it means knowing in advance the IP addresses that
> will be used and announced by the server.
>
> Patches 1 & 2: some clean-ups and refactoring.
>
> Patch 3: "standardisation" and small perf improvement.
>
> Patch 4: squash to patches for a commit queued for net-next.
>

Hi Matthieu -

Patches 1-4 look good for mptcp-next:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Patch 5: new 'address' endpoints.
>
> Patch 6: validation using selftests.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - patch 3: rename helper, move where it is called, comments (Mat)
> - patch 5: rename var and function (Mat)
> - Link to v1: https://lore.kernel.org/r/20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (6):
>      mptcp: pm: in-kernel: remove stale_loss_cnt
>      mptcp: pm: in-kernel: reduce pernet struct size
>      mptcp: pm: in-kernel: compare IDs instead of addresses
>      Squash to "mptcp: pm: in-kernel: usable client side with C-flag"
>      mptcp: pm: in-kernel: add 'address' endpoints
>      selftests: mptcp: join: validate new 'address' endpoints
>
> include/uapi/linux/mptcp.h                      |   6 +-
> net/mptcp/pm_kernel.c                           | 229 ++++++++++++++++--------
> net/mptcp/protocol.h                            |   9 +-
> net/mptcp/sockopt.c                             |   2 +
> tools/testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   9 +
> 6 files changed, 230 insertions(+), 81 deletions(-)
> ---
> base-commit: 77807b94c731081ef3d97e96dabcea7aae2bfe15
> change-id: 20250918-pm-kern-endp-add_addr-new-a20893e45389
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
