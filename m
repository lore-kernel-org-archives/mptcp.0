Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADD71
	for <mptcp@lists.linux.dev>; Wed, 19 May 2021 08:42:00 +0000 (UTC)
IronPort-SDR: 5G4TdMsrMJETvzsEORWrMhXdn0jI4MfWP+35TIILvPRXr37WA9Av9OgO9xVV37nOhtkMWSNFT7
 fxK45jDvsubg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188334076"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="xz'?yaml'?scan'208";a="188334076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 01:41:58 -0700
IronPort-SDR: Y0IHT030czwKJGHirgyNzpsKwa30bF7tupNZ8DaIDeXgDkYJI0Cp5PvB3z3k718zbEkZZV6N/I
 dhdkD4rqL5Uw==
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="xz'?yaml'?scan'208";a="439875899"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 01:41:53 -0700
Date: Wed, 19 May 2021 16:58:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Florian Westphal <fw@strlen.de>
Cc: 0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	lkp@lists.01.org, mptcp@lists.linux.dev,
	Florian Westphal <fw@strlen.de>
Subject: [sock]  d1023bc19b: kernel-selftests.net.rxtimestamp.sh.fail
Message-ID: <20210519085844.GG29704@xsang-OptiPlex-9020>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <20210511133659.29982-3-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: d1023bc19bee0379b804309f9be5dd9f91dfba00 ("[PATCH v2 mptcp-next 2/8=
] sock: expose so_timestamp options for mptcp")
url: https://github.com/0day-ci/linux/commits/Florian-Westphal/add-cmsg-sup=
port-to-receive-path/20210511-213838
base: https://github.com/multipath-tcp/mptcp_net-next.git export

in testcase: kernel-selftests
version: kernel-selftests-x86_64-0d95472a-1_20210507
with following parameters:

	group: net
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz with 3=
2G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
=2E3-kselftests-d1023bc19bee0379b804309f9be5dd9f91dfba00
2021-05-15 17:43:02 mount --bind /lib/modules/5.12.0-15073-gd1023bc19bee/ke=
rnel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d1023bc19bee037=
9b804309f9be5dd9f91dfba00/lib
2021-05-15 17:43:02 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2021-05-15 17:43:02 sed -i s/default_timeout=3D45/default_timeout=3D300/ /k=
selftests/kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
LKP SKIP net.l2tp.sh
LKP SKIP net.tls
2021-05-15 17:43:05 /kselftests/run_kselftest.sh -c net
TAP version 13
1..49
# selftests: net: reuseport_bpf
# ---- IPv4 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP w/ mapped IPv4 ----
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# ---- IPv4 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP w/ mapped IPv4 ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing filter add without bind...
# SUCCESS
ok 1 selftests: net: reuseport_bpf
# selftests: net: reuseport_bpf_cpu
# ---- IPv4 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# SUCCESS
ok 2 selftests: net: reuseport_bpf_cpu
# selftests: net: reuseport_bpf_numa
# ---- IPv4 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv4 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# SUCCESS
ok 3 selftests: net: reuseport_bpf_numa
# selftests: net: reuseport_dualstack
# ---- UDP IPv4 created before IPv6 ----
# ---- UDP IPv6 created before IPv4 ----
# ---- UDP IPv4 created before IPv6 (large) ----
# ---- UDP IPv6 created before IPv4 (large) ----
# ---- TCP IPv4 created before IPv6 ----
# ---- TCP IPv6 created before IPv4 ----
# SUCCESS
ok 4 selftests: net: reuseport_dualstack
# selftests: net: reuseaddr_conflict
# Opening 127.0.0.1:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening in6addr_any:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening INADDR_ANY:9999 after closing ipv6 socket
# bind: Address already in use
# Successok 5 selftests: net: reuseaddr_conflict
# selftests: net: run_netsocktests
# --------------------
# running socket test
# --------------------
# [PASS]
ok 6 selftests: net: run_netsocktests
# selftests: net: run_afpackettests
# --------------------
# running psock_fanout test
# --------------------
# test: control single socket
# test: control multiple sockets
# test: control multiple sockets, max_num_members
# test: unique ids
#=20
# test: datapath 0x0 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D15,5
# warning: incorrect queue lengths
# info: count=3D0,20, expect=3D20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
#=20
# test: datapath 0x0 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D15,5
# warning: incorrect queue lengths
# info: count=3D0,20, expect=3D20,5
# warning: incorrect queue lengths
# info: trying alternate ports (19)
#=20
# test: datapath 0x0 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D5,20, expect=3D20,5
#=20
# test: datapath 0x1000 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D15,20, expect=3D20,15
#=20
# test: datapath 0x1 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D10,10, expect=3D10,10
# info: count=3D17,18, expect=3D18,17
#=20
# test: datapath 0x3 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x6 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x7 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x2 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D20,0
# info: count=3D20,0, expect=3D20,0
#=20
# test: datapath 0x2 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D0,20
# info: count=3D0,20, expect=3D0,20
#=20
# test: datapath 0x2000 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,20, expect=3D20,20
# info: count=3D20,20, expect=3D20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# OK. All tests passed
# [PASS]
# --------------------
# running txring_overwrite test
# --------------------
# read: a (0x61)
# read: b (0x62)
# [PASS]
ok 7 selftests: net: run_afpackettests
# selftests: net: test_bpf.sh
# test_bpf: ok
ok 8 selftests: net: test_bpf.sh
# selftests: net: netdevice.sh
# SKIP: eth0: interface already up
# PASS: eth0: ethtool list features
# PASS: eth0: ethtool dump
# PASS: eth0: ethtool stats
# SKIP: eth0: interface kept up
ok 9 selftests: net: netdevice.sh
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: promote_secondaries complete
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# PASS: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias ff6a2666-77ec-411f-829b-36b59897d7dd for test-dummy0
# PASS: vrf
# PASS: vxlan
# PASS: fou
# PASS: macsec
# PASS: ipsec
# PASS: ipsec_offload
# PASS: bridge fdb get
# PASS: neigh get
# Error: Unknown device type.
# Error: argument "test-bond0" is wrong: Device does not exist
#=20
# Error: argument "test-bond0" is wrong: Device does not exist
#=20
# Cannot find device "test-bond0"
# Cannot find device "test-bond0"
# FAIL: bridge_parent_id
not ok 10 selftests: net: rtnetlink.sh # exit=3D1
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh changes)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
anges)
# PASS: policy matches (exceptions and block policies after hresh changes)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hthresh change in ns3)
# PASS: direct policy matches (exceptions and block policies after hthresh =
change in ns3)
# PASS: policy matches (exceptions and block policies after hthresh change =
in ns3)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter htresh change to normal)
# PASS: direct policy matches (exceptions and block policies after htresh c=
hange to normal)
# PASS: policy matches (exceptions and block policies after htresh change t=
o normal)
# PASS: policies with repeated htresh change
# PASS: policies inserted in random order
ok 11 selftests: net: xfrm_policy.sh
# selftests: net: test_blackhole_dev.sh
# test_blackhole_dev: ok
ok 12 selftests: net: test_blackhole_dev.sh
# selftests: net: fib_tests.sh
#=20
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [=
 OK ]
#     TEST: IPv6 fibmatch - no route                                      [=
 OK ]
#=20
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [=
 OK ]
#     TEST: IPv6 - multipath down to single path                          [=
 OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [=
 OK ]
#=20
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - no linkdown flag                                       [=
 OK ]
#     TEST: IPv6 - no linkdown flag                                       [=
 OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - linkdown flag set                                      [=
 OK ]
#     TEST: IPv6 - linkdown flag set                                      [=
 OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 no linkdown flag                                         [=
 OK ]
#     TEST: IPv6 no linkdown flag                                         [=
 OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# IPv4 nexthop tests
# <<< write me >>>
#=20
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [=
 OK ]
#     TEST: Directly connected nexthop, unicast address with device       [=
 OK ]
#     TEST: Gateway is linklocal address                                  [=
 OK ]
#     TEST: Gateway is linklocal address, no device                       [=
 OK ]
#     TEST: Gateway can not be local unicast address                      [=
 OK ]
#     TEST: Gateway can not be local unicast address, with device         [=
 OK ]
#     TEST: Gateway can not be a local linklocal address                  [=
 OK ]
#     TEST: Gateway can be local address in a VRF                         [=
 OK ]
#     TEST: Gateway can be local address in a VRF, with device            [=
 OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [=
 OK ]
#     TEST: Redirect to VRF lookup                                        [=
 OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [=
 OK ]
#     TEST: VRF route, gateway can not be a local address                 [=
 OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [=
 OK ]
#=20
# FIB rule with suppress_prefixlength
#     TEST: FIB rule suppress test                                        [=
 OK ]
#=20
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv6 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with dev-only                                       [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Add new nexthop for existing prefix                           [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Append nexthop to existing route - dev only                   [=
 OK ]
#     TEST: Append nexthop to existing route - reject route               [=
 OK ]
#     TEST: Append nexthop to existing reject route - gw                  [=
 OK ]
#     TEST: Append nexthop to existing reject route - dev only            [=
 OK ]
#     TEST: add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv4 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with reject route                                 [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with reject route                                   [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv6 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Set metric with peer route on local side                      [=
 OK ]
#     TEST: Set metric with peer route on peer side                       [=
 OK ]
#     TEST: Modify metric and peer address on local side                  [=
 OK ]
#     TEST: Modify metric and peer address on peer side                   [=
 OK ]
#=20
# IPv4 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Modify metric of .0/24 address                                [=
 OK ]
#     TEST: Set metric of address with peer route                         [=
 OK ]
#     TEST: Modify metric and peer address for peer route                 [=
 OK ]
#=20
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [=
 OK ]
#     TEST:     MTU of second leg                                         [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [=
 OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [=
 OK ]
#     TEST: Single path route delete                                      [=
 OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#=20
# IPv4 rp_filter tests
#     TEST: rp_filter passes local packets                                [=
FAIL]
#     TEST: rp_filter passes loopback packets                             [=
FAIL]
#=20
# IPv4 delete address route tests
#     TEST: Route removed from VRF when source address deleted            [=
 OK ]
#     TEST: Route in default VRF not removed                              [=
 OK ]
#     TEST: Route removed in default VRF when source address deleted      [=
 OK ]
#     TEST: Route in VRF is not removed by address delete                 [=
 OK ]
