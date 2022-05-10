Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F72F4E
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652223803; x=1683759803;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RU/TisfyQQBQDH0bG32VNC44WCwB939yR1eaNCaVJS8=;
  b=ErepkDszYaLTXQg00zLfDe4VHSJEbh6lzq+bLl/AaCKoCMSSAf40NwVn
   Z2Djghd08/bo9wwp40znwF2O5i6PdULSmQQ0gmBIdjf3mIAjxFlItZe2o
   qRAOYUkazxjoH18o351Hp7J8tzP7UvTcqQ3UHGL8Ddu0JTBNFCPosSf21
   aUPeFAvT8/1sI8tNubNamCHmi133YPeLmIQPUCvyUjgR2A/D1J+oE+W+h
   iuwVPwJj46y45GIXWf/b6Yi3gu9U8kIVaB5tIiQ24mK41TW5Js9mLR6Ka
   sOQD26DRo9ScS1dOsjB+p54m2WblwWXnjWVF4MiSQYK+U/o9WdvhBkuca
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250060494"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="250060494"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 16:03:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="553049822"
Received: from yperng-mobl1.amr.corp.intel.com ([10.209.50.90])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 16:03:17 -0700
Date: Tue, 10 May 2022 16:03:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: test
 bpf_skc_to_mptcp_sock"
In-Reply-To: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
Message-ID: <45f492b2-1b41-9681-2fac-9cd59dd0f6b@linux.intel.com>
References: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 10 May 2022, Geliang Tang wrote:

> Drop bpf_mptcp_helpers.h, squash into bpf_tcp_helpers.h (Andrii)

Hi Geliang -

Since there are 6 different commits touching bpf_mptcp_helpers.h, maybe it 
would be easier for Matthieu if you posted the full patches for 
"selftests/bpf: test bpf_skc_to_mptcp_sock" and all the bpf patches after 
that, instead of squash changes / instructions?

I'm not sure the instructions below translate well to topgit.

- Mat

>
> 1
>
> CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h deleted in HEAD and modified in 8996b41ffcd2 (selftests/bpf: verify token of struct mptcp_sock).  Version 8996b41ffcd2 (selftests/bpf: verify token of struct mptcp_sock) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h left in tree.
> Auto-merging tools/testing/selftests/bpf/progs/mptcp_sock.c
> error: could not apply 8996b41ffcd2... selftests/bpf: verify token of struct mptcp_sock
>
> cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:
>
> '''
> extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> 	__u32		token;
> } __attribute__((preserve_access_index));
>
> '''
>
> git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
> git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>
> 2
>
> CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h deleted in HEAD and modified in 57dcfb6f61ec (selftests/bpf: verify ca_name of struct mptcp_sock).  Version 57dcfb6f61ec (selftests/bpf: verify ca_name of struct mptcp_sock) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h left in tree.
> Auto-merging tools/testing/selftests/bpf/bpf_tcp_helpers.h
> Auto-merging tools/testing/selftests/bpf/progs/mptcp_sock.c
> error: could not apply 57dcfb6f61ec... selftests/bpf: verify ca_name of struct mptcp_sock
>
> cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:
>
> '''
> extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> 	__u32		token;
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> '''
>
> git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
> git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>
> 3
>
> CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h deleted in HEAD and modified in 416cb433f1df (selftests/bpf: verify first of struct mptcp_sock).  Version 416cb433f1df (selftests/bpf: verify first of struct mptcp_sock) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h left in tree.
> Auto-merging tools/testing/selftests/bpf/progs/mptcp_sock.c
> error: could not apply 416cb433f1df... selftests/bpf: verify first of struct mptcp_sock
>
> cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:
>
> '''
> extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> 	__u32		token;
> 	struct sock	*first;
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> '''
>
> git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
> git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>
> 4
>
> CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h deleted in HEAD and modified in 74d3c74494e6 (mptcp: add struct mptcp_sched_ops).  Version 74d3c74494e6 (mptcp: add struct mptcp_sched_ops) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h left in tree.
> error: could not apply 74d3c74494e6... mptcp: add struct mptcp_sched_ops
>
> cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:
>
> '''
> extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> struct mptcp_sched_data {
> 	struct sock	*sock;
> 	bool		call_again;
> };
>
> struct mptcp_sched_ops {
> 	char name[MPTCP_SCHED_NAME_MAX];
>
> 	void (*init)(const struct mptcp_sock *msk);
> 	void (*release)(const struct mptcp_sock *msk);
>
> 	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
> 			    struct mptcp_sched_data *data);
> 	void *owner;
> };
>
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> 	__u32		token;
> 	struct sock	*first;
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> '''
>
> git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
> git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>
> 5
>
> CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h deleted in HEAD and modified in 1b3d7a5f1f10 (mptcp: add sched in mptcp_sock).  Version 1b3d7a5f1f10 (mptcp: add sched in mptcp_sock) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h left in tree.
> error: could not apply 1b3d7a5f1f10... mptcp: add sched in mptcp_sock
>
> cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:
>
> '''
> extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> struct mptcp_sched_data {
> 	struct sock	*sock;
> 	bool		call_again;
> };
>
> struct mptcp_sched_ops {
> 	char name[MPTCP_SCHED_NAME_MAX];
>
> 	void (*init)(const struct mptcp_sock *msk);
> 	void (*release)(const struct mptcp_sock *msk);
>
> 	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
> 			    struct mptcp_sched_data *data);
> 	void *owner;
> };
>
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> 	__u32		token;
> 	struct sock	*first;
> 	struct mptcp_sched_ops *sched;
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> '''
>
> git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
> git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> MAINTAINERS                                     |  1 -
> tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 14 --------------
> tools/testing/selftests/bpf/bpf_tcp_helpers.h   |  5 +++++
> tools/testing/selftests/bpf/progs/mptcp_sock.c  |  2 +-
> 4 files changed, 6 insertions(+), 16 deletions(-)
> delete mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af0d6a8543f6..56f5dd17859b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13787,7 +13787,6 @@ F:	include/net/mptcp.h
> F:	include/trace/events/mptcp.h
> F:	include/uapi/linux/mptcp.h
> F:	net/mptcp/
> -F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> F:	tools/testing/selftests/bpf/*/*mptcp*.c
> F:	tools/testing/selftests/net/mptcp/
>
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> deleted file mode 100644
> index 18da4cc65e89..000000000000
> --- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (c) 2022, SUSE. */
> -
> -#ifndef __BPF_MPTCP_HELPERS_H
> -#define __BPF_MPTCP_HELPERS_H
> -
> -#include "bpf_tcp_helpers.h"
> -
> -struct mptcp_sock {
> -	struct inet_connection_sock	sk;
> -
> -} __attribute__((preserve_access_index));
> -
> -#endif
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index b1ede6f0b821..a43b1afe22bd 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -225,4 +225,9 @@ static __always_inline bool tcp_cc_eq(const char *a, const char *b)
> extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
> extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> +struct mptcp_sock {
> +	struct inet_connection_sock	sk;
> +
> +} __attribute__((preserve_access_index));
> +
> #endif
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> index 9552584b1b6c..dd2448d1e7fc 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> @@ -4,7 +4,7 @@
>
> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> -#include "bpf_mptcp_helpers.h"
> +#include "bpf_tcp_helpers.h"
>
> char _license[] SEC("license") = "GPL";
> extern bool CONFIG_MPTCP __kconfig;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
