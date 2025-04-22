Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790AC28137C
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328229; cv=none; b=kCfrWMnpucQjthkmo2f4MX5/s20mwDFJNA3kbM9UBM/FEdR1DOgEVJt7ZjP1LTgJMWa2UHzZyHm1h+3IRacTxHZCYU5VNEiEaeJciNbdEPghtdxB5dh2mSH+LAuw2ZSvsw9eX9dZ/s8XMXoeuv6cfXbnoaXyhdcV5pJpFa6TMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328229; c=relaxed/simple;
	bh=n/EhkWaBkzhEQzSu/bem0huZDuNCE6I7wCymD1apy6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UiJho2dRuvOiko8Av+sB+Q99+lq/RdB3vzCg8mjYfIPckymub/May7iv3weYKQh9Y8GQ4wusIKWl/tPD5O6t0YCz0t3j+dJZO+9T28s8ajk8pSLYL+5EAIv2mJ7foEL+RV9wkFlAEFGZwT7TgJITx9iMh4cs9I+ESElf/MVQs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwhvGCvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwhvGCvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CF0C4CEE9;
	Tue, 22 Apr 2025 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328229;
	bh=n/EhkWaBkzhEQzSu/bem0huZDuNCE6I7wCymD1apy6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pwhvGCvoDTvggTpaUAXWGNPW+b9QzmKvJCqxp/mjv8ein3bm8/JhJ/nDQnkBnPRtd
	 xQGCMu2LA9lD9m7SP133LTXNmDOyPTNf48dZU6FNA1WcDAW76TuiDZqsEPJ8vNk/Rc
	 B8tas2yjenG08K+i69lQwYQqHTp7qiMxnG3nZ1HPra8wsnUw9Qfc2EjjAhvU0bz7Cb
	 Smm52HaYNN29If4bpFqJ/CaoeQNQ/S5Fh+z1fwMOZE8xOpFAD94mb4YxX2deWtGKtM
	 Puo4bKkvyHkdonz2aHxXN3iknQ4MWiLHHWYtOf806A86HuYiPQGUxC9dtnigNfP724
	 xbm6CtPCWlfOQ==
Message-ID: <a5211dd3-7508-442d-b318-b53dc79eeba2@kernel.org>
Date: Tue, 22 Apr 2025 15:23:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v2 6/7] selftests: mptcp: add a helper to print
 subflow_info
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1744793332.git.yangang@kylinos.cn>
 <69ec06b8a1a16cec85b06bb93150e53de0ffdaf5.1744793332.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <69ec06b8a1a16cec85b06bb93150e53de0ffdaf5.1744793332.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 16/04/2025 10:59, Gang Yan wrote:
> This patch adds 'print_subflow_info' in 'mptcp_diag', which can print
> the subflow_filed of an MPTCP subflow. This function is for further
> checking the 'subflow_info' through inet_diag method.

I think this can be squashed in the previous patch. They don't make
sense alone.

> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_diag.c  | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index 28b1704d0c78..25495c7e1c74 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -74,6 +74,18 @@ enum {
>  };
>  #define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
>  
> +#define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
> +#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
> +#define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
> +#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		_BITUL(3)
> +#define MPTCP_SUBFLOW_FLAG_BKUP_REM		_BITUL(4)
> +#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		_BITUL(5)
> +#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	_BITUL(6)
> +#define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
> +#define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
> +
> +#define rta_getattr(type, value)		(*(type *)RTA_DATA(value))
> +
>  static void die_perror(const char *msg)
>  {
>  	perror(msg);
> @@ -185,6 +197,65 @@ static void print_info_msg(struct mptcp_info *info)
>  	printf("bytes_acked:      %llu\n", info->mptcpi_bytes_acked);
>  }
>  
> +/*
> + * 'print_subflow_info' is from 'mptcp_subflow_info'
> + * which is a function in 'misc/ss.c' of iproute2.
> + */
> +static void print_subflow_info(struct rtattr *tb[])
> +{
> +	u_int32_t flags = 0;
> +
> +	printf("It's a mptcp subflow, the subflow info:\n");
> +	if (tb[MPTCP_SUBFLOW_ATTR_FLAGS]) {
> +		char caps[32 + 1] = { 0 }, *cap = &caps[0];
> +
> +		flags = rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_FLAGS]);
> +
> +		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_REM)
> +			*cap++ = 'M';
> +		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_LOC)
> +			*cap++ = 'm';
> +		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_REM)
> +			*cap++ = 'J';
> +		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_LOC)
> +			*cap++ = 'j';
> +		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_REM)
> +			*cap++ = 'B';
> +		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_LOC)
> +			*cap++ = 'b';
> +		if (flags & MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED)
> +			*cap++ = 'e';
> +		if (flags & MPTCP_SUBFLOW_FLAG_CONNECTED)
> +			*cap++ = 'c';
> +		if (flags & MPTCP_SUBFLOW_FLAG_MAPVALID)
> +			*cap++ = 'v';
> +
> +		if (flags)
> +			printf(" flags:%s", caps);
> +	}
> +	if (tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM] &&
> +	    tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC] &&
> +	    tb[MPTCP_SUBFLOW_ATTR_ID_REM] &&
> +	    tb[MPTCP_SUBFLOW_ATTR_ID_LOC])
> +		printf(" token:%04x(id:%u)/%04x(id:%u)",
> +		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM]),
> +		       rta_getattr(__u8, tb[MPTCP_SUBFLOW_ATTR_ID_REM]),
> +		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC]),
> +		       rta_getattr(__u8, tb[MPTCP_SUBFLOW_ATTR_ID_LOC]));
> +	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ])
> +		printf(" seq:%llu",
> +		       rta_getattr(__u64, tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ]));
> +	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ])
> +		printf(" sfseq:%u",
> +		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ]));
> +	if (tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET])
> +		printf(" ssnoff:%u",
> +		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET]));
> +	if (tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN])
> +		printf(" maplen:%u",
> +		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN]));

I guess you need:

  printf("\n");

here at the end.

Also, do not hesitate to show an example of the whole output in the
commit message, that would be helpful for the reviews.

> +}
> +
>  static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
>  {
>  	struct inet_diag_msg *r = NLMSG_DATA(nlh);
> @@ -219,6 +290,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
>  
>  			parse_rtattr_nested(sfinfo, MPTCP_SUBFLOW_ATTR_MAX,
>  					    ulpinfo[INET_ULP_INFO_MPTCP]);
> +			print_subflow_info(sfinfo);
>  		} else {
>  			printf("It's a normal TCP!\n");
>  		}


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

