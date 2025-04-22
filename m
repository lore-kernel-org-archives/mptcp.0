Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AD283CA7
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328291; cv=none; b=i6HcWGeLIZ1+Ew/5ZyR8rahfkN5Q+OtWACLckZqyLkKV6yOFbbOw6MFh9BbiwPHh4qf6gGeDiMnxqB85hBCpRenP0AEzDgykTFVnEC8MQHoGkuVEUHuVK+/6cph0heRu8F+6V/NYkxw3A4UNEMgfUj0KmwhdIeYzxp40amRicMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328291; c=relaxed/simple;
	bh=UHPxkqhDSD0EaBPN+/6iWsHmjcs+BTOK5mAQjtL7JlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcbbuLA1MWFl907PSzPiiVJUgNN9mpJ64wG8I3gJznazXousm5204ZIQArbOy95kdUhvLDYDfSlS0HY2h4W8ibmbvOi938R9ND3tu/ZfO7x/RJYHXoeEbXb4qZblSdI6CfAPeQGp4DLyq2/Iiz34e0XUkzM5ZXP4wqFH5S2xkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq7Zg8gF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq7Zg8gF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02802C4CEE9;
	Tue, 22 Apr 2025 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328291;
	bh=UHPxkqhDSD0EaBPN+/6iWsHmjcs+BTOK5mAQjtL7JlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Eq7Zg8gFgUPMWiTf1rPrkoGlGBNcll7CHfwaFv77Gkwzt/Ap6YIEzn0ERp+cG6lNu
	 G8B04u0+N9RdmUZxYpPih4TPOKmpZs4kS0dnP8qXq4YzZRVee+Y5tKUXFDEc6m07im
	 /Rhcktth/XYYgtGW01KN2d9Ivs3b22oebeqtV2AbnS/lwyeT+I7TyEizDxGBDG9hqq
	 563bN66IOdCdYKvMKaKBVwVFY5osjnZCSOJpRQg7zHKP9M0MqFQuQFfxgc4czO6lyk
	 PpxjoKQoMQ6z0qRDiSs+36ppWeZC2xLWSe+voV7lTEYexm+aAGqiqdaBWKqCxpXVgB
	 wuDL2dBQkc/Aw==
Message-ID: <6bfa23c9-fdcb-49c1-a808-887dff760205@kernel.org>
Date: Tue, 22 Apr 2025 15:24:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v2 7/7] selftests: mptcp: add chk_sublfow in diag.sh
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1744793332.git.yangang@kylinos.cn>
 <6be98516e035e73e9523e4fb8c301bc482e65133.1744793332.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6be98516e035e73e9523e4fb8c301bc482e65133.1744793332.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/04/2025 10:59, Gang Yan wrote:
> This patch aims to add chk_dump_subflow in diag.sh. The subflow's
> info can be obtained through "ss -tin", then use the 'mptcp_diag'
> to verify the token in subflow_info.
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 55 +++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index e7a75341f0f3..20de007e44cd 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -225,6 +225,60 @@ chk_dump_one()
>  	fi
>  }
>  
> +get_endpoint_addr()
> +{
> +	echo $1 | cut -d ":" -f 1
> +}
> +
> +get_endpoint_port()
> +{
> +	echo $1 | cut -d ":" -f 2
> +}
> +
> +chk_dump_subflow()
> +{
> +	local inet_diag_token
> +	local subflow_line
> +	local remote_addr
> +	local remote_port
> +	local local_addr
> +	local local_port
> +	local ss_token
> +	local msg
> +
> +	subflow_line=$(ss -tnN $ns | \
> +		       grep -m1 -Eo '[0-9.]+:[0-9].+ +[0-9.]+:[0-9.]+')
> +
> +	if [ -n "$subflow_line" ]; then
> +		read -r local_endpoint remote_endpoint <<< $subflow_line
> +
> +		local_addr=$(get_endpoint_addr $local_endpoint)
> +		local_port=$(get_endpoint_port $local_endpoint)

(you could use 'read -rd: local_addr local_port' here ; same below)

> +
> +		remote_addr=$(get_endpoint_addr $remote_endpoint)
> +		remote_port=$(get_endpoint_port $remote_endpoint)
> +	fi
> +
> +	ss_token=$(ss -tniN $ns | \
> +		   grep -m1 -Eo 'token:[^ ]+')

It might be safer to call 'ss' only once, then extract the subflow and
the ports later.

> +
> +	inet_diag_token=$(ip netns exec $ns ./mptcp_diag -s \
> +			  "$local_addr $local_port $remote_addr $remote_port" | \

Why don't you call 'mptcp_diag -s "$subflow_line"', then adapt sscanf in
mptcp_diag.c to use: "%s:%d %s:%d"?

You will save a few lines of bash here above by doing that. Or is it
more difficult when handling IPv6 addresses? I don't think you handle
IPv6 addresses anyway, right?

> +			  grep -Eo 'token:[^ ]+')
> +
> +	msg="....chk dump_subflow"
> +
> +	mptcp_lib_print_title "$msg"
> +	if [[ $ss_token == $inet_diag_token ]]; then

Please use the same style as elsewhere in the file:

  if [ -n "$ss_token" ] && [ "$ss_token" = "$inet_diag_token" ]; then

> +		mptcp_lib_pr_ok
> +		mptcp_lib_result_pass "${msg}"
> +	else
> +		mptcp_lib_pr_fail "expected $ss_token but $inet_diag_token"

Same here for the style:

  "expected $ss_token found $inet_diag_token"

> +		mptcp_lib_result_fail "${msg}"
> +		ret=${KSFT_FAIL}
> +	fi
> +}
> +
>  msk_info_get_value()
>  {
>  	local port="${1}"
> @@ -316,6 +370,7 @@ chk_msk_fallback_nr 0 "....chk no fallback"
>  chk_msk_inuse 2
>  chk_msk_cestab 2
>  chk_dump_one
> +chk_dump_subflow
>  flush_pids
>  
>  chk_msk_inuse 0 "2->0"

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

