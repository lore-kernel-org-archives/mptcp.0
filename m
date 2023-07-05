Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2210FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKeMFRVpTp2OEs0xa4V0EnDwr5zzHVBjPcrv2RiG1WvFFH3yBHLg6MzwNF+eXvOO5/xZ3NOvQKu7fd61d06bWlqHeMjjVI2Vwg7u9+prZvyYOa+1DDvqm503rGQGZz21u+rI3HSxQ+EFZYfCzFj9NQqqPRqjT3C9rKADW7tlJz4VvfNzTmCH38RJoay7Hirp8sQQFPPgadw7PElY41hEGaYylEHUvxxIdr/5XBgepUyW9IqORbwJZKQp4SGfEwYZDkLx2eyJNmh+5dpCNczPoX6xMEFD8QwytplpJ6M99ImsT0yYR/UK6USe19fQte3NzaWoYENGa1P8CkxB+dVL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=VgHEtOI3E7EYCgN/wf2W+aqeYNn3cx2rmvmQQVn7EMAUgEGmlXrmRqqJKzf3MaCTk29pFdOGFDv2MzmnV4fT82Clab5QvYpm0qfhsrfxgon9Tor0tlxOEAlQpuwF4HiheD/U+wBU2D5OL1Dq7IhZo0fmqx+M/4SMRN3kVQsIVaQa2y4jY/EpO7OmYihFwFMGLhlco91dd7poMe48WBoYnD9bs+MsqFb9DHzdNkACSKG8oiJbfSXwmj6VtrggEou46+fyAJTfNJrcXgsuFqYSI5dNy2fMkeVu5fsrIDBedXBsfCorRduLkXe+TrfkPK4biqzoUlk0iP/j2dgFTY8dQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=IuihkJgp4LXGh22ceZ1vAGhTA5L0hM4HTKPtANGdu3kg6gQhIq8ezLFFCkjCf6++OKv3+TzrvxSLk0bVgSrl3MQ+P5PIjxX3J8t8wmumprvo70dqJ1SZMMT91bA0md0CkjtqcsyM6bHskivBF/USVSxR6re/LTGR1AAF4P2A9KGF5N4g/Jpzo+V00eyzZ2BpRN4PKn71xYQUJWmWnPckrS6A1/YYyGHSDY3BQ+ctJnye1brUlVYnTmtp47TCcCMsL4fx21Bdwrld3ITJGOp537T84fiAgSlQioV7tEFEpfWiS7hKHHOBHazq1VYrJU2VfrVAqcr9bLL+c6xjry6kaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:57:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:57:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/7] net: socket: run sockinit hooks
Date: Wed,  5 Jul 2023 14:56:37 +0800
Message-Id: <1740c11d12f49a122ccea2927f3ac9f833836721.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
References: <cover.1688540074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edad94a-9e60-47d9-5b33-08db7d25110b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yBl45LmP/j+VL6zCmeZwORB8faszL1agSEC+251PEjILeWJn5DSYcHr6N+yro29nSCwPERX5SDCPaYcXc63V+o8yrZtTeA9fQLf/ul4JFFT2RVIx/+DAyoPyqT01AKySXjRX3+MM6hSx9dOxijARs9e3TopRla5N4hilV7j13bwW7KIuPVc6QH6BhLGlYOgGqE1SySk2EzfUchFMtthhV2wL0ZnfU/XUDvrjDnjvg9LPhEAblqtglUuGNe+lQkLJ4u2zOpC15x/LsZTk4+15ft70XzGUfIFrH+FRC/qEbW0cvxpzevj4DnYKVXhvNLe1zjiYyKF1VsbtYq9ydQxHEScnTFG8aLeNrT9N6OMUIxvKGjxQMSW3BBqyfh6UWDYTuTvOjFSFW+hxWNhYZ0Hg4QUfDwQf9SpCT+DlNsM31+rTIbZJF/dCS78mbs0+LZVwjszgGrh2sYkDAWmp5Ar9lFg45n3STKXkdJESrZgnRLcnotidyPfbce4iV3uX25s9XZ+hnCueu4DcIm5FEB+wT6Ecb6TClPMPf2RTViAHdTGMEMBEBgwn6ZlQF+jUdDN2y9M409c64MXmF/AiR/495fYFjDiDsac+TpiFgsWagWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(6512007)(44832011)(26005)(186003)(86362001)(8676002)(6666004)(36756003)(2906002)(6486002)(4744005)(8936002)(5660300002)(41300700001)(38100700002)(478600001)(107886003)(6506007)(66556008)(6916009)(66946007)(4326008)(66476007)(2616005)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pdhN++2DlM2M33NdclkRpx46xkl3rh9qqzQ8shYyBV6xOCqRdU5cvlhzY90r?=
 =?us-ascii?Q?7/cYKzxiU4yiHuZ/YogiQP+1kYKnCwVNVWtdiTeXFJVn2scJxN3MY/gTS6EC?=
 =?us-ascii?Q?5hpecW3N0bjUgXPn1uPc+qRHh0IIgQHq1k34wxShPjTVssmvi6u8WTOip7O/?=
 =?us-ascii?Q?SrasAJegGC6L1eYDq/VEPWLzFrqJF/RojgmPgBvGte80Pm6aFIWtUiF9laMQ?=
 =?us-ascii?Q?KN76rGu58oeug6GXUfH5Pj46ojcxyz7wrPFfkGZoXutLrKASMC0K3sAJqD2I?=
 =?us-ascii?Q?Gox8CXfUCSs2Z1pv0AEIApSK+SDKKTlAc8zRBiRdDaZX+AhrzQGZ03fyVud4?=
 =?us-ascii?Q?FqWyGIYbhAQRxVo1vLtUYiee2uEXFwfj1AqSZYlkLr+dHX32XTVrQuAxJuk9?=
 =?us-ascii?Q?z/I8m8uTazvpBh6w5MvaUuLLVS2EIgxqqZ2o7t5WAQ+S5HatCuEN4ZTdWp6d?=
 =?us-ascii?Q?5AQvh35YLC4wRpAZ0nMaUGtkjFJ6xEHBE/4iRwVhbjud8h7Z7i/Q3PfgzuCT?=
 =?us-ascii?Q?qmgU3PyAlliOISE9uLRCKeavouEZhqKA18+oGyE+8ej0vfPS8TK000lzr3mI?=
 =?us-ascii?Q?hjyinYK8JxdBjRSE4LM/UtXsklIW5OblAV2Vo0ndyB7xkRvO7emNfgfIMELq?=
 =?us-ascii?Q?z0sov5oI/MzhvWlwwVguejSqcK9Q2S7Hu9G4YAWbY0tvBCnFLykdYjdV6RCD?=
 =?us-ascii?Q?B8uP6wxyuhx7SnoAdTaTr4puqebdTIXr0dKtGvEirGUP8egj28gs43yA8JJ0?=
 =?us-ascii?Q?Pf7xcm0ICe5oa/o/84gAVtLaT6U/3Hf1tBkZnD7BvAD2Wk2MlyfryYKJppo/?=
 =?us-ascii?Q?7UvYl3M8MChsLKzZ017QUbfHe/mS6ICHTx600A5X27gKPYO+r9L8Us6lWFLg?=
 =?us-ascii?Q?yvutDawto6UT8TE6fcBk27ZERIV5IsyiAfkbBGHmALEQbwgXHoqwK6eY3c4j?=
 =?us-ascii?Q?HIk9qTQVHdqzZGxu4y6W+67Jpxe5POOnOrCYec1d/dGXFVxBsvgxLu5G0Y9Z?=
 =?us-ascii?Q?OfjlZCwP5QJcTvIoYob+GkomG5GCeHTO3NU7C75W22XFUja6J09UxOc+1zPt?=
 =?us-ascii?Q?aw2BkqEDS4W8TkkwlDR2VkmPrbf+rDuWKp6BfaoD7cRtJopsYKrYUHgTSSO9?=
 =?us-ascii?Q?Qh7DZmqavYOA+WEP2yfq5tuKCXod78FpXAJvFQM6HFD0dmQpFe+RcGgKqZkA?=
 =?us-ascii?Q?Imuxcx1jYnignT3vL3eQ/sLzPxB5kec78LVBrI9IeCE6CTydTW51dQ6rB/aV?=
 =?us-ascii?Q?S3Hi+vxNxcYo/X9f+vwzzG7xETgCe6izCLubt77fTVCL917ghDH2ROP3vhOe?=
 =?us-ascii?Q?obTD05fZEhDYaEiwrwj/+9grqx0jcH4j7WPnIbbNZebl90FsGGrMRu3APIrF?=
 =?us-ascii?Q?VkXyiHJ4am8NvEP7bdiND50M717e9RfapE/A+3L7xxx3NSDk2BN6nh39n1+b?=
 =?us-ascii?Q?3ct10//WiLqyxiPKoMsjV70P4oG4nAQvfSvmtM+lWGCLGjN3danVz+zt36at?=
 =?us-ascii?Q?OveM1r15tSNu8E9Mbv0a9uCeyiopHl5joxIoFUI/U8hQeshI4tqeBv/GLpuV?=
 =?us-ascii?Q?Evi9Sgrm9odXcBX6ppy3E5IboKiSyB3CUrMtAxUk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edad94a-9e60-47d9-5b33-08db7d25110b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:57:15.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wdn9zt5UQXOP8XPpG830W6hUu5yl/b0Stb3rmef9xP9Xrsd9MMF+CyaDcU9IDf8VryUoVj2QcMI6ojmClx8mNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720

The arguments of socket() need to be changed sometimes like the MPTCP
case in the next commits.

It's too late to add the BPF hooks in BPF_CGROUP_RUN_PROG_INET_SOCK()
in inet_create(). So this patch invokes BPF_CGROUP_RUN_PROG_SOCKINIT()
in __socket_create() to change the arguments.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..27b423e1800f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1469,6 +1469,12 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	struct socket *sock;
 	const struct net_proto_family *pf;
 
+	if (!kern) {
+		err = BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &protocol);
+		if (err)
+			return err;
+	}
+
 	/*
 	 *      Check protocol is in range
 	 */
-- 
2.35.3

