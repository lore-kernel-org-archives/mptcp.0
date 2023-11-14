Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94C18C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="arh616jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhQSYekje1o6iMFObaug0bWW0DSxPX8K2crpKVOe9pLhQkmXbFtrjuUfYR5oLL8u+4eeB0jz74XhWjZky/9Vf8YOgyoXksKJHzArLffOW5jO+9ylB4PsQfufETaJbES9vUwF14l0tkrJkznWcQHTHihOuWU7PZs1TDBu9wB5LLukX5jcepIbCNTsQul/7hfkVARQyY+H+06uLV/bPQhbBQV9tvwSEebZI+dT08N+q3Jnd0uB1WYsx2ANcYJwc/Ajz6OumdJ4fSRwSwXC5Oig6hfw2bLRUvVbKlWMoe9j52J2upuk4AcrnC1P5SvQfeglywSWVo8l92A6I7SefDYzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnrbHek0IzYTAneu92fpPXnq2J8mQLj2jvDJNMUCwJE=;
 b=Xj2JJ/2Yr22YwU+IvUL4jXoI6BZ5FxJjVtoaFUjN5Xu3r7eXh6JgTJ62z493pjhbLEyXwmNYMtdwaCPikvVXzeV5azTo4idVKtLpHOA0hZY3IqtD730B4/na7LilT1AhIuCh5PFH/V13tLpHWzPKIiJZBDOaR+6miBUt8cM9hDMqOvLU5cuIiryN7PtEmSHcLCtdcmz7L4LTlRLT6Fv0a8lgfp7tczlo+CaMo/f5CpB0D+CIZPdVP5+1kpfGj3jQB6R2uvLjRBISm9K9TgdeTs4ZHkoCxS7DKXd5ShjbjckVz85h16R1y+zVmJ0Yu28d9gn74sMjkcyyj5rjGQ2raQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnrbHek0IzYTAneu92fpPXnq2J8mQLj2jvDJNMUCwJE=;
 b=arh616jq9IfU3JWeYaQjAAfN+Y3nJtZvo4GSSMVYK9wP+xV4wHAI0NCll0Ehf/UKCHrHfwE/mw9v8ElQo247i3LtogWeIl2PWDlF1plNf32T0ly9aw3CJJpb150QH6ESgDBF8WHYAu0IN0A1DmfVm0cH0sWEj2CXSz+va0x4MZasIHikrsLm07udv3E3AptP9IurpRPBy31sb4OkubkJbRlzQOsg1UNVo3PXdJw2ths43U3YAXQiDvkm4QIBF+fS072f3mFbgKtOWqYjCUDDb3I19qkKPk09X0GZ/9uzUfqdoAftPG16LGhrevZ0hXCutr/3sLKYX3X7S3lrtcdnYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 26/33] selftests: mptcp: simult flows: define missing vars