#=20
# IPv4 mangling tests
# socat command not found. Skipping test
#=20
# IPv6 mangling tests
# socat command not found. Skipping test
#=20
# Tests passed: 163
# Tests failed:   2
not ok 13 selftests: net: fib_tests.sh # exit=3D1
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
#=20
# ########################################
# Configuring interfaces
#=20
# ######################################################################
# TEST SECTION: IPv4 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath                       [ OK ]
#     TEST: unicast recursive - multipath                       [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device            [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath onlink                [ OK ]
#     TEST: unicast recursive - multipath onlink                [ OK ]
#     TEST: v4-mapped - multipath onlink                        [ OK ]
#     TEST: unicast connected - multipath onlink both nexthops  [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local linklocal address                [ OK ]
#     TEST: Invalid gw - multicast address                      [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: Invalid gw - local linklocal address, VRF           [ OK ]
#     TEST: Invalid gw - multicast address, VRF                 [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
#=20
# Tests passed:  38
# Tests failed:   0
ok 14 selftests: net: fib-onlink-tests.sh
# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK ]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: ipv6: PMTU exceptions                                         [ OK ]
# TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve6: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve6: PMTU exceptions                            [SKIP]
# TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: vti6: PMTU exceptions                                         [ OK ]
# TEST: vti4: PMTU exceptions                                         [ OK ]
# TEST: vti4: default MTU assignment                                  [ OK ]
# TEST: vti6: default MTU assignment                                  [ OK ]
# TEST: vti4: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU changes on link changes                             [ OK ]
# TEST: ipv4: cleanup of cached exceptions                            [ OK ]
# TEST: ipv4: cleanup of cached exceptions - nexthop objects          [ OK ]
# TEST: ipv6: cleanup of cached exceptions                            [ OK ]
# TEST: ipv6: cleanup of cached exceptions - nexthop objects          [ OK ]
# TEST: ipv4: list and flush cached exceptions                        [ OK ]
# TEST: ipv4: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv6: list and flush cached exceptions                        [ OK ]
# TEST: ipv6: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv4: PMTU exception w/route replace                          [ OK ]
# TEST: ipv4: PMTU exception w/route replace - nexthop objects        [ OK ]
# TEST: ipv6: PMTU exception w/route replace                          [ OK ]
# TEST: ipv6: PMTU exception w/route replace - nexthop objects        [ OK ]
ok 15 selftests: net: pmtu.sh
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed =3D 1621101240
# ipv4 defrag with overlaps
# PASS
# seed =3D 1621101240
# ipv6 defrag
# PASS
# seed =3D 1621101245
# ipv6 defrag with overlaps
# PASS
# seed =3D 1621101245
# ipv6 nf_conntrack defrag
# PASS
# seed =3D 1621101251
# ipv6 nf_conntrack defrag with overlaps
# PASS
# seed =3D 1621101252
# all tests done
ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:    878 MB/s    14903 calls/s  14903 msg/s
# tcp rx:    879 MB/s    14821 calls/s
# tcp tx:   1133 MB/s    19219 calls/s  19219 msg/s
# tcp rx:   1134 MB/s    19193 calls/s
# tcp tx:   1016 MB/s    17240 calls/s  17240 msg/s
# tcp zerocopy
# tcp tx:    644 MB/s    10924 calls/s  10924 msg/s
# tcp rx:    644 MB/s    10910 calls/s
# tcp tx:   1217 MB/s    20653 calls/s  20653 msg/s
# tcp rx:   1218 MB/s    20604 calls/s
# tcp tx:    590 MB/s    10017 calls/s  10017 msg/s
# udp
# udp rx:     45 MB/s    32123 calls/s
# udp tx:     45 MB/s    32382 calls/s    771 msg/s
# udp rx:     71 MB/s    51194 calls/s
# udp tx:     72 MB/s    51324 calls/s   1222 msg/s
# udp rx:     43 MB/s    30752 calls/s
# udp tx:     42 MB/s    30534 calls/s    727 msg/s
# udp gso
# udp rx:    163 MB/s   116304 calls/s
# udp tx:    164 MB/s     2796 calls/s   2796 msg/s
# udp rx:    232 MB/s   165926 calls/s
# udp tx:    234 MB/s     3969 calls/s   3969 msg/s
# udp rx:    188 MB/s   134289 calls/s
# udp tx:    190 MB/s     3229 calls/s   3229 msg/s
# udp gso zerocopy
# udp rx:    142 MB/s   101550 calls/s
# udp tx:    145 MB/s     2461 calls/s   2461 msg/s
# udp rx:    168 MB/s   120130 calls/s
# udp tx:    168 MB/s     2852 calls/s   2852 msg/s
# udp rx:    161 MB/s   115129 calls/s
# udp tx:    161 MB/s     2740 calls/s   2740 msg/s
# udp gso timestamp
# udp rx:    158 MB/s   112812 calls/s
# udp tx:    159 MB/s     2707 calls/s   2707 msg/s
# udp rx:    144 MB/s   103202 calls/s
# udp tx:    144 MB/s     2451 calls/s   2451 msg/s
# udp rx:    205 MB/s   146278 calls/s
# udp tx:    205 MB/s     3478 calls/s   3478 msg/s
# udp gso zerocopy audit
# udp rx:    171 MB/s   122210 calls/s
# udp tx:    172 MB/s     2923 calls/s   2923 msg/s
# udp rx:    149 MB/s   106765 calls/s
# udp tx:    150 MB/s     2552 calls/s   2552 msg/s
# udp rx:    171 MB/s   122315 calls/s
# udp tx:    173 MB/s     2935 calls/s   2935 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    169 MB/s       8410 calls (2803/s)       8410 msgs (2803/s)
# Zerocopy acks:                8410
# udp gso timestamp audit
# udp rx:    143 MB/s   101891 calls/s
# udp tx:    145 MB/s     2471 calls/s   2471 msg/s
# udp rx:    171 MB/s   122366 calls/s
# udp tx:    171 MB/s     2914 calls/s   2914 msg/s
# udp rx:    199 MB/s   141924 calls/s
# udp tx:    198 MB/s     3375 calls/s   3375 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    176 MB/s       8760 calls (2920/s)       8760 msgs (2920/s)
# Tx Timestamps:                8760 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    150 MB/s   107342 calls/s
# udp tx:    153 MB/s     2603 calls/s   2603 msg/s
# udp rx:    146 MB/s   104202 calls/s
# udp tx:    146 MB/s     2478 calls/s   2478 msg/s
# udp rx:    126 MB/s    89838 calls/s
# udp tx:    125 MB/s     2134 calls/s   2134 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    145 MB/s       7215 calls (2405/s)       7215 msgs (2405/s)
# Tx Timestamps:                7215 received                 0 errors
# Zerocopy acks:                7215
# ipv6
# tcp
# tcp tx:    526 MB/s     8927 calls/s   8927 msg/s
# tcp rx:    526 MB/s     8873 calls/s
# tcp tx:   1311 MB/s    22240 calls/s  22240 msg/s
# tcp rx:   1312 MB/s    22174 calls/s
# tcp tx:   1005 MB/s    17051 calls/s  17051 msg/s
# tcp zerocopy
# tcp tx:    383 MB/s     6499 calls/s   6499 msg/s
# tcp rx:    383 MB/s     6213 calls/s
# tcp tx:    395 MB/s     6709 calls/s   6709 msg/s
# tcp rx:    395 MB/s     6365 calls/s
# tcp tx:    412 MB/s     6993 calls/s   6993 msg/s
# udp
# udp rx:     28 MB/s    20528 calls/s
# udp tx:     28 MB/s    20855 calls/s    485 msg/s
# udp rx:     24 MB/s    17684 calls/s
# udp tx:     24 MB/s    17544 calls/s    408 msg/s
# udp rx:     32 MB/s    23731 calls/s
# udp gso
# udp rx:    120 MB/s    87910 calls/s
# udp tx:    122 MB/s     2075 calls/s   2075 msg/s
# udp rx:    113 MB/s    82914 calls/s
# udp tx:    113 MB/s     1925 calls/s   1925 msg/s
# udp rx:    126 MB/s    92465 calls/s
# udp tx:    127 MB/s     2158 calls/s   2158 msg/s
# udp gso zerocopy
# udp rx:    143 MB/s   104334 calls/s
# udp tx:    143 MB/s     2442 calls/s   2442 msg/s
# udp rx:     74 MB/s    54309 calls/s
# udp tx:     75 MB/s     1286 calls/s   1286 msg/s
# udp rx:    216 MB/s   157745 calls/s
# udp gso timestamp
# udp rx:    176 MB/s   129029 calls/s
# udp tx:    179 MB/s     3052 calls/s   3052 msg/s
# udp rx:    232 MB/s   169882 calls/s
# udp tx:    232 MB/s     3938 calls/s   3938 msg/s
# udp rx:    133 MB/s    97549 calls/s
# udp tx:    133 MB/s     2263 calls/s   2263 msg/s
# udp gso zerocopy audit
# udp tx:     49 MB/s      835 calls/s    835 msg/s
# udp rx:     49 MB/s    35816 calls/s
# udp tx:     29 MB/s      499 calls/s    499 msg/s
# udp rx:     29 MB/s    21671 calls/s
# udp tx:     29 MB/s      497 calls/s    497 msg/s
# Summary over 3.001 seconds...
# sum udp tx:     36 MB/s       1831 calls (610/s)       1831 msgs (610/s)
# Zerocopy acks:                1831
# udp gso timestamp audit
# udp rx:    144 MB/s   105166 calls/s
# udp tx:    146 MB/s     2493 calls/s   2493 msg/s
# udp rx:    147 MB/s   107430 calls/s
# udp tx:    150 MB/s     2560 calls/s   2560 msg/s
# udp rx:    146 MB/s   106683 calls/s
# udp tx:    144 MB/s     2452 calls/s   2452 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    151 MB/s       7505 calls (2501/s)       7505 msgs (2501/s)
# Tx Timestamps:                7505 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    132 MB/s    96708 calls/s
# udp tx:    134 MB/s     2279 calls/s   2279 msg/s
# udp rx:    147 MB/s   107844 calls/s
# udp tx:    148 MB/s     2513 calls/s   2513 msg/s
# udp rx:    169 MB/s   123496 calls/s
# udp tx:    168 MB/s     2864 calls/s   2864 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    154 MB/s       7656 calls (2552/s)       7656 msgs (2552/s)
# Tx Timestamps:                7656 received                 0 errors
# Zerocopy acks:                7656
# udpgso_bench.sh: PASS=3D18 SKIP=3D0 FAIL=3D0
# udpgso_bench.sh: =1B[0;92mPASS=1B[0m
ok 18 selftests: net: udpgso_bench.sh
# selftests: net: fib_rule_tests.sh
#=20
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
#=20
#     TEST: rule4 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward =3D 1
# net.ipv4.conf.dummy0.rp_filter =3D 0
#=20
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
#=20
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward =3D 0
#=20
#     TEST: rule4 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule4 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule4 check: ipproto icmp                           [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
#=20
#     TEST: rule6 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
#=20
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
#=20
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
#=20
#     TEST: rule6 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule6 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
#=20
# Tests passed:  32
# Tests failed:   0
ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=3D27392 (1709 MB) txc=3D0 zc=3Dn
# rx=3D13696 (1709 MB)
# ipv4 tcp -z -t 1
# tx=3D23777 (1483 MB) txc=3D23777 zc=3Dn
# rx=3D11889 (1483 MB)
# ok
# ipv6 tcp -t 1
# tx=3D9799 (611 MB) txc=3D0 zc=3Dn
# rx=3D4901 (611 MB)
# ipv6 tcp -z -t 1
# tx=3D23757 (1482 MB) txc=3D23757 zc=3Dn
# rx=3D11879 (1482 MB)
# ok
# ipv4 udp -t 1
# tx=3D15153 (945 MB) txc=3D0 zc=3Dn
# rx=3D15153 (945 MB)
# ipv4 udp -z -t 1
# tx=3D22240 (1387 MB) txc=3D22240 zc=3Dn
# rx=3D22240 (1387 MB)
# ok
# ipv6 udp -t 1
# tx=3D12730 (794 MB) txc=3D0 zc=3Dn
# rx=3D12730 (794 MB)
# ipv6 udp -z -t 1
# tx=3D21234 (1325 MB) txc=3D21234 zc=3Dn
# rx=3D21212 (1323 MB)
# ok
# OK. All tests passed
ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# dgram bind
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# raw
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw bind
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw qdisc bypass
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw vlan
# tx: 146
# rx: 100
# OK
#=20
# raw vnet hdr
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off with bad offset (expected to fail)
# ./psock_snd: write: Invalid argument
# raw min size
# tx: 42
# rx: 0
# OK
#=20
# raw mtu size
# tx: 1514
# rx: 1472
# OK
#=20
# raw mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw vlan mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# dgram mtu size
# tx: 1500
# rx: 1472
# OK
#=20
# dgram mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw truncate hlen (expected to fail: does not arrive)
# tx: 14
# ./psock_snd: recv: Resource temporarily unavailable
# raw truncate hlen - 1 (expected to fail: EINVAL)
# ./psock_snd: write: Invalid argument
# raw gso min size
# tx: 1525
# rx: 1473
# OK
#=20
# raw gso min size - 1 (expected to fail)
# tx: 1524
# rx: 1472
# OK
#=20
not ok 21 selftests: net: psock_snd.sh # exit=3D1
# selftests: net: udpgro_bench.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 22 selftests: net: udpgro_bench.sh # exit=3D255
# selftests: net: udpgro.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 23 selftests: net: udpgro.sh # exit=3D255
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [ OK ]
# Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
# Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 24 selftests: net: test_vxlan_under_vrf.sh # exit=3D1
# selftests: net: reuseport_addr_any.sh
# UDP IPv4 ... pass
# UDP IPv6 ... pass
# UDP IPv4 mapped to IPv6 ... pass
# TCP IPv4 ... pass
# TCP IPv6 ... pass
# TCP IPv4 mapped to IPv6 ... pass
# DCCP not supported: skipping DCCP tests
# SUCCESS
ok 25 selftests: net: reuseport_addr_any.sh
# selftests: net: test_vxlan_fdb_changelink.sh
# expected two remotes after fdb append	[ OK ]
# expected two remotes after link set	[ OK ]
ok 26 selftests: net: test_vxlan_fdb_changelink.sh
# selftests: net: so_txtime.sh
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:772 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:388 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10191 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10167 expected:10000 (us)
# payload:b delay:20115 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:b delay:20264 expected:20000 (us)
# payload:a delay:20398 expected:20000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# send: pkt a at -1621101353626ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# send: pkt a at 0ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# payload:a delay:9812 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# payload:a delay:9812 expected:10000 (us)
# payload:b delay:19758 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock tai
# payload:b delay:9817 expected:10000 (us)
# payload:a delay:19762 expected:20000 (us)
# OK. All tests passed
ok 27 selftests: net: so_txtime.sh
# selftests: net: ipv6_flowlabel.sh
# TEST management
# [OK]   !(flowlabel_get(fd, 1, 255, 0))
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   !(flowlabel_get(fd, 0x1FFFFF, 255, 1))
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   flowlabel_get(fd, 1, 255, 0)
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   !(flowlabel_get(fd, 1, 255, 1 | 2))
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   flowlabel_get(fd, 2, 1, 1)
# [OK]   !(flowlabel_get(fd, 2, 255, 1))
# [OK]   !(flowlabel_get(fd, 2, 1, 1))
# [OK]   flowlabel_put(fd, 2)
# [OK]   flowlabel_get(fd, 3, 3, 1)
# [OK]   !(flowlabel_get(fd, 3, 255, 0))
# [OK]   !(flowlabel_get(fd, 3, 1, 0))
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   !(flowlabel_get(fd, 3, 3, 0))
# [OK]   flowlabel_get(fd, 4, 2, 1)
# [OK]   flowlabel_get(fd, 4, 2, 0)
# [OK]   !(flowlabel_get(fd, 4, 2, 0))
# TEST datapath
# send no label: recv no label (auto off)
# sent without label
# recv without label
# send label
# sent with label 1
# recv with label 1
# TEST datapath (with auto-flowlabels)
# send no label: recv auto flowlabel
# sent without label
# recv with label 746690
# send label
# sent with label 1
# recv with label 1
# OK. All tests passed
ok 28 selftests: net: ipv6_flowlabel.sh
# selftests: net: tcp_fastopen_backup_key.sh
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# all tests done
ok 29 selftests: net: tcp_fastopen_backup_key.sh
# selftests: net: fcnal-test.sh
#=20
# #########################################################################=
##
# IPv4 ping
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D0
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
#=20
# #################################################################
# With VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out, VRF bind - ns-B IP                                       =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, VRF bind - ns-B loopback IP                              =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - VRF IP                                                   =
     [ OK ]
# TEST: ping local, VRF bind - ns-A IP                                     =
     [ OK ]
# TEST: ping local, VRF bind - VRF IP                                      =
     [ OK ]
# TEST: ping local, VRF bind - loopback                                    =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - VRF IP                                   =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, vrf bind, blocked by rule - ns-B loopback IP             =
     [ OK ]
# TEST: ping out, device bind, blocked by rule - ns-B loopback IP          =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, vrf bind, unreachable route - ns-B loopback IP           =
     [ OK ]
# TEST: ping out, device bind, unreachable route - ns-B loopback IP        =
     [ OK ]
# TEST: ping in, unreachable route - ns-A loopback IP                      =
     [ OK ]
#=20
# #########################################################################=
##
# IPv4/TCP
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
#=20
# #################################################################
# tcp_l3mdev_accept disabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D0
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
# TEST: Global server, local connection - ns-A loopback IP                 =
     [ OK ]
# TEST: Global server, local connection - loopback                         =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A IP          =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A loopback IP =
     [ OK ]
# TEST: Device server, unbound client, local connection - loopback         =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A loopback IP  =
     [ OK ]
# TEST: Global server, device client, local connection - loopback          =
     [ OK ]
# TEST: Device server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: No server, device client, local conn - ns-A IP                     =
     [ OK ]
# TEST: MD5: Single address config                                         =
     [ OK ]
# TEST: MD5: Server no config, client uses password                        =
     [ OK ]
# TEST: MD5: Client uses wrong password                                    =
     [ OK ]
# TEST: MD5: Client address does not match address configured with password=
     [ OK ]
# TEST: MD5: Prefix config                                                 =
     [ OK ]
# TEST: MD5: Prefix config, client uses wrong password                     =
     [ OK ]
# TEST: MD5: Prefix config, client address not in configured prefix        =
     [ OK ]
