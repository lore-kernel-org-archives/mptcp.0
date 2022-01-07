Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7D2C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hnXCrhJQNvXxN5iNvdVJ5AaZXhOHhxA8oH+OZlRq2U=;
	b=DUYHEAqBe3K2Dit1jXUUa/hYUOeyfyDgu3jwb1q1SOVJtXFxC4F/9MiK3fYvW9p7nfZODr
	pJG/4AjN0Vq3jNu6W1xATFhe8gjLqpfMut6mdv21xJrNAIUIT7adRxQIwxsivrAX7T1WIk
	nrT7Bmln4LStvKExFJhEfkg6fpg++xA=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-aOFhkZS2OEiEaNMx1uyiOA-1; Fri, 07 Jan 2022 06:52:47 +0100
X-MC-Unique: aOFhkZS2OEiEaNMx1uyiOA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7lvW1icSULEA82E04XrHzM7io1wXDimB8N5lMS4dt8f6A+7LBZBKrv8LMTL6WNgWl8imOsz7i9Xp/XPIWOpmg+eBghxtjCpfXXTic0gopZ1lyTvIrqKDLbIAmzUDHEYkl7wPyXYO4/QCebl33X8qbNnXvDLDkv0h8qkj/YaK2VWEOxwtEzi6MnWEoMLcx+N22ObHNmBcAbWLN5mjEy9t30bzRh7G8/8UHz+FxglVeOGjgXZ6b8jtk4xaUu5iCGSmizo0tnIOuiU+vazsccALYcVwZAx6iTHRRNSrOYPn4itpLMC1k0QCemcYlfZmFuuCiw5fnCxo7ELxBMLBuGxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o/6x5nG4MnZMKEvg0cVI8BGtyFmD0Yem5Fu3GAfjqQ=;
 b=i3VrnNnypofxSXZ2v0ohk+Er/+miXDDYhYmk7dbcPPeUZaR5a1rnWGFBkHi8ox1j/4OVdl+kD+0hGIVyPVdNgg/aKurtMo3G47X5sQlH8CbxRWOGSjzNXdqpJ/RcBRHuhb457P4fhuIXzeyHVcJXvCf4AEzs34jelprmC1bIKAFY9bbGiHU5cjnLyk6kfpbGBrZJbWLAn36wWtVXrhQGQUFwC/x0Mqo422z2halvZc87RRGuPtr3nVUgQI4Mc1z1l2ifOVkn7/W3NzElPjerwC3chGS+IwzOncuyRszgjrBD72hDGXRyUdL2g4h8Su0YurkHjm6dC4yUTU03zOThAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 7/9] selftests: mptcp: implement pm_nl_show_endpoint
