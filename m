Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6272
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 04:45:50 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:60308.1638703953
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-10482a78b4d84243ae8fb1d52823714b (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id E06FE28009E;
	Tue, 22 Jun 2021 12:45:46 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 10482a78b4d84243ae8fb1d52823714b for mptcp@lists.linux.dev;
	Tue Jun 22 12:45:47 2021
X-Transaction-ID: 10482a78b4d84243ae8fb1d52823714b
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v5 0/4] mptcp: fix conflicts when using pm.add_signal in ADD_ADDR/echo and RM_ADDR process
Date: Tue, 22 Jun 2021 12:45:31 +0800
Message-Id: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn>
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

v3->v4:
 - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO)) instead 
   of BIT(MPTCP_RM_ADDR_SIGNAL)
 - Patch 3: simple the code; init flags; fix wrong goto logic code; 

v4->v5:
 - Patch 3: simple the code of function 'mptcp_established_options_add_addr'

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

