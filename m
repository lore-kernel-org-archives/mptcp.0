Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A664614D
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 18:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648060131; x=1679596131;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R+gyFlzG9U6liEh9kwWwFCz7+rJjdUmKUCK/ynwZZfw=;
  b=clKdL54Uh70F4JI9+6qGXHAGRvcsBboEjUPqzOq5tKjgTszGs4BSbOT2
   s+gQp1WVHBJRrPmzGn1tHr5QkZSOYO1h5aBcpMJSE3J0YTBpwuCyZJZt3
   qz5EzYCNnPraMZy8No6H08i3W9rb58JDKDmQrSC8T0CYIEP7C5mmgU0qi
   xcTaMTLhxa5eSEf1GorPRAgrEoD47LtFAHNt8OSzqYhsvid6Pt7rpbCZW
   WkehJVRiZJSaaCCVJ9yryaMAMFWTMCqE919ZxztUUcs2J3fHWRCbVfAaT
   7ZeJFnQ+fB5QA+ROdypypDq+YiLEa4r2AbSBISZhvXgnsyy/0AMK17JNE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238140102"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="238140102"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 11:28:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="649551717"
Received: from lmcarlo-mobl.amr.corp.intel.com ([10.212.175.160])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 11:28:50 -0700
Date: Wed, 23 Mar 2022 11:28:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 6/7] selftests: bpf: verify ca_name of
 struct mptcp_sock
In-Reply-To: <42bf5ab5eda469d54c3e00d0d13523b815f31554.1648025308.git.geliang.tang@suse.com>
Message-ID: <55171cab-2ab0-d367-951e-3968ff26511@linux.intel.com>
References: <cover.1648025307.git.geliang.tang@suse.com> <42bf5ab5eda469d54c3e00d0d13523b815f31554.1648025308.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 23 Mar 2022, Geliang Tang wrote:

> This patch verified another member of struct mptcp_sock, ca_name. Added a
> new function get_msk_ca_name() to read the sysctl tcp_congestion_control
> and verified it in verify_msk().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 ++++
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 +++++++++++++++++++
> tools/testing/selftests/bpf/progs/mptcp.c     |  4 +++
> 3 files changed, 34 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index 9ea6687c8f4d..bebe382bcc7a 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -16,6 +16,10 @@ BPF_PROG(name, args)
> #define SOL_TCP 6
> #endif
>
> +#ifndef TCP_CA_NAME_MAX
> +#define TCP_CA_NAME_MAX	16
> +#endif
> +
> #define tcp_jiffies32 ((__u32)bpf_jiffies64())
>
> struct sock_common {
> @@ -87,6 +91,7 @@ struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> 	__u32		token;
> +	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> static __always_inline struct inet_connection_sock *inet_csk(const struct sock *sk)
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 80e57ca1ea4d..0f8ced3845c9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -5,10 +5,15 @@
> #include "cgroup_helpers.h"
> #include "network_helpers.h"
>
> +#ifndef TCP_CA_NAME_MAX
> +#define TCP_CA_NAME_MAX	16
> +#endif
> +
> struct mptcp_storage {
> 	__u32 invoked;
> 	__u32 is_mptcp;
> 	__u32 token;
> +	char ca_name[TCP_CA_NAME_MAX];
> };
>
> static char monitor_log_path[64];
> @@ -79,14 +84,28 @@ static __u32 get_msk_token(void)
> 	return token;
> }
>
> +void get_msk_ca_name(char ca_name[])
> +{
> +	FILE *stream = popen("sysctl -b net.ipv4.tcp_congestion_control", "r");
> +	ssize_t len;
> +
> +	len = fread(ca_name, TCP_CA_NAME_MAX, 1, stream);
> +	if (CHECK_FAIL(len < 0))
> +		log_err("Failed to read ca_name");
> +
> +	pclose(stream);
> +}
> +
> static int verify_msk(int map_fd, int client_fd)
> {
> 	char *msg = "MPTCP subflow socket";
> 	int err = 0, cfd = client_fd;
> 	struct mptcp_storage val;
> +	char ca_name[TCP_CA_NAME_MAX];
> 	__u32 token;
>
> 	token = get_msk_token();
> +	get_msk_ca_name(ca_name);
> 	if (token <= 0) {
> 		log_err("Unexpected token %x", token);
> 		return -1;
> @@ -115,6 +134,12 @@ static int verify_msk(int map_fd, int client_fd)
> 		err++;
> 	}
>
> +	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
> +		log_err("Unexpected mptcp_sock.ca_name %s != %s",
> +			val.ca_name, ca_name);

Double checking - is it guaranteed that ca_name and val.ca_name are null 
terminated?

-Mat

> +		err++;
> +	}
> +
> 	return err;
> }
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/selftests/bpf/progs/mptcp.c
> index afacea5ad9ca..6e7d2abf6ce3 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp.c
> @@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
> /* Copyright (c) 2020, Tessares SA. */
>
> +#include <string.h>
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> #include "bpf_tcp_helpers.h"
> @@ -12,6 +13,7 @@ struct mptcp_storage {
> 	__u32 invoked;
> 	__u32 is_mptcp;
> 	__u32 token;
> +	char ca_name[TCP_CA_NAME_MAX];
> };
>
> struct {
> @@ -48,6 +50,7 @@ int _sockops(struct bpf_sock_ops *ctx)
> 			return 1;
>
> 		storage->token = 0;
> +		bzero(storage->ca_name, TCP_CA_NAME_MAX);
> 	} else {
> 		msk = bpf_skc_to_mptcp_sock(sk);
> 		if (!msk)
> @@ -59,6 +62,7 @@ int _sockops(struct bpf_sock_ops *ctx)
> 			return 1;
>
> 		storage->token = msk->token;
> +		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
> 	}
> 	storage->invoked++;
> 	storage->is_mptcp = tcp_sk->is_mptcp;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
