Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379103210
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654788475; x=1686324475;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/DetcrYzhKvC5EKCHmA6QrtiTlGSI4qrmZ4Uf9d7yOU=;
  b=Bb04R1D+SEf/0mlC7/Mnwo4R/LcfK3S4/6VOFyVML5khTQEIWX1CCmRg
   mtZtFKxa5gU4ViiHvyVLSyGW0TJI+8KngK7Rbs4ZDKPsoXcGBMK3661nS
   GXRC/sbfGXt5XTxmH1rG8tzXc+ZAMMSB2bMBnSxLQIp4ktTXrFmYMDIbS
   VTdB+ilDwLOHXu1sX5f76SM2r2TF1G8kbZg2j8mmKeJXMsV3BR44jv8HD
   jJIRjJYrAWf4EIug131d5rqQn6kC5zdEx2PsQVG9JFqtMHNIiTQfqVYJB
   k1H27MLpDOp8r3lHTqOYmV4AoK7qELcYuCdmsI8i2kUsO3N8YZvpMvoIi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339078770"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="339078770"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:27:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="827650107"
Received: from stolud-mobl1.ger.corp.intel.com ([10.212.124.13])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:27:54 -0700
Date: Thu, 9 Jun 2022 08:27:54 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_first
 test"
In-Reply-To: <f5ce13a35164d0c81c47b807d146632795f6255c.1654752190.git.geliang.tang@suse.com>
Message-ID: <44b26c1-f88c-6131-f81e-da719114d744@linux.intel.com>
References: <f5ce13a35164d0c81c47b807d146632795f6255c.1654752190.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 9 Jun 2022, Geliang Tang wrote:

> A small cleanup, separate the code of base subtest and sched subtest, do
> not mix them together.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>

Fine with me to rearrange this test code and squash this, thanks Geliang.


- Mat


> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 9f3242c7920a..8426a5aba721 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -15,9 +15,6 @@
> #define TCP_CA_NAME_MAX	16
> #endif
>
> -#define ADDR_1	"10.0.1.1"
> -#define ADDR_2	"10.0.1.2"
> -
> struct mptcp_storage {
> 	__u32 invoked;
> 	__u32 is_mptcp;
> @@ -27,9 +24,6 @@ struct mptcp_storage {
> 	char ca_name[TCP_CA_NAME_MAX];
> };
>
> -static const unsigned int total_bytes = 10 * 1024 * 1024;
> -static int stop, duration;
> -
> static int verify_tsk(int map_fd, int client_fd)
> {
> 	int err, cfd = client_fd;
> @@ -177,6 +171,9 @@ static void test_base(void)
> 	close(cgroup_fd);
> }
>
> +static const unsigned int total_bytes = 10 * 1024 * 1024;
> +static int stop, duration;
> +
> static void *server(void *arg)
> {
> 	int lfd = (int)(long)arg, err = 0, fd;
> @@ -256,6 +253,9 @@ static void send_data(int lfd, int fd)
> 	      PTR_ERR(thread_ret));
> }
>
> +#define ADDR_1	"10.0.1.1"
> +#define ADDR_2	"10.0.1.2"
> +
> static void sched_init(char *flags, char *sched)
> {
> 	char cmd[64];
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
