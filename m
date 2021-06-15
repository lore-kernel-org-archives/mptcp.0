Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8226D00
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 09:36:52 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 305C41A0466;
	Tue, 15 Jun 2021 11:36:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15BA81A29CD;
	Tue, 15 Jun 2021 11:36:45 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
	by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5660440310;
	Tue, 15 Jun 2021 17:36:37 +0800 (+08)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Shuah Khan <shuah@kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rui Sousa <rui.sousa@nxp.com>,
	Sebastien Laveze <sebastien.laveze@nxp.com>
Subject: [net-next, v3, 10/10] MAINTAINERS: add entry for PTP virtual clock driver
Date: Tue, 15 Jun 2021 17:45:17 +0800
Message-Id: <20210615094517.48752-11-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615094517.48752-1-yangbo.lu@nxp.com>
References: <20210615094517.48752-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Add entry for PTP virtual clock driver.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v3:
	- Added this patch.
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 183cc61e2dc0..537f9f19dfa8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14841,6 +14841,13 @@ F:	drivers/net/phy/dp83640*
 F:	drivers/ptp/*
 F:	include/linux/ptp_cl*
 
+PTP VIRTUAL CLOCK SUPPORT
+M:	Yangbo Lu <yangbo.lu@nxp.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/ptp/ptp_vclock.c
+F:	net/ethtool/phc_vclocks.c
+
 PTRACE SUPPORT
 M:	Oleg Nesterov <oleg@redhat.com>
 S:	Maintained
-- 
2.25.1

