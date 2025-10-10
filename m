Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6B222587
	for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091598; cv=none; b=JqDJGg8ZYDzmvJ+pfMvvwDayl23ipTYnxLByL8040mlKGGTxjmq9VugTz5bGGpISz4YtWJQGcvL3d9PZ4ZT6oHv0UHLBVSmTQFNLofJba/J2drxAObJ4Teb3JPXxDAb9a5+CUMnOAX2/x4i0OmNk3gGSI4lan5VB63YwqRtL68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091598; c=relaxed/simple;
	bh=jiuHm+gp+uhns2/zR3UPx3StAb0dwYsNnhJjH+4QGL0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJracYIMT5HChRthuLdZeTo8/VYflNMovLHwhq2zTYionJ0xyTMuNDGToJw+4gzXHnrhxIzrxB10cZmpMl+29usD2H+JggK5LHmAKjSadtSdCfOJROe7LlpO7YCXiSY2Kts4KjHospKVov7D2PRmn+xiuIzhcCh0/uo7sW7Z8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZljGsKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZljGsKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8076FC4CEF1;
	Fri, 10 Oct 2025 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760091598;
	bh=jiuHm+gp+uhns2/zR3UPx3StAb0dwYsNnhJjH+4QGL0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=KZljGsKCuOUwJ4VAIQ653exAa38IFOxKa39SBQXm9C7Fa/tcvbhEoPMqHgKfs6MgF
	 FpCFpdVLiC0Ys7Zl5886Wfy3DKVtZMZuZIZ8W1+oI498bmkF+wq9Uy/0erNxw3pVTD
	 3SP74kyXdddbS/ibtb22vNw99W8svnQNZLHyJ2ADa16wyUJrFq/qdGuRVh0rbpxt2L
	 2WaRS3pyFIrfjzjbz/Eam/PRY8FLZi5odV9Zb4b683VYFHI/cNQoonTQYjI8iW2h83
	 wzJiYl+NN2Qd/M1kFFbZfJ6vTm0sqPayyJSqKvg3364wITMUYOVjNpeqCyJpv5RU4Y
	 Hr4VaxtQNLcWg==
Message-ID: <559fab4b7aee38876b5dcdbc7ce8ec6d9c1b12f7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: join: do_transfer:
 reduce code dup
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 10 Oct 2025 18:19:53 +0800
In-Reply-To: <20251009-bind-extra-listen-v1-1-5ad2077d77a9@kernel.org>
References: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
	 <20251009-bind-extra-listen-v1-1-5ad2077d77a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-10-09 at 19:33 +0200, Matthieu Baerts (NGI0) wrote:
> The same extra long command is present twice, with one small
> different:
> the var for the stdin file is different.
> 
> Use a new dedicated var in one command to avoid this code
> duplication.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c90d8e8b95cb..c5169020a515 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -951,6 +951,7 @@ do_transfer()
>  	local FAILING_LINKS=${FAILING_LINKS:-""}
>  	local fastclose=${fastclose:-""}
>  	local speed=${speed:-"fast"}
> +	local in="${sin}"
>  	port=$(get_port)
>  
>  	:> "$cout"
> @@ -999,16 +1000,12 @@ do_transfer()
>  
>  	extra_srv_args="$extra_args $extra_srv_args"
>  	if [ "$test_linkfail" -gt 1 ];then
> -		timeout ${timeout_test} \
> -			ip netns exec ${listener_ns} \
> -				./mptcp_connect -t ${timeout_poll} -
> l -p $port -s ${srv_proto} \
> -					$extra_srv_args "::" <
> "$sinfail" > "$sout" &
> -	else
> -		timeout ${timeout_test} \
> -			ip netns exec ${listener_ns} \
> -				./mptcp_connect -t ${timeout_poll} -
> l -p $port -s ${srv_proto} \
> -					$extra_srv_args "::" <
> "$sin" > "$sout" &
> +		in="${sinfail}"
>  	fi
> +	timeout ${timeout_test} \
> +		ip netns exec ${listener_ns} \
> +			./mptcp_connect -t ${timeout_poll} -l -p
> ${port} -s ${srv_proto} \
> +				${extra_srv_args} "::" < "${in}" >
> "${sout}" &
>  	local spid=$!
>  
>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
> 

