Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942B72
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 03:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=fHuB8NkjIdk/X+RYFw
	Q17qh9M0C4yZfCjMC25q6jxDY=; b=jFSeg33vlVewcVFldVa+QKz2jEsbGE+lDq
	mlwT8ax13L+qJRMnzc6f+p0qRifG+1XNNtRM4nZUw+8FtGjYNCvP43rR9QWP6ng7
	eYb1dx44WTO3JP6+mp5ReB/87K//0UgH/bmEDyj4BJfSzASKAzaOrSl3uzsm5kHb
	lKmPSt5Qk=
Received: from localhost.localdomain.localdomain (unknown [110.80.1.45])
	by smtp10 (Coremail) with SMTP id DsCowAC3_2NMGMhgphfqOw--.24172S2;
	Tue, 15 Jun 2021 11:02:37 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	fw@strlen.de
Subject: [PATCH v4 0/4] Fix some mptcp syncookie process bugs
Date: Tue, 15 Jun 2021 11:02:22 +0800
Message-Id: <1623726146-5911-1-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:DsCowAC3_2NMGMhgphfqOw--.24172S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyxZr1fGr17Jr1UZw4ruFg_yoWDGrX_W3
	9rJrW3GrW7ZFWkAFW7KFs8JrZYgrWqg3y8Cr1qqrZ8Gry7ta40qFs0qrs7ur18GFWFvas5
	CFy7ZrW8AF13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8fsqJUUUUU==
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJw2ykF5u+ukiWQAAsQ
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

v3->v4:
patch1: using seq and sport/dport for hashing, and ignore network headers altogether,
        as suggest by Florian
patch2: no changes
patch3: no changes
patch4: no changes 

v2->v3:
patch1: directly use inet6_ehashfn() for IPv6
patch2: no changes
patch3: no changes
patch4: add Fixes tag.

v1->v2:
patch1: handle ipv6 sockets/addresses,
        always use 4-tuple drived hash and never look at skb->hash
patch2: no changes
patch3: split into 2 patches.
patch4: new added.


Jianguo Wu (4):
  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for
    subflow join
  mptcp: remove redundant req destruct in subflow_check_req()
  mptcp: fix syncookie process if mptcp can not_accept new subflow
  mptcp: avoid processing packet if a subflow reset

 net/mptcp/options.c    |  2 ++
 net/mptcp/subflow.c    | 11 +++--------
 net/mptcp/syncookies.c | 16 +++++++++++++++-
 3 files changed, 20 insertions(+), 9 deletions(-)

-- 
1.8.3.1

