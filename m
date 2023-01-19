Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E542F29
	for <mptcp@lists.linux.dev>; Thu, 19 Jan 2023 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674168264; x=1705704264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ViDWoMuzU+c9aQabLLq+FyDK35XeGBe9/4vSIYEA4+Y=;
  b=QBOrrtI08bFvezv63BzGR4foEJw6gOwoqwsXvFLH+tlbXw7oDqq9wA/L
   Du7JaIN6rADnIaX+EkGgH7Rh0+nYrCfdbd9JrxEXlILM+VlxeNNYl7nl9
   j+Ht55YZj0eY/CxdaH7riMXborY5/u+yzAMepMK4Vv84lbOfG6UCwKc/A
   BKpKD8HZoHrtlsWRmfXVymxagX12pNRhPP6tQ3gwGvZvG7sfzvawkt1ox
   CJWJv9XYnmk54XkCnRwhdTLKKhiQiia/Kkhdwdq6EBVFxkqz1zN6yJFyk
   RFueMKSoyJLdI9hwy42PN74lK/Xajnb8x8saGRj0Z6vuxGbDNpbeqk1FE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="411682711"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="411682711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:44:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749114439"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="749114439"
Received: from ticela-or-197.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.70.51])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:44:23 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-net] MAINTAINERS: Update MPTCP maintainer list and CREDITS
Date: Thu, 19 Jan 2023 14:44:11 -0800
Message-Id: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My responsibilities at Intel have changed, so I'm handing off exclusive
MPTCP subsystem maintainer duties to Matthieu. It has been a privilege
to see MPTCP through its initial upstreaming and first few years in the
upstream kernel!

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

Hi Matthieu -

Hoping you can tag this (not sure if signoff or Acked-by is best?)
before I send to netdev.

Thanks,

Mat


---
 CREDITS     | 7 +++++++
 MAINTAINERS | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 4e302a459ddf..acac06b6563e 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2489,6 +2489,13 @@ D: XF86_Mach8
 D: XF86_8514
 D: cfdisk (curses based disk partitioning program)
 
+N: Mat Martineau
+E: mat@martineau.name
+D: MPTCP subsystem co-maintainer 2020-2023
+D: Keyctl restricted keyring and Diffie-Hellman UAPI
+D: Bluetooth L2CAP ERTM mode and AMP
+S: USA
+
 N: John S. Marvin
 E: jsm@fc.hp.com
 D: PA-RISC port
diff --git a/MAINTAINERS b/MAINTAINERS
index 180c18f936b7..b166dec1ffc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14633,7 +14633,6 @@ F:	net/netfilter/xt_SECMARK.c
 F:	net/netlabel/
 
 NETWORKING [MPTCP]
-M:	Mat Martineau <mathew.j.martineau@linux.intel.com>
 M:	Matthieu Baerts <matthieu.baerts@tessares.net>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev
-- 
2.39.1

