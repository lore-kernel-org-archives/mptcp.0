Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136122C80
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644364746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcCDJzHNV6kcFpm6QUQWBx6GY1KwXHjb2MCAhKpBMzI=;
	b=F06G9k11DWc4KxbS3b1RbaqF34H2eltGk6oVP6/dGGi92vLaL//J5ItqjYrjpKo5FPPb2n
	G0Otre3yO/udyeipDmqzQ+wTMIm9+qW9OyK4eVlM8sHa9Ff6uH1LCGASLaz0VDiiVE03p6
	YZ6SW4U9Fklvc35injMG1P+beQZT96Y=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-HtPNaZ6oMKGF_8MtzuScjw-2; Wed, 09 Feb 2022 00:59:05 +0100
X-MC-Unique: HtPNaZ6oMKGF_8MtzuScjw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP5CR+NK7NqaQmKmnGB1fStldrla7F8F5NqAh8PLgnyF0Ak1GnF8kXUhtOJK/Bg+Cu8BY4BdGcvpoMt3zza6npgs+kQAj0eOGpDUDi/vnTc/cTZifX3cc6zFPlbIgGnCaJJT6zVWahwin0aqxXGSna0lfUngF/JtvzY1WVQgjO+8Q6zTg6U1XXOYt6we8XouQHi1yLCid+Magt6n8HTaa9gBIzEXFWeRkgp+T1OyIi54VX5YmpBAXFip+aGI1SOuMWzm3/0poXmV67ojTqZRuzkkOBDz9bENE11GXuteOhQjJ8V+juiB2xrNdvymvOHC4jl6Ib9Ge2SPvN+cnOnAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a26/8dAG+o98EF8E3cZi1/wwV7DYzSfMYnFb5dQLUqc=;
 b=ZTPIiVBExKZ6DGmWG5xb9yI3MhEhp+7MPOPQRC1mhiFJvI9VGThd71sfsmY3lQRkzy87eMFLzTbHrIjvb72I/qckeuebXB2y6AoVsWPP1GwSAJrm5qErVnlQZk1kwo37o3igTwbbg60FGkFSz60wrVVBt1Rkl+O4ihtnrQbHNt0TOZt1+pDgKlTQJVcPuEx6NtDiY09FXWWSGjRdrZU4Wc6YDDwDRjLgbjkmuGA3hhl30y/BX7Jj345bvHiniOKU/SzSDf0WG4uCr0TkkCi6pxC6LlPm0FGq4dk7bIpOov4g+OBSXlbH3LMCCdkmU4+Pz0fYJHFcIRETd5uBX91GSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB2959.eurprd04.prod.outlook.com (2603:10a6:802:8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 23:59:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 23:59:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/2] Squash to "mptcp: infinite mapping receiving"
