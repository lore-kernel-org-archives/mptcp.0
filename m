Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA4173
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628766871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH05GpSk9zSpvA6Ou9e+Chbshf0QpvKnV5Svfk4AB54=;
	b=Yr5poAxx1mnepUL5IC0xflniKlS3K68c+q9iW08E2Hy0w5B91kmjRCifFg4QOlJsj27fG0
	QbLrFBv+efWRze21Blo8W3waXddaiMACbENsQGNnKyruDaKwXY2jOVLm/yvuwYS2fJh8Jy
	odpKR5KDC3MocsqrbDpq/Xa9JoebbZo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-9XpwetqcPG6sfSRozx_ILQ-1; Thu, 12 Aug 2021 07:14:29 -0400
X-MC-Unique: 9XpwetqcPG6sfSRozx_ILQ-1
Received: by mail-wr1-f69.google.com with SMTP id k15-20020a5d628f0000b029015501bab520so1709464wru.16
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 04:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oH05GpSk9zSpvA6Ou9e+Chbshf0QpvKnV5Svfk4AB54=;
        b=RNSqsFgJHEedb5wb3J7/tT48ffSenzpvrPkXII5HNsUu5BTvc3KQSLMTV0O0blwwnG
         A1192ssguEV0nkkKDg1nBVrZTm8LRH6k4afZR6J48/rXdU1oJ+xTVkoMHZMxKLuq6QT4
         zry+ELjtKy/a6aZR4+XOVU+pmQn7QeNG8A4MiP8DfxlMQcjvntuXzdGcxYRgs4rJC7+8
         wIJWjSiDRTN3cUmSE9l40YwcTqlNvPLb+uZkVl3FL8fDnXXZw5Uov7+G+DMDSeRgzU9n
         gfqNm2ec7cDgvLBDervtlhYkDUa3Cg/keI2psbvYt+BppEDxgj1uglvwQM5zNgde733u
         x14Q==
X-Gm-Message-State: AOAM530iiq2/UjZypKGk6SdqNQG5496F6fjHxjeq4uMImfOoaZ1j89hb
	CLa9z0HcRT7X4uoeShukXvLH+KwGldtw7vcLVMcJBOlLPOKQh6uzBnw+x68j4p9a8T4RAMy0OdB
	FzeEXdqlRoM1lox0=
X-Received: by 2002:adf:ed0a:: with SMTP id a10mr3469786wro.30.1628766868613;
        Thu, 12 Aug 2021 04:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvIFu6jqn3+e8x5XkBlUJiX3J9hj66PCpF4A/jU6/4yc2EHmsoC2QW17jjdFMkffdX5QPAug==
X-Received: by 2002:adf:ed0a:: with SMTP id a10mr3469771wro.30.1628766868440;
        Thu, 12 Aug 2021 04:14:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id i8sm5196676wma.7.2021.08.12.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 04:14:28 -0700 (PDT)
Message-ID: <442435228e4ef69a6b2eff0d968d7fe78a08863a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 5/5] selftests: mptcp: add mptcp getsockopt
 test cases
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Thu, 12 Aug 2021 13:14:27 +0200
In-Reply-To: <20210811131523.6339-6-fw@strlen.de>
References: <20210811131523.6339-1-fw@strlen.de>
	 <20210811131523.6339-6-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I'm sorry, I skipped over this patch before sending my previous reply.

On Wed, 2021-08-11 at 15:15 +0200, Florian Westphal wrote:
> Add a test program that retrieves the three info types:
> 1. mptcp meta information
> 2. tcp info for subflow
> 3. subflow endpoint addresses
> 
> For all three rudimentary checks are added.
> 
> 1. Meta information checks that the logical mptcp
>    sequence numbers advance as expected, based on the bytes read
>    (init seq + bytes_received/sent) and the connection state
>    (after close, we should exect 1 extra byte due to FIN).
> 
> 2. TCP info checks the number of bytes sent/received vs.
>    sums of read/write syscall return values.
> 
> 3. Subflow endpoint addresses are checked vs. getsockname/getpeername
>    result.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  tools/testing/selftests/net/mptcp/Makefile    |   4 +-
>  .../selftests/net/mptcp/mptcp_sockopt.c       | 545 ++++++++++++++++++
>  .../selftests/net/mptcp/mptcp_sockopt.sh      |  31 +-
>  3 files changed, 576 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> 
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index f1464f09b080..7437929a2109 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -6,9 +6,9 @@ KSFT_KHDR_INSTALL := 1
>  CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
>  
>  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
> -	      simult_flows.sh mptcp_sockopt.sh
> +	      simult_flows.sh mptcp_sockopt.sh mptcp_sockopt.sh

