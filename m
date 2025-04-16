Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD821D3F4
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792771; cv=none; b=c36H/axbPNwELkxsozvpfNaaO0VfMgdnh5Q6RyQSMYHHoEWaMvioPQXepSRE/oO8L8ThVHMjrhDPRs3CA9DuCt4GZfNyquIeQQp5GLR3HwY9IqK1YvgjYlAgoP0NS+eRcOd5BkugjltP3ug64bA7jaA4Hf+is+aZ34ZUzS5Zeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792771; c=relaxed/simple;
	bh=6DuioohKt46Xh6FPPSxNZ+s/GbMqqFMQXTIDCmvXa0w=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=qidbdYTWsC3ahsIl50UyMRd1ND6kLxUTJ41I05NJkKpJ8kV84B7PoILYyCaevaIBG2j6LELLeE1WkeKq6FzTVTZYr2cpS/gBGbePlbsJJkORJQAN6mNNOgq7MgrT1Lo/RpbuI+Nscijy0OPO/mufjQP9JAKvet0suMQQ/BLezEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2bY/VLR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2bY/VLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55297C4CEE2;
	Wed, 16 Apr 2025 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744792770;
	bh=6DuioohKt46Xh6FPPSxNZ+s/GbMqqFMQXTIDCmvXa0w=;
	h=Subject:From:To:In-Reply-To:References:Date:From;
	b=P2bY/VLRaJN4n0SJtNaLDfgtxAIHhRBgvN69UfZeAV469MsgwcCOG+TNeU43HsamH
	 Obw0XvA+LUnNAD+RtOBjeCnwMXuiSf/i+V8Y6bBKf+kvLwHPPdBo1P2JPBYUlcsVnK
	 2BCcab18BQYYKdFdnAFqn4VXDcVQ6CGWQ0Mc0EiM/uBD3BnOH+2QHvI2pBA+GZDZxp
	 fdjY+V82RJZHfKyKesDsEoBsp+HQHMHrkDLiWRPJGnK7bIbX2m2jPxL4sWwTAe3BFW
	 G7JbyOE6Vw9DNxI6SaoxNfYhnACG+eb3UXKfbe6e+TZL9Jk4kQBjgt0RB3gGnH/VrK
	 e9IzfSe8J1hmQ==
Message-ID: <84ce45ec223a7953a4208ca23b8bb0f270e6c89b.camel@kernel.org>
Subject: Re: [mptcp-next 5/7] selftests: mptcp: add a helper to get
 subflow_info
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
In-Reply-To: <4147cca0b271a635059089415cf51a6072389c1c.1744788247.git.yangang@kylinos.cn>
References: <cover.1744788247.git.yangang@kylinos.cn>
	 <4147cca0b271a635059089415cf51a6072389c1c.1744788247.git.yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Apr 2025 16:35:11 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.52.3-0ubuntu1 
Content-Transfer-Encoding: 8bit

Hi Gang,

