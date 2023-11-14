Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0E612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="26vrFSrz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob/Y8v8tpdEUAoa5Wy6M1HBqoK/L6TgbDecpJIRWVJmwZuXzM8alD3at+/NbMfz5vnKcnG3C2Zmvi5oHSnuo1k0OLPh16ESkQ+u+eZ8HnOUiRZf9Brk9/fundWghaRj02aChzZhtxCYonS75VfQwUdxnssw8zJSHC9nXQ8bOhjsusrEptgX6RYz7Fe3nuX1Zm9wP1yl7JuRCz2OUiNSJXDf7yjwdvTFht1S4Yx1tbWRxy9OnlSIrrnV4UG7dfG9Q4JeTti919cX2MHr1ZDcPVK4dWIYVug2TjsmI77Zt4wCxOPerPjFtgmitU/8I0RgprdbesNvT8n5qxgoqGVG50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYr1NMFMKvfGcN0MRxRaig0LTgbAKiIHMgkQ7i4xZF0=;
 b=IzQKKpejcRwMsA34ihEsjLpDne7BWzYZ104h1ZJjTqrQpxQJN5Zf63Pk+LhlYJSizZvuH6vwUVE0aYFo6+xbzW6Szn7T6oS0KrSfIqHlnIvF+kpccbFlrmmY1lJ1KUl+u7tJTZXenxh4G0ifG3vXlMnENFowKqk94Fr0lx5gSlwETLY+AKVoHHgLHihiysFgY6bOGSe3V2rn2IAwkJTPuL1/BivgZCXnP2T2Y9W4VX1cA8+mJ2v1efU/S5rSBiNalwsVyM45k0UPhGCvqpCWrqeXlHb/x9+I1Jlahc98UXBUlOmSK64Bqi2AxvBQGpzPVkihYVBbwy5ywReN0zJBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYr1NMFMKvfGcN0MRxRaig0LTgbAKiIHMgkQ7i4xZF0=;
 b=26vrFSrzKHlX84ucrMGRhM6Bq0COwEvFXucammE5/dJ02B/wdomwkDwQGhVGrov0iLJNIK6uQfbpd+vhCBthZFxZYeoIC4CIrv/+PX6r3XE+PMrKBphewnrzhe//hKGswZDefpJJiwV1ljfKWL+UpTqDEhPwI1S03hqIUJXSQoD65+pplmF2lVpPHmHYh/apKlpG8cjdI1T1POhFs0vMPzihJVY2GPynF8CSvES4gxdKaLqKn0Vjp5p3stu5zYDxXlxEhRPj3V8W7W9GyH7OntBiqycbnKxdYopPBgDAPjJjIPtKgABCXOWlX9qQ5FRe6HSjeuzh9L6k/SrB0jEBUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 23/32] selftests: mptcp: netlink: print out test counter
