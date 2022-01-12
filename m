Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865B2CA7
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641982105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sPqZoCqGytl933MH9NW26uMTJ8Y522P/nTDsUlMx0E=;
	b=eYWARMbXYxn2W3igwKvB5bBWzazhC+1sO7KiTDlNTqIusXsnp4UaG+XS5lxXD2UUwQ1pWH
	WYG4iXjiG0/Q7zDuqk13NALXsat3f0SJFc3UnKuyhobnPC5E+Cyt5eVNOkMwEwmhcv7tlV
	EYtes0lDgAyhgMN3sYGlPOA+tvMEq1A=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-dnEQhzGJOg-SKTDdLyPy5g-1; Wed, 12 Jan 2022 11:08:24 +0100
X-MC-Unique: dnEQhzGJOg-SKTDdLyPy5g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkovtJt6f36W08aM4Kzcv5INiPbZqLP39MYLlCu92Dy5mcnIjj5S4n6SpSIJN+vhQfMeO2SbvtCYZEXjWdmKQv/MK2cwvcC/HpatUF+sQd5tI6A4LP4WTXBmI0tJhWKNveOm5RVRiSckLWfm1MFjY5/fTcWVOUloAQqyjR4u1Shd8XJEFSIsNg+JhaHN5GPKbOkRooBd0Nm/z8eRXdP1UunquzMsZ/MPTLyr7kykmsYhGSRC+ahFdCE8D3J9nII8dt7RF1xAQLLaHuZPpfbujQ7LDDpv6wAcLauf2dH8GgaSwyevAsP98soGQ/Q2yULYQhJqdc+TvJ04OuuLnxu7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqWN03yIJVG7vh1bOTsxSmWJrD1OCTIcqIVGrKhC5eU=;
 b=kod6iJnEe6S68tW+Yy2sWBLEowVOxSVevTA23FBheboee581bNpgQt9L5qC98T0/unrViALaTP5lKonxZFdGRlTuguQQ6faX6dUAaFKrcvs8YSjojVw6gCRKK96+5z2VCxyzmG8gsz0jPpZZnN8YHwcsGkW8FF/0qMqcmkftFddgBcaX1AMpJ3THVG3BP5v6Gxwt9nYpE0qRiYWw0BsFQ7fnHcYf1lCpxETmbTcNtHSQ8LFrTy/kHfMSXl8QhE2HSLv1BJNnrWVpDA0speJLIwnC/sVE9SFU9n9DyoGttUfW6Ek92ajV+fOGCw+WKxX8uJVmYZTNmSqyHlJdTIOtyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 10:08:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:08:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/6] selftests: mptcp: wrapper for showing endpoints
