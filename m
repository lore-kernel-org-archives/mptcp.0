Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A82F21
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 00:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643847321; x=1675383321;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gK5+iuWGPI9DlIXKr0r65JAMvsy7m74+ssLN7MiQW0Q=;
  b=OvfnYlrCwRZYPw4fbub2ut74OZwlmvbp+y2pNJLmeYz9yeCLp/FWU1mv
   rVfq7MFywVQIWurZtMi3AunAxQD9H/0GiY8Qdn+Mwce+sAWanx3+jTe4m
   4vRNYlyys0+d0kItwMQCMMpT4XJaHqq1dO7Wi9hraIL+/iw7Pu+N7NLCg
   UaHx+dI4k61S+4MgaTJfskPvAcO+9LTOraHnesRGCEqq4Eqxu/ndhF3E7
   ushcRIycKk79BTTdDMkO8tIct5EEvfXFs24bNjNqwV08H1Qygni5NFs6f
   viW+TtR5Ew2GFQduR7ypPvYz9QP3klIlcGMsCiHjCFvyAJ/NwbmOTjSmv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247998884"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="247998884"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 16:15:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="480311834"
Received: from lddickin-mobl1.amr.corp.intel.com ([10.212.228.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 16:15:17 -0800
Date: Wed, 2 Feb 2022 16:15:17 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix diag instability
In-Reply-To: <8e7b626d99b8c28b8638f850841707c63deb0bb4.1643825648.git.pabeni@redhat.com>
Message-ID: <d2e4a5f1-e7b9-349e-ba1d-e9b2b4148da3@linux.intel.com>
References: <8e7b626d99b8c28b8638f850841707c63deb0bb4.1643825648.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 2 Feb 2022, Paolo Abeni wrote:

> Increase the time waiting for mptcp sockets to get established,
> to cope with very slow running host, or high jitter caused by
> VMs.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> note: just to trigger the public CI, probably a better commit
> message needed

Ok, noted. I also haven't seen instability in diag.sh, for what it's 
worth.

Suggestion for the commit message, explain why the change from "-j" to "-r 
0" when invoking mptcp_connect.

-Mat

> ---
> tools/testing/selftests/net/mptcp/diag.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 2674ba20d524..baafd36c3e0e 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -87,9 +87,9 @@ chk_msk_nr 0 "no msk on netns creation"
> echo "b" | \
> 	timeout ${timeout_test} \
> 		ip netns exec $ns \
> -			./mptcp_connect -p 10000 -j -t ${timeout_poll} \
> +			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} \
> 				127.0.0.1 >/dev/null &
> -sleep 0.1
> +sleep 0.4
> chk_msk_nr 2 "after MPC handshake "
> chk_msk_remote_key_nr 2 "....chk remote_key"
> chk_msk_fallback_nr 0 "....chk no fallback"
> @@ -105,9 +105,9 @@ sleep 0.1
> echo "b" | \
> 	timeout ${timeout_test} \
> 		ip netns exec $ns \
> -			./mptcp_connect -p 10001 -j -t ${timeout_poll} \
> +			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} \
> 				127.0.0.1 >/dev/null &
> -sleep 0.1
> +sleep 0.4
> chk_msk_fallback_nr 1 "check fallback"
> flush_pids
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
