Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92370
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 09:14:52 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:35304.1563350684
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-5115ca8f26c14b9a91d0dcf6ea180cd4 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id D281D280098;
	Thu, 17 Jun 2021 17:14:43 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 5115ca8f26c14b9a91d0dcf6ea180cd4 for mptcp@lists.linux.dev;
	Thu Jun 17 17:14:43 2021
X-Transaction-ID: 5115ca8f26c14b9a91d0dcf6ea180cd4
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v3 0/4] mptcp: fix conflicts when using pm.add_signal in ADD_ADDR/echo and RM_ADDR process
Date: Thu, 17 Jun 2021 17:14:32 +0800
Message-Id: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
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

Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.

Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix 
conflicts in using pm.addr_signal porcess.

Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.

v1->v2:
 - remove READ_ONCE under the pm spin lock.

v2->v3:
 - Patch 2: rename mptcp_pm_should_add_addr to mptcp_pm_should_add_signal_addr
 - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change  
   mptcp_pm_add_addr_signal to return void.

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

