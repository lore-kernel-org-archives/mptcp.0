Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B420E8
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 01:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644631113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=neL9tNTw62NBqNHxPC1H93FUC/fmpSO8qGO65vEkJHU=;
	b=jkbPlR8GUfsvqO3Eu0S9iltOosyRg20tHwVq/JjeYDxwzj6kfAdOTta8pS4xhr/KXl7oQC
	IQ9YBOQKN6LJj5crbrE5+KULLwwwPoY7gtQXSeY68+mh8VyzVkV5jg1yDh7LBuYt7AJyXX
	RzCOn4lMSZ0dJEAiW4swV3l/CSY68UA=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-SoiopjBVP1qfPE-dIHGxgQ-1; Sat, 12 Feb 2022 02:58:32 +0100
X-MC-Unique: SoiopjBVP1qfPE-dIHGxgQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akFdq7hnIU36CPByPTNe73qbI9/j1FHxLWALnahth0v41RCRiO6lEdQIWemgYNW9G8xCHQGeShVjiD73/oMeSgrF2d8zLqmCpn1J5J/zBURSauQllBML3J+zK9knEvmZ2lZF6IUsUYhy7OcOeoI5k5s5ph75JYbSfH5EM4B+W2Zl9F4TO6Z7l8Sj1C0TbKBc/Eet5uzH3f4MZr/7SwvNATUDedK+jTZxsHBiXzEFjk69D5LLfEKV39LADn8J/lNaVTMsg34TShfd1MsN2X4CC5n6vrrfcbFwIKX8CrmJL9Dvl7s5romjwE1OBQQTdXRFn+xoMIU7QUo8KWDKQZemhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1XBp9bxTNFlcFwd2ueFXJSDmptU2Lc15bg15QRTr4o=;
 b=YYWQ9uiI9ryaGA6tAU1upd3ZBbGyy3cu8BFjzGxKR9qEa5g7vA511R+3D3symWuHy5lhoiGdWXMfHtbLRaiNOjFLN622+mVQr5JWXph3YOpAoqzfA8sauNhhLt/qG9fFvXkktgQ3pcStiQEHEv9eNuC2Nj9/cplIilWnLuDYZFO3KKYKc1chNYcpm4zUD27hUmnqrpiS6rtz5T6aIJtGuniF9HHkHCx9oi4V/IHK26Iojq7y18rwCHVUoteRyxQ2VsIVNLs7LSA+HcaDo1qA1Re65scxt6LWPuV0ESsFIqZRFPPHb7DjDy6dHW1P341hoFuXQ4YQtExINLIM81H37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3556.eurprd04.prod.outlook.com (2603:10a6:208:17::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 01:58:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 01:58:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add more arguments for chk_join_nr v7"
Date: Sat, 12 Feb 2022 09:58:58 +0800
Message-ID: <5a8bc892093225da0667054819b6a5e280d73eee.1644631124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa9f6c8c-50b4-4a2d-ccd6-08d9edcb2ae4
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3556:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3556CF06582910B45BB6B7EBF8319@AM0PR0402MB3556.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xI4dVSRMnqc/6AUbe1UhK4Hejin2q0mESJBn4bU6edYmj7PR36JD47dwDLpgUglKvD9yLCtwf3IfXhyPZr+eN26Axe4w8FyAa2jo+84w6tNCyqIS8En5wOa/EaYvD4Xx8A0ciTORck0ioEJmwr24yRVshxmhLh03rsQlb6qzxjk7hxIGajaFhf+NTLIrhvu+d/Wu1VdHpKKTh5x/gRmweuCUCZV156qLRo0XsT16fN8TbXpHLXfKu0uXwpgasjwqLMY8sha3BULun0AWvW/CoHqNyzHCQedB+b5KJ20zpm1jXX3+/8eoAR72aQ6dCLXiujkQvAXwRvio+kH1+eZEMHJwezju2HVM5pJZ+1yzvZIAErKfJHongApUGBuLcAgLdu3oUdAS9R7e7V0Fn6beRwtx7Fxi+tAtTAFHD/5Snfd64L/A5IKYDcj1OE1DFEqjMHhx+XG49AIlHL0WdAl9yLdgDnFz8BEUdQ229vFOvlIx/Ghlp9RtKNbp+ZyyjEyBHqFQiUvHg0TLksMg+UcoXk1hqp+Qsx+yeYmuTx5wDeqqWDDbBXt+TMz7OAjJX60uii7Lg65cwzPtw1dJPIvJ5UoHqZlqRKAxj3rrMOH1EAbE1LA4c5Se9R5GF26Q9K8tyG175Uu0LrpsmOcan2demg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(36756003)(508600001)(86362001)(2906002)(44832011)(38100700002)(6512007)(5660300002)(83380400001)(6506007)(8676002)(6666004)(107886003)(186003)(6916009)(4326008)(6486002)(316002)(2616005)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lt5OhX4KkevWlFIdFE4rZdF7o7YkLoJ0y/0P5UHMIFWMNXqcvn5DGZWpU3le?=
 =?us-ascii?Q?ZdQ2NvtgvxW/mv5LbzrfAodwfRcgPyTBuBTh3+UqSnZZtsf1u14fGptAEwDs?=
 =?us-ascii?Q?2kT0mpwiV/1GpBOQ5Fr9UZ8aZUQRzD2MfXgISBRbXbuD2/rthrNewQieuyor?=
 =?us-ascii?Q?nvZIR3ZkFUzfgCMEhEeWDHIctxkoYmqph0HNBJI7itBLgyv1rgO4ntFaAXNh?=
 =?us-ascii?Q?s4R+H9u5b2jiuAxkV+BHeAa9koyhcQQLD8Yrh1hRwxwdS2vk1vGSLB9tz19O?=
 =?us-ascii?Q?xNA95a4J9MK5g0jndFaDvPTRfs5scrGq9mzqch/5t/IaTubzuuAMaCXaanFq?=
 =?us-ascii?Q?1uz8zDI1C4294nrJIm+OrcVpt7Lr3pha4HeDE4i6quWRFnF4DYwESJ/9pVYK?=
 =?us-ascii?Q?sEEWs2zJePMMW4Bdhyr068cub4df0NDraCq9YNFRu4ONWcjwpKDYmhjD/wH7?=
 =?us-ascii?Q?07DOm+v+o8qvfuBP7umgIrpGZ7TuBwmxsixkVxJ/XZiJcu5PRvtvMD+Kbru8?=
 =?us-ascii?Q?Ivrn+xbtBsRia1dbMHOGztEl0a+YuTsiDrg0kyyTtpivMISXemqEaanfH3II?=
 =?us-ascii?Q?O5HUiNO61XDe+irIeImU/q486+Zb/xaDp3CGmkF9OeMrHVIxn49BQEDr1M9+?=
 =?us-ascii?Q?MUd8PXyIvlYqZAnreF7OYaERkHeVDchuUwW76/jhLGN3p7o43Tsh/Nz9lTcm?=
 =?us-ascii?Q?EJH/4V3r+ToX5/+LD+uDdbKyIplfjQ44sEHVoBOTq9EbCMyfG4WMFoZnspg2?=
 =?us-ascii?Q?0G/NmIyiU290iX0nJNrZHhsmo63v274p8EqyOgexjGg/olNrTCXVuheL2SQl?=
 =?us-ascii?Q?/ho5TnqEN0k2tO9Q3RUKjFXj6S3cRhSsAW6rm4zKZI6Z08coMbAPIdcvXQ7b?=
 =?us-ascii?Q?sC/eVDC3Xq5Jp36fNrkYQ9bvTY8lCYQ9pF5uXL0l2RhEiPDK2uANGfMfInOh?=
 =?us-ascii?Q?nJWld1ktAN9du0Qb1n4xOpArYfvVzAUqnZ4UGGD/dOTXbgIdl+HrH7ke7FrG?=
 =?us-ascii?Q?/KuYLCcngU21Nvso3TfyfW+4bSdIpUxsi9jO9fOEbXzsEdcuNzQqNe4i0JEj?=
 =?us-ascii?Q?soosk8+dg/0jkwf0QnHSFgHbrpXS44p8Wckl1uVc3pH/eBO6AisgEzWQrDev?=
 =?us-ascii?Q?3NHRWROlvAMclffGixfA1kK5fNrLT8L/+lTbeZCI6+eOBcn9Y9vFsR0owBey?=
 =?us-ascii?Q?0NUPctRC+1RyGgB/EWIrYF6UAtR1KBNRlwnhPHlZIDL71W/OXc3GCOk++Bvo?=
 =?us-ascii?Q?tK15k9+/MvT1pafI9lcyYMSXuF9WYeUkIRScSXzuVafMJTdrkawWrME6w4R3?=
 =?us-ascii?Q?fvNVF4CnLLQgSvL3k23x+yQk6MAUdzeypPK6tf9693t4psBuEXJfQeEZD6ON?=
 =?us-ascii?Q?+Mx/fLedpaPvzKcpy42h/lFqHOHcCIpaTP82eV0h0G6DsReG5Zk20XAQeZj8?=
 =?us-ascii?Q?CAXjhqdsHINeABTRPfMADFGVaQoLonV0xz0vFKp07xYrzFioJ94qynGeKkK3?=
 =?us-ascii?Q?xgQhl8nk8cGxvhIsc8+14X+blOFOoNGvD2AfhogTrKolkIapUdvGgzRA07Iq?=
 =?us-ascii?Q?oa2+kpyskwdY+t3ZZTwQjcIGmdsHkw6Xd1jPGYaUAn9Qrz26LPsIlfC0mXxB?=
 =?us-ascii?Q?VTD5ttFKfU+jEKm/dvL3H1V/zHMo6SbdpSXVz3c9PxAbig1u+REYzxJr22IG?=
 =?us-ascii?Q?VH317FUKd97BVGLmWdChH6ne+wE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9f6c8c-50b4-4a2d-ccd6-08d9edcb2ae4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 01:58:30.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmFJQA6RN9nFjxAOpZ6TUDArcSZULpLPa2Ej+bu9SDDr0pzDIlEW9cmEXkikktd3DE80O2t9mhfJtKWaV6d3gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3556

Allow multiple checksum errors.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 0b739785efd1..0e4a4c58f264 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -752,7 +752,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D $csum_ns1 ]; then
+	# allow multiple checksum errors
+	if [ "$count" -lt $csum_ns1 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=3D1
 		dump_stats=3D1
@@ -762,7 +763,7 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D $csum_ns2 ]; then
+	if [ "$count" -lt $csum_ns2 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=3D1
 		dump_stats=3D1
--=20
2.34.1

