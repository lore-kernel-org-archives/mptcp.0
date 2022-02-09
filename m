Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62F2C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644449987; x=1675985987;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fghnLF7P5Pr6ukiSKGBmibwiIfepCVy8Jn7R4XTkBD8=;
  b=T+zqEvfScU3+2qkiS2yek8H2U1TY/HvPQ/JzyqLeMuQUpVwjuWXBGZpv
   Lt+bSmRIVTmyfOF8aYZmHMV5CFlp0tQ7BbIgwgkV4dZ82Hft3nI7PJSWI
   89vnTnY11y5zDVltDecLz7GGBlpND3/7txTPjmu39Qum3xRzYbgbIXtcG
   o4hqc5EcaLfigl9u2AO6Ks32lxhHyuf79xO3h22gLxGJlDTtXG4uE3V2Y
   cCgIIrP2HZaS0RjI/Aj8Xs27PvpKUBoRqQTpr04SEqkHl3aE/m7QTCv0S
   8JgtbY+hbyOCJ/boKmp5bFGB4bFU+Kbk8kJSwcGFmqTWPE6liOJ0WO1yN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="246950335"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="246950335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:39:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="541358131"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:39:46 -0800
Date: Wed, 9 Feb 2022 15:39:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add mp_fail
 testcases v5"
In-Reply-To: <d7ae1690ad1da5e0614e239a429e91e4dbc52155.1644414480.git.geliang.tang@suse.com>
Message-ID: <6674c36-961c-6910-881-52b4891d93eb@linux.intel.com>
References: <d7ae1690ad1da5e0614e239a429e91e4dbc52155.1644414480.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 9 Feb 2022, Geliang Tang wrote:

> We will get this failure in v5 in rare cases, about one percent
> probability:
>
> Created /tmp/tmp.e4nE5Q14mj (size 1024 KB) containing data sent by client
> Created /tmp/tmp.QwpQYClFnm (size 1024 KB) containing data sent by server
> 001 MP_FAIL MP_RST: 0 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                         sum[fail] got 0 data checksum error[s] expected 1
>                                         ftx[fail] got 0 MP_FAIL[s] TX expected 1
>                                         rtx[fail] got 0 MP_RST[s] TX expected 1
>                                         itx[ ok ] - infirx[ ok ]
>
> We shouldn't always expect getting 1 MP_FAIL. If no checksum failure
> occur, we should expect no MP_FAIL.

There are two main reasons we would see no checksum failure:

1. TC rules didn't produce the bit flips. In this case it seems like the 
script should retry.

2. TC rules did trigger, checksum code failed to detect it, and file 
contents don't match. This should fail the test case. I think the test 
should catch this.


Since it looks like v5 plus this squash doesn't seem to handle #1 I'll 
mark both as "Changes Requested" in patchwork.

-Mat


>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 9f5c9afc26d2..cfa5f168e6db 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2287,7 +2287,9 @@ fail_tests()
> 	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> 	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> 	run_tests $ns1 $ns2 10.0.1.1 3
> -	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 2 2 2 1 1
> +	local pedit_action=$(pedit_action_pkts)
> +	chk_join_nr "MP_FAIL MP_RST: $pedit_action corrupted pkts" 2 2 2 \
> +			$((!!$pedit_action)) $((!!$pedit_action))
>
> 	# single subflow
> 	reset_with_fail 1
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