Date: Wed,  9 Feb 2022 07:59:15 +0800
Message-ID: <621a0237b6c15001e3590b27358dbb854c2ab6e8.1644364562.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644364562.git.geliang.tang@suse.com>
References: <cover.1644364562.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca31add7-7b97-4866-aef9-08d9eb5efc48
X-MS-TrafficTypeDiagnostic: VI1PR04MB2959:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB29599723C0B60AED5CC718E6F82D9@VI1PR04MB2959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	58TdH/S8Wvl1IxZ17uwuovBKIzHDtB8NLQICgqgxWfLbewwfubzBXj3ksvxkalQD6c/DOaanMDODl1MHOIVpg3lpmwXrjuvaXDtWjVS3l4GfosKguTkdcBqtRJeeHVmNQqC/qeFRQ4dXIsD2as2rqwFwBAnHLjswL+Sr4PwS3gbC8U0lxx6a1uedZ5seZ77lWNe9CwxjKubBlTsj4yKqa6P7K8ecw/TrzUIARQ46sHbUAAAHMBBu0s5sQluQTqhFd+xiX/Yj0mTk8NlU7abedhSCYGYbyS0h6f2FdZ1ckOvMiTjoffFL4eV2Gji21u/aNDZGrFZ0PAAr786F2gCM9mXkap3NmN4FSH1ymewdudysotKwKTfBsAwBd6foU/b6g0EcUsHjcMhj+FvMzfkjTpjs/mk0Ow97sBzqwX+NSk54fduMm+gdnQ5OQlMvt37PdPAlyVKBJPPMgkVXKTxttLQNWtcrDYjFSiNfI6TqE24/pxv7yADDdvdnyjPxhq8/FI2Z5D4b+x83eocEAMTFnvTqEfpQoHg7kA4ghw36IEsmrfYbWvaYo4scJGYM42ebiMBozurUVLftzdiUUu907yvO/usoPVotnii3+cwxxILM39tD/yvO0YvipozGCGSKd06plA91di3TzMKEKQ3vBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(2616005)(5660300002)(44832011)(107886003)(6506007)(6512007)(36756003)(38100700002)(186003)(6666004)(86362001)(66556008)(508600001)(6916009)(8676002)(4326008)(66476007)(66946007)(4744005)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tln/aBrSlNQKbxwcAi1E8fLb/JQ91nuB4uU2FaGYrBCu6R/tRvhVnxFaQRrE?=
 =?us-ascii?Q?/ACsxXqC2mWMKgRcyR1ZqLSmL/WHumTZU/IQo3kZDTYqDq8pXmh0pw5NQ42M?=
 =?us-ascii?Q?jIysixpfKrM6bWex4lV4uO0TjoUCzw9Rh/c/3alnTKuOWHyOZyHXoBt6mJ5D?=
 =?us-ascii?Q?fz3cHv6PISBciguRzMeLCrcRNDanoNspB+zL5+otd3TXIpQ0YbPrD2X60ZTQ?=
 =?us-ascii?Q?kuYohKkj30UMWSvvjgliSOmk26jGswnUIJiY+iGbkeKoknGNuDxYsuQoeIRL?=
 =?us-ascii?Q?linUg3rpOwyJcd98jRJdW4NiYeTmYMAI+msOTY7ACdoRy5mIFcRKZv52JgUx?=
 =?us-ascii?Q?uGuqbqfHyD/EIO2G0i+V/rmN4oPdViTEhFdiCNRNKocPis2XvDObwYX6Skfw?=
 =?us-ascii?Q?B57KaMdKXAKXi0tqPHgOrk+BTExxE3iHUflRrSH7IVqThBHaAUIG1JolEpbu?=
 =?us-ascii?Q?J8Dg8Bgdfre/ev1jqE7bH0gJLSRWvaqXz28NzZ2+x3snY4XpFywWgllG847f?=
 =?us-ascii?Q?MJq6R7eDcvjw/86WvO4Xv6dxEzvnG9xnFYlmVhuIovJGAx+NbmAGcnBFQNOM?=
 =?us-ascii?Q?WfzBX29BRiWXlN+SSGAMIIoY1I/yC6VqFWCQinTxQQj/AYdlHZUdF48KLAoD?=
 =?us-ascii?Q?BQeJtdfmmmRMghUZ8rFnYi3y/673eKZXFrnMfqWSt3aWl/AiCFEsLQ4uCj53?=
 =?us-ascii?Q?2GH4ayvNGRRFVV6qFFH5jq1AGCtrvvbPw6eATH71A2fQdqsHADXX/wMIu81r?=
 =?us-ascii?Q?W74OCQD6nxdfVHYlzMU8VK2ze9q+MgqsJi/7m/r/YHKr6vNcSc2ta9TprCt3?=
 =?us-ascii?Q?XzrhB8ttbHa9S8H4vXJJLKJpFzhAvZA7eRdjXWdKp9O3xgwo9fArgBrUdaqw?=
 =?us-ascii?Q?UtiCNABQxBxO3MPL3UOsnV+zuYtQskQ4jfK1vzBcdazqgcGvDkRdVqlyF2q4?=
 =?us-ascii?Q?LgmmzLWRP3PU1G5wMB/cvmm2RfWCUelwFFIRYqUcAb4XRTM1h1P6HYsITh3W?=
 =?us-ascii?Q?dFUILAhXYIcu8L8c230KLuxqdk+y2l0FMfq4X0u2T9wFqGpyvHtl976QHAWz?=
 =?us-ascii?Q?TyuL4N9A7Fu3b3W1BtbJ0W93FBJkML6AvQ4mbuQXiv0NZuvEqLUlwGoeOixc?=
 =?us-ascii?Q?VJwHKNrVIqDDO1ZrolUNnJhjoiCq+4ScUsIYTcpnvbQrJdruX6DN5cHtjats?=
 =?us-ascii?Q?L63Lv9N6A7HYcTTmp42eoUW3GF2LidoNQHAzYoyVlh7DpGqoldCFw1j5bbyo?=
 =?us-ascii?Q?yM0pLN4NUGleikMHWnWwIo+FYZG8ahqBA9wiFSfmIJ4uo6frNi5t4AxRfAVa?=
 =?us-ascii?Q?dRWnvcQ7o+21iZNadD1JKijOKcwGKor7265PwJtePyLbD6obBdTSIoTEgYNq?=
 =?us-ascii?Q?TfXFJ0BomgWDSDEieghzLuDAUraEGVxgc/Kay0MyS9N/4cDByHZeVIUW6hvP?=
 =?us-ascii?Q?1p56U2IK6hWHFsYUiwRbF3hdT64tZJVlq7u+FrGVlBlzfIWZ6Axt5+rv6YU1?=
 =?us-ascii?Q?Ag/jqVG1NMrmnTQ2jDORFDOGIXQ+SRv4tJZVP4zX5hvwkNW/D1NVat+FbxEM?=
 =?us-ascii?Q?zifJG+AHoJM5vusPxER4eOxx9dcUb1MSOBvHEPR+xJ4EQq5aAUiZfTlsvbZp?=
 =?us-ascii?Q?ukXRTcu5fLst5qGnhy/5FtU6q2tjAHSKNYyOHsA6Hd4fh9JYoZ/O38VsgBOC?=
 =?us-ascii?Q?uMLSpwuPynLTqmxhjPVfkJEAD5o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca31add7-7b97-4866-aef9-08d9eb5efc48
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 23:59:04.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzSPdlvc6KK3ORjKGJ9DUwmk8ixs1rhHqzz4bn0vjq4NnuzCVy8wC4vmo/t/hW7oA8ktt9GllVrFb6bSaJlqWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2959

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 485f00dcaf84..ae4d855f3c2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -962,6 +962,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
--=20
2.34.1

