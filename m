Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F417C9
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 01:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651627094; x=1683163094;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9XbS1ck6zZPogYSiqtFB8Y/hPh2yscPtt4yzKMP12pI=;
  b=Le4biWg0XCRP8opkCqjkekcgLxf/Q4spMwSizIeXwBYbGndgLR5Hj4/3
   UQdqsQZqXt7RKWTuNhx0BajoFFafL1dL9d7c243UKp1ZlQ88R5iqKM0xp
   6dSQH7S3Wre3Nqdlo/S7MRYO/6GILr/zBFakkjg0e665jm8UIMgtZx7jt
   2R16SDM9IjWLzP44uAQ5i3J0+KWY1YmsJ3Fgq3LFvpn482eh2AyGnvOjQ
   APhhrsAOET2n85GaeLWx5yPxBH70qTXE4kloRcBvSA1EIlG9BjoFDRuaW
   HdgQOHgep+Y50PBcjy0fEr4S3uvq5iIlVkGqXK6dMJYdrM/3kMFLZM2Me
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247542304"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="247542304"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 18:17:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="692900770"
Received: from skarmaka-mobl2.amr.corp.intel.com ([10.209.21.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 18:17:28 -0700
Date: Tue, 3 May 2022 18:17:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first
 test"
In-Reply-To: <3efc49e473d2fbb03c9577aea5959b35d29d2c9e.1651625191.git.geliang.tang@suse.com>
Message-ID: <d734f759-837f-3f14-cf86-757727661e7d@linux.intel.com>
References: <3efc49e473d2fbb03c9577aea5959b35d29d2c9e.1651625191.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 4 May 2022, Geliang Tang wrote:

> Set scheduler to default after test.

Looks good to squash, thanks Geliang.

- Mat

>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/prog_tests/mptcp.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 925858d63a9c..3106e013b9ca 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -371,6 +371,7 @@ static void test_first(void)
>
> 	close(client_fd);
> 	close(server_fd);
> +	system("sysctl -qw net.mptcp.scheduler=default");
> 	bpf_link__destroy(link);
> 	mptcp_bpf_first__destroy(first_skel);
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
