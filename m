Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750382FB7
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 08:52:21 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:40052.999822468
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-f7c5a0468a3942f1a4a4b00055d3061f (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 04739280111;
	Thu, 10 Jun 2021 16:52:07 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id f7c5a0468a3942f1a4a4b00055d3061f for mptcp@lists.linux.dev;
	Thu Jun 10 16:52:07 2021
X-Transaction-ID: f7c5a0468a3942f1a4a4b00055d3061f
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH 0/4] mptcp: fix conflicts when using pm.add_signal in ADD_ADDR/echo and RM_ADDR process
Date: Thu, 10 Jun 2021 16:51:54 +0800
Message-Id: <1623315118-57936-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so 
in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in 
process.

fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time, 
only one event can write pm.add_signal. so ADD_ADDR will process 
after add_timer timeout or ADD_ADDR-echo will not be process.

Patches 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.

Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix 
conflicts in using pm.addr_signal porcess.

Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.

Yonglong Li (4):
  mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
  mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
  mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
  mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT

 include/net/mptcp.h    |   1 +
 net/mptcp/options.c    | 161 ++++++++++++++++++++++++++++++++-----------------
 net/mptcp/pm.c         |  53 +++++++---------
 net/mptcp/pm_netlink.c |  10 ++-
 net/mptcp/protocol.h   |  31 ++++------
 5 files changed, 147 insertions(+), 109 deletions(-)

-- 
1.8.3.1

