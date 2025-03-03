Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609511D7E4C
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999066; cv=none; b=O4fY/5XTYM9EY6VAzfl9tU0zUPO/P/Zvnp9LAWhHHqeisxgaJbAvnWrE5DKBXekNjGvh2oZwDLz8yQIifZKNzP4g2QLLr2qiqNToDNDw+wr9zkb2SmV2yMvi8ANqD27wHrxFZPGenpCNYX4KC4Vzvhc0paS8VyeKgHqvvS9l8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999066; c=relaxed/simple;
	bh=viBJYr27Wg++hclyoBAcr+p1DFatJBNlhGd6p/snBXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8lMXaxfivcUaztfcA0GiTGoVTVK84njt1Mm0QsGhkJOex6KukPypCp9c1fdvRmOFbzal7OteLDsww7qEFXdI4niEYAGMW76lwJkoBIfnQFbFB0+vjWveInhzwoDbuUcshXOseZ7bKeMm4uh0BldHqwnJuMsn4p22EhDGR5MUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYlg24Gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYlg24Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E637C4CED6;
	Mon,  3 Mar 2025 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740999065;
	bh=viBJYr27Wg++hclyoBAcr+p1DFatJBNlhGd6p/snBXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CYlg24Gpy0vUwbBMdIX8sGiNHWnnVM5UQHhhlyxacx7U3P1AjFocUDYnv2Ve1ztZs
	 0yYnmy2TaoIeGEeAjn9fgLkBA/tgY0iKae0Nu72UyAsMK6Sq0CqyyiWIdjmtCTxFNA
	 drixmbAFB7tHPO6jORmL+BzcoRPqdZ0bOYYmTkOjYfxYF57sKMgLKj7WaGqY3Pv0Vs
	 0K2C1unM9Kjtqq5d1WkaTUlRvA0VFfNkZEFcUvtgD2AkLIAs/x2brmtrjLnNXP9NTx
	 fFvtIigd03dOXtadzrOUGjYh0N1TdpnSLHE89jXYCFyBqyU777axLNkylEnjFTsBUA
	 Hp1c/wNT53miQ==
Message-ID: <cefcf810-3793-494d-8cc1-d4d093331bcc@kernel.org>
Date: Mon, 3 Mar 2025 11:51:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 13/14] mptcp: pm: split in-kernel PM
 specific code
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
 <20250228-mptcp-pm-reorg-code-v2-13-fa8b2542b7a5@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-13-fa8b2542b7a5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 28/02/2025 14:31, Matthieu Baerts (NGI0) wrote:
> Before this patch, the PM code was dispersed in different places:
> 
> - pm.c had common code for all PMs
> 
> - pm_netlink.c was supposed to be about the in-kernel PM, but also had
>   exported common Netlink helpers, NL events for PM userspace daemons,
>   etc. quite confusing.
> 
> To clarify the code, a reorganisation is suggested here, only by moving
> code around to avoid confusions:
> 
> - pm_netlink.c now only contains common PM Netlink code:
>   - PM events: this code was already there
>   - shared helpers around Netlink code that were already there as well
>   - more shared Netlink commands code from pm.c will come after
(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e4abb94e8c0bd42533500587f5f6e88038b2db62..530b2362a5a35c5ef44d3bf495c8103bdfa08cff 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> -void __init mptcp_pm_nl_init(void)
> -{
> -	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
> -		panic("Failed to register MPTCP PM pernet subsystem.\n");
> -
> -	if (genl_register_family(&mptcp_genl_family))
> -		panic("Failed to register MPTCP PM netlink family\n");

I think it would make more sense to keep the mptcp_genl_family
registration here in pm_netlink.c.

I can do the modification when applying the patches.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

