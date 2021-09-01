Received: from mail-m17644.qiye.163.com (mail-m17644.qiye.163.com [59.111.176.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0333FC3
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 03:07:27 +0000 (UTC)
Received: from wanjb-virtual-machine.localdomain (unknown [58.213.83.158])
	by mail-m17644.qiye.163.com (Hmail) with ESMTPA id AF8CD3200D6;
	Wed,  1 Sep 2021 11:07:24 +0800 (CST)
From: Wan Jiabing <wanjiabing@vivo.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kael_w@yeah.net,
	Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] [v2] mptcp: Fix duplicated argument in protocol.h
Date: Wed,  1 Sep 2021 11:06:56 +0800
Message-Id: <20210901030656.7383-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
	kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNCSE1WT0tIQkMZHR9DTR
	hJVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6FDo6FT8BSEguCAFJSRYo
	OQ8aCQFVSlVKTUhLT01OTU9OSEhKVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlO
	Q1VJSkhVQ0hVSk5DWVdZCAFZQUlKSEw3Bg++
X-HM-Tid: 0a7b9f53595ed99akuwsaf8cd3200d6

Fix the following coccicheck warning:
./net/mptcp/protocol.h:36:50-73: duplicated argument to & or |

The OPTION_MPTCP_MPJ_SYNACK here is duplicate.
Here should be OPTION_MPTCP_MPJ_ACK.

Fixes: 74c7dfbee3e18 ("mptcp: consolidate in_opt sub-options fields in
a bitmask")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Add a Fixes-tag.
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d7aba1c4dc48..64c9a30e0871 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -34,7 +34,7 @@
 #define OPTIONS_MPTCP_MPC	(OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK | \
 				 OPTION_MPTCP_MPC_ACK)
 #define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_SYNACK | \
-				 OPTION_MPTCP_MPJ_SYNACK)
+				 OPTION_MPTCP_MPJ_ACK)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
-- 
2.25.1

