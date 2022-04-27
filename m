Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01C36B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651018805; x=1682554805;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=looGfH6mbenu2vWqPChaNugkrpcRhAmQbgMSdI/9euw=;
  b=Ov1UIf236n3fBbwfbwvXjSOvEBQBa2N0At80agePGhq11xLqvv16PA9c
   9V6Fv/12tAeq1HRaVK98iFWh9LrGC44+pDiC1YsgqzDiDiNSywiT0tjJC
   NTyRB+r5fkFxxgavTUbvW1jdS8McRAMWpgJCvxoYFmjT4ph9+lhDi4kLJ
   Z5qiyHZ1V/bF+Akj/o0dHrDt7ljDBHBNzXGvd/anMU6CsRKY2RTp6HYZu
   NqAZpxDKhhnPvez4+6fBsn6XW20NXXUXoU8cH8mbWXH4Lf5qPYnY4jB7I
   +2v1MSYEE82kCfCEBKAo66GRAAsDyvx5knx5SH+PCdsf/d8CrI6DKApi4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328706423"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="328706423"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:20:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532930521"
Received: from brpivitt-mobl1.amr.corp.intel.com ([10.252.136.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:20:04 -0700
Date: Tue, 26 Apr 2022 17:20:04 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: test
 bpf_skc_to_mptcp_sock"
In-Reply-To: <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
Message-ID: <d521e76e-729a-cc7f-9ad5-e4e26f3da8d@linux.intel.com>
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com> <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 26 Apr 2022, Geliang Tang wrote:

> Add CONFIG_MPTCP check.
>
> When CONFIG_MPTCP is not enabled, we'll get a clearer error message:
>
> libbpf: extern CONFIG_MPTCP (strong) not resolved
> libbpf: failed to load object './mptcp_sock.o'
>
> The message before is like this:
>
> libbpf: prog '_sockops': BPF program load failed: Invalid argument
> libbpf: prog '_sockops': -- BEGIN PROG LOAD LOG --
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/progs/mptcp_sock.c | 4 ++++
> 1 file changed, 4 insertions(+)
>

Looks like this also requires CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC, 
can you also add those to tools/testing/selftests/bpf/config? Maybe that 
should be a separate commit, since other bpf test progs appear to rely on 
this undocumented config requirement.

- Mat

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> index 5cfaec4e7245..7b6a25e37de8 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> @@ -7,6 +7,7 @@
>
> char _license[] SEC("license") = "GPL";
> __u32 _version SEC("version") = 1;
> +extern bool CONFIG_MPTCP __kconfig;
>
> struct mptcp_storage {
> 	__u32 invoked;
> @@ -46,6 +47,9 @@ int _sockops(struct bpf_sock_ops *ctx)
> 		if (!storage)
> 			return 1;
> 	} else {
> +		if (!CONFIG_MPTCP)
> +			return 1;
> +
> 		msk = bpf_skc_to_mptcp_sock(sk);
> 		if (!msk)
> 			return 1;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
