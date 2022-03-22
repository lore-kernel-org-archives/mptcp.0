Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8AA50
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647982225; x=1679518225;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F9O4/FqP2t1MAHmkJ27niGQL2IQ5ykWjz9MG0QTZw2k=;
  b=PkMHWsnRiA14MJ8uT0AlwnIjTGJObMIiw+60k5Tp4pe7CJGPKyQpEVTr
   iZQCgIiD0sT6I6qPveuYi5sSVxTWTY/Q3AUduEp9M/cpVFRchQ9ruX3Y5
   +rE56A+383Bw1jCKy35LLbhJ45t4QjKK5jhZLg7oTzc+2U5xFolH5F0fe
   XCPhYXDyf4oS5s+1nbEO6e5k22Vy5psE4xQyQVNd8/0G7p9xrNz3gLxad
   DkBPF+NGN4z4Y+rZakBO9AXQsJl34l/9mgUxZI+oSBWzkFAqaZf3pLHOD
   qeeYeh3YnibY2DKqYVrYs3kAt2GxGrFaO7bHYSZHCpIw7TdMkeYLOd4u7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="257661037"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="257661037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 13:50:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="560586480"
Received: from priyankk-mobl1.amr.corp.intel.com ([10.212.193.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 13:50:25 -0700
Date: Tue, 22 Mar 2022 13:50:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 2/3] selftests: bpf: verify ca_name of
 struct mptcp_sock
In-Reply-To: <44d0fb218df30ede0a3797351ee833534c8fad72.1647783989.git.geliang.tang@suse.com>
Message-ID: <f6ab90d-8a4f-1353-8c80-a64c28a63782@linux.intel.com>
References: <cover.1647783989.git.geliang.tang@suse.com> <44d0fb218df30ede0a3797351ee833534c8fad72.1647783989.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 20 Mar 2022, Geliang Tang wrote:

> This patch verified another member of struct mptcp_sock, ca_name. Added a
> new function get_msk_ca_name() to read the sysctl tcp_congestion_control
> and verified it in verify_msk().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +++
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 33 +++++++++++++++++++
> tools/testing/selftests/bpf/progs/mptcp.c     |  4 +++
> 3 files changed, 42 insertions(+)
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
> index 80ae5a9777bf..d2941fbc686c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -3,12 +3,19 @@
> #include "cgroup_helpers.h"
> #include "network_helpers.h"
>
> +#define TCP_CA_SYSCTL	"/proc/sys/net/ipv4/tcp_congestion_control"
> +
> +#ifndef TCP_CA_NAME_MAX
> +#define TCP_CA_NAME_MAX	16
> +#endif
> +
> char monitor_log_path[64];
>
> struct mptcp_storage {
> 	__u32 invoked;
> 	__u32 is_mptcp;
> 	__u32 token;
> +	char ca_name[TCP_CA_NAME_MAX];
> };
>
> static int verify_tsk(int map_fd, int client_fd)
> @@ -77,14 +84,34 @@ static __u32 get_msk_token(void)
> 	return token;
> }
>
> +void get_msk_ca_name(char ca_name[])
> +{
> +	ssize_t len;
> +	int fd;
> +
> +	fd = open(TCP_CA_SYSCTL, O_RDONLY);
> +	if (CHECK_FAIL(fd < 0)) {
> +		log_err("Failed to open %s", TCP_CA_SYSCTL);
> +		return;
> +	}
> +
> +	len = read(fd, ca_name, TCP_CA_NAME_MAX);
> +	if (CHECK_FAIL(len < 0))
> +		log_err("Failed to read %s", TCP_CA_SYSCTL);
> +
> +	close(fd);
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
> @@ -113,6 +140,12 @@ static int verify_msk(int map_fd, int client_fd)
> 		err++;
> 	}
>
> +	if (strncmp(val.ca_name, ca_name, strlen(val.ca_name))) {

Hi Geliang -

Since we don't know if val.ca_name or ca_name are null-terminated, the 
length should be limited to TCP_CA_NAME_MAX instead of 
strlen(val.ca_name). strncmp will already limit based on null termination 
of the two input strings, and using strlen(val.ca_name) could erroneously 
return 0 if val.ca_name was the shorter string and the initial bytes 
matched.

When you repost this series, can you also rebase "add add 
skc_to_mptcp_sock v10" and squash patch 3 of this series?

Thanks!

Mat


> +		log_err("Unexpected mptcp_sock.ca_name %s != %s",
> +			val.ca_name, ca_name);
> +		err++;
> +	}
> +
> 	return err;
> }
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/selftests/bpf/progs/mptcp.c
> index b08448a12c02..99718f20c5f8 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp.c
> @@ -1,4 +1,5 @@
> // SPDX-License-Identifier: GPL-2.0
> +#include <string.h>
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> #include "bpf_tcp_helpers.h"
> @@ -10,6 +11,7 @@ struct mptcp_storage {
> 	__u32 invoked;
> 	__u32 is_mptcp;
> 	__u32 token;
> +	char ca_name[TCP_CA_NAME_MAX];
> };
>
> struct {
> @@ -47,6 +49,7 @@ int _sockops(struct bpf_sock_ops *ctx)
> 			return 1;
>
> 		storage->token = 0;
> +		bzero(storage->ca_name, TCP_CA_NAME_MAX);
> 	} else {
> 		msk = bpf_skc_to_mptcp_sock(sk);
> 		if (!msk)
> @@ -58,6 +61,7 @@ int _sockops(struct bpf_sock_ops *ctx)
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
