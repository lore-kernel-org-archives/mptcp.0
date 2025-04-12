Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94F33C9
	for <mptcp@lists.linux.dev>; Sat, 12 Apr 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744416388; cv=none; b=P6UZKraTN1ueMGaOOT7i9sOLJkwSPZnZ3RaYIC9PROpF8v9lbBEw7SHTO2xICAnsOq4ZPC4Vrpi05zxCefiyEY87BCsFwYmU9Nw/uTaWfR3M22KJDEdcjOmQW3xMmjkOhka5yVXI5QtIAUiQlZfqp/hVbDKukwk/NbtDNBYLE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744416388; c=relaxed/simple;
	bh=yd/CmDY9fdeLSfGf3gVpITk5DX7nXm9yM84es5NioJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rGgEinEhTsW/jF2AOw7XPUiQWPPZpsUtCusRz0u338VeH8xvmP4SHDzwmzdOJjEbENHXnIYYnB9QXnQiVqW9E54E/Dtiaq9o6g7GA1kjuu6to2XDeTBjVP4yAiQt04EjFd5X5Qs83+QwWQKmkSMCNo43n6/B4XFfjuW4fbGIBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VacUce+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VacUce+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A1EC4CEE2;
	Sat, 12 Apr 2025 00:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744416387;
	bh=yd/CmDY9fdeLSfGf3gVpITk5DX7nXm9yM84es5NioJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VacUce+s+TrUH4L0lNHsDEvLYltZwS3CW3vY41T2hs/qeaInlhJFk5NnhtwryrJ9V
	 f2WuKDkr7bwJ/6+JeKXMPNubbeoHXbRFzDhgJitWeUAwQTQW7bCy+Hq3voUbfhZJ6B
	 EhmuOpftCtkgJhP9HAtnOpxJt+NX7dwE0f8rlIKuFkBHTJaiLhwvJ9QzuqbRfvArCD
	 oy8f5LWhuH6ZH7hT0YjB3E3vDDCMID1iD8KfuumH0mmVesqdKNxSZ3Q8uKdxZ5PlpP
	 SEvy5BnjF+gUoioBPKAW0xnHKlyAxeclhwy5NrCWeKjMhR7+2SM9YoaQBg+hiNU1CC
	 buTy7dp388bgw==
Date: Fri, 11 Apr 2025 17:06:26 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: info: hide 'grep: write
 error' warnings
In-Reply-To: <20250410-selftests-mptcp-grep-close-v1-1-3c360279a856@kernel.org>
Message-ID: <076393de-9a1f-f5a0-e439-00a35dda4758@kernel.org>
References: <20250410-selftests-mptcp-grep-close-v1-1-3c360279a856@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Apr 2025, Matthieu Baerts (NGI0) wrote:

> mptcp_lib_get_info_value() will only print the first entry that match
> the filter because of the ';q' at the end. As a consequence, the 'sed'
> command could finish before the previous 'grep' one and print a 'write
> error' warning because it is trying to write data to the closed pipe.
>
> Such warnings are not interesting, they can be hidden by muting stderr
> here for grep.
>
> While at it, clearly indicate that mptcp_lib_get_info_value() will only
> print the first matched entry to avoid confusions later on.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Hi Matthieu -

Looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> tools/testing/selftests/net/mptcp/mptcp_lib.sh | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 051e289d79676c5feb9f46da67a08116548f4b47..99c87cd6e25563e220263c813223206ef6f4b311 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -331,12 +331,15 @@ mptcp_lib_result_print_all_tap() {
>
> # get the value of keyword $1 in the line marked by keyword $2
> mptcp_lib_get_info_value() {
> -	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
> +	grep "${2}" 2>/dev/null |
> +		sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
> +		# the ';q' at the end limits to the first matched entry.
> }
>
> # $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
> mptcp_lib_evts_get_info() {
> -	grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
> +	grep "${4:-}" "${2}" 2>/dev/null |
> +		mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
> }
>
> # $1: PID
>
> ---
> base-commit: 244c301d3de6bf2e1bdc5cf7291159cd8e342942
> change-id: 20250410-selftests-mptcp-grep-close-9e4ac9b41a94
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
