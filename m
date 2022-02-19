Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB64F21
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645228805; x=1676764805;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RVO/lzwi03GfOeTxn3XVs9t4aW+vgFxmpdBkmX7PnHc=;
  b=iC6++QVCDbOu0Hd8+34mO+SjLBk5ul0irHAk+Tz550pSPe1o5/pdA9G4
   uGEqCssZcWNA2NuRGLGyY1ieGZB4YHVPSLcNhaEjtt7Hjt26bmusu+h/t
   9M5+VBnNE/5T5joT6SA6sYgMRRt+M/glEWhF1patpDdKqluqdHJAgdCQX
   TdNigtlaXtYJ7zcgjpQsvChjup9SXBta/VhqrGseUIclax73YMfi/KWRK
   VuLG4jRTSkJsI9b3/Vm44v+qsfjJcAm64b/QHfXKVOA3bxy6ASq7FNJm3
   h4JafJhEqJjX8hvHrBlvBED+rAoy3bsqYYHnF7WKTUuxoJ7GHXOZkVKT1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231218230"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="231218230"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 16:00:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="705573892"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 16:00:04 -0800
Date: Fri, 18 Feb 2022 16:00:03 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add fastclose
 testcases"
In-Reply-To: <22588887e5e516015f7f7b9d09112efc679fecf7.1645159759.git.geliang.tang@suse.com>
Message-ID: <bf71c5e-2814-9774-69c8-e938b67db35c@linux.intel.com>
References: <22588887e5e516015f7f7b9d09112efc679fecf7.1645159759.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 18 Feb 2022, Geliang Tang wrote:

> This patch makes the fastclose testcase more stable. I had tested it
> over 10,000 times, no failures occurred.
>

It seems mostly stable to me too.

The first time I tried "./mptcp_join.sh -zC" I got a failure! I have not 
been able to reproduce it.

The output:

001 fastclose test                       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                          sum[ ok ] - csum  [ ok ]
                                          ftx[ ok ] - failrx[ ok ]
                                          rtx[ ok ] - rstrx [ ok ]
                                          itx[ ok ] - infirx[ ok ]
                                          ctx[ ok ] - fclzrx[fail] got 0 MP_FASTCLOSE[s] RX expected 1
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpInSegs                       361                0.0
TcpOutSegs                      917                0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               130                0.0
TcpExtTCPBacklogCoalesce        4                  0.0
TcpExtTCPOrigDataSent           786                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       26                 0.0
TcpExtTCPDelivered              785                0.0
MPTcpExtMPCapableSYNRX          2                  0.0
MPTcpExtMPCapableACKRX          2                  0.0
Client ns stats
TcpActiveOpens                  2                  0.0
TcpEstabResets                  1                  0.0
TcpInSegs                       344                0.0
TcpOutSegs                      926                0.0
TcpOutRsts                      2                  0.0
TcpExtTCPPureAcks               122                0.0
TcpExtTCPBacklogCoalesce        7                  0.0
TcpExtTCPOrigDataSent           788                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       27                 0.0
TcpExtTCPDelivered              790                0.0
MPTcpExtMPCapableSYNTX          2                  0.0
MPTcpExtMPCapableSYNACKRX       2                  0.0
MPTcpExtMPFastcloseTx           1                  0.0
MPTcpExtMPRstTx                 1                  0.0
                                          rtx[ ok ] - rstrx [fail] got 0 MP_RST[s] RX expected 1
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpInSegs                       361                0.0
TcpOutSegs                      917                0.0
TcpExtTW                        1                  0.0
TcpExtTCPPureAcks               130                0.0
TcpExtTCPBacklogCoalesce        4                  0.0
TcpExtTCPOrigDataSent           786                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       26                 0.0
TcpExtTCPDelivered              785                0.0
MPTcpExtMPCapableSYNRX          2                  0.0
MPTcpExtMPCapableACKRX          2                  0.0
Client ns stats
TcpActiveOpens                  2                  0.0
TcpEstabResets                  1                  0.0
TcpInSegs                       344                0.0
TcpOutSegs                      926                0.0
TcpOutRsts                      2                  0.0
TcpExtTCPPureAcks               122                0.0
TcpExtTCPBacklogCoalesce        7                  0.0
TcpExtTCPOrigDataSent           788                0.0
TcpExtTCPHystartTrainDetect     1                  0.0
TcpExtTCPHystartTrainCwnd       27                 0.0
TcpExtTCPDelivered              790                0.0
MPTcpExtMPCapableSYNTX          2                  0.0
MPTcpExtMPCapableSYNACKRX       2                  0.0
MPTcpExtMPFastcloseTx           1                  0.0
MPTcpExtMPRstTx                 1                  0.0
    invert