On Wed, 2025-04-16 at 15:35 +0800, Gang Yan wrote:
> This patch adds 'get_subflow_info' in 'mptcp_diag', which can check
> whether
> a TCP connection is an MPTCP subflow based on the
> "INET_ULP_INFO_MPTCP"
> with tcp_diag method.
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_diag.c  | 68
> ++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index 2116b40bc927..03c92940e461 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -8,6 +8,7 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #include <linux/tcp.h>
> +#include <arpa/inet.h>
>  
>  #include <unistd.h>
>  #include <stdlib.h>
> @@ -19,8 +20,13 @@
>  #define IPPROTO_MPTCP 262
>  #endif
>  
> +#define parse_rtattr_nested(tb, max, rta) \
> +	(parse_rtattr_flags((tb), (max), RTA_DATA(rta),
> RTA_PAYLOAD(rta), \
> +			    NLA_F_NESTED))
> +
>  struct params {
>  	__u32 target_token;
> +	char subflow_addr[1024];
>  };
>  
>  struct mptcp_info {
> @@ -58,7 +64,9 @@ static void die_perror(const char *msg)
>  
>  static void die_usage(int r)
>  {
> -	fprintf(stderr, "Usage: mptcp_diag -t\n");
> +	fprintf(stderr, "Usage:\n"
> +			"mptcp_diag -t <token>\n"
> +			"mptcp_diag -s \"<saddr> <sport> <daddr>
> <dport>\"\n");
>  	exit(r);
>  }
>  
> @@ -182,6 +190,21 @@ static void parse_nlmsg(struct nlmsghdr *nlh,
> __u32 proto)
>  		}
>  		print_info_msg(info);
>  	}
> +	if (proto == IPPROTO_TCP && tb[INET_DIAG_ULP_INFO]) {
> +		struct rtattr *ulpinfo[INET_ULP_INFO_MAX + 1] = { 0
> };
> +
> +		parse_rtattr_nested(ulpinfo, INET_ULP_INFO_MAX,
> +				    tb[INET_DIAG_ULP_INFO]);
> +
> +		if (ulpinfo[INET_ULP_INFO_MPTCP]) {
> +			struct rtattr *sfinfo[MPTCP_SUBFLOW_ATTR_MAX
> + 1] = { 0 };
> +
> +			parse_rtattr_nested(sfinfo,
> MPTCP_SUBFLOW_ATTR_MAX,
> +					   
> ulpinfo[INET_ULP_INFO_MPTCP]);

CI complains this:

selftests - selftests: Commit: 0ce1b7bc31 selftests: mptcp: add a
helper to get subflow_info
  make: Entering directory
'/github/workspace/tools/testing/selftests/net/mptcp'
    CC       mptcp_diag
  mptcp_diag.c: In function 'parse_nlmsg':
  mptcp_diag.c:200:47: error: 'MPTCP_SUBFLOW_ATTR_MAX' undeclared
(first use in this function)
    200 |                         struct rtattr
*sfinfo[MPTCP_SUBFLOW_ATTR_MAX + 1] = { 0 };
        |                                              
^~~~~~~~~~~~~~~~~~~~~~
  mptcp_diag.c:200:47: note: each undeclared identifier is reported
only once for each function it appears in
  mptcp_diag.c:200:40: warning: unused variable 'sfinfo' [-Wunused-
variable]
    200 |                         struct rtattr
*sfinfo[MPTCP_SUBFLOW_ATTR_MAX + 1] = { 0 };
        |                                        ^~~~~~
  make: *** [../../lib.mk:222:
/github/workspace/tools/testing/selftests/net/mptcp/mptcp_diag] Error 1
  make: Leaving directory
'/github/workspace/tools/testing/selftests/net/mptcp'
 
4147cca0b271a635059089415cf51a6072389c1c.1744788247.git.yangang@kylinos.cn
fail Build error with: make -C tools/testing/selftests/net/mptcp
  ERROR: Unable to compile selftests
ERROR: Unable to validate one commit: 0ce1b7bc31 selftests: mptcp: add
a helper to get subflow_info

> +		} else {
> +			printf("It's a normal TCP!\n");
> +		}
> +	}
>  }
>  
>  static void recv_nlmsg(int fd, __u32 proto)
> @@ -244,6 +267,41 @@ static void get_mptcpinfo(__u32 token)
>  	close(fd);
>  }
>  
> +static void get_subflow_info(char *subflow_addr)
> +{
> +	struct inet_diag_req_v2 r = {
> +		.sdiag_family           = AF_INET,
> +		.sdiag_protocol         = IPPROTO_TCP,
> +	};
> +	int sport, dport;
> +	char saddr[64];	// Take ipv6 into consideration
> +	char daddr[64];
> +	int ret;
> +	int fd;
> +
> +	ret = sscanf(subflow_addr, "%s %d %s %d", saddr, &sport,
> daddr, &dport);
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
> +	r.id.idiag_sport = htons(sport);
> +	r.id.idiag_dport = htons(dport);
> +	r.id.idiag_if = 0;
> +
> +	inet_pton(AF_INET, saddr, &r.id.idiag_src);
> +	inet_pton(AF_INET, daddr, &r.id.idiag_dst);
> +	r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
> +	send_query(fd, &r, IPPROTO_TCP);
> +	recv_nlmsg(fd, IPPROTO_TCP);
> +}
> +
>  static void parse_opts(int argc, char **argv, struct params *p)
>  {
>  	int c;
> @@ -251,7 +309,7 @@ static void parse_opts(int argc, char **argv,
> struct params *p)
>  	if (argc < 2)
>  		die_usage(1);
>  
> -	while ((c = getopt(argc, argv, "ht:")) != -1) {
> +	while ((c = getopt(argc, argv, "ht:s:")) != -1) {
>  		switch (c) {
>  		case 'h':
>  			die_usage(0);
> @@ -259,6 +317,9 @@ static void parse_opts(int argc, char **argv,
> struct params *p)
>  		case 't':
>  			sscanf(optarg, "%x", &p->target_token);
>  			break;
> +		case 's':
> +			snprintf(p->subflow_addr, strlen(optarg) +
> 1, "%s", optarg);
> +			break;
>  		default:
>  			die_usage(1);
>  			break;
> @@ -275,6 +336,9 @@ int main(int argc, char *argv[])
>  	if (p.target_token)
>  		get_mptcpinfo(p.target_token);
>  
> +	if (strlen(p.subflow_addr) != 0)
> +		get_subflow_info(p.subflow_addr);
> +
>  	return 0;
>  }
>  

