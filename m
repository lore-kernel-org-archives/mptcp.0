Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B36464E
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 00:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645576773; x=1677112773;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9NuEJznY5qVsmLtqVAs7ef5we2pWrrMqF3QAwwRrcEw=;
  b=JGZ4cw3/1N9c5XOaunJd4an8eRpB+lhD+xzSnvJ14k4/NosfSBaU8s8S
   ip18HjI8w+xa11RgcTU7A3fSiO4+bZTGfULnNbCEwgS2AH5vhlQG3nnDV
   9DoSRHYiYNLpG+vxbtxi1mxuDIKOq5jMo/I4Uh7127lVJZaRu7GzW8a0P
   rGTgjv9Y6Cv0u0Iwf3MeiGsynoDvcA+7cROqm8TONLEHBD+Kkpb0KeXbD
   IQTVtIQJujalVuk+7qlGB7y8u0LGkQ0syyDVHDVEGjrxWFaw/Bvv3l71l
   Leh71DEWQdZUsMU08tkif2pE/Zb99qU1TKzMnmJzLKyFlXs12FSrVblwg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338286196"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="338286196"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:39:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="683715343"
Received: from fdwikusu-mobl.amr.corp.intel.com ([10.251.6.85])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:39:32 -0800
Date: Tue, 22 Feb 2022 16:39:32 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next] bpf: examples: fix libbpf 0.7 deprecated
 warnings
In-Reply-To: <807598d13bce34bb92b2078bbef0aa30007aac2c.1645510773.git.geliang.tang@suse.com>
Message-ID: <d8928aad-851a-b9a4-a32b-8682b1be686@linux.intel.com>
References: <807598d13bce34bb92b2078bbef0aa30007aac2c.1645510773.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 22 Feb 2022, Geliang Tang wrote:

> This patch fixed the following deprecated warnings:
>
> loader.c:136:10: warning: 'bpf_program__next' is deprecated: libbpf v0.7+: use bpf_object__next_program() instead [-Wdeprecated-declarations]
>                prog = bpf_program__next(prog, object_file);
>                       ^
> tools/lib/bpf/libbpf.h:265:12: note: 'bpf_program__next' has been explicitly marked deprecated here
> LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_program() instead")
>           ^
> tools/lib/bpf/libbpf_common.h:24:4: note: expanded from macro 'LIBBPF_DEPRECATED_SINCE'
>                (LIBBPF_DEPRECATED("libbpf v" # major "." # minor "+: " msg))
>                 ^
> tools/lib/bpf/libbpf_common.h:19:47: note: expanded from macro 'LIBBPF_DEPRECATED'
>                                              ^
> loader.c:139:18: warning: 'bpf_program__title' is deprecated: BPF program title is confusing term; please use bpf_program__section_name() instead [-Wdeprecated-declarations]
>                name = (char*) bpf_program__title(prog, false);
>                               ^
> tools/lib/bpf/libbpf.h:294:12: note: 'bpf_program__title' has been explicitly marked deprecated here
> LIBBPF_API LIBBPF_DEPRECATED("BPF program title is confusing term; please use bpf_program__section_name() instead")
>           ^
> tools/lib/bpf/libbpf_common.h:19:47: note: expanded from macro 'LIBBPF_DEPRECATED'
>                                              ^
> 2 warnings generated.
> mptcp_set_sf_sockopt_kern.c:19:8: warning: 'bpf_map_def' is deprecated: use BTF-defined maps in .maps section [-Wdeprecated-declarations]
> struct bpf_map_def SEC("maps") mptcp_sf = {
>       ^
> tools/lib/bpf/bpf_helpers.h:136:18: note: 'bpf_map_def' has been explicitly marked deprecated here
> } __attribute__((deprecated("use BTF-defined maps in .maps section")));
>                 ^
> 1 warning generated.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> RESEND:
> - update the subject prefix from "bpf: example:" to "bpf: examples:"
> ---
> bpf/examples/loader.c                    |  4 ++--
> bpf/examples/mptcp_set_sf_sockopt_kern.c | 12 ++++++------
> 2 files changed, 8 insertions(+), 8 deletions(-)

Hi Geliang -

Oh, this is for the scripts branch.

Can you also update bpf/examples/Makefile to make it easier to build this 
example on a system that has libbpf 0.7 and its headers built in a kernel 
tree but not installed systemwide?

Thanks,

Mat



>
> diff --git a/bpf/examples/loader.c b/bpf/examples/loader.c
> index 6a87aa9555c8..c4f8e85585b5 100644
> --- a/bpf/examples/loader.c
> +++ b/bpf/examples/loader.c
> @@ -133,10 +133,10 @@ int main(int argc, const char **argv)
> 	LIBBPF_ERROR_WRAPPER(ret, "failed to load programs from object file");
>
> 	do {
> -		prog = bpf_program__next(prog, object_file);
> +		prog = bpf_object__next_program(object_file, prog);
> 		if (!prog) break;
>
> -		name = (char*) bpf_program__title(prog, false);
> +		name = (char *)bpf_program__section_name(prog);
>
> 		switch(bpf_program__get_expected_attach_type(prog)) {
> 		case BPF_CGROUP_SOCK_OPS:
> diff --git a/bpf/examples/mptcp_set_sf_sockopt_kern.c b/bpf/examples/mptcp_set_sf_sockopt_kern.c
> index 4079ce197e83..6c8231d21ad8 100644
> --- a/bpf/examples/mptcp_set_sf_sockopt_kern.c
> +++ b/bpf/examples/mptcp_set_sf_sockopt_kern.c
> @@ -16,12 +16,12 @@ char _license[] SEC("license") = "GPL";
> char cc [TCP_CA_NAME_MAX] = "vegas";
>
> /* Associate a subflow counter to each token */
> -struct bpf_map_def SEC("maps") mptcp_sf = {
> -	.type = BPF_MAP_TYPE_HASH,
> -	.key_size = sizeof(__u32),
> -	.value_size = sizeof(__u32),
> -	.max_entries = 100
> -};
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, 100);
> +} mptcp_sf SEC(".maps");
>
> #define DEBUG 1
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
