Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344B111B
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 21:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655932254; x=1687468254;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=g31r/RcqcsaFsfb/4C/FiQfbtdRCjCo2sY3WIjysn4E=;
  b=DbcQDG6WxyfBobVN+i5KIF0rBvNPAu9xWoAgkYDfn7Lm7B5JeyKDwJPV
   0qjRM+Zzk6hh73y69u9cYgAO4v7lF9/WG7zxdJjd7w3SR3WF2iIc/EvcG
   c/anlYMP7zdnMG249M2QwHSYrswSt/jwVSOVADotyx2yc5oLnWS1pWesa
   WNkbAIC5flp4favG5jOeXZXhYaqQyTaz4T+HIkp9aHdh8bVt9LwZGm4Qe
   mwhdWAz5VLesxI6kDbJG6NHX1rqkwiucvfku2j2h+wLKu+tqc2urN6O06
   2q7/PWwURvdoVzKd57MZpfKtKlR/6nngvE++BF5JrIGIUkNtj7dltt/Ea
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260981180"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260981180"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 14:10:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834318553"
Received: from desireen-mobl.amr.corp.intel.com ([10.209.126.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 14:10:53 -0700
Date: Wed, 22 Jun 2022 14:10:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] Squash-to: "selftests: mptcp: more stable diag
 tests"
In-Reply-To: <f1109179c77a14bed80be75bb297aac1ef867a49.1655891188.git.pabeni@redhat.com>
Message-ID: <ffef409e-3a5-72df-ff5f-7eb63ad3b53@linux.intel.com>
References: <f1109179c77a14bed80be75bb297aac1ef867a49.1655891188.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Jun 2022, Paolo Abeni wrote:

> The "....chk remote_key" testcase is failing quite often in debug
> build. I guess the mptcp_connect completes before the script execute
> this latter test, so I'm adding another large wait. It should not
> impact the test run-time, as the mptcp_connect processes are terminated
> just after running the check.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this is wild guess, mostly to trigger/inspect the test results

Looks good to squash - CI looks ok too.

- Mat


> ---
> tools/testing/selftests/net/mptcp/diag.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index ee2f238255ec..515859a5168b 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -179,7 +179,7 @@ ip -n $ns link set dev lo up
> echo "a" | \
> 	timeout ${timeout_test} \
> 		ip netns exec $ns \
> -			./mptcp_connect -p 10000 -l -t ${timeout_poll} \
> +			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
> 				0.0.0.0 >/dev/null &
> wait_local_port_listen $ns 10000
> chk_msk_nr 0 "no msk on netns creation"
> @@ -188,7 +188,7 @@ chk_msk_listen 10000
> echo "b" | \
> 	timeout ${timeout_test} \
> 		ip netns exec $ns \
> -			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} \
> +			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
> 				127.0.0.1 >/dev/null &
> wait_connected $ns 10000
> chk_msk_nr 2 "after MPC handshake "
> @@ -200,13 +200,13 @@ flush_pids
> echo "a" | \
> 	timeout ${timeout_test} \
> 		ip netns exec $ns \
> -			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} \
> +			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
> 				0.0.0.0 >/dev/null &
> wait_local_port_listen $ns 10001
> echo "b" | \
> 	timeout ${timeout_test} \
> 		ip netns exec $ns \
> -			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} \
> +			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} -w 20 \
> 				127.0.0.1 >/dev/null &
> wait_connected $ns 10001
> chk_msk_fallback_nr 1 "check fallback"
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
