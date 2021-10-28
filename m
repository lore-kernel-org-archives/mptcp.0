Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBE2C83
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 00:57:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230153521"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="230153521"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 17:57:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="537781194"
Received: from rasanto1-mobl.amr.corp.intel.com ([10.212.200.198])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 17:57:35 -0700
Date: Wed, 27 Oct 2021 17:57:35 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: add tproxy test case
In-Reply-To: <20211027143041.28449-3-fw@strlen.de>
Message-ID: <bd103756-17a0-a0b8-b235-1a82398f0e7@linux.intel.com>
References: <20211027143041.28449-1-fw@strlen.de> <20211027143041.28449-3-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 27 Oct 2021, Florian Westphal wrote:

> No hard dependencies here, just skip if test environ lacks
> nft binary or the needed kernel config options.
>
> The test case spawns listener in ns2 but ns1 will connect
> to the ip address of ns4.
>
> policy routing + tproxy rule will redirect packets to ns2 instead
> of forward.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 51 +++++++++++-
> .../selftests/net/mptcp/mptcp_connect.sh      | 80 +++++++++++++++++++

Hi Florian -

Could you also update tools/testing/selftests/net/mptcp/config with the 
required kconfig values? My test kernel is definitely missing 
CONFIG_NFT_TPROXY, are others required too?

Thanks,

Mat


> 2 files changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 95e81d557b08..ada9b80774d4 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -75,7 +75,12 @@ struct cfg_cmsg_types {
> 	unsigned int timestampns:1;
> };
>
> +struct cfg_sockopt_types {
> +	unsigned int transparent:1;
> +};
> +
> static struct cfg_cmsg_types cfg_cmsg_types;
> +static struct cfg_sockopt_types cfg_sockopt_types;
>
> static void die_usage(void)
> {
> @@ -93,6 +98,7 @@ static void die_usage(void)
> 	fprintf(stderr, "\t-u -- check mptcp ulp\n");
> 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
> 	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
> +	fprintf(stderr, "\t-o option -- test sockopt <option>\n");
> 	fprintf(stderr,
> 		"\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket\n");
> 	exit(1);
> @@ -185,6 +191,22 @@ static void set_mark(int fd, uint32_t mark)
> 	}
> }
>
> +static void set_transparent(int fd, int pf)
> +{
> +	int one = 1;
> +
> +	switch (pf) {
> +	case AF_INET:
> +		if (-1 == setsockopt(fd, SOL_IP, IP_TRANSPARENT, &one, sizeof(one)))
> +			perror("IP_TRANSPARENT");
> +		break;
> +	case AF_INET6:
> +		if (-1 == setsockopt(fd, IPPROTO_IPV6, IPV6_TRANSPARENT, &one, sizeof(one)))
> +			perror("IPV6_TRANSPARENT");
> +		break;
> +	}
> +}
> +
> static int sock_listen_mptcp(const char * const listenaddr,
> 			     const char * const port)
> {
> @@ -212,6 +234,9 @@ static int sock_listen_mptcp(const char * const listenaddr,
> 				     sizeof(one)))
> 			perror("setsockopt");
>
> +		if (cfg_sockopt_types.transparent)
> +			set_transparent(sock, pf);
> +
> 		if (bind(sock, a->ai_addr, a->ai_addrlen) == 0)
> 			break; /* success */
>
> @@ -944,6 +969,27 @@ static void parse_cmsg_types(const char *type)
> 	exit(1);
> }
>
> +static void parse_setsock_options(const char *name)
> +{
> +	char *next = strchr(name, ',');
> +	unsigned int len = 0;
> +
> +	if (next) {
> +		parse_setsock_options(next + 1);
> +		len = next - name;
> +	} else {
> +		len = strlen(name);
> +	}
> +
> +	if (strncmp(name, "TRANSPARENT", len) == 0) {
> +		cfg_sockopt_types.transparent = 1;
> +		return;
> +	}
> +
> +	fprintf(stderr, "Unrecognized setsockopt option %s\n", name);
> +	exit(1);
> +}
> +
> int main_loop(void)
> {
> 	int fd;
> @@ -1047,7 +1093,7 @@ static void parse_opts(int argc, char **argv)
> {
> 	int c;
>
> -	while ((c = getopt(argc, argv, "6jr:lp:s:hut:T:m:S:R:w:M:P:c:")) != -1) {
> +	while ((c = getopt(argc, argv, "6jr:lp:s:hut:T:m:S:R:w:M:P:c:o:")) != -1) {
> 		switch (c) {
> 		case 'j':
> 			cfg_join = true;
> @@ -1108,6 +1154,9 @@ static void parse_opts(int argc, char **argv)
> 		case 'c':
> 			parse_cmsg_types(optarg);
> 			break;
> +		case 'o':
> +			parse_setsock_options(optarg);
> +			break;
> 		}
> 	}
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 559173a8e387..205e9f0c4296 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -671,6 +671,82 @@ run_tests()
> 	run_tests_lo $1 $2 $3 0
> }
>
> +run_test_transparent()
> +{
> +	local connect_addr="$1"
> +	local msg="$2"
> +
> +	local connector_ns="$ns1"
> +	local listener_ns="$ns2"
> +	local lret=0
> +	local r6flag=""
> +
> +	# skip if we don't want v6
> +	if ! $ipv6 && is_v6 "${connect_addr}"; then
> +		return 0
> +	fi
> +
> +ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
> +flush ruleset
> +table inet mangle {
> +	chain divert {
> +		type filter hook prerouting priority -150;
> +
> +		meta l4proto tcp socket transparent 1 meta mark set 1 accept
> +		tcp dport 20000 tproxy to :20000 meta mark set 1 accept
> +	}
> +}
> +EOF
> +	if [ $? -ne 0 ]; then
> +		echo "SKIP: $msg"
> +		return
> +	fi
> +
> +	local local_addr
> +	if is_v6 "${connect_addr}"; then
> +		local_addr="::"
> +		r6flag="-6"
> +	else
> +		local_addr="0.0.0.0"
> +	fi
> +
> +	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
> +	if [ $? -ne 0 ]; then
> +		ip netns exec "$listener_ns" nft flush ruleset
> +		echo "SKIP: $msg"
> +		return
> +	fi
> +
> +	ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100
> +	if [ $? -ne 0 ]; then
> +		ip netns exec "$listener_ns" nft flush ruleset
> +		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
> +		echo "SKIP: $msg"
> +		return
> +	fi
> +
> +	echo "INFO: test $msg"
> +
> +	TEST_COUNT=10000
> +	local extra_args="-o TRANSPARENT"
> +	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
> +		    ${connect_addr} ${local_addr} "${extra_args}"
> +	lret=$?
> +
> +	ip netns exec "$listener_ns" nft flush ruleset
> +	ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
> +	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
> +
> +	if [ $lret -ne 0 ]; then
> +		echo "FAIL: $msg" 1>&2
> +		ret=$lret
> +		return 1
> +	fi
> +
> +	echo "PASS: $msg"
> +	return 0
> +}
> +
> run_tests_peekmode()
> {
> 	local peekmode="$1"
> @@ -794,5 +870,9 @@ run_tests_peekmode "saveWithPeek"
> run_tests_peekmode "saveAfterPeek"
> stop_if_error "Tests with peek mode have failed"
>
> +# connect to ns4 ip address, ns2 should intercept/proxy
> +run_test_transparent 10.0.3.1 "tproxy ipv4"
> +run_test_transparent dead:beef:3::1 "tproxy ipv6"
> +
> display_time
> exit $ret
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
