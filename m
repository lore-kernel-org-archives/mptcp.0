Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F2AD5A
	for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005663; cv=none; b=ubV+QrPIoelXaCFk25QF8fODG6j8f56nTS8LTOyyhzBEiysg59r6dgA+dyPtXbn/HEqSq/YX5Es1DFmBeE3vyf59PayftNJmiOVH86ne02XKjWMacF5eX7iZkiMhmi2MMO3bIreKAagZJL1YreRtDYRFuMJVBuzqVXdWwlAhsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005663; c=relaxed/simple;
	bh=PjPKATxwrZDeXpazaMvdwHiDwoCuLUdUuK7qgZvz4Ug=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OMudILNiHv4OvxI5woiNv1DWPHu7+FSBdb7lsDPrK0mk2AWp3FHqqY+tHRwk9qgOVbk/ZGlJD02SGzUAA7Io1JlGJGq2/t/cU5vXUtv74Ru/3dzKi02YnlO0N62SHwlxg6f3dMlrlEZ0aEe+nea34vDwVSqEfakS3Sk5dl0Otxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odsElAn+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odsElAn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A05C4CEFB;
	Tue, 21 Oct 2025 00:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761005663;
	bh=PjPKATxwrZDeXpazaMvdwHiDwoCuLUdUuK7qgZvz4Ug=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=odsElAn+LILYkomjztevv5vTnH8/2wFi4j2ALTAshw0cwRRhlobfQ+tn64UPZmU2/
	 i2UnY8CH2PIu6yFxAXerbJrhGpYjXss2heCk+8s30UNZvWYt0ojE0jihagtrcfR+Se
	 nUYSHoMUGwihhWoxrsmGNpOuMlbtw7jrEsrjJ8vG4vIom9FKe+TQNLweZ4ErIeX81G
	 gixLEHlUOKMXJIuj6X3MaeT6zkDp2uz+eSXLLLWPci1yQZtXUHpb53OHLJVFJZ6fQx
	 5bqv4FdFQ53IvsW4wfpcC8KFnUnSax/fFpBW4Gyh3OcRhmL3uEl2oeCMZuo4VbrB1c
	 hGyjA/5i+7dNg==
Date: Mon, 20 Oct 2025 17:14:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, geliang@kernel.org
Subject: Re: [PATCH mptcp-net 2/2] mptcp: zero window probe mib
In-Reply-To: <1873f5bcb2958cc2366664e46d22c18c410748b6.1760976334.git.pabeni@redhat.com>
Message-ID: <81364c99-566f-4322-0503-92a33e9fb218@kernel.org>
References: <cover.1760976334.git.pabeni@redhat.com> <1873f5bcb2958cc2366664e46d22c18c410748b6.1760976334.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 20 Oct 2025, Paolo Abeni wrote:

> Explicitly account for MPTCP-level zero windows probe, to catch
> hopefully earlier issues alike the one addressed by the previous
> patch.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Helpful metric to track, looks good.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/mib.c      | 1 +
> net/mptcp/mib.h      | 1 +
> net/mptcp/protocol.c | 1 +
> 3 files changed, 3 insertions(+)
>
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 6003e47c770a7c..eb4645a9c5ac07 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -85,6 +85,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
> 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
> 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
> 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
> +	SNMP_MIB_ITEM("MPTcpWinProbe", MPTCP_MIB_MPTCPWINPROBE),
> };
>
> /* mptcp_mib_alloc - allocate percpu mib counters
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 309bac6fea3252..f83a113700522e 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -88,6 +88,7 @@ enum linux_mptcp_mib_field {
> 	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
> 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
> 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
> +	MPTCP_MIB_MPTCPWINPROBE,	/* MPTCP-level zero window probe */
> 	__MPTCP_MIB_MAX
> };
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fe029359b7d7a2..67919ae774cc40 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1396,6 +1396,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 		 mpext->dsn64);
>
> 	if (zero_window_probe) {
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPTCPWINPROBE);
> 		mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
> 		mpext->frozen = 1;
> 		if (READ_ONCE(msk->csum_enabled))
> -- 
> 2.51.0
>
>
>
