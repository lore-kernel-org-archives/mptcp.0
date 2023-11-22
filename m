Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB84AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="xzmokxa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVE41iH9y1nMuLbGTNmlSCcCg47SOyZXa3n56zx0C/t5/Ih6+iDXu0bqqrWNgeEFWjObJFEJRH/EDDgG6ytyxpVB5MTuA+AvoTmBTivdJxwM3/aXosIagORhiBIE/gIn1MN8EGOh1EzUv192jxIdeLIWSL5fWxeLlJ5M3Row+ON2ohJdmazW98rcltrLdeLPMbrmwLlD9E5UPuYHe7L1X+UTJvw9MEyWM0cbqhYX45lJ5iQLVgJoPtz23PIuSZc3xOw+WEpre0EPzlBrVjYP6zIHrcVBbnSs00wDsuE5G67I6Dv3iCeL8u9lb/8RcNQcPFTZuXOIpBXLGV33N3gD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsRv6aGr6mmmOPvTXHhXyzuRdf8FIBdg1IzuxNO8OK0=;
 b=aIWXmWjgNKefj55g7weosEODl85LuOubovr0SdVLwDyZIUe8S43yF2+q/vWi+CowEplyE86GNxe21N9quKHynhEMt4KJ8MFDYsShQk3oExnhHOuOkeSOQ/eBiiVmdUMoG+yKDF7LXG/vxyuWjWRVdrLQV87gz86IWUmO0jTJeuXIPX8+xI+44q1RgKO8b3p8HwSJal9yZoHb0lbbiZuGZ9dAp1uUn78X20uDYJx62MFutcl4by7Ab4PYxg1N5fwx3fC41oNq6lifPU46wfQeQs5iKOWy+m6W1Z4WaVlX2pzghlelAmiwimU3d1pGB1XHZEPcCrLg9fxlZ8F/w3AMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsRv6aGr6mmmOPvTXHhXyzuRdf8FIBdg1IzuxNO8OK0=;
 b=xzmokxa4Wd7ilRBpMOJiYHgsJgdEGYCYjT4mP7LPQiUQ/6+E1Q2uP/6H7yOhBixvR/sawePc+5MfXphpv6vsM+kruOXlU9+alj1gBh0d298VCoS3gXB80wO0c0WAL9Ib36+VI2hKOq4sIEytO6jxNVZ9lmelILxEccIMjkagwOdftHYNbm+u0zrD/YEyIQCP9pZ1+gHaBQxLH+JNaQU2bzcoBqrJYGK/ES/qpbH9fSlQlx3egksDJgUM3TTLq7iXa7+GsVpfzQpTptDLIIXSVKeWyqJetAOz0MlHkWu/Sx4LE+Zx1L7gEgoyoX2+78uSnOkCO5n8fKhN9aM59B79CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 05/33] selftests: mptcp: netlink: drop duplicate var ret