#=20
# #################################################################
# tcp_l3mdev_accept enabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D1
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
#
not ok 30 selftests: net: fcnal-test.sh # TIMEOUT 300 seconds
# selftests: net: traceroute.sh
# SKIP: Could not run IPV6 test without traceroute6
# SKIP: Could not run IPV4 test without traceroute
#=20
# Tests passed:   0
# Tests failed:   0
ok 31 selftests: net: traceroute.sh
# selftests: net: fin_ack_lat.sh
# server port: 60305
# test done
ok 32 selftests: net: fin_ack_lat.sh
# selftests: net: fib_nexthop_multiprefix.sh
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
ok 33 selftests: net: fib_nexthop_multiprefix.sh
# selftests: net: fib_nexthops.sh
#=20
# Basic functional tests
# ----------------------
# TEST: List with nothing defined                                     [ OK ]
# TEST: Nexthop get on non-existent id                                [ OK ]
# TEST: Nexthop with no device or gateway                             [ OK ]
# TEST: Nexthop with down device                                      [ OK ]
# TEST: Nexthop with device that is linkdown                          [ OK ]
# TEST: Nexthop with device only                                      [ OK ]
# TEST: Nexthop with duplicate id                                     [ OK ]
# TEST: Blackhole nexthop                                             [ OK ]
# TEST: Blackhole nexthop with other attributes                       [ OK ]
# TEST: Blackhole nexthop with loopback device down                   [ OK ]
# TEST: Create group                                                  [ OK ]
# TEST: Create group with blackhole nexthop                           [ OK ]
# TEST: Create multipath group where 1 path is a blackhole            [ OK ]
# TEST: Multipath group can not have a member replaced by blackhole   [ OK ]
# TEST: Create group with non-existent nexthop                        [ OK ]
# TEST: Create group with same nexthop multiple times                 [ OK ]
# TEST: Replace nexthop with nexthop group                            [ OK ]
# TEST: Replace nexthop group with nexthop                            [ OK ]
# TEST: Nexthop group and device                                      [ OK ]
# TEST: Test proto flush                                              [ OK ]
# TEST: Nexthop group and blackhole                                   [ OK ]
# TEST: Large scale nexthop flushing                                  [ OK ]
#=20
# Basic resilient nexthop group functional tests
# ----------------------------------------------
# TEST: Add a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with non-default parameters               [ OK ]
# TEST: Add a nexthop group with 0 buckets                            [ OK ]
# TEST: Replace nexthop group parameters                              [ OK ]
# TEST: Get a nexthop group after replacing parameters                [ OK ]
# TEST: Replace idle timer                                            [ OK ]
# TEST: Get a nexthop group after replacing idle timer                [ OK ]
# TEST: Replace unbalanced timer                                      [ OK ]
# TEST: Get a nexthop group after replacing unbalanced timer          [ OK ]
# TEST: Replace with no parameters                                    [ OK ]
# TEST: Get a nexthop group after replacing no parameters             [ OK ]
# TEST: Replace nexthop group type - implicit                         [ OK ]
# TEST: Replace nexthop group type - explicit                         [ OK ]
# TEST: Replace number of nexthop buckets                             [ OK ]
# TEST: Get a nexthop group after replacing with invalid parameters   [ OK ]
# TEST: Dump all nexthop buckets                                      [ OK ]
# TEST: Dump all nexthop buckets in a group                           [ OK ]
# TEST: All nexthop buckets report a positive near-zero idle time     [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop device       [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop identifier   [ OK ]
# TEST: Dump all nexthop buckets in a non-existent group              [ OK ]
# TEST: Dump all nexthop buckets in a non-resilient group             [ OK ]
# TEST: Dump all nexthop buckets using a non-existent device          [ OK ]
# TEST: Dump all nexthop buckets with invalid 'groups' keyword        [ OK ]
# TEST: Dump all nexthop buckets with invalid 'fdb' keyword           [ OK ]
# TEST: Get a valid nexthop bucket                                    [ OK ]
# TEST: Get a nexthop bucket with valid group, but invalid index      [ OK ]
# TEST: Get a nexthop bucket from a non-resilient group               [ OK ]
# TEST: Get a nexthop bucket from a non-existent group                [ OK ]
# TEST: Initial bucket allocation                                     [ OK ]
# TEST: Bucket allocation after replace                               [ OK ]
# TEST: Buckets migrated after idle timer change                      [ OK ]
#=20
# IPv4 functional
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
# IPv4 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
#=20
# IPv4 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 route with invalid IPv6 gateway                          [ OK ]
#=20
# IPv4 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Route add - scope conflict with nexthop                       [ OK ]
# TEST: Nexthop replace with invalid scope for existing route         [ OK ]
# TEST: Basic ping                                                    [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - multiple default routes, nh first                      [ OK ]
# TEST: Ping - multiple default routes, nh second                     [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv4 route with device only nexthop                           [ OK ]
# TEST: IPv4 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with mixed v4-v6 multipath route                   [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 default route with IPv6 gateway                          [ OK ]
# TEST: IPv4 route with MPLS encap                                    [ OK ]
# TEST: IPv4 route with MPLS encap - check                            [ OK ]
# TEST: IPv4 route with MPLS encap and v6 gateway                     [ OK ]
# TEST: IPv4 route with MPLS encap, v6 gw - check                     [ OK ]
#=20
# IPv4 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv4 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
# IPv4 nexthop api compat mode
# ----------------------------
# TEST: IPv4 default nexthop compat mode check                        [ OK ]
# TEST: IPv4 compat mode on - route add notification                  [ OK ]
# TEST: IPv4 compat mode on - route dump                              [ OK ]
# TEST: IPv4 compat mode on - nexthop change                          [ OK ]
# TEST: IPv4 set compat mode - 0                                      [ OK ]
# TEST: IPv4 compat mode off - route add notification                 [ OK ]
# TEST: IPv4 compat mode off - route dump                             [ OK ]
# TEST: IPv4 compat mode off - nexthop change                         [ OK ]
# TEST: IPv4 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv4 set compat mode - 1                                      [ OK ]
#=20
# IPv4 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
#=20
# IPv4 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv4 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
# IPv6 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
#=20
# IPv6 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
#=20
# IPv6 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Ping with nexthop                                             [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv6 route with device only nexthop                           [ OK ]
# TEST: IPv6 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 route can not have a v4 gateway                          [ OK ]
# TEST: Nexthop replace - v6 route, v4 nexthop                        [ OK ]
# TEST: Nexthop replace of group entry - v6 route, v4 nexthop         [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after removing v4 gateways           [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after replacing v4 gateways          [ OK ]
# TEST: Nexthop with default route and rpfilter                       [ OK ]
# TEST: Nexthop with multipath default route and rpfilter             [ OK ]
#=20
# IPv6 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv6 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
# IPv6 nexthop api compat mode test
# --------------------------------
# TEST: IPv6 default nexthop compat mode check                        [ OK ]
# TEST: IPv6 compat mode on - route add notification                  [ OK ]
# TEST: IPv6 compat mode on - route dump                              [ OK ]
# TEST: IPv6 compat mode on - nexthop change                          [ OK ]
# TEST: IPv6 set compat mode - 0                                      [ OK ]
# TEST: IPv6 compat mode off - route add notification                 [ OK ]
# TEST: IPv6 compat mode off - route dump                             [ OK ]
# TEST: IPv6 compat mode off - nexthop change                         [ OK ]
# TEST: IPv6 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv6 set compat mode - 1                                      [ OK ]
#=20
# IPv6 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
#=20
# IPv6 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# Tests passed: 215
# Tests failed:   0
ok 34 selftests: net: fib_nexthops.sh
# selftests: net: altnames.sh
# SKIP: mausezahn not installed
not ok 35 selftests: net: altnames.sh # exit=3D1
# selftests: net: icmp_redirect.sh
#=20
# #########################################################################=
##
# Legacy routing
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# #########################################################################=
##
# Legacy routing with VRF
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# #########################################################################=
##
# Routing with nexthop objects
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# #########################################################################=
##
# Routing with nexthop objects and VRF
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# Tests passed:  28
# Tests failed:  12
not ok 36 selftests: net: icmp_redirect.sh # exit=3D1
# selftests: net: ip6_gre_headroom.sh
# TEST: ip6gretap headroom                                            [PASS]
# TEST: ip6erspan headroom                                            [PASS]
ok 37 selftests: net: ip6_gre_headroom.sh
# selftests: net: route_localnet.sh
# run arp_announce test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_announce =3D 2
# net.ipv4.conf.veth1.arp_announce =3D 2
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.156 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.045 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.051 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.064 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.063 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 101ms
# rtt min/avg/max/mdev =3D 0.045/0.075/0.156/0.042 ms
# ok
# run arp_ignore test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_ignore =3D 3
# net.ipv4.conf.veth1.arp_ignore =3D 3
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.198 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.043 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.059 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.094 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.050 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 108ms
# rtt min/avg/max/mdev =3D 0.043/0.088/0.198/0.058 ms
# ok
ok 38 selftests: net: route_localnet.sh
# selftests: net: reuseaddr_ports_exhausted.sh
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.reuseaddr_ports_exhausted_unreusable ...
# #            OK  global.reuseaddr_ports_exhausted_unreusable
# ok 1 global.reuseaddr_ports_exhausted_unreusable
# #  RUN           global.reuseaddr_ports_exhausted_reusable_same_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_same_euid
# ok 2 global.reuseaddr_ports_exhausted_reusable_same_euid
# #  RUN           global.reuseaddr_ports_exhausted_reusable_different_euid=
 ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_different_euid
# ok 3 global.reuseaddr_ports_exhausted_reusable_different_euid
# # PASSED: 3 / 3 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# tests done
ok 39 selftests: net: reuseaddr_ports_exhausted.sh
# selftests: net: txtimestamp.sh
# protocol:     TCP
# payload:      10
# server port:  9000
#=20
# family:       INET=20
# test SND
#     USR: 1621101932 s 433081 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 434512 us (seq=3D9, len=3D10)  (USR +1431 us)
#     USR: 1621101932 s 483353 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 484395 us (seq=3D19, len=3D10)  (USR +1041 us)
#     USR: 1621101932 s 533531 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 534579 us (seq=3D29, len=3D10)  (USR +1048 us)
#     USR: 1621101932 s 583766 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 584841 us (seq=3D39, len=3D10)  (USR +1074 us)
#     USR-SND: count=3D4, avg=3D1148 us, min=3D1041 us, max=3D1431 us
# test ENQ
#     USR: 1621101932 s 741175 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 741294 us (seq=3D9, len=3D10)  (USR +119 us)
#     USR: 1621101932 s 791547 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 791585 us (seq=3D19, len=3D10)  (USR +37 us)
#     USR: 1621101932 s 841819 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 841850 us (seq=3D29, len=3D10)  (USR +31 us)
#     USR: 1621101932 s 892034 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 892058 us (seq=3D39, len=3D10)  (USR +24 us)
#     USR-ENQ: count=3D4, avg=3D53 us, min=3D24 us, max=3D119 us
# test ENQ + SND
#     USR: 1621101933 s 48992 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 49044 us (seq=3D9, len=3D10)  (USR +51 us)
#     SND: 1621101933 s 50060 us (seq=3D9, len=3D10)  (USR +1068 us)
#     USR: 1621101933 s 99397 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 99444 us (seq=3D19, len=3D10)  (USR +47 us)
#     SND: 1621101933 s 100491 us (seq=3D19, len=3D10)  (USR +1093 us)
#     USR: 1621101933 s 149760 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 149819 us (seq=3D29, len=3D10)  (USR +59 us)
#     SND: 1621101933 s 150857 us (seq=3D29, len=3D10)  (USR +1097 us)
#     USR: 1621101933 s 200029 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 200062 us (seq=3D39, len=3D10)  (USR +32 us)
#     SND: 1621101933 s 201080 us (seq=3D39, len=3D10)  (USR +1050 us)
#     USR-ENQ: count=3D4, avg=3D47 us, min=3D32 us, max=3D59 us
#     USR-SND: count=3D4, avg=3D1077 us, min=3D1050 us, max=3D1097 us
#=20
# test ACK
#     USR: 1621101933 s 356846 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 363001 us (seq=3D9, len=3D10)  (USR +6155 us)
#     USR: 1621101933 s 407095 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 413288 us (seq=3D19, len=3D10)  (USR +6193 us)
#     USR: 1621101933 s 457340 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 463471 us (seq=3D29, len=3D10)  (USR +6130 us)
#     USR: 1621101933 s 507618 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 513754 us (seq=3D39, len=3D10)  (USR +6136 us)
#     USR-ACK: count=3D4, avg=3D6153 us, min=3D6130 us, max=3D6193 us
#=20
# test SND + ACK
#     USR: 1621101933 s 664361 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 665399 us (seq=3D9, len=3D10)  (USR +1037 us)
#     ACK: 1621101933 s 670467 us (seq=3D9, len=3D10)  (USR +6105 us)
#     USR: 1621101933 s 714628 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 715670 us (seq=3D19, len=3D10)  (USR +1041 us)
#     ACK: 1621101933 s 720738 us (seq=3D19, len=3D10)  (USR +6110 us)
#     USR: 1621101933 s 764868 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 765906 us (seq=3D29, len=3D10)  (USR +1038 us)
#     ACK: 1621101933 s 770987 us (seq=3D29, len=3D10)  (USR +6119 us)
#     USR: 1621101933 s 815115 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 816160 us (seq=3D39, len=3D10)  (USR +1045 us)
#     ACK: 1621101933 s 821271 us (seq=3D39, len=3D10)  (USR +6155 us)
#     USR-SND: count=3D4, avg=3D1040 us, min=3D1037 us, max=3D1045 us
#     USR-ACK: count=3D4, avg=3D6122 us, min=3D6105 us, max=3D6155 us
#=20
# test ENQ + SND + ACK
#     USR: 1621101933 s 971922 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 971969 us (seq=3D9, len=3D10)  (USR +47 us)
#     SND: 1621101933 s 972983 us (seq=3D9, len=3D10)  (USR +1060 us)
# ERROR: 21025 us expected between 6000 and 6500
#     ACK: 1621101933 s 992947 us (seq=3D9, len=3D10)  (USR +21025 us)
#     USR: 1621101934 s 22250 us (seq=3D0, len=3D0)
#     ENQ: 1621101934 s 22279 us (seq=3D19, len=3D10)  (USR +29 us)
#     SND: 1621101934 s 23299 us (seq=3D19, len=3D10)  (USR +1049 us)
# ERROR: 27957 us expected between 6000 and 6500
#     ACK: 1621101934 s 50207 us (seq=3D19, len=3D10)  (USR +27957 us)
#     USR: 1621101934 s 74111 us (seq=3D0, len=3D0)
#     ENQ: 1621101934 s 74142 us (seq=3D29, len=3D10)  (USR +30 us)
#     SND: 1621101934 s 75160 us (seq=3D29, len=3D10)  (USR +1049 us)
# ERROR: 15755 us expected between 6000 and 6500
#     ACK: 1621101934 s 89866 us (seq=3D29, len=3D10)  (USR +15755 us)
#     USR: 1621101934 s 130859 us (seq=3D0, len=3D0)
#     ENQ: 1621101934 s 130892 us (seq=3D39, len=3D10)  (USR +33 us)
#     SND: 1621101934 s 131913 us (seq=3D39, len=3D10)  (USR +1053 us)
#     ACK: 1621101934 s 137042 us (seq=3D39, len=3D10)  (USR +6183 us)
#     USR-ENQ: count=3D4, avg=3D35 us, min=3D29 us, max=3D47 us
#     USR-SND: count=3D4, avg=3D1053 us, min=3D1049 us, max=3D1060 us
#     USR-ACK: count=3D4, avg=3D17730 us, min=3D6183 us, max=3D27957 us
not ok 40 selftests: net: txtimestamp.sh # exit=3D1
# selftests: net: vrf-xfrm-tests.sh
#=20
# No qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
#=20
# netem qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
#=20
# Tests passed:  10
# Tests failed:   4
not ok 41 selftests: net: vrf-xfrm-tests.sh # exit=3D1
# selftests: net: rxtimestamp.sh
# Testing ip...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv4 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 1 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv6 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 2 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv4 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 2 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv6 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Starting testcase 9 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Testing udp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv4 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 1 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv6 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 2 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv4 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 2 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv6 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Starting testcase 9 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Testing tcp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv4 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 1 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv6 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 2 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv4 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 2 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv6 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Starting testcase 9 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
not ok 42 selftests: net: rxtimestamp.sh # exit=3D24
# selftests: net: devlink_port_split.py
# Traceback (most recent call last):
#   File "./devlink_port_split.py", line 277, in <module>
#     main()
#   File "./devlink_port_split.py", line 242, in main
#     dev =3D list(devs.keys())[0]
# IndexError: list index out of range
not ok 43 selftests: net: devlink_port_split.py # exit=3D1
# selftests: net: drop_monitor_tests.sh
# SKIP: Could not run test without tshark tool
ok 44 selftests: net: drop_monitor_tests.sh # SKIP
# selftests: net: vrf_route_leaking.sh
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP Frag needed                                [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Packet too big                             [FAIL]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# Tests passed:  11
# Tests failed:   1
not ok 45 selftests: net: vrf_route_leaking.sh # exit=3D1
# selftests: net: bareudp.sh
# TEST: IPv4 packets over UDPv4                                       [ OK ]
# TEST: IPv4 packets over UDPv6                                       [ OK ]
# TEST: IPv6 packets over UDPv4                                       [ OK ]
# TEST: IPv6 packets over UDPv6                                       [ OK ]
# TEST: IPv4 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv4 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: Unicast MPLS packets over UDPv4                               [ OK ]
# TEST: Unicast MPLS packets over UDPv6                               [ OK ]
ok 46 selftests: net: bareudp.sh
# selftests: net: unicast_extensions.sh
# #########################################################################=
##
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# #########################################################################=
##
# TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [ OK ]
# TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [ OK ]
# TEST: assign and ping inside 255.255/16 (is allowed)                [ OK ]
# TEST: assign and ping inside 255.255.255/24 (is allowed)            [ OK ]
# TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [ OK ]
# TEST: route between 0.200/16 and 245.99/16 (is allowed)             [ OK ]
# TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
# TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
# TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
# TEST: assign and ping lowest address (is forbidden)                 [ OK ]
# TEST: routing using lowest address (is forbidden)                   [ OK ]
# TEST: assign and ping class D address (is forbidden)                [ OK ]
# TEST: routing using class D (is forbidden)                          [ OK ]
# TEST: routing using 127/8 (is forbidden)                            [ OK ]
ok 47 selftests: net: unicast_extensions.sh
# selftests: net: udpgro_fwd.sh
# IPv4
# ./udpgro_fwd.sh: 90: local: -r: bad variable name
# ./udpgro_fwd.sh: 22: local: -r: bad variable name
not ok 48 selftests: net: udpgro_fwd.sh # exit=3D2
# selftests: net: veth.sh
# Missing xdp_dummy helper. Build bpf selftest first
# ./veth.sh: 111: exit: Illegal number: -1
# ./veth.sh: 21: local: -r: bad variable name
not ok 49 selftests: net: veth.sh # exit=3D2



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file f=
or lkp run
        bin/lkp run                    generated-yaml-file



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Cent=
er
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporati=
on

Thanks,
Oliver Sang


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.12.0-15073-gd1023bc19bee"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.12.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_IO_MAPPING=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
# CONFIG_WWAN is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_ALTERA_CORE is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export job_origin='kernel-selftests-bm.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-nuc2'
	export tbox_group='lkp-skl-nuc2'
	export submit_id='609ff6f8a723baf0fc2d8417'
	export job_file='/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d1023bc19bee0379b804309f9be5dd9f91dfba00-20210516-61692-6aphlg-1.yaml'
	export id='b4821565b2b2773efe70c5b62f89cb567c70cb51'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=8
	export memory='32G'
	export nr_sdd_partitions=1
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part2'
	export brand='Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz'
	export commit='d1023bc19bee0379b804309f9be5dd9f91dfba00'
	export netconsole_port=6675
	export ucode='0xe2'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kselftests=true
	export need_kconfig='CONFIG_USER_NS=y
CONFIG_BPF_SYSCALL=y
CONFIG_TEST_BPF=m
CONFIG_NUMA=y ~ ">= v5.6-rc1"
CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
CONFIG_IPV6=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_VETH=y
CONFIG_NET_IPVTI=m
CONFIG_IPV6_VTI=m
CONFIG_DUMMY=y
CONFIG_BRIDGE=y
CONFIG_VLAN_8021Q=y
CONFIG_IFB=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP_NF_NAT=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
CONFIG_NET_SCH_NETEM=y
CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
CONFIG_KALLSYMS=y
CONFIG_BAREUDP=m ~ ">= v5.7-rc1"
CONFIG_MPLS_ROUTING=m ~ ">= v4.1-rc1"
CONFIG_MPLS_IPTUNNEL=m ~ ">= v4.3-rc1"
CONFIG_NET_SCH_INGRESS=y ~ ">= v4.19-rc1"
CONFIG_NET_CLS_FLOWER=m ~ ">= v4.2-rc1"
CONFIG_NET_ACT_TUNNEL_KEY=m ~ ">= v4.9-rc1"
CONFIG_NET_ACT_MIRRED=m ~ ">= v5.11-rc1"'
	export enqueue_time='2021-05-16 00:29:44 +0800'
	export _id='609ff6f8a723baf0fc2d8417'
	export _rt='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='72da41c58a616f9d0aa4b177d35f2a5ca7e2c67d'
	export base_commit='6efb943b8616ec53a5e444193dccf1af9ad627b5'
	export branch='linux-review/Florian-Westphal/add-cmsg-support-to-receive-path/20210511-213838'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/3'
	export scheduler_version='/lkp/lkp/.src-20210513-171754'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d1023bc19bee0379b804309f9be5dd9f91dfba00-20210516-61692-6aphlg-1.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=linux-review/Florian-Westphal/add-cmsg-support-to-receive-path/20210511-213838
commit=d1023bc19bee0379b804309f9be5dd9f91dfba00
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/vmlinuz-5.12.0-15073-gd1023bc19bee
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/linux-selftests.cgz'
	export kselftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/kselftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-0d95472a-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0-rc1-01476-g72da41c58a61'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/vmlinuz-5.12.0-15073-gd1023bc19bee'
	export dequeue_time='2021-05-16 01:38:26 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d1023bc19bee0379b804309f9be5dd9f91dfba00-20210516-61692-6aphlg-1.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='net' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='net' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--tvOENZuN7d6HfOWU
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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

--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
=2E3-kselftests-d1023bc19bee0379b804309f9be5dd9f91dfba00
2021-05-15 17:43:02 mount --bind /lib/modules/5.12.0-15073-gd1023bc19bee/ke=
rnel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d1023bc19bee037=
9b804309f9be5dd9f91dfba00/lib
2021-05-15 17:43:02 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2021-05-15 17:43:02 sed -i s/default_timeout=3D45/default_timeout=3D300/ /k=
selftests/kselftest/runner.sh
source /lkp/lkp/src/lib/tests/kernel-selftests-ext.sh
LKP SKIP net.l2tp.sh
LKP SKIP net.tls
2021-05-15 17:43:05 /kselftests/run_kselftest.sh -c net
TAP version 13
1..49
# selftests: net: reuseport_bpf
# ---- IPv4 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 UDP w/ mapped IPv4 ----
# Testing EBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 20...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 10: 10
# Socket 11: 11
# Socket 12: 12
# Socket 13: 13
# Socket 14: 14
# Socket 15: 15
# Socket 16: 16
# Socket 17: 17
# Socket 18: 18
# Socket 19: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 10: 30
# Socket 11: 31
# Socket 12: 32
# Socket 13: 33
# Socket 14: 34
# Socket 15: 35
# Socket 16: 36
# Socket 17: 37
# Socket 18: 38
# Socket 19: 39
# Reprograming, testing mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Socket 0: 20
# Socket 1: 21
# Socket 2: 22
# Socket 3: 23
# Socket 4: 24
# Socket 5: 25
# Socket 6: 26
# Socket 7: 27
# Socket 8: 28
# Socket 9: 29
# Socket 0: 30
# Socket 1: 31
# Socket 2: 32
# Socket 3: 33
# Socket 4: 34
# Socket 5: 35
# Socket 6: 36
# Socket 7: 37
# Socket 8: 38
# Socket 9: 39
# ---- IPv4 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing too many filters...
# Testing filters on non-SO_REUSEPORT socket...
# ---- IPv6 TCP w/ mapped IPv4 ----
# Testing EBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing CBPF mod 10...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 5: 5
# Socket 6: 6
# Socket 7: 7
# Socket 8: 8
# Socket 9: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 5: 15
# Socket 6: 16
# Socket 7: 17
# Socket 8: 18
# Socket 9: 19
# Reprograming, testing mod 5...
# Socket 0: 0
# Socket 1: 1
# Socket 2: 2
# Socket 3: 3
# Socket 4: 4
# Socket 0: 5
# Socket 1: 6
# Socket 2: 7
# Socket 3: 8
# Socket 4: 9
# Socket 0: 10
# Socket 1: 11
# Socket 2: 12
# Socket 3: 13
# Socket 4: 14
# Socket 0: 15
# Socket 1: 16
# Socket 2: 17
# Socket 3: 18
# Socket 4: 19
# Testing filter add without bind...
# SUCCESS
ok 1 selftests: net: reuseport_bpf
# selftests: net: reuseport_bpf_cpu
# ---- IPv4 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 UDP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv4 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# ---- IPv6 TCP ----
# send cpu 0, receive socket 0
# send cpu 1, receive socket 1
# send cpu 2, receive socket 2
# send cpu 3, receive socket 3
# send cpu 4, receive socket 4
# send cpu 5, receive socket 5
# send cpu 6, receive socket 6
# send cpu 7, receive socket 7
# send cpu 7, receive socket 7
# send cpu 6, receive socket 6
# send cpu 5, receive socket 5
# send cpu 4, receive socket 4
# send cpu 3, receive socket 3
# send cpu 2, receive socket 2
# send cpu 1, receive socket 1
# send cpu 0, receive socket 0
# send cpu 0, receive socket 0
# send cpu 2, receive socket 2
# send cpu 4, receive socket 4
# send cpu 6, receive socket 6
# send cpu 1, receive socket 1
# send cpu 3, receive socket 3
# send cpu 5, receive socket 5
# send cpu 7, receive socket 7
# SUCCESS
ok 2 selftests: net: reuseport_bpf_cpu
# selftests: net: reuseport_bpf_numa
# ---- IPv4 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 UDP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv4 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# ---- IPv6 TCP ----
# send node 0, receive socket 0
# send node 0, receive socket 0
# SUCCESS
ok 3 selftests: net: reuseport_bpf_numa
# selftests: net: reuseport_dualstack
# ---- UDP IPv4 created before IPv6 ----
# ---- UDP IPv6 created before IPv4 ----
# ---- UDP IPv4 created before IPv6 (large) ----
# ---- UDP IPv6 created before IPv4 (large) ----
# ---- TCP IPv4 created before IPv6 ----
# ---- TCP IPv6 created before IPv4 ----
# SUCCESS
ok 4 selftests: net: reuseport_dualstack
# selftests: net: reuseaddr_conflict
# Opening 127.0.0.1:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening in6addr_any:9999
# Opening INADDR_ANY:9999
# bind: Address already in use
# Opening INADDR_ANY:9999 after closing ipv6 socket
# bind: Address already in use
# Successok 5 selftests: net: reuseaddr_conflict
# selftests: net: run_netsocktests
# --------------------
# running socket test
# --------------------
# [PASS]
ok 6 selftests: net: run_netsocktests
# selftests: net: run_afpackettests
# --------------------
# running psock_fanout test
# --------------------
# test: control single socket
# test: control multiple sockets
# test: control multiple sockets, max_num_members
# test: unique ids
#=20
# test: datapath 0x0 ports 8000,8002
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D15,5
# warning: incorrect queue lengths
# info: count=3D0,20, expect=3D20,5
# warning: incorrect queue lengths
# info: trying alternate ports (20)
#=20
# test: datapath 0x0 ports 8000,8003
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D15,5
# warning: incorrect queue lengths
# info: count=3D0,20, expect=3D20,5
# warning: incorrect queue lengths
# info: trying alternate ports (19)
#=20
# test: datapath 0x0 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D5,20, expect=3D20,5
#=20
# test: datapath 0x1000 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D15,20, expect=3D20,15
#=20
# test: datapath 0x1 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D10,10, expect=3D10,10
# info: count=3D17,18, expect=3D18,17
#=20
# test: datapath 0x3 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D15,5, expect=3D15,5
# info: count=3D20,15, expect=3D20,15
#=20
# test: datapath 0x6 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x7 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D5,15, expect=3D15,5
# info: count=3D20,15, expect=3D15,20
#=20
# test: datapath 0x2 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,0, expect=3D20,0
# info: count=3D20,0, expect=3D20,0
#=20
# test: datapath 0x2 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D0,20, expect=3D0,20
# info: count=3D0,20, expect=3D0,20
#=20
# test: datapath 0x2000 ports 8000,8004
# info: count=3D0,0, expect=3D0,0
# info: count=3D20,20, expect=3D20,20
# info: count=3D20,20, expect=3D20,20
# OK. All tests passed
# [PASS]
# --------------------
# running psock_tpacket test
# --------------------
# test: TPACKET_V1 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V1 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200=
 bytes)
