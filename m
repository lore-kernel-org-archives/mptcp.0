Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1337F49B
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951344; cv=none; b=uS5YnowFz0m67XMvGb++P6vElfzk0WCDl+ZIvN7Hu4djy2gLxYo7JGboBDKYNqPuJMd0tL7/QZXqVBRjPL84tvXJVc9UAwqNYCgKnyVBBefXCjnRGEgnU3nIgdK8fQ5qMIaX3Ay2o/vV4PPbPqTcCgTtl3h0Zkt4zjmbx6+hCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951344; c=relaxed/simple;
	bh=0MF2xJPfiW/9hEDFGoTeSQjCosmM75dkDg+uFnOfazQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwEl4Ry4EfL06W59cetPEuw0MrNMceaWMiyDRD5YfDji/8mNYBWYdUmWPERI+1yrh05gGtwrWwW70cV8N0EJj6dJBX2P8xXEoCEhoi4bauUCf2PNIL7Mnn2Stm7Q82uK5may59ry9AYTlQte3CgL21r61qPsrCnUXQdgC52+XXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi/WcFj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi/WcFj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2C2C433F1;
	Mon, 26 Feb 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951343;
	bh=0MF2xJPfiW/9hEDFGoTeSQjCosmM75dkDg+uFnOfazQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oi/WcFj+nhrH2mdW9+ld/29Ha+79DTdJt8nC0t4Tb6zWsghOX8FfnYA07c1yOJVVK
	 xqvO786IrjEkyqUa7/88HHJOiZlY3p5u1jIZwnpHtfuyXQhqR37DT+rVe6eZt3tnRm
	 hHZtCJr9EcM6WDQP/QILUBIGe7AusfDM7ltk+EO9rwsot67Pp3CLStOqs6lksjGHYk
	 e09jNqdMFzIMKmOJaUKheO3VA6VZKiAi1eVydo9qXiK0LdrEfjRw6hWpA2MAeB7F8X
	 1mho7F3PKVZfmLah1FU4WMm6nT5LdHRowZbFhVObb7n5HbnDdKMuMEpNrJjzQj0R/a
	 JcjxCyoU6vz8g==
Message-ID: <59a8b8bc-bff6-4b2c-9eb7-f8669fd92bb6@kernel.org>
Date: Mon, 26 Feb 2024 13:42:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 11/12] selftests: mptcp: add
 mptcp_lib_verify_listener_events
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <575315da0fa8969e5cf1215f3a38c8bd83d1c431.1708939962.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <575315da0fa8969e5cf1215f3a38c8bd83d1c431.1708939962.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/02/2024 10:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To avoid duplicated code in different MPTCP selftests, we can add and use
> helpers defined in mptcp_lib.sh.
> 
> The helper verify_listener_events() is defined both in mptcp_join.sh and
> userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
> prefix. Use this new helper in both scripts.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++------------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 25 +++++++++++++++
>  .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++--------------
>  3 files changed, 38 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c9b779510528..fa7d07c51973 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2791,16 +2791,12 @@ backup_tests()
>  
>  verify_listener_events()
>  {
> -	local evt=$1
>  	local e_type=$2
>  	local e_family=$3
>  	local e_saddr=$4
>  	local e_sport=$5
> -	local type
> -	local family
> -	local saddr
> -	local sport
>  	local name
> +	local rc=0
>  
>  	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
>  		name="LISTENER_CREATED"
> @@ -2817,23 +2813,12 @@ verify_listener_events()
>  		return
>  	fi
>  
> -	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
> -	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
> -	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
> -	if [ $family ] && [ $family = $AF_INET6 ]; then
> -		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
> -	else
> -		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
> -	fi
> -
> -	if [ $type ] && [ $type = $e_type ] &&
> -	   [ $family ] && [ $family = $e_family ] &&
> -	   [ $saddr ] && [ $saddr = $e_saddr ] &&
> -	   [ $sport ] && [ $sport = $e_sport ]; then
> -		print_ok

Should you not keep 'print_ok' here?

> +	mptcp_lib_verify_listener_events "${@}" || rc="${?}"
> +	if [ "${rc}" -eq 0 ]
> +	then

Keep the same style as in the rest of the file: 'then' at the previous line.

>  		return 0
>  	fi
> -	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
> +	fail_test "$e_type $e_family $e_saddr $e_sport"
>  }
>  
>  add_addr_ports_tests()

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
