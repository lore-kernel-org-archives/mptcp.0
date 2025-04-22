Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15E27F4E7
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328215; cv=none; b=sIGZsloBs3AvHQgtOG4Rbd9mClEGdt3W24lip1WpJ9ndNLnUwlfcvgxFM4JYdX8/XUorfNSeX68nQMAgR/bmDAhzMaFimpsYymexHayADkroqEFsesNENRK/UJJv4Np27mWoCCMfg0CCk9kKe14IRlsySx2bBGBL5aPRLO5K46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328215; c=relaxed/simple;
	bh=GsyXqfqrpYGwIYodaLtZrAJ42/ov9o771J70ZglKNfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iX576AMDom6Ov8lNwsP3vnMeMYUiY0iMDRsUxn0Id998pAV3rycdeEs+P/9+zc5+e5XTcNg/mTmCDHj6Qwh1PQDFlJyCaeMfEWKGdgCv1n1zxfrFsRw38Bj2vgET8TOg4M7+u6jcod2FNnao0F6jUNl3KmVZSKmyZJLbLtUF2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHDyCHOI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHDyCHOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1FEC4CEE9;
	Tue, 22 Apr 2025 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328215;
	bh=GsyXqfqrpYGwIYodaLtZrAJ42/ov9o771J70ZglKNfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pHDyCHOI7LouWnBQDFo2T6k7zkmNS6r/qe53EGdiWcGn0FwBJlUTQo7+SQtaj+wAu
	 vUlnrr2H76WFm7lPI0jFP2rsSma86bkXGRUbVVxwVGCWhrSJIe5JQk9F6B5L+fT1t6
	 0kCYHVnriXCR/htnWRl/i0jwDGOLcQ5X6dKMom0jDEGJ3ckEp5U7tmnxpDwnPHCOPa
	 BrMPu7M12j8ns+LA3UfiMvr0Vj+yGAPbAqHMkP9zFH7hR0VDTHuc0x8HsoMaYXLr/D
	 uumJAEgItkrIsMOHAkZP9Q6zF1QkGQir3oWTmQJftLikQG5pofBr6Wpz84PdQUWKcn
	 2XD27Bqe8XfHQ==
Message-ID: <c737fb9f-d3a8-45b1-87bf-afb7d3e57ca9@kernel.org>
Date: Tue, 22 Apr 2025 15:23:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v2 5/7] selftests: mptcp: add a helper to get
 subflow_info
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1744793332.git.yangang@kylinos.cn>
 <376ac5afbb35463387e8db2f009ff5b628cd69c7.1744793332.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <376ac5afbb35463387e8db2f009ff5b628cd69c7.1744793332.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 16/04/2025 10:59, Gang Yan wrote:
> This patch adds 'get_subflow_info' in 'mptcp_diag', which can check whether
> a TCP connection is an MPTCP subflow based on the "INET_ULP_INFO_MPTCP"
> with tcp_diag method.
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_diag.c  | 86 ++++++++++++++++++-
>  1 file changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index 2116b40bc927..28b1704d0c78 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -8,6 +8,7 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #include <linux/tcp.h>
> +#include <arpa/inet.h>
>  
>  #include <unistd.h>
>  #include <stdlib.h>
> @@ -19,8 +20,13 @@
>  #define IPPROTO_MPTCP 262
>  #endif
>  
> +#define parse_rtattr_nested(tb, max, rta) \
> +	(parse_rtattr_flags((tb), (max), RTA_DATA(rta), RTA_PAYLOAD(rta), \
> +			    NLA_F_NESTED))
> +
>  struct params {
>  	__u32 target_token;
> +	char subflow_addr[1024];

detail: maybe add a 's': subflow_addrs.

>  };
>  
>  struct mptcp_info {

(...)

> @@ -244,6 +285,41 @@ static void get_mptcpinfo(__u32 token)
>  	close(fd);
>  }
>  
> +static void get_subflow_info(char *subflow_addr)
> +{
> +	struct inet_diag_req_v2 r = {
> +		.sdiag_family           = AF_INET,
> +		.sdiag_protocol         = IPPROTO_TCP,
> +	};
> +	int sport, dport;
> +	char saddr[64];	// Take ipv6 into consideration

Detail: the comments are usually with the "/* ... */" style. You can
also remove the comment and declare both [sd]addr on the same line I think.

> +	char daddr[64];
> +	int ret;
> +	int fd;
> +
> +	ret = sscanf(subflow_addr, "%s %d %s %d", saddr, &sport, daddr, &dport);
> +	if (ret != 4)
> +		die_perror("IP PORT Pairs has style problems!");
> +
> +	printf("%s:%d -> %s:%d\n", saddr, sport, daddr, dport);
> +
> +	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
> +	if (fd < 0)
> +		die_perror("Netlink socket");
> +
> +	r.id.idiag_cookie[0] = INET_DIAG_NOCOOKIE;
> +	r.id.idiag_cookie[1] = INET_DIAG_NOCOOKIE;

Can you not set it above, when declaring 'r'? Same for 'idiag_ext'.

> +	r.id.idiag_sport = htons(sport);
> +	r.id.idiag_dport = htons(dport);
> +	r.id.idiag_if = 0;

Do you need to explicitly set it to 0? Is it not 0 by default?

> +
> +	inet_pton(AF_INET, saddr, &r.id.idiag_src);
> +	inet_pton(AF_INET, daddr, &r.id.idiag_dst);
> +	r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
> +	send_query(fd, &r, IPPROTO_TCP);
> +	recv_nlmsg(fd, IPPROTO_TCP);
> +}
> +
>  static void parse_opts(int argc, char **argv, struct params *p)
>  {
>  	int c;

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

