Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0AC6D10
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 23:54:41 +0000 (UTC)
IronPort-SDR: eEIin6F4O/WT46Dd3Xqqadru3pM+uRWU/ZcvKI8KD3rnoae/DeQujcYOK1W8yxMFzFdyvZmlLS
 lT8t1xSaFxXw==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288450530"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="288450530"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:37 -0700
IronPort-SDR: 6zlaBs7OnzXOtPUtroLpW3oCwYu3cLoi/9g/GcNffQz6kIrh6FafmzZyvtCH0LFvMLKlnWsQxF
 Etat8Roz9h2g==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443774260"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.84.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:36 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 7/7] mptcp: restrict values of 'enabled' sysctl
Date: Thu, 27 May 2021 16:54:30 -0700
Message-Id: <20210527235430.183465-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
References: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

To avoid confusions, it seems better to parse this sysctl parameter as a
boolean. We use it as a boolean, no need to parse an integer and bring
confusions if we see a value different from 0 and 1, especially with
this parameter name: enabled.

It seems fine to do this modification because the default value is 1
(enabled). Then the only other interesting value to set is 0 (disabled).
All other values would not have changed the default behaviour.

Suggested-by: Florian Westphal <fw@strlen.de>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/networking/mptcp-sysctl.rst | 8 ++++----
 net/mptcp/ctrl.c                          | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 6af0196c4297..3b352e5f6300 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -7,13 +7,13 @@ MPTCP Sysfs variables
 /proc/sys/net/mptcp/* Variables
 ===============================
 
-enabled - INTEGER
+enabled - BOOLEAN
 	Control whether MPTCP sockets can be created.
 
-	MPTCP sockets can be created if the value is nonzero. This is
-	a per-namespace sysctl.
+	MPTCP sockets can be created if the value is 1. This is a
+	per-namespace sysctl.
 
-	Default: 1
+	Default: 1 (enabled)
 
 add_addr_timeout - INTEGER (seconds)
 	Set the timeout after which an ADD_ADDR control message will be
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index a3b15ed60b77..1ec4d36a39f0 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -21,7 +21,7 @@ struct mptcp_pernet {
 	struct ctl_table_header *ctl_table_hdr;
 #endif
 
-	int mptcp_enabled;
+	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
 };
 
@@ -50,12 +50,14 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
-		.maxlen = sizeof(int),
+		.maxlen = sizeof(u8),
 		.mode = 0644,
 		/* users with CAP_NET_ADMIN or root (not and) can change this
 		 * value, same as other sysctl or the 'net' tree.
 		 */
-		.proc_handler = proc_dointvec,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
 	},
 	{
 		.procname = "add_addr_timeout",
-- 
2.31.1