Date: Tue, 14 Nov 2023 14:35:42 +0800
Message-Id: <35afa66e1298c8910c5de48c9cffa811f0275883.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcc254c-0a4c-41d6-2fb5-08dbe4dca37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wScCKtDjrKwqn7A8rlzEetoSEQhg9E17Ln1KhqtSkiOnvu7QHcVdNMDTF4hVecKGQDAdLD7Rzm2zug21mwA0RGDSFjz7dnKuUQWsE018tF+UetQB40J0sYOBJsxuBYknsITtVL3d5xjIOZULDUt2P9otvHkNEoXhgvtN/Vc6FI5FksICVby/iTppi+4c+WgrB6HQbQdmdf3ZlLOywTKhZj20hh8Rizer2ajpmxxH/vlI/IHbntbBZ4+ZZ2tWpbeTHn2rEIZ0y1CDT/TmnMpJaFb/OP3fjFMvaVzfWKLTtrd6gQhPrhItaL9a1563MZQyO8N9waLEDHGjdZvhiqDgV8Jmo6rwQhqQ75KzHD3jfNl58EhGIPfBt6ZcOQWY/SulxNtHQ+9kOwRbML87uqI29wk7NKGvU8aeP/coqV7yeDQrgbWaRv+6Cu0/B9KiYBG6jAjcA7LLknlG1sWRJlE6KuYAIGTEl15Xg3ypjqqP+COpwljDjba5LxXaLMik6ySOTrJSgns+iclulVe5lwTYa/KTEQMj/gJwbmVa3JNbwMKr5FDxalfWk0EXbusB2spS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3AdGCnAM7LbGZux6LBDkPo6cdxZPJ4F2+Kg2yFfx/r2KVIIAaM/QrC7NAqo?=
 =?us-ascii?Q?TPyXCMayEDVrGGG+6GukByk7+ihLt7XcpH1R0d3JtS6biCTeUJb2lW3v53ox?=
 =?us-ascii?Q?AFqyy5Gyp//yZqIo4a6TsH3+dne56ghgT/Be4NdUsXTgOSxxbRCtLwiOtgKC?=
 =?us-ascii?Q?AgTohCJQg461/cOQHNFLM1yuGXbAc01PfGkFTFXNginQa/xCOXgFu+8aoZzz?=
 =?us-ascii?Q?ETpD1aozrxbFVLRUdQIcPPqmxN/u6HEJyRiSzsvLHVE/i+WtzeifWp98a6Le?=
 =?us-ascii?Q?PwlZIx1KCJl6Md8Em9b3CxWeNf2nZaWw0asoTzIEIoSKOpbduxokZB8/nlqm?=
 =?us-ascii?Q?VlUoCi2hM4gT96AI1fxSAngLFbli9BVK09MTNFK7j9CInFMPIT43kOOmLpEK?=
 =?us-ascii?Q?U5RGHVYibTlU9ygB8AEhBdD3A7pCaovYn49pnmXByLO5w8ENKoFWcKYBYBlA?=
 =?us-ascii?Q?miCQt9jhYJE6Td2TIjvChV6+ccW4WKpEEV2DbFUZEX05PrxW1Kqt+Q4CuY7f?=
 =?us-ascii?Q?2/EG+YX0biOFCxRYfIgXoadtyg1RbYGAi6KK68OvCwsFjssNitJFspbn6ItA?=
 =?us-ascii?Q?xPEJbM0Wza7nv9Y7Fji2IlTEKUkLzhRjAjFTptNm687xauBPGlXSTplrJMq8?=
 =?us-ascii?Q?CsGVPASlFfTRjsSO2Id4k6EnA+fjuDxhLZjNkAEBpG3N9cW1pz/LtugV1U/w?=
 =?us-ascii?Q?sI9Kdx9KnelqSV59HsMZVjHUjfp9qm0kes0jlBC/sM7QuxAaeksO3CQlcUcO?=
 =?us-ascii?Q?u/ke36HN5kLvLcd6/oKIAYG/0kFKij2lMEqWVk7QEqhXyTY47IEDxxmZkiBX?=
 =?us-ascii?Q?VxZ8GK3qy4LNMBslWZeZEC3BaGvJ+J/XAvmXOvikoZMssS7Q3WwVDcjtYD4t?=
 =?us-ascii?Q?3y5PfCu41iSkEOhXKcCFjVSALjKHDqZ1JS229jGUjPOYCmwqDLiqmpNnJvdG?=
 =?us-ascii?Q?ZA2LRABviS47jfeqIXqPPKIpjkIdY/z5FDtLF62rE2UIJnpyDlxlLUYR9psy?=
 =?us-ascii?Q?Cv+Q7r74u5miZYLyVyUMTRENtn590uTensrWhLoRG9GSY6x5pKOpEDA0PvAx?=
 =?us-ascii?Q?oLNE8M1cTKj2583ULsiZmi99ns15vHuCv4J5A/aHdu/T+KM+EecyOswWtaI0?=
 =?us-ascii?Q?GT8LHWKA047D9j0ZWxcJ4jTNNVUOT2ow+/qPcc6lay1StnXTQyYdZOkv2zci?=
 =?us-ascii?Q?R/70nQ5603EivORv6RZ5xejLp5JCiZREWlWWREUo7v7RmIAu69paPXsv9+eP?=
 =?us-ascii?Q?tyfHoRBK0hH4ylYm++POgNFCmeLjTL9LdxRn91eWlXOj6I0LcAwIUv64+sQc?=
 =?us-ascii?Q?gsH7RhtvUlQvcqC/7IQPMBwOL8jLJ/nhciq5cAex61WzArBPXXi8wH6jw7+G?=
 =?us-ascii?Q?l6T2sxG8xt6ghnbYaTHiNtOzArWCHsvZzZGYkwm0P46lrBX4cMU8Edkwa1rs?=
 =?us-ascii?Q?oE+03QRttWtuM1Ix2JFk6smmEadC9t/d4rjVDbnyJU9Yc8vtpnr97XAanKV7?=
 =?us-ascii?Q?viN9g32FFV9asVVJG3xcHxtKlQNKdwHct6Pcb4YqkvDP2+bSfpI2m2VHdjf7?=
 =?us-ascii?Q?Q+zt3TXRNRb6XiW5xR3xEC9xJY5Iy+Jdo7QsfOFw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcc254c-0a4c-41d6-2fb5-08dbe4dca37c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:49.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4fPMq6P7wOILb7+6sMFEHyiMHFy2eo5zwokGzptRR5MENAqzy+ea3KyLsY03wKdsAF1AEbKXxy5Qms2DAKo7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

This patch prints out TEST_COUNT for every tests in script pm_netlink.sh.

The output looks like:

  1 defaults addr list                        [ OK ]
  2 simple add/get addr                       [ OK ]
  3 dump addrs                                [ OK ]
  4 simple del addr                           [ OK ]
  5 dump addrs after del                      [ OK ]
  6 duplicate addr                            [ OK ]
  7 id addr increment                         [ OK ]
  8 hard addr limit                           [ OK ]
  9 above hard addr limit                     [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32265d4ecb41..e89b78e7d4a0 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -45,6 +45,8 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%2u " "$TEST_COUNT"
 	# ${*} doesn't work here since there're spaces in some arguments.
 	mptcp_lib_check "${1}" "${2}" "${3}"
 	local rc=$?
-- 
2.35.3

