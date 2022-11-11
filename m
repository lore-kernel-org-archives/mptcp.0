Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A2372
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 01:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668129216; x=1699665216;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x7aMOLJYsyvRsgqGWihUiV7kYo8qBXRhifMMgyBDTRo=;
  b=cNgkh5lxxKbdA3MhHq+qNk8oo79dH5V07zieoGXVArjALyW+pOLhYuMN
   3tXdxUrwwFJNnCLCtZLXPVdWrF7vjq9n8RXZjvmhphtb2KeIs5jjmbAAl
   B7FvoFccVUr3T72o0zvpfs1SYihARP8Nsh19pXffZ7Yy3kwJbU4awbcEL
   6Ks8jGsu/IN6GBajMw4ciTarC8yAoDhR38YlxKMIC6TgBYWEjAnIimbeq
   iLZfDcHD2wAkZadr/eRTHK2v416LAYBovDxoIuZGlEBhFuo6q80hDW/jG
   NC8cxRhw49SQZpgJygkdwxd4Ha5yipQ9dN7lgUD9S5Ert+8hINXO5V3Uz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="298996399"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="298996399"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:13:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="726611089"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="726611089"
Received: from ssamaraj-mobl1.amr.corp.intel.com ([10.209.53.250])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:13:35 -0800
Date: Thu, 10 Nov 2022 17:13:34 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix mibit vs mbit mix up
In-Reply-To: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
Message-ID: <b7b6bf8e-0db9-4573-b8e8-9b7e26a6dd2e@linux.intel.com>
References: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Nov 2022, Matthieu Baerts wrote:

> The estimated time was supposing the rate was expressed in mibit
> (bit * 1024^2) but it is in mbit (bit * 1000^2).
>
> This makes the threshold higher but in a more realistic way to avoid
> false positives reported by CI instances.
>
> Before this patch, the thresholds were at 7561/4005ms and now they are
> at 7906/4178ms.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/310
> Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Looks good to me, if you can make one small adjustment when applying! (see 
below)

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index af70c14e0bf9..34362c4644ff 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -249,7 +249,8 @@ run_test()
>
> 	# time is measured in ms, account for transfer size, affegated link speed
                                                              ^^^^^^^^^
Think this is supposed to be "aggregated"? Might as well fix.

> 	# and header overhead (10%)
> -	local time=$((size * 8 * 1000 * 10 / (( $rate1 + $rate2) * 1024 *1024 * 9) ))
> +	#              ms    byte -> bit   10%        mbit      -> kbit -> bit  10%
> +	local time=$((1000 * size  *  8  * 10 / ((rate1 + rate2) * 1000 * 1000 * 9) ))
>
> 	# mptcp_connect will do some sleeps to allow the mp_join handshake
> 	# completion (see mptcp_connect): 200ms on each side, add some slack
>
> base-commit: 9c6870ffc2198874360447d04eb79c5f578b0f26
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
