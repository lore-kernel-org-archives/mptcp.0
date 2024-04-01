Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07510481C6
	for <mptcp@lists.linux.dev>; Mon,  1 Apr 2024 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994544; cv=none; b=cKsxDzWp73YiZ9dA8+tnmqyzHDcH2ycuhpGQPmxHBEufCjG5dnClHAc1qnpkm54es3TB1K4agvcDVrW5NYa8oHWeCoTlR/gQiMdZF/ivY3WZa9Jqz4G6At5tpgxcH2+RKIlqq7jnP/nzZsVN4Z8mnflbh7L3bWBcFcufXa41EEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994544; c=relaxed/simple;
	bh=z5xhzm7/amuCo8xpg1bUV7Rm6bYAbvIn+6qtyKc7lRI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ox82w3ZnlyHL/M6Mwpp/srd5R4OzAhbr3HBy0I05rC2xjSGMlU+FJ1ZFpMWZXOeRGTcgwoL6OdBzvvoqjlyyNBa3yGWhnCdlVBKofTjcFZ27Sjy5XE9vNE3dCAKdUD6RU5Ca0v0QHTMx2TQZTAKFvhmsuoluYVRAAa7EQ2P6SBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ0Tm8qf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ0Tm8qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8765AC433C7;
	Mon,  1 Apr 2024 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711994543;
	bh=z5xhzm7/amuCo8xpg1bUV7Rm6bYAbvIn+6qtyKc7lRI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KJ0Tm8qfBPPJ19Admi6GdpndIYRM3QmIG5kAqq8BsCkuIZTFXoKUgMoaC4dHqmJg+
	 2NmwBaVSrHEfnQ6Z0IFmJj+OHD6ctje9YKkIalXe92oNay39eBljCQxbCmvTMe+U2a
	 mV21wHrmtons8OFuVIlOC3qqkQIhj586B+VANzOEL47fyr3um/A2BoTOICjxnR7swP
	 /AyA0LiMlshckFuR+M/BajBc9hsWaKQLeYABeSU0N2iI+jt1qQo8eKayPupLkFFJaO
	 tY2sCZM/W+OkBjVoZkultKtA2deiPI0qNdc3SSV4pKplQItyC5PBOoaa2PbmtkUgsu
	 dNFnKrEp9HgsA==
Date: Mon, 1 Apr 2024 11:02:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: add last time fields in
 mptcp_info
In-Reply-To: <cd7e6214f3e6fd6928c674d6759964d111b4f444.1711784619.git.tanggeliang@kylinos.cn>
Message-ID: <7245b23e-0aff-682b-92d7-1370096011c1@kernel.org>
References: <cover.1711784619.git.tanggeliang@kylinos.cn> <cd7e6214f3e6fd6928c674d6759964d111b4f444.1711784619.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Mar 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_recv
> exposed with TCP, this patch exposes the last time "an action happened" for
> MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv and
> mptcpi_last_ack_recv, calculated in mptcp_diag_fill_info() as the time
> deltas between now and the newly added last time fields in mptcp_sock.
>
> Also add three reserved bytes in struct mptcp_info.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> include/uapi/linux/mptcp.h | 4 ++++
> net/mptcp/sockopt.c        | 5 +++++
> 2 files changed, 9 insertions(+)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 74cfe496891e..67d015df8893 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -58,6 +58,10 @@ struct mptcp_info {
> 	__u64	mptcpi_bytes_received;
> 	__u64	mptcpi_bytes_acked;
> 	__u8	mptcpi_subflows_total;
> +	__u8	reserved[3];
> +	__u32	mptcpi_last_data_sent;
> +	__u32	mptcpi_last_data_recv;
> +	__u32	mptcpi_last_ack_recv;
> };
>
> /* MPTCP Reset reason codes, rfc8684 */
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index dcd1c76d2a3b..1e74851614e8 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -898,6 +898,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
> 	struct sock *sk = (struct sock *)msk;
> 	u32 flags = 0;
> 	bool slow;
> +	u32 now;
>
> 	memset(info, 0, sizeof(*info));
>
> @@ -942,6 +943,10 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
> 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
> 	info->mptcpi_subflows_total = info->mptcpi_subflows +
> 		__mptcp_has_initial_subflow(msk);
> +	now = tcp_jiffies32;
> +	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
> +	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
> +	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);

Hi Geliang -

msk->last_ack_recv is protected by mptcp_data_lock, not the msk socket 
lock, so this line should be moved to the data_lock protected section 
earlier in mptcp_diag_fill_info().

Thanks,

Mat

> 	unlock_sock_fast(sk, slow);
> }
> EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
> -- 
> 2.40.1
>
>
>
