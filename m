Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60E2C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641985041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LClAuRIUQ8XTH5mJ5scAwS7JtrI3VQpxQF4g4KgfVYE=;
	b=DaUefov5/nc9UzTnqtRvhiQljZx5FHyU7TiGRm6qB2cnSyumleI7KSjsrNBoweB56rXIkM
	zMQsea8TJK/5zJ868yC3Xwy2T+SKWVtqfzfUeZiRY4p8Hi3/9h5/lJ5NF2pfqSYxpUcVa+
	wNKEVWmDVoBZyfdV2OdSIX3USb/LYR0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-kcXslyfLPjaVTQ8ZX-rDxw-1; Wed, 12 Jan 2022 11:57:20 +0100
X-MC-Unique: kcXslyfLPjaVTQ8ZX-rDxw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ0yYbUJZolMvg3TUQ2j7iSIWR8yBoLzUcXdsMmGutFXQM/iLypTS/pfyx+tNX/h+4Fh6Yjb8B95PfStHdkkIlECEdVqi1Cenvh8fR0quM9u+DoInZtqs+5aC6S3Qm2Htq2v9MZ7o0Y7oSsKa4TCWCv9dHMXKoxhq+KF2cmj07qpzVy2wIyB0JRQMnzGeBcJp4UJOAHfSO+Gzx+YXelBbfPzxI8gDy1BvtLwJ+WADtmP5zyaP68gPpTJPBC8Hmpfz9a4FJ1lT1JYBociVdeTl7ES46eyYRwegsrLAJKh6JLRgQVxO2ajSSL4axD7b4GzQIpfcfUFpCNO/8jde0bUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOCJ8f79CDcijMb1nzH7KJv0EJDutxZmERxVGoGPbJw=;
 b=HNLFcdSrgjKI0sjgHVE8BADdnAgi8vksyBH02mrUivDKHxqFX++n1x4NUPumOeZB3ss2DgYcdtqbK8eBX/8WEDlZWWDUPf7t4DLXYmPP6WrvwC2LltwtGgEtoFk/0WlT9z3amHKqsztEp7mq3hri9vhyXZCkaypovEG5V5M4xd0qEBs5FFcywYwt8t9/9KYxfNv9D5I3eniUh2nydxsKP1f3noXi70yK6PTSOd7OVBKdqtPpRkYl8kbs/Sd7mekNStIl7Qwj0w3daLimUkr4y2JEkn/0T/VNsgf+hpJXO7xIAsAsj9va8rPd8ilvarn53jqdESyfhaiZgDCnJPAB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3483.eurprd04.prod.outlook.com (2603:10a6:7:8a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 10:57:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:57:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v3 4/6] selftests: mptcp: add wrapper for showing addrs
