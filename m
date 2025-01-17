Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B6199E88
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737131739; cv=none; b=oAAJJtyOtwsPg7vSlFIl6K3NzGUbv4hQSIRHSnl+vPyKtE67xyp6wK3bvuR29nOzBRWHPl1fS0uWzfjGYpppE4lNpF2FII5/rinsCRnpcQIBXs3PIfqXPh1Zy/kjjQy80p+wyAMpPmZa23HxOrHd+V8b7EUkbcgPDpsaDQgVT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737131739; c=relaxed/simple;
	bh=39F9BA/uNbuhIrcpP2fkxlzJm+saNHikUC6spPIP/1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEdnGE6ucWUwx2i480mROcRsB68G+Di6fxMWSk07CjRgbh4y5/B51WuH3tvIHyiGNKcYuh8uL8JXeaCkU9JVsJOvLMwPFUlywycryXyUFVilLe7JzzlMM/AqMs2ae/pkvnXCuq1ujJjYR3jzyHM1tqvk1veTU+/MZRLHT62hDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfMt3R5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfMt3R5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68485C4CEDD;
	Fri, 17 Jan 2025 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737131738;
	bh=39F9BA/uNbuhIrcpP2fkxlzJm+saNHikUC6spPIP/1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lfMt3R5SA/BaFIkqi93Y//Jk97i0XMW3XmE5vKGXT6caCW5268VkKhhNtR2cVKjb4
	 C1szUAGt3J5m8V1C+ffsHDvbW4VAR3q9Bbx9lFOHjmoESdo0hAFz4iiM/ncmdoZnsu
	 jCtGKL+HUNWEFFuwGcsIuMD62KC4a9NF+YNP/ey28Zd8OnfT1RTv0GT4dy4kbpJQyP
	 tu/ChTgZVlklHe6NH+pCJLpYwbJLMWaa3dUQIQOFERkvsG04VK33+EUkt9Hi5DItpH
	 v5pmp2WOjrH86scVMZVw2dRG6UX82xXymDj6mLTzr+QCHtUS3Pv1xJqdGe/ZhNX+tD
	 azLFJ49WAMfJA==
Message-ID: <01deae4b-c90e-4aa7-a7f1-dc9fa26b6abd@kernel.org>
Date: Fri, 17 Jan 2025 17:35:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next] selftests: mptcp: cover 'mptcp_diag_dump_one' in
 mptcp_sockopt
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <tencent_EE06C3EF8440C6905D8EC0B94E3E4A589905@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_EE06C3EF8440C6905D8EC0B94E3E4A589905@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang Yan,

On 17/01/2025 07:44, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> Through code coverage analysis, it has been identified that the
> 'mptcp_diag_dump_one' function lacks test coverage on the testing front.
> 
> This patch introduces a function in mptcp_sockopt.c, which is built upon
> the 'inet_diag' module, and integrates it into the 'mptcp_sockopt.sh' to
> execute the 'mptcp_diag_dump_one' function when server bound a socket.

Thank you for increasing the code coverage!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../selftests/net/mptcp/mptcp_sockopt.c       | 76 ++++++++++++++++++-
>  .../selftests/net/mptcp/mptcp_sockopt.sh      |  6 ++
>  2 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index 926b0be87c99..caa0466d827f 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c

(...)

> +void diag(void)
> +{
> +	int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
> +
> +	if (fd < 0)
> +		die_perror("Netlink socket");
> +
> +	send_query(fd);

From what I see, you are sending a request, but you don't look at the
reply. I understand the objective is to increase the code coverage, but
while at it, it sounds better to verify the kernel is doing the right
thing: the reply looks correct.

Do you mind checking the reply? e.g. create a connection, request info
about it, and compare (a part of) the reply with info you already have.

(Also, is your code here covering mptcp_diag_dump_one() function?)

> +
> +	close(fd);
> +}
> +
>  static void parse_opts(int argc, char **argv)
>  {
>  	int c;
>  
> -	while ((c = getopt(argc, argv, "h6")) != -1) {
> +	while ((c = getopt(argc, argv, "h6d")) != -1) {
>  		switch (c) {
>  		case 'h':
>  			die_usage(0);
> @@ -262,6 +332,10 @@ static void parse_opts(int argc, char **argv)
>  		case '6':
>  			pf = AF_INET6;
>  			break;
> +		case 'd':
> +			diag();
> +			exit(0);
> +			break;
>  		default:
>  			die_usage(1);

(you didn't update the 'usage' menu)

>  			break;
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 5e8d5b83e2d0..3f74100bc023 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh

(...)

> @@ -356,6 +361,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
>  
>  do_mptcp_sockopt_tests
>  do_tcpinq_tests
> +do_diag_tests

It sounds strange to do this Netlink request in the MPTCP Socket Option
test program.

Ideally, this should be done from diag.sh. I guess you modified
mptcp_sockopt.c because you needed to do some operations in C, right?

Here are some ideas:

- Create a new diag.c file to do these operations, and call the new
program from diag.sh. In diag.sh, you already have connections that are
created, you can do an extra check there, e.g. compare info from ss and
from diag.c.

- Modify 'ss' to be able to query one MPTCP connection having a given
token. Then use this feature (if available) in diag.sh.

- Modify mptcp_sockopt.c to query info about one connection via netlink,
e.g. to compare them with info retrieved via getsockopt(MPTCP_INFO) from
do_getsockopt_mptcp_info(). You could compare them in
process_one_client() I suppose (to be checked where it sounds better to
do that).

- ...


The first 2 options might make more sense: it is all about 'diag'. Maybe
the 3rd option can be justified if the goal is to compare more data from
getsockopt(MPTCP_INFO).


Note that modifying 'ss' to query info about a specific connection seems
useful anyway. In other words, we could have both option 1 and 2 in
place. Or only option 1 or 3 + the support in 'ss' but not used in the
selftests.

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

