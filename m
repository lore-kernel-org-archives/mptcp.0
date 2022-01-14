Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A102C9D
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzGaSnx9oZh8iGnTdLmQbTh1iTDkBbR1taHTF8Y33HE=;
	b=cjwoNT0kzyY1BqMSrQeBPgfFHfk29cHCfyMXcbgMwXMn624Z80jz+7hUwPEbowxdTSJpAV
	dCTl+buJPBvBPs5ze6u1QZnNjXHR8cgCSGJhIs2lfAOkkM+GGvCXsGi+YA2Xh3JU6TKcWR
	v4lYr/pWBvVrnzsbaDm9WQ18lu7D/XI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-x2agCEOmOSOPWHVEWrVetA-1; Fri, 14 Jan 2022 11:27:28 +0100
X-MC-Unique: x2agCEOmOSOPWHVEWrVetA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLydUsf4y2Jy2iD2SaHF4aaTM+VPnMeTtXvyPljbIK2cSZm+ow4gOwciqWuk95r7OMht0sY760Aa6jMLJR80nnoWkS8AXc51WwgAkUI1HtcNE0VAtWC71vv1ILcnZXadcYV7nvpuHOYlpjlh6vPttUlPbjEGT9sW9Z96HOQcYyzGSjN7fpIfDbBdjLHFv4ynQZSqHYyvyKlGjrgZJ4hxOGJFW+p2y6BJstYE8jUlq7iju9FeRp6YZklesoZeegt/bEJWBXdNojU9tYaY0jkU1fkU0toIlFWazwqXA7qjz+F++Wtz/LYrUJfRfsL0uzOA/L/rmp+gBLErrJ3tbcotow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh82OVGH7wOlGCOopRacbZhPVBwjGhytlm/dP/EGTPo=;
 b=Aw5ygItW6O9Gq29wM3X8ubKVeFj8XGVqZ9GlMeITL8rNQsRiVi43dzOr1yoVFHEIdds9EiXTjewZMsEZCf1X7SYNZHkZGFCaWnjnElWhEoMBRHTQDu5ORMihRQassmxrp5yX4jFwzqt8xbaXfIBzHxmKofYGOGY4i77QkyjSlHQNXVfVWjiTtYXVmslw7IGspuYQJZsfq1qw/C+2B3kBvCmDp6jkBOjMd4I2C7juxdAI/M7ArHKa+o9YUv+t8Zh+zn/+QkjKJKfS+xwHVJPI86F4iJhJfDSLTDyoUiZ6THr0fX8uFb4IUm597+rAPkxQU6gABNVuYqv1ZHz8YnsxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4317.eurprd04.prod.outlook.com (2603:10a6:803:3f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:27:27 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 06/11] selftests: mptcp: add backup with port testcase