# test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200=
 bytes)
# OK. All tests passed
# [PASS]
# --------------------
# running txring_overwrite test
# --------------------
# read: a (0x61)
# read: b (0x62)
# [PASS]
ok 7 selftests: net: run_afpackettests
# selftests: net: test_bpf.sh
# test_bpf: ok
ok 8 selftests: net: test_bpf.sh
# selftests: net: netdevice.sh
# SKIP: eth0: interface already up
# PASS: eth0: ethtool list features
# PASS: eth0: ethtool dump
# PASS: eth0: ethtool stats
# SKIP: eth0: interface kept up
ok 9 selftests: net: netdevice.sh
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: promote_secondaries complete
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# PASS: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias ff6a2666-77ec-411f-829b-36b59897d7dd for test-dummy0
# PASS: vrf
# PASS: vxlan
# PASS: fou
# PASS: macsec
# PASS: ipsec
# PASS: ipsec_offload
# PASS: bridge fdb get
# PASS: neigh get
# Error: Unknown device type.
# Error: argument "test-bond0" is wrong: Device does not exist
#=20
# Error: argument "test-bond0" is wrong: Device does not exist
#=20
# Cannot find device "test-bond0"
# Cannot find device "test-bond0"
# FAIL: bridge_parent_id
not ok 10 selftests: net: rtnetlink.sh # exit=3D1
# selftests: net: xfrm_policy.sh
# PASS: policy before exception matches
# PASS: ping to .254 bypassed ipsec tunnel (exceptions)
# PASS: direct policy matches (exceptions)
# PASS: policy matches (exceptions)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies)
# PASS: direct policy matches (exceptions and block policies)
# PASS: policy matches (exceptions and block policies)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hresh changes)
# PASS: direct policy matches (exceptions and block policies after hresh ch=
anges)
# PASS: policy matches (exceptions and block policies after hresh changes)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter hthresh change in ns3)
# PASS: direct policy matches (exceptions and block policies after hthresh =
change in ns3)
# PASS: policy matches (exceptions and block policies after hthresh change =
in ns3)
# PASS: ping to .254 bypassed ipsec tunnel (exceptions and block policies a=
fter htresh change to normal)
# PASS: direct policy matches (exceptions and block policies after htresh c=
hange to normal)
# PASS: policy matches (exceptions and block policies after htresh change t=
o normal)
# PASS: policies with repeated htresh change
# PASS: policies inserted in random order
ok 11 selftests: net: xfrm_policy.sh
# selftests: net: test_blackhole_dev.sh
# test_blackhole_dev: ok
ok 12 selftests: net: test_blackhole_dev.sh
# selftests: net: fib_tests.sh
#=20
# Single path route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Nexthop device deleted
#     TEST: IPv4 fibmatch - no route                                      [=
 OK ]
#     TEST: IPv6 fibmatch - no route                                      [=
 OK ]
#=20
# Multipath route test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One nexthop device deleted
#     TEST: IPv4 - multipath route removed on delete                      [=
 OK ]
#     TEST: IPv6 - multipath down to single path                          [=
 OK ]
#     Second nexthop device deleted
#     TEST: IPv6 - no route                                               [=
 OK ]
#=20
# Single path, admin down
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     Route deleted on down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Admin down multipath
#     Verify start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     One device down, one up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Other device down and up
#     TEST: IPv4 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv6 fibmatch on down device                                  [=
 OK ]
#     TEST: IPv4 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv6 fibmatch on up device                                    [=
 OK ]
#     TEST: IPv4 flags on down device                                     [=
 OK ]
#     TEST: IPv6 flags on down device                                     [=
 OK ]
#     TEST: IPv4 flags on up device                                       [=
 OK ]
#     TEST: IPv6 flags on up device                                       [=
 OK ]
#     Both devices down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#=20
# Local carrier tests - single path
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - no linkdown flag                                       [=
 OK ]
#     TEST: IPv6 - no linkdown flag                                       [=
 OK ]
#     Carrier off on nexthop
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 - linkdown flag set                                      [=
 OK ]
#     TEST: IPv6 - linkdown flag set                                      [=
 OK ]
#     Route to local address with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# Single path route carrier test
#     Start point
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 no linkdown flag                                         [=
 OK ]
#     TEST: IPv6 no linkdown flag                                         [=
 OK ]
#     Carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#     Second address added with carrier down
#     TEST: IPv4 fibmatch                                                 [=
 OK ]
#     TEST: IPv6 fibmatch                                                 [=
 OK ]
#     TEST: IPv4 linkdown flag set                                        [=
 OK ]
#     TEST: IPv6 linkdown flag set                                        [=
 OK ]
#=20
# IPv4 nexthop tests
# <<< write me >>>
#=20
# IPv6 nexthop tests
#     TEST: Directly connected nexthop, unicast address                   [=
 OK ]
#     TEST: Directly connected nexthop, unicast address with device       [=
 OK ]
#     TEST: Gateway is linklocal address                                  [=
 OK ]
#     TEST: Gateway is linklocal address, no device                       [=
 OK ]
#     TEST: Gateway can not be local unicast address                      [=
 OK ]
#     TEST: Gateway can not be local unicast address, with device         [=
 OK ]
#     TEST: Gateway can not be a local linklocal address                  [=
 OK ]
#     TEST: Gateway can be local address in a VRF                         [=
 OK ]
#     TEST: Gateway can be local address in a VRF, with device            [=
 OK ]
#     TEST: Gateway can be local linklocal address in a VRF               [=
 OK ]
#     TEST: Redirect to VRF lookup                                        [=
 OK ]
#     TEST: VRF route, gateway can be local address in default VRF        [=
 OK ]
#     TEST: VRF route, gateway can not be a local address                 [=
 OK ]
#     TEST: VRF route, gateway can not be a local addr with device        [=
 OK ]
#=20
# FIB rule with suppress_prefixlength
#     TEST: FIB rule suppress test                                        [=
 OK ]
#=20
# IPv6 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv6 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with dev-only                                       [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Attempt to add duplicate route - gw                           [=
 OK ]
#     TEST: Attempt to add duplicate route - dev only                     [=
 OK ]
#     TEST: Attempt to add duplicate route - reject route                 [=
 OK ]
#     TEST: Add new nexthop for existing prefix                           [=
 OK ]
#     TEST: Append nexthop to existing route - gw                         [=
 OK ]
#     TEST: Append nexthop to existing route - dev only                   [=
 OK ]
#     TEST: Append nexthop to existing route - reject route               [=
 OK ]
#     TEST: Append nexthop to existing reject route - gw                  [=
 OK ]
#     TEST: Append nexthop to existing reject route - dev only            [=
 OK ]
#     TEST: add multipath route                                           [=
 OK ]
#     TEST: Attempt to add duplicate multipath route                      [=
 OK ]
#     TEST: Route add with different metrics                              [=
 OK ]
#     TEST: Route delete with metric                                      [=
 OK ]
#=20
# IPv4 route replace tests
#     TEST: Single path with single path                                  [=
 OK ]
#     TEST: Single path with multipath                                    [=
 OK ]
#     TEST: Single path with reject route                                 [=
 OK ]
#     TEST: Single path with single path via multipath attribute          [=
 OK ]
#     TEST: Invalid nexthop                                               [=
 OK ]
#     TEST: Single path - replace of non-existent route                   [=
 OK ]
