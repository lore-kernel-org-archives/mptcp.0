Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C6173
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642842013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W+LozFGjpQiE1vNLPqc37CRuUFtYcVKg4t7g/3f91vs=;
	b=mDFT1h/rfmSacnf5U2p+VqtwQY/fPOVpF42c4U825IaxIpDkSeAVj5rBYry4mJdz+VaXVw
	liOduJ+9pys+phaqYgwJGNbPJ24xB60Q96ypnZbj9MjKApDLyWRGodhCSprOnuWjW1wCky
	W7tDwc6j6OChQzBDyQ7eUM8P1lbLUn8=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-P26Vuo7xMrajcjxV9c_7rA-1; Sat, 22 Jan 2022 10:00:12 +0100
X-MC-Unique: P26Vuo7xMrajcjxV9c_7rA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVcuM/pr+ZJTIHFAdPDhEADiRcf0fLLVdGkAIkmzUXRfdSUw6g/walz/bWtLj6fi9l3D/RvFA4AkqRz5xBb8BCr8WMT7z0O3kSBhPak95dNn2MeOL8FkSWUMOby9KXjpnBmwQjB4LeK+HLWQaSkIWE+lEl8DMg6l+DVw9rvHGy+ZDCVQHk6ZzDn0Ew+43tngALf4vZLqU50Rq85XblN5zbudlADRncwr53ONFvBFHbs4kTO4plwCVEEqOlbHIXZQOwrSWWeYAlsFjTm87M19pr++QYFKjRS+OycugGo14NA5Gea3kx6zXecJzBmo6DiW/mF902kcihIUk2/QmHrYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YocGaRCZBuQflGcHmXs6spD1/RSYcxRxmPm6WhVme2U=;
 b=FKK4rZMKqcUWgaKXU6ri0QcK6Z5vPUXHrZNW3cnNB3IhgGrYxOp//5KVSLWKWSk5yDybGcO5mrJXUnQhF8ZK78XhS9UrlkRQSDn7DFddBajSJZa+MMreNZFsdRbTORJP/dZQpKxahX/92vcztQeGMbA53HncY7SdfK8YPk+jIeH9ZQ1J3zQDgXkW4J+DNQpFYrfrt/ZCdxtGg8CoEX5+r6nqpI/UeqjQEE1fG275oRaLFS+6Pqs20iwWAzm4Q/LBxTlDazxWAL9IltsiauVuL5XnP4U66N1KV1coPOfd/8UIBa+87JvgOk0YsvyheLVo3Pppe1v43scaTrKDeyNCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8854.eurprd04.prod.outlook.com (2603:10a6:10:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Sat, 22 Jan
 2022 09:00:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.013; Sat, 22 Jan 2022
 09:00:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/2] add the id argument for set_flags