Date: Fri, 14 Jan 2022 18:26:25 +0800
Message-ID: <b91d86de18d38ae64a54d65b4664dc88779b04f7.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:203:b0::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2ac121f-d9bc-428a-12cb-08d9d7487674
X-MS-TrafficTypeDiagnostic: VI1PR04MB4317:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB431785F55ED9AABF7275A66BF8549@VI1PR04MB4317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qVoBIpNC9KfTHqYkCrLL3H26rlbKhNLWHeti+kanRF32QlNd66LEHPAQhmTebpAGYNpVnSvJGYSyLzoDqMC90MDR/tkIUpOMu9S9yUS9oxKFVO7jSFD2xFTyYXURUCvdIsAt/tLUt69/9uumaHU2ewxrCHwXM+I5itZR2nkA7iHADFcOBKu37aMV6qMc3G4uIdbBv3RyCrPraMeRDhO3z48MYyr6av346kfov7UFEingqtSa+xtl+XbFZpfNTpM34AGfuamnNQlQVniDHdTkIYhhi/NGZz4NcMPPoCj3L2Fw7gTWhZ1b736oVRiK49knfvC2Gx5M1YubrH9BV3hzOu68bnVwXU4t0z5mfHhIZiv0SwNbC64bZhcCUzkWx0OfC51+5/nNJsY7wFkk/woLda5yIThjCMyoGOhpDHF/unubuNNUGSzuT8scYJTdGk+DNa+6eokcpelAtpoYC6OLNooJksS5lR8soiTM8Y8z/UYfZFpakyGqDoRth3FWpI5GY2oGILzEzOpt1uSRps64teIO6fm97HCx/P6Ouils5h0Bl351tmHmHRG1vAbMNNypr6Ys4o+EL9g9yk6hVenjGzlG7KbPb+aF4ttV7MzT4+wQJV9PnvByC0J4T5J4mcdX7pfmvEPW33/iEzVyD4tr7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(55236004)(66946007)(508600001)(8936002)(6512007)(6506007)(26005)(2906002)(107886003)(83380400001)(66476007)(5660300002)(36756003)(8676002)(186003)(38100700002)(6486002)(6916009)(2616005)(4326008)(66556008)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMHlFSwyvHE/JnXGog3ij4O7AxTAOIN6ksNUDSQNMyfjECup2z1TLQ5nkNss?=
 =?us-ascii?Q?ETyk8AH5+K+0wQcVOCxpV1D/kjbJxb9GTclHLTAyN9X4hsYkQPhxoOB/kOMO?=
 =?us-ascii?Q?hxVoWcJ09vqI1nimiSk8T8FN7BQlPx7UcVl3qiJqZGWeRrloiXgKxBdyxUk+?=
 =?us-ascii?Q?M2n0XUxqAFGfJVT1zVeX9YZW/OPKKbgi5Hhsv8+Z/PJVs1DljWvtck63GT20?=
 =?us-ascii?Q?W1etZ6lkMarzT3Ncg4ACpVzzVVVMlLF6VqYd18ACmBpU4UwbJRYEdOHGLldN?=
 =?us-ascii?Q?QQoISq/c2yPCABLtrxQSDa7ClyhBt8nRgwxTlgbYVTRiR1hjq9GavYGPUDzw?=
 =?us-ascii?Q?g6aoHe09CCe0+uRJWEkanCgBDvoKuYxhju1xhtB05dPioWlC3haDvQhO/Dfm?=
 =?us-ascii?Q?9NYoa0a7LQ1AwVB4Z6Al/MjU6kx0suS7X90Wzr1ObddvBQk978fDzNvtHLBc?=
 =?us-ascii?Q?ppRE2HYzqwUY9n2rk8X3IKKWs8ktl82Xew9T04ArdJ0R7cRt/ZbjP8xhyVq7?=
 =?us-ascii?Q?qbdHu7hnrYYmwGZ/ziamVTtj0rZVs9A+w1lp949kpH8QPEerkm1c2GxOMvUQ?=
 =?us-ascii?Q?xY/y2P82e7xNac2sCKnACydxhvY2Hs+O2fGlFav9WxlJy4eWeskLqCB83LlO?=
 =?us-ascii?Q?xRcyjA8EMjwWYHQ0ECXcZda1YkNCouamaHN/YLUZIqV8hutIm2Z4cJ6nSbVJ?=
 =?us-ascii?Q?p8hZzoY7dJNs2XhMREyL5mEjfQDBF+3goNywPv8QA2rbnQ4+OrRuYuJRxqW6?=
 =?us-ascii?Q?0dEmqqcbOGIOMnlixKePC95Z3jJfPrXSpXez4c+avVBCUOEniwHfVfFjFGJb?=
 =?us-ascii?Q?Ss9D1gwJvqHOCGKLc282YxaHdFnme+3yzYr9J2pYb81VOmAfd4pggaKqnhaC?=
 =?us-ascii?Q?fIHVQ6vy2tHg/bDIvpnL4h/NnUy9EeLcb0+lPraGDb2n4FG5mhWBqhFi8Tjf?=
 =?us-ascii?Q?ItuF2g7eByfUDazNUUowzlMfH6lVGnkn5ne1tC0Na80OTXNfE1GHcj127WVt?=
 =?us-ascii?Q?xtCg8SGcLvB5hVg2QKOmfdDKH5gVhxoZh5PlbHXnTEqGCHXIN4r6PPs8Vzpv?=
 =?us-ascii?Q?HaBEpWVZY+iZOhekQE/5TX82Z5YW6fB7UExQPgASTQZu5TnptAwos4e/OU7q?=
 =?us-ascii?Q?kCdxq8+7VDGfZ/dJSSsewIrFt2nYVnNOw/3tk7tRQR46qQOppsSEbCdqtsNu?=
 =?us-ascii?Q?A2Q7k33BI4RIQHX+nNw9Z5GrAa9/BO4euw3oGbr+JYBmh0YP6a5cfTPeuFA+?=
 =?us-ascii?Q?fY/OPWRHWSLN/Qv+FxViD6uSww26fZIa6yZYnPvT+18LVLTALI075X+02zex?=
 =?us-ascii?Q?VkwDKVNuYcDdpisaA+WpJ7FgRWzdqPUC81S2LEK9aPJGBm/ogndBEEcjRc6p?=
 =?us-ascii?Q?bsQyfsylgceL5Rmv8C7Hp5daVKEBqdCXdL53eUPC1NLRNpgyyWYP+b4uyL8Z?=
 =?us-ascii?Q?2GWQbQnyqWogHLUZ7fCiX4eeR8iLLMoBQKTiw4FB76tB1ffL7I4fPi4pDIZJ?=
 =?us-ascii?Q?d0gmFI6d4Xl4147frukLyMxF+YjiKdyR81eXRtXaCmseao27FfiJ5O2HUAtB?=
 =?us-ascii?Q?rP4NhH1dp+ci7hwrTFrrAlFrNiAj+1xVOGOHJryGCjEDInu8sNNNE2MV1jUg?=
 =?us-ascii?Q?mHynzjYLcVSt9DjU8+Pv6Hw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ac121f-d9bc-428a-12cb-08d9d7487674
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:27.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdEhpAZBcvV9ORElHKMJVZH0jKmc5XonmclEWuxWfDz9BCSyLgShrGI4i7s+YG8S1SoUQzO1YiXficMglBGwFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317

