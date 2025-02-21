Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5520A5C7
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138938; cv=none; b=nWNWEXkbvDgvS1WK2RiRrFNiAljnnbjgvkIGe4MjU9Ls43mIkcnJne3e7ybiLayr4aH70QtfTDQDu0Pq3DOVij0v63P28MuZw4IRhw2KC7fE5zrT52il+uM5VfwvquaVTAUXYtt1ekKgamxknDOT1xcfMFhEKQTLl39vul7qGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138938; c=relaxed/simple;
	bh=XefC3OLnJGXBmEDKwmrgmOYViuK+vRWoNcQA3GnWtC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gSIXMiAvlNqIHF5nHTXtyYorCC40fBRrxE9xF8Xc2zUFeDTdf9FtYMvaPPCWzXcdoWpiceeLvi/S+KcrIUfntqA3WEJUIns1zpSUPepo+/row4zdrbCPkbDFU98NRkVeJhnwjcv4PyTACsoM4B16RKpMxVYFRmWCniJvlIIEydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRSJQHvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRSJQHvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D4C4CED6;
	Fri, 21 Feb 2025 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740138937;
	bh=XefC3OLnJGXBmEDKwmrgmOYViuK+vRWoNcQA3GnWtC4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dRSJQHvzjIXaaRj9ZjWbYGmJwpChn7lLSsi8ySrdOQWhKsNtYi3AYg04WfT8xPaKj
	 l+PSMHhoFhI78Umg4pW3YUBoQYM7B/DTxo7e/8bmOk+GT8ltDM942sKsvSf3nI23an
	 hZ3AM5Wd63v30SXTwM2/EqD9UkXoGbwbp+7BmgQS5n/mbR1Mov81bVo5AitTnxJS9m
	 +7G18bBDnUorifi/QOFOC5xznyj+KxMmyt1ZkntdtzHgxIQGbWZmw3Jd8ee9wXRhlG
	 TzC8yNefbFu35DZnbnD9cfNX+JAiPtlCDBxLqxRBpWxXawgr0B94X9ZBZJKZrmgTuW
	 b+pIHvuoZm2RA==
Message-ID: <caafdba1-3e3d-4f99-ae66-30add58f87d1@kernel.org>
Date: Fri, 21 Feb 2025 12:55:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next v3 1/2] selftests: mptcp: Add a tool to get specific
 msk_info
Content-Language: en-GB
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1740115494.git.yangang@kylinos.cn>
 <3cd22d64f08ef8564e934a0de0331fc89fd6095b.1740115494.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3cd22d64f08ef8564e934a0de0331fc89fd6095b.1740115494.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang Yan,

On 21/02/2025 06:34, Gang Yan wrote:
> This patch enables the retrieval of the mptcp_info structure corresponding
> to a specified MPTCP socket (msk). When multiple MPTCP connections are
> present, specific information can be obtained for a given connection
> through the 'mptcp_diag_dump_one' by using the 'token' associated with
> the msk.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>

Please add a changelog here next time:

  ---
  Notes:
  - v4:
    - (...)

> ---
>  tools/testing/selftests/net/mptcp/Makefile    |   2 +-
>  .../testing/selftests/net/mptcp/mptcp_diag.c  | 258 ++++++++++++++++++
>  2 files changed, 259 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/mptcp/mptcp_diag.c
> 
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index c76525fe2b84..340e1a777e16 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -7,7 +7,7 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
>  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
>  	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
>  
> -TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
> +TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
>  
>  TEST_FILES := mptcp_lib.sh settings
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> new file mode 100644
> index 000000000000..aec3d99cb948
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025, Kylin Software */
> +
> +#include <linux/sock_diag.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/inet_diag.h>
> +#include <linux/netlink.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <linux/tcp.h>
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <stdio.h>
> +
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
> +#ifndef MPTCP_INFO

I don't think you need this ifdef, because you didn't add:

  #include <linux/mptcp.h>

I think it is easier not to add it to easily deal with the different
kernel versions.