Date: Sat, 22 Jan 2022 17:00:01 +0800
Message-ID: <cover.1642841713.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0215.apcprd02.prod.outlook.com
 (2603:1096:201:20::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f84ba5c5-ae8a-4e21-9b62-08d9dd8597db
X-MS-TrafficTypeDiagnostic: DU2PR04MB8854:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB88547B62F942EFB64E882147F85C9@DU2PR04MB8854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jDAvFsacaTg3abIHWyqQq3pCWb5e59Gw/ofKNx2EYcLicyCAOJ5mkQwaBZ+aVeZ9xUZyODQLYEqXGMbsf8hd+7YtpTIrbm+ltBIjRQyL6WeVt0nLshREXVXtvzWDMLEM1EXw9FeEaBio3OtlSH9AyKIVtFiOi1fUAj2EsMhEJyWLZhigHnLNWHZXUFpONDW+t93ac0vi5R9kfEehSpCAsQEMx79WuiROjv00m5Vj7VpLqyzPEXWr8pXDHbz1ftvy4VMTAK94EjtXODYdcoHN7vRaOHbgMqOAsHV6VcO24rpouzzZdM28vm02UHjjyBnw1itklPNXY6Kkbjb0VT5B+p8oZTA0ksKmv6EGs+mfFXBPqdlnzfXimnywV997K9BtGO0n88hdaoCaAhQrMCM7NTSvSJJhOeoIc/6nzdeNPdBdYe7Rm3mELIbXybMKEJHwDUHvlgCL+viQG0rfUUkpcQzGUpgP61MHjPkK+oJR7EeNSdjptpRVc6amq+OLOrV7fdiPAg50ozIShawnnrEpeM0nt5/uiIutiRC742Au3wQqz9Qju66NrwMWTInLqL8xSMgVRCC0vQ9hvUG2ZX9zsLikpzClghhVciabugXVsQ/bSD2LkW9iRPZr+G4QhNd6y1/aMX7HYc28wz3318gax48U6UYgIXc9JkYqrF5tZBLvQk+Hjju6LEuhsxxUkbFulVWIR/KF6hcQA3qjKXy94A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(4744005)(6506007)(44832011)(316002)(83380400001)(5660300002)(508600001)(186003)(6916009)(4326008)(36756003)(6666004)(26005)(6486002)(2906002)(66556008)(66476007)(8936002)(66946007)(8676002)(107886003)(38100700002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lxG+SBGDRJTV2iZsPm9aYpMGMN0rFe0DUIDP3INXf/3iEctR+4/GkYhbUcH?=
 =?us-ascii?Q?QT4PI062pqWY84BizIfESjx2+hriGkRLelILVQM3mJp+l/Wu/q9dU2jQV0tG?=
 =?us-ascii?Q?2eoWRfq03HXOdftJjhSBBnUEIftGc+fFh/kcKntGsJoxnls23qsPQWTlWDIz?=
 =?us-ascii?Q?QanhirlIGkYqX8g6rWJKVtRkaxh+tl2XYG1IR8l0HSD9bZXmFF2bBtk1hHUw?=
 =?us-ascii?Q?Jvl3+tFsJmExMaHbW1WalEd7grWuY7BBvLk6XEZ6SXQPEQDfHBfeUfHA5yIZ?=
 =?us-ascii?Q?dAAhntCYzYTzlNX/jXLBcXcarQdRchuYu+hH5h/D1jSPFXD5SycbxPVblXkN?=
 =?us-ascii?Q?ypkw6G7oCN8jzi1mQfLzwt4AtVlf7PLJcIf3gyKiGmYQK1bh7YYYXZjOQcy3?=
 =?us-ascii?Q?QwffATNgUXNr3dzo/JEdeq+gZBrLWIOjr2fQd6Usl/eRknIGGr/idETZTYJq?=
 =?us-ascii?Q?CDBNPtz9Pw4/JXpsqKFGx5jm8gAxF8uB050oF5s76bPA+nJEf67gJZS6bV0g?=
 =?us-ascii?Q?eXmns6dukrFuCpjUuKdr+aNZDCuDOi7Io/uebvinxds005DqA0dDc0w7IIeo?=
 =?us-ascii?Q?yWoIetYlWU0H5KRU8KcBOuVfjbSv4vZwPt9yfTh9rOM4pMyzBmleddjZbGGk?=
 =?us-ascii?Q?VyY9LyXibRdYFldpGNP+f10oZKk59CuHt/AxtGb2oPjJptrOGJ3HOpE9hTdu?=
 =?us-ascii?Q?Y1OZhQyZXqCUtTrVGsoIZzcY2d4gXNws5xtUqGj1P4z0gEOCUUt0Kr0ACuiy?=
 =?us-ascii?Q?IK6jGFSXdsOELV3F/Gd70TxSJQimYVZFOUf5+iXievuXOQDYgIfMsM7jVm8G?=
 =?us-ascii?Q?sq0iLG5c9UYoBOFqdK7hWJ7aeOEdgOD7vHHNdC0m+yqjjs4tETB5lwSpNdXH?=
 =?us-ascii?Q?GwT9DlzIGZi2JXYOstooMYo5Vy5JXruiG+o6wm7rjwFg+ut3d+AbwkdTHqKy?=
 =?us-ascii?Q?AMKj7T3L6sJyKRFov8dogcKfZJd0e2xmhzLZ2Xnn8242XoXwiwtoKu64gEj3?=
 =?us-ascii?Q?srQb7cyyNwGrfElJVCJQxCeDIWfoTRz7jokzDxE1gqE/2d/Jw8LRnQdyEG8M?=
 =?us-ascii?Q?j5mGnqD35ME6KnLa+5IAvOITM2u8P8Ht8jW3q0tMfPPTUFgLrGKDVWAW5EVT?=
 =?us-ascii?Q?4c9ZL5UvxQIozq/wa3n/j6xR35XyaUMYfC8vY7SEvOmlFiQvR4q56slObkKW?=
 =?us-ascii?Q?m/WsYv9jLhaASENVMweivPvMirs2DGlA7jIxSp6TrVKd7ADCQGdVS/eKH1O1?=
 =?us-ascii?Q?WUMz/6f0RmORexTmYcr5C0VuHm0gk1UOul5fCJ1ES7ZXkkfHLj7sSyn5lXp8?=
 =?us-ascii?Q?s8kch6q/ONVThvb0JUFIDREEFyUTkdVSsRLWl//iopu5GclTMhRz7E2SB8kL?=
 =?us-ascii?Q?aE6CsXZwMZj+jhTHrOrepef3XZBgBQ+/j0iJ+oKFmaOg3cNiV7uSQHgwkbra?=
 =?us-ascii?Q?/5k7mrpSRy0Lr7bxSd5hg+ubtoNAiAfmcSVnyci65KwoxzW/la8PucWdOSL8?=
 =?us-ascii?Q?oxopWyXu8TPEOl6uIf/spTEtSvY2NGq4K4aHjYfaxGtZcB3aDIAHLlC7N/tK?=
 =?us-ascii?Q?h2LOngHZlMso4L6ssqgERE3ZaMZ3uKYvKdGig7dUuv+jWE3g75J6HVU9ZNWu?=
 =?us-ascii?Q?KSsWbxtWl2Bmrjk5pVBCOgU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84ba5c5-ae8a-4e21-9b62-08d9dd8597db
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 09:00:09.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcT0ldAFArMFg0NbI/fa3XLLfnGxk8+zXTbsgOouWBUi7fI8XlpyiFx0rOgKWT8u6aUVIGoxzx2owNI086STrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8854

v2:
 - make standalone patches, instead of squash-to ones.
 - add test cases in pm_netlink.sh, instead of mptcp_join.sh

Add the id argument for 'pm_nl_ctl set', and allow to use the port keyword
with the non-signal flags for the setting flags in 'ip mptcp endpoint
change', more commands can be used to set the address flags:

 pm_nl_ctl set 10.0.2.1 flags backup port 10100
 pm_nl_ctl set id 1 flags backup
 ip mptcp endpoint change id 1 backup
 ip mptcp endpoint change 10.0.2.1 backup port 10100

Geliang Tang (2):
  selftests: mptcp: add the id argument for set_flags
  selftests: mptcp: add set_flags tests in pm_netlink.sh

 .../testing/selftests/net/mptcp/pm_netlink.sh | 10 +++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 64 +++++++++++++------
 2 files changed, 53 insertions(+), 21 deletions(-)

--=20
2.31.1