Date: Wed, 22 Nov 2023 19:30:53 +0800
Message-Id: <b3ba1abf6e0c1cd0b995f9c0cac582b71c8f7f8e.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0016.jpnprd01.prod.outlook.com (2603:1096:405::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ba8e66-4dd6-47c9-fc4a-08dbeb4e9b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IE844gft6xERWYklI9o2pzJHQI/RtIkmJR2KhQCPzJqyRvTqhg0dyx8MUNNhgXWgnuZYT+9FBnDHpiWG6P3WXV2m+U+hc2VSu8zCqgXfM/ef3xSUGNNH+I6j/u7w9SpEAx87HiMYJoX5Tk5CCJqX5IkYrV2ypSBWy+vmPLD9lhv8ex0GmTh3zMsOy/ja+IKGuvH4RCFN9SN3c7M5RzqwsigITx9F4GPVCFsOA/UggqexaPFNUUFmdOwQDYlGn64Z2nylWvUVMDklPsPv0zv9yhrtLEab8i8GhjpFrahUhFp/TtuBexqy6BKN+pSAE/qtVodQnQ3MaS8tXp+6rSYBvfvZ/ev01QfYU5027AQqA3jkb57S2medukn4vA9I6wovMSe49Ua0Bb5IcLNpiYTLodyXwzeZMhdVwGJeGyU1p6YwAg5/hAeozD6EwH5HmXL6DLqqrrfpBCsTUsbxqiftGwxJ9mZ1rfob1YnzpH9hMsAtE1spPhlFal0WSbCjsmlAvzLTj+40z6pOnsyjm+P6z9KuCm4BFhpYvUQo+2eyPBlvYdStonxqNxlQp/gnWzVYCL/SV2roJzJ3WEc7kpjSfFI76rG2ZPxhFx3kDlqCFCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(4744005)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waeJ61meb3odJhSSwi+VHDqwUz5DtyD//7MvKJ6IsGdvHJNG+Ai3GtuPAUZU?=
 =?us-ascii?Q?yVetcgf0sPrggZTPEleXYDFLgorgOHSBDVkz6ZJyaI6AipTlmletk3rEccM1?=
 =?us-ascii?Q?lSnVpUvdZE1Zo5P0nH1k+4qZVDGhnCvEei0A+zIrAHWEf7PahiLiqGhwEe6A?=
 =?us-ascii?Q?jWjsQNZpIlbkm/o8608bqmQDExOFKmfw3GPJrI0XScKYofFM5mrqirO6H2rw?=
 =?us-ascii?Q?qsqXy4w7sB7jdJdtoVpsuv2+5A7GR060fMJl+raOw7vHDQUgMLvTRsnnUHzs?=
 =?us-ascii?Q?P6YhQwZF6L1E0Evq1IzRftLpQCurOvee8vXMxaYMBN9cteDosY4z6OVaJPWX?=
 =?us-ascii?Q?LiCNKzsSHSGRNZw0YzqLyA+4KH3x7OiMidshqk9HbS4Sf68FMbY1g4YvAUhr?=
 =?us-ascii?Q?pY7yUkt627fjaW+Lua/IueC5Iuj75uJE0ZSdbt6Wr2QM3xoT026b8I72urk1?=
 =?us-ascii?Q?dr0i8YLR5ITpXj8s4qHnEtDYOAVLctuVxDRnxz3BR3p/JOtdGNr3a9CcURfa?=
 =?us-ascii?Q?TcwTBN9Oc4dafuSHSntwoBP9aRPqChG9h9ZT1b43bbLopTzVIbtk97ryDqoQ?=
 =?us-ascii?Q?CprAcDBor+c3yUDhxu+dxYteI7aOQnpfP9a6znnLf0ELftS7VBlaxP0mtdNE?=
 =?us-ascii?Q?xWjwIdgzgbbZnwWvRjzGWMbj3v/9zIK/O6nyCGgNUUyknYdqcwxxCKfkxt9N?=
 =?us-ascii?Q?dldW/VmmdiPAUnmDqSB6WzWMWLFEeU4yBQ155Rfwvd2FUXD8IbAVvQUb1Hak?=
 =?us-ascii?Q?AQkhG39AslN3Qgq2nxVd0qx9Nbk0dEPPpfYPGQiof4i0WEP34cK8xhre3rVi?=
 =?us-ascii?Q?TGdO4wDG0r2MDAs3aZ9BEuzxVcwLoMBSYmapSKoIOyD+vQr18imNUFnT3jje?=
 =?us-ascii?Q?PcOUGFHy89P+4of7YANtqdrTbpG638HF7ocm0wCLXhlNfN+ERsqcCiXHruUQ?=
 =?us-ascii?Q?VCpXsoCqTC8ozqTeCWRYr+mM98/PxuOcE8kZRjr+I1fX5qM9u/TJoMDxgJu8?=
 =?us-ascii?Q?3lg8pfYzdIDYMndW4A6aWxto6hXiVdYFu5gIH3t5TbeJR5OtevIhCUD88AtM?=
 =?us-ascii?Q?MdGxOnNqkj+VEtBXLCHohLIkurLUsrrM6lrlr9hCthWHaGwhdPh8+M+7mzfH?=
 =?us-ascii?Q?vSE9Qm9J5ssRWbCtrRAjX6UUh+nCByHMfUs1blDTcBKTy7QynEmoSL6Xksy7?=
 =?us-ascii?Q?OiZK/mWmEUoUL9uELdVS+HQWey7/01F8bAh3IEaoEUoZovQpGwx2lfpRosTH?=
 =?us-ascii?Q?QkI0sEDLN/YFXZKPfe0ZVbwuWW2sP57giiFLScruK1N4FXj1PD/k7y0uTilI?=
 =?us-ascii?Q?Fa8GWn+1uYC9JyF5I6TT3lxyzaKrC5+RRdtqZpEJtJltcxMH3Ly6F6kPmjSX?=
 =?us-ascii?Q?q6cidFw/aK21wIE6DRXd2v9nEl/uzqCN6WRpXbpD6DOSygByiGgNkrgCT267?=
 =?us-ascii?Q?Xlahng/BBPA71L54gJ9P6iRpCxPELYh34TbS2B+zhVZsCAPn7wuHzaFQRZch?=
 =?us-ascii?Q?LvnLIjIljSP6PBEB47c2W1DpvmLtiBfu1awJrc3Mqg8UjknpFmoxuafUij4j?=
 =?us-ascii?Q?QPbnZbCNy5juMRmc5CSNuxdCC9A2ABfSg42QXyMf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ba8e66-4dd6-47c9-fc4a-08dbeb4e9b5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:45.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Unt+ij7EGLsAZRYHzHsO+6KUG2bAPBdBt0RFn1ZrPlrFfLD/9iPyeJyzcor8gZ+80COHJknXuqxhhc4sszvf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8d30d4a1db57..e995dfca52cc 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -27,7 +27,6 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-ret=0
 
 cleanup()
 {
-- 
2.35.3

