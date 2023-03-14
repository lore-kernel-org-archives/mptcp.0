Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A817C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV9L30SZGKc/hkofa7HeTrgaMarleZXTLHHztlFhrirUIF3XBgYbq3G3s9cmM5CIyDvRIRUgLh49/B8BNrG3L8Gd2MjZfGyNWE7LWMyo5bpGjrNtJ+Aow0osEAYhNyJU0q9zQFBbAmoXjPQRoLbxpLkzLlrxGZ3bAOuCa2iIKfARUfuY+RkeyD/5kKKB0g4QKkrAum2Akc0HWsbfWZ1wYsWxngt2+MRexj9bvNSA9+fJTWZC5FwtkCXbuzSlR76onsGjAsDt11mX1u3ijWjmP3Ki8KGYh6kagH5FOjVghOmFlwHpaGTevZCGkQ3DaIzE9JWGUwzpiw35++2I2QZKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9EDmkzVY7PMLEdzT06DnvBOZz93FVwrHgPXWGNZioY=;
 b=c9l/PhOO8HNFozhpz35wdEUfk5xdIah0eIKR51IoNpuhyf5EXosK83Po2sBB7pfzY9wjFia1spCNPSmbDpCGlqzwguazvx/HYgqcofUW4k7Vo2H70qqBm0bKThpVPubefW9+G0oq7zRfWnugcUjvKKDypo4R3xkh1kjeLi00gOQBloVN96oElvQL02oFnW8yOp5B1CXKpwUbGRBHq+yQlVovLLYOns7hzki3SK2OtzoJFMgFOwpC9Ul7kqp7OHjyr6tjBb/6sRtHhjJdKLedx1tN9eaMgzIZMf+O6xUi10nRhNK+nyqY5U4LMkUDNbuKFA+ly4zRy7QjCTpQA/wXDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9EDmkzVY7PMLEdzT06DnvBOZz93FVwrHgPXWGNZioY=;
 b=VKuJUcTDgxDQVKcZeSWlC9mnast9ge6z/nFqdo3Aov3HbBlbtiaV2WFXK6mVYREfUHNPwukqv4OzKBrcBsczaZeBwA8TlXiaV6qS8zwQp1WxuXJKECtGzDUTpChBRVPfR/JSod2uJ2ychRGJdNXGdk9bxL76L+xBjDbfBnvUW9m7OH8dsuoSB6C0ZoWe195p1Pw8oKOE9Hw2OuSKzQlD2cmSNCjc9K/wuRl3cH5WqNZb8HTasjvrSnZcuwvObZE2z42T3C+81U6nMAzz8lq3h13BEqt1aakP8IDKUlBi5hgnQYPQgmyja5/e56/S5q3nOLfxqaS9rEZ0hfWtr7ek8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:01:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:01:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 7/7] selftests: mptcp: check userspace mptcp_info
