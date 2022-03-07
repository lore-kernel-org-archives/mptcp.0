Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33D7A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 14:15:49 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id e24so10534703wrc.10
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 06:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=AZJ/Gy1VKoa1gB7nXI4Jc1ILGePW9o8/9uo7vrZ/2pU=;
        b=SaYvYRvkqlhtfau5yxnEcUYqFwPxzWPLApAElDJ0/Z4gJlIP5g0pSVu9QLgFbIBqHJ
         aAKALieRiUTl/XaorwtBzGVeX5pvPr/X+UnRWYKjKUTMBbT5GtoMn21schWpdYQaAnqu
         T1wHp6k/oCQu18P0iJtJfDHmA1XxDZqFb+st5LlzUni8pCJ5cJ7KODfdczof5CEgUpV3
         kmisb4I4pX/g2UPwx1A76ttTzhqg7yGT1+HvpEzNhe3fJbWOEsL7sij2bV+DkM8Y4tve
         8Satin+CiugbT+7+zC+YWmSiiLcYsJCygsCYKacXJTjGEjV/L+XhSh9I0rcX4xxpqhxx
         Ma7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AZJ/Gy1VKoa1gB7nXI4Jc1ILGePW9o8/9uo7vrZ/2pU=;
        b=N1pGSoMdTWH9VkWgiWq1ISQKPWSHsrPx2ymnvoIJb7MJT5Nmc4z082vEreOLQl5yrP
         853NeJFE3A7ydXdM0/z8UcViY06uOWOR1FYiCFwwy6zDy/1tC+uxHuX20PYepGOv8nVp
         NI11E84LRbbI4glLmG26kCYuEZqndNKCEHixapf6IBtRvGwA6TJeEOTfRyl/6nvWy567
         efmSKALxrDxnUkIKEQB8snWGLB6GsaVz1+W10uZ0naL7KZWwTZs1p2tIRHGbgs6DAXyF
         4faZK11o1wv6kJUQ/Jla0kYUN+i7tJ/o7y+hNpSuaMiePrg5oRQvVTznKqGlLQIKv+2s
         TxeQ==
X-Gm-Message-State: AOAM530cwBvGKXPAJ5ityjrjrqhIAksACNT9D09s5Ey+y/W2XAqFj9TZ
	dchra3oGMKPsGGg5SEwYsPZV1ihtLcCgDQ==
X-Google-Smtp-Source: ABdhPJz9slvE2T93laXmQjrvFJxMDc3oKYItQI1EqhrFXJY5Y43C0EBZCC3SFCbXbtnWb4L2CpIr4w==
X-Received: by 2002:a05:6000:1842:b0:1ef:cf9b:bfec with SMTP id c2-20020a056000184200b001efcf9bbfecmr8373363wri.74.1646662547184;
        Mon, 07 Mar 2022 06:15:47 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6688000000b001f04ae0bb6csm11305143wru.58.2022.03.07.06.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:15:46 -0800 (PST)
Message-ID: <4b248f07-d749-400a-ff81-4f08a12c7814@tessares.net>
Date: Mon, 7 Mar 2022 15:15:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v6 4/4] selftests: bpf: add skc_to_mptcp_sock
 test
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646528337.git.geliang.tang@suse.com>
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/03/2022 02:01, Geliang Tang wrote:
> This patch extended the MPTCP test base, to exercise bpf_skc_to_mptcp_sock()
> from C test as Alexei suggested in v3.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 +++++
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 +++++++++++++++----
>  tools/testing/selftests/bpf/progs/mptcp.c     | 23 ++++++++++++++++
>  3 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index b1ede6f0b821..05f62f81cc4d 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -83,6 +83,12 @@ struct tcp_sock {
>  	__u64	tcp_mstamp;	/* most recent packet received/sent */
>  } __attribute__((preserve_access_index));
>  
> +struct mptcp_sock {
> +	struct inet_connection_sock	sk;
> +
> +	__u32	token;
> +} __attribute__((preserve_access_index));

Is it really OK to do that when 'struct mptcp_sock' is not declared in
the 'include' directory?
I guess the compiler can find where 'struct mptcp_sock' is actually
defined but I'm surprised it doesn't need more assistance here.

In your tests, did you check that the token seen in the kernel --
outside the BPF part but in MPTCP code -- is the same as what the
userspace program can see after a capture from BPF side? I mean: the
current test only check the token is different from 0 but it could also
be set at a wrong value (any random value except 0) and we would not
notice the issue, no?

