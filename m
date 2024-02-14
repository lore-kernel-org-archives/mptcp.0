Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E13171A3
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905887; cv=none; b=GPwgfKXaNUTzCKv5nPBsvLrmMh4fGFu4Tog4DXeHoAl9bLn88P+KFSuxsk9QnMxTLlrOK5pgQVQps7DGZgu+8iZLDuvkgPbGGFP0h549fvkGF63PnUnE8WfRJCZePnZVjvgJ6elT1bJF4Pl8WlogHEoOiIXBqqY7RrYVeZtYur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905887; c=relaxed/simple;
	bh=PrYFYa0ypzBzLJEnGCSYzPbYhRFWnApFP2/Yw6MaT+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5MDqoOaUJJCd73CTrGAOY9FGAm0sEiWSULlW3Jgo8AZ8RPUe6pGIseuwQGNxL79XRWs4hBhqFC9podoQZGMfjTn5bekC9tz4P5p6GB5s7gFKS7roSV4/P8AkJ1yC4UDCeIUINiukwXAQoidt8y2jYSzguY9l3XY9D56QjcWDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imyekNTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imyekNTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88039C43390;
	Wed, 14 Feb 2024 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707905887;
	bh=PrYFYa0ypzBzLJEnGCSYzPbYhRFWnApFP2/Yw6MaT+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=imyekNTH/whsK442+B3mMVbAdyjY11Ms8DCb6boxdbfZsTPAtV04makNSxNFzUBsM
	 n5RqV9dvH8gNTvi+JjHw1eA4aazypRioAtdJTf1IYvX7LpJyNNv24elEewo9yj3JHT
	 NRT+oMwxC+nF2JH64j/3B9Z+xiRhtfE06QgplRINeGOskwozcjvQwOKfPIKc9SDTm9
	 qMsNt6BqYUXQKUHuDxlTDYhCr4Nkc11/xSA2EHfYZLc+/PLtfYKFnnYi6/cebzcUyn
	 D/u5kkxZE4zQzmbnyNoAtujoDZ1iPUGO67zns9teBL28MiUasUPcjle3D+M/guZgX5
	 ki5DTjuhCdD4Q==
Message-ID: <2f1a2240-b213-47b5-bd4b-4bd398bae475@kernel.org>
Date: Wed, 14 Feb 2024 11:18:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 2/2] selftests: mptcp: rm subflow with
 v4/v4mapped addr
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1707270765.git.tanggeliang@kylinos.cn>
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/02/2024 02:55, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Now both a v4 address and a v4-mapped address are supported when
> destroying a userspace pm subflow, this patch adds a second subflow
> to "userspace pm add & remove address" test, and two subflows could
> be removed two different ways, one with the v4mapped and one with v4.

Thank you for validating this.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 3a2abae5993e..69001d2a8dab 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -213,9 +213,12 @@ mptcp_lib_get_info_value() {
>  	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
>  }
>  
> -# $1: info name ; $2: evts_ns ; $3: event type
> +# $1: info name ; $2: evts_ns ; $3: event type; $4: addr
>  mptcp_lib_evts_get_info() {
> -	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
> +	local addr=${4:-""}
> +
> +	cat "${2}" | grep "${addr}" |
> +	mptcp_lib_get_info_value "${1}" "^type:${3:-1},"

When modifying shell scripts, please make sure 'shellcheck' is happy
with the modifications you did.

> $ shellcheck -x mptcp_lib.sh
> 
> In mptcp_lib.sh line 220:
>         cat "${2}" | grep "${addr}" |
>             ^----^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
> 
> For more information:
>   https://www.shellcheck.net/wiki/SC2002 -- Useless cat. Consider 'cmd < file...

I then did this modification when applying the patch:

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 69001d2a8dab..3777d66fc56d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -213,12 +213,9 @@ mptcp_lib_get_info_value() {
>         grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
>  }
>  
> -# $1: info name ; $2: evts_ns ; $3: event type; $4: addr
> +# $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
>  mptcp_lib_evts_get_info() {
> -       local addr=${4:-""}
> -
> -       cat "${2}" | grep "${addr}" |
> -       mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
> +       grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
>  }
>  
>  # $1: PID

Note that it is not strictly needed to add ':-' in '${4:-}' (we don't
use 'set -u'), but it clearly shows the argument is optional.

I also edited the comment above the declaration of the function to
reflect that.

About 'shellcheck', please note that for the moment, not all scripts are
shellcheck compliant, only 'mptcp_join.sh', 'mptcp_lib.sh' and
'userspace_pm.sh'. For the others, it would be great if at the least the
new code is shellcheck compliant. I don't think it is needed to modify
the existing ones, they are not often modified and they work. (Except
maybe if there are some other big modifications needed.)

Also, some checks can be ignored with '# shellcheck disable=XXXX'
directive if needed:

  https://www.shellcheck.net/wiki/Ignore

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
