Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018941388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmnNQ8I7yi53PgKS5AW9GSIuCr1OpR5vFPtKocG+LjE=;
	b=bC4qLxW15BBsMjYa9GFuyV28+8KwvMJZ+L9SUDk8alxzN8aJf6weL2TQozxA6wKoSDquXi
	L1Mi/ORLsxmL2RtVemW8a8mfC6F7y15KKUNk4pCO1J10EkOn1HLqlkgD9LPdrINviPkBUc
	GMUiYfnSk2KQfZBxYyJmFLfiYo6F1aM=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-KiG3JdsDPpeIUG0SsphsVg-1; Tue, 15 Feb 2022 12:12:17 +0100
X-MC-Unique: KiG3JdsDPpeIUG0SsphsVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfRb4ModvWwx/Q0uvLY4btTN/AmOk6YIUBCiz2v7ojnByN1IAkHhYeGuZUa8ynE89O69O1l70qfHJFz1OHtOu+ubPnhfCqXwxBmvhIN9XeAzK2QU+eV5YARTMkV5y11cFmoXCvw2iJ2tDUj4f74I1YMFziewI0tjGsswCbWrZQ1wCoMb0a20wO/L+2ZyGv+g5MuRAMhdjvkMSHEGIScdegEaYvkWe3AzxhEGaTRpoW7NORfuHqRTtjauHJhbLY6+oIyVmiKva8ym5tex9vtCDC6VnAN9OC2CQlUtpMPmu4IAVEa829MOUXJb03cmQd87PPmlcoGUG07aOMLAMec2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dlZ6mvFvziLhG+/zdShszurzWWe/RgE86pGllWpX8w=;
 b=M4vXhyhmyMOnUYxb1HHkW+Zu1juJh/3Gn0Dfzv7OrBeJVOPMqOZu356Lo4fCUqIw8wwB/ml+Bn5xHISBDQMMWBOmvO6FgbeeobhjmQesqJiq5IG/ld+rQ9xGs1nbcvs1KVpCIG9+KxM0VYQJHp1O9wEvwrFUZlSifs6JjxvPZYKHavW2XDDgeu/hxfsyRh0fiWfKSwxcfDAB5Ri8yo2KUHE8j+MR5zqp0U7HmfdIQnDTk7pczDxL6orpPHAjifUfSZg8Z7jEgF3BrETtBF7KeMsbMFviEdT/GnUWJpu3sHL6B67sDG+5JA+F9Y6L7L8a4L6fjCRMskgiFUdroJYQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:12:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/7] selftests: mptcp: add the MP_FASTCLOSE mibs check
