Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A341B94D
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505282; cv=none; b=IsKDsU42NirArtsW89a+z7I8jduvsKK1WHyJJUtQ27j7v810bYR5ZakGBb30rljgi86wGIqmG39Ue90CZ8BAbopJT8cRqmV7NkpabTZvlK3Lx7+Ky2s/4BtvCfrmM+fBYt8vGljrmf+bQStL0e6Y5nNoQm19VLTzMmlqMKvtmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505282; c=relaxed/simple;
	bh=dElndWUbHPmtz5AIQJN2BYDG1nIdGz1pf9jYyIBg3D4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WrytSBr0Uxkqv6knisj0TPLJrX/4LIoWXhMXLtShiWzYwLsGDvD7Jec5HMShv/XdWXJ8DuQeKeEvdDliNS/26Cb/qnUtLaO3iCdVTHp/by1GB5+HY3uRa8YYzKqMc768EFm16IYuc1vHSZFVsOgCbp5JMOizzd334XZ8FHneWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj3KPUNO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj3KPUNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F554C433F1;
	Wed, 27 Mar 2024 02:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711505282;
	bh=dElndWUbHPmtz5AIQJN2BYDG1nIdGz1pf9jYyIBg3D4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oj3KPUNOP2A6KLKDGH9dSilEvrJskmUvWYGHIGjztuZ1jr5hhhCByQhQidVG1mjeA
	 Q7Wqj/UXVMwotF/BzH/B4dwwRrdh4zREICsYAMctBDMdFlR1fX8/4KdtfcN8s/rdqm
	 YTlnMtcxBDVNXL8wsZG7rH7urZtOVGuQDS2NsyNRVfTYRPgPoLlEPWI5749Rngby/u
	 lyfHwpqmjrO0u3zzhdqaqBExQW+7pL58vyPBRU6AuB7/mZauHK+GLU8cwjicFveSuh
	 mSAne2TNGohjSNEZKI8dkkTFikS+Jf/lEH945yeC5jQ+JidyFxFKL55ngT9Z0nLaig
	 Of422qJ05t4hg==
Date: Tue, 26 Mar 2024 19:08:01 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: add last time fields in
 mptcp_info
In-Reply-To: <a5e9b583f1f763a472ab24379ec606f0cd28d0c2.1710748923.git.tanggeliang@kylinos.cn>
Message-ID: <b3d76fef-5f3f-cca1-494b-1e6fc2c7a485@kernel.org>
References: <cover.1710748923.git.tanggeliang@kylinos.cn> <a5e9b583f1f763a472ab24379ec606f0cd28d0c2.1710748923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 18 Mar 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_recv
> exposed with TCP, this patch exposes the last time "an action happened" for
> MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv and
> mptcpi_last_ack_recv, calculated In mptcp_diag_fill_info() as the time
> deltas between now and the newly added last time fields in mptcp_sock.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> include/uapi/linux/mptcp.h | 3 +++
> net/mptcp/sockopt.c        | 5 +++++
> 2 files changed, 8 insertions(+)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 74cfe496891e..7126563542b3 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -58,6 +58,9 @@ struct mptcp_info {
> 	__u64	mptcpi_bytes_received;
> 	__u64	mptcpi_bytes_acked;
> 	__u8	mptcpi_subflows_total;

Hi Geliang -

Should add three reserved bytes after mptcpi_subflows_total, otherwise we 
lose them to alignment. See other uapi header files with "reserved", 
"reserved2", etc.

- Mat

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
> 	unlock_sock_fast(sk, slow);
> }
> EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
> -- 
> 2.40.1
>
>
>