Date: Fri,  7 Jan 2022 13:51:49 +0800
Message-ID: <2663a2bb82272c43ab1578d5f272f937bd225225.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:202:2e::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad32a1b3-84d9-44be-8cb7-08d9d1a1ee5d
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB273170F123C2156FBC050FECF84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h1BMd0Msb/9LJtypmcGMa/vRlaqVELqDkT5MgR+cLhKFfaBOXvj3Hev69a19azJ0fYT1OBcnw6FpiH0W+ZuirNlQdjTzmbArOg1Sqo+nhIpAvpAVn1XfdDVv0zlo3p6lL05tcTaQ1KdaKesw5Sk2b/1+Gf+BLZJbzw9eM12Yt4pUPvI18y7J3nh/5nuyo4/aIERzJFKcbLi5r+a1wx5VQodBoIykUWfje4c61Lt5ZOWD/9BH+601+frSkhVlC3o5ck9bSdyiLMwXVg3/dkzcWB5FjNyvXLN88Fn61JvKDE2DZ6g8sb8/l5uwQS+GLLckGB8Xot/m5p/d+lBTx7pOABB9ziw9YPj4Q8e7++sjaRPPrb46QgZzVSruUKbk4UrxSrMz6T+Y16VcytyAEkAjOwiddOElAPuVi2kPg740P2pw67qlRnjSECk76ayUQ0suaD6AFVZqe2hbmfCB8Bp2KYNUpKTz7d+oVX3ao9xEs/rOs9qp18KHTc7Oo7vDOUDbhW8UpzcTJQClF5sLAl8i4Ep87JJ0QyD0UJquboAWsqN2ckLJZGY/WjTH/117P05gCvUgT99nOkuVeZo54kCgdKnxekIDAW6gVHi+8HiUi47tRMh/Zi3dYqakyVxROvjB3CvpdjGYeC5EBp1S//ZsLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(55236004)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nT7CBSwF0DuaGj7mcrbd9t7WvTcy9zTSptAULFd4x5le/fmtEKQqff8YYMAc?=
 =?us-ascii?Q?+WLLERcZW+dTc3AgmPm29C/LNcpcH0RY1SS8vI3otFO4T8RIuXr06hs0pDsa?=
 =?us-ascii?Q?BuWmueL1C9v/6Tevw0rEl283Y2q7s3vdsCTWXHZY4Ui5efzBW84fOpAKMHY8?=
 =?us-ascii?Q?XkU+Cu+x+sURxJvULna1fWUVSrtapsv20kLfjZXw7hlhhyWrBTAKwIm/l09D?=
 =?us-ascii?Q?D67DQQ8cBemp19EknIArkxD5svsGvifRFqp4/LwZC/MBfa+R7Ah4qeT+4gQa?=
 =?us-ascii?Q?uulSdfTegnpHHlHb4ybSWdb0lwfuEVjNkgQFQSksX8yehRJBJW3BD+Kg+AXW?=
 =?us-ascii?Q?DPWQTjn1QvoCb+YZHEfNBVhJmgDaHMr1n9EfdTnC2nAoFOXntq6TTatnefZ8?=
 =?us-ascii?Q?jPByyRbaGqiqWGcYM00CAUk4t/MM6z5Xg1sUJFn9l7ppMnVh8mn2yPuLwfmF?=
 =?us-ascii?Q?03UIMZrKi4gQWA3xaeDNnPMUQAio0/eUKGXCxWocF9gixoO7XXGlVZU/gjix?=
 =?us-ascii?Q?i2w1wrNtiktoyDGgmejj7i+Ot6bL0IN9r8Hf5Y83+S2ImCLOvNbC8oFADUKW?=
 =?us-ascii?Q?RGVSIvOnpTVESJ2mF1HvlDRnb/G1UExU0Ok//smhSQhT+xIxyq7RCkypmWdz?=
 =?us-ascii?Q?1u07YH98AIDcRv/T2t1a2jfypmKe0PUjM8JTUw988mZFDQHhYEX6ksJdAv39?=
 =?us-ascii?Q?t3+dtC2qWfYvC1eQhrEhvPLFRdI/lSspXg/K67qrArkIZT6R7iC/lOAzZQVo?=
 =?us-ascii?Q?Y6gn4UIsUWopxAEDSV6M38+Lre0IOXwSe16YZPVlAOMaUJ+yWfd7phtj/foP?=
 =?us-ascii?Q?vJJRLocfNWeGo4orIzvbeVFTxopHOm4tTYFY6jpXqBxlKz8mWkiRfN8eo0Nr?=
 =?us-ascii?Q?jO3CaBk7aOcg/jbUXuM9zG/SoEsHpHulkBlEOhnpOFVt+MQlt3Lg5EJ3m3b6?=
 =?us-ascii?Q?b3A0YPZrohaHOoxOGEEGRp1vjI+NaUAdBl2m8Jl1Y8kaEpnhRIXdcZ1m7mD/?=
 =?us-ascii?Q?PJ8fKLeGriqEOk1ueSJOOjppzTzj550ai1AIxVLR7B3uoD0Zt4PTMx9HcfGj?=
 =?us-ascii?Q?e3BxxAY/fW+VIE5iqrLjhSkJ+kEBvFEc7vhe+rCmus++YSBWBsO/GxfvOb5x?=
 =?us-ascii?Q?NTeUcEJzqRilQcZwszOIvx88wCaBF5cLZc2CJZZikuwDxmtvM0NyFLh/h7fN?=
 =?us-ascii?Q?TWmgyM9xo3kXp1fgemu5PUhPObmY2uUgtMlf3W7MpWoOtCTpTrAF0iU11lUV?=
 =?us-ascii?Q?xEArsk/Xzkv3JThR3j+qr+TP6Es+wy+w/7EQT/DF1fcuurqw8sSmPmNo7qjW?=
 =?us-ascii?Q?CKM1QRSBtvYOcdzlt3SwFE3DxaRZhwacpFYSEzshGw/dROHtiVwhajROQbpQ?=
 =?us-ascii?Q?sCXlRkaoDZFwYcVwUujJWqiZXtRfzndbA+nvd4GV+9ENI8hxLJrdvums2NZG?=
 =?us-ascii?Q?9uZ0sZVIukog9LFj9pDk/HJEYXu8pVBO4qnIdsGOuspbvQt7E5hKhnvn4hej?=
 =?us-ascii?Q?SoSKts7/jUYxlZzYMqsjyumtLZJ6XX1yP2/l1V7Xcr5wc2DW2YYRNLbeNkGV?=
 =?us-ascii?Q?5Bt86QmlAT3XITfBLTnZYOpTNnhKzbIhsUEe184I0Amr3fFypQNQpyyZqF4C?=
 =?us-ascii?Q?/tquV7O0JLXYmGmwEq5rD4s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad32a1b3-84d9-44be-8cb7-08d9d1a1ee5d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:46.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzSwgX0W/EzG7fkBD+eDejtQYGcizkzR4/wFZpTcfPHVMTHqjTUt5pKbkvmK9aqV2OZupeFDdxYSNoVVtLb0qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

This patch implemented a new function named pm_nl_show_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to show all the PM endpoints=
.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 56f040722b5b..ce36205f2e0a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -363,6 +363,17 @@ pm_nl_flush_endpoint()
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
@@ -471,7 +482,7 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint ${listener_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -524,7 +535,7 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint ${connector_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -559,11 +570,15 @@ do_transfer()
 	if [ ! -z $bkup ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoint $netns | while read line; do
 				local arr=3D($line)
 				# 'pm_nl_ctl' shows the address at the end
 				let pos=3D${#arr[@]}-1
=20
+				# 'ip mptcp' shows the address at the front
+				if [ $ip_mptcp -eq 1 ]; then
+					pos=3D0
+				fi
 				addr=3D${arr[$pos]}
 				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
 			done
--=20
2.31.1