> +struct mptcp_info {
> +	__u8    mptcpi_subflows;
> +	__u8    mptcpi_add_addr_signal;
> +	__u8    mptcpi_add_addr_accepted;
> +	__u8    mptcpi_subflows_max;
> +	__u8    mptcpi_add_addr_signal_max;
> +	__u8    mptcpi_add_addr_accepted_max;
> +	__u32   mptcpi_flags;
> +	__u32   mptcpi_token;
> +	__u64   mptcpi_write_seq;
> +	__u64   mptcpi_snd_una;
> +	__u64   mptcpi_rcv_nxt;
> +	__u8    mptcpi_local_addr_used;
> +	__u8    mptcpi_local_addr_max;
> +	__u8    mptcpi_csum_enabled;
> +	__u32   mptcpi_retransmits;
> +	__u64   mptcpi_bytes_retrans;
> +	__u64   mptcpi_bytes_sent;
> +	__u64   mptcpi_bytes_received;
> +	__u64   mptcpi_bytes_acked;
A few items are missing, see

  https://www.mptcp.dev/mptcp-info.html#mptcp-socket-level

or:


https://github.com/multipath-tcp/mptcp_net-next/blob/export/include/uapi/linux/mptcp.h

Please add them here, and print them below.

> +};
> +
> +#define MPTCP_INFO              1
> +#endif
> +
> +static void die_perror(const char *msg)
> +{
> +	perror(msg);
> +	exit(1);
> +}
> +
> +static void die_usage(int r)
> +{
> +	fprintf(stderr, "Usage: mptcp_diag -t\n");
> +	exit(r);
> +}
> +
> +static void send_query(int fd, __u32 token)
> +{
> +	struct sockaddr_nl nladdr = {
> +		.nl_family = AF_NETLINK
> +	};
> +	struct {
> +		struct nlmsghdr nlh;
> +		struct inet_diag_req_v2 r;
> +	} req = {
> +		.nlh = {
> +			.nlmsg_len = sizeof(req),
> +			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
> +			.nlmsg_flags = NLM_F_REQUEST
> +		},
> +		.r = {
> +			.sdiag_family = AF_INET,
> +			.sdiag_protocol = IPPROTO_MPTCP,
> +			.id.idiag_cookie[0] = token,
> +		}
> +	};
> +	struct rtattr rta_proto;
> +	struct iovec iov[6];
> +	int iovlen = 1;
> +	__u32 proto;
> +
> +	req.r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
> +	proto = IPPROTO_MPTCP;
> +	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
> +	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
> +
> +	iov[0] = (struct iovec) {
> +		.iov_base = &req,
> +		.iov_len = sizeof(req)
> +	};
> +	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
> +	iov[iovlen + 1] = (struct iovec){ &proto, sizeof(proto)};
> +	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
> +	iovlen += 2;
> +	struct msghdr msg = {
> +		.msg_name = &nladdr,
> +		.msg_namelen = sizeof(nladdr),
> +		.msg_iov = iov,
> +		.msg_iovlen = iovlen
> +	};
> +
> +	for (;;) {
> +		if (sendmsg(fd, &msg, 0) < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			die_perror("sendmsg");
> +		}
> +		break;
> +	}
> +}
> +
> +static void parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta,
> +			       int len, unsigned short flags)
> +{
> +	unsigned short type;
> +
> +	memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
> +	while (RTA_OK(rta, len)) {
> +		type = rta->rta_type & ~flags;
> +		if (type <= max && !tb[type])
> +			tb[type] = rta;
> +		rta = RTA_NEXT(rta, len);
> +	}
> +}
> +
> +static void print_info_msg(struct mptcp_info *info)
> +{
> +	printf("Token & Flags\n");
> +	printf("token:	       %x\n", info->mptcpi_token);
> +	printf("flags:	       %x\n", info->mptcpi_flags);
> +	printf("csum_enabled:  %u\n", info->mptcpi_csum_enabled);
> +
> +	printf("\nBasic Info\n");
> +	printf("subflows:            %-5u subflows_max:          %u\n",
> +	       info->mptcpi_subflows,
> +	       info->mptcpi_subflows_max);
> +	printf("local_addr_used:     %-5u local_addr_max:        %u\n",
> +	       info->mptcpi_local_addr_used,
> +	       info->mptcpi_local_addr_max);
> +	printf("add_addr_signal:     %-5u add_addr_accepted:     %u\n",
> +	       info->mptcpi_add_addr_signal,
> +	       info->mptcpi_add_addr_accepted);
> +	printf("add_addr_signal_max: %-5u add_addr_accepted_max: %u\n",
> +	       info->mptcpi_add_addr_signal_max,
> +	       info->mptcpi_add_addr_accepted_max);

It is a good idea to take less space, but it makes the parsing slightly
more complex. Maybe easier to simply print one item per line?

> +
> +	printf("\nTransmission Info\n");
> +	printf("write_seq:	  %llx\n", info->mptcpi_write_seq);
> +	printf("snd_una:	  %llx\n", info->mptcpi_snd_una);
> +	printf("rcv_nxt:	  %llx\n", info->mptcpi_rcv_nxt);
> +	printf("retransmits:	  %u\n", info->mptcpi_retransmits);
> +	printf("retransmit bytes: %llu\n", info->mptcpi_bytes_retrans);
> +	printf("bytes_sent:	  %llu\n", info->mptcpi_bytes_sent);
> +	printf("bytes_received:   %llu\n", info->mptcpi_bytes_received);
> +	printf("bytes_acked:	  %llu\n", info->mptcpi_bytes_acked);
> +}
> +
> +static void parse_nlmsg(struct nlmsghdr *nlh)
> +{
> +	struct inet_diag_msg *r = NLMSG_DATA(nlh);
> +	struct rtattr *tb[INET_DIAG_MAX + 1];
> +	struct mptcp_info *info;
> +
> +	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r + 1),
> +			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
> +			   NLA_F_NESTED);
> +
> +	if (tb[INET_DIAG_INFO]) {
> +		info = RTA_DATA(tb[INET_DIAG_INFO]);

Mmh, I don't think that's safe to use that directly: the mptcp_info
structure has not been frozen in time, new items have been added along
versions. The selftests can be used with any kernel versions, which
means that the "struct mptcp_info" seen at build time by the userspace
might be bigger or smaller than the one used by the kernel being tested.

If it is smaller, it means there will be garbage at the end, and we
should not display that. In this case, it would be better to copy data
from tb[INET_DIAG_INFO] to a local structure. See how it is handled on
IPRoute2 side with ss with the different "info" structures:

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/misc/ss.c#n3324

  if (tb[INET_DIAG_INFO]) {
      struct mptcp_info *info;
      int len = RTA_PAYLOAD(tb[INET_DIAG_INFO]);

      /* workaround for older kernels with less fields */
      if (len < sizeof(*info)) {
          info = alloca(sizeof(*info));
          memcpy(info, RTA_DATA(tb[INET_DIAG_INFO]), len);
          memset((char *)info + len, 0, sizeof(*info) - len);
      } else
          info = RTA_DATA(tb[INET_DIAG_INFO]);

      print_info_msg(info);
  }


> +		print_info_msg(info);
> +	}
> +}
> +
> +static void recv_nlmsg(int fd, struct nlmsghdr *nlh)
> +{
> +	char rcv_buff[8192];
> +	struct sockaddr_nl rcv_nladdr = {
> +		.nl_family = AF_NETLINK
> +	};
> +	struct iovec rcv_iov = {
> +		.iov_base = rcv_buff,
> +		.iov_len = sizeof(rcv_buff)
> +	};
> +	struct msghdr rcv_msg = {
> +		.msg_name = &rcv_nladdr,
> +		.msg_namelen = sizeof(rcv_nladdr),
> +		.msg_iov = &rcv_iov,
> +		.msg_iovlen = 1
> +	};
> +	int len;
> +
> +	len = recvmsg(fd, &rcv_msg, 0);
> +	nlh = (struct nlmsghdr *)rcv_buff;
> +
> +	while (NLMSG_OK(nlh, len)) {
> +		if (nlh->nlmsg_type == NLMSG_DONE) {
> +			printf("NLMSG_DONE\n");
> +			break;
> +		} else if (nlh->nlmsg_type == NLMSG_ERROR) {
> +			struct nlmsgerr *err;
> +
> +			err = (struct nlmsgerr *)NLMSG_DATA(nlh);
> +			printf("Error %d:%s\n",
> +			       -(err->error), strerror(-(err->error)));
> +			break;
> +		}
> +		parse_nlmsg(nlh);
> +		nlh = NLMSG_NEXT(nlh, len);
> +	}
> +}
> +
> +static void get_mptcpinfo(__u32 token)
> +{
> +	struct nlmsghdr *nlh = NULL;
> +	int fd;
> +
> +	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
> +	if (fd < 0)
> +		die_perror("Netlink socket");
> +
> +	send_query(fd, token);
> +	recv_nlmsg(fd, nlh);
> +
> +	close(fd);
> +}
> +
> +static void parse_opts(int argc, char **argv, __u32 *target_token)
> +{
> +	int c;
Please add:

  if (argc < 2)
      die_usage(1)

To make use at least '-t' is passed.

> +
> +	while ((c = getopt(argc, argv, "ht:")) != -1) {
> +		switch (c) {
> +		case 'h':
> +			die_usage(0);
> +			break;
> +		case 't':
> +			sscanf(optarg, "%x", target_token);
> +			break;
> +		default:
> +			die_usage(1);
> +			break;
> +		}
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	__u32 target_token;
> +
> +	parse_opts(argc, argv, &target_token);
> +	get_mptcpinfo(target_token);
> +
> +	return 0;
> +}
> +

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

