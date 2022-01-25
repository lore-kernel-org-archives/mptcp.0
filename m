Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB02CA3
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 02:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1643076354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfTXLk0sencHzIV9abgKaTjRkiVS7XkBfz73Ns3W1Jw=;
	b=QetKfDOfgQCrfUO6bzTJ1BVKLJBpZ8P2vROEIiIZOuWYf4mes844LZujWGuGhNdWUVjxiQ
	s3dbvSDFES08wHGHdyeyGrawXkOkZZ2sQUisc9Lez8T4OrR5B2K2mpmw+qvb66qRaAnxGv
	IX177jj3f0j/ZLppwrDDy8TgqL+28KE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-kjbVgetqNmebjeJMn94TMA-2; Tue, 25 Jan 2022 03:05:53 +0100
X-MC-Unique: kjbVgetqNmebjeJMn94TMA-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWmfWUCs1riymUcE/j8/UyHJzky9U5jaMO9BqMP3E8A8jBU5nFrrSaQpKF3Uq2SGpm7cDM/nRyfr50drgB+xMAh/x9QzB4STIy3V9EHtB4g/Mw/c97OUXd0AHDD8sbM14r2QCbeR1Iglnzs6Z2vkqyqmSOjyl0eX2O2yyvA1kvQfj9njwJOoTijvzNacMXI/tfx3huMGktc43vB04E+SfbMmAPkRod1Z4YaivlW9zFjCueSK37FScSBnU+aaUKnhWKV2v97wC0frl70wj+5Cfh4xTgWE1rtCGFGm8qvROH3/5jcTZ1Wg1QibhMA0L5/5gZOaDc1TBc3AOHyyWOnb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scYTN8ezqhyhyiayMlvBm+R+qHM8KJrsAO8DGSe7Mbw=;
 b=ZIr2/IFoVzpV3ccmVFfTcVPjBZDiOwbY3kWe2Og5LKOTpAIi1jKkSaX1Yiiqr0v2DQ91AVCD6XEF/a4nO6pBlvGKh8+ijJgJE/Hm6np1vuu7Ti4N5RdZr8TdYh/QA0dWT9BgdXmP/nVUn3zxZnP+rjO0BILC02tdtDZpSuYI7OUD3UQYtNuSZ1pq412h6zijrJyfnAUISsk+V1E8bXdgK36mhgmnCundvAlxu538/ruJH4MqPIKT65zmgroz4+VwLH7YY0Twf8rSdJAo9s7LbwglNI+R/CfEU26/Vvfwdfw1PXGkG6cxElevpyl1vjmFCGzX7qGbyxkvcYz8vjkS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7169.eurprd04.prod.outlook.com (2603:10a6:208:19a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19; Tue, 25 Jan
 2022 02:05:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 02:05:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/2] selftests: mptcp: add set_flags tests in pm_netlink.sh