Given that I can't repro, I'm still ok with squashing this.

> 1. Drop "fastclose test 2". The two tests are somewhat repetitive, and
> test 2 is more likely to fail than test 1.

Ok. It didn't seem to add much coverage, I agree.

>
> And patch 7 in this series ("selftests: mptcp: fastclose check in
> mptcp_connect") should be dropped too. It may break mptcp_connect.sh.
>

I marked it as "Rejected" in patchwork.

> 2. Use the test_linkfail value to make 1024KB test files. So patch 4
> in the "add mp_fail testcases" series ("selftests: mptcp: reuse linkfail
> to make given size files") and its squash-to patch (Squash to "selftests:
> mptcp: reuse linkfail to make given size files v8") need to be moved into
> this series, just before the commit ("selftests: mptcp: add fastclose
> testcases").
>
> The order of all the mp_fastclose and mp_fail testcases patches in my
> tree looks like this:
>
> pick a854ead2766e mptcp: add the mibs for MP_FASTCLOSE
> pick 57f50b740bdc selftests: mptcp: add the MP_FASTCLOSE mibs check
> pick 12ae36a6ccc1 mptcp: add the mibs for MP_RST
> pick fc3da2c8bcbc selftests: mptcp: add the MP_RST mibs check
> pick 963f2f26574e Squash to "selftests: mptcp: add the MP_RST mibs check v3"
> pick 46680be81472 selftests: mptcp: add extra_args in do_transfer
> pick 81803638389d selftests: mptcp: reuse linkfail to make given size files
> pick fe9ed20f6bdc Squash to "selftests: mptcp: reuse linkfail to make given size files v8"
> pick 24ba919394f9 selftests: mptcp: add fastclose testcases
> pick fb989057969a Squash to "selftests: mptcp: add fastclose testcases"
> pick 9985ed286b3a Squash to "mptcp: infinite mapping receiving"
> pick 0d5bc6ecc54d Squash to "selftests: mptcp: add infinite map mibs check"
> pick 2ed9ce9e914b selftests: mptcp: add more arguments for chk_join_nr
> pick 82435d67b9e8 Squash to "selftests: mptcp: add more arguments for chk_join_nr v8"
> pick bcc0e73c5acb selftests: mptcp: add the MP_FAIL testcases
>
> If it's better to resend the whole series, please let me know.
>

Everything applied ok for me without conflicts. Matthieu would you prefer 
a resend?


-Mat


> 3. Please update the subject:
>
> '''
> selftests: mptcp: add fastclose testcase
> '''
>
> And update the commit log:
>
> '''
> This patch added the self test for MP_FASTCLOSE. Reused the argment
> addr_nr_ns2 of do_transfer() to pass the extra argments '-I 2' to
> mptcp_connect commands. Then mptcp_connect disconnected the
> connections to trigger the MP_FASTCLOSE sending and receiving. Used
> chk_fclose_nr to check the MP_FASTCLOSE mibs and used chk_rst_nr to
> check the MP_RST mibs. This test used the test_linkfail value to make
> 1024KB test files.
>
> The output looks like this:
>
> Created /tmp/tmp.XB8sfv1hJ0 (size 1024 KB) containing data sent by client
> Created /tmp/tmp.RtTDbzqrXI (size 1024 KB) containing data sent by server
> 001 fastclose test                syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                  ctx[ ok ] - fclzrx[ ok ]
>                                  rtx[ ok ] - rstrx [ ok ]   invert
> '''
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
> 1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2e95a8d321ab..1ef0119d7b7a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2289,16 +2289,10 @@ userspace_tests()
> fastclose_tests()
> {
> 	reset
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_2
> -	chk_join_nr "fastclose test 1" 0 0 0
> +	run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_2
> +	chk_join_nr "fastclose test" 0 0 0
> 	chk_fclose_nr 1 1
> 	chk_rst_nr 1 1 invert
> -
> -	reset
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 fastclose_3 slow
> -	chk_join_nr "fastclose test 2" 0 0 0
> -	chk_fclose_nr 2 2
> -	chk_rst_nr 2 2 invert
> }
>
> all_tests()
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
