Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738B8F63
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 19:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671565953; x=1703101953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tdwr4tSuEEph9K5A0iUIg96ixLr3HopsgYZRUV8gxs4=;
  b=JvHiKTVleDcRjwrOyowjiGgknpPdVrsuXyQTkNQs6p/OnjfEidIayu1z
   aKIHWWxE4Tm4EPMS4/6WPCLPm4IU/Nr8rkwCq+tId3WZUTjQxM4voaxnp
   uVrFatQJkr8IaQf9wFYf72hbbhUmbbxK00TC+jlbFfAhVVzWnb+bpZwJY
   d7kOFWdhGJTEds3IYwAyOM405SH96NkJhJFed2m8vo8MFNK0DQYab024M
   xBBdJPxfg9E9Rz3BSE4K7RnOPafSFaY1v0S2WwLScH8JklyB6PixR4X8v
   z44fzUIWE4aSs1+pukDgrukKAIBXVn1mssiqHJCTUgejD5bvAt1JbmffP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299376681"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="299376681"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 11:52:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="681780963"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="681780963"
Received: from mdaugher-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.232.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 11:52:21 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	imagedong@tencent.com,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: Locking fixes
Date: Tue, 20 Dec 2022 11:52:13 -0800
Message-Id: <20221220195215.238353-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two separate locking fixes for the networking tree:

Patch 1 addresses a MPTCP fastopen error-path deadlock that was found
with syzkaller.

Patch 2 works around a lockdep false-positive between MPTCP listening and
non-listening sockets at socket destruct time.


Paolo Abeni (2):
  mptcp: fix deadlock in fastopen error path
  mptcp: fix lockdep false positive

 net/mptcp/protocol.c | 20 ++++++++++++++++----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/subflow.c  | 19 +++++++++++++++++--
 3 files changed, 35 insertions(+), 8 deletions(-)


base-commit: 4be84df38a6f49b81e5909ede78242ba1538c1e6
-- 
2.39.0

