Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9529D6
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 01:49:24 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:33510.417183281
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-5a0c242f35f34769876aa48fc24ed7bb (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id C479F280113;
	Tue, 29 Jun 2021 09:41:49 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 5a0c242f35f34769876aa48fc24ed7bb for mptcp@lists.linux.dev;
	Tue Jun 29 09:41:50 2021
X-Transaction-ID: 5a0c242f35f34769876aa48fc24ed7bb
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v6 0/4] mptcp: fix conflicts when using pm.add_signal in ADD_ADDR/echo and RM_ADDR process
Date: Tue, 29 Jun 2021 09:41:35 +0800
Message-Id: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
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
 - Patch 2: mptcp_pm_should_add_addr => mptcp_pm_should_add_signal_addr
 - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change  
   mptcp_pm_add_addr_signal to return void.

v3->v4:
 - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO)) 
   instead of BIT(MPTCP_RM_ADDR_SIGNAL)
 - Patch 3: simple the code; init flags; fix wrong goto logic code; 

v4->v5:
 - Patch 3: simple the code of 'mptcp_established_options_add_addr'

v5->v6:
 - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send_ack 
   without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent for 
   ADD_ADDR. That cause ADD_ADDR can not be sent in time.
 - Patch3: refactor some code according Geliang's suggestions.
 - Patch4: modify commit comment

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

