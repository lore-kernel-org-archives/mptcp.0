Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B821844
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644974902; x=1676510902;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=49f5FhBjCCsPKaePK3TX7cO9Fi2mHi7ZWmMdIvKe/YU=;
  b=PEEqZns1XzqwB0p8Nt0URYGmsrkNARuFLjE2w4j+wT2XTfHwGaONwACo
   p1LOrVf6BSWaZtQivPfHlqUKpGoQAx17ZoFfBhOFc5zznwe7y7Uen06ld
   sbIK9Au+l25uD2P0nPhi6k4L+A2Jy6m90tPxvMjKqgxtmQMlCTYqi2af9
   GSkiWMDHbbeTfx92pSwCuNF4N9Wpz7SHEWdwovkEXVUEqAu5BE1NFsTuV
   tEG7H19UE7ANhro5H72d5I/ldJwrQDuczSRtX0QvLJK7Z0THC0LJ0olU4
   Do6LenwN2gQ5wz1rTw03kdUIjuxT59Yq+LWyPe08Z4H8CCDAd1kJ9Xway
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="234038416"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="234038416"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:28:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571078854"
Received: from skling-mobl1.amr.corp.intel.com ([10.212.200.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:28:21 -0800
Date: Tue, 15 Feb 2022 17:28:21 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 0/5] add mp_fail testcases
In-Reply-To: <cover.1644923833.git.geliang.tang@suse.com>
Message-ID: <4e901f58-10e6-af-869e-c343dac78c36@linux.intel.com>
References: <cover.1644923833.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 15 Feb 2022, Geliang Tang wrote:

> v8:
> - move two MP_RST mibs patches into the "add fastclose testcases" series.
> - allow multiple checksum errors in patch 3.
> - depends on "add fastclose testcases v3".
>

Thanks Geliang. This series (plus the two associated squash-to patches in 
patchwork) look good to me. Matthieu, note the dependency on the fastclose 
test series that has a pending question about intermittent failures.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> RESEND:
> - no code modified, just updated the commit logs and comments.
> v7:
> This version makes the multiple subflows test more stable.
> - Add delays and drop 'retry' in the multiple subflows test in patch 7.
> - Don't add two addresses for the multiple subflows test in patch 7, add
> one address 10.0.2.2 is enough, this make it more stable.
> - Add a comment in patch 6.
> - Rebased to export/20220211T054659.
> - A 500 times loop test log of v7 will be attached.
>
> v6:
> - Split two patches from the last one.
> - Retry the multiple subflows test three times to fix this
> "MP_FAIL MP_RST: 0 corrupted pkts" failure reported by me in v5:
>
> Created /tmp/tmp.e4nE5Q14mj (size 1024 KB) containing data sent by client
> Created /tmp/tmp.QwpQYClFnm (size 1024 KB) containing data sent by server
> 001 MP_FAIL MP_RST: 0 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                         sum[fail] got 0 data checksum error[s] expected 1
>                                         ftx[fail] got 0 MP_FAIL[s] TX expected 1
>                                         rtx[fail] got 0 MP_RST[s] TX expected 1
>                                         itx[ ok ] - infirx[ ok ]
>
> A test log of running v6 500 times is attached, named v6-loop-500-times.log,
> in it, we can see retry happend 8 times (116, 136, 236, 295, 297, 402, 444,
> 457), and no "0 corrupted pkts" any more.
>
> - Reduce the single subflow test files size from 1024KB to 128KB to fix
> this "file received by client does not match" failure reported by CI and
> Matt in v5:
>
> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # file received by server has inverted byte at 195585
> # 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
> #                                          sum[ ok ] - csum  [ ok ]
> #                                          ftx[ ok ] - failrx[ ok ]
> #                                          rtx[ ok ] - rstrx [ ok ]
> #                                          itx[ ok ] - infirx[ ok ]
> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # [ FAIL ] file received by client does not match (in, out):
> # -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # file received by server has inverted byte at 169
> # 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] - ack[ ok ]
> #                                          sum[ ok ] - csum  [ ok ]
> #                                          ftx[ ok ] - failrx[ ok ]
> #                                          rtx[ ok ] - rstrx [ ok ]
> #                                          itx[ ok ] - infirx[ ok ]
>
> In the attached v6-loop-500-times.log, no "file received by client does
> not match" any more.
>
> I think this v6 is very stable, but there are still 6 tests failed in the
> 500 time tests log (68 77 97 112 161 243). These failures are all due to
> get one more unexpected checksum failure:
>
> > cat v6-loop-500-times.log  | grep "\[fail"
>                                         sum[fail] got 2 data checksum error[s] expected 1
>                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
> - failrx[fail] got 2 MP_FAIL[s] RX expected 1
>                                         rtx[fail] got 2 MP_RST[s] TX expected 1
> - rstrx [fail] got 2 MP_RST[s] RX expected 1
>                                         sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
>                                         sum[fail] got 2 data checksum error[s] expected 1
>                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
> - failrx[fail] got 2 MP_FAIL[s] RX expected 1
>                                         rtx[fail] got 2 MP_RST[s] TX expected 1
> - rstrx [fail] got 2 MP_RST[s] RX expected 1
>                                         sum[ ok ] - csum  [fail] got 1 data checksum error[s] expected 0
>                                         rtx[fail] got 2 MP_RST[s] TX expected 1
> - rstrx [fail] got 2 MP_RST[s] RX expected 1
>                                         sum[fail] got 2 data checksum error[s] expected 1
>                                         ftx[fail] got 2 MP_FAIL[s] TX expected 1
> - failrx[fail] got 2 MP_FAIL[s] RX expected 1
>                                         rtx[fail] got 2 MP_RST[s] TX expected 1
> - rstrx [fail] got 2 MP_RST[s] RX expected 1
>
> These failures are related the checksum bug reported by me, issue #255.
> When transferring a larger file, the checksum sometimes fails. Running
> "./mptcp_connect.sh -C" in 10 times, we will the MP_FAILs. If we solve
> issue #255 in the future, this mp_fail testcases will be more stable.
>
> v5:
> - update patch 5 as Matt suggested.
> - use '|| exit 1'
> - drop jq
> - drop pedit_action
>
> v4:
> - add the mibs for MP_RST
> - patch 4 "selftests: mptcp: add MP_RST mibs check" uses the variable
> $nr_blank, so it depends on the commit "selftests: mptcp: adjust output
> alignment for more tests".
>
> v3:
> - check the exit code of iptables.
> - add ip6tables support for reset_with_fail too.
> - add the null check for $packets
> - rename nr_mp_fail to pedit_action and get_nr_mp_fail to
> pedit_action_happened
>
> This is v12 of the mp_fail testcases with Matt's changes. It works well
> and it's very stable.
>
> Geliang Tang (5):
>  Squash to "mptcp: infinite mapping receiving"
>  Squash to "selftests: mptcp: add infinite map mibs check"
>  selftests: mptcp: add more arguments for chk_join_nr
>  selftests: mptcp: reuse linkfail to make given size files
>  selftests: mptcp: add the MP_FAIL testcases
>
> net/mptcp/subflow.c                           |   1 +
> tools/testing/selftests/net/mptcp/config      |   8 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 216 +++++++++++++++---
> 3 files changed, 192 insertions(+), 33 deletions(-)
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
