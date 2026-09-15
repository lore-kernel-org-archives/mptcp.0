Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96291FB1
	for <mptcp@lists.linux.dev>; Tue, 15 Sep 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452779; cv=none; b=m8+hImvH3voJT3Y1aKYHNOrKOmK/NBqThEQMai67p9rcZrbmnn4wbAtVr1ANNwORgsVq3a5/83Oy2yRGrPT8TfmovWI6WwHuoui2YGsm1Xcde5Hx0UPsTXlLLv122cxqgpcr/+0DQzbxSe17El/IqNUcWgkG/nc7s+DHd0jNP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452779; c=relaxed/simple;
	bh=b8aJeJLFhs+k0gVA+dhH/A1mG3d6/WJDYKTdSxTioXw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4tEtJydZrfJ5mjx85HIOwMR9lb1QyJl9wIashs80jdgcX+0vimnWp8/+WzWysY2Qv77QCsyJDPtpmbIssvXvEohZnKu0mR6Y6azeg1nsdZbarJ9FZKexLujWSsycGaVQwa/biu+pBzrK+YHGbYQFNkx+LCRk3lNGdw4TP9fAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYVzdlAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYVzdlAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68831F00893;
	Tue, 15 Sep 2026 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789452778;
	bh=vMhDN6zgj71eNRcfFSmaUnmVWB3szXErbNyBFNDLbX4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=iYVzdlAuZyZ0xJsa9qcEJdPv9h2kAgY4Cox+WVg8Rgw9TmwHS8+ZoOMBmh8P7Xm3D
	 InoHdNM4sSkFnXo2HotK5o5RaOglhDxr0Z2n2FE2VLQxw/ztde+XywSi+Vih9u4QtV
	 kULCocZ0AgIklluYyyfMIXFq2ul5cd4jlTEMJ7f1xyiMnp4E7t2s0R2ieOFiZgxtYh
	 Co8fLwWIiG9SUI8/V62O/f4iwQkaolYLx7mOHU7433jd66xI/uokXjz9TMBJDVR2oL
	 bOQxsrybYLoaaSaDUotaocfAgodQMt6gEv4T/1+RFcziLBnGF4uXX1CsF0M48R+pKk
	 J97GyrrkfP4gQ==
Message-ID: <adfae8144b8e274753ea15d8798b8c29d4e139d9.camel@kernel.org>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: dump stats with right
 title
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Tue, 15 Sep 2026 14:12:49 +0800
In-Reply-To: <20260914-mptcp-sft-join-typo-ns-stat-v1-1-30d5a5802b57@kernel.org>
References: 
	<20260914-mptcp-sft-join-typo-ns-stat-v1-1-30d5a5802b57@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2026-09-14 at 19:53 +0200, Matthieu Baerts (NGI0) wrote:
> This fixes a typo when dumping stats to print the right netns.
> 
> Indeed, the client netns was hardcoded instead of taking the netns
> given
> in argument. Fixing that to avoid confusions when debugging issues.
> 
> Fixes: 658e53141780 ("selftests: mptcp: join: dump stats from
> history")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b16e24418e73..bec499047e06 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1163,7 +1163,7 @@ _dump_stats()
>  	local ns="${1}"
>  	local side="${2}"
>  
> -	mptcp_lib_print_err "${side} ns stats (${ns2})"
> +	mptcp_lib_print_err "${side} ns stats (${ns})"

Good catch!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

>  	mptcp_lib_pr_nstat "${ns}"
>  	echo
>  }
> 
> ---
> base-commit: 060af37701a3aca2c02cb5e874d740be6acbf1a2
> change-id: 20260914-mptcp-sft-join-typo-ns-stat-4db20f0b7a48
> 
> Best regards,
> --  
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