I guess this change is not needed.

> -TEST_GEN_FILES = mptcp_connect pm_nl_ctl
> +TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt
>  
>  TEST_FILES := settings
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> new file mode 100644
> index 000000000000..522b394fe011
> --- /dev/null
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -0,0 +1,545 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <string.h>
> +#include <stdarg.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <strings.h>
> +#include <unistd.h>
> +
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
> +#include <netdb.h>
> +#include <netinet/in.h>
> +
> +#include <linux/tcp.h>
> +
> +static int pf = AF_INET;
> +
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +#ifndef SOL_MPTCP
> +#define SOL_MPTCP 284
> +#endif
> +
> +#ifndef TCP_TCPINFO
> +struct mptcp_subflow_data {
> +	__u32		size_subflow_data;		/* size of this structure in userspace */
> +	__u32		num_subflows;			/* must be 0, set by kernel */
> +	__u32		size_kernel;			/* must be 0, set by kernel */
> +	__u32		size_user;			/* size of one element in data[] */
> +} __attribute__((aligned(8)));
> +
> +struct mptcp_subflow_addrs {
> +	union {
> +		sa_family_t sa_family;
> +		struct sockaddr sa_local;
> +		struct sockaddr_in sin_local;
> +		struct sockaddr_in6 sin6_local;
> +		struct sockaddr_storage ss_local;
> +	};
> +	union {
> +		struct sockaddr sa_remote;
> +		struct sockaddr_in sin_remote;
> +		struct sockaddr_in6 sin6_remote;
> +		struct sockaddr_storage ss_remote;
> +	};
> +};
> +
> +#define MPTCP_INFO		1
> +#define MPTCP_TCPINFO		2
> +#define MPTCP_SUBFLOW_ADDRS	3
> +#endif
> +
> +struct mptcp_info {
> +	__u8	mptcpi_subflows;
> +	__u8	mptcpi_add_addr_signal;
> +	__u8	mptcpi_add_addr_accepted;
> +	__u8	mptcpi_subflows_max;
> +	__u8	mptcpi_add_addr_signal_max;
> +	__u8	mptcpi_add_addr_accepted_max;
> +	__u32	mptcpi_flags;
> +	__u32	mptcpi_token;
> +	__u64	mptcpi_write_seq;
> +	__u64	mptcpi_snd_una;
> +	__u64	mptcpi_rcv_nxt;
> +	__u8	mptcpi_local_addr_used;
> +	__u8	mptcpi_local_addr_max;
> +	__u8	mptcpi_csum_enabled;
> +};
> +
> +enum sockopt_check_flags {
> +	EOF_RECEIVED = 1 << 0,
> +};
> +
> +struct so_state {
> +	struct mptcp_info mi;
> +};
> +
> +static void die_perror(const char *msg)
> +{
> +	perror(msg);
> +	exit(1);
> +}
> +
> +static void die_usage(int r)
> +{
> +	fprintf(stderr, "Usage: mptcp_sockopt [-6]\n");
> +	exit(r);
> +}
> +
> +static void xerror(const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	vfprintf(stderr, fmt, ap);
> +	va_end(ap);
> +	fputc('\n', stderr);
> +	exit(1);
> +}
> +
> +static const char *getxinfo_strerr(int err)
> +{
> +	if (err == EAI_SYSTEM)
> +		return strerror(errno);
> +
> +	return gai_strerror(err);
> +}
> +
> +static void xgetaddrinfo(const char *node, const char *service,
> +			 const struct addrinfo *hints,
> +			 struct addrinfo **res)
> +{
> +	int err = getaddrinfo(node, service, hints, res);
> +
> +	if (err) {
> +		const char *errstr = getxinfo_strerr(err);
> +
> +		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
> +			node ? node : "", service ? service : "", errstr);
> +		exit(1);
> +	}
> +}
> +
> +static int sock_listen_mptcp(const char * const listenaddr,
> +			     const char * const port)
> +{
> +	int sock;
> +	struct addrinfo hints = {
> +		.ai_protocol = IPPROTO_TCP,
> +		.ai_socktype = SOCK_STREAM,
> +		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
> +	};
> +
> +	hints.ai_family = pf;
> +
> +	struct addrinfo *a, *addr;
> +	int one = 1;
> +
> +	xgetaddrinfo(listenaddr, port, &hints, &addr);
> +	hints.ai_family = pf;
> +
> +	for (a = addr; a; a = a->ai_next) {
> +		sock = socket(a->ai_family, a->ai_socktype, IPPROTO_MPTCP);
> +		if (sock < 0)
> +			continue;
> +
> +		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
> +				     sizeof(one)))
> +			perror("setsockopt");
> +
> +		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
> +			break; /* success */
> +
> +		perror("bind");
> +		close(sock);
> +		sock = -1;
> +	}
> +
> +	freeaddrinfo(addr);
> +
> +	if (sock < 0)
> +		xerror("could not create listen socket");
> +
> +	if (listen(sock, 20))
> +		die_perror("listen");
> +
> +	return sock;
> +}
> +
> +static int sock_connect_mptcp(const char * const remoteaddr,
> +			      const char * const port, int proto)
> +{
> +	struct addrinfo hints = {
> +		.ai_protocol = IPPROTO_TCP,
> +		.ai_socktype = SOCK_STREAM,
> +	};
> +	struct addrinfo *a, *addr;
> +	int sock = -1;
> +
> +	hints.ai_family = pf;
> +
> +	xgetaddrinfo(remoteaddr, port, &hints, &addr);
> +	for (a = addr; a; a = a->ai_next) {
> +		sock = socket(a->ai_family, a->ai_socktype, proto);
> +		if (sock < 0)
> +			continue;
> +
> +		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
> +			break; /* success */
> +
> +		die_perror("connect");
> +	}
> +
> +	if (sock < 0)
> +		xerror("could not create connect socket");
> +
> +	freeaddrinfo(addr);
> +	return sock;
> +}
> +
> +static void parse_opts(int argc, char **argv)
> +{
> +	int c;
> +
> +	while ((c = getopt(argc, argv, "h6")) != -1) {
> +		switch (c) {
> +		case 'h':
> +			die_usage(0);
> +			break;
> +		case '6':
> +			pf = AF_INET6;
> +			break;
> +		default:
> +			die_usage(1);
> +			break;
> +		}
> +	}
> +}
> +
> +static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t r, size_t w, uint32_t flags)
> +{
> +	struct mptcp_info i;
> +	socklen_t olen;
> +	int ret;
> +
> +	olen = sizeof(i);
> +	ret = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &i, &olen);
> +
> +	if (ret < 0)
> +		die_perror("getsockopt MPTCP_INFO");
> +
> +	assert(olen == sizeof(i));
> +
> +	if (s->mi.mptcpi_write_seq == 0)
> +		s->mi = i;
> +
> +	assert(s->mi.mptcpi_write_seq + w == i.mptcpi_write_seq);
> +
> +	if (flags & EOF_RECEIVED)
> +		r += 1;
> +
> +	assert(s->mi.mptcpi_rcv_nxt + r == i.mptcpi_rcv_nxt);
> +}
> +
> +static void do_getsockopt_tcp_info(int fd, size_t r, size_t w)
> +{
> +	struct my_tcp_info {
> +		struct mptcp_subflow_data d;
> +		struct tcp_info ti[2];
> +	} ti;
> +	socklen_t olen;
> +	int ret;
> +
> +	memset(&ti, 0, sizeof(ti));
> +
> +	ti.d.size_subflow_data = sizeof(struct mptcp_subflow_data);
> +	ti.d.size_user = sizeof(struct tcp_info);
> +	olen = sizeof(ti);
> +
> +	ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
> +	if (ret < 0)
> +		die_perror("getsockopt MPTCP_TCPINFO");

Perhaps we could add some test case for weird lens: too short olen,
size_user gretaer then olen, size_user smaller then size_kernel, WDYT?

Thanks!

/P