#     TEST: Multipath with multipath                                      [=
 OK ]
#     TEST: Multipath with single path                                    [=
 OK ]
#     TEST: Multipath with single path via multipath attribute            [=
 OK ]
#     TEST: Multipath with reject route                                   [=
 OK ]
#     TEST: Multipath - invalid first nexthop                             [=
 OK ]
#     TEST: Multipath - invalid second nexthop                            [=
 OK ]
#     TEST: Multipath - replace of non-existent route                     [=
 OK ]
#=20
# IPv6 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Set metric with peer route on local side                      [=
 OK ]
#     TEST: Set metric with peer route on peer side                       [=
 OK ]
#     TEST: Modify metric and peer address on local side                  [=
 OK ]
#     TEST: Modify metric and peer address on peer side                   [=
 OK ]
#=20
# IPv4 prefix route tests
#     TEST: Default metric                                                [=
 OK ]
#     TEST: User specified metric on first device                         [=
 OK ]
#     TEST: User specified metric on second device                        [=
 OK ]
#     TEST: Delete of address on first device                             [=
 OK ]
#     TEST: Modify metric of address                                      [=
 OK ]
#     TEST: Prefix route removed on link down                             [=
 OK ]
#     TEST: Prefix route with metric on link up                           [=
 OK ]
#     TEST: Modify metric of .0/24 address                                [=
 OK ]
#     TEST: Set metric of address with peer route                         [=
 OK ]
#     TEST: Modify metric and peer address for peer route                 [=
 OK ]
#=20
# IPv6 routes with metrics
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on first  [=
 OK ]
#     TEST: Multipath route via 2 single routes with mtu metric on 2nd    [=
 OK ]
#     TEST:     MTU of second leg                                         [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route add / append tests
#     TEST: Single path route with mtu metric                             [=
 OK ]
#     TEST: Multipath route with mtu metric                               [=
 OK ]
#     TEST: Using route with mtu metric                                   [=
 OK ]
#     TEST: Invalid metric (fails metric_convert)                         [=
 OK ]
#=20
# IPv4 route with IPv6 gateway tests
#     TEST: Single path route with IPv6 gateway                           [=
 OK ]
#     TEST: Single path route with IPv6 gateway - ping                    [=
 OK ]
#     TEST: Single path route delete                                      [=
 OK ]
#     TEST: Multipath route add - v6 nexthop then v4                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#     TEST: Multipath route add - v4 nexthop then v6                      [=
 OK ]
#     TEST:     Multipath route delete - nexthops in wrong order          [=
 OK ]
#     TEST:     Multipath route delete exact match                        [=
 OK ]
#=20
# IPv4 rp_filter tests
#     TEST: rp_filter passes local packets                                [=
FAIL]
#     TEST: rp_filter passes loopback packets                             [=
FAIL]
#=20
# IPv4 delete address route tests
#     TEST: Route removed from VRF when source address deleted            [=
 OK ]
#     TEST: Route in default VRF not removed                              [=
 OK ]
#     TEST: Route removed in default VRF when source address deleted      [=
 OK ]
#     TEST: Route in VRF is not removed by address delete                 [=
 OK ]
#=20
# IPv4 mangling tests
# socat command not found. Skipping test
#=20
# IPv6 mangling tests
# socat command not found. Skipping test
#=20
# Tests passed: 163
# Tests failed:   2
not ok 13 selftests: net: fib_tests.sh # exit=3D1
# selftests: net: fib-onlink-tests.sh
# Error: ipv4: FIB table does not exist.
# Flush terminated
# Error: ipv6: FIB table does not exist.
# Flush terminated
#=20
# ########################################
# Configuring interfaces
#=20
# ######################################################################
# TEST SECTION: IPv4 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath                       [ OK ]
#     TEST: unicast recursive - multipath                       [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device            [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 onlink
# ######################################################################
#=20
# #########################################
# TEST SUBSECTION: Valid onlink commands
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF lisa
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: VRF device, PBR table
#     TEST: unicast connected                                   [ OK ]
#     TEST: unicast recursive                                   [ OK ]
#     TEST: v4-mapped                                           [ OK ]
#=20
# #########################################
# TEST SUBSECTION: default VRF - main table - multipath
#     TEST: unicast connected - multipath onlink                [ OK ]
#     TEST: unicast recursive - multipath onlink                [ OK ]
#     TEST: v4-mapped - multipath onlink                        [ OK ]
#     TEST: unicast connected - multipath onlink both nexthops  [ OK ]
#     TEST: unicast connected - multipath onlink first only     [ OK ]
#     TEST: unicast connected - multipath onlink second only    [ OK ]
#=20
# #########################################
# TEST SUBSECTION: Invalid onlink commands
#     TEST: Invalid gw - local unicast address                  [ OK ]
#     TEST: Invalid gw - local linklocal address                [ OK ]
#     TEST: Invalid gw - multicast address                      [ OK ]
#     TEST: Invalid gw - local unicast address, VRF             [ OK ]
#     TEST: Invalid gw - local linklocal address, VRF           [ OK ]
#     TEST: Invalid gw - multicast address, VRF                 [ OK ]
#     TEST: No nexthop device given                             [ OK ]
#     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]
#=20
# Tests passed:  38
# Tests failed:   0
ok 14 selftests: net: fib-onlink-tests.sh
# selftests: net: pmtu.sh
# TEST: ipv4: PMTU exceptions                                         [ OK ]
# TEST: ipv4: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: ipv6: PMTU exceptions                                         [ OK ]
# TEST: ipv6: PMTU exceptions - nexthop objects                       [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv4 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions                             [ OK ]
# TEST: IPv6 over vxlan6: PMTU exceptions - nexthop objects           [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve4: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv4 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions                            [ OK ]
# TEST: IPv6 over geneve6: PMTU exceptions - nexthop objects          [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv4, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions                         [ OK ]
# TEST: IPv6, bridged vxlan6: PMTU exceptions - nexthop objects       [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve4: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv4, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions                        [ OK ]
# TEST: IPv6, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan4: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS vxlan6: PMTU exceptions                             [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve4: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv4, OVS geneve6: PMTU exceptions                            [SKIP]
#   ovs_bridge not supported
# TEST: IPv6, OVS geneve6: PMTU exceptions                            [SKIP]
# TEST: IPv4 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over fou6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over gue6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv4: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv4 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions                               [ OK ]
# TEST: IPv6 over IPv6: PMTU exceptions - nexthop objects             [ OK ]
# TEST: vti6: PMTU exceptions                                         [ OK ]
# TEST: vti4: PMTU exceptions                                         [ OK ]
# TEST: vti4: default MTU assignment                                  [ OK ]
# TEST: vti6: default MTU assignment                                  [ OK ]
# TEST: vti4: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU setting on link creation                            [ OK ]
# TEST: vti6: MTU changes on link changes                             [ OK ]
# TEST: ipv4: cleanup of cached exceptions                            [ OK ]
# TEST: ipv4: cleanup of cached exceptions - nexthop objects          [ OK ]
# TEST: ipv6: cleanup of cached exceptions                            [ OK ]
# TEST: ipv6: cleanup of cached exceptions - nexthop objects          [ OK ]
# TEST: ipv4: list and flush cached exceptions                        [ OK ]
# TEST: ipv4: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv6: list and flush cached exceptions                        [ OK ]
# TEST: ipv6: list and flush cached exceptions - nexthop objects      [ OK ]
# TEST: ipv4: PMTU exception w/route replace                          [ OK ]
# TEST: ipv4: PMTU exception w/route replace - nexthop objects        [ OK ]
# TEST: ipv6: PMTU exception w/route replace                          [ OK ]
# TEST: ipv6: PMTU exception w/route replace - nexthop objects        [ OK ]
ok 15 selftests: net: pmtu.sh
# selftests: net: udpgso.sh
# ipv4 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 cmsg
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv6 setsockopt
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
# ipv4 connected
# device mtu (orig): 65536
# device mtu (test): 1600
# route mtu (test): 1500
# path mtu (read):  1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv4 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv4 tx:1 gso:0=20
# ipv4 tx:1472 gso:0=20
# ipv4 tx:1473 gso:0 (fail)
# ipv4 tx:1472 gso:1472=20
# ipv4 tx:1473 gso:1472=20
# ipv4 tx:2944 gso:1472=20
# ipv4 tx:2945 gso:1472=20
# ipv4 tx:64768 gso:1472=20
# ipv4 tx:65507 gso:1472=20
# ipv4 tx:65508 gso:1472 (fail)
# ipv4 tx:1 gso:1=20
# ipv4 tx:2 gso:1=20
# ipv4 tx:5 gso:2=20
# ipv4 tx:36 gso:1=20
# ipv4 tx:37 gso:1 (fail)
# OK
# ipv6 msg_more
# device mtu (orig): 65536
# device mtu (test): 1500
# ipv6 tx:1 gso:0=20
# ipv6 tx:1452 gso:0=20
# ipv6 tx:1453 gso:0 (fail)
# ipv6 tx:1452 gso:1452=20
# ipv6 tx:1453 gso:1452=20
# ipv6 tx:2904 gso:1452=20
# ipv6 tx:2905 gso:1452=20
# ipv6 tx:65340 gso:1452=20
# ipv6 tx:65527 gso:1452=20
# ipv6 tx:65528 gso:1452 (fail)
# ipv6 tx:1 gso:1=20
# ipv6 tx:2 gso:1=20
# ipv6 tx:5 gso:2=20
# ipv6 tx:16 gso:1=20
# ipv6 tx:17 gso:1 (fail)
# OK
ok 16 selftests: net: udpgso.sh
# selftests: net: ip_defrag.sh
# ipv4 defrag
# PASS
# seed =3D 1621101240
# ipv4 defrag with overlaps
# PASS
# seed =3D 1621101240
# ipv6 defrag
# PASS
# seed =3D 1621101245
# ipv6 defrag with overlaps
# PASS
# seed =3D 1621101245
# ipv6 nf_conntrack defrag
# PASS
# seed =3D 1621101251
# ipv6 nf_conntrack defrag with overlaps
# PASS
# seed =3D 1621101252
# all tests done
ok 17 selftests: net: ip_defrag.sh
# selftests: net: udpgso_bench.sh
# ipv4
# tcp
# tcp tx:    878 MB/s    14903 calls/s  14903 msg/s
# tcp rx:    879 MB/s    14821 calls/s
# tcp tx:   1133 MB/s    19219 calls/s  19219 msg/s
# tcp rx:   1134 MB/s    19193 calls/s
# tcp tx:   1016 MB/s    17240 calls/s  17240 msg/s
# tcp zerocopy
# tcp tx:    644 MB/s    10924 calls/s  10924 msg/s
# tcp rx:    644 MB/s    10910 calls/s
# tcp tx:   1217 MB/s    20653 calls/s  20653 msg/s
# tcp rx:   1218 MB/s    20604 calls/s
# tcp tx:    590 MB/s    10017 calls/s  10017 msg/s
# udp
# udp rx:     45 MB/s    32123 calls/s
# udp tx:     45 MB/s    32382 calls/s    771 msg/s
# udp rx:     71 MB/s    51194 calls/s
# udp tx:     72 MB/s    51324 calls/s   1222 msg/s
# udp rx:     43 MB/s    30752 calls/s
# udp tx:     42 MB/s    30534 calls/s    727 msg/s
# udp gso
# udp rx:    163 MB/s   116304 calls/s
# udp tx:    164 MB/s     2796 calls/s   2796 msg/s
# udp rx:    232 MB/s   165926 calls/s
# udp tx:    234 MB/s     3969 calls/s   3969 msg/s
# udp rx:    188 MB/s   134289 calls/s
# udp tx:    190 MB/s     3229 calls/s   3229 msg/s
# udp gso zerocopy
# udp rx:    142 MB/s   101550 calls/s
# udp tx:    145 MB/s     2461 calls/s   2461 msg/s
# udp rx:    168 MB/s   120130 calls/s
# udp tx:    168 MB/s     2852 calls/s   2852 msg/s
# udp rx:    161 MB/s   115129 calls/s
# udp tx:    161 MB/s     2740 calls/s   2740 msg/s
# udp gso timestamp
# udp rx:    158 MB/s   112812 calls/s
# udp tx:    159 MB/s     2707 calls/s   2707 msg/s
# udp rx:    144 MB/s   103202 calls/s
# udp tx:    144 MB/s     2451 calls/s   2451 msg/s
# udp rx:    205 MB/s   146278 calls/s
# udp tx:    205 MB/s     3478 calls/s   3478 msg/s
# udp gso zerocopy audit
# udp rx:    171 MB/s   122210 calls/s
# udp tx:    172 MB/s     2923 calls/s   2923 msg/s
# udp rx:    149 MB/s   106765 calls/s
# udp tx:    150 MB/s     2552 calls/s   2552 msg/s
# udp rx:    171 MB/s   122315 calls/s
# udp tx:    173 MB/s     2935 calls/s   2935 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    169 MB/s       8410 calls (2803/s)       8410 msgs (2803/s)
# Zerocopy acks:                8410
# udp gso timestamp audit
# udp rx:    143 MB/s   101891 calls/s
# udp tx:    145 MB/s     2471 calls/s   2471 msg/s
# udp rx:    171 MB/s   122366 calls/s
# udp tx:    171 MB/s     2914 calls/s   2914 msg/s
# udp rx:    199 MB/s   141924 calls/s
# udp tx:    198 MB/s     3375 calls/s   3375 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    176 MB/s       8760 calls (2920/s)       8760 msgs (2920/s)
# Tx Timestamps:                8760 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    150 MB/s   107342 calls/s
# udp tx:    153 MB/s     2603 calls/s   2603 msg/s
# udp rx:    146 MB/s   104202 calls/s
# udp tx:    146 MB/s     2478 calls/s   2478 msg/s
# udp rx:    126 MB/s    89838 calls/s
# udp tx:    125 MB/s     2134 calls/s   2134 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    145 MB/s       7215 calls (2405/s)       7215 msgs (2405/s)
# Tx Timestamps:                7215 received                 0 errors
# Zerocopy acks:                7215
# ipv6
# tcp
# tcp tx:    526 MB/s     8927 calls/s   8927 msg/s
# tcp rx:    526 MB/s     8873 calls/s
# tcp tx:   1311 MB/s    22240 calls/s  22240 msg/s
# tcp rx:   1312 MB/s    22174 calls/s
# tcp tx:   1005 MB/s    17051 calls/s  17051 msg/s
# tcp zerocopy
# tcp tx:    383 MB/s     6499 calls/s   6499 msg/s
# tcp rx:    383 MB/s     6213 calls/s
# tcp tx:    395 MB/s     6709 calls/s   6709 msg/s
# tcp rx:    395 MB/s     6365 calls/s
# tcp tx:    412 MB/s     6993 calls/s   6993 msg/s
# udp
# udp rx:     28 MB/s    20528 calls/s
# udp tx:     28 MB/s    20855 calls/s    485 msg/s
# udp rx:     24 MB/s    17684 calls/s
# udp tx:     24 MB/s    17544 calls/s    408 msg/s
# udp rx:     32 MB/s    23731 calls/s
# udp gso
# udp rx:    120 MB/s    87910 calls/s
# udp tx:    122 MB/s     2075 calls/s   2075 msg/s
# udp rx:    113 MB/s    82914 calls/s
# udp tx:    113 MB/s     1925 calls/s   1925 msg/s
# udp rx:    126 MB/s    92465 calls/s
# udp tx:    127 MB/s     2158 calls/s   2158 msg/s
# udp gso zerocopy
# udp rx:    143 MB/s   104334 calls/s
# udp tx:    143 MB/s     2442 calls/s   2442 msg/s
# udp rx:     74 MB/s    54309 calls/s
# udp tx:     75 MB/s     1286 calls/s   1286 msg/s
# udp rx:    216 MB/s   157745 calls/s
# udp gso timestamp
# udp rx:    176 MB/s   129029 calls/s
# udp tx:    179 MB/s     3052 calls/s   3052 msg/s
# udp rx:    232 MB/s   169882 calls/s
# udp tx:    232 MB/s     3938 calls/s   3938 msg/s
# udp rx:    133 MB/s    97549 calls/s
# udp tx:    133 MB/s     2263 calls/s   2263 msg/s
# udp gso zerocopy audit
# udp tx:     49 MB/s      835 calls/s    835 msg/s
# udp rx:     49 MB/s    35816 calls/s
# udp tx:     29 MB/s      499 calls/s    499 msg/s
# udp rx:     29 MB/s    21671 calls/s
# udp tx:     29 MB/s      497 calls/s    497 msg/s
# Summary over 3.001 seconds...
# sum udp tx:     36 MB/s       1831 calls (610/s)       1831 msgs (610/s)
# Zerocopy acks:                1831
# udp gso timestamp audit
# udp rx:    144 MB/s   105166 calls/s
# udp tx:    146 MB/s     2493 calls/s   2493 msg/s
# udp rx:    147 MB/s   107430 calls/s
# udp tx:    150 MB/s     2560 calls/s   2560 msg/s
# udp rx:    146 MB/s   106683 calls/s
# udp tx:    144 MB/s     2452 calls/s   2452 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    151 MB/s       7505 calls (2501/s)       7505 msgs (2501/s)
# Tx Timestamps:                7505 received                 0 errors
# udp gso zerocopy timestamp audit
# udp rx:    132 MB/s    96708 calls/s
# udp tx:    134 MB/s     2279 calls/s   2279 msg/s
# udp rx:    147 MB/s   107844 calls/s
# udp tx:    148 MB/s     2513 calls/s   2513 msg/s
# udp rx:    169 MB/s   123496 calls/s
# udp tx:    168 MB/s     2864 calls/s   2864 msg/s
# Summary over 3.000 seconds...
# sum udp tx:    154 MB/s       7656 calls (2552/s)       7656 msgs (2552/s)
# Tx Timestamps:                7656 received                 0 errors
# Zerocopy acks:                7656
# udpgso_bench.sh: PASS=3D18 SKIP=3D0 FAIL=3D0
# udpgso_bench.sh: =1B[0;92mPASS=1B[0m
ok 18 selftests: net: udpgso_bench.sh
# selftests: net: fib_rule_tests.sh
#=20
# ######################################################################
# TEST SECTION: IPv4 fib rule
# ######################################################################
#=20
#     TEST: rule4 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule4 del by pref: oif dummy0                       [ OK ]
# net.ipv4.ip_forward =3D 1
# net.ipv4.conf.dummy0.rp_filter =3D 0
#=20
#     TEST: rule4 check: from 192.51.100.3 iif dummy0           [ OK ]
#=20
#     TEST: rule4 del by pref: from 192.51.100.3 iif dummy0     [ OK ]
# net.ipv4.ip_forward =3D 0
#=20
#     TEST: rule4 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule4 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule4 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule4 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule4 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule4 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule4 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule4 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule4 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule4 check: ipproto icmp                           [ OK ]
#=20
#     TEST: rule4 del by pref: ipproto icmp                     [ OK ]
#=20
# ######################################################################
# TEST SECTION: IPv6 fib rule
# ######################################################################
#=20
#     TEST: rule6 check: oif dummy0                             [ OK ]
#=20
#     TEST: rule6 del by pref: oif dummy0                       [ OK ]
#=20
#     TEST: rule6 check: from 2001:db8:1::3 iif dummy0          [ OK ]
#=20
#     TEST: rule6 del by pref: from 2001:db8:1::3 iif dummy0    [ OK ]
#=20
#     TEST: rule6 check: tos 0x10                               [ OK ]
#=20
#     TEST: rule6 del by pref: tos 0x10                         [ OK ]
#=20
#     TEST: rule6 check: fwmark 0x64                            [ OK ]
#=20
#     TEST: rule6 del by pref: fwmark 0x64                      [ OK ]
#=20
#     TEST: rule6 check: uidrange 100-100                       [ OK ]
#=20
#     TEST: rule6 del by pref: uidrange 100-100                 [ OK ]
#=20
#     TEST: rule6 check: sport 666 dport 777                    [ OK ]
#=20
#     TEST: rule6 del by pref: sport 666 dport 777              [ OK ]
#=20
#     TEST: rule6 check: ipproto tcp                            [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto tcp                      [ OK ]
#=20
#     TEST: rule6 check: ipproto ipv6-icmp                      [ OK ]
#=20
#     TEST: rule6 del by pref: ipproto ipv6-icmp                [ OK ]
#=20
# Tests passed:  32
# Tests failed:   0
ok 19 selftests: net: fib_rule_tests.sh
# selftests: net: msg_zerocopy.sh
# ipv4 tcp -t 1
# tx=3D27392 (1709 MB) txc=3D0 zc=3Dn
# rx=3D13696 (1709 MB)
# ipv4 tcp -z -t 1
# tx=3D23777 (1483 MB) txc=3D23777 zc=3Dn
# rx=3D11889 (1483 MB)
# ok
# ipv6 tcp -t 1
# tx=3D9799 (611 MB) txc=3D0 zc=3Dn
# rx=3D4901 (611 MB)
# ipv6 tcp -z -t 1
# tx=3D23757 (1482 MB) txc=3D23757 zc=3Dn
# rx=3D11879 (1482 MB)
# ok
# ipv4 udp -t 1
# tx=3D15153 (945 MB) txc=3D0 zc=3Dn
# rx=3D15153 (945 MB)
# ipv4 udp -z -t 1
# tx=3D22240 (1387 MB) txc=3D22240 zc=3Dn
# rx=3D22240 (1387 MB)
# ok
# ipv6 udp -t 1
# tx=3D12730 (794 MB) txc=3D0 zc=3Dn
# rx=3D12730 (794 MB)
# ipv6 udp -z -t 1
# tx=3D21234 (1325 MB) txc=3D21234 zc=3Dn
# rx=3D21212 (1323 MB)
# ok
# OK. All tests passed
ok 20 selftests: net: msg_zerocopy.sh
# selftests: net: psock_snd.sh
# dgram
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# dgram bind
# tx: 128
# rx: 142
# rx: 100
# OK
#=20
# raw
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw bind
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw qdisc bypass
# tx: 142
# rx: 142
# rx: 100
# OK
#=20
# raw vlan
# tx: 146
# rx: 100
# OK
#=20
# raw vnet hdr
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off
# tx: 152
# rx: 142
# rx: 100
# OK
#=20
# raw csum_off with bad offset (expected to fail)
# ./psock_snd: write: Invalid argument
# raw min size
# tx: 42
# rx: 0
# OK
#=20
# raw mtu size
# tx: 1514
# rx: 1472
# OK
#=20
# raw mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw vlan mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# dgram mtu size
# tx: 1500
# rx: 1472
# OK
#=20
# dgram mtu size + 1 (expected to fail)
# ./psock_snd: write: Message too long
# raw truncate hlen (expected to fail: does not arrive)
# tx: 14
# ./psock_snd: recv: Resource temporarily unavailable
# raw truncate hlen - 1 (expected to fail: EINVAL)
# ./psock_snd: write: Invalid argument
# raw gso min size
# tx: 1525
# rx: 1473
# OK
#=20
# raw gso min size - 1 (expected to fail)
# tx: 1524
# rx: 1472
# OK
#=20
not ok 21 selftests: net: psock_snd.sh # exit=3D1
# selftests: net: udpgro_bench.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 22 selftests: net: udpgro_bench.sh # exit=3D255
# selftests: net: udpgro.sh
# Missing xdp_dummy helper. Build bpf selftest first
not ok 23 selftests: net: udpgro.sh # exit=3D255
# selftests: net: test_vxlan_under_vrf.sh
# Checking HV connectivity                                           [ OK ]
# Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
# Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]
not ok 24 selftests: net: test_vxlan_under_vrf.sh # exit=3D1
# selftests: net: reuseport_addr_any.sh
# UDP IPv4 ... pass
# UDP IPv6 ... pass
# UDP IPv4 mapped to IPv6 ... pass
# TCP IPv4 ... pass
# TCP IPv6 ... pass
# TCP IPv4 mapped to IPv6 ... pass
# DCCP not supported: skipping DCCP tests
# SUCCESS
ok 25 selftests: net: reuseport_addr_any.sh
# selftests: net: test_vxlan_fdb_changelink.sh
# expected two remotes after fdb append	[ OK ]
# expected two remotes after link set	[ OK ]
ok 26 selftests: net: test_vxlan_fdb_changelink.sh
# selftests: net: so_txtime.sh
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:772 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:388 expected:0 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:10191 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:10167 expected:10000 (us)
# payload:b delay:20115 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock monotonic
# payload:b delay:20264 expected:20000 (us)
# payload:a delay:20398 expected:20000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# send: pkt a at -1621101353626ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# send: pkt a at 0ms dropped: invalid txtime
# ./so_txtime: recv: timeout: Resource temporarily unavailable
#=20
# SO_TXTIME ipv6 clock tai
# payload:a delay:9812 expected:10000 (us)
#=20
# SO_TXTIME ipv4 clock tai
# payload:a delay:9812 expected:10000 (us)
# payload:b delay:19758 expected:20000 (us)
#=20
# SO_TXTIME ipv6 clock tai
# payload:b delay:9817 expected:10000 (us)
# payload:a delay:19762 expected:20000 (us)
# OK. All tests passed
ok 27 selftests: net: so_txtime.sh
# selftests: net: ipv6_flowlabel.sh
# TEST management
# [OK]   !(flowlabel_get(fd, 1, 255, 0))
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   !(flowlabel_get(fd, 0x1FFFFF, 255, 1))
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   flowlabel_get(fd, 1, 255, 0)
# [OK]   flowlabel_get(fd, 1, 255, 1)
# [OK]   !(flowlabel_get(fd, 1, 255, 1 | 2))
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   flowlabel_put(fd, 1)
# [OK]   !(flowlabel_put(fd, 1))
# [OK]   flowlabel_get(fd, 2, 1, 1)
# [OK]   !(flowlabel_get(fd, 2, 255, 1))
# [OK]   !(flowlabel_get(fd, 2, 1, 1))
# [OK]   flowlabel_put(fd, 2)
# [OK]   flowlabel_get(fd, 3, 3, 1)
# [OK]   !(flowlabel_get(fd, 3, 255, 0))
# [OK]   !(flowlabel_get(fd, 3, 1, 0))
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   flowlabel_get(fd, 3, 3, 0)
# [OK]   !(flowlabel_get(fd, 3, 3, 0))
# [OK]   flowlabel_get(fd, 4, 2, 1)
# [OK]   flowlabel_get(fd, 4, 2, 0)
# [OK]   !(flowlabel_get(fd, 4, 2, 0))
# TEST datapath
# send no label: recv no label (auto off)
# sent without label
# recv without label
# send label
# sent with label 1
# recv with label 1
# TEST datapath (with auto-flowlabels)
# send no label: recv auto flowlabel
# sent without label
# recv with label 746690
# send label
# sent with label 1
# recv with label 1
# OK. All tests passed
ok 28 selftests: net: ipv6_flowlabel.sh
# selftests: net: tcp_fastopen_backup_key.sh
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# PASS
# all tests done
ok 29 selftests: net: tcp_fastopen_backup_key.sh
# selftests: net: fcnal-test.sh
#=20
# #########################################################################=
##
# IPv4 ping
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D0
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out - ns-B IP                                                 =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, address bind - ns-B IP                                   =
     [ OK ]
