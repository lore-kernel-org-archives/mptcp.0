Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119E4F8B2
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355604; cv=none; b=MIpSTQKvqb2zK32NRTa7MF690DcrA7ydLY81fZLOL2mmgFlyFYkhW8qMmd7/4Rw9y7XuvMMYV1gkRepoawwmgwKyeyg8sf/Rxo6uJeIWOE9xrVJeGhPxNKKBwBizgxUEJiFRAxXyzPBWXcUc0GOfSYXQBLwYYcct2s+x7vRLUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355604; c=relaxed/simple;
	bh=oidbY/Dg7XQ8oV620nqVkoeFYgl280EofZuvhtdb+QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCo6hFmdo6RYcb2IvPzVaUYAJq9uzNidyVipSy+IBtQeee+tXEXhuMp9OZFgd7QEFyME6S9kvcZwS7ipbYTgNAgi0QOEy49nUNo/zMXE0OnF5Rlk6onL0fCJWpNLz9vVG54m+gRjTbCeDMx/WNQhb/+p4dRX86S/09T75Va3O9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeD5qfcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeD5qfcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CE8C433C7;
	Wed, 13 Mar 2024 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710355604;
	bh=oidbY/Dg7XQ8oV620nqVkoeFYgl280EofZuvhtdb+QI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UeD5qfcvZM4cdHppeIAAkIlm7llkU0Cervs0DIO7F+2xUqZ1zS13YdLw3huPJIJ0z
	 mmKEYu8YzO9Gi7K6RMNrfI2eMWVMej9cdYuHm9h0x8yHCfqUnF5HqBbmvaI+OuqRnU
	 Afv6C/rx3zliUyBzpyI8Dkl4Ddva6RmY5a9rDrxWEyYGPHiXU291oySHMT7AvBOmSG
	 Jidouc5VDC20l/HwCj+bFvayguw3O+n9RjTnzstYHO0KTRT5C019afDmafIa9GY/sV
	 RRoL4QLI+uVPKoIgCP2zztIcMQZ8DZP3tYzE7Mk6nHJiEvJK4+0Ai83oWaimZr0/ki
	 qk4cWym4SvnsA==
Message-ID: <d4ad6607-3a57-49cd-a0d6-de7f3ceb38c9@kernel.org>
Date: Wed, 13 Mar 2024 19:46:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 00/10] add helpers and vars in mptcp_lib.sh,
 final
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2024 02:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This is the last part for "add helpers and vars in mptcp_lib.sh" series,
> add endpoint operation helpers into mptcp_lib.sh.

Thank you for looking at that!

I just did a review, see my different replies.

In general, I think we should only add tests if they validate new code
path on the kernel side, e.g. new feature. Having more tests means more
code to maintain, a longer time to execute them, etc. Best to only add
"valuable" ones.

> Geliang Tang (10):
>   selftests: mptcp: export ip_mptcp to mptcp_lib
>   selftests: mptcp: get support for limits
>   selftests: mptcp: id support for show_endpoints
>   selftests: mptcp: addr support for change_endpoint
>   selftests: mptcp: netlink: fix positions of newline
>   selftests: mptcp: netlink: add outputs for ip_mptcp
>   selftests: mptcp: add endpoint_ops API helper
>   selftests: mptcp: use mptcp_lib_endpoint_ops
>   selftests: mptcp: add ip_mptcp option for more scripts

I hope some people are going to validate that. I don't think our CI
should always run these tests with and without this new '-i' option.

Maybe once in a while, to validate the interface with 'ip mptcp' is
still OK? Do you plan to do this check periodically? e.g. before a new
version of 'iproute2'?


>   selftests: mptcp: netlink: drop disable=SC2086
> 
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++-----
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 166 ++++++++++
>  .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
>  .../testing/selftests/net/mptcp/pm_netlink.sh | 288 +++++++++++-------
>  .../selftests/net/mptcp/simult_flows.sh       |  14 +-
>  5 files changed, 401 insertions(+), 209 deletions(-)
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

