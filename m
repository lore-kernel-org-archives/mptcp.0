Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782770
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 00:28:03 +0000 (UTC)
IronPort-SDR: rPP9918ZGFxNiJnf+svrrSlOSyVZ57XM9s8i+df6CFYab7Jt/CUcrOOa7g1fjrkyKincsI2X6A
 Q1ApN3uvdvlg==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="229176793"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="229176793"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 17:28:02 -0700
IronPort-SDR: zm8cVmc1uP3h57vVAwNRO2I5PxLpXsigWfbU4uVljmqGbfzjDWXC9JXLCZYdPOkT7AN96Dol2p
 yAXS4222+BcQ==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="407218522"
Received: from vedsingh-mobl1.amr.corp.intel.com ([10.212.254.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 17:28:02 -0700
Date: Thu, 24 Jun 2021 17:28:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, geliangtang@gmail.com
Subject: Re: [PATCH v5 0/4] mptcp: fix conflicts when using pm.add_signal in
 ADD_ADDR/echo and RM_ADDR process
In-Reply-To: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <7d7b1d1-36b9-8350-77d6-705bc99f6a7@linux.intel.com>
References: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 22 Jun 2021, Yonglong Li wrote:

> fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
> in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
> process.
>
> fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
> only one event can write pm.add_signal. so ADD_ADDR will process
> after add_timer timeout or ADD_ADDR-echo will not be process.
>
> Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.
>
> Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix
> conflicts in using pm.addr_signal porcess.
>
> Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.
>
> v1->v2:
> - remove READ_ONCE under the pm spin lock.
>
> v2->v3:
> - Patch 2: rename mptcp_pm_should_add_addr to mptcp_pm_should_add_signal_addr
> - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change
>   mptcp_pm_add_addr_signal to return void.
>
> v3->v4:
> - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO)) instead
>   of BIT(MPTCP_RM_ADDR_SIGNAL)
> - Patch 3: simple the code; init flags; fix wrong goto logic code;
>
> v4->v5:
> - Patch 3: simple the code of function 'mptcp_established_options_add_addr'

Hi Yonglong -

Thank you for all of your work on this patch series! I think it is close 
to being ready, in terms of code review I don't have any changes to 
suggest.

When I run the ADD_ADDR timeout test cases (mptcp_join.sh -t), I'm seeing 
test case failures on every run because fewer ADD_ADDRs were received than 
were expected.

Here's one run:

"""
[mjmartin@mjmartin-nucvm01 mptcp]$ sudo ./mptcp_join.sh -t -c
Created /tmp/tmp.SoSi2pHquT (size 1 KB) containing data sent by client
Created /tmp/tmp.CGf8pIwMGf (size 1 KB) containing data sent by server
Capturing traffic for test 1 into mp_join-01-ns1-0-kHO27s.pcap
tcpdump: data link type LINUX_SLL2
dropped privs to mjmartin
tcpdump: listening on any, link-type LINUX_SLL2 (Linux cooked v2), 
snapshot length 65535 bytes
149 packets captured
149 packets received by filter
0 packets dropped by kernel
01 signal address, ADD_ADDR timeout     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
Capturing traffic for test 2 into mp_join-02-ns1-0-MXTUAg.pcap
tcpdump: data link type LINUX_SLL2
dropped privs to mjmartin
tcpdump: listening on any, link-type LINUX_SLL2 (Linux cooked v2), 
snapshot length 65535 bytes
150 packets captured
150 packets received by filter
0 packets dropped by kernel
02 signal address, ADD_ADDR6 timeout    syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[fail] got 2 ADD_ADDR[s] expected 4
  - echo  [ ok ]
Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
Client ns stats
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtAddAddr                 2                  0.0
Capturing traffic for test 3 into mp_join-03-ns1-0-J4cBbN.pcap
tcpdump: data link type LINUX_SLL2
dropped privs to mjmartin
tcpdump: listening on any, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 65535 bytes
432 packets captured
432 packets received by filter
0 packets dropped by kernel
03 signal addresses, ADD_ADDR timeout   syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
Capturing traffic for test 4 into mp_join-04-ns1-0-0DJYdc.pcap
tcpdump: data link type LINUX_SLL2
dropped privs to mjmartin
tcpdump: listening on any, link-type LINUX_SLL2 (Linux cooked v2), 
snapshot length 65535 bytes
415 packets captured
415 packets received by filter
0 packets dropped by kernel
04 invalid address, ADD_ADDR timeout    syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[fail] got 7 ADD_ADDR[s] expected 8
  - echo  [ ok ]
Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
Client ns stats
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtAddAddr                 7                  0.0
"""

If you run the tests with -c (mptcp_join.sh -t -c) you can review the 
.pcap files to see if the new behavior is expected.

Please see if you can replicate the test results above (I've seen 
different combinations of these tests succeed and fail). If I'm not the 
only person seeing the failures, either the tests or the code need to be 
updated.


Best regards,

Mat



>
> Yonglong Li (4):
>  mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
>  mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
>  mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
>  mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
>
> include/net/mptcp.h    |   1 +
> net/mptcp/options.c    | 161 ++++++++++++++++++++++++++++++++-----------------
> net/mptcp/pm.c         |  53 +++++++---------
> net/mptcp/pm_netlink.c |  10 ++-
> net/mptcp/protocol.h   |  31 ++++------
> 5 files changed, 147 insertions(+), 109 deletions(-)
>
> -- 
> 1.8.3.1
>
>

--
Mat Martineau
Intel