Date: Wed, 12 Jan 2022 18:56:44 +0800
Message-ID: <02de998a170d83a5170aa4e3c96084a0fc4696d0.1641984855.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641984855.git.geliang.tang@suse.com>
References: <cover.1641984855.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0174.apcprd02.prod.outlook.com
 (2603:1096:201:1f::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b01f2fe-6027-4c24-2d5b-08d9d5ba4dce
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3483:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB348308347D17CCB17228465CF8529@HE1PR0402MB3483.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CjgdoABlQeL/1X33Yzql5QezRAPPpvOrXMT6A2kwtw7kG5V7YnUYYjWmYKdRXCpAU6XiaLHu8JfkHztzlOl67hpCfCitPc+yv2unklYFR7Oyi8qf/ZOsVILtCEo8FUs7QFQzIteOuYgmCSoyFBsBXzPv4TpltMBeVWkvN4dc+Ia+iOQlcs/0VDVAidxdhyWXl6BBGpWzjzveTrFAPPf4lHcEss/wkq50bgI570hs613eVEQeU83BwBtSPdakCSApp2FaJFTJBZwBAYkHPlVBhJF8LqQVV3ATV7rE79Jq8+AOqiQtc1gK8YH7Bp+bbzthr/XcsUvdxmYjpf2TqovNZKdyXgypcMohtrvXDg0vUg3SWQHsXo/iFmBn1ZuyXMe46YkejqBZjaRhvCBvp4+37bafc4Y6rmcszbKFQumOFSZjU1xgH2ydtLNOWldRq8OAUbsM6+dOKGeANoQX1XSDkGmAPtI3PUDA6LhR8WgjTawvvV4LWnU65ymqwn9HfWCKymlmgcwITOOhiDUzv+0YIazu1R3RW+3pufcynJx0aFBAyJCzGIloKYyEp0dfy22OLS15iO/bek5QA9N3tEaQeE2FBsGvMm78yGCzVaAifGdXH3+DsClbVvHPoDyhKG02TxJltc2qkHnVzWbpRHb7Kg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(8936002)(6506007)(107886003)(6916009)(8676002)(36756003)(38100700002)(5660300002)(6666004)(4326008)(186003)(26005)(508600001)(44832011)(83380400001)(2906002)(86362001)(66476007)(316002)(66946007)(6486002)(66556008)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0zyaLSBRyh3rd/MVNlDoa0UalSv/JD2nFx1vsje2OD4gA10n5vzn8sPJZkM?=
 =?us-ascii?Q?l1BVn/S3ywc5ypa1ikvSqwPWHAV3aykJG+CEJHmYY0ZyLi3Bj4O5+6f408XL?=
 =?us-ascii?Q?xdxEACZWWU0VF6KXCTzEAeyT4rqlye7iji2MKuIPmLGoJF/9xoH3+53iih6h?=
 =?us-ascii?Q?ES/R9EvcMMa6VXZqGIuIRi/Lyq3a2Qci4JWS/Bn2pCWCDZuF2yPjjentuC2v?=
 =?us-ascii?Q?TV7DOUisLt7VFjfLBIQ+pl1XICeDcPKfr9TdGkJipFOiz7fq06TQVW26yNox?=
 =?us-ascii?Q?PCxVgAiBLxRkUBXd2R8CT85YRw+44/o7Ylrm0vAGtYx2rTRF9HCJvOELGGi2?=
 =?us-ascii?Q?ppKOK6QbhZ/guBURFxUg3IKMu9bLrLKFP7FHsN9NyHBK3UQADPf2oHl5Wq5f?=
 =?us-ascii?Q?vYIjTCu1lZQ4V/1IBmUynvPxIIh3l0qy5d+Um8HuLtkWOJWYYXxKu00/4Cmp?=
 =?us-ascii?Q?56bNuz66WUK7dXzXMw7lSQqld4QwEZQ5mvLcTxb2niKpoBgNnBnc2sysmbWb?=
 =?us-ascii?Q?nGXeoJl3CFa+DQD3pCt3NPgi2a3znhog+YKIkpAf4qvKkPEj5n+rXS74hk2X?=
 =?us-ascii?Q?BLMqRoPF8CGaSYTSgsUqgVy43M3X82UvbIAPjEVGUtfa3eIWWTeB+rVnbKZL?=
 =?us-ascii?Q?hxscu9BF6IsNs43fc+TUVBmFqci4AK7pH2shxDKrpGV5zKyppuIh+vUIp4f0?=
 =?us-ascii?Q?9/uk/emT9z7spzFqy0DSAFl2kEYRPsRrnACLJ1Ltu37FvoAmkbpphX/uiE/E?=
 =?us-ascii?Q?yQSjp/zMpq7ynR6brD4JuxCsQqvM2AGjwALzmXtYPQfJP3cSWUe/6/2iNEfv?=
 =?us-ascii?Q?cHmGtiDkFfshWHiuLcMngSqU9bmBY+qxbA8czj2Y1RWsP/WsTjUqoxDyYEhZ?=
 =?us-ascii?Q?nx61Ie89rJbFvj6b1gYQpYuG1837YWN5uRPjiXMIcOAI+tNe7NLWe7zQO+30?=
 =?us-ascii?Q?xYPxrB2nHTpZT6R/+ooRUyRq9B7NS2lH7NvfGbLCCkSwamdPVjMQMlLSXMw7?=
 =?us-ascii?Q?9lU3+nrUqjW+ClhDaU/WBFwzSeFr9Yv1EVBvwnHpYk0j0J2lHpbU3WBz0ZRf?=
 =?us-ascii?Q?UxC1DkfYNE+B55mtGrdRyiefWkgRaOroa0S0/yzZQC533NIS17swGwaieg9P?=
 =?us-ascii?Q?FHwgvPNlCpxgRnVuAjuIA8Xki02NwWGUlRHsZkE7Kej9c6oPL/2/EW6GU9Qj?=
 =?us-ascii?Q?lFeUVM4naKKKmRLnoHFXo6tcFDKNtCBkLT9gze/M7dEhmjhEBGmzwb7Rzt/G?=
 =?us-ascii?Q?MqMUE7yBgvWHicUGTEroVwEWfPfXeSxtyowibDVN9/A5EiA18DBjFCjiHQCE?=
 =?us-ascii?Q?M0PN+2XP8QgN/cgzybmz4ymAmQ9hKjjMxogg6NLKskPM7sTdMXC69SwzhA6d?=
 =?us-ascii?Q?/p+t8dbeEoFhwzyFQIf2idmvKl01Af3LrcDhnGtERBZYzo361+OTSiezy+ct?=
 =?us-ascii?Q?mAvV8pD8LAt4lh7CAetDi+6HhiwjnU8f+fFJy8O+6mT+o/4OGWqStuq36Gp9?=
 =?us-ascii?Q?pcj23s4m33xZbugc/9/uJ8utDyd9bhhrAxdAuWKu9LaDTSzd4HQuKEnFqV7T?=
 =?us-ascii?Q?1oCu5ZZ3olWAX97pGIVvcImFZQHi1H+pHZTdtBwjmM8yL/kymT5CNaE9bToB?=
 =?us-ascii?Q?0V6ACjoFtv/jTR5xOGtfEFs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b01f2fe-6027-4c24-2d5b-08d9d5ba4dce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:57:19.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1isnUOyW9hAxEy6hlUFUuPIZbapxIhCqcuumg2Z8ZpdXS/J+AFDMiiEtKr0zr7Kff5TgS7RpeTJttREvErItqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3483

This patch implemented a new function named pm_nl_show_endpoints(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to show all the PM
endpoints.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl commands
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 086e0778a1fa..66f430d6300f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -360,6 +360,17 @@ pm_nl_flush_endpoint()
 	fi
 }
=20
+pm_nl_show_endpoints()
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
+			pm_nl_show_endpoints ${listener_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -521,7 +532,7 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints ${connector_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -557,7 +568,7 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints $netns | while read line; do
 				local arr=3D($line)
 				local addr
=20
--=20
2.31.1