Date: Wed, 12 Jan 2022 18:07:33 +0800
Message-ID: <7648122b50bded5cff5aeacb15949dc41d6308c8.1641981669.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641981669.git.geliang.tang@suse.com>
References: <cover.1641981669.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7430e16-e818-4bd0-d5db-08d9d5b377cb
X-MS-TrafficTypeDiagnostic: DBBPR04MB7899:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB78995B54143F1839E419F31FF8529@DBBPR04MB7899.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SMYSfKp0vyxv5XvpVHYbphyJJieETKN7xubzu3hkT1ib+dScxbeBMaWzEzeKOiUlzWvIVfNEEDLBnenRtqSTF1+7BQRCyy9n5vB22B7jCRfw73ekH1QW0JcyGfReOlXlukXkT9KUEnk5MW5AsXS64iy/01bNg+oOJA+1Vm2lpsI7iNGBhmBHJHQbrm84/gHZ1jbfwqfZXcsUQ+NDNexyO6WVqHwr5+0AfMYHKZd53W8NuzS8GPu6kweQzQTF7xW3F0i3i5TM/1AFg1L+K974cao5VS2/6V6x3YpZHjdCQ96ONVQRJ0YyZeJoQqIkBtiOCxZJ5gcCZxHa4j7HjIz64GhJvwPc2gPBghKSCCk/E/qy8tUvj/MK/SXfP61J6BJIE9pi+gZix2HDb6AGV68G7d6BXV/EJt+CSnHDKo7CaK5iChOQF+D9DfHYDi5VfgqXPgk1Ye6vDNaj9NTxTFcjx7BWi42jSj71fi9MnIRNDY/Cl7fp1lwlaqlKRVgh5LKmPPiwias/nocxHXBE24KbTkViajgKeKRnVYVTj1O4JY29Wve84ey4WNQUME/NZxLATibXuDivE6yDl1EhIvDGzNcNfzpB8qiedcy2fY41QXL5oy/Qa59btVJ3zbB4k6P1bwb0pI11ddEVEuZaVguWUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(6512007)(38100700002)(6486002)(316002)(6916009)(66476007)(508600001)(66556008)(2906002)(4326008)(186003)(44832011)(5660300002)(36756003)(107886003)(26005)(8936002)(6666004)(6506007)(55236004)(8676002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OXh7P+x0wPbNlQfFAM2pHyo9yc9QnO8u+sx1Bed1yJN/huRw0HRvxyo60yOt?=
 =?us-ascii?Q?Z47d+hdEbw6QppRnHbBOd1sRmKj4+u3b5TyyCnLqBmx3Vftneo8nzHmNDGxI?=
 =?us-ascii?Q?PWvBZvpcHgDEZT25NSb9j6fVg6k+RJQn67Jfwx8tXb6nE+t4Z7nnFslpDeoS?=
 =?us-ascii?Q?8c29Fsxry3x6aEOgwZTjMIkR0X5yhQwo03aGrjIKnC4BHLbjmjlLNOu3QL5Q?=
 =?us-ascii?Q?PZO3lSYXiPxKOLulQ9D/eApJJKXCfUEUl1sW2or743jN1Zt5H4wvoP5smLhM?=
 =?us-ascii?Q?g+CH1yDWbZY0RMJt1ugV0B2fQRJGk7L8lmz8bQvI5mROO85B3TUdaMiw1L3X?=
 =?us-ascii?Q?wxlg0AHkUTqj2Yw2L/+g+IscPQQWwYnAnWphBMIaQHaWb6akAc4RzCZK0+es?=
 =?us-ascii?Q?NxCOAXZPECN6QqGiUYTbqb8JmUSDUJ8mnAubDaUYwy5uAUOu+LhCH6wlnDKF?=
 =?us-ascii?Q?HjpeAZ6tjhzASqLbbHgLNUhaQkMpBLv/cOCIPM4TAemTs8Y+QYpBDI26WCRO?=
 =?us-ascii?Q?iJP3OZerDory3j+4QvEpuxnEUV9G6ILxVOzwK/9AeFrsIeB3vf2tL+8rsZDK?=
 =?us-ascii?Q?lHVGVjGNp9/r4vEO4724rcPbYQC+zZuUaGxnoltp4yYYGjOppLU7suOZF0DO?=
 =?us-ascii?Q?SNYTycfUUZYkLYcMXcQJJH+g/NgCC7N4gN1gJ5p8X0izYDDWTXCP+taOTHFx?=
 =?us-ascii?Q?BlJvd/iZs5zski+AE1wqoShRxNWN0fs8BdzLkizAHoO2dzuwQrjuPwjR3ceA?=
 =?us-ascii?Q?gIpaZ65n2ngQcofnExORazw1pAbqBl79DLoGDBRA8pPWmlnTf/eGGcjjKMhW?=
 =?us-ascii?Q?WCNjP+DQ9juvmHdAdHA9DirXVLXrJkmQtIRDL37jCqYuMRpw4W4jAhy0TtU/?=
 =?us-ascii?Q?mHljrpsWMuQSd2wp5Ogj9u/aOsorh8se9xCfHz2cG/TNeoIlOKJ3f/WMaWsO?=
 =?us-ascii?Q?7h9rUynEGIl1VDq3X2WRDl2hCxMNuZFYL4KaSq2VrR+0vXXwc9xcv7rtwcCI?=
 =?us-ascii?Q?MvPRi2JiH7T0gdhUvjBrHOSKlAn33rdGvMTW0fCZwU1Rm5V2ypfyDP7UNySm?=
 =?us-ascii?Q?vdcek9ABLjlFCrPDgF9cUgWGGCt7j7xuV6CwWV+ZecWdoHRRuvXOh7WJ/EIw?=
 =?us-ascii?Q?pctMcpHIPeVg15VVUf7+Adi0rmLfFvrqo78T3LCzIg/zz+XgMj2HnhnZL/xx?=
 =?us-ascii?Q?RUqfUvRMGPvDMudjKI8UL8Z4IvtC38Qh1eTW80s/W66b4V7bV9Z7n35pOfkK?=
 =?us-ascii?Q?VYvcadmulSDGkY0PRFUqybgABRm7J0xl5nVywNXrWblhsB80GSJaRZCLvLot?=
 =?us-ascii?Q?ZGb7XDFTmMFSgSJrrJoTlTBoznE3B49JtBEKiE+wepQ/G+FZ8tb4SfgUsOSR?=
 =?us-ascii?Q?P5DPm8w3R5IfINX1Kczq59+ODbiM9UP91OIK8UUbqcn840p4DBmMOaToHV87?=
 =?us-ascii?Q?ppGZuWaia8nYEGqj4XQmooVA+DigHEg2DukUkSCdLhDt6lnU9naJG9+A9shT?=
 =?us-ascii?Q?j6xuelRM0gi82izSrqhUeFrJhC6W281wzlkzlyzYolExkI7QEdfITSulqw2j?=
 =?us-ascii?Q?O/nxT+XSvPaKcDioqKtE1fUH5wCdpmCU4tpiYDM9QCMdcquVPj3+0gEagwOS?=
 =?us-ascii?Q?BmtmEOAxsxa9X2f2mGEUXsc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7430e16-e818-4bd0-d5db-08d9d5b377cb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:08:23.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0vR0fqrF2NU5S3cRorG4mcAOWrR3fJjOBDj7KMD2ly81N3CqnUnhi9FBHi61XhzQ5ah4B8iOG4RZ91pOrxyXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899

This patch implemented a new function named pm_nl_show_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to show all the PM
endpoints.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 086e0778a1fa..617f311057df 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -360,6 +360,17 @@ pm_nl_flush_endpoint()
 	fi
 }
=20
+pm_nl_show_endpoint()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint show
+	else
+		ip netns exec $ns ./pm_nl_ctl dump
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -468,7 +479,7 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint ${listener_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -521,7 +532,7 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint ${connector_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -557,7 +568,7 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint $netns | while read line; do
 				local arr=3D($line)
 				local addr
=20
--=20
2.31.1

