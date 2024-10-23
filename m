Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25C4A32
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 00:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642627; cv=none; b=qKb7anGYA8G7sGz6RT09d/88jDgaf/Ma/VrzC2znGeCTEdOlf6pnWptVMjQ6lZOx7FNzrpLZzDSFC7t7GCcb0Gl4xANq2QVm1+VRRhJQ2fV5PU4BnBwJUgGR3NYjEVRrCRHCH7N5YAMH1ADeLK947UBioPn90Pcum1C65YzXBBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642627; c=relaxed/simple;
	bh=ZMvpJNvNE/LgeS0ZIfibBAWuUyiYfKzb3jc75kADiuQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H4GYklHj7lI0qvA4u4Lw9OJoS8AjjS2d/zrMA3TklkZXMfKWEj4lJyOYHsh4dGL2Y7GOgbNMlGxSVWX+zautht319pFz5HP1rVZF9rkix5amkHdULaFGtmPGatRKCohnPkE8J5FHIU1ddW/ENPsa8N8hA+WAb1okYxnHb/Fp/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru07TIzv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru07TIzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BF4C4CEC3;
	Wed, 23 Oct 2024 00:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729642627;
	bh=ZMvpJNvNE/LgeS0ZIfibBAWuUyiYfKzb3jc75kADiuQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ru07TIzveag9iMXKS2k/UD+xL1F3wzXazHDalpqEOul8yA/Dqo8dRjR+f/RFcb+6F
	 uJIY8ibi0n+B0JQQker2V+roxdNhaQ1HpCF+Zp5GeJ2ZD6lr2O/ZEcbOq7H3u+PJ3N
	 GP0NeFkbe/NF2Uvp/gLcPQTe24cnJlvAf+eZd/WRimu0qiY8DWMtcwxSFQpDpIy+0z
	 hIyrB8q06SlvCI2r/55B3AB/+K1lVbVewSLknFo+5YhrPuD9bTxWktpM0DRoE3IYp3
	 af7+UNaHsQ7pjDJNwJnsVpAchCPWkMXjFL/3Yjei6PB60YBVTiQpj16dbdOUGP9Kde
	 fNyidricSF+AQ==
Date: Tue, 22 Oct 2024 17:17:06 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: no admin perm to list endpoints
In-Reply-To: <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
Message-ID: <bcc3660e-8978-1163-fc68-9e707bb5ebe0@kernel.org>
References: <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 22 Oct 2024, Matthieu Baerts (NGI0) wrote:

> During the switch to YNL, the command to list all endpoints has been
> accidentally restricted to users with admin permissions.
>
> It looks like there are no reasons to have this restriction which makes
> it harder for a user to quickly check if the endpoint list has been
> correctly populated by an automated tool. Best to go back to the
> previous behaviour then.
>
> mptcp_pm_gen.c has been modified using ynl-gen-c.py:
>
>   $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
>     --spec Documentation/netlink/specs/mptcp_pm.yaml --source \
>     -o net/mptcp/mptcp_pm_gen.c
>
> The header file doesn't need to be regenerated.
>
> Fixes: 1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> Documentation/netlink/specs/mptcp_pm.yaml | 1 -
> net/mptcp/mptcp_pm_gen.c                  | 1 -
> 2 files changed, 2 deletions(-)
>
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index 30d8342cacc8704c42b84c9e03f96c906e81733e..dc190bf838fec6add28b61e5e2cac8dee601b012 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -293,7 +293,6 @@ operations:
>       doc: Get endpoint information
>       attribute-set: attr
>       dont-validate: [ strict ]
> -      flags: [ uns-admin-perm ]
>       do: &get-addr-attrs
>         request:
>           attributes:
> diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
> index c30a2a90a19252dd41a74109d5762a091129269d..bfb37c5a88c4ef90740699dfda345b52e206966b 100644
> --- a/net/mptcp/mptcp_pm_gen.c
> +++ b/net/mptcp/mptcp_pm_gen.c
> @@ -112,7 +112,6 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
> 		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
> 		.policy		= mptcp_pm_get_addr_nl_policy,
> 		.maxattr	= MPTCP_PM_ATTR_TOKEN,
> -		.flags		= GENL_UNS_ADMIN_PERM,
> 	},
> 	{
> 		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,
>
> ---
> base-commit: 66bee427d4db76bd1afbf0184a2fd1f238a4ee27
> change-id: 20241022-mptcp-pm-dump-addr-admin-0b226758e9f5
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
