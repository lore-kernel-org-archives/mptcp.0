Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75815DA
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 01:36:03 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BB374240104
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 03:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1687397761; bh=vn5lWO9L26Hc+cT/azimR/ufDacqIFsyS9y1ITX9c+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=EylOBdjc7dp88u898CPNSrTu/ltrxjDY0bDTIW3B9ZkgQVwDnWo8gwTU25mdpY7HG
	 nQ9d2vuTXWne4OWH/VNRsqjDJ7ri+vh7Ib5C1glP84wPZb/d2wpPbk3IRGalCUzlHv
	 sP2OAcbXccVUUpgECJC6FvK2IAR1zUNgahtkTu2zqi01L17dmK5JYejsiM/2FVQ3sH
	 4Rv9FtZiuak6UqnhnQAXATWxs4nWbqxEsYdj+YyoQx0SpjsP7TVUtH+LVYt910xIfc
	 oMHH3FI9zZvwaXbeoh7t4yskIuCUW9RWUE7bkWV/p45QqPT1Bp8Gn3Jl+zLSs/jl+p
	 mXl52eYvBbkQw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Qmjcp1kcSz6twX;
	Thu, 22 Jun 2023 03:35:53 +0200 (CEST)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@kernel.org>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yueh-Shun Li <shamrocklee@posteo.net>
Subject: [PATCH 8/8] scripts/spelling.txt: Add "transmit" patterns
Date: Thu, 22 Jun 2023 01:26:37 +0000
Message-Id: <20230622012627.15050-9-shamrocklee@posteo.net>
In-Reply-To: <20230622012627.15050-1-shamrocklee@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "transmit"-related patterns misspelled with the first "s" missing.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 scripts/spelling.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f8bd6178d17b..c81e489ba4cf 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1319,6 +1319,12 @@ ressource||resource
 ressources||resources
 restesting||retesting
 resumbmitting||resubmitting
+retranmission||retransmission
+retranmissions||retransmissions
+retranmit||retransmit
+retranmits||retransmits
+retranmitted||retransmitted
+retranmitting||retransmitting
 retransmited||retransmitted
 retreived||retrieved
 retreive||retrieve
@@ -1553,6 +1559,11 @@ tranasction||transaction
 tranceiver||transceiver
 tranfer||transfer
 tranmission||transmission
+tranmissions||transmissions
+tranmit||transmit
+tranmits||transmits
+tranmitted||transmitted
+tranmitting||transmitting
 transcevier||transceiver
 transciever||transceiver
 transferd||transferred
-- 
2.38.1

