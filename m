Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDE3FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkS0Rd2mMJeZ+1Da8aWIoLkURZnb4/Tbe2w+EyAAN22lOKEnxoKK2rr17GqTYEpy9c52QYB9t+gUT2xW5di+YR+fO1cl/caTNE7V43gqe3eC4C1k8Rs6SxS/f9qX+SNAxkipkEX3QNtsdSELvOZyCoWsGlkDORvC1HMStSsrF1Zd0fsxmABR/inLmvifIbVZwwjrQrohPVF1fQQVr/Ef9FQ8wwWuELohowiHWf5oNepBw2XcvjafVsL4pXloDahqyvfDmjXSrp2N+nwisHNRjgUFmdZOSoCieou+oBNzCIRW9Vm/Edp1PmjgiqIe+16641Z0MT6xDU1oytdY4k1cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpp/i3aXk61yYFGbObLKa/JLeNL25iavaTEjwCip/sc=;
 b=P+aQYtzcDR37OOQ35cfjKH5pOx8j+SAzDJcf2Rm/tprFUsbYmESiHhDyLRfaoDu8sECMpsdbd3G+w29+8LLLIvX12ZOW35s20IZyPxtGXSua596J6AOjL6AbwB0cxXOdv/0pjlY7CVgTGwdh04BpIRdnTqdzJQWytg+Dw9Mb7shWZpH6nspMCYJ2WViwTt+XIbFTTKyZkyVPZ6pXr9slCj8Z8fuiVYCBFSWjWvq/KaPQBiOuWSAXwgqlB8ooravaon33oNyuFrVVAfNH0HrrxRBHE4bJys1EqhF5/1hsCVhCrG2bmyPjaa3xxuKkXdxFSOUk2Nwz1MHjb6w5YwuTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpp/i3aXk61yYFGbObLKa/JLeNL25iavaTEjwCip/sc=;
 b=sfbxbPWiG4nUdrPmVNiG/l509U/NiamVHk/s+8PORZU2I9PMwCMFZV+2vdpNdFrCDFJH9Gd9L2vsxvf3D859M4pdOtZ4+bj6UkEA2GwkEm5UFEWHrbcbvozd5HEDHJ18hd4Xug59Ja0XokCrmPKX2XW/FArcvrHxAWm6neMiuiZ2CVgXS1UUpHJVGQLXux0p+tyRylSdVXOExGlUISgB4JntbsoC8ie1APN/JxxDtXlabhRSLZI/FRNPzZCQQQWel6+P0e6v3oeKMQhXc9vCfk2lXfFFFie0Z/CFD8wX7S7b9f8EGnRaZnoOugush6Z8LlryaaPw3EPyifkszziC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 07:45:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:45:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] ss: mptcp: print out subflows_total counter
