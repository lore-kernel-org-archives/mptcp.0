Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139257D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkm/F8kIugYthlQHewxQiNOaKyKuHxn4X5zwChelN0E=;
	b=Epv9FxijEnqdWY++bix9MQazW2XHiv8lUiLAQVOUkvbjn9p/MKxzY9zgwmf1UNbOnJJE4P
	i8NWpxK6FYgnmIx+z+8LEBYqNsmng0Sf9ga8qZbEnrjehcJyIktK1zPzmLgzfBO/f+0OWC
	Q+GfN+2hVfZlrHFIqSbnBPYQwxk1vTg=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-fVC7sU4dOl-tLKnP_7_9fw-1; Fri, 11 Feb 2022 10:52:57 +0100
X-MC-Unique: fVC7sU4dOl-tLKnP_7_9fw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0pVKdQdzxP4AzGS48iS4VgPlPBHu2lHHT0wQl5u/nhr0Q32VtfINlRtWXTHXTI7zWQ13EQZgttIHYR3X1LvCKXaeLkNRo2JJy86d5ksRZ0Vt5oiO8aAQLlsziZyMVS763jY5AEEBV6ps/LAYu0p0h758E8HxiopFwZAKqTmrTYLfXDO1IIraJVLGiZ7MYidK46KSw6PLn+0zDVyGnavGcmBikZEUSicOwMW2RMkoE4TP+0AFk4H9+rHhl7WEFi4I9+tzmSdBKDWSt2dgNiVyqKJisYfkbG/clvWxKrFdZEX+0YR6XqbFnNQ3hPB/to8FKOLHbAGXs3W5QLFXCftaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZn+rwqzm+9fVwHDDf4wVUfLJIm9Nt1u//1kz/sYbws=;
 b=eKp6AuCiW3QeKwg0JHiCW7fgx740HtGqJZhJ3BP7IPnV+0NkAbRgIJa0/ondFZ/8CG/tw0pChhTQxV4qwFl88RDVyerbD/Xq/6ZWaxAZNJoICPzQzaoQwndiMhEd2QaCk9g4JJU3jhm+auoTqeFaJ8GuYdEQJreJ3NNxN0zM/CoYTZRh9rKWWzaAAomJPGpZF4vrbcFtNDUmyYYoILH/LoKRByMWURbH442SBXBO2T0NwaUqyGLkpMdEM2siXoBJwKkWP4lxeXDRAWv3r4lDApRV3tPjneAeLeUDod+ibzSC1a91VDp/q2I5GWlbQj8ty4+bCiJX2MkfzaheSIxhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8651.eurprd04.prod.outlook.com (2603:10a6:20b:43e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 09:52:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:52:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 1/7] Squash to "mptcp: infinite mapping receiving"