# TEST: ping out - ns-B loopback IP                                        =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, address bind - ns-B loopback IP                          =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - ns-A loopback IP                                         =
     [ OK ]
# TEST: ping local - ns-A IP                                               =
     [ OK ]
# TEST: ping local - ns-A loopback IP                                      =
     [ OK ]
# TEST: ping local - loopback                                              =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - ns-A loopback IP                         =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, blocked by rule - ns-B loopback IP                       =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, blocked by route - ns-B loopback IP                      =
     [ OK ]
# TEST: ping in, blocked by route - ns-A loopback IP                       =
     [ OK ]
# TEST: ping out, unreachable default route - ns-B loopback IP             =
     [ OK ]
#=20
# #################################################################
# With VRF
#=20
# SYSCTL: net.ipv4.raw_l3mdev_accept=3D1
#=20
# TEST: ping out, VRF bind - ns-B IP                                       =
     [ OK ]
# TEST: ping out, device bind - ns-B IP                                    =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B IP                  =
     [ OK ]
# TEST: ping out, VRF bind - ns-B loopback IP                              =
     [ OK ]
# TEST: ping out, device bind - ns-B loopback IP                           =
     [ OK ]
# TEST: ping out, vrf device + dev address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping out, vrf device + vrf address bind - ns-B loopback IP         =
     [ OK ]
# TEST: ping in - ns-A IP                                                  =
     [ OK ]
# TEST: ping in - VRF IP                                                   =
     [ OK ]
# TEST: ping local, VRF bind - ns-A IP                                     =
     [ OK ]
# TEST: ping local, VRF bind - VRF IP                                      =
     [ OK ]
# TEST: ping local, VRF bind - loopback                                    =
     [ OK ]
# TEST: ping local, device bind - ns-A IP                                  =
     [ OK ]
# TEST: ping local, device bind - VRF IP                                   =
     [ OK ]
# TEST: ping local, device bind - loopback                                 =
     [ OK ]
# TEST: ping out, vrf bind, blocked by rule - ns-B loopback IP             =
     [ OK ]
# TEST: ping out, device bind, blocked by rule - ns-B loopback IP          =
     [ OK ]
# TEST: ping in, blocked by rule - ns-A loopback IP                        =
     [ OK ]
# TEST: ping out, vrf bind, unreachable route - ns-B loopback IP           =
     [ OK ]
# TEST: ping out, device bind, unreachable route - ns-B loopback IP        =
     [ OK ]
# TEST: ping in, unreachable route - ns-A loopback IP                      =
     [ OK ]
#=20
# #########################################################################=
##
# IPv4/TCP
# #########################################################################=
##
#=20
#=20
# #################################################################
# No VRF
#=20
#=20
# #################################################################
# tcp_l3mdev_accept disabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D0
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
# TEST: Global server, local connection - ns-A loopback IP                 =
     [ OK ]
# TEST: Global server, local connection - loopback                         =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A IP          =
     [ OK ]
# TEST: Device server, unbound client, local connection - ns-A loopback IP =
     [ OK ]
# TEST: Device server, unbound client, local connection - loopback         =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: Global server, device client, local connection - ns-A loopback IP  =
     [ OK ]
# TEST: Global server, device client, local connection - loopback          =
     [ OK ]
# TEST: Device server, device client, local connection - ns-A IP           =
     [ OK ]
# TEST: No server, device client, local conn - ns-A IP                     =
     [ OK ]
# TEST: MD5: Single address config                                         =
     [ OK ]
# TEST: MD5: Server no config, client uses password                        =
     [ OK ]
# TEST: MD5: Client uses wrong password                                    =
     [ OK ]
# TEST: MD5: Client address does not match address configured with password=
     [ OK ]
# TEST: MD5: Prefix config                                                 =
     [ OK ]
# TEST: MD5: Prefix config, client uses wrong password                     =
     [ OK ]
# TEST: MD5: Prefix config, client address not in configured prefix        =
     [ OK ]
#=20
# #################################################################
# tcp_l3mdev_accept enabled
#=20
# SYSCTL: net.ipv4.tcp_l3mdev_accept=3D1
#=20
# TEST: Global server - ns-A IP                                            =
     [ OK ]
# TEST: Global server - ns-A loopback IP                                   =
     [ OK ]
# TEST: Device server - ns-A IP                                            =
     [ OK ]
# TEST: No server - ns-A IP                                                =
     [ OK ]
# TEST: No server - ns-A loopback IP                                       =
     [ OK ]
# TEST: Client - ns-B IP                                                   =
     [ OK ]
# TEST: Client, device bind - ns-B IP                                      =
     [ OK ]
# TEST: No server, unbound client - ns-B IP                                =
     [ OK ]
# TEST: No server, device client - ns-B IP                                 =
     [ OK ]
# TEST: Client - ns-B loopback IP                                          =
     [ OK ]
# TEST: Client, device bind - ns-B loopback IP                             =
     [ OK ]
# TEST: No server, unbound client - ns-B loopback IP                       =
     [ OK ]
# TEST: No server, device client - ns-B loopback IP                        =
     [ OK ]
# TEST: Global server, local connection - ns-A IP                          =
     [ OK ]
