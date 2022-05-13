Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44917E7
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 01:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652404155; x=1683940155;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vo8LTBd8BW84euojZjsQDT7SSAP7wkowsKUleY7rgzU=;
  b=Yo65wPmrvK1KMf9Hk/aCswamMSVqrnftN/CzsP4/PiG2PDvrSesaTB8b
   xIMpeIYrNtADY2z1e0yjfjrwSqMsvrFo19DhBHT//GTbNKV64YWE8QiZC
   QdaXzvCLEM/+uY3Wl99DwBxmc/vcNxS6GiaypW5UIVaFdo0swr+5EmNRQ
   cUoFb8lsYFS0SUYKqn0GZ7SBtpICsLa7p15TrkmrKov5ad5456tka+crl
   +oetX/OoMvZcvxqi1Hl/LRjTCa8ZsUcuABr9lFeo9YPxuYsk6m8SEKtxm
   idl5uUYCgEBMn6XRQ0XucNwhCV6Nt0Jk65xh+dHx3SWFCFCh9Im7/qCKo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="356608229"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="356608229"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:09:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="658873242"
Received: from gjimenez-mobl2.amr.corp.intel.com ([10.212.193.238])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:09:14 -0700
Date: Thu, 12 May 2022 18:08:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 3/3] selftests/bpf: add bpf_rr test
In-Reply-To: <e3d31fc19246a91423fca7c497bdd0f661470e36.1652270663.git.geliang.tang@suse.com>
Message-ID: <344bad28-8918-29c7-387c-a41c356c447b@linux.intel.com>
References: <cover.1652270663.git.geliang.tang@suse.com> <e3d31fc19246a91423fca7c497bdd0f661470e36.1652270663.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 11 May 2022, Geliang Tang wrote:

> This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
> set net.mptcp.scheduler to use this sched. Add a veth net device to
> simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
> add this new endpoint to PM netlink.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
> 1 file changed, 38 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 93a5739712ce..6303eba67fab 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,6 +6,7 @@
> #include "cgroup_helpers.h"
> #include "network_helpers.h"
> #include "mptcp_bpf_first.skel.h"
> +#include "mptcp_bpf_rr.skel.h"
>
> #ifndef TCP_CA_NAME_MAX
> #define TCP_CA_NAME_MAX	16
> @@ -369,10 +370,47 @@ static void test_first(void)
> 	mptcp_bpf_first__destroy(first_skel);
> }
>
> +static void test_rr(void)
> +{
> +	struct mptcp_bpf_rr *rr_skel;
> +	int server_fd, client_fd;
> +	struct bpf_link *link;
> +
> +	rr_skel = mptcp_bpf_rr__open_and_load();
> +	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(rr_skel->maps.rr);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +		mptcp_bpf_rr__destroy(rr_skel);
> +		return;
> +	}
> +
> +	system("ip link add veth1 type veth");
> +	system("ip addr add 10.0.1.1/24 dev veth1");
> +	system("ip link set veth1 up");
> +	system("ip mptcp endpoint add 10.0.1.1 subflow");
> +	system("sysctl -qw net.mptcp.scheduler=bpf_rr");
> +	server_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	client_fd = connect_to_mptcp_fd(server_fd, 0);
> +
> +	send_data(server_fd, client_fd);
> +

Is there a way to verify data was sent on both subflows? Maybe look at 
bytes_sent or segs_out in 'ss' output?

> +	close(client_fd);
> +	close(server_fd);
> +	system("sysctl -qw net.mptcp.scheduler=default");
> +	system("ip mptcp endpoint flush");
> +	system("ip link del veth1");
> +	bpf_link__destroy(link);
> +	mptcp_bpf_rr__destroy(rr_skel);
> +}
> +
> void test_mptcp(void)
> {
> 	if (test__start_subtest("base"))
> 		test_base();
> 	if (test__start_subtest("first"))
> 		test_first();
> +	if (test__start_subtest("rr"))
> +		test_rr();
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
