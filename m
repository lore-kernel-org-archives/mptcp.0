Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4968F64
	for <mptcp@lists.linux.dev>; Tue, 29 Apr 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931922; cv=none; b=pd7XZqM64D6uZobot/2dMuy6bExSMDt8qvSizxLLscDPgHfyKDjfL2fpzm0XM6c/K24sm3V6hvPpzBAHeqn5mTAKOweafLr/cwI3LUwJV2Ln/CsdHZKz2+2Ib9DAbDMZSDp/YSQvlL9258ltkLQDpdoYHTPlE8Aej6UQ3yGwek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931922; c=relaxed/simple;
	bh=PWy+GOdkP2nyrzG3fHBfp3DROSzB5GZ3SySH7Y8rniQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5Gj9lvpdhZ+1FgHNFlw1DdY0sWiJAJh9L/b9QqSzfdaAfn4JfKBVwP3xQ+NKrCK6GKoOxpgRcSOIaibbBUCZhLqLUEQMKfpCcqjJ8axPkFtkF78klsp3kYxE9gzftVefaU5sTwH9xIDsbIGC10eBndEeQ+JliVNs2v2gT6QO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGxR3Qxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGxR3Qxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC5C4CEE3;
	Tue, 29 Apr 2025 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931921;
	bh=PWy+GOdkP2nyrzG3fHBfp3DROSzB5GZ3SySH7Y8rniQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VGxR3QxubgcC+JBHxH3Pq4cWg8zRI/11Hj9b9RBK3KNfMa7tnExPM8sPfwtN243S9
	 3xLH8GSMobeUjXzWdSxBFK6SLWfs3rWlq5Y2A11hdnmhZS9cHBQREGIQqArLTqPLsI
	 Chc6ozd7EkPryAgLIvJkA1aaFzO35lsZoXk7SGwRAhI+AEcyKc/up2Pb/v6fTxRMT0
	 CC44O1ujpyd+EnaJyTp5Aj3DNfWVu4rXoLekYakiENNftC0FZejZddMhuhuRy8T3g0
	 bzIEsAb8ZpLLA4ClsPMc+J4296RkYHzQHxE5JcIC6qQ0X9YZKJ3FqROZgxEHLLJ+Cl
	 eP4/8jkEnOIWw==
Message-ID: <637a4ea4-216d-481a-93bd-d0283f4cb38b@kernel.org>
Date: Tue, 29 Apr 2025 15:05:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 4/5] selftests: mptcp: add helpers to get
 subflow_info
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1745395366.git.yangang@kylinos.cn>
 <30e3b8d461c1e7776d398897c9e891536fbc385b.1745395366.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <30e3b8d461c1e7776d398897c9e891536fbc385b.1745395366.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 25/04/2025 08:18, Gang Yan wrote:
> This patch adds 'get_subflow_info' in 'mptcp_diag', which can check whether
> a TCP connection is an MPTCP subflow based on the "INET_ULP_INFO_MPTCP"
> with tcp_diag method.
> 
> The helper 'print_subflow_info' in 'mptcp_diag' can print the subflow_filed
> of an MPTCP subflow for further checking the 'subflow_info' through
> inet_diag method.
> 
> The example of the whole output should be:
> 
> '''
> 127.0.0.1:10000 -> 127.0.0.1:38984
> It's a mptcp subflow, the subflow info:
>  flags:Mec token:0000(id:0)/4278e77e(id:0) seq:9288466187236176036 \
>  sfseq:1 ssnoff:2317083055 maplen:215
> '''
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_diag.c  | 159 +++++++++++++++++-
>  1 file changed, 157 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index e19b21631641..13848a25938d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c

(...)

> @@ -244,6 +359,39 @@ static void get_mptcpinfo(__u32 token)
>  	close(fd);
>  }
>  
> +static void get_subflow_info(char *subflow_addrs)
> +{
> +	struct inet_diag_req_v2 r = {
> +		.sdiag_family           = AF_INET,
> +		.sdiag_protocol         = IPPROTO_TCP,
> +		.id.idiag_cookie[0]	= INET_DIAG_NOCOOKIE,
> +		.id.idiag_cookie[1]	= INET_DIAG_NOCOOKIE,
> +	};
> +	char saddr[64], daddr[64];
> +	int sport, dport;
> +	int ret;
> +	int fd;
> +
> +	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr, &sport, daddr, &dport);
> +	if (ret != 4)
> +		die_perror("IP PORT Pairs has style problems!");
> +
> +	printf("%s:%d -> %s:%d\n", saddr, sport, daddr, dport);
> +
> +	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
> +	if (fd < 0)
> +		die_perror("Netlink socket");
> +
> +	r.id.idiag_sport = htons(sport);
> +	r.id.idiag_dport = htons(dport);
> +
> +	inet_pton(AF_INET, saddr, &r.id.idiag_src);
> +	inet_pton(AF_INET, daddr, &r.id.idiag_dst);
> +	r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));

This could be declared above as well I suppose.

> +	send_query(fd, &r, IPPROTO_TCP);
> +	recv_nlmsg(fd, IPPROTO_TCP);
> +}
> +
>  static void parse_opts(int argc, char **argv, struct params *p)
>  {
>  	int c;
> @@ -251,7 +399,7 @@ static void parse_opts(int argc, char **argv, struct params *p)
>  	if (argc < 2)
>  		die_usage(1);
>  
> -	while ((c = getopt(argc, argv, "ht:")) != -1) {
> +	while ((c = getopt(argc, argv, "ht:s:")) != -1) {
>  		switch (c) {
>  		case 'h':
>  			die_usage(0);
> @@ -259,6 +407,10 @@ static void parse_opts(int argc, char **argv, struct params *p)
>  		case 't':
>  			sscanf(optarg, "%x", &p->target_token);
>  			break;
> +		case 's':
> +			snprintf(p->subflow_addrs, strlen(optarg) + 1,

The max size (2nd argument) should be linked to the destination buffer
size, not the source one.

Note that it would make more sense to use "strncpy()" here.

> +				 "%s", optarg);
> +			break;
>  		default:
>  			die_usage(1);
>  			break;
> @@ -275,6 +427,9 @@ int main(int argc, char *argv[])
>  	if (p.target_token)
>  		get_mptcpinfo(p.target_token);
>  
> +	if (strlen(p.subflow_addrs) != 0)
> +		get_subflow_info(p.subflow_addrs);
> +
>  	return 0;
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