Date: Tue, 25 Jan 2022 10:05:41 +0800
Message-ID: <8115efcc945fc08172f8454947d12b4434375f43.1643076075.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643076075.git.geliang.tang@suse.com>
References: <cover.1643076075.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e9d81e9-2582-4e3c-07f5-08d9dfa736bc
X-MS-TrafficTypeDiagnostic: AM0PR04MB7169:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7169BA5C9A9978947783C747F85F9@AM0PR04MB7169.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HwZuoIsBZCX4Ed4p07/q/mi8hi8+Vnu9NZxcPpxBVRvmFsL+Tg07iCX+A6XrsdzpKahii3BfhGUDutjFop0VyZQUVmDXBvqYFp75C9LNoD3edNzddc2uvUF3Hkp0008K5GZ3ZyGh0HmzETGun2S6W+dn9J6Zl3KfhHBwtiycU7sv8zq2oriFO/AGmxdDvV5+BJyCxSTlAmjwsdgdFgnbZBLdGrh59zcTR1mMUVgIIvLtn/IhDR4lZf8gdJ6ZJxFkH9TdR4/5W7OBwF8mCwu+qNTCftZSh4ebF9ezkB9LNtGfUHXXCEkTLVuzgc7FVsKKLqQOd7bftrhJG84w9zpbvg7/yFP0vcbycEgKpfv92RgQwM+6wWifBhN7caY8NZ/C6BWLt/tiNt+HOnBltQ2PDiUMGmeuAAZYo/xwbcOLxwV4j/obfsLLZj7JdIiRLmBoTO7vrtwpAr1j397OzlRAJM4lvpbuMSSQc+Fh6kv3kIXQWA2kc81LdmkX4LqqGgMJsB8LGxrCMn2l14tnS7Sfl42Jro64oYcBP6D3Y9wtWkPWWJgzKUCbA9jNIsDIWcg7/ezc+KStreRlB8Ife88lzXmBixkr8grFRnWdDICtLVsheqYJBvnIoen4Y5aYFJyTd2yqJOQEIbk4ryE7sq7hCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(8936002)(6916009)(316002)(508600001)(66946007)(86362001)(5660300002)(6512007)(6666004)(38100700002)(66476007)(66556008)(6506007)(186003)(44832011)(2906002)(26005)(6486002)(55236004)(107886003)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dBbIEMIH8yCJPGYXXj3aO5eHdaD4N7VLxW5bOigER9J6a+geiQ7746Q1PNv?=
 =?us-ascii?Q?/bimTVWQgIz+ggaFpQPnKvYi9KX5K48snLXz3TVEpUF5pL4T0tJJF6M3yybW?=
 =?us-ascii?Q?cvyO/pYYWm6hu64xBnvBnbIkHP15lvdwvYur1dHIYi6yCAp5ErUrSpcP1zJw?=
 =?us-ascii?Q?m/6A4w7uAnjN26D2PIGjxOssgfpW7+HNWAfaxC5c8M2Pd/I2XEL2t7+MLGxD?=
 =?us-ascii?Q?/C3KBnsPpxz7sDm1FZwiCkK0dnrTLrneWsL58gmDXZBlu71eC0OhdhP2L2ad?=
 =?us-ascii?Q?F/0anF5f2ypBhSYw5lpcsxg2geNSvW4XcLy9ULNI2O34u8mcPAoNaQRmA9Ck?=
 =?us-ascii?Q?tQt83Ph5zy0q/5pUTEwlvx5F2b1M3ikTooLrKNEm3SkUGfpSpUClQckuosmm?=
 =?us-ascii?Q?gd2zKedVo/tLIod2ncqqE4zvGheYll+pqzooQbvlk3ZGaFIfzdBvJh32W+uD?=
 =?us-ascii?Q?2GWtyYSAvmPOcudsJEXSktaeQ38URVb6mjeMBxFmqsYUp0ZH/seB1dy+Dig5?=
 =?us-ascii?Q?ljm0xz0lgz6DcRMvIBVez1p506ua2TAwlbHPC3tL31Q7sWWvykd9yIdufSNA?=
 =?us-ascii?Q?MwWoBU5/s5CRNL1/TUqYW948K/ZjXo4Yhq39qGGWB6KkVJiVjGqaoWdza/aL?=
 =?us-ascii?Q?osq07aSjGY8Z1YzCYhHevVNPo0kuIMlXb947m7EUf84SMt6S/0nFgFDxtEDt?=
 =?us-ascii?Q?iQbM9UNFwB3Y1M3dWj7B3kB8um0Mf6bukhW6TdSLABPiBGuOAxbbfKhk/nqx?=
 =?us-ascii?Q?zqCk+eFXkHGtzHqWclczcWi/CR8z1xszT8iMLtjMFYUvAK9t51Bpd00nerR+?=
 =?us-ascii?Q?Ns0+C8upSZHICMpoxBd0L8QP09bnhVJX0HHI9QtA3LWSKXzhFjNkb1Fdr6At?=
 =?us-ascii?Q?M4LF7SREWAfk9sXaqq6kHS+oppSudhxbPXByBlZLJuDUK8dU54XuDOFJey9S?=
 =?us-ascii?Q?7Xi1omDt4J0+NnrJ/lC3Fy0pmW0G3607CiQsNS5TmltEo/TQAt4XEzjkzTIh?=
 =?us-ascii?Q?7JcYTQ0nQdxYRmRE3OYVHQw32NNlE0uXlMa1hUhgtYjodQIb+nvwFVay2BRT?=
 =?us-ascii?Q?A3NrXzPuI2LcL1IVu8rVnjfDiYGjaXcATurlv2aKP5PgddRytV5HgiUwTlX3?=
 =?us-ascii?Q?/Mpz9Ffyd6zUT3sXikTLLEcM9N7uEPQ999mGyrtZ2/jk5Tb1ztJsQTDgYi8m?=
 =?us-ascii?Q?93p4ma7Yrt5Lap5XDC434Czm9cl1s/1jHE75YFoQw53EIjF/5JXTL8ZN8mcL?=
 =?us-ascii?Q?rC7EMyAJCRyDnlYz42hW24hN35XltH/8Cf1WECafpmhgTRX8KlzFjW3veyNe?=
 =?us-ascii?Q?SLGXGUazSi547o6J3sPvKDL381m1RE2KrbzGaZX5zJV4r8aLK8lyUwEuQ1+y?=
 =?us-ascii?Q?amVImreGwJfcxl4jodSZaAT+taEwiC2FeIoeeHGSr0AmYrZnLahHN5zeyZ5C?=
 =?us-ascii?Q?jyzf19rgvhtobw0oury4B+L8mjAgM8Lub6+Aefdlt5ndEsY2JwwaD/CCu5XN?=
 =?us-ascii?Q?XSIHiB91f8OKdscLW6Nkio3jHNdWReAR9uwJ6BQ+c10osyj+0+V7t2hY3DiX?=
 =?us-ascii?Q?eWMTQjxEez95Dllyls8BbcASgZ1mtdmvI8ROf+Q2D2pfwMnTsl9kn3p/vPmO?=
 =?us-ascii?Q?2uHTKXKywsVER7QTrtpDN+I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9d81e9-2582-4e3c-07f5-08d9dfa736bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 02:05:52.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHK97XHuHSOfifKjSp0IemuSudl7rb/zjPEKIFCegzUK0rGsIrtyy6mUAllWo+bgk3C3JKnoHhQ6TdT62bvcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169

This patch added the setting flags test cases, using both addr-based and
id-based lookups for the setting address.

The output looks like this:
 set flags                                          [ OK ]
                                                    [ OK ]
                                                    [ OK ]
                                                    [ OK ]
                                                    [ OK ]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index cbacf9f6538b..ae735a380123 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -164,4 +164,22 @@ id 253 flags  10.0.0.5
 id 254 flags  10.0.0.2
 id 255 flags  10.0.0.3" "wrap-around ids"
=20
+ip netns exec $ns1 ./pm_nl_ctl flush
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,backup 10.0.1.1" "set flags"
+ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow 10.0.1.1" ""
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,fullmesh 10.0.1.1" ""
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow 10.0.1.1" ""
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+subflow,backup,fullmesh 10.0.1.1" ""
+
 exit $ret
--=20
2.31.1

