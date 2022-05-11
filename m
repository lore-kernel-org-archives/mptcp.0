Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C115B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Atk3G91JSSNUe+UIEuu8GjmY3hMPn56dEBUsv8p19hs=;
	b=cuVdZFpuu0VJEq6ps3BHxCFEc6Usxe95C+Uoh6U7dW8YOMBpvX8onJ/TSg/3uXlXYts0aj
	FBpIvYMdkO8hla/yslZncJQUMkFYRDFb1bSKr9jfE6ZhpgslTlgWc5DzG6yXp9AluGpx7o
	zQ1HveUwnWlTcRO4k1QwhItPwa11LBA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-SQI5uDT6OFWP-omGSUN6eg-1; Wed, 11 May 2022 05:39:47 +0200
X-MC-Unique: SQI5uDT6OFWP-omGSUN6eg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NppX8Vp58Pux5LsLoYfiKEKxmT+IZ0ne4G0bHBrDyD2wivaGDLyYokhvEkBmTvSGLaOhCTxnkvnWx3UtqldtuPw2j/uwJnfE+bskTzhbeid8tCgjzdxkUdkiFgpaQzg9AF5x9YYox7CUTOT3q/A7D2+EHfyHeYLNJxpsTkLrzSJLJ+AU6Ory1r6W+0aKSBihZZULYNPmHG6KvOjzeLeymAJC9dBy7/DpXMJxbzqpZsBLsCdklDHzIA7/a0maxvclvl/z+y6HYTnqACpOU2PeWkqbNpoC+MLCe/sk/ZtkhFDIXyuvdbhvQDaaKaAtvnR4o5kTBWx8me+T9AUpNeNATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y27vFa5j/lSX4Ma9newk9esbxK4aYDN13I/rD70ttUw=;
 b=jivgZpN2supkoZ7FiAQKSH2ivtUabTFEqLGLRLcEhAIokgTIA+aOtl68QPVfFh50oIXfw7b/N1Qr1OQHo+RcWeWeOjgl0MbZvDsFop7LWvH4C1T2T9SILqMxSobw6UTt+Sn+N5MpdiuW/utTjHIu5lD7KW2LpbhES7F6Ffthoq0hkq/hfrJ3Eqp/+7K3WQ1LLVOOd926HSqYPIT0nTutFxtigqaE8xlAvDImzk/vL8iLOaCNBNNE7kYkP+uD18w3mXKrgcNIMsXnpBl/vsg/C5Dof5udL679HUTUaVSCLmu6m1of0m4Rn/sa8iWlPnMboPuweB/soKHok0hjxXEQXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:39:46 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:39:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH mptcp-next 03/15] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