Date: Tue, 14 Nov 2023 18:21:56 +0800
Message-Id: <32ea92e19df2632d50fc13e4dc7041cda3435258.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc0caeb-2aa7-4bac-5dbb-08dbe4fbe6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zo4sb7UjAaf0Grnc/U1xd/cpoDf2+1CsWBdRuMfyW17SXg92Wa/g7TMhx66dEC5O/E2vlBvSt7MjwAUKfFfxgtACz2KiYK4SGT5nPDNXltTMLsIIpUtd7JFhJqfUJMSHE6bl2F/Fh+Rj2Pdh0IMh9fWqyobb7UXj8cYmjbWKoijvdMPbvUMUvB9Da9mnx9JQVf5O+g87RPCBQKWWbNhi7Wmhla41NlFp9HEkcTccKWsEDuZ20qRYJ3nGkqtViSQ3BQu9kxlMtSlnBGO1LdYHxqQPxmQpE4xK89NADAkuEHUekWgmH7ZgCogJ9kVlshCYHvlzMPFc6SMj4GurHrEs6yQxjlu9tRdvtdUzlDHVwCr25Fw2doJ8MtQkb+HC9jJ7apCG4mvkfWaIQX1LqovGjyWEb+Hbh5vaaLjeBFb0WRB3CMC8Mz6w4zjQfFcu0QO6i4TxpYoZzbv0XmyQLzDmJ8IajUVh51BPyhyOeVTBuRow3atYpUsUV8QYThtBjwgr8rhSHNZDjqKI73W0T9zxeY+535wjK+OziqwT75sDAfH4Tlh7fEAvA5JlGXhQh+F9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(4744005)(107886003)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5P8lmdVy+fGV4D9Pe90FpLyYVpXauQ7tRqfmEiwh7yO0GqKrdfzdOzo8fzoH?=
 =?us-ascii?Q?OCxw3GsPNI90xAf6BZW+gUnMX/Smuj0omvw0/kjeQb+PeHufkzibNo+LbrUx?=
 =?us-ascii?Q?WLsl8oJK4ZAjPY0mCCMXoV4NNX87H+uGrjnKybniYx7wEB49yuXv7ZbRZNHe?=
 =?us-ascii?Q?HflFWNR6qrc8ZNL4jcRRtmvQSEg5Toce6Zkd5TS3eVY7eC92RbDWprUpumPW?=
 =?us-ascii?Q?fM0VEg24mDmVKx85JWPoQTb/Cp16kVqRD+Lmw9QQE6KRZjH1mtYc3RlMFn62?=
 =?us-ascii?Q?no4VLetdpaaFxrS2L+12sRy+kwClVb/Nh2iuPDUISDp7dK64uTH1TP+h3DdV?=
 =?us-ascii?Q?PuowNJS5RM7BQWkGeJlWFruKlgoSsPrHEmYizwvEM+1O2SR4PUXPZG5Unb2Y?=
 =?us-ascii?Q?TqCsV/mAxCe2PNURLx0I8g2hwJtxvw0G50AUkbhmMQ2izK/YL11LSsp6WlCB?=
 =?us-ascii?Q?Q82au4DZIzsVS+kMbjFklF8qHWYfrjp75vn/3qsAdjhmKLZuStKOXwn3+i9R?=
 =?us-ascii?Q?EGf/ag81VajUmjvT8Et3a2QV7Vmi7QGJisFv9JG9LrZxSu8mgiE+bRgmT213?=
 =?us-ascii?Q?QF8JX6xuQvZwqTfyMmoKnXyy0pCAdpqv1npwsvbfcefzOp6jrXVOVZXZqlYC?=
 =?us-ascii?Q?d/LzIXFlJfo4HpZZ95D/IRbHb5doNN0Sl1c6KjImTvUbrZzEQCslCC8U8Zf2?=
 =?us-ascii?Q?9pdeNfYzkZbDuyz7fIeQZgkhFwn9pmTLmHMVRyomHpcFyyumfnDPN/yM0axI?=
 =?us-ascii?Q?fm+gdx53fUiPWABcdaXrHvXPjMV/HayknJQy9CTVi7QwmQu8Sw9Ftva16cZK?=
 =?us-ascii?Q?0pF4JL8y0RcCr+q75XXw8lJa1OgRg7PHVE0K2UUSrl5oauOhn5ikOC38B2vE?=
 =?us-ascii?Q?gHTM0F3BtxFtGeF0sRVO8agiDMT3/Z/DPfWFCL68yo+nvSJi+yLMZsosNQ8F?=
 =?us-ascii?Q?tUdttic3DY7FK7zZFzRwvwfi/XsnFSdBr3zkDU9fIYk/hBfxCkG4FKB1ptks?=
 =?us-ascii?Q?FKwNX0Puoa5YZYCUOnBEjavaHVFlDbiF85GFHv31tlXjMDHYI75XT1+t+FtH?=
 =?us-ascii?Q?jJGLzDqX2KPAVof+eBC9k8sVtoQgSwauAy25EaVq5dz8KiWo3+yitpCT3PKm?=
 =?us-ascii?Q?p4u6mPszdZOBF17g3vWAMsMPWSw4kgKCWLQ7jLWmSgCkjZKCgLoYNV5VaVl9?=
 =?us-ascii?Q?EEYQHXw2YO4UznFVkx/4qr9M0ATTasSzO/jqHU6ykc+BkZ4GUtnABEJwPxfP?=
 =?us-ascii?Q?jy8Drb/uA0Ko9+EKM04ivUgSuxXVvmla6buXivHw0fmdg70RvZGeG/nTndaG?=
 =?us-ascii?Q?v0Eezhu2+MTce75CFdz6HTd5v5z2vNm/f2D9fc/Od4L6rAIVLpA+AS6Tb48j?=
 =?us-ascii?Q?bBHKPcRT+Ae8OIWUX4c+3eBgLCWEmB5orATO+bjIlOOgfZRalJikeOa7ptKm?=
 =?us-ascii?Q?uOG1IddVywGkWyyA2aqVuK26GLCcUFTrEHdoHYts+iwbCt/RqAKlWVphypTU?=
 =?us-ascii?Q?3jFUEK+ZY/7Yi9b60vhCePg5OxuRnSN1eeaMCzQto/EfQb1Ga8F/CKUFLCb9?=
 =?us-ascii?Q?RKSzW961Odd8n05hjHDPwnAo86+8Iakfznu/sTnKK8fSI9eWwQCyLHNs5qyg?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc0caeb-2aa7-4bac-5dbb-08dbe4fbe6d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:39.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIbjGS4UyrqNcvG6T1QGeifjWi3KZC8IKKFNhz3llnQ3Wcxw7i43Q/UGbMbeCeUJbbRc7BxtsTKDrBSwj/1fww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

The variables 'large', 'small', 'sout', 'cout', 'capout' and 'size' are
used in multiple functions, so they should be defined as global variables.
This patch redefines them at the beginning of simult_flows.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e1f4ddf04bc3..a85c9ff21e54 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -10,6 +10,12 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 bail=0
 slack=50
+large=""
+small=""
+sout=""
+cout=""
+capout=""
+size=0
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
-- 
2.35.3

