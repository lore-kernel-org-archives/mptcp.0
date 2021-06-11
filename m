Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164332FB7
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=HJQkRlv/fGsnRu2YK/
	x+tztyOFAelcTpLauQLQgSzJs=; b=bK80ZDm+4dYRAtvGL/nq9tiiug3j10tw1C
	VfwK7+kibxHx2WB8pZsAMOnFm9uodFDRcbsoIrJnAfFgoo4ugCdhUmjGn68Fpwu4
	KdPaAfx8yrC+k08lm0nJxpGmVMcaAYJE2Yhjtzb0M0+PKbeG+LRFYcGgzcDmulRe
	QeEZaxtVI=
Received: from localhost.localdomain (unknown [110.80.1.45])
	by smtp11 (Coremail) with SMTP id D8CowAD325gTEsNgpvWXAA--.80S2;
	Fri, 11 Jun 2021 15:34:53 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com
Subject: [PATCH v3 0/4] Fix some mptcp syncookie process bugs
Date: Fri, 11 Jun 2021 15:34:38 +0800
Message-Id: <1623396882-2748-1-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:D8CowAD325gTEsNgpvWXAA--.80S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1kuF4xKr4kuw1fXryrJFb_yoW3KFX_W3
	97JrW3GrW7ZFZxJFW7Krs8JrWrWrWqg3y09F1vqrW5Gr1aya40qF4qgFs7ur18uFZYvF95
	CFyUArW0yF13GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Ma0DUUUUU==
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBSR2ukFaD+3B92QAAsQ
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

v1->v2:

patch1: handle ipv6 sockets/addresses,
        always use 4-tuple drived hash and never look at skb->hash
patch2: no changes
patch3: split into 2 patches.
patch4: new added.

v2->v3:
patch1: directly use inet6_ehashfn() for IPv6
patch2: no changes
patch3: no changes
patch4: add Fixes tag.

Jianguo Wu (4):
  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for subflow join
  mptcp: remove redundant req destruct in subflow_check_req()
  mptcp: fix syncookie process if mptcp can not_accept new subflow
  mptcp: avoid processing packet if a subflow reset

 net/mptcp/options.c    |  2 ++
 net/mptcp/subflow.c    | 11 +++--------
 net/mptcp/syncookies.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 12 deletions(-)

-- 
1.8.3.1