Date: Tue, 15 Feb 2022 19:12:18 +0800
Message-ID: <57f50b740bdcc7ca145fff3f610f1a357072557a.1644923074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fbaabd-7156-4097-7bf2-08d9f0740661
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2921:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB292146CEBEF4884C0341AF55F8349@HE1PR0402MB2921.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3hCnnpk1ASn3/T1BSq4bAwQ3huBdphBZZdKEAjbKZwRJ/ETHV+SaVRAw0odd8z+QMIXUVIe+YUdYq60CrO6NQxlzXEJlb+08kcirW5gbJxs7+gtRFFSGMPfrCviLdo83ne/EOkjrLYa4vHczEjpZ/ekLhzp7PC9NUH7cAi5JJaynbkHcUPoWm0xEkWm+8hMgXWwGsssAIctGcBWUEi6bUPbtyV6yRpgmtTL+83s9jL3ZGGPNv4ZqlKUHUEVWMXNCNwFIuMHYMGbcoK+HV+UWA3+Amc70vZcnqE2G4NtSfIUC1cZQqeXHvA88Ojg7NTgxNlH9BCxxa557xFKju9pl37xtKKZWYaRBgmrwE81Ei/96wI+j9oM+r1FG1Tjp3GyLK37gM0D+kvGrz87dEHsaFRljAzKh7qRTw10XeSpNSR6rDsH4nLLQjUofbhYNhElIhHnWn7BnnFBXsx+Vo75RNcqaYuMc+aqg9aBvjvRoOtxM+tuIUcvT/nqbm/7DcXsHaTbxhRYEjjyKmTqHYOKePUpudyL8qHKPmiPRqLP1JmIIKii2z3HXZKdCQK5AZ7W0CFGN+qJke3FAYUzjZWmm0bGqPCnfqu/n9d66lqIyRs5UWYWcs7qXo8OQck3Mb+eQ9uuR6IsqiU1s3CAA8dty9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(38100700002)(5660300002)(55236004)(8936002)(8676002)(66476007)(66556008)(66946007)(508600001)(6506007)(6512007)(316002)(6486002)(36756003)(83380400001)(44832011)(2616005)(107886003)(6916009)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/s+FMva4FPmBoEII8I5QB3kDRR7pSB7yD7DDxVVhHy8EW6jNdVCSdsUjiFj6?=
 =?us-ascii?Q?5i5WrQB+KpT0/ZnD5jadv9PpDIi9/T4Iz3zLjcLtrycuuczAz4RiJJ2BzQFo?=
 =?us-ascii?Q?wzhkwdzSY5pmrWJkuL0t6Hw6YA3/m0cyp17pqiK2k6NIm/uKC/KovHX9opZX?=
 =?us-ascii?Q?UjkVE4bmYeeLQ0yLPV2GypX5Ntc4HQR8y04odE5yeexWyXqlKjyLVLPxRsA2?=
 =?us-ascii?Q?rkOr2bNEkbFe/dld+DDOO1zftD+GdtT3kuTD6tyfj+UjPLXz/Ra0bXN4eaG0?=
 =?us-ascii?Q?+99uXnBf76JzI1yZeM84kNBSYsestLk+IbRBiNwH2f57e8fTegy1rXaINQCA?=
 =?us-ascii?Q?a7sO5DQhKqqDnb6BcJlN25s1V5Rt9gPuf8N0yIh0D54/45w1oe42qOwR/SJ/?=
 =?us-ascii?Q?abwqbzzKu04A5cuVhhlhd4MYER3ZwEwVziNSMKDErN30ToV3r/E5aFMHUw0l?=
 =?us-ascii?Q?gIWlA4sLyNEWYAG4UzZ6QcD9ih/ETtoxm7b+blUxKpNkuNIMBQfxr/dTGHKM?=
 =?us-ascii?Q?37/qcAJy4o03qo99SVBOB74Q3DyzQFnz0VYn19Z4bWmZ3XT1fjFB9UplpyWR?=
 =?us-ascii?Q?F7QnUHm6TgUzviEnAH/wlUe/o8xT+315uawEI6GahIcuWCpHsN+7YpKYA8Zt?=
 =?us-ascii?Q?O6tOuIIzwCnneE+rerHFFwHvZA9AFfKK6FxCOzjkH1H35WH9lD9kieJjMLzC?=
 =?us-ascii?Q?AoRryirFWjIR+y2ckSX/Ipi/E4lDDn8cRc/6ADQN1DTgl8tZQA1U+lcJMvMK?=
 =?us-ascii?Q?l7yDHq/ONqzY6qVda9XYng0MApvskrEdnfWCaRXlzgte775bxHRaofRUdz4V?=
 =?us-ascii?Q?fciFcQOBSayThIjocDzYjURLJ43yw4oRJIRaDYbpsIhDO9K/eFBlGz/6VTMB?=
 =?us-ascii?Q?p5/Vv8dqueehaTgcWT+qTN0CYmjcxM04jAZCe+QqaA0r4RQNmbpLzZIM974C?=
 =?us-ascii?Q?mq+EZPbF/aiJ3D3Jn2c3j3JYjTq+M7ChuXod7agq2dpSGCfMmHgGy8UUL5Qc?=
 =?us-ascii?Q?GOHCbuFD8qgbeeMDe/rkB7YC8YJ7wQDGFPWj7e0oz+owVPScXjKmTZ5oLGcx?=
 =?us-ascii?Q?fvJ0fY56YgYEA+gNeReMLRijcR/AePlj+/1bJQOkPkAUNgJyJfsIVQ+GGUhh?=
 =?us-ascii?Q?+pe79WfbJBepDyMtSOWyFizX9CsbucBJD0rsTt5MWd8k39cNz/+LaknIbIP7?=
 =?us-ascii?Q?RlnmOGQLOFRMgTZOHjMucUUDvOFGAuup8P7uvjialxgyHAoI7v5MK0AfWEMT?=
 =?us-ascii?Q?lPga0gornrhnN/miPjxeToUNgiod3SeRIm3l4jYuHRhEW7BI9un/IQhafL6f?=
 =?us-ascii?Q?1/eTGTfubKEkbRNGzbGVZLb8MUnSIIY0ragNFxSNO22QJsKdTGK8G1OkCm1q?=
 =?us-ascii?Q?+rnVOaEYM0qSP96NpxWyQtskYyCUrdZmGXBdQITJhc8RL0OKDOTTs+p6erGc?=
 =?us-ascii?Q?7NfUCkRn5QBp2kWS39zZyPH8urKh5/5rqTCb3MdvfuTv4zKZUKfoSIR8Say9?=
 =?us-ascii?Q?BmLqgSp2nVbg/KUejMtPPiZ/C+wVFq4EyIpXzdZxxk9H7xzo/wps/ugMYogO?=
 =?us-ascii?Q?0g8kwotNA1wstsUyBx0dFP8lgoDdRNI1WXtKUDCSvQc2HwQosFBJnryZOd1O?=
 =?us-ascii?Q?utK0OtvA3J3shzl7ZvTucSI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fbaabd-7156-4097-7bf2-08d9f0740661
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:16.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oatf6Vym9zYS4RtEVZDDIwSkuFYJfYxWClO+R5vjC6EoH2t6kI3xYHeJKiuQvmTTPmNWIEsbswOynqqCBiG5qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921

This patch added a new function chk_fclose_nr() to check the numbers
of the MP_FASTCLOSE sending and receiving mibs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b48b11714817..f71494b87d5e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -834,6 +834,38 @@ chk_infi_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_fclose_nr()
+{
+	local fclose_tx=3D$1
+	local fclose_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "ctx"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_tx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - fclzrx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_rx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_join_nr()
 {
 	local msg=3D"$1"
--=20
2.34.1

