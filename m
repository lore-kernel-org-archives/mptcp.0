Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED13C078
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uacqQDoY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPwXASqF9yC7wNNaBpohgOfv/RhVpqiGxeFBjXVXGN3sosu76nRQFoiZziYD91OBhZifKSG1gtpiP3pL1DNjuiueGjcgSLKlG6aKWnwHsYvfsbSsdp+GMCYy2TAZQcy3B5eVzfyQ8zUJkGgDs4uiw9Er2t4Y8r2VcIxjkgb7Xnlghryqsd5qb0kC0VT2x+uL3qKvCrPvO0k1Owi0gexoSg9herPAPgA0Lin51NjcsLGM0qUkMNy51vg8Yc8poJPH0rsywWWICqexCQXNiuHexdlnjNn6wDXIHQcX1VLkTJU9fY20TmPA/VZnpgGBkXHUQh3BHue5l3rcJPVUU0kdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crNiTFpMjs7yAPN8QhN6HNu+J2Et+4KM+5JXUFciygI=;
 b=NWjfgGYseVrvkln8kvb+KmkGSKs3++F7e6FcZ1N1PEsxXfBYZ9KAvxm0aDCGqj+59AJ/v4PMowa1px8tye0Nu2JAM8C+bjCL0udORRkJjPb0wpiutThZhy7RTHtQ+I4kErKHHVUeDokUFMhp4MLjDAYokMy18OoeoVU+vGuGqn6RjW9xgeydrAQnmyTTZ/unC6rTXhyhUxi0n87+ukTMMv6/r2ZFGBjMYL2h99Bqu+XQMXOQ4yItZoKYhINEdKxyIqCfMS+NGWTukJVpq9TQFrPItynUg7g6aIRN1PA++XUvcWmZJGwKbcqMfkOD61mG/WmQIQKCFtRrZAiTSsUuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crNiTFpMjs7yAPN8QhN6HNu+J2Et+4KM+5JXUFciygI=;
 b=uacqQDoYEUcHORUjl6VdajNUSyfkWs+NsHSPY+dgn0AQo7FxFUtqfeAcueSnvKpkXLbADWkBtSokHFq3QKopAXEue3I386c3Yyyg+gZrgL6mPlHWhLFDWNLmSz+3N75Q3d+/cp+vCvkOyVKrrY984ueVESzgGySEiAnhmbv0ojolSExXGNTAuISeZcNuqBIfAalYsUsJ9ytdlHYvDNRfTRrWwnWYjJ9UNz+VlmbMD5t/Ru+NHqajmN9jKaXDx6Z5rDGFfTkSmYzbTtsT8/t8k2OqKtLhQWfMdW0eKzdvVRddNtrnFdomgO8NaY6SgEg/Ck2tQyI1kT2UDILnZA/4dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 09/28] selftests: mptcp: add mptcp_lib_cleanup