This patch added the backup testcase using an address with a port number.

The original backup tests only work for the output of 'pm_nl_ctl dump'
without the port number. It chooses the last item in the dump to parse
the address in it, and in this case, the address is showed at the end
of the item.

But it dosen't work for the dump with the port number, in this case, the
port number is showed at the end of the item, not the address.

This patch implemented a more flexible approach to get the address and
the port number from the dump to fit for the port number case.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8286ef2f76d6..e918e3151c32 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -240,6 +240,16 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
=20
+is_addr()
+{
+	[ -z "${1##*[.:]*}" ]
+}
+
+is_number()
+{
+	[[ $1 =3D=3D ?(-)+([0-9]) ]]
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -465,11 +475,25 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
-			fi
+			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local addr
+				local port=3D0
+				local _port=3D""
+
+				for i in ${arr[@]}; do
+					if is_addr $i; then
+						addr=3D$i
+					elif is_number $i; then
+						# The minimum expected port number is 10000
+						if [ $i -gt 10000 ]; then
+							port=3D$i
+						fi
+					fi
+				done
+				[ ! -z $port ]; _port=3D"port $port"
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+			done
 		done
 	fi
=20
@@ -1652,6 +1676,17 @@ backup_tests()
 	chk_add_nr 1 1
 	chk_prio_nr 1 0
 	chk_rm_nr 0 0
+
+	# single address with port, backup
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+	chk_join_nr "single address with port, backup" 1 1 1
+	chk_add_nr 1 1
+	chk_prio_nr 1 0
+	chk_rm_nr 0 0
 }
=20
 add_addr_ports_tests()
--=20
2.31.1

