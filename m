Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B86ABC
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645744948; x=1677280948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zsza57S9iUFYXKh6lhG6QAzJasueOVD2tTe+gdP6Yis=;
  b=niTyEkR8oTNc3oIWCMaVL1kHFC4njrKrRVxHB9NWCSAjqIRJeSmu2RCN
   oeAnfENn3IoMB+JDPCXIa737G282L4XdQ/YzQgP3enW/UkMBJAjyK54+e
   OtCR4VDo6MUK1pujXoJm/xQB2khcqcFZtuxlDQqPoXTuq2zBwtc7lwgAP
   kQdmgAflGZI5fghJ3Xo2qoEHd3mTkz/pauFdFgJxQVULaZvb8fev0yD7F
   0VPtp+zB32WqQWqNE1Z2khPpx/wMExUKIK6ddv2RU0YEe4xv/NG/XmaCl
   9Oi6+ytteIXWbV70+N/qQ+ZZV/Ze6vI2Bg+Q7Nbm9h+zXXixkaffzaeeo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232998391"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232998391"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491784929"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:27 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	fw@strlen.de
Subject: [RFC PATCH mptcp-next 0/4] MP_JOIN fallback for TCP listeners
Date: Thu, 24 Feb 2022 15:22:22 -0800
Message-Id: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In discussion of Florian's "replace per-addr listener sockets" series, I
proposed this:

    One possibility that doesn't disturb the hot path too much: Let the
    TCP listener try to handle the SYN. In tcp_parse_options(), add just
    enough code to set a bit in struct tcp_options_received if MP_JOIN
    is present (don't fully parse the MPTCP option). If MP_JOIN is there
    and MPTCP is enabled, return early from tcp_check_req() and have
    tcp_v4_rcv() treat it similar to req_stolen==true. Instead of
    kicking back to a regular lookup, try a token lookup.

It seemed to me that the hot path impact would be minimal. To better
show that, I put together these RFC patches. Only one conditional is
added to the hot path, checking a bit in struct tcp_received options
(which should be in the data cache anyway). The other hooks are:

 * tcp_parse_options() switch statement (only executed if a MPTCP option
   is present).

 * The tcp_check_req()-returned-NULL error paths for IPv4 and IPv6.

In addition, the added code in this series is almost entirely optimized
out if CONFIG_MPTCP is not set. With one more ifdef for the
tcp_parse_option() change, the optimized kernel binary may even be
entirely unchanged.

Compared to Florian's proposal (add token lookup before the listener
lookup) this does change more lines of TCP code, but has less runtime
impact.

Major caveat: this is very lightly tested, build and a quick check to
make sure it didn't break TCP.

This applies on top of "mptcp: replace per-addr listener sockets" v4.


Mat Martineau (4):
  mptcp: Move some symbols to be visible outside the MPTCP subsystem
  tcp: Allow tcp_check_req() to return more status values
  tcp: Check for the presence of a MP_JOIN option
  tcp: Add TCP hooks for detecting MP_JOIN on a regular TCP listener

 include/linux/tcp.h      |  3 ++-
 include/net/mptcp.h      | 18 ++++++++++++++++++
 include/net/tcp.h        | 10 +++++++++-
 net/ipv4/tcp_input.c     | 12 ++++++++++--
 net/ipv4/tcp_ipv4.c      | 13 ++++++++++---
 net/ipv4/tcp_minisocks.c | 14 ++++++++++----
 net/ipv6/tcp_ipv6.c      | 13 ++++++++++---
 net/mptcp/protocol.h     | 12 ------------
 8 files changed, 69 insertions(+), 26 deletions(-)

-- 
2.35.1

