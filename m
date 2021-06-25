Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE72FB6
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=MGN69EACMW/G389m5i
	Ll2R/wggJjJQpG3KOXr/WvGgo=; b=G0Rf5eIVVMYJ0yBBJShHAdzFcM4Uf/YaT3
	wxcn6F3UgwzhsuOwqA21EqNVq2rHCeA8fJLeaYf4DxQOj4FHJU5L3Xm885ASods1
	H7X/sc1k0BpCUHxUSX251DeWYnBk8P31gtCUG3iIfKZVnQpkA3lAJOxF+Bp54ugn
	rzTzz8xnw=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp13 (Coremail) with SMTP id EcCowACntjoSRNVg6_a69Q--.41874S2;
	Fri, 25 Jun 2021 10:48:52 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v6 0/5] Fix some mptcp syncookie process bugs
Date: Fri, 25 Jun 2021 10:48:45 +0800
Message-Id: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:EcCowACntjoSRNVg6_a69Q--.41874S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1UJr4fKrWfuF1xGFW5Awb_yoW8XFy8pF
	Z3CrW5Xr4rAFW3XFy3Ar48Xr1F9a1rKrZ8Jay7tw1Yvr1qy3Z8Gr1xtr1rCFW7GFZ3K34a
	qr47Aa1kCw1UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnHUDUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxS8kF5u+1+Y7QAAs+
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

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

 include/net/mptcp.h                             |  2 +-
 net/ipv4/tcp_input.c                            | 19 +++++++++++++++----
 net/mptcp/options.c                             | 22 ++++++++++++++--------
 net/mptcp/subflow.c                             | 11 +++--------
 net/mptcp/syncookies.c                          | 16 +++++++++++++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 6 files changed, 49 insertions(+), 23 deletions(-)

-- 
1.8.3.1