> +
>  static __always_inline struct inet_connection_sock *inet_csk(const struct sock *sk)
>  {
>  	return (struct inet_connection_sock *)sk;
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 04aef0f147dc..ba856956f9c3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,9 +6,11 @@
>  struct mptcp_storage {
>  	__u32 invoked;
>  	__u32 is_mptcp;
> +	__u32 token;
>  };
>  
> -static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
> +static int verify_sk(int map_fd, int client_fd, const char *msg,
> +		     __u32 is_mptcp, __u32 token)
>  {
>  	int err = 0, cfd = client_fd;
>  	struct mptcp_storage val;
> @@ -19,8 +21,23 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
>  	 * does not trigger sockops events.
>  	 * We silently pass this situation at the moment.
>  	 */
> -	if (is_mptcp == 1)
> -		return 0;
> +	if (is_mptcp == 1) {
> +		if (token <= 0)

It looks like you no longer need 'token': it always has the same value
as "is_mptcp", which makes sense: if it is an MPTCP connection, it
should have a token. So maybe good not to add this new 'token' variable,
WDYT?

(it can be added later if it is needed to manage different cases)

> +			return 0;
> +
> +		if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
> +			perror("Failed to read socket storage");
> +			return -1;
> +		}
> +
> +		if (val.token <= 0) {
> +			log_err("%s: unexpected bpf_mptcp_sock.token %d %d",
> +				msg, val.token, token);
> +			err++;
> +		}
> +
> +		return err;
> +	}
>  
>  	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
>  		perror("Failed to read socket storage");
> @@ -76,8 +93,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  		goto close_client_fd;
>  	}
>  
> -	err += is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", 1) :
> -			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
> +	err += is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", 1, 1) :
> +			  verify_sk(map_fd, client_fd, "plain TCP socket", 0, 0);
>  
>  close_client_fd:
>  	close(client_fd);
> diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/selftests/bpf/progs/mptcp.c
> index be5ee8dac2b3..212e9341b877 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include "bpf_tcp_helpers.h"
>  
>  char _license[] SEC("license") = "GPL";
>  __u32 _version SEC("version") = 1;
> @@ -8,6 +9,7 @@ __u32 _version SEC("version") = 1;
>  struct mptcp_storage {
>  	__u32 invoked;
>  	__u32 is_mptcp;
> +	__u32 token;
>  };
>  
>  struct {
> @@ -20,6 +22,7 @@ struct {
>  SEC("sockops")
>  int _sockops(struct bpf_sock_ops *ctx)
>  {
> +	char fmt[] = "invoked=%u is_mptcp=%u token=%u\n";
>  	struct mptcp_storage *storage;
>  	struct bpf_tcp_sock *tcp_sk;
>  	int op = (int)ctx->op;
> @@ -43,6 +46,26 @@ int _sockops(struct bpf_sock_ops *ctx)
>  
>  	storage->invoked++;
>  	storage->is_mptcp = tcp_sk->is_mptcp;
> +	storage->token = 0;
> +
> +	if (tcp_sk->is_mptcp) {
> +		struct mptcp_sock *msk;
> +
> +		msk = bpf_skc_to_mptcp_sock(sk);
> +		if (!msk)
> +			return 1;

(detail) if you have to edit this commit, please add a new empty line
here after the 'return'.

> +		storage = bpf_sk_storage_get(&socket_storage_map, msk, 0,
> +					     BPF_SK_STORAGE_GET_F_CREATE);
> +		if (!storage)
> +			return 1;
> +
> +		storage->invoked++;
> +		storage->token = msk->token;

Linked to my previous comment about checking if 'token' had the right
value: it is not enough to compare this 'msk->token' printed with
'bpf_trace_printk' here below with the value you have in
'prog_tests/mptcp.c' because it is supposed to be the same one if the
BPF MAP storage does its job (I guess it does).

Instead, we should compare with either what you can see with 'ss' or 'ip
mptcp monitor' or with the code in 'net/mptcp/' dir (pr_debug's print it
at some points I guess). But doing that is not enough: that will not be
part of the automated tests, just a manual check. But still good to do :)

My point is that the token is supposed to be random: if you read the
wrong address in the memory, it will also appear as a random value
because it is unlikely to read '0'.

Maybe it would be good to also check other values from 'mptcp_sock'. But
I don't know which one can be known in advanced in this structure appart
from booleans: fully_established, cork, etc. But I guess we should avoid
using booleans: one bit, we could be lucky to have the good value.

Or maybe interesting to use 'struct sock *first' (or *last_snd or
*subflow)? I mean it would be a good test case to keep a ref to a
subflow. Then from the userspace, we could get info from the MSK and
then get info about the subflow.
But I don't know if it is possible: typically from the usespace, we get
a sk from a fd. Can we get a sk from its pointer?
I guess it will be needed to iterate over the different subflows from a msk.

Cheers,
Matt


> +		storage->is_mptcp = 1;
> +	}
> +
> +	bpf_trace_printk(fmt, sizeof(fmt),
> +			 storage->invoked, storage->is_mptcp, storage->token);
>  
>  	return 1;
>  }

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