Date: Tue, 14 Mar 2023 11:01:46 +0800
Message-Id: <35fc5e7f22966c370c932f134170b0ec5f8aceae.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678762832.git.geliang.tang@suse.com>
References: <cover.1678762832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e6b6b0-9ee7-47ca-df49-08db24386a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SXUYUDPwKvjU4UQbEqnqYntU8VkI44ksrY8NUPF98ANzaRf87CFD4LmZoOjCE6pqD7n8Pb90BRbzt7gvZNgWxQwy4WNrjEyJs0fB2k1vLkodN2/lirYJhxyt1tCKY/723CkFL1eRXen4y/UKiP8mPwXCM65MHvcX0ppAxWMhKf7IzD45uw4PyNYbETYiXG86i9p2swH2sPv5y5B0uJo2w4FfNEtn5wQlhNd79ex7nNOsFliHEsNdUB0mHjFzHpl2IheVajRFF3ytZ4raF/tKi86sKLKGdehMbaaffMtjX1JQWHAKAQ15s4XyTu4Op8sE0LaHtq5WuTiFzN+WwjvNN2bCsHPm8fsyO4/w0jhhYZR/eHQKwWeEk/fPVfzF4OvnXiCWbQUaCkrwG7tQOLgmCVTyupk0R+L6HTHqUJFAi9alz8lqq1GzSxSgDH1Ph0wO2k/O7FaWRGxZ2FpNINtkPI+/pHt+g0jiK+N6mMUew6dmnVwkbN6CyYSgigbpPZtt4X8m320SZdE6X+hdPipwjaaU69utMqUE6bCEhf+ILaot6gAh39Se8ZFXM9UGrmLiBz8WlDLtL/AbhB7q0DCG6nkbB+dBw0Uy/nsa7DZpD5ZYCGsboeRB5YPSozL8pSPqTvZgmLz30awztiEm/8LIGTUpLgxbH8VJWSVYRIgU1SwRxXWjiKPSoV9y0Z720O7v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(186003)(478600001)(6666004)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9jT+z4KlLguC+yGE572crsE6dE9sKiwSUKehCh8tBauQt9MRYJrAZ5r902C3?=
 =?us-ascii?Q?9wlAqWEYl6LPC+Kmzdx7I0lUiHsMOPGuegRpzK4WwMQoY9KcskEKbfMIOQAa?=
 =?us-ascii?Q?WgItKAJ7NJmy0alNEjFsgX4zBSQWw/i/jfQYpPOZACvEtd957XFxC+V55Npu?=
 =?us-ascii?Q?IUzZDBeer4N98/meXZS1gafpAL7DqWDjjMsZjQ5Vq2fX7FAK99uXYUxp08Ax?=
 =?us-ascii?Q?HBWu/qNg6Jzce2X8YeBZAn6fWmj/HKitblKGZ524y3aMLVJG+NwfXSEl1bn8?=
 =?us-ascii?Q?Fvj++Advzh+cx/k/BWbP5vLtXPuZ0vwMU0qNBd2EHvD3pGo2Yewfs1TIGOeg?=
 =?us-ascii?Q?IN4ktAg7Ey2Xx7qj2tsyTZZnWcmQmgSK1Unlt9hNNVq5ZZ4k27kY/LA/5IbL?=
 =?us-ascii?Q?mDw/TzRZMT7JEFvvxINJbqj6zZpi4j+su4+lq9BImqc53Zik3EUysVsYmReQ?=
 =?us-ascii?Q?KPrOVC1wD9dkSbtw8rNp4PMCVhYdaoV2Y49fOIpcTVweOY272cqOmFpiFWYV?=
 =?us-ascii?Q?R46itxwnEC708rzEqCMmJua5T8MOobhQad1R3Xa6LafrbvpSKGueFn0NbUbP?=
 =?us-ascii?Q?5f1Qm2y8PzTGUuX06MhXnemfloWUhiJpQ6TEWSqqvh0k4NHJM47dS7MoywRe?=
 =?us-ascii?Q?cdni7rIxJZEjVc26cuyR1E+QKqZ5kKuJvzrzi3q9pq9NumD5ij/UEPd6Uqbv?=
 =?us-ascii?Q?OaBy+8jAo4EC5h3/rB4avByRUZOphvc4fNM+sheRthHI7c2VCQeLqiVDxVkJ?=
 =?us-ascii?Q?cz8g+6VfOlLxBXOoBde67jMpkpxpyb5nzHS6BUS6VF4fBk1wsp9sJcDsUD6k?=
 =?us-ascii?Q?72OezCWgzlFLt3rfOCxCX4hBUp7mvvHxJAC+MxJR0Y7QwYQ2YHhPZVKMZFOJ?=
 =?us-ascii?Q?IXA+ZcMIWN3QXTgL/vaHmGxav1TEbU1bMBF9FMu5yHGbNzDgR5fDHVEr89G4?=
 =?us-ascii?Q?jxmP9N+rMZdh1TuGRnFACWCKbTchS2vpHVvblC8r0c7eYpKywYx6Er31rXe1?=
 =?us-ascii?Q?uI57WwEUJQqV1RdbSxc6n/ZaudfJcOL+9YCNTnGZcoOemwfwJqqCY0/6X/Vk?=
 =?us-ascii?Q?uvpVTlbtWKH2gkW3jnUSYLudisD1A8kuxg8Oxic2oVAWmEMZiEKt0T9kUhjx?=
 =?us-ascii?Q?7kqBi49ccT81hn0iHXV4GN58dJ9mQyYXKRjUvJ9f4yVI9oyo4urHrZ9Ov9u4?=
 =?us-ascii?Q?rAsMIIVKLpRgEipxrT+00sfzJOST2FPR97aif8IWIJvAXw8DdZI8w8Jc/cZe?=
 =?us-ascii?Q?CHk22H4z3ZFvBqLNyAVfl/ux5ow4UiM0XNmOV5YntKQOBPUWg9P1JwXhVDA6?=
 =?us-ascii?Q?iT+ZsuIf1zDb7WJmm/TRWo9gt2/ObzgHP3OmzaaoytDfLyOyCFBQmHaAGOgb?=
 =?us-ascii?Q?KcK/MfBcPdudDHfTdyw5UOlvwU8dSkSVn/bQzpSBLXLsovnsY+2YyiFw/+7y?=
 =?us-ascii?Q?RFcTxYfOoewknWa/bhWlePoVVMdxx0iSKLeefoAaU5jgPCjkIZLN2+Thg6Ug?=
 =?us-ascii?Q?mREavu4MZFDY7Pxl3thifLgQrWL+zl3ZagBFP6KTpoZx/gO4aGN/5IyLKoFR?=
 =?us-ascii?Q?LaCe9tIXh/LQSwUcGxwaVoxKVUb0dAxm0XXywSaGgj6hi+zoz6wofVLa3Q1h?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e6b6b0-9ee7-47ca-df49-08db24386a34
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:01:32.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbTdER/I//LFxzt1PaGnKsSFLOwokTozy77+GQk/nQ6t0GbfQlwCi7gWLTLfKl34rz8AT/o6yuGWjDFwzKsEoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

This patch invokes chk_mptcp_info to check userspace PM mptcp_info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 506120401abe..63ceaa613bdc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -842,8 +842,10 @@ do_transfer()
 				tk=$(grep "type:1," "$evts_ns1" |
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+				chk_mptcp_info subflows_1
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				chk_mptcp_info subflows_0
 			fi
 
 			counter=$((counter + 1))
@@ -906,11 +908,13 @@ do_transfer()
 				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
 									rip $da rport $dp token $tk
+				chk_mptcp_info subflows_1
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
+				chk_mptcp_info subflows_0
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3148,6 +3152,10 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+
+		chk_mptcp_info subflows_1
+		pm_nl_del_endpoint $ns2 1 10.0.2.2
+		chk_mptcp_info subflows_0
 		kill_tests_wait
 	fi
 
-- 
2.35.3

