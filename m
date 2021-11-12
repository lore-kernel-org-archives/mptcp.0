Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA068
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 04:30:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="233315773"
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="233315773"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 20:30:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="602869463"
Received: from neelchat-mobl2.amr.corp.intel.com ([10.209.109.125])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 20:30:29 -0800
Date: Thu, 11 Nov 2021 20:30:29 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 4/4] selftests: mptcp: add inq test case
In-Reply-To: <acb4e241-3da7-621a-2ca8-58e4cdf7ac4d@linux.intel.com>
Message-ID: <1945c69d-3aa1-4d8b-226a-2a7fc1ffb1e3@linux.intel.com>
References: <20211111151418.17276-1-fw@strlen.de> <20211111151418.17276-5-fw@strlen.de> <acb4e241-3da7-621a-2ca8-58e4cdf7ac4d@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Nov 2021, Mat Martineau wrote:

> On Thu, 11 Nov 2021, Florian Westphal wrote:
>
>> client & server use a unix socket connection to communicate
>> outside of the mptcp connection.
>> 
>> This allows the consumer to know in advance how many bytes have been
>> (or will be) sent by the peer.
>> This allows stricter checks on the bytecounts reported by TCP_INQ cmsg.
>> 
>> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> Signed-off-by: Florian Westphal <fw@strlen.de>
>> ---
>> tools/testing/selftests/net/mptcp/.gitignore  |   1 +
>> tools/testing/selftests/net/mptcp/Makefile    |   2 +-
>> tools/testing/selftests/net/mptcp/mptcp_inq.c | 603 ++++++++++++++++++
>> .../selftests/net/mptcp/mptcp_sockopt.sh      |  40 ++
>> 4 files changed, 645 insertions(+), 1 deletion(-)
>> create mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c
>> 
>> diff --git a/tools/testing/selftests/net/mptcp/.gitignore 
>> b/tools/testing/selftests/net/mptcp/.gitignore
>> index 7569d892967a..49daae73c41e 100644
>> --- a/tools/testing/selftests/net/mptcp/.gitignore
>> +++ b/tools/testing/selftests/net/mptcp/.gitignore
>> @@ -1,5 +1,6 @@
>> # SPDX-License-Identifier: GPL-2.0-only
>> mptcp_connect
>> +mptcp_inq
>> mptcp_sockopt
>> pm_nl_ctl
>> *.pcap
>> diff --git a/tools/testing/selftests/net/mptcp/Makefile 
>> b/tools/testing/selftests/net/mptcp/Makefile
>> index bbf4e448bad9..0356c4501c99 100644
>> --- a/tools/testing/selftests/net/mptcp/Makefile
>> +++ b/tools/testing/selftests/net/mptcp/Makefile
>> @@ -8,7 +8,7 @@ CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g 
>> -I$(top_srcdir)/usr/include
>> TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
>> 	      simult_flows.sh mptcp_sockopt.sh
>> 
>> -TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt
>> +TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
>> 
>> TEST_FILES := settings
>> 
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c 
>> b/tools/testing/selftests/net/mptcp/mptcp_inq.c
>> new file mode 100644
>> index 000000000000..62ee2dd63b5f
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
>> @@ -0,0 +1,603 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include <assert.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <limits.h>
>> +#include <string.h>
>> +#include <stdarg.h>
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +#include <inttypes.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <strings.h>
>> +#include <unistd.h>
>> +#include <time.h>
>> +
>> +#include <sys/ioctl.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/socket.h>
>> +#include <sys/types.h>
>> +#include <sys/wait.h>
>> +
>> +#include <netdb.h>
>> +#include <netinet/in.h>
>> +
>> +#include <linux/tcp.h>
>> +#include <linux/sockios.h>
>> +
>> +#ifndef IPPROTO_MPTCP
>> +#define IPPROTO_MPTCP 262
>> +#endif
>> +#ifndef SOL_MPTCP
>> +#define SOL_MPTCP 284
>> +#endif
>> +
>> +static int pf = AF_INET;
>> +static int proto_tx = IPPROTO_MPTCP;
>> +static int proto_rx = IPPROTO_MPTCP;
>> +
>> +static void die_perror(const char *msg)
>> +{
>> +	perror(msg);
>> +	exit(1);
>> +}
>> +
>> +static void die_usage(int r)
>> +{
>> +	fprintf(stderr, "Usage: mptcp_inq [-6] [ -t tcp|mptcp ] [ -r 
>> tcp|mptcp]\n");
>> +	exit(r);
>> +}
>> +
>> +static void xerror(const char *fmt, ...)
>> +{
>> +	va_list ap;
>> +
>> +	va_start(ap, fmt);
>> +	vfprintf(stderr, fmt, ap);
>> +	va_end(ap);
>> +	fputc('\n', stderr);
>> +	exit(1);
>> +}
>> +
>> +static const char *getxinfo_strerr(int err)
>> +{
>> +	if (err == EAI_SYSTEM)
>> +		return strerror(errno);
>> +
>> +	return gai_strerror(err);
>> +}
>> +
>> +static void xgetaddrinfo(const char *node, const char *service,
>> +			 const struct addrinfo *hints,
>> +			 struct addrinfo **res)
>> +{
>> +	int err = getaddrinfo(node, service, hints, res);
>> +
>> +	if (err) {
>> +		const char *errstr = getxinfo_strerr(err);
>> +
>> +		fprintf(stderr, "Fatal: getaddrinfo(%s:%s): %s\n",
>> +			node ? node : "", service ? service : "", errstr);
>> +		exit(1);
>> +	}
>> +}
>> +
>> +static int sock_listen_mptcp(const char * const listenaddr,
>> +			     const char * const port)
>> +{
>> +	int sock;
>> +	struct addrinfo hints = {
>> +		.ai_protocol = IPPROTO_TCP,
>> +		.ai_socktype = SOCK_STREAM,
>> +		.ai_flags = AI_PASSIVE | AI_NUMERICHOST
>> +	};
>> +
>> +	hints.ai_family = pf;
>> +
>> +	struct addrinfo *a, *addr;
>> +	int one = 1;
>> +
>> +	xgetaddrinfo(listenaddr, port, &hints, &addr);
>> +	hints.ai_family = pf;
>> +
>> +	for (a = addr; a; a = a->ai_next) {
>> +		sock = socket(a->ai_family, a->ai_socktype, proto_rx);
>> +		if (sock < 0)
>> +			continue;
>> +
>> +		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
>> +				     sizeof(one)))
>> +			perror("setsockopt");
>> +
>> +		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
>> +			break; /* success */
>> +
>> +		perror("bind");
>> +		close(sock);
>> +		sock = -1;
>> +	}
>> +
>> +	freeaddrinfo(addr);
>> +
>> +	if (sock < 0)
>> +		xerror("could not create listen socket");
>> +
>> +	if (listen(sock, 20))
>> +		die_perror("listen");
>> +
>> +	return sock;
>> +}
>> +
>> +static int sock_connect_mptcp(const char * const remoteaddr,
>> +			      const char * const port, int proto)
>> +{
>> +	struct addrinfo hints = {
>> +		.ai_protocol = IPPROTO_TCP,
>> +		.ai_socktype = SOCK_STREAM,
>> +	};
>> +	struct addrinfo *a, *addr;
>> +	int sock = -1;
>> +
>> +	hints.ai_family = pf;
>> +
>> +	xgetaddrinfo(remoteaddr, port, &hints, &addr);
>> +	for (a = addr; a; a = a->ai_next) {
>> +		sock = socket(a->ai_family, a->ai_socktype, proto);
>> +		if (sock < 0)
>> +			continue;
>> +
>> +		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
>> +			break; /* success */
>> +
>> +		die_perror("connect");
>> +	}
>> +
>> +	if (sock < 0)
>> +		xerror("could not create connect socket");
>> +
>> +	freeaddrinfo(addr);
>> +	return sock;
>> +}
>> +
>> +static int protostr_to_num(const char *s)
>> +{
>> +	if (strcasecmp(s, "tcp") == 0)
>> +		return IPPROTO_TCP;
>> +	if (strcasecmp(s, "mptcp") == 0)
>> +		return IPPROTO_MPTCP;
>> +
>> +	die_usage(1);
>> +	return 0;
>> +}
>> +
>> +static void parse_opts(int argc, char **argv)
>> +{
>> +	int c;
>> +
>> +	while ((c = getopt(argc, argv, "h6t:r:")) != -1) {
>> +		switch (c) {
>> +		case 'h':
>> +			die_usage(0);
>> +			break;
>> +		case '6':
>> +			pf = AF_INET6;
>> +			break;
>> +		case 't':
>> +			proto_tx = protostr_to_num(optarg);
>> +			break;
>> +		case 'r':
>> +			proto_rx = protostr_to_num(optarg);
>> +			break;
>> +		default:
>> +			die_usage(1);
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +/* wait up to timeout milliseconds */
>> +static void wait_for_ack(int fd, int timeout, size_t total)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < timeout; i++) {
>> +		int nsd, ret, queued = -1;
>> +		struct timespec req;
>> +
>> +		ret = ioctl(fd, TIOCOUTQ, &queued);
>> +		if (ret < 0)
>> +			die_perror("TIOCOUTQ");
>> +
>> +		ret = ioctl(fd, SIOCOUTQNSD, &nsd);
>> +		if (ret < 0)
>> +			die_perror("SIOCOUTQNSD");
>> +
>> +		if ((size_t)queued > total)
>> +			xerror("TIOCOUTQ %u, but only %zu expected\n", 
>> queued, total);
>> +		assert(nsd <= queued);
>> +
>> +		if (queued == 0)
>> +			return;
>> +
>> +		/* wait for peer to ack rx of all data */
>> +		req.tv_sec = 0;
>> +		req.tv_nsec = 1 * 1000 * 1000ul; /* 1ms */
>> +		nanosleep(&req, NULL);
>> +	}
>> +
>> +	xerror("still tx data queued after %u ms\n", timeout);
>> +}
>> +
>> +static void connect_one_server(int fd, int unixfd)
>> +{
>> +	size_t len, i, total, sent;
>> +	char buf[4096], buf2[4096];
>> +	int queued, on = 1;
>
> I got a compile warning on the above line due to unused variables. Matthieu 
> could maybe delete the above line when applying.
>
> Thanks for adding this test case, I ran the tests in this series in a loop 
> for a while and did not see any failures.
>
> Matthieu, there's also a small reverse-xmas fix in patch 3. If Florian 
> doesn't want to add the optional sk_receive_queue splice in patch 3 I'm ok 
> with adding the series to the export branch with the line above deleted and 
> the reverse-xmas fix. Or you can ask for a v3 :)
>

To be clear, I did skip the "Reviewed-by" tag intentionally given the 
outstanding question in patch 3, but I can add my signoff later if this is 
applied to export with the noted minor fixes.

--
Mat Martineau
Intel
