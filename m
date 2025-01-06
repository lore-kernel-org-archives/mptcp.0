Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B81D88D1
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151895; cv=none; b=HaKWFbewWAwdjUw/E/uUuqvLemGGPqGXbz7sbN8xYcW42sSxhfs9owSPozGFqm4yCa6S7J78HpIs+/4sSsiRKY3n0H+8HdTLsQjtxDJY2qlYJgVCrApSP5peuFPF02dUcNj0joYVvwo6GZ6W7P5mgtosR3LmY77bKIvvhbktosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151895; c=relaxed/simple;
	bh=3oavDKx58mk1f6DlCb8+QHVIhujcNM1o6VnzdlDbn4o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQIS059wrwP7bJqDm1yhb1j5qUO51aGgbiGCDrpOnqwqLNYVYP+SUqH/UAPvID/Ms+wa8+AOHGIAxiNXQ7s5m+7/xKrliY9NzrWrgs8UjHI/SF8kGrjTCpO9qmCgKEn42NwUPjpPZ0yWYTxUJ6T7GFwv4EWfJWlV7FFrIX2c5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDlEI7Om; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDlEI7Om"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D37C4CEE0;
	Mon,  6 Jan 2025 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151894;
	bh=3oavDKx58mk1f6DlCb8+QHVIhujcNM1o6VnzdlDbn4o=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=HDlEI7OmiFeLbCsebXK4vWjIe4GdZosJFJFEL8DTBsQ6DstOEEvZjFNg8a9sWkJQ5
	 Fltdf2Q5JgMmA3+DIDw5mplltKqmh5ZxPAPIKktKEDZ5KJvM/6mwVoolTUTeV/hBEJ
	 XS+EeTw8nciQ6D3igeoSAJdgOPbZAd4WeoXkQoWHvDlrAFex+Zrf/L4bgimpBiMTjf
	 J/aXtTPsq3Mb/FPCA8FkOqTYt6PcnT3HF+PEdxOhU+iyKqeauICwtO0yi49JKUI6hD
	 Mf5dE2twli95OodKBOGP4PuMiBQdIwPsPjcgSdGP4xE+5d8DG3qk4y9XvLihT0SIJd
	 l3ZdJ9pDy6dYA==
Message-ID: <9e1c9742e62870dd76449299c10b99ec9b85a9f5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/7] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 06 Jan 2025 16:24:50 +0800
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this new version.

On Mon, 2024-12-30 at 14:24 +0100, Matthieu Baerts (NGI0) wrote:
> This is a newer version of the series started by Geliang, now making
> them more uniform on how the NL errors are set, and giving more hints
> to
> the userspace about what's wrong.

This series is useful, but it conflicts with "BPF path manager" series
under review, especially with set_flags() interface. So I also added
the patches to update set_flags interface into v7.

> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Geliang Tang (1):
>       mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
> 
> Matthieu Baerts (NGI0) (6):
>       mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
>       mptcp: pm: more precise error messages
>       mptcp: pm: improve error messages
>       mptcp: pm: userspace: flags: clearer msg if no remote addr
>       mptcp: pm: remove duplicated error messages
>       mptcp: pm: mark missing address attributes
> 
>  net/mptcp/pm_netlink.c   |  50 +++++++++++-----
>  net/mptcp/pm_userspace.c | 144 ++++++++++++++++++++++++++++---------
> ----------
>  2 files changed, 121 insertions(+), 73 deletions(-)
> ---
> base-commit: f770d70d123db1907d419f715117245d7060816b
> change-id: 20241228-genl_req_attr_check-2accaa49f84f
> 
> Best regards,

