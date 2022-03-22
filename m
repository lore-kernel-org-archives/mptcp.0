Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A96453
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 21:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647984794; x=1679520794;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cIr/AJf608Pbd7y/qRyy2PKDL9A0fLIoCFO9rJfvqbk=;
  b=hZDrijlM9ChqWJAN1HZ4iUdU5eTlydSc5Hku+eGGtxI12DGnkiBtJXW6
   w29PgAynZ5uiedpG2hULFzdpXL5mq1htxjkXlhEx4sL3JJU3BotJ+IPbe
   qlvrK3ifFF2nzGjWE38Foqa1BTFbsZGpmYLOtJOtkbH1xpdT34vZHl43s
   jptrFiKng9XSxvijZbTY4CoA2eA4gDjPTiYgUhZAhK56GIj/G5/y78Cl6
   n9ae7nICoFKQD1i8Vj8of8iYtXcgUGHl9eLgbZPiyVOayEM3W4sq+OsDP
   Ov2oaAF7kzlptiaJTwjErX3tX3D2kAJFxcvK5T5b84yUq3Wf8+fZxbCEx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="240114267"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="240114267"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:33:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="500756106"
Received: from priyankk-mobl1.amr.corp.intel.com ([10.212.193.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:33:14 -0700
Date: Tue, 22 Mar 2022 14:33:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 8/8] selftests: bpf: add bpf_first test
In-Reply-To: <11db7ce5a24b7f38ea835e5d286f7531b3a95929.1647942374.git.geliang.tang@suse.com>
Message-ID: <22612f2e-64cc-2268-e1dc-6eb766b9d6ec@linux.intel.com>
References: <cover.1647942374.git.geliang.tang@suse.com> <11db7ce5a24b7f38ea835e5d286f7531b3a95929.1647942374.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 22 Mar 2022, Geliang Tang wrote:

> This patch expended the BPF TCP congestion control tests to support
> MPTCP. Add the bpf_first MPTCP sched test in it. Use sysctl to set
> net.mptcp.scheduler to use this sched.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

This should definitely be set up as a separate test from bpf_tcp_ca. Ok to 
copy the CA tests (explain where it was copied from in the commit 
message), and then modify for MPTCP scheduler use.

-Mat

> ---
> .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 42 +++++++++++++++++--
> 1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 8f7a1cef7d87..979b6e90b372 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -9,6 +9,7 @@
> #include "bpf_cubic.skel.h"
> #include "bpf_tcp_nogpl.skel.h"
> #include "bpf_dctcp_release.skel.h"
> +#include "bpf_first.skel.h"
>
> #define min(a, b) ((a) < (b) ? (a) : (b))
>
> @@ -16,6 +17,10 @@
> #define ENOTSUPP 524
> #endif
>
> +#ifndef IPPROTO_MPTCP
> +#define IPPROTO_MPTCP 262
> +#endif
> +
> static const unsigned int total_bytes = 10 * 1024 * 1024;
> static int expected_stg = 0xeB9F;
> static int stop, duration;
> @@ -85,21 +90,26 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
> 	socklen_t addrlen = sizeof(sa6);
> 	void *thread_ret;
> 	char batch[1500];
> +	int proto = 0;
> 	int err;
>
> 	WRITE_ONCE(stop, 0);
>
> -	lfd = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (!strcmp(tcp_ca, "bpf_first"))
> +		proto = IPPROTO_MPTCP;
> +
> +	lfd = socket(AF_INET6, SOCK_STREAM, proto);
> 	if (CHECK(lfd == -1, "socket", "errno:%d\n", errno))
> 		return;
> -	fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	fd = socket(AF_INET6, SOCK_STREAM, proto);
> 	if (CHECK(fd == -1, "socket", "errno:%d\n", errno)) {
> 		close(lfd);
> 		return;
> 	}
>
> -	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
> -	    settimeo(lfd, 0) || settimeo(fd, 0))
> +	if (!proto &&
> +	    (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
> +	     settimeo(lfd, 0) || settimeo(fd, 0)))
> 		goto done;
>
> 	/* bind, listen and start server thread to accept */
> @@ -324,6 +334,28 @@ static void test_rel_setsockopt(void)
> 	bpf_dctcp_release__destroy(rel_skel);
> }
>
> +static void test_first(void)
> +{
> +	struct bpf_first *first_skel;
> +	struct bpf_link *link;
> +
> +	first_skel = bpf_first__open_and_load();
> +	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(first_skel->maps.first);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +		bpf_first__destroy(first_skel);
> +		return;
> +	}
> +
> +	system("sysctl -q net.mptcp.scheduler=bpf_first");
> +	do_test("bpf_first", NULL);
> +
> +	bpf_link__destroy(link);
> +	bpf_first__destroy(first_skel);
> +}
> +
> void test_bpf_tcp_ca(void)
> {
> 	if (test__start_subtest("dctcp"))
> @@ -336,4 +368,6 @@ void test_bpf_tcp_ca(void)
> 		test_dctcp_fallback();
> 	if (test__start_subtest("rel_setsockopt"))
> 		test_rel_setsockopt();
> +	if (test__start_subtest("first"))
> +		test_first();
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
