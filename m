Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B81C26
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655938100; x=1687474100;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nZBJzt6StDPnTOI/kUaoQA4QkZToeP1qqqGZo7WfexM=;
  b=QPbKZT6AE9vtj2KkSi00J/hI53jZBMiJBjtmEjMi2u+OWFKa2fvaYYw4
   6EFr4jwAx/o85yu2+jwIIYZApog9uTnWuDxb8YbjBatdjB/oXQFSG18Kj
   kJjEHH7hjAAxcxEw6LvWG8SfAwyuSVAZlQd1/yLTFpTklxHrxTN60TIHG
   H5W7MYzapRKY5Sd/8glRA6HrYN97//dWfw/3d++1kk8GtQDnDkR4E/jZ4
   lo1IHIZDh4MR87Q1j6ezK17gIvRMdsJYKSf1u/4W/skwbAK9+FmXRc0A9
   MB0yayLVe+oVFjhum6tyIOkV2922tV6K4pZVlhnUgamI9CeT3I9+145wf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263599015"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="263599015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:48:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="621093661"
Received: from desireen-mobl.amr.corp.intel.com ([10.209.126.32])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:48:20 -0700
Date: Wed, 22 Jun 2022 15:48:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: userspace PM support
 for MP_PRIO signals
In-Reply-To: <20220622175547.289717-3-kishen.maloor@intel.com>
Message-ID: <ab178e0-217b-2d9c-15ae-13d0ddc4f20@linux.intel.com>
References: <20220622175547.289717-1-kishen.maloor@intel.com> <20220622175547.289717-3-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 22 Jun 2022, Kishen Maloor wrote:

> This change updates the testing sample (pm_nl_ctl) to take a
> connection token as an optional param for the MPTCP_PM_CMD_SET_FLAGS
> command. This is used to test the userspace PM code path for issuing
> MP_PRIO signals over a connection for the specified address ID.
>
> E.g. ./pm_nl_ctl set id 0 flags backup token 823274047
>
> userspace_pm.sh has new selftests which exercise this command.
>
> Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 19 ++++++++++--
> .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++++++++++++++++
> 2 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index 4dd87bb9ee91..0512d64b1d11 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -39,7 +39,7 @@ static void syntax(char *argv[])
> 	fprintf(stderr, "\tdsf lip <local-ip> lport <local-port> rip <remote-ip> rport <remote-port> token <token>\n");
> 	fprintf(stderr, "\tdel <id> [<ip>]\n");
> 	fprintf(stderr, "\tget <id>\n");
> -	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>]\n");
> +	fprintf(stderr, "\tset [<ip>] [id <nr>] flags [no]backup|[no]fullmesh [port <nr>] [token <token>]\n");
> 	fprintf(stderr, "\tflush\n");
> 	fprintf(stderr, "\tdump\n");
> 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
> @@ -1279,6 +1279,7 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
> 	struct rtattr *rta, *nest;
> 	struct nlmsghdr *nh;
> 	u_int32_t flags = 0;
> +	u_int32_t token = 0;
> 	u_int16_t family;
> 	int nest_start;
> 	int use_id = 0;
> @@ -1339,7 +1340,13 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
> 		error(1, 0, " missing flags keyword");
>
> 	for (; arg < argc; arg++) {
> -		if (!strcmp(argv[arg], "flags")) {
> +		if (!strcmp(argv[arg], "token")) {
> +			if (++arg >= argc)
> +				error(1, 0, " missing token value");
> +
> +			/* token */
> +			token = atoi(argv[arg]);
> +		} else if (!strcmp(argv[arg], "flags")) {
> 			char *tok, *str;
>
> 			/* flags */
> @@ -1384,6 +1391,14 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
> 	}
> 	nest->rta_len = off - nest_start;
>
> +	if (token) {
> +		rta = (void *)(data + off);
> +		rta->rta_type = MPTCP_PM_ATTR_TOKEN;
> +		rta->rta_len = RTA_LENGTH(4);
> +		memcpy(RTA_DATA(rta), &token, 4);
> +		off += NLMSG_ALIGN(rta->rta_len);
> +	}
> +
> 	do_nl_req(fd, nh, off, 0);
> 	return 0;
> }
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index d586bc5ffe01..387f5774d541 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -776,10 +776,41 @@ test_subflows()
> 	rm -f "$evts"
> }
>
> +test_prio()
> +{
> +	local count
> +
> +	# Send MP_PRIO signal from client to server machine
> +	ip netns exec "$ns2" ./pm_nl_ctl set id 0 flags backup token "$client4_token"

This test did pass for me with a debug kernel in a desktop VM.

Considering the occasional failures we have when running other tests on 
debug kernels in CI, and the delays inserted elsewhere in this script, I 
think there should be a "sleep 0.5" here to make sure the MIBs have time 
to update.

- Mat


> +
> +	# Check TX
> +	stdbuf -o0 -e0 printf "MP_PRIO TX                                                 \t"
> +	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
> +	[ -z "$count" ] && count=0
> +	if [ $count != 1 ]; then
> +		stdbuf -o0 -e0 printf "[FAIL]\n"
> +		exit 1
> +	else
> +		stdbuf -o0 -e0 printf "[OK]\n"
> +	fi
> +
> +	# Check RX
> +	stdbuf -o0 -e0 printf "MP_PRIO RX                                                 \t"
> +	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
> +	[ -z "$count" ] && count=0
> +	if [ $count != 1 ]; then
> +		stdbuf -o0 -e0 printf "[FAIL]\n"
> +		exit 1
> +	else
> +		stdbuf -o0 -e0 printf "[OK]\n"
> +	fi
> +}
> +
> make_connection
> make_connection "v6"
> test_announce
> test_remove
> test_subflows
> +test_prio
>
> exit 0
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
