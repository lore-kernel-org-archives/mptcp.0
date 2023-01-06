Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7127E8
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673031454; x=1704567454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7TIumUDPpEAOEBg0s828TzSxiiXHZj89eU4D6tJcElg=;
  b=RYD9dJGvGVs0aKpDltefeYwOA1XJzidNL5V7T0mCKAYmfYS75VUIqTE6
   Lg4ewqIHJKa32KwyT+5NgpXXMTM56y9zjZ5MfRbh9tISiF5+kpfMn1eoj
   wFBz9tjB2hMTLxaiPi3DOV1gxOeyIHu8JgBgZwAzQ5ZVJSQpfiYcBxm9O
   TIyxjsKLkHwwZ8dEgoZeKFC4BDRvsFqT1eB6R2xjzPstum+IFM/RXMaLn
   yl2cqCq0CRnmgldKz9Lq61bsrIgMBKNd0F+KNabLTRq/phIAjkjx+ub1f
   PtA8xjVvKRBe7X5qvWom61B8ppq9e+/37WqoSgmYt5wioXUtmDBG7Ps1p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322611200"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="322611200"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="688383426"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="688383426"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 10:57:33 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/9] mptcp: Protocol in-use tracking and code cleanup
Date: Fri,  6 Jan 2023 10:57:16 -0800
Message-Id: <20230106185725.299977-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's a collection of commits from the MPTCP tree:

Patches 1-4 and 6 contain miscellaneous code cleanup for more consistent
use of helper functions, existing local variables, and better naming.

Patches 5, 7, and 9 add sock_prot_inuse tracking for MPTCP and an
associated self test.

Patch 8 modifies the mptcp_connect self test tool to exit on SIGUSR1
when in "slow mode".

Geliang Tang (3):
  mptcp: use msk_owned_by_me helper
  mptcp: use net instead of sock_net
  mptcp: use local variable ssk in write_options

Menglong Dong (6):
  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
  mptcp: init sk->sk_prot in build_msk()
  mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
  mptcp: add statistics for mptcp socket in use
  selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
  selftest: mptcp: add test for mptcp socket in use

 net/mptcp/options.c                           |  3 +-
 net/mptcp/pm_netlink.c                        |  5 +-
 net/mptcp/protocol.c                          | 38 ++++++++-----
 net/mptcp/protocol.h                          |  2 +-
 net/mptcp/sockopt.c                           |  2 +-
 net/mptcp/token.c                             | 14 +++--
 net/mptcp/token_test.c                        |  3 +
 tools/testing/selftests/net/mptcp/diag.sh     | 56 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.c       |  4 +-
 9 files changed, 95 insertions(+), 32 deletions(-)


base-commit: 6bd4755c7c499dbcef46eaaeafa1a319da583b29
-- 
2.39.0

