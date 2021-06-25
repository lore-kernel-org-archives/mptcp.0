Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9596D0E
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=w7Qiu7z5W/FYTSvhgH
	pqj79pcj180YXDvPE2uHUOphA=; b=ArjqSFgxs8gZla+MLyfU7rcmLAAtOQ5std
	/Im0hiljV04+DJn2LNazZHbDXEAn09R+YRAuenaJ9jsUDmixreCNqSgho4e+VAwd
	MPQsMu16KOAhveDNVNYa9wT1sP+T76YJ1tcbemsIugmZZ5++ZW97yHL2MNdtsNw+
	7/NyD4QB4=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowAAnK+MXk9VgPJySrQ--.35196S2;
	Fri, 25 Jun 2021 16:26:01 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v7 0/5] Fix some mptcp syncookie process bugs
Date: Fri, 25 Jun 2021 16:25:54 +0800
Message-Id: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:EsCowAAnK+MXk9VgPJySrQ--.35196S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7WFW7Cr1fKw43uw4fAFb_yoW8Ar4rpF
	Z5uryrJr48JFyfJFy3Ar48Xr1F9a1rKrZ8Jay3tw1Fvw1qywnxGr1xtw13CFW7GFsa934a
	qr47JF4kC3WUZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joYL9UUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxm8kF5u+2NcKAAAsO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: wujianguo <wujianguo@chinatelecom.cn>

v6->v7:
 - patch4: corret the declaration of mptcp_incoming_options()
	   when CONFIG_MPTCP is not set
 - patch5: add tag Reported-by: kernel test robot <oliver.sang@intel.com>

v5->v6:
 - patch1: describe the testing tools in the commit log
 - patch4: add return value to mptcp_incoming_options(), return 0 if
	   a subflow has been reset, else return 1, and drop the packet
	   in tcp_data_queue()/tcp_rcv_state_process() if the return
	   value is 0
 - patch5: update selftest case "multiple subflows limited by server",
	   since the expected behavior is changed by patch4

v4->v5:
 - patch4: add comment 

v3->v4:
 - patch1: using seq and sport/dport for hashing, and ignore network
	   headers altogether, as suggest by Florian

v2->v3:
 - patch1: directly use inet6_ehashfn() for IPv6
 - patch4: add Fixes tag.

v1->v2:
 - patch1: handle ipv6 sockets/addresses,
	   always use 4-tuple drived hash and never look at skb->hash
 - patch3: split into 2 patches.
 - patch4: new added.


Jianguo Wu (5):
  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for
    subflow join
  mptcp: remove redundant req destruct in subflow_check_req()
  mptcp: fix syncookie process if mptcp can not_accept new subflow
  mptcp: avoid processing packet if a subflow reset
  selftests: mptcp: fix case multiple subflows limited by server

 include/net/mptcp.h                             |  5 +++--
 net/ipv4/tcp_input.c                            | 19 +++++++++++++++----
 net/mptcp/options.c                             | 22 ++++++++++++++--------
 net/mptcp/subflow.c                             | 11 +++--------
 net/mptcp/syncookies.c                          | 16 +++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 6 files changed, 51 insertions(+), 24 deletions(-)

-- 
1.8.3.1


