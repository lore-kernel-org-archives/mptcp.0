Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6942877D9
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201455; cv=none; b=Q56IheSsseJibVE/hl+gZX3XzAz6x9PxKO5WzVFdwU57gWn2t0TG961VLgp+cSJCisnk/WrZQzeFKOY+4mVGUELwj9vfEo+pb5+u6ili8h+jM4uJIpNACmKzmUaoHQdLeXtkejTEJKeHaUQ5E/6cBEf8Bmau2WpiRj/8BEQ3zP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201455; c=relaxed/simple;
	bh=L97wlkj7swc+AzpHvcUIMnLgwZVMrHTWp34eyNwtQNQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nuBamaG8lCjzR6dvC5lnW85+uK4JdiqO4VzVHJyp0CCyMlXLvNzO5prOz1BoO02fdITWu6Ck0odcIQtSJmZkVukSZhviEIdt3jfkqMjmgSdF+2ZQk44oj14dwvv5nNstxDq5s73p4UTlTRLsH5HxZsHpq+KbDpw8eChsDjhys2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8lhAAe5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8lhAAe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC19CC4CEF7;
	Wed, 26 Nov 2025 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764201454;
	bh=L97wlkj7swc+AzpHvcUIMnLgwZVMrHTWp34eyNwtQNQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=X8lhAAe5gB/1VFR1bp/4bAmijiYaXCKeRwhKZhHlpEj25OUYByas0aJpPWZDYFSIp
	 a5K1wjBDMPDqiZZYBSJGAzF7uYwu8/BAarc/7BxATsQYRuGPswQjQp6tHcjhyuDMb7
	 nKNBZwus9RGZQWqrQIUhqnFapp2XVoTXjDnoPfjQ3MvxIT0qd++7rzNRJPzFEjs/2y
	 EVJgA0A43IIIhqJsQgqFV28gOAuu1++9HCBjdSSXfROUoqF+HBNd59uO19yN/8Eqdr
	 KIQVMAEmmul/GcXhoPamJUPmCeNy6Z025cfsXGePErosh4uAQFu3e8uI+kI3SbEMTY
	 sXXJyrQDcAmMg==
Date: Wed, 26 Nov 2025 15:57:34 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net 2/3] selftests: mptcp: pm: ensure unknown flags
 are ignored
In-Reply-To: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-2-d2e4c2ebce0c@kernel.org>
Message-ID: <34dd0312-6eb7-b56d-b7e4-06837bc4c50c@kernel.org>
References: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org> <20251126-mptcp-pm-kern-drop-unknown-flags-v1-2-d2e4c2ebce0c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 Nov 2025, Matthieu Baerts (NGI0) wrote:

> This validates the previous commit: the userspace can set unknown flags
> -- the 7th bit is currently unused -- without errors, but only the
> supported ones are printed in the endpoints dumps.
>
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the selftests,
> but it validates the previous fix for an issue introduced by this commit
> ID.
>
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
> 2 files changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index ec6a87588191..123d9d7a0278 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -192,6 +192,10 @@ check "show_endpoints" \
> flush_endpoint
> check "show_endpoints" "" "flush addrs"
>
> +add_endpoint 10.0.1.1 flags unknown
> +check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" "ignore unknown flags"
> +flush_endpoint
> +
> set_limits 9 1 2>/dev/null
> check "get_limits" "${default_limits}" "rcv addrs above hard limit"
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index 65b374232ff5..99eecccbf0c8 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -24,6 +24,8 @@
> #define IPPROTO_MPTCP 262
> #endif
>
> +#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)

Given the u8->u32 change in patch 3, I can see why this needs to be 7 for 
this patch to be meaningful for -net.

Can you add a patch 4 that updates this to _BITUL(31) to match up with 
the internal flag representation change?

Thanks,
Mat

> +
> static void syntax(char *argv[])
> {
> 	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
> @@ -836,6 +838,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
> 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> 				else if (!strcmp(tok, "fullmesh"))
> 					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
> +				else if (!strcmp(tok, "unknown"))
> +					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
> 				else
> 					error(1, errno,
> 					      "unknown flag %s", argv[arg]);
> @@ -1048,6 +1052,13 @@ static void print_addr(struct rtattr *attrs, int len)
> 					printf(",");
> 			}
>
> +			if (flags & MPTCP_PM_ADDR_FLAG_UNKNOWN) {
> +				printf("unknown");
> +				flags &= ~MPTCP_PM_ADDR_FLAG_UNKNOWN;
> +				if (flags)
> +					printf(",");
> +			}
> +
> 			/* bump unknown flags, if any */
> 			if (flags)
> 				printf("0x%x", flags);
>
> -- 
> 2.51.0
>
>
>