Date: Tue, 21 Nov 2023 17:52:32 +0800
Message-Id: <1fdeac5cb3c1c117af407a4b9e626b82b9405d89.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0357.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdeb031-b0e9-4ed6-4a17-08dbea77d959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k8hRHqMMevWM8kccoSxc0tybA7DKPUfa5XlhwJCfmyDQDCMo843pcNiz4pFPpRfsRgzOl0WwrcjeYmheavF3Auk9k+iz+DgApw+0SEXlDwer0HgSg8e7Di/D6Z6XC74a6FO+9ANANRnoSqte2FZ6ieyShXSA+mGZ4ao4/eZKGeY4WLChF043n+XblNVTiNYhHAjBwMM1Z8r4+SZBgb4yV+ie2M99xUiqghzvFrC3JhgoIQJPi4ydrK6Tzq3PVZb+4JFLLcL0Dj49kRIIwgQsjTa+TEgZhqh1sH2kDoJToP9LE9VzJAaCO6cXFIbBqGqLd3+JQvNS/TFrZlIaEax0+8A27SkW2OFSjuzP2OpCvYT605lIpaIDziaA3SUR4rL3iqUfzrw5RSc5+UNIDoWS9JAkoucSYHBspemIe0g7bXMuFNi5KvMUYI//nw/B/5eK1xcTgBubl2p9ueRKz/XSiTVLE8Jz43MN1vrDz7JOMg2+Cd7Kr94IMtsrWl/Ac36WTK+62OPgFarKIJerxVrz+N+SjHaGaiiYYDj3TGlwIa4sbVWE3Ag7Dx8H/r33LbZl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r/A79ktrOwmc0QZCr1EcTemoOuaXe4rTprB2DaNspWDJo4gehXzvNW98kiez?=
 =?us-ascii?Q?8/0Tcfx6cEXe8hK8woF103jkktHIF/6fKkWIanDmyoqMPb0YdnHNnV8WEPxa?=
 =?us-ascii?Q?j0fAMtVdyfukkZQcZPoRFwra4qZ22dQFSc7qJI12lV3O36SDZ4kTp6s+FfIm?=
 =?us-ascii?Q?Ky1rBc50KikY5LtkoEHjkT78rrXVGapL9BWI1yZ/8kvJlEYJBjpX2OXdjJ90?=
 =?us-ascii?Q?iD3pvWcz2zPIETCqdfR3dgBU7PgCeWtcKJ0nYz7406WMArHk80gIZmtU6oWi?=
 =?us-ascii?Q?GRAWcvqOg/PTChOEgM/GQv9jkzXOvLUltKPaZz8YXPgYFqHcRkq85QSjBlSV?=
 =?us-ascii?Q?agLx/azRe5XIwy8EAHa2I/iEsr0l8av6FKzVAWLmWXPfa9JKhWZAyYfu38ZB?=
 =?us-ascii?Q?UmRqHHRmrHtDaTlF7gdGz2RIaLignXtACS6M06WbX/w9l1GnvZvE1X/oIuQn?=
 =?us-ascii?Q?T7mRRttsSv6neRQH/xlAiY8xJjkJqaaFyz0R2vM+V1vn+DQgWO5Se2+94nrv?=
 =?us-ascii?Q?3NIVOsXzfTq3dudvW/D5VQXg9h2BU30HdCYRX1atNo3qqyRJIah2MRacXS7Y?=
 =?us-ascii?Q?OiA3VBn+jjqjuziAt3Wtt7MnSyXZAMGpaBInxdZ1hIHpEQD9MTrvExuW92Eq?=
 =?us-ascii?Q?l8wCFJjnvn17ilb0dpjMn5U7gx2KG/dy6+XSokKzlNLRgiNIQ1jO4tIjicBe?=
 =?us-ascii?Q?VlwCuVugHBsGUUKnef4cXMYRifHWmlFhJHhYwEx6kqxdbBtpqz/1hrjPh7aX?=
 =?us-ascii?Q?XcGMg6kDgBrSZ/hNxMmYGnAukff553dK5fPQwbjeh5yHG694w+r76b49deRO?=
 =?us-ascii?Q?ZryVuF5CweouK8w4lyYYnnYAzHCLKWvExiTsRCPmcA+nEesufAeuYTGC59k1?=
 =?us-ascii?Q?fiCBuE+z23GXvROkdDnZV/hFfx7pJjljvbp2eBI9uSICGNdnRb83K8T4kHX3?=
 =?us-ascii?Q?Da1HEpX36QDgN8yI3gDPVisQRfPO1VG9pkgMTxSnK5jCKPm4ihBey5PmZ7Y6?=
 =?us-ascii?Q?nZQyv2/vVkbAQ3SrUNIn9YJGG68dP+F+kHUB2PHOuglVbTADQQEp0bIQsXBF?=
 =?us-ascii?Q?vyHkNdwP/0AlVIFaPzeaUe20aQ+7djkDa4GkxP6chCDgcnbxdDdCiBzYn8E8?=
 =?us-ascii?Q?Vo8J1PJKjfDAllYv0xNhuiDm3iQ4hYbEG27WTAbAf32lN4HY2d6d+drokWiF?=
 =?us-ascii?Q?gZw3Jwo8oQPFryYi2WKytjpAJieuvta3gDzpmw+krMoLw/sCYM3sgNTZs0yQ?=
 =?us-ascii?Q?dZXIZEtFCvl0GjZcqRdtjSan2YlmAvENZJuwekHGvXdvCpC+rR6VmRraPhzb?=
 =?us-ascii?Q?ZZw4HYVhbmZvXdwkybZBjKmB2vQUKslrRLpvKj4TL4sd1DXP2omstHnfUfY3?=
 =?us-ascii?Q?nOUqi33h0UwxYCIOwAa7WjEiErmJuBoZwCA1SW9qijvIbWgR14J+wl5nbQ0l?=
 =?us-ascii?Q?OppwtuoqalOm6pHnNUv6db9ZckYyEByylVlyQJ/ayRrhJKNqosfwTNNdITbi?=
 =?us-ascii?Q?wy+N4KKW4HBPDuq7GPW3AlYVdHwTEAcx2/fI5tdnw2MuIbSB+DV3lFxA2fSi?=
 =?us-ascii?Q?5Ty3GD/Qm+D9wECxa3cbNGVfriynFQzyhvjm43Ft?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdeb031-b0e9-4ed6-4a17-08dbea77d959
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:27.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxOmqtBTb4nnjYdp4HuocwCyFt4J+pjxwbul8iWHJJBGWhTXtAAknUHCWvTVXewALR5i7yx5XWPZhSlD/3Pz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

This patch adds a new helper mptcp_lib_cleanup() in mptcp_lib.sh, it's
a public cleanup interface, being invoked in every cleanup() in all
scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 8 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..a678ee21973b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -31,6 +31,7 @@ cleanup()
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
 	ip netns del $ns
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..98f4e82789ba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -143,6 +143,7 @@ cleanup()
 		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 87590a43b50d..98b6814af0e5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -198,6 +198,7 @@ cleanup()
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
 	cleanup_partial
+	mptcp_lib_cleanup
 }
 
 print_title()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f8be9dd0e20..cbaa55ab89b1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -299,3 +299,8 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_cleanup()
+{
+	echo "cleanup"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..75d8c648f9de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -85,6 +85,7 @@ cleanup()
 	done
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..fd413b4c8123 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -34,6 +34,7 @@ cleanup()
 {
 	rm -f $err
 	ip netns del $ns1
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..436500c55e12 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -34,6 +34,7 @@ cleanup()
 	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns del $netns
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6167837f48e1..005251b61d7a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -129,6 +129,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
+	mptcp_lib_cleanup
 	_printf "Done\n"
 }
 
-- 
2.35.3

