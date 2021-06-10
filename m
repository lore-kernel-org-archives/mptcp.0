Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9C72
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=Ip2SG
	EK6EQdw+eG2FkX5jzn//NjCBLG4oW+GxS6dA9Y=; b=ax+eqaUotTfHEzWZMX1o9
	E7Xj5s5KSJJrUMj8rF3e+1KzVm3rcWqvTJ/6XhWpYRY1tyoeEI1Z0e3zTdZ23Ug+
	2drpwrLqLAzoE86pNIKkRnXjcGpSK5U7RPbTIutJetmVO2en4euQ1xY8+ytmSVwo
	tNKqtefACdo6XCswAA0LrA=
Received: from [192.168.16.78] (unknown [110.80.1.45])
	by smtp7 (Coremail) with SMTP id C8CowABHMoo428Fgmuj1hA--.24226S2;
	Thu, 10 Jun 2021 17:28:24 +0800 (CST)
From: Jianguo Wu <wujianguo106@163.com>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 0/4] Fix some mptcp syncookie process bugs
Message-ID: <6f0fe8f0-492d-0a0f-6853-721961b48811@163.com>
Date: Thu, 10 Jun 2021 17:28:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowABHMoo428Fgmuj1hA--.24226S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4xKryUWFy3CrWDCw4DArb_yoWxKFb_G3
	yxXry3GrW8uFZ8JFW7Krs8JrWrWrWDW34j9F1vqryUJr13ta40qF4DKrZ7ur18CFZ5XFyD
	WF17A348AF13KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeMUDtUUUUU==
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiBitkFaD-P04tQAAs0

Fix some mptcp syncookie process bugs.

v1->v2:

patch1: handle ipv6 sockets/addresses,
        always use 4-tuple drived hash and never look at skb->hash
patch2: no changes
patch3: split into 2 patches.
patch4: new added.

Jianguo Wu (4):
  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for subflow join
  mptcp: remove redundant req destruct in subflow_check_req()
  mptcp: fix syncookie process if mptcp can not_accept new subflow
  mptcp: avoid processing packet if a subflow reset

 net/mptcp/options.c    |  2 ++
 net/mptcp/subflow.c    | 11 +++-------
 net/mptcp/syncookies.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 12 deletions(-)

-- 
1.8.3.1

