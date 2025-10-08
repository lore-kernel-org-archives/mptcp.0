Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C18288C0E
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932016; cv=none; b=W1VbUreXq3Ms2X6cTrj6uHVZZ6z0NGd6fWElxrJ4A+6h5m1UsRAmhv8Y0tLJMFAd6s7mNFYi46o+NXXfsncdo5KUOyp8hEUQFI7SR4R+f8eB+id9hLcSAqd70IgM1qpt0I6GC75/1xIuRcSe3kTNYTL53E8ikIdd0843pqjEBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932016; c=relaxed/simple;
	bh=2LsCQGyDC2O8+H8PLJYOjRsKS5oSTOHqYfQHcjXaLo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eVfnnQAXyie37Yp8yC0XaJhuaJi5sOvKPp7yf9f7MTftj79Ji92XbIqjetpVTXh9ulVJWAOHdrswQbqqMeeMrstQNT3Tn9iLOD3s77XVsJtGT3/NHDySaM4KOa8jk0oXQPL/bNQ+TCB7x2gdy0oiA0+o7/p7yi7uwicJF/WeagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X161ZHyb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X161ZHyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE9BC4CEE7;
	Wed,  8 Oct 2025 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932015;
	bh=2LsCQGyDC2O8+H8PLJYOjRsKS5oSTOHqYfQHcjXaLo8=;
	h=From:Subject:Date:To:Cc:From;
	b=X161ZHyb1SGfWRa1dNul5eOFuCltdM0XHiMOGg6x+OWrA276zidsW0OSkvBLyeHZf
	 bOuT1HJiD4d1v5WO1llqjh47l3+Eer71gKFtZbrlb3LlengXLl9IUXet3+W64sA3BG
	 R8ls3lrdKDXXRTF4EVLED8cIlHXwlv2A9YU77myfTuEQheuEvdTu5WAWQDV6nXCzxa
	 CKPjrtHjUUtQmxvmCU8iBShLjzAq2fzArDlX1wNPN4B7f3JodqXatypDRcnrXiHLGX
	 Lc6c8zmutMIMAKFQjxPTvwmFjeQZgXMz/6D/LIIq80dZg8Ak2PM/RYJkYXfC1WJSIj
	 3hStjT85NUDWw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/7] mptcp: pm: in-kernel: C-flag: handle late
 ADD_ADDR + misc.
Date: Wed, 08 Oct 2025 15:59:54 +0200
Message-Id: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpu5mgC/x2MzQqDMBAGX0X27EL8r76K9BCST7tg05AEaRHfv
 dHDHOYwc1BEEESaioMCdonycVmqsiDz0m4Fi81Otaq7SqmGDS+bXllbexHYYtM/bjGiG4bHaJq
 ecusDFvne35nePhnPDome5/kHeArQVHIAAAA=
X-Change-ID: 20251003-c-flag-add-addr-delay-4e9e57789c36
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2LsCQGyDC2O8+H8PLJYOjRsKS5oSTOHqYfQHcjXaLo8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKe5aWu2suS+UltwvNrUR9jZ/2ebSgWYFJavKe1u72s+
 c2U6+f5O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayyY+RYV3BOx+frBNJOgEl
 wbmmB5nsAoyUxfLfKcx4t3yu8vePXxj+p39Y/+19WAJn4EOFQ72alSdObH++9tM2Hcvc0gyP8/c
 PMgAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On NIPA, the new test validating the special case for the C-flag failed
a few times, e.g.

  102 default limits, server deny join id 0
        syn rx                 [FAIL] got 0 JOIN[s] syn rx expected 2
  Server ns stats
  TcpPassiveOpens                 1                  0.0
  TcpInSegs                       9                  0.0
  TcpOutSegs                      10                 0.0
  TcpExtTW                        1                  0.0
  TcpExtTCPPureAcks               5                  0.0
  TcpExtTCPOrigDataSent           3                  0.0
  TcpExtTCPDelivered              3                  0.0
  MPTcpExtMPCapableSYNRX          1                  0.0
  MPTcpExtMPCapableACKRX          1                  0.0
  MPTcpExtAddAddrTx               1                  0.0
  MPTcpExtEchoAdd                 1                  0.0
  Client ns stats
  TcpActiveOpens                  1                  0.0
  TcpInSegs                       10                 0.0
  TcpOutSegs                      9                  0.0
  TcpExtTCPPureAcks               6                  0.0
  TcpExtTCPOrigDataSent           3                  0.0
  TcpExtTCPDelivered              4                  0.0
  MPTcpExtMPCapableSYNTX          1                  0.0
  MPTcpExtMPCapableSYNACKRX       1                  0.0
  MPTcpExtAddAddr                 1                  0.0
  MPTcpExtEchoAddTx               1                  0.0
        synack rx              [FAIL] got 0 JOIN[s] synack rx expected 2
        ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 2
        join Rx                [FAIL] see above
        syn tx                 [FAIL] got 0 JOIN[s] syn tx expected 2
        join Tx                [FAIL] see above

I had a suspicion about what the issue could be: the ADD_ADDR might have
been received with a delay, not when switching to 'fully-established'.
The issue was not easy to reproduce on my side, but when I did, the
packet capture shown that the ADD_ADDR can indeed be received with a
delay, and the client would not try to establish subflows to it as
expected.

Patch 1 fixes that, simply by not marking the endpoints as 'used' in the
C-flag case, when looking at creating subflows to the remote initial IP
address and port: in this case, there is no need to try.

Patches 2 to 5 are not directly related, but seen when working on patch
7: they fix subtests not being marked as 'skipped' on older kernels.

Patches 6 and 7 are for net-next:

- The first one avoids iterating over all endpoints just to check if one
  of them has the 'fullmesh' flag.

- The second one clarifies what is done when an ADD_ADDR is received and
  there are endpoints with the fullmesh flag: only these endpoints are
  used, even if there are none defined for this address family.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (7):
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
      selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
      selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
      selftests: mptcp: join: mark implicit tests as skipped if not supported
      selftests: mptcp: join: mark laminar tests as skipped if not supported
      mptcp: pm: in-kernel: record fullmesh endp nb
      mptcp: pm: in kernel: only use fullmesh endp if any

 include/uapi/linux/mptcp.h                      |  3 +-
 net/mptcp/pm_kernel.c                           | 42 ++++++++++++++++++++++---
 net/mptcp/protocol.h                            |  1 +
 net/mptcp/sockopt.c                             |  2 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 24 ++++++++------
 5 files changed, 57 insertions(+), 15 deletions(-)
---
base-commit: 3afc295b5e6e698696cf1fd75db194db2c7f64cd
change-id: 20251003-c-flag-add-addr-delay-4e9e57789c36

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

