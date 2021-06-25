Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898716D10
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 09:24:49 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 407271A2722;
	Fri, 25 Jun 2021 11:24:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 058BF1A271F;
	Fri, 25 Jun 2021 11:24:48 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F2E83183AC99;
	Fri, 25 Jun 2021 17:24:45 +0800 (+08)
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
Subject: [net-next, v4, 11/11] MAINTAINERS: add entry for PTP virtual clock driver
Date: Fri, 25 Jun 2021 17:35:13 +0800
Message-Id: <20210625093513.38524-12-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625093513.38524-1-yangbo.lu@nxp.com>
References: <20210625093513.38524-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Add entry for PTP virtual clock driver.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v3:
	- Added this patch.
Changes for v4:
	- None.
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc375fda89d0..8afd96d4d194 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14847,6 +14847,13 @@ F:	drivers/net/phy/dp83640*
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

