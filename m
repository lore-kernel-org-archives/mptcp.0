Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4642CA1
	for <mptcp@lists.linux.dev>; Sat,  5 Feb 2022 00:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644019425; x=1675555425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4q4YJ1139GLMhZaBm3mNqmEee0PPkjJBBZa0mJPWIUE=;
  b=aCkPPypK2Plh8XXlQ5AlObuaQCtY5lXoUqAQ2DTnV/KBJ3mNOJhuJ5Ki
   Rv77cRdEraTlv6qs+xghq5cfO6jwRicmaReqQJPZlw9nrxdz8I9Zzl0xU
   n6uwE2oX1e+lgdK8sA4FvmHwLjOb03s3bPfM7gTvTbsgo7jWGdTLwi2w7
   goNSrsI2MO7Go8VlaZnIF/vt4b/BUqbqlG2+5K0OAFsnmFMELjoRP2Ikj
   yK7x6lJBF9aJiP2NgTFan+Kp5MuNfkqWC/9yqyPCq6RaLakY5CEgQR84A
   Wd82Sscd/1QrBDTREwnazb5o4eimG2UM0K/JDnwWZ7P0M0YMcxsbxsEmR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248678284"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248678284"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="770097515"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:03:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/9] selftests: mptcp: add the port argument for set_flags
Date: Fri,  4 Feb 2022 16:03:30 -0800
Message-Id: <20220205000337.187292-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
References: <20220205000337.187292-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch added the port argument for setting the address flags in
pm_nl_ctl.

Usage:

    pm_nl_ctl set 10.0.2.1 flags backup port 10100

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 152b84e44d69..2a57462764d0 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh]\n");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh] [port <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -721,6 +721,18 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 			rta->rta_len = RTA_LENGTH(4);
 			memcpy(RTA_DATA(rta), &flags, 4);
 			off += NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "port")) {
+			u_int16_t port;
+
+			if (++arg >= argc)
+				error(1, 0, " missing port value");
+
+			port = atoi(argv[arg]);
+			rta = (void *)(data + off);
+			rta->rta_type = MPTCP_PM_ADDR_ATTR_PORT;
+			rta->rta_len = RTA_LENGTH(2);
+			memcpy(RTA_DATA(rta), &port, 2);
+			off += NLMSG_ALIGN(rta->rta_len);
 		} else {
 			error(1, 0, "unknown keyword %s", argv[arg]);
 		}
-- 
2.35.1

