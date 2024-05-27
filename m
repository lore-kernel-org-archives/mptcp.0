Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD2763F8
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804891; cv=none; b=Io3pmGEtVRj+bw2wKLT3N9lndbDDIUU+/w2YymiNMonRG+A1FFDtoIWDBIw52GnD7Rldq6W0t1Kg9uQp7uWxLqNP59mEuDHMqiQo1zIbFfbeFYtciY8SxotJ7KpmN8zGiKFou9Ec7b3QnjsQ9ITsKRUV0WoIFg0XLh6EUg55f6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804891; c=relaxed/simple;
	bh=30nsz5rkCEY8Mqdi9ETRRpgj23ubSFE02IYBhUNegpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgdmDa+psnrdaiEHdEBotv2T8SKUVxc65oHAAyDG0KDp1Wql3GhXlFKKdJ3cJex/WiFkcDDeUlGPxGNRxDYUlOOa+B2E9TklRJDrBFMkZLUlQg3B8+9uDnY/+B8fy0wxrDFZVmHZYkHKxXu02Hz1eHQ1qmmQ7zmp/bh/hxq5cGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfjMgeOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfjMgeOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F931C2BBFC;
	Mon, 27 May 2024 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716804890;
	bh=30nsz5rkCEY8Mqdi9ETRRpgj23ubSFE02IYBhUNegpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pfjMgeOPqsyXiDc/1NcdQJkf7lJ+yf7OWH2xg+IqiaI/o/WbYgxHt82RVwT0d+JKa
	 dmGA/F67qPmdYbvifn62HOCsLyPbLrGnOp4sLofO0QKjWQBBj2rv1PhaU1tJHnY41B
	 9FpJndOVSl+PNJtk/B7pZJ0/aInjW7jN5n4d4+N/ckzsx1+SliP6w0xUkjWlaN9yn5
	 vt+gf9gvSdIcJ2qB2SgrXAbH5eWEMdJEPtvNe2U+4M00qiWRDi3Cto+5+lLs/lb1sI
	 yZUMgQzt0kQrANvdxdb8bP91UWYe1Nfj4c02/8q4BUMXAWsqh6U8hdG3b9OU6NGlnq
	 HGQnmm6W9gWEQ==
Message-ID: <047d144c-74e6-471a-81f2-b0dc4c5903df@kernel.org>
Date: Mon, 27 May 2024 12:14:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/4] Squash to "selftests: net: lib: rename ns
 in setup_ns"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1716641976.git.tanggeliang@kylinos.cn>
 <a6c019fd6e47ba0c98fd03e9a4723df0075ad269.1716641976.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a6c019fd6e47ba0c98fd03e9a4723df0075ad269.1716641976.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/05/2024 15:01, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> I think "ns_temp" is a better name than "_ns" here.

Good point. But when looking at that, I think it would be even better to
get rid of this variable.

I can suggest a patch in a v6.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/lib.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index b883289ec4a1..97f3d7d6b913 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -167,11 +167,11 @@ cleanup_all_ns()
>  # setup_ns local remote
>  setup_ns()
>  {
> -	local _ns=""
> +	local ns_temp=""
>  	local ns_name=""
>  	local ns_list=()
>  	for ns_name in "$@"; do
> -		if [ "${ns_name}" = "_ns" ]; then
> +		if [ "${ns_name}" = "ns_temp" ]; then
>  			echo "Failed to setup namespace '${ns_name}': invalid name"
>  			cleanup_ns "${ns_list[@]}"
>  			exit $ksft_fail

I don't know if this check still makes sense. It could also conflict
with ns_name...

> @@ -179,20 +179,20 @@ setup_ns()
>  
>  		# Some test may setup/remove same netns multi times
>  		if [ -z "${!ns_name}" ]; then
> -			_ns="${ns_name,,}-$(mktemp -u XXXXXX)"
> -			eval "${ns_name}=${_ns}"
> +			ns_temp="${ns_name,,}-$(mktemp -u XXXXXX)"
> +			eval "${ns_name}=${ns_temp}"
>  		else
> -			_ns="${!ns_name}"
> -			cleanup_ns "${_ns}"
> +			ns_temp="${!ns_name}"
> +			cleanup_ns "${ns_temp}"
>  		fi
>  
> -		if ! ip netns add "${_ns}"; then
> +		if ! ip netns add "${ns_temp}"; then
>  			echo "Failed to create namespace $ns_name"
>  			cleanup_ns "${ns_list[@]}"
>  			return $ksft_skip
>  		fi
> -		ip -n "${_ns}" link set lo up
> -		ns_list+=("${_ns}")
> +		ip -n "${ns_temp}" link set lo up
> +		ns_list+=("${ns_temp}")
>  	done
>  	NS_LIST+=("${ns_list[@]}")
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