#
not ok 30 selftests: net: fcnal-test.sh # TIMEOUT 300 seconds
# selftests: net: traceroute.sh
# SKIP: Could not run IPV6 test without traceroute6
# SKIP: Could not run IPV4 test without traceroute
#=20
# Tests passed:   0
# Tests failed:   0
ok 31 selftests: net: traceroute.sh
# selftests: net: fin_ack_lat.sh
# server port: 60305
# test done
ok 32 selftests: net: fin_ack_lat.sh
# selftests: net: fib_nexthop_multiprefix.sh
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
# TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 2, mtu 1350                              [ OK ]
# TEST: IPv6: host 0 to host 2, mtu 1350                              [FAIL]
#=20
# TEST: IPv4: host 0 to host 3, mtu 1400                              [ OK ]
# TEST: IPv6: host 0 to host 3, mtu 1400                              [FAIL]
ok 33 selftests: net: fib_nexthop_multiprefix.sh
# selftests: net: fib_nexthops.sh
#=20
# Basic functional tests
# ----------------------
# TEST: List with nothing defined                                     [ OK ]
# TEST: Nexthop get on non-existent id                                [ OK ]
# TEST: Nexthop with no device or gateway                             [ OK ]
# TEST: Nexthop with down device                                      [ OK ]
# TEST: Nexthop with device that is linkdown                          [ OK ]
# TEST: Nexthop with device only                                      [ OK ]
# TEST: Nexthop with duplicate id                                     [ OK ]
# TEST: Blackhole nexthop                                             [ OK ]
# TEST: Blackhole nexthop with other attributes                       [ OK ]
# TEST: Blackhole nexthop with loopback device down                   [ OK ]
# TEST: Create group                                                  [ OK ]
# TEST: Create group with blackhole nexthop                           [ OK ]
# TEST: Create multipath group where 1 path is a blackhole            [ OK ]
# TEST: Multipath group can not have a member replaced by blackhole   [ OK ]
# TEST: Create group with non-existent nexthop                        [ OK ]
# TEST: Create group with same nexthop multiple times                 [ OK ]
# TEST: Replace nexthop with nexthop group                            [ OK ]
# TEST: Replace nexthop group with nexthop                            [ OK ]
# TEST: Nexthop group and device                                      [ OK ]
# TEST: Test proto flush                                              [ OK ]
# TEST: Nexthop group and blackhole                                   [ OK ]
# TEST: Large scale nexthop flushing                                  [ OK ]
#=20
# Basic resilient nexthop group functional tests
# ----------------------------------------------
# TEST: Add a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with default parameters                   [ OK ]
# TEST: Get a nexthop group with non-default parameters               [ OK ]
# TEST: Add a nexthop group with 0 buckets                            [ OK ]
# TEST: Replace nexthop group parameters                              [ OK ]
# TEST: Get a nexthop group after replacing parameters                [ OK ]
# TEST: Replace idle timer                                            [ OK ]
# TEST: Get a nexthop group after replacing idle timer                [ OK ]
# TEST: Replace unbalanced timer                                      [ OK ]
# TEST: Get a nexthop group after replacing unbalanced timer          [ OK ]
# TEST: Replace with no parameters                                    [ OK ]
# TEST: Get a nexthop group after replacing no parameters             [ OK ]
# TEST: Replace nexthop group type - implicit                         [ OK ]
# TEST: Replace nexthop group type - explicit                         [ OK ]
# TEST: Replace number of nexthop buckets                             [ OK ]
# TEST: Get a nexthop group after replacing with invalid parameters   [ OK ]
# TEST: Dump all nexthop buckets                                      [ OK ]
# TEST: Dump all nexthop buckets in a group                           [ OK ]
# TEST: All nexthop buckets report a positive near-zero idle time     [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop device       [ OK ]
# TEST: Dump all nexthop buckets with a specific nexthop identifier   [ OK ]
# TEST: Dump all nexthop buckets in a non-existent group              [ OK ]
# TEST: Dump all nexthop buckets in a non-resilient group             [ OK ]
# TEST: Dump all nexthop buckets using a non-existent device          [ OK ]
# TEST: Dump all nexthop buckets with invalid 'groups' keyword        [ OK ]
# TEST: Dump all nexthop buckets with invalid 'fdb' keyword           [ OK ]
# TEST: Get a valid nexthop bucket                                    [ OK ]
# TEST: Get a nexthop bucket with valid group, but invalid index      [ OK ]
# TEST: Get a nexthop bucket from a non-resilient group               [ OK ]
# TEST: Get a nexthop bucket from a non-existent group                [ OK ]
# TEST: Initial bucket allocation                                     [ OK ]
# TEST: Bucket allocation after replace                               [ OK ]
# TEST: Buckets migrated after idle timer change                      [ OK ]
#=20
# IPv4 functional
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
# IPv4 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
#=20
# IPv4 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 route with invalid IPv6 gateway                          [ OK ]
#=20
# IPv4 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Route add - scope conflict with nexthop                       [ OK ]
# TEST: Nexthop replace with invalid scope for existing route         [ OK ]
# TEST: Basic ping                                                    [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - multiple default routes, nh first                      [ OK ]
# TEST: Ping - multiple default routes, nh second                     [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv4 route with device only nexthop                           [ OK ]
# TEST: IPv4 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with mixed v4-v6 multipath route                   [ OK ]
# TEST: IPv6 nexthop with IPv4 route                                  [ OK ]
# TEST: IPv4 route with IPv6 gateway                                  [ OK ]
# TEST: IPv4 default route with IPv6 gateway                          [ OK ]
# TEST: IPv4 route with MPLS encap                                    [ OK ]
# TEST: IPv4 route with MPLS encap - check                            [ OK ]
# TEST: IPv4 route with MPLS encap and v6 gateway                     [ OK ]
# TEST: IPv4 route with MPLS encap, v6 gw - check                     [ OK ]
#=20
# IPv4 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv4 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
# IPv4 nexthop api compat mode
# ----------------------------
# TEST: IPv4 default nexthop compat mode check                        [ OK ]
# TEST: IPv4 compat mode on - route add notification                  [ OK ]
# TEST: IPv4 compat mode on - route dump                              [ OK ]
# TEST: IPv4 compat mode on - nexthop change                          [ OK ]
# TEST: IPv4 set compat mode - 0                                      [ OK ]
# TEST: IPv4 compat mode off - route add notification                 [ OK ]
# TEST: IPv4 compat mode off - route dump                             [ OK ]
# TEST: IPv4 compat mode off - nexthop change                         [ OK ]
# TEST: IPv4 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv4 set compat mode - 1                                      [ OK ]
#=20
# IPv4 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
#=20
# IPv4 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv4 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6
# ----------------------
# TEST: Create nexthop with id, gw, dev                               [ OK ]
# TEST: Get nexthop by id                                             [ OK ]
# TEST: Delete nexthop by id                                          [ OK ]
# TEST: Create nexthop - gw only                                      [ OK ]
# TEST: Create nexthop - invalid gw+dev combination                   [ OK ]
# TEST: Create nexthop - gw+dev and onlink                            [ OK ]
# TEST: Nexthops removed on admin down                                [ OK ]
#=20
# IPv6 groups functional
# ----------------------
# TEST: Create nexthop group with single nexthop                      [ OK ]
# TEST: Get nexthop group by id                                       [ OK ]
# TEST: Delete nexthop group by id                                    [ OK ]
# TEST: Nexthop group with multiple nexthops                          [ OK ]
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop group with weighted nexthops                          [ OK ]
# TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
# TEST: Nexthops in groups removed on admin down                      [ OK ]
# TEST: Multiple groups with same nexthop                             [ OK ]
# TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
# TEST: Nexthop group can not have a group as an entry                [ OK ]
# TEST: Nexthop group with a blackhole entry                          [ OK ]
# TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
#=20
# IPv6 resilient groups functional
# --------------------------------
# TEST: Nexthop group updated when entry is deleted                   [ OK ]
# TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
# TEST: Nexthop group updated after replace                           [ OK ]
# TEST: Nexthop buckets updated after replace                         [ OK ]
# TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
# TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
# TEST: Nexthop group updated after replace - nECMP                   [ OK ]
# TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
#=20
# IPv6 functional runtime
# -----------------------
# TEST: Route add                                                     [ OK ]
# TEST: Route delete                                                  [ OK ]
# TEST: Ping with nexthop                                             [ OK ]
# TEST: Ping - multipath                                              [ OK ]
# TEST: Ping - blackhole                                              [ OK ]
# TEST: Ping - blackhole replaced with gateway                        [ OK ]
# TEST: Ping - gateway replaced by blackhole                          [ OK ]
# TEST: Ping - group with blackhole                                   [ OK ]
# TEST: Ping - group blackhole replaced with gateways                 [ OK ]
# TEST: IPv6 route with device only nexthop                           [ OK ]
# TEST: IPv6 multipath route with nexthop mix - dev only + gw         [ OK ]
# TEST: IPv6 route can not have a v4 gateway                          [ OK ]
# TEST: Nexthop replace - v6 route, v4 nexthop                        [ OK ]
# TEST: Nexthop replace of group entry - v6 route, v4 nexthop         [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after removing v4 gateways           [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route can not have a group with v4 and v6 gateways       [ OK ]
# TEST: IPv6 route using a group after replacing v4 gateways          [ OK ]
# TEST: Nexthop with default route and rpfilter                       [ OK ]
# TEST: Nexthop with multipath default route and rpfilter             [ OK ]
#=20
# IPv6 large groups (x32)
# ---------------------
# TEST: Dump large (x32) ecmp groups                                  [ OK ]
#=20
# IPv6 large resilient group (128k buckets)
# -----------------------------------------
# TEST: Dump large (x131072) nexthop buckets                          [ OK ]
#=20
# IPv6 nexthop api compat mode test
# --------------------------------
# TEST: IPv6 default nexthop compat mode check                        [ OK ]
# TEST: IPv6 compat mode on - route add notification                  [ OK ]
# TEST: IPv6 compat mode on - route dump                              [ OK ]
# TEST: IPv6 compat mode on - nexthop change                          [ OK ]
# TEST: IPv6 set compat mode - 0                                      [ OK ]
# TEST: IPv6 compat mode off - route add notification                 [ OK ]
# TEST: IPv6 compat mode off - route dump                             [ OK ]
# TEST: IPv6 compat mode off - nexthop change                         [ OK ]
# TEST: IPv6 compat mode off - nexthop delete                         [ OK ]
# TEST: IPv6 set compat mode - 1                                      [ OK ]
#=20
# IPv6 fdb groups functional
# --------------------------
# TEST: Fdb Nexthop group with multiple nexthops                      [ OK ]
# TEST: Get Fdb nexthop group by id                                   [ OK ]
# TEST: Fdb Nexthop group with non-fdb nexthops                       [ OK ]
# TEST: Non-Fdb Nexthop group with fdb nexthops                       [ OK ]
# TEST: Fdb Nexthop with blackhole                                    [ OK ]
# TEST: Fdb Nexthop with oif                                          [ OK ]
# TEST: Fdb Nexthop with onlink                                       [ OK ]
# TEST: Fdb Nexthop with encap                                        [ OK ]
# TEST: Fdb mac add with nexthop group                                [ OK ]
# TEST: Fdb mac add with nexthop                                      [ OK ]
# TEST: Route add with fdb nexthop                                    [ OK ]
# TEST: Route add with fdb nexthop group                              [ OK ]
# TEST: Fdb entry after deleting a single nexthop                     [ OK ]
# TEST: Fdb nexthop delete                                            [ OK ]
# TEST: Fdb entry after deleting a nexthop group                      [ OK ]
#=20
# IPv6 runtime torture
# --------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# IPv6 runtime resilient nexthop group torture
# --------------------------------------------
# SKIP: Could not run test; need mausezahn tool
#=20
# Tests passed: 215
# Tests failed:   0
ok 34 selftests: net: fib_nexthops.sh
# selftests: net: altnames.sh
# SKIP: mausezahn not installed
not ok 35 selftests: net: altnames.sh # exit=3D1
# selftests: net: icmp_redirect.sh
#=20
# #########################################################################=
##
# Legacy routing
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# #########################################################################=
##
# Legacy routing with VRF
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# #########################################################################=
##
# Routing with nexthop objects
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# #########################################################################=
##
# Routing with nexthop objects and VRF
# #########################################################################=
##
#=20
# TEST: IPv4: redirect exception                                      [ OK ]
# TEST: IPv6: redirect exception                                      [FAIL]
# TEST: IPv4: redirect exception plus mtu                             [ OK ]
# TEST: IPv6: redirect exception plus mtu                             [FAIL]
# TEST: IPv4: routing reset                                           [ OK ]
# TEST: IPv6: routing reset                                           [ OK ]
# TEST: IPv4: mtu exception                                           [ OK ]
# TEST: IPv6: mtu exception                                           [ OK ]
# TEST: IPv4: mtu exception plus redirect                             [ OK ]
# TEST: IPv6: mtu exception plus redirect                             [FAIL]
#=20
# Tests passed:  28
# Tests failed:  12
not ok 36 selftests: net: icmp_redirect.sh # exit=3D1
# selftests: net: ip6_gre_headroom.sh
# TEST: ip6gretap headroom                                            [PASS]
# TEST: ip6erspan headroom                                            [PASS]
ok 37 selftests: net: ip6_gre_headroom.sh
# selftests: net: route_localnet.sh
# run arp_announce test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_announce =3D 2
# net.ipv4.conf.veth1.arp_announce =3D 2
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.156 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.045 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.051 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.064 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.063 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 101ms
# rtt min/avg/max/mdev =3D 0.045/0.075/0.156/0.042 ms
# ok
# run arp_ignore test
# net.ipv4.conf.veth0.route_localnet =3D 1
# net.ipv4.conf.veth1.route_localnet =3D 1
# net.ipv4.conf.veth0.arp_ignore =3D 3
# net.ipv4.conf.veth1.arp_ignore =3D 3
# PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84) bytes of dat=
a.
# 64 bytes from 127.25.3.14: icmp_seq=3D1 ttl=3D64 time=3D0.198 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D2 ttl=3D64 time=3D0.043 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D3 ttl=3D64 time=3D0.059 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D4 ttl=3D64 time=3D0.094 ms
# 64 bytes from 127.25.3.14: icmp_seq=3D5 ttl=3D64 time=3D0.050 ms
#=20
# --- 127.25.3.14 ping statistics ---
# 5 packets transmitted, 5 received, 0% packet loss, time 108ms
# rtt min/avg/max/mdev =3D 0.043/0.088/0.198/0.058 ms
# ok
ok 38 selftests: net: route_localnet.sh
# selftests: net: reuseaddr_ports_exhausted.sh
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.reuseaddr_ports_exhausted_unreusable ...
# #            OK  global.reuseaddr_ports_exhausted_unreusable
# ok 1 global.reuseaddr_ports_exhausted_unreusable
# #  RUN           global.reuseaddr_ports_exhausted_reusable_same_euid ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_same_euid
# ok 2 global.reuseaddr_ports_exhausted_reusable_same_euid
# #  RUN           global.reuseaddr_ports_exhausted_reusable_different_euid=
 ...
