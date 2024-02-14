Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D28128836
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934539; cv=none; b=rsCp00eTq7GCEOpwcO6ziY0kRAIgFlKkGvyoOspSHTmU6ZHBgR5jNFtpFUbfIhbBF5n+SMs0wjcNCpEXMoRH+/tswF0NMRyshfl3sowRWM2rxIq8qjXCWl0GftS2b5Sx3PFvwaKlMbDug1C3zHUsQAnsUFhgaVWnnYbsBSDNgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934539; c=relaxed/simple;
	bh=drDvJ2RcS9SIA62dkbZq1sYusCJXcwvgwF+1pu7iYF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptKz0hhY2Up9HNsKMVrsS8aks5q5705Xev8Y5hm0HN1gvHfTaxqNyjVg8oeyTT9Kf0C6wouSd5OM3djIUlinS0l0QXnzEnnL5ZkPv6P9FwW0qcATObMKDL6QmVbvaM8fxTlvcpS9SRZladaRmOgtAoEXpA/mWoCwxRZ/OBnit2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwY7A8xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwY7A8xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B9BC433F1;
	Wed, 14 Feb 2024 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934538;
	bh=drDvJ2RcS9SIA62dkbZq1sYusCJXcwvgwF+1pu7iYF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fwY7A8xob4X/TqXz2xZY8ZzuP7+RdpsDiRNSZg7krN5SeRHrFdB+tG6tTA2998jkD
	 5i78p2L98afapsmLEhOOn7n3xHvOYON//ngVzMi7DuryO/lZRlo/tA9hf1Mv+diWY9
	 4lQxeU9cdeTFDOvl0PAwAP13alK0QPua2043Lqbut85r19x0c4bsTc0MNMfueTYl05
	 CsmSkYZI+QBUvlucwI+YM1LCFzPpvDvmnd9gTiIj9OeK5YsakZtE9xgY6yDGtRWXdP
	 aznSARlXYE+XkohpeKlUO2gXoDBUs4F5nnVDgLPwTakjQ/lDNkOvb6ZP4Dk9nK4dv4
	 4r4kmFuZIij8Q==
Message-ID: <4fcbae24-8438-4091-8cd4-5d44981e3de6@kernel.org>
Date: Wed, 14 Feb 2024 19:15:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 3/5] selftests: mptcp: add ss mptcp support
 checks
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1707797566.git.tanggeliang@kylinos.cn>
 <8f1e695491d199be96ea6a7a9e38ffd45a30388b.1707797566.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8f1e695491d199be96ea6a7a9e38ffd45a30388b.1707797566.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/02/2024 05:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Commands 'ss -M' are used in scripts mptcp_connect.sh, mptcp_join.sh,
> and mptcp_sockopt.sh to display only MPTCP sockets. So it must be checked
> if ss tool supports MPTCP in these script.
> 
> Fixes: 767389c8dd55 ("selftests: mptcp: dump more info on errors")
> Fixes: c2a55e8fd80f ("selftests: mptcp: dump more info on mpjoin errors")
> Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")

If we only use it to get more debug in these selftests, maybe this check
is not needed? I think it would be better to let other CI running our
tests, and accept we can have less debug info. (Also easier for the
backports if there is only one thing to fix at a time)


I would then add...

 Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")

... because here it is different, it is used as a feature.

So I think we only need it for mptcp_join.sh, right?

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++++
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 6 ++++++
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 ++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 7898d62fce0b..c49351d85cae 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -154,6 +154,12 @@ if [ $? -ne 0 ];then
>  	exit $ksft_skip
>  fi
>  
> +ss -h | grep -q MPTCP
> +if [ $? -ne 0 ];then
> +	echo "SKIP: ss tool does not support MPTCP"
> +	exit $ksft_skip
> +fi
> +
>  sin=$(mktemp)
>  sout=$(mktemp)
>  cin=$(mktemp)
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c07386e21e0a..5ca1512c3eae 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -161,6 +161,12 @@ check_tools()
>  		exit $ksft_skip
>  	fi
>  
> +	ss -h | grep -q MPTCP
> +	if [ $? -ne 0 ];then

(Even if you might have taken that from diag.sh) This will not pass
shellcheck's validation, I think, right?

Better like this?

  if ! ss -h | grep -q MPTCP; then

(Also, please add a space after ";", like in most of the scripts we have)

Same in the other files (if you need to modify them).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
