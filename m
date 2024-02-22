Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EF3FB1C
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600054; cv=none; b=BbOmb0nQy2FYyYQajOe1ei5PMEzEaTtu0cRJfGctyrlsU3bdbCDWZx5YdOTz7tk1YSR9/afV5kDspFeQqxpiZvD9QPBvg990MqlreW/cu0QgnhTHL1Mt4FO+UrK7aA2bPjFACicP44dQuAHu9KPXROHgUYdTROuxrn6FrN98VgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600054; c=relaxed/simple;
	bh=LVipJmEeIig2pdw2vToKY7YbnYxXwBb5+HCxNg2d4Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV3XGoBwjtTX082R/+O1SH6CoCzZh3LrtC6E5XMKOjGumtkCGAlUwk1owwDLfXWUEIaY5dh8YSspnqBqHGf4WjXU2MNlfWA4+SiRBJFhrywSHI7MvhKlhRz8lMHx2ZIL4Lsb8l/HNM3MU8A6zGs+x8v1618czFkNWFLMJcxnwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8c6cEPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8c6cEPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACE9C433C7;
	Thu, 22 Feb 2024 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708600054;
	bh=LVipJmEeIig2pdw2vToKY7YbnYxXwBb5+HCxNg2d4Zo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8c6cEPG1BQehq25uM8jak8ng5Z4ngCkKFXdFmi5VmLysKLcXmgHAygS1g/ZnEdAH
	 tAvdGYtQvCHtydrN3Dr4VDlDfEjE6XHNMYFKg/nulGgKzYNvDw1psIsrAm0Y2tXxeh
	 Mrug0COYRhtiWA53U4b0QJPAXeZokWKByXeZMXV+tCZuR9mb4vV9UEEBAGBFbdzTPH
	 HGT1JCrp0N47f3OOuIr1tMAGmTT/1l1OH4kWn8X8NoMm/6pLefguR/yv6MQi+dcsaA
	 QCnv+EtJ8tmcb/l0S0lZ6e4brzX+SfJYafevZRU+X7I/VXLcHuBz2CEYRHm+TXvaTp
	 xzH2JTXMiFYiQ==
Message-ID: <c415e047-b5ee-4aa1-919b-2a1e829d16e2@kernel.org>
Date: Thu, 22 Feb 2024 12:07:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v4 4/4] selftests: mptcp: add mptcp_lib_events
 helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708572320.git.tanggeliang@kylinos.cn>
 <a306733bbc030878afda1ba501a94b40b92ec264.1708572320.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a306733bbc030878afda1ba501a94b40b92ec264.1708572320.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/02/2024 4:40 am, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To avoid duplicated code in different MPTCP selftests, we can add and
> use helpers defined in mptcp_lib.sh.
> 
> This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
> and mptcp_join.sh into a helper mptcp_lib_events(). Define it in
> mptcp_lib.sh and use it in both scripts.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index f65a31594829..5b5ad9947c21 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -399,3 +399,17 @@ mptcp_lib_ns_exit() {
>  		rm -f /tmp/"$netns".{nstat,out}
>  	done
>  }
> +
> +mptcp_lib_events() {
> +	local ns="${1}"
> +	local evts="${2}"
> +	declare -n pid="${3}"
> +
> +	:>"${evts}"
> +
> +	if [ ${pid} -ne 0 ]; then

Yet another new shellcheck warning introduced here:

> 
> In mptcp_lib.sh line 410:
>         if [ ${pid} -ne 0 ]; then
>              ^----^ SC2086 (info): Double quote to prevent globbing and word splitting.
> 
> Did you mean: 
>         if [ "${pid}" -ne 0 ]; then

I guess the CI should check that and report it, so I would not have to
fix that just before applying patches.

I just added the suggested double-quotes when applying the patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
