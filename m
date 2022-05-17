Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF81860
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652810541; x=1684346541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hUIHED+FQ98pTjGesxJQFWoxjja0CiSPbNhECuXi4/Y=;
  b=lJYdc61dphhMtnzEek0xT7F949n8TA31m3gC1ye2p0paoam12zMp1d9K
   tCMsMYeadIIfNK1biCQmq5K/OwvtZ/EVGcjB72QvGCgcV3gVsA+DXOd8/
   NDlJptEdfCwbCOZeRLhDZFQtANnqvkYxN/zj50LYr9xtHJflYkB6I80Rv
   t4XSz1mlniFCP0cQIgGMVlmS+QcaY6BzM3YuqTA6jAAXoZM2wnyduw1MY
   h1lAROxkWgfKUhCUJ4Dqu5XqJBaz4Ba2RwnWK+uuOpiS63vg/ytUw3HKv
   8yOGbM2cfxvsCUoXoQF5rXif2PW/fYFhvf+VjG3OV+NHSZX/87Iz0RXq5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="331887957"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="331887957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:02:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="523080350"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.6.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:02:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: Fix checksum byte order on little-endian
Date: Tue, 17 May 2022 11:02:10 -0700
Message-Id: <20220517180212.92597-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches address a bug in the byte ordering of MPTCP checksums on
little-endian architectures. The __sum16 type is always big endian, but
was being cast to u16 and then byte-swapped (on little-endian archs)
when reading/writing the checksum field in MPTCP option headers.

MPTCP checksums are off by default, but are enabled if one or both peers
request it in the SYN/SYNACK handshake.

The corrected code is verified to interoperate between big-endian and
little-endian machines.

Patch 1 fixes the checksum byte order, patch 2 partially mitigates
interoperation with peers sending bad checksums by falling back to TCP
instead of resetting the connection.

Mat Martineau (1):
  mptcp: Do TCP fallback on early DSS checksum failure

Paolo Abeni (1):
  mptcp: fix checksum byte order

 net/mptcp/options.c  | 36 ++++++++++++++++++++++++------------
 net/mptcp/protocol.h |  5 +++--
 net/mptcp/subflow.c  | 23 +++++++++++++++++++----
 3 files changed, 46 insertions(+), 18 deletions(-)


base-commit: edf410cb74dc612fd47ef5be319c5a0bcd6e6ccd
-- 
2.36.1

