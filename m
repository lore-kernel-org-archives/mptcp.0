Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D6256E
	for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 23:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674256289; x=1705792289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yBRdim4sGqZtI8PiMJj04A/Uc5lxttQoFVe1Rb3y+VU=;
  b=a1T3myMXsLI7vBDgIiohCcKRKZHct3ngpmbhs/FrZikD03VgsMYfpTMa
   uQI7d4YoLYZNm/BbTVdI6zDHa3IbdnXoM71m9Io6akVbZIzOA8b3Tleor
   vH9OjAHeD8l0J35etZJ3kA6PL/OYh7JUt5k6gfbUbBxk93MXsRRc1biYb
   c70l+P3g//0Qtfy6WPNcSyP8jbUdzAUGV0UrnNsPXt9geBjcTtzKE8CIc
   cict01Nzmz0xt2pC5ykGZu1uSilEBvHePj/KqvNJJByLFhulkQ+Sw7ydm
   1tguwkwUwNeCdH/3XiDSYBYRqZpEDG+RYIQgMk/foeMOFijW/oDNAAtoc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="305390600"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="305390600"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 15:11:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="691226118"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="691226118"
Received: from tnlabont-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.145.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 15:11:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net] MAINTAINERS: Update MPTCP maintainer list and CREDITS
Date: Fri, 20 Jan 2023 15:11:21 -0800
Message-Id: <20230120231121.36121-1-mathew.j.martineau@linux.intel.com>
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

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
index f8ef124a941b..fdc81ee6df1f 100644
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