Date: Fri, 15 Sep 2023 15:45:19 +0800
Message-Id: <3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: d994c0b9-ba3f-4531-2555-08dbb5bfc4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kfFP6db8rLB4ykp0fmM6nM3/YSPrA+SPsozH3hD7/rI8nVJQbZkFaRhrQWJbVbu34hIRkXbcAppwf1FC3UTRGAI6FI4NGILnUOEbmUlZ0HDXrhMzcBjpE4u2+ppmXg4m2s+WA3E53AYAkYAwLQvAC2xo6m/Ep+V81BPnWC/f4rzGtvIal6U0K8hQGB6e8Vmi209Xc/gNgIhcKXo127j+3NEVUrpYCVl+9IpjUkWd6oF/DG6UacHkn91QTgpcXk6QGJpxXklgI5ye+IQrMCvByBdVE61EQzoeQ2RpHTjjEw0zOA37dsbSCoPDFapeebqDIfjPnaEDM+BNMbCcjE39kRxrOJOjs7LBpcndPVUMwnGKbPg3a6JdjD6v3l/jMuhJ1O0C72+xuD8o87zSOcf4nk5ILJ3t9ccEmzHAqWxcGKRBHYQPdFqb8ffr324XrD5KmdClZOhP0Jj3ts5M0ctxamtzp3qRZ73LTwxIfFG9fcBJvqW+sv6gUoysho6VId2UVHGSnLfS75kXrMIFtXSOQY1mxqQbyk63cjR1DdFONKic6ceUWB7m2KBCJZBkrl/w5zM9ZpY5ySrlw6R2MfAbDlabrUan1Jd8OO40ZrCFFss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(6486002)(6666004)(2616005)(26005)(6506007)(38100700002)(86362001)(478600001)(107886003)(8676002)(66946007)(5660300002)(8936002)(66476007)(44832011)(4326008)(316002)(66556008)(2906002)(6916009)(36756003)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSyf/lnsCVa3SAu8wnkF8feDRP4dVhoTVuNhg5OnpPi0RxQPVZCtcGuAgn+g?=
 =?us-ascii?Q?nWUPrd8QjwtpysVjmMDhPFxddf9hteLtYOzyb0Z1yxB7uuRFmWVpfUrznNdX?=
 =?us-ascii?Q?Z1TFMk6CeLZBaiEtGrp93jcHarC03O+7Yqa1jRwgesAREbUqqxrHt0OoNZn7?=
 =?us-ascii?Q?ba7pW8GyP2hqYiIZSBUKOGr/INMel3hJjHqDNfcgkqXqgj9PO0FhXn3zBANr?=
 =?us-ascii?Q?5kpRV6ueg0XOkXnsBSafx2l/kP2kv8IKr7sQGWv8u4N9yXOTuG/U5fqtAD5I?=
 =?us-ascii?Q?XgkfuoL1gYo5PMfVe5n1q8PliRDwpPM0QeUTwBMWsXdTWgSO+3bO3zK414uc?=
 =?us-ascii?Q?qHAnnzxmh3lPgdoHBspRBX3QlIUbjfNB6EnKRZ3cPVuAx8RCN9cmhaklG0xG?=
 =?us-ascii?Q?8STuG9cGKbPDykPZVrgw3R7gEDBcgO/R+GkG9b+V9B4fgiWUlakaNgLXdd5b?=
 =?us-ascii?Q?AcYMeQFQ8hRx4B4SIygVSKHpJXxDZzTON4Zj7LUC0dN1OdpnVOV4yeVyt4AQ?=
 =?us-ascii?Q?bzlv7PYvtP/DOaDQloszodHWGWGywvZ0mWXkjUyMRsl2xzhLExxq79tzdJCq?=
 =?us-ascii?Q?jlYScvLGHNMIQEMmacc9KrWiBoGG/SFBvhoEPS5X7iqaxGtM8k3fbFJgRojw?=
 =?us-ascii?Q?RCJtIYJuDFHfSpmTSmN56uDma9Sip34W33FtfhwG7xhIhyqOLYQtym+yOf6Q?=
 =?us-ascii?Q?xqnPtm7kZatog559gJeP+RpPkWkc/nmtBhqLX7n7UtUOv88DiU1y23nu7i4R?=
 =?us-ascii?Q?TjZ4JAETOiG8AWObIhznp/qHSK/Fl/OFkhemrNRH1Aq7HyCV2DQ3vgCNbczS?=
 =?us-ascii?Q?ncwdWE35VAn5fKODgo4emYOlrmuInr58CUalGmfbBx6mYb6XETKqSoHCWd+g?=
 =?us-ascii?Q?DmjKMwb+FcB8YTKMws5j2DkSjG6J9mRSGMQeHq5BaCpHPIBMgYE0OugCf1b1?=
 =?us-ascii?Q?noEB0uYjHiDMep3IoKVk9czt5PV/nQqkimDXhTLH0G+3tPA1CkNfhq/VSM09?=
 =?us-ascii?Q?9u7Ep8ORlVQcm/JMn/FKKYam5WTl36eo20bXUp2/wH2Egloye8GfNjDgqVAv?=
 =?us-ascii?Q?IcohWURzZ+kSFZawzwnqFgAT/v44R9laASCrWHQ2XLtzoCbbQ5oYiZ6sSRsD?=
 =?us-ascii?Q?cg6+9DPyNsODt1dlDILgbUVf9yMvr+b8OMOG07O5W4kY+v89nM2BptJwqoig?=
 =?us-ascii?Q?kN9IXceiXf/xIZogIRjCwlPSTbmpKik+0gT9OGIB7oWVnXRxy+/+vUK5TqM+?=
 =?us-ascii?Q?oo1451misTgvmHKnQCOP0n/Z/OjGeYCA6XSAclsL9pIHdIY1MGZsBEBa+Wnj?=
 =?us-ascii?Q?2VmBtnkMw9TcNt4Gx8Qi/PZKHboAy9SASc+n/OwMDlRZ4wen8J65ieODaVVZ?=
 =?us-ascii?Q?OlgCkoxDKr08eEt5pnJTEaD23nDC4GZGQOR4+EjgMEzwhBokHSYbp22Q0n/V?=
 =?us-ascii?Q?ewttpmqpbId7Xn+l4B3qJnqpkO6mhKmvvupWpYT0YjsYfWatqzSj7ZV15dwu?=
 =?us-ascii?Q?Biu//FH5zf29gDIDU9mUVz1InfjsQVSrkwsjjUPQCaz1NsxN9yKLEAmpIZEy?=
 =?us-ascii?Q?vyRjiQ12EzqNsUwow+NU+bv2CqCYcMjq7sFXuMR9CceGYRM1l+YpG577bufu?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d994c0b9-ba3f-4531-2555-08dbb5bfc4e5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:45:45.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMsB6vWgHgfl4G2+qAO1xCkP6LulnA9E+egeWo8jqilHdJY0aEtf1TAu+mOmOYE7TU6hUFJJ7ZAKHqY7EnCxrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524

A new counter mptcpi_subflows_total has been added in mptcpi_flags
to count the total amount of subflows from mptcp_info including the
initial one. This patch prints out it into mptcp_stats output.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h | 1 +
 misc/ss.c                  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 159d32f0..c110c183 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -126,6 +126,7 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_sent;
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
+	__u8	mptcpi_subflows_total;
 };
 
 /*
diff --git a/misc/ss.c b/misc/ss.c
index 2a584015..77fdd6e2 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3271,6 +3271,8 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" bytes_received:%llu", s->mptcpi_bytes_received);
 	if (s->mptcpi_bytes_acked)
 		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
+	if (s->mptcpi_subflows_total)
+		out(" subflows_total:%u", s->mptcpi_subflows_total);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
-- 
2.35.3

