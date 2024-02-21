Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748B64B
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477574; cv=none; b=nLgUp1p4Hp1H+OgLNrKXENNwP4LmyFWy+eno64BlyYcJ4hYnnuO7xPU8qjzExvo9OFZz3M73mFN2rzEuWlKnYcwI3TF07G2bTBkt6cYos2GvG3C+V+QWqc0C3h/EemgHNC+2/lxZGWP5ikOxNsb9y5yFwnvuwuUghog7dG/SnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477574; c=relaxed/simple;
	bh=wCFKN6FlMR0Fa4epnoUbw44j1QezlgZ+Xz55q55ET7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOnwqs5nFJnD5yMDEuW3AYYOacZ0B/pOZy6fiSUNkwkgnU6SFALfiiNCuXI7UQL88FSg0uw2OvLMiVv9B267usort3J/ln31woN84gH9u2G5dRPW4XHyAFFq4CQQI9BO2jYxt1ZhiqdRrCfOwDSvvg3rZOyCCRcxng/CnkMw7+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPk6cafL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPk6cafL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27416C433C7;
	Wed, 21 Feb 2024 01:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708477573;
	bh=wCFKN6FlMR0Fa4epnoUbw44j1QezlgZ+Xz55q55ET7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPk6cafLrIf+Jt+WqbJdeyUkTZRs5qc8OoiMP9Q0gflztoIg2Q8MHqTy2XT7bHX3B
	 H6kjPr+OANEhF0vObQJwn8YqxhQDeLnnhDZeqY5kO4l/vzFchGsp4aHP4PBbilrdAg
	 VQjNFzFXlObXhITwLGHdoXd9U9HZVI/NpdchFPsWSr2b1AJc8FauubeaxAPYPREnZB
	 YOGwa8h75OrZs1GDIwpMY78+awzL1hcfG+9F1qvWCG9Ws/IJuOE85rgPkEtsab6Uuj
	 TI5EMONtZUV5NHJhxa2JCkSV0FBfVW0gmjg1iAdna8n1N8V0oZD3zaJavpf1xNRSqn
	 RbXx4a1NZPE8Q==
Date: Wed, 21 Feb 2024 09:06:09 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 00/14] dump for userspace pm
Message-ID: <ZdVMgQEqbhO+e0fY@t480>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
 <682134fb-8893-4ee0-9ddd-c0a4a4f5650b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682134fb-8893-4ee0-9ddd-c0a4a4f5650b@kernel.org>

On Tue, Feb 20, 2024 at 12:50:49PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 20/02/2024 10:58, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v14:
> >  - address Matt's comments in v13.
> 
> Thank you for the new version!
> 
> I didn't look at it yet, but:
> 
> >  - I have to use these lines in patch #8:
> > 
> >       local cmd_ret=0
> >       local out=$(${cmd} 2>${err}) || cmd_ret=${?}
> > 
> >    The following expected code breaks pm_netlink.sh, I don't know why:
> > 
> >       local out cmd_ret=0
> >       out=$(${cmd} 2>${err}) || cmd_ret=${?}
> > 
> >    If this is still a problem, I'll send a squash-to patch to fix it.
> 
> Yes, we should either fix warnings or explicitly mark the false positive
> ones as ignored.
> 
> Can you try with the attached patch please? It is not clear to me why
> the second block doesn't do the same as the first one.

Thanks Matt, the attached patch works well. It fixes the issue I
mentioned perfectly.

> 
> I can squash it when applying the series if there are no other comments.

Great, thanks.

-Geliang

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index aca35376006b..556a7d9784d7 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -352,20 +352,24 @@ mptcp_lib_check_tools() {
>  }
>  
>  mptcp_lib_check_output() {
> -	local err="$1"
> -	local cmd="$2"
> -	local expected="$3"
> +	local err="${1}"
> +	local cmd="${2}"
> +	local expected="${3}"
>  	local cmd_ret=0
> -	local out=$(${cmd} 2>${err}) || cmd_ret=${?}
> +	local out
>  
> -	if [ $cmd_ret -ne 0 ]; then
> -		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr"
> +	if ! out=$(${cmd} 2>"${err}"); then
> +		cmd_ret=${?}
> +	fi
> +
> +	if [ ${cmd_ret} -ne 0 ]; then
> +		mptcp_lib_print_err "[FAIL] command execution '${cmd}' stderr"
>  		cat "${err}"
>  		return 2
> -	elif [ "$out" = "$expected" ]; then
> +	elif [ "${out}" = "${expected}" ]; then
>  		return 0
>  	else
> -		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
> +		mptcp_lib_print_err "[FAIL] expected '${expected}' got '${out}'"
>  		return 1
>  	fi
>  }