# #            OK  global.reuseaddr_ports_exhausted_reusable_different_euid
# ok 3 global.reuseaddr_ports_exhausted_reusable_different_euid
# # PASSED: 3 / 3 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
# tests done
ok 39 selftests: net: reuseaddr_ports_exhausted.sh
# selftests: net: txtimestamp.sh
# protocol:     TCP
# payload:      10
# server port:  9000
#=20
# family:       INET=20
# test SND
#     USR: 1621101932 s 433081 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 434512 us (seq=3D9, len=3D10)  (USR +1431 us)
#     USR: 1621101932 s 483353 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 484395 us (seq=3D19, len=3D10)  (USR +1041 us)
#     USR: 1621101932 s 533531 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 534579 us (seq=3D29, len=3D10)  (USR +1048 us)
#     USR: 1621101932 s 583766 us (seq=3D0, len=3D0)
#     SND: 1621101932 s 584841 us (seq=3D39, len=3D10)  (USR +1074 us)
#     USR-SND: count=3D4, avg=3D1148 us, min=3D1041 us, max=3D1431 us
# test ENQ
#     USR: 1621101932 s 741175 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 741294 us (seq=3D9, len=3D10)  (USR +119 us)
#     USR: 1621101932 s 791547 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 791585 us (seq=3D19, len=3D10)  (USR +37 us)
#     USR: 1621101932 s 841819 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 841850 us (seq=3D29, len=3D10)  (USR +31 us)
#     USR: 1621101932 s 892034 us (seq=3D0, len=3D0)
#     ENQ: 1621101932 s 892058 us (seq=3D39, len=3D10)  (USR +24 us)
#     USR-ENQ: count=3D4, avg=3D53 us, min=3D24 us, max=3D119 us
# test ENQ + SND
#     USR: 1621101933 s 48992 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 49044 us (seq=3D9, len=3D10)  (USR +51 us)
#     SND: 1621101933 s 50060 us (seq=3D9, len=3D10)  (USR +1068 us)
#     USR: 1621101933 s 99397 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 99444 us (seq=3D19, len=3D10)  (USR +47 us)
#     SND: 1621101933 s 100491 us (seq=3D19, len=3D10)  (USR +1093 us)
#     USR: 1621101933 s 149760 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 149819 us (seq=3D29, len=3D10)  (USR +59 us)
#     SND: 1621101933 s 150857 us (seq=3D29, len=3D10)  (USR +1097 us)
#     USR: 1621101933 s 200029 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 200062 us (seq=3D39, len=3D10)  (USR +32 us)
#     SND: 1621101933 s 201080 us (seq=3D39, len=3D10)  (USR +1050 us)
#     USR-ENQ: count=3D4, avg=3D47 us, min=3D32 us, max=3D59 us
#     USR-SND: count=3D4, avg=3D1077 us, min=3D1050 us, max=3D1097 us
#=20
# test ACK
#     USR: 1621101933 s 356846 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 363001 us (seq=3D9, len=3D10)  (USR +6155 us)
#     USR: 1621101933 s 407095 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 413288 us (seq=3D19, len=3D10)  (USR +6193 us)
#     USR: 1621101933 s 457340 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 463471 us (seq=3D29, len=3D10)  (USR +6130 us)
#     USR: 1621101933 s 507618 us (seq=3D0, len=3D0)
#     ACK: 1621101933 s 513754 us (seq=3D39, len=3D10)  (USR +6136 us)
#     USR-ACK: count=3D4, avg=3D6153 us, min=3D6130 us, max=3D6193 us
#=20
# test SND + ACK
#     USR: 1621101933 s 664361 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 665399 us (seq=3D9, len=3D10)  (USR +1037 us)
#     ACK: 1621101933 s 670467 us (seq=3D9, len=3D10)  (USR +6105 us)
#     USR: 1621101933 s 714628 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 715670 us (seq=3D19, len=3D10)  (USR +1041 us)
#     ACK: 1621101933 s 720738 us (seq=3D19, len=3D10)  (USR +6110 us)
#     USR: 1621101933 s 764868 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 765906 us (seq=3D29, len=3D10)  (USR +1038 us)
#     ACK: 1621101933 s 770987 us (seq=3D29, len=3D10)  (USR +6119 us)
#     USR: 1621101933 s 815115 us (seq=3D0, len=3D0)
#     SND: 1621101933 s 816160 us (seq=3D39, len=3D10)  (USR +1045 us)
#     ACK: 1621101933 s 821271 us (seq=3D39, len=3D10)  (USR +6155 us)
#     USR-SND: count=3D4, avg=3D1040 us, min=3D1037 us, max=3D1045 us
#     USR-ACK: count=3D4, avg=3D6122 us, min=3D6105 us, max=3D6155 us
#=20
# test ENQ + SND + ACK
#     USR: 1621101933 s 971922 us (seq=3D0, len=3D0)
#     ENQ: 1621101933 s 971969 us (seq=3D9, len=3D10)  (USR +47 us)
#     SND: 1621101933 s 972983 us (seq=3D9, len=3D10)  (USR +1060 us)
# ERROR: 21025 us expected between 6000 and 6500
#     ACK: 1621101933 s 992947 us (seq=3D9, len=3D10)  (USR +21025 us)
#     USR: 1621101934 s 22250 us (seq=3D0, len=3D0)
#     ENQ: 1621101934 s 22279 us (seq=3D19, len=3D10)  (USR +29 us)
#     SND: 1621101934 s 23299 us (seq=3D19, len=3D10)  (USR +1049 us)
# ERROR: 27957 us expected between 6000 and 6500
#     ACK: 1621101934 s 50207 us (seq=3D19, len=3D10)  (USR +27957 us)
#     USR: 1621101934 s 74111 us (seq=3D0, len=3D0)
#     ENQ: 1621101934 s 74142 us (seq=3D29, len=3D10)  (USR +30 us)
#     SND: 1621101934 s 75160 us (seq=3D29, len=3D10)  (USR +1049 us)
# ERROR: 15755 us expected between 6000 and 6500
#     ACK: 1621101934 s 89866 us (seq=3D29, len=3D10)  (USR +15755 us)
#     USR: 1621101934 s 130859 us (seq=3D0, len=3D0)
#     ENQ: 1621101934 s 130892 us (seq=3D39, len=3D10)  (USR +33 us)
#     SND: 1621101934 s 131913 us (seq=3D39, len=3D10)  (USR +1053 us)
#     ACK: 1621101934 s 137042 us (seq=3D39, len=3D10)  (USR +6183 us)
#     USR-ENQ: count=3D4, avg=3D35 us, min=3D29 us, max=3D47 us
#     USR-SND: count=3D4, avg=3D1053 us, min=3D1049 us, max=3D1060 us
#     USR-ACK: count=3D4, avg=3D17730 us, min=3D6183 us, max=3D27957 us
not ok 40 selftests: net: txtimestamp.sh # exit=3D1
# selftests: net: vrf-xfrm-tests.sh
#=20
# No qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
#=20
# netem qdisc on VRF device
# TEST: IPv4 no xfrm policy                                           [ OK ]
# TEST: IPv6 no xfrm policy                                           [ OK ]
# TEST: IPv4 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy based on address                             [ OK ]
# TEST: IPv6 xfrm policy with VRF in selector                         [ OK ]
# Error: Unknown device type.
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# Cannot find device "xfrm0"
# TEST: IPv4 xfrm policy with xfrm device                             [FAIL]
# TEST: IPv6 xfrm policy with xfrm device                             [FAIL]
# Cannot find device "xfrm0"
#=20
# Tests passed:  10
# Tests failed:   4
not ok 41 selftests: net: vrf-xfrm-tests.sh # exit=3D1
# selftests: net: rxtimestamp.sh
# Testing ip...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv4 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 1 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv6 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 2 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv4 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 2 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv6 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Starting testcase 9 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Testing udp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv4 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 1 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv6 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 2 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv4 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 2 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv6 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Starting testcase 9 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Testing tcp...
# Starting testcase 0 over ipv4...
# Starting testcase 0 over ipv6...
# Starting testcase 1 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv4 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 1 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 1 over ipv6 sockopts { SO_TIMESTAMP } expected cmsgs:=
 { SCM_TIMESTAMP }
# Starting testcase 2 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv4 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 2 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 2 over ipv6 sockopts { SO_TIMESTAMPNS } expected cmsg=
s: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv4...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 3 over ipv6...
# ./rxtimestamp: Expected tstampns to be set.
# FAILURE in testcase 3 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPNS }=
 expected cmsgs: { SCM_TIMESTAMPNS }
# Starting testcase 4 over ipv4...
# Starting testcase 4 over ipv6...
# Starting testcase 5 over ipv4...
# Starting testcase 5 over ipv6...
# Starting testcase 6 over ipv4...
# Starting testcase 6 over ipv6...
# Starting testcase 7 over ipv4...
# Starting testcase 7 over ipv6...
# Starting testcase 8 over ipv4...
# Starting testcase 8 over ipv6...
# Starting testcase 9 over ipv4...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv4 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
# Starting testcase 9 over ipv6...
# ./rxtimestamp: Expected tstamp to be set.
# FAILURE in testcase 9 over ipv6 sockopts { SO_TIMESTAMP  SO_TIMESTAMPING:=
 { SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_RX_SOFTWARE |}} expected cm=
sgs: { SCM_TIMESTAMP  SCM_TIMESTAMPING {0}}
not ok 42 selftests: net: rxtimestamp.sh # exit=3D24
# selftests: net: devlink_port_split.py
# Traceback (most recent call last):
#   File "./devlink_port_split.py", line 277, in <module>
#     main()
#   File "./devlink_port_split.py", line 242, in main
#     dev =3D list(devs.keys())[0]
# IndexError: list index out of range
not ok 43 selftests: net: devlink_port_split.py # exit=3D1
# selftests: net: drop_monitor_tests.sh
# SKIP: Could not run test without tshark tool
ok 44 selftests: net: drop_monitor_tests.sh # SKIP
# selftests: net: vrf_route_leaking.sh
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv4 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP Frag needed                                [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv4 connectivity                                       [ OK ]
# TEST: Ping received ICMP ttl exceeded                               [ OK ]
#=20
# #########################################################################=
##
# IPv4 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV4 test without traceroute
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# #########################################################################=
##
# IPv6 (sym route): VRF ICMP fragmentation error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Packet too big                             [FAIL]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP ttl error route lookup ping
# #########################################################################=
##
#=20
# TEST: Basic IPv6 connectivity                                       [ OK ]
# TEST: Ping received ICMP Hop limit                                  [ OK ]
#=20
# #########################################################################=
##
# IPv6 (asym route): VRF ICMP error route lookup traceroute
# #########################################################################=
##
#=20
# SKIP: Could not run IPV6 test without traceroute6
#=20
# Tests passed:  11
# Tests failed:   1
not ok 45 selftests: net: vrf_route_leaking.sh # exit=3D1
# selftests: net: bareudp.sh
# TEST: IPv4 packets over UDPv4                                       [ OK ]
# TEST: IPv4 packets over UDPv6                                       [ OK ]
# TEST: IPv6 packets over UDPv4                                       [ OK ]
# TEST: IPv6 packets over UDPv6                                       [ OK ]
# TEST: IPv4 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv4 (multiproto mode)                     [ OK ]
# TEST: IPv4 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: IPv6 packets over UDPv6 (multiproto mode)                     [ OK ]
# TEST: Unicast MPLS packets over UDPv4                               [ OK ]
# TEST: Unicast MPLS packets over UDPv6                               [ OK ]
ok 46 selftests: net: bareudp.sh
# selftests: net: unicast_extensions.sh
# #########################################################################=
##
# Unicast address extensions tests (behavior of reserved IPv4 addresses)
# #########################################################################=
##
# TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [ OK ]
# TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [ OK ]
# TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [ OK ]
# TEST: assign and ping inside 255.255/16 (is allowed)                [ OK ]
# TEST: assign and ping inside 255.255.255/24 (is allowed)            [ OK ]
# TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [ OK ]
# TEST: route between 0.200/16 and 245.99/16 (is allowed)             [ OK ]
# TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
# TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
# TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
# TEST: assign and ping lowest address (is forbidden)                 [ OK ]
# TEST: routing using lowest address (is forbidden)                   [ OK ]
# TEST: assign and ping class D address (is forbidden)                [ OK ]
# TEST: routing using class D (is forbidden)                          [ OK ]
# TEST: routing using 127/8 (is forbidden)                            [ OK ]
ok 47 selftests: net: unicast_extensions.sh
# selftests: net: udpgro_fwd.sh
# IPv4
# ./udpgro_fwd.sh: 90: local: -r: bad variable name
# ./udpgro_fwd.sh: 22: local: -r: bad variable name
not ok 48 selftests: net: udpgro_fwd.sh # exit=3D2
# selftests: net: veth.sh
# Missing xdp_dummy helper. Build bpf selftest first
# ./veth.sh: 111: exit: Illegal number: -1
# ./veth.sh: 21: local: -r: bad variable name
not ok 49 selftests: net: veth.sh # exit=3D2

--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-bm.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
kernel-selftests:
  group: net
job_origin: kernel-selftests-bm.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-nuc2
tbox_group: lkp-skl-nuc2
submit_id: 609fe23aa723baebc6c8252c
job_file: "/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d1023bc19bee0379b804309f9be5dd9f91dfba00-20210515-60358-17qnl2n-0.yaml"
id: 75fc162b928474cc26d4ce15b74089f2ba916baf
queuer_version: "/lkp-src"

#! hosts/lkp-skl-nuc2
model: Skylake
nr_cpu: 8
memory: 32G
nr_sdd_partitions: 1
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSCKKF480H6_CVLY6296001Z480F-part2"
brand: Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: d1023bc19bee0379b804309f9be5dd9f91dfba00

#! include/testbox/lkp-skl-nuc2
netconsole_port: 6675
ucode: '0xe2'
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kselftests: true
need_kconfig:
- CONFIG_USER_NS=y
- CONFIG_BPF_SYSCALL=y
- CONFIG_TEST_BPF=m
- CONFIG_NUMA=y ~ ">= v5.6-rc1"
- CONFIG_NET_VRF=y ~ ">= v4.3-rc1"
- CONFIG_NET_L3_MASTER_DEV=y ~ ">= v4.4-rc1"
- CONFIG_IPV6=y
- CONFIG_IPV6_MULTIPLE_TABLES=y
- CONFIG_VETH=y
- CONFIG_NET_IPVTI=m
- CONFIG_IPV6_VTI=m
- CONFIG_DUMMY=y
- CONFIG_BRIDGE=y
- CONFIG_VLAN_8021Q=y
- CONFIG_IFB=y
- CONFIG_NETFILTER=y
- CONFIG_NETFILTER_ADVANCED=y
- CONFIG_NF_CONNTRACK=m
- CONFIG_NF_NAT=m ~ ">= v5.1-rc1"
- CONFIG_IP6_NF_IPTABLES=m
- CONFIG_IP_NF_IPTABLES=m
- CONFIG_IP6_NF_NAT=m
- CONFIG_IP_NF_NAT=m
- CONFIG_NF_TABLES=m
- CONFIG_NF_TABLES_IPV6=y ~ ">= v4.17-rc1"
- CONFIG_NF_TABLES_IPV4=y ~ ">= v4.17-rc1"
- CONFIG_NFT_CHAIN_NAT_IPV6=m ~ "<= v5.0"
- CONFIG_NFT_CHAIN_NAT_IPV4=m ~ "<= v5.0"
- CONFIG_NET_SCH_FQ=m
- CONFIG_NET_SCH_ETF=m ~ ">= v4.19-rc1"
- CONFIG_NET_SCH_NETEM=y
- CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
- CONFIG_KALLSYMS=y
- CONFIG_BAREUDP=m ~ ">= v5.7-rc1"
- CONFIG_MPLS_ROUTING=m ~ ">= v4.1-rc1"
- CONFIG_MPLS_IPTUNNEL=m ~ ">= v4.3-rc1"
- CONFIG_NET_SCH_INGRESS=y ~ ">= v4.19-rc1"
- CONFIG_NET_CLS_FLOWER=m ~ ">= v4.2-rc1"
- CONFIG_NET_ACT_TUNNEL_KEY=m ~ ">= v4.9-rc1"
- CONFIG_NET_ACT_MIRRED=m ~ ">= v5.11-rc1"
enqueue_time: 2021-05-15 23:01:14.517241923 +08:00
_id: 609fe23aa723baebc6c8252c
_rt: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 72da41c58a616f9d0aa4b177d35f2a5ca7e2c67d
base_commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
branch: linux-devel/devel-hourly-20210511-230510
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/0"
scheduler_version: "/lkp/lkp/.src-20210513-171754"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-nuc2/kernel-selftests-net-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-d1023bc19bee0379b804309f9be5dd9f91dfba00-20210515-60358-17qnl2n-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=linux-devel/devel-hourly-20210511-230510
- commit=d1023bc19bee0379b804309f9be5dd9f91dfba00
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/vmlinuz-5.12.0-15073-gd1023bc19bee
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/net-ucode=0xe2/lkp-skl-nuc2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/linux-selftests.cgz"
kselftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/kselftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210507.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-0d95472a-1_20210507.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210511-095718/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.12.0-15018-g247b8634e644

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/d1023bc19bee0379b804309f9be5dd9f91dfba00/vmlinuz-5.12.0-15073-gd1023bc19bee"
dequeue_time: 2021-05-16 00:05:48.057407684 +08:00

#! /lkp/lkp/.src-20210513-171754/include/site/inn
job_state: finished
loadavg: 0.82 0.74 0.68 1/181 9072
start_time: '1621094875'
end_time: '1621096108'
version: "/lkp/lkp/.src-20210513-171829:3289bb95:d4b01c2df"

--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

mount --bind /lib/modules/5.12.0-15073-gd1023bc19bee/kernel/lib /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d1023bc19bee0379b804309f9be5dd9f91dfba00/lib
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
sed -i s/default_timeout=45/default_timeout=300/ /kselftests/kselftest/runner.sh
/kselftests/run_kselftest.sh -c net

--tvOENZuN7d6HfOWU--
