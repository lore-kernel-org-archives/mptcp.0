Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614A72
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=p01GW
	YLRbaWSny/I66OmLLpDp2YruCltlW4Vc39yYEk=; b=Zi9O7hH1Undg6UKAgPFNQ
	g9L1Q4oXpQ/TQIrB4l2YxCkP3Gd6QuwMHc0nSRNP50jouFWZyu0jU1RWfL8ta3LI
	a9CEOXczYRqNDNjBpsWugAatFKGiyZvVVsBMVh4qiZD30h/LhsYswXBCD6ubowYz
	nUXQ6EUH/u+L7Ig6WFQUnM=
Received: from [192.168.16.78] (unknown [110.86.5.93])
	by smtp8 (Coremail) with SMTP id DMCowADHx9NmmsBg9zCxIw--.5362S2;
	Wed, 09 Jun 2021 18:39:35 +0800 (CST)
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH 0/3] Fix some mptcp syncookie process bugs
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
 Geliang Tang <geliangtang@gmail.com>
Message-ID: <5224c600-36f3-2069-beab-4272a301688c@163.com>
Date: Wed, 9 Jun 2021 18:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DMCowADHx9NmmsBg9zCxIw--.5362S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgHqcUUUUU
X-Originating-IP: [110.86.5.93]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBSQeskFaD+1gMIwAAsr

Fix some mptcp syncookie process bugs.

Jianguo Wu (3):
  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for subflow join
  mptcp: remove redundant req destruct in subflow_check_req()
  mptcp: fix syncookie process if mptcp can not_accept new subflow

 net/ipv4/tcp_input.c   |  7 ++++++-
 net/mptcp/subflow.c    | 11 +++--------
 net/mptcp/syncookies.c | 24 +++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 10 deletions(-)

-- 
1.8.3.1

