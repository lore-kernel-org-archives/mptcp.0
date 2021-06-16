Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8D17F
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 11:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=/zJz/cksLfaSF98boJ
	80NmJD0os627Wfym1BW2y38IQ=; b=qMWgs+lHp8U52p7tZemQ3LSkogSM0jq5uR
	Sr1vta7Hh6pLnDO7Ywkn+nH1DSn+3zWR2ge+Q91v5H4SyQlWwiR/QRti+1yiNpAr
	XjFfmXyNyK6ypPYoU9+7RKmjCBK4eeRRTO5Ad4NBTUNiOKD8623+ipkB1ZIkT2GF
	xKudyFehE=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp11 (Coremail) with SMTP id D8CowAB33vY718lgxTs1AA--.106S2;
	Wed, 16 Jun 2021 18:50:32 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	fw@strlen.de
Subject: [PATCH v5 0/4] Fix some mptcp syncookie process bugs
Date: Wed, 16 Jun 2021 18:49:26 +0800
Message-Id: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:D8CowAB33vY718lgxTs1AA--.106S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF15uFy7XFWrWr17GF4rZrb_yoWDtwc_W3
	9rXrW3Gr47ZFWkAFW2kFs8JrWv9rWqg3yUCr1qqrZ8G3srJa40qFs0qrn7ury8Ga9a9as5
	CFyUZrW8AF13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Za93UUUUU==
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9wizkF2MZRh8YgAAsu
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

v4->v5:
patch1: no changes 
patch2: no changes
patch3: no changes
patch4: add comment 

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

 net/mptcp/options.c    |  6 ++++++
 net/mptcp/subflow.c    | 11 +++--------
 net/mptcp/syncookies.c | 16 +++++++++++++++-
 3 files changed, 24 insertions(+), 9 deletions(-)

-- 
1.8.3.1

