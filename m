Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DF4302F8
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459977; cv=none; b=oFV0gV2eI2S21GpDBYJzpF+GCQ4xiZq/fagM12tw6yYlRRPlz7BH8I4aB49LWdbN04293ycP0o7LPRqkJBbodjR8eAL0/UcFNZ97FtxXP6ldNXUizxgpt/5LU8GXKgzZXe9Paz6S7R144zKAGbAljk/R9YEYdFxb9X/jKM1JVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459977; c=relaxed/simple;
	bh=ConEoR0ZfZaWggzZWzKOsFKlQNu5jfBU5KmfBuR/fWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQWqakAjTVG2kVC8dXOYeMIVT672AJn6m/pt5U0T8QKByA5DiLOqjMqBXa0nl5CSNTNi1Y0iuF9qfy92KAvg9x2waU5UkNIbnOfzNWawfdrTtBXfsphYpcJWH595/4/q64uU0tddc+fPSf9TVOCC7c0nbVKh575rofrlvNcmTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5NDV5Rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5NDV5Rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C861F000FF;
	Thu,  8 Oct 2026 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791459976;
	bh=n8dhUrh0MitDa6vG3uSAn8+1m5OFkRvMYejurLcOba0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c5NDV5RzdK+JJ5glU+Icg5GmUJPjII+EWw32MjEBJ5ag90muDxXflpTc/aTWwBHMX
	 YgSvLQVwAJuXbaarCOIcNJNunoH28ihBMbWuplDpNgQp1psAexEZrZo3mZ38Ac2vBH
	 rugE+utbOyug4JVs1eF+pmfXzeG+Ly8tB7IDoXiWXhIvoSrzZJ+9eB17ccBND5vE9f
	 HmIwZnaY9tCCLoz1nVspx2YZf36GG8B5RWTEKhLFjhok7Vmd4m4YeWeM2eE9RQeNKC
	 eIpHkmV6YUjGoe5L3Kajj1bivL2bYyywpnrEOvnXpnm8GVzRn7cBV8b9UUYLVEq0OY
	 6gnu6uukPvTzA==
Message-ID: <b7438cbf-0674-4b8f-aa23-3ba5791cfe26@kernel.org>
Date: Thu, 8 Oct 2026 13:46:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use offset to match RM_ADDR
 message
Content-Language: fr
To: Hangbin Liu <hangbin.liu@linux.dev>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20261008-mptcp_rm_addr-v1-1-b4d35ac8afef@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261008-mptcp_rm_addr-v1-1-b4d35ac8afef@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hangbin,

Thank you for the follow-up!

On 08/10/2026 12:06, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> nft cannot match RM_ADDR when it is the second MPTCP option,

Do you mind adding a short explanation why or just a ref to:

 https://lore.kernel.org/a391d81c-0bce-41e6-886e-a558765c6891@kernel.org

Also, could you title this patch:

  Squash to "selftests: mptcp: convert iptables to nftables for
  mptcp_join.sh"

And mention what should be added to the original commit message, please?

> so we rely on hard-coded offsets. A tcpdump capture of the RM_ADDR
> message looks like:
> 
>   [TCP header: 20 bytes] [nop] [nop] [timestamp: 10 bytes] \
>         [MPTCP DSS: 12 bytes] [MPTCP RM_ADDR: 4 bytes]
> 
> We verify: TCP Data Offset (TCP[12] × 8) equals 48 bytes (12 x 4),
> DSS length (TCP[33] x 8) is 12 bytes, and RM_ADDR subtype (TCP[46] × 8)
> is 4. This matches the old cBPF check, which calculated offsets starting
> from the IP header:
> 
> (ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c && (ip[66] & 0xf0) == 0x40
> 
> Also add MPTCP kind (30) checks for the DSS (TCP[32] x 8) and RM_ADDR
> (TCP[44] x 8) options.

Good idea.

> 
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b16e24418e73..194b80277ae2 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4375,7 +4375,12 @@ endpoint_tests()
>  		local nft=1
>  		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
>  			ip saddr 10.0.1.2 meta l4proto tcp \
> -			tcp option mptcp subtype remove-addr drop || nft=0
> +			@th,96,4 == 12 \
> +			@th,256,8 == 30 \
> +			@th,264,8 == 12 \
> +			@th,352,8 == 30 \
> +			@th,368,4 == 4 \
> +			drop || nft=0
>  		local i
>  		for i in $(seq 3); do
>  			pm_nl_del_endpoint $ns2 1 10.0.1.2
> @@ -4454,7 +4459,12 @@ endpoint_tests()
>  		local nft=1
>  		ip netns exec "${ns1}" nft insert rule ip filter OUTPUT \
>  			ip saddr 10.0.1.1 meta l4proto tcp \
> -			tcp option mptcp subtype remove-addr drop || nft=0
> +			@th,96,4 == 12 \
> +			@th,256,8 == 30 \
> +			@th,264,8 == 12 \
> +			@th,352,8 == 30 \
> +			@th,368,4 == 4 \

Do you mind just adding this sequence to a global variable (an array?),
similar to what was done before with the cBPF filter, with a short
comment, please?

That would be easier to understand here, and to avoid duplicated code.

> +			drop || nft=0
>  		pm_nl_del_endpoint $ns1 42 10.0.1.1
>  		sleep 0.5
>  		chk_subflow_nr "after delete ID 0" 2
> 
> ---
> base-commit: 9651c766735c19e7a6b90d731bab53ef7959def8
> change-id: 20261008-mptcp_rm_addr-92ab7ff3d94d
> 
> Best regards,

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