Date: Fri, 11 Feb 2022 17:52:59 +0800
Message-ID: <03aa9c661016c7b61cf84a421fd684a452ef0bca.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa7abfa2-77af-465e-2586-08d9ed444768
X-MS-TrafficTypeDiagnostic: AM9PR04MB8651:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8651FC872458A9512D41872FF8309@AM9PR04MB8651.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xe5/wcyb4Vu15SNxxMqNzxZYlGmaTIeZ2EnMb7Q9HehXPBtM/Pe4/LrdTBcCFXGvumNscUYFJ5272KGDhjXTO1zEJ+FImKF2o3W73dSreWaYcKp+fXUtmTtRu0Xt7mw0b1SD2M1YZXM3zztAGB04t8eH5/OvzqRME1TVKrogKlllGD1QP+XVfDWzkE4zAFtTbLf9TMZJ7geq8GFaZDmuY/XvVYGjk4GfeO7qy8pbz8jYp9XsrxeTLyshZ57Llzef7j25G8Gc4dWuTjNBDCbUM1cIkAD5IPOUnS5tIrBjTV58VLfXMaqVjLQw9mguyYGRoHjE1VcMgCkoZS4jKuTCfP4jzuQIw5AQzK0gGonH/Br0uq+WO+U4nwZ+iRFSEiQpQbdx9w7MYOeMyseWdTmux0ogBN+sIcekkbWeBGYp0R0VlALPt0BF1hFzaoXsMAZC6HRba0ZGpnWQfdKwHpWcTas+/ROXAm2YTdjbDaSYsNiwtnwtKqJ3TUEO3YrOgjnK2Dr0b1NuP+K5Z/cHUxhMJk3joDtQIx38uExFzylFwzvq2QtMftNRPUODA0fyK3+YWXSo+eVQ9tnH9xRi2p9WE2ua3Nf1ecAGeSadMlOUZb88mn1jaArF9TDxTBlSEraBm2ruPUiTrYS9ZvFsPkP/0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2906002)(44832011)(26005)(36756003)(2616005)(5660300002)(107886003)(8936002)(4744005)(38100700002)(55236004)(6512007)(6486002)(316002)(6916009)(6506007)(508600001)(4326008)(66476007)(66556008)(66946007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kGZVvznkWCQkLjAw2FhZ06sFRE1aXOJ4eU5vftJH7rAP21mCZ+ZdfuYxIP3?=
 =?us-ascii?Q?sVkvPnsEi56B9wjar8LqwKoRt64uem0+7nefREwbdy/PbEUpN/tUYtWIe6g0?=
 =?us-ascii?Q?/Dlrd4Vpa6eA1g5sdF6tTII1hZr/ulYzcX5Wy2GpNHkv8l2Pt0HqGLyptjLs?=
 =?us-ascii?Q?EWGtgMXfmj3qRbQZvCa9VgSl15oJ9scsfZdEmVRm+Yvh3X8MUmpQ+0C27Y8E?=
 =?us-ascii?Q?Jz4eeMBAWPuenNxm4b6egIYhftpmRx7jVJ2uO12XELSqA9FqWg1oC/5dZmSc?=
 =?us-ascii?Q?ma8qGvGcWgENKaMt1qkSQD3saTXSnJGTCzbul3LM9rHDIr2Hevgdem2KW6ee?=
 =?us-ascii?Q?1SWLaKLNIqBiM8qGZgSz+YH0DnLPchYOSSiWOteovWgae75ThWZ9SYKRi4oD?=
 =?us-ascii?Q?JRvSK5JiQT33WtpaqsWf16yRKK/BEaqTun60WVeYmv+ZieW7b3cpsh8YYg86?=
 =?us-ascii?Q?m52iQrDAMT1Ln2llBfWk+dTT5mCRz4IdbhIn53O3CIKiW8XxxOlqNCB4ZPT+?=
 =?us-ascii?Q?TSEHDVDM43bs/nj+BizExJYQpIT+fNKmyXpzVsGwdy96c8ZedJGW7PbgIS/6?=
 =?us-ascii?Q?1R/kYh498chAOKs7NjeWcFDzvWNRTrM8O8xY7fH2KLxs++w6/x6UROMEPSGT?=
 =?us-ascii?Q?DTLpXrRlhw4wJl7IoM7V7pFmKTvtWhni7ef80eCmK7KCBLN8SksIj0b0RmHe?=
 =?us-ascii?Q?Ez1CUcO5+ziEVbopNDj0Rz/NdEIrbhtS9wDoJzvBxw5O+EGDuOdBpQywdHIs?=
 =?us-ascii?Q?jllInutxzfbj8rNZFPsb82G3AWMiZu5TAAiro6d9/WLUPjLEI1Zr74SySJGY?=
 =?us-ascii?Q?GCDIBWuHcjipFWmIpwOBJO2vY1qtsDTsLOtrmj/LcP/vD4OgAILTgxf8CUFl?=
 =?us-ascii?Q?uZbN/cv//YmJVCkOC/o+SDDwP5Wl65Yl371lBtgc9J8UxpoZZdevUlASGPil?=
 =?us-ascii?Q?v5Zc7Md115wWjifB8hpxjBrO6Jq+ojYP36flNkV6ay2yd6auXGn9Ou2Lu1+0?=
 =?us-ascii?Q?PEHVhoZ2rsEFgtiDsQU+PLXpzq9uO8MLYevdsaCc3UFPmUQ/o7j1oGIzNIkM?=
 =?us-ascii?Q?v7xspp3LeFZFTLvDV44Xp4c5jdOu9dPyYOm59xdEU7dfStpu6seypczXlqNR?=
 =?us-ascii?Q?yOAiF/05GA7Uk0ZRnham8diHDJk+86hntGnhR7ewZ0nPA8ry7WBBPXY+pfDP?=
 =?us-ascii?Q?EhEyng8NYYN2Jcji2W8VeGYmK5q2nupRIqpkmtI64SzBlXcK7OrI3EP4XtsL?=
 =?us-ascii?Q?ID11FJXX13/MRFxgjpd5a7oS/cEAD3/NzfEd09tvpTpEyc/UBrfZDu5xsiwL?=
 =?us-ascii?Q?2lG6usLoAj/EfN7aZktkNsvNBI3Bi/h960kTK2Q6iSGaS40QjqegJswl4LBu?=
 =?us-ascii?Q?MKjyF5QwHVly7oRDsJsnFLrvf3DYbgxFLMcw5k4nbie7vYW9ayl+hqqeKi2g?=
 =?us-ascii?Q?LmsLw1W5wTJw7ggo+HVfKHDEGTCNTEI1vv4obCVn8crGGTzQ1ZX8dfa4MgCq?=
 =?us-ascii?Q?ppeYRVjIzfjr729jhv+QK0aKmZT2DVNaaZWncsiJzhHhK8Ht3ZBM6r5BUZoT?=
 =?us-ascii?Q?SR8rIkZYvZOKdLBBzzRc35fM478sr2evs6PAAcwe0nSJmvgCkuGVyjSsNV8K?=
 =?us-ascii?Q?JSs2EA7VwQ48UdaLIZvSChg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7abfa2-77af-465e-2586-08d9ed444768
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:52:56.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ancJGBHP/iSkjR3mSot7WRHVPMl1YOykEck6GRwLFz1cPmSnxLm2mJbAHjADDgFyWs+Lplp/Ggy4JXpZDDgdRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8651

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b53b392dd280..250ec414df92 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -961,6 +961,7 @@ static enum mapping_status get_mapping_status(struct so=
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

