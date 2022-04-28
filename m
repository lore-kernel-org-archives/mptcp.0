Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE1C1843
	for <mptcp@lists.linux.dev>; Thu, 28 Apr 2022 23:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651188556; x=1682724556;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UFw1pPFsGJlRPbUvv1gKmeS1Of7X8wxSksjaPhLKsmk=;
  b=oHJ0LuzXXb5ZHDLzmPYDYO0BCjajFVc+D1dN2uCQ4NQKLj/mvcyV1UC0
   a7v1w2ct6AyRw9VErqzmKPfZNPuMFqnZw0eKKB7NGCcQL6AaT/Kj1WrF3
   nGIyccoKESvazX5LyXjplq8ee/+GL92nAaxvQn0wiqjX8GyNTJCGxr/CO
   +uTScwx4ybK1FnUM3lkZHghJcmhcBS7k7PPkXUkYEhR7mEeEE6tXbZDxD
   3G3d3NW0plZf6z4NdltUkxrmnQm/YCie1at2pLDyuDFYanoJrzlrCmJrP
   gWMA+xcT4N0Xd5eEYmNY62B/AuT2v/e9RBCvaPVB0n1W3lfYFCJ5PT2eG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265309255"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="265309255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:29:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="534158671"
Received: from davideli-mobl.amr.corp.intel.com ([10.209.69.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:29:01 -0700
Date: Thu, 28 Apr 2022 16:29:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] selftests/bpf: Enable CONFIG_IKCONFIG_PROC
 in config
In-Reply-To: <f14787485262a8dd8c439e01cd5651f10d5eb63d.1651114997.git.geliang.tang@suse.com>
Message-ID: <46af5926-5671-53b7-8358-7697336ed67@linux.intel.com>
References: <f14787485262a8dd8c439e01cd5651f10d5eb63d.1651114997.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 28 Apr 2022, Geliang Tang wrote:

> CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
> errors like this:
>
> libbpf: failed to open system Kconfig
> libbpf: failed to load object 'kprobe_multi'
> libbpf: failed to load BPF skeleton 'kprobe_multi': -22
>
> It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
> in tools/lib/bpf/libbpf.c:
>
>        file = gzopen("/proc/config.gz", "r");
>
> So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
> tools/testing/selftests/bpf/config.
>
> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - as a dedicated patch, not a squash-to one.
> - apply this patch before "bpf: expose is_mptcp flag to bpf_tcp_sock"

Thanks - I'll send this as part of the v2 series for bpf-next.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> tools/testing/selftests/bpf/config | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 763db63a3890..8d7faff33c54 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -53,3 +53,5 @@ CONFIG_NF_DEFRAG_IPV4=y
> CONFIG_NF_DEFRAG_IPV6=y
> CONFIG_NF_CONNTRACK=y
> CONFIG_USERFAULTFD=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> -- 
> 2.34.1
>
>

--
Mat Martineau
Intel