Date: Wed, 11 May 2022 11:39:04 +0800
Message-ID: <c0aa22595696f86d3d4f51945447f05b66b414f7.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d8f27dc-b248-4ed9-349a-08da32ffe4c9
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB7156101FFB08E01B92652C66F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q1AOb4md9TGFUp/e7N49YYJP/5DQGYq8TrKbxH2OqGk7xu+XruTdX5hdO7wByqb3pxBknj8YaWRAQ9Fdy9qQuD6ICYPYUXn+zPz4BaYEMnN8TErD9wzVUDkx14Ji7quG23CuF9ewnBkSioTFzUInR+ZeoIvYKkzebdaSB8qh91eTo6mpYAsS8xReZp1iF1DlwDDLMkwQoqhUy4xvYVCvon9zHfKZwM9xIEtQsYBrxa3k73K88DOQ/BXzUIdFSuIUmNLwKMiwNS89a/jOldPm4m4ZEp/VcoDVmNm6R5Jn+85FDfGWXGkJYaHOTn3tylVs/TqLgU6PUcBuZF54A1lw0Ht07QCsBD8h1Dk5INcvHTEwyBxZpX0nxMyAd9pkPZfAi61eYtw2zsXR8oQk4aAyQoDU+TIE6tL953DMfM/0UYxKT7oSGBb/bbKuuHjcunwbeP1eRRuQoILhkaKbS7QEmVMRtcWzuQnaugI7hJwA+7KbPqF7JTJ3sqDv18L76d2r1vw1F8d5DNFwSXAArTRnza040CZBuTLcqjFM6FwJ00arN8b1WJ2rHwQ73oGNMEuskz08ht1f9zpIUP+g0SqgpVJOoBN/mmrd7RoLO4X4C5F6viLaQIN/TgwsJP57/TuLRvUy5neoWOKbVMBFldg0AcuOUJWFAaxbop6HhInjaRUfRzryrl8DA5jOIp3a0P6hYjXgAJhEv97/KePcN6GYJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MwJDoEVxe/SVsd9X2660EvZc2GWognImZ8Kat40gVUzt/Sg/Ii0YCbN6Wb5y?=
 =?us-ascii?Q?igS2F8HLBmw6oiSB49gyNXOVo5fBPbSbMZ/MTPTXfDdEsK9u7bM2vi9x6hBN?=
 =?us-ascii?Q?QZafIZX3N9iJ+4dKxkK343VN3S3rwnHw3anne4foav9kUor9+VKsOPG5LTEm?=
 =?us-ascii?Q?LpQfvsmSWe+3GL2YDS1B8sklW45R21zXFm307R4Y5bOcr3bJp0yDxOwkjzbP?=
 =?us-ascii?Q?o7iVibcsI2UiSGgVzgLzNbDRarmuuTy4tKBm1NYzciqbP+Rxi6cwQw+d6lRM?=
 =?us-ascii?Q?W1hheLPVZPlbaiyOw5hmjgihjPbfoQg/nxcPF43et5LkkWV9hTHoZQWpPxck?=
 =?us-ascii?Q?t10D5HZJIZNiUAsQIaDooKXgmV+GVVNGgQftJjJ7jeiarTpzSDfsKCmbv2/g?=
 =?us-ascii?Q?fwxxchP0GZpp0+zQinHS6ogQoKCs2CxeCJiYPDLbmyrqJkmyx1la+7YbckPR?=
 =?us-ascii?Q?rNewcUf0CpAdBmaYY8mtJ8MgUkepbvJnorZXWWprOCu9jilt/hhjR+5xUpQv?=
 =?us-ascii?Q?alVW21unel5jxNd3XoW+fZJhWTx5hlpdnLt825RU1oMMd6F9en+yP52n8zSe?=
 =?us-ascii?Q?qWYUcWCXsiuaVwwSOPTQSDBjOU64LqJmuazhuuFujRLPnHawGBrYwyTHyJUe?=
 =?us-ascii?Q?B3foLxOf4SvZ+Vo+03i2sX6XbJGXcJUDFSotgWtsTnvj02dBzBbom6Lz7qD7?=
 =?us-ascii?Q?a4j8ipYxdB5h7gCLRE5+TX/szKSOrOuWOWKE+N4hcrlAkP1CSIH6ZmIdyIsk?=
 =?us-ascii?Q?MBkzEs1822E1mxNu8L3G0v706D1Q/ejlRWCrK7g0QWHCJ3LgMVaoEHmuc9nM?=
 =?us-ascii?Q?BtpBb92O5vTVC0eR8c24hAvPVNE2mPp+5sloLk+1/gCjTXJOIOBCi8ViXHZJ?=
 =?us-ascii?Q?qY3xXd+l3LPpOzGLKZ/teT7zXC/EyJCO+3pAKWkxlCKIBYLHQRRQEz9Sb4NX?=
 =?us-ascii?Q?3XQTJTZ5eeB5Uj2cVhQttFJmarDlOguqf1XQVeHe+gG7pDIc3/TgDOhF8EYl?=
 =?us-ascii?Q?TCZsRzmpOzih5RCPJZKQnUTc5kwoEhjev5VUqVkSY5cEPRI/1P5Hw8US62qq?=
 =?us-ascii?Q?jqyC+e4lSHyAfWd737XrgiV9+E4GTnIvFcdNjANVBDO0/0aZJAclLiLIP4du?=
 =?us-ascii?Q?zrFIsjMKmHl7n7D4QUYdk6MG2KDrezCg94qzQ4BmNu0Kh3vJh03S7/pR14Qx?=
 =?us-ascii?Q?93OwVkDClzXDcs79icxw7CxiCwAMgGaSVYXdsPu/qlNSnIVuV9VSTC+aVrBy?=
 =?us-ascii?Q?nqRWq9ZaQULNM5unB1BnspkV6eDj07OrLYaT4h46h7FuR2E/J5ehcmxYMgFF?=
 =?us-ascii?Q?3kBiIOxg73XsNOj0n1gQi3Zk6bJKkpVwjEJbVTKYBykUbBy1+ydr/FrfKdmR?=
 =?us-ascii?Q?TKsmDcJTEaMR/Z7XBPTYSfmSDLAqjo0GJBfXQEqMQhkC6Dx9M5EUga1whRzE?=
 =?us-ascii?Q?1mwH3PcOwlYeIAJMIyJBWZgXTgO/wTlvkNF1lGVTmvIqmBV6AJjYvQ9CC362?=
 =?us-ascii?Q?v7dtlABXL+tR1JtklsdsLtz7w5B2EE+Wqia7T1/zPkcTt1tCkxuNv8cLpNmj?=
 =?us-ascii?Q?xf+sWOrsb0CbPNta5ySQ/VQx0Nbfaep/o3iCjpmzs01hSJleTd78xNWdTwHe?=
 =?us-ascii?Q?U4H008uOPOYlXTpJtfZS5hAQwCcaiLWPMrAcqtxOVgfBw9E+9trnVQtEd6jn?=
 =?us-ascii?Q?A3Gy+NUE0dmx+pbVe8dQIp/ZLFPZJx18JG+c123pLk67g7U7di+SL8daZfNg?=
 =?us-ascii?Q?AP973ePNA9BiG2R/L2/JnJ5Lvbz0WHw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8f27dc-b248-4ed9-349a-08da32ffe4c9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:39:46.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7qhZPVJGQ3OBpWXyqRTWxMjjppPwlQxmOuEOEvsBP5P/OELSffChbnh3cMWU0KCKP/6gNbpa3Sw7PcIRj/mCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
errors like this:

 libbpf: failed to open system Kconfig
 libbpf: failed to load object 'kprobe_multi'
 libbpf: failed to load BPF skeleton 'kprobe_multi': -22

It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
in tools/lib/bpf/libbpf.c:

        file =3D gzopen("/proc/config.gz", "r");

So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
tools/testing/selftests/bpf/config.

Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index 763db63a3890..8d7faff33c54 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -53,3 +53,5 @@ CONFIG_NF_DEFRAG_IPV4=3Dy
 CONFIG_NF_DEFRAG_IPV6=3Dy
 CONFIG_NF_CONNTRACK=3Dy
 CONFIG_USERFAULTFD=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
--=20
2.34.1

