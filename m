Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35C29CA
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 01:19:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232420426"
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="232420426"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 17:18:51 -0800
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="503745136"
Received: from ticede-or-153.amr.corp.intel.com ([10.212.186.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 17:18:51 -0800
Date: Tue, 9 Nov 2021 17:18:51 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/3] selftests: mptcp: add TCP_INQ support
In-Reply-To: <20211108105711.16200-3-fw@strlen.de>
Message-ID: <634cff10-1c91-2a68-74cd-3c48da807528@linux.intel.com>
References: <20211108105711.16200-1-fw@strlen.de> <20211108105711.16200-3-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 8 Nov 2021, Florian Westphal wrote:

> Do checks on the returned inq counter.
> Fail on:
> 1. Huge value (>= 1 megabyte, test case files are 1 MB)
> 2. last hint larger than returned bytes when read was short
> 3. erroenous indication of EOF.
>
> 3) happens when a hint of X bytes reads X-1 on next call
>   but next recvmsg returns more data (instead of EOF).
>

Is it possible to do a more deterministic test? Like: one peer sends X 
bytes, other peer waits and then reads X-Y bytes, then checks that the inq 
value is Y?


> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 56 ++++++++++++++++++-
> .../selftests/net/mptcp/mptcp_sockopt.sh      | 10 ++--
> 2 files changed, 60 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index ada9b80774d4..e3e4338d610f 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -73,12 +73,20 @@ static uint32_t cfg_mark;
> struct cfg_cmsg_types {
> 	unsigned int cmsg_enabled:1;
> 	unsigned int timestampns:1;
> +	unsigned int tcp_inq:1;
> };
>
> struct cfg_sockopt_types {
> 	unsigned int transparent:1;
> };
>
> +struct tcp_inq_state {
> +	unsigned int last;
> +	bool expect_eof;
> +};
> +
> +static struct tcp_inq_state tcp_inq;
> +
> static struct cfg_cmsg_types cfg_cmsg_types;
> static struct cfg_sockopt_types cfg_sockopt_types;
>
> @@ -389,7 +397,9 @@ static size_t do_write(const int fd, char *buf, const size_t len)
> static void process_cmsg(struct msghdr *msgh)
> {
> 	struct __kernel_timespec ts;
> +	bool inq_found = false;
> 	bool ts_found = false;
> +	unsigned int inq = 0;
> 	struct cmsghdr *cmsg;
>
> 	for (cmsg = CMSG_FIRSTHDR(msgh); cmsg ; cmsg = CMSG_NXTHDR(msgh, cmsg)) {
> @@ -398,12 +408,27 @@ static void process_cmsg(struct msghdr *msgh)
> 			ts_found = true;
> 			continue;
> 		}
> +		if (cmsg->cmsg_level == IPPROTO_TCP && cmsg->cmsg_type == TCP_CM_INQ) {
> +			memcpy(&inq, CMSG_DATA(cmsg), sizeof(inq));
> +			inq_found = true;
> +			continue;
> +		}
> +
> 	}
>
> 	if (cfg_cmsg_types.timestampns) {
> 		if (!ts_found)
> 			xerror("TIMESTAMPNS not present\n");
> 	}
> +
> +	if (cfg_cmsg_types.tcp_inq) {
> +		if (!inq_found)
> +			xerror("TCP_INQ not present\n");
> +
> +		if (inq >= 1 * 1024 * 1024)
> +			xerror("tcp_inq is larger than one mbyte\n", inq);

Looks like you intended to print the value of inq here but there's no 
format specifier in the format string.

- Mat

> +		tcp_inq.last = inq;
> +	}
> }
>
> static ssize_t do_recvmsg_cmsg(const int fd, char *buf, const size_t len)
> @@ -420,10 +445,23 @@ static ssize_t do_recvmsg_cmsg(const int fd, char *buf, const size_t len)
> 		.msg_controllen = sizeof(msg_buf),
> 	};
> 	int flags = 0;
> +	unsigned int last_hint = tcp_inq.last;
> 	int ret = recvmsg(fd, &msg, flags);
>
> -	if (ret <= 0)
> +	if (ret <= 0) {
> +		if (ret == 0 && tcp_inq.expect_eof)
> +			return ret;
> +
> +		if (ret == 0 && cfg_cmsg_types.tcp_inq)
> +			if (last_hint != 1 && last_hint != 0)
> +				xerror("EOF but last tcp_inq hint was %u\n", last_hint);
> +
> 		return ret;
> +	}
> +
> +	if (tcp_inq.expect_eof)
> +		xerror("expected EOF, last_hint %u, now %u\n",
> +			last_hint, tcp_inq.last);
>
> 	if (msg.msg_controllen && !cfg_cmsg_types.cmsg_enabled)
> 		xerror("got %lu bytes of cmsg data, expected 0\n",
> @@ -435,6 +473,15 @@ static ssize_t do_recvmsg_cmsg(const int fd, char *buf, const size_t len)
> 	if (msg.msg_controllen)
> 		process_cmsg(&msg);
>
> +	if (cfg_cmsg_types.tcp_inq) {
> +		if ((size_t)ret < len && last_hint > (unsigned int)ret) {
> +			if (ret + 1 != (int)last_hint)
> +				xerror("read %u of %u, last_hint was %u\n", ret, (unsigned int)len, last_hint);
> +			else
> +				tcp_inq.expect_eof = true;
> +		}
> +	}
> +
> 	return ret;
> }
>
> @@ -944,6 +991,8 @@ static void apply_cmsg_types(int fd, const struct cfg_cmsg_types *cmsg)
>
> 	if (cmsg->timestampns)
> 		xsetsockopt(fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW, &on, sizeof(on));
> +	if (cmsg->tcp_inq)
> +		xsetsockopt(fd, IPPROTO_TCP, TCP_INQ, &on, sizeof(on));
> }
>
> static void parse_cmsg_types(const char *type)
> @@ -965,6 +1014,11 @@ static void parse_cmsg_types(const char *type)
> 		return;
> 	}
>
> +	if (strncmp(type, "TCPINQ", len) == 0) {
> +		cfg_cmsg_types.tcp_inq = 1;
> +		return;
> +	}
> +
> 	fprintf(stderr, "Unrecognized cmsg option %s\n", type);
> 	exit(1);
> }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 41de643788b8..75af784cc62a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -167,7 +167,7 @@ do_transfer()
> 	:> "$cout"
> 	:> "$sout"
>
> -	mptcp_connect="./mptcp_connect -r 20"
> +	mptcp_connect="./mptcp_connect"
>
> 	local local_addr
> 	if is_v6 "${connect_addr}"; then
> @@ -178,7 +178,7 @@ do_transfer()
>
> 	timeout ${timeout_test} \
> 		ip netns exec ${listener_ns} \
> -			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS \
> +			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
> 				${local_addr} < "$sin" > "$sout" &
> 	spid=$!
>
> @@ -186,7 +186,7 @@ do_transfer()
>
> 	timeout ${timeout_test} \
> 		ip netns exec ${connector_ns} \
> -			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS \
> +			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
> 				$connect_addr < "$cin" > "$cout" &
>
> 	cpid=$!
> @@ -284,8 +284,8 @@ sout=$(mktemp)
> cin=$(mktemp)
> cout=$(mktemp)
> init
> -make_file "$cin" "client" 1
> -make_file "$sin" "server" 1
> +make_file "$cin" "client" 1024
> +make_file "$sin" "server" 1024
> trap cleanup EXIT
>
> run_tests $ns1 $ns2 10.0.1.1
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
