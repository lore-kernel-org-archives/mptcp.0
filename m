Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B278F52
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328173; cv=none; b=MmAwqxxWe7lH97+8kO56PoE75WUO1WbroztFyal/TOZAa0BUsluX8ILI1xA9VtRTtGzU13f/0b0mIctG2TJJKFov+DYi03HNW/dgPn9nivOyHHGcDVAY4GQFRzDPZWsHwWYdiLx7ShvseZHHlFIvAnNGIfC5YhXhaBUoWnLIx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328173; c=relaxed/simple;
	bh=PFBWt7Ier+9v4KCe7VQWSeUErGcT0i7gkhvo78nKu2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2V7m9WfmPEPrn8/0XfQhVEladjatt7Llua+V5yJM9lHQtbcbykG/xGgYqoGysCgQ6Q3Ltt7pHG3MyLLKtdFpJPC/KEX9qe2vb3KX0CioFQ34fZtEgBFTklKjCXd7MorhJM6TH8ctT6TzvOx1n9+Kf6gDk1WY8CgeUd+rLkMcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyqlJqSm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyqlJqSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37215C4CEE9;
	Tue, 22 Apr 2025 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328173;
	bh=PFBWt7Ier+9v4KCe7VQWSeUErGcT0i7gkhvo78nKu2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gyqlJqSm0VTH01jA7ceXdNY2DvHhMyMYGSjSH007YR+IGjP5nU+BpUEZo5HTcGunA
	 KEUKT7UDRCFvzYhlltCeI5TR5VTbMfhnpdbQEJSg8LsN5DSP5jFJkdhyT0Wv6Wg7X0
	 SDbQRlAy2WQ0U9gzB+Ui/t5DslK5pAh9FvoKY88onmXDQiBTzyHRB/7W35VMsgiX+F
	 xT8ZetBTtfYrMctRNEdPzqSc5K6Oqe8rdE+FLBpsIm4fWYPOft1rwjJ7FQJQZOU12u
	 hdTHpUpVdT4Q+K10P6LfJeeSyCZdfZjW0NJVHRcpCtnEOFP2Wk209BhV1CpZIbTThl
	 Ezzp7Q7UuFBBQ==
Message-ID: <6f1f5c0f-c7fe-472c-8dd5-87bf34d43c92@kernel.org>
Date: Tue, 22 Apr 2025 15:22:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v2 2/7] selftests: mptcp: refactor send_query
 parameters for code clarity
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1744793332.git.yangang@kylinos.cn>
 <afbbf4fc074b0d26b4954db0a750cadea1b67a62.1744793332.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <afbbf4fc074b0d26b4954db0a750cadea1b67a62.1744793332.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 16/04/2025 10:59, Gang Yan wrote:
> This patch use 'inet_diag_req_v2' instead of 'token' as parameters of
> send_query, and construct the req in 'get_mptcpinfo'. This modification
> can enhance the enhancing clarity of the code, and prepare for the
> dump_subflow_info.
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_diag.c  | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index ea7cb1128044..8a5b7745c58c 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -62,7 +62,7 @@ static void die_usage(int r)
>  	exit(r);
>  }
>  
> -static void send_query(int fd, __u32 token)
> +static void send_query(int fd, struct inet_diag_req_v2 *r)
>  {
>  	struct sockaddr_nl nladdr = {
>  		.nl_family = AF_NETLINK
> @@ -76,19 +76,13 @@ static void send_query(int fd, __u32 token)
>  			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
>  			.nlmsg_flags = NLM_F_REQUEST
>  		},
> -		.r = {
> -			.sdiag_family = AF_INET,
> -			/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
> -			.sdiag_protocol = IPPROTO_TCP,
> -			.id.idiag_cookie[0] = token,
> -		}
> +		.r = *r
>  	};
>  	struct rtattr rta_proto;
>  	struct iovec iov[6];
>  	int iovlen = 1;
>  	__u32 proto;
>  
> -	req.r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
>  	proto = IPPROTO_MPTCP;
>  	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
>  	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
> @@ -229,13 +223,20 @@ static void recv_nlmsg(int fd)
>  
>  static void get_mptcpinfo(__u32 token)
>  {
> +	struct inet_diag_req_v2 r = {
> +		.sdiag_family           = AF_INET,
> +		/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
> +		.sdiag_protocol         = IPPROTO_TCP,
> +		.id.idiag_cookie[0]     = token,
> +	};
>  	int fd;
>  
>  	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
>  	if (fd < 0)
>  		die_perror("Netlink socket");
>  
> -	send_query(fd, token);
> +	r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));

Out of curiosity, why can you not set idiag_ext above, when 'r' is declared?

> +	send_query(fd, &r);
>  	recv_nlmsg(fd);
>  
>  	close(fd);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

