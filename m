Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440B7F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkm/F8kIugYthlQHewxQiNOaKyKuHxn4X5zwChelN0E=;
	b=MZUw/3BC6VK0WpM2TiBQBLUnrGEZyxnte6sM9o6DO9Ckyi356f58vpWepEO/jfALRdFXhW
	VSshm6SR3RwdSXuSLWFoxc5bX6Wf1BjODTp8IQ0yjwpmwoo7AJBg46FpC4PPEvahJkO/5n
	05TE2CU8u/srLCb9dt3BVcCNeJNAuBE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-DPiDlXrdPxedCwMi12FX4Q-2; Fri, 11 Feb 2022 23:45:33 +0100
X-MC-Unique: DPiDlXrdPxedCwMi12FX4Q-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyB5sXhJnn6i2bG2yxeJNKdesb8pLm0znS6kyocmbGMZ6mpbFevr+Md6QyGgAD4pb/+qNkFbLeQaW4YWm+OdCOfNxw6tlKlQyW1clRDNs39Sw89nkpSqnQeKSESTbn8zfF2sarHzfdAnOkkCcCH8owWXar2XjVbP5u+fUvRTSYKwuW5H/varBaO+CBPZUwrw6DWuea/gayUYjY/Y3/u2ccIuP+TP2XTWPGR2UOsaZt2wtJexynOJJq+su/X45nOD2Ie17t6f6cqzhq5K2QpR8HI2vr61C6weX8doGFVVWK7ukxFUq45J7JDZSqyji+LLRKrsoO/fookC9vDNIOdIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZn+rwqzm+9fVwHDDf4wVUfLJIm9Nt1u//1kz/sYbws=;
 b=SkLjfmbYh0hlil/NFxv0rHUBU69pC9EV6KinJ85KDDeOYBpNO73bBuYjTQbvh5aVbD4n45MbynqAdeQXqiJfBLybKiwsdvntEIozALhKTF74sIk7LdPecvxPHW5iMf0vKqY/Tp0fpwCsjGOJ6duMWkns7B8Vaet64OVyLg1zGxj4geK38vkDBRodLfszNBdRtPQHWG6+wOuWbceW+zLz7HZm38rOlagXDAauqMgHLJqb2Cez+DFHW1F4LMhfN5G7NdrOwGBrKLzCfixTzz8XPSIiudqo0/852zaxLAxAXcgDvf8v9hn/K3agSPLCxTpSvAwn874yQwS9HhXM0j84qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:45:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:45:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v7 1/7] Squash to "mptcp: infinite mapping receiving"
Date: Sat, 12 Feb 2022 06:45:37 +0800
Message-ID: <03aa9c661016c7b61cf84a421fd684a452ef0bca.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644618926.git.geliang.tang@suse.com>
References: <cover.1644618926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22da9da8-af5b-42f7-e633-08d9edb03608
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB56528FA4C576B8CF54B0A94EF8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jP/uBc3qs+dU0bfftOsCBuoFtgiLayZR83u42x+Sjv7aka01uQ5Foy50GU/S+a09dL+IGI0rTl4Ux7C9vACOM3wY3p1t0CuyuCh72URcNr94iuDY35kjlMYf9Xme/6w2ix3+H0XOvGnK/JKafvlxNGXTKt6wrjjhoQrG9e56g8fct8Ii5Cw+1oP18wjW/e4tFLOE60Q0DGZfWNJB94OHRtwHtY2sPIvlqHFo5AlbzoEhG0/XSDjWI3iO9VyeumVT4p1n/VFpPm7LOSjgnku3Fv3AUTZeAaqU/A3Uc7/7yyOfnKZSSwdDLIp6O5PXVB4Nu5L8f8dZnhwx/JGfcVDZ5L+GIB/sk/46Yeu+4VvFv/J2tt3s7ewAdGW0fsqtW9XNaLT68g7VWf8wm4ZqnBDXYU6fxzcLw/qt/JMBG4kiMFm9nUTVNC1jN1kLIch3bR0WIWMC2tF8jqdOFvu2cgcZwr0bFZkz9Mr5gJTtAfRZt6CelRX6FH6kgyf487SJXWFovU3snfVA70eYNAs23BWI1PUW9q9Gb6/+cUhaZ0e7i1IFMVVCc87F/finbhKXRiK+79xI5JLiqrEkonB3Ec3FmfyBTChZ5MW5xy3wtaBpvQWx8I09+9dMkMoI0/VNCZ6jUqaIMiCQDlcDsMojs7wEpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(38100700002)(4326008)(8676002)(36756003)(6486002)(4744005)(508600001)(6506007)(8936002)(44832011)(186003)(6916009)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cn/VjkC3oF9zOMhF6ICWsWZdxSyAKOcQysMgJTsWvMaIrgXQuBdyz3ZheMh/?=
 =?us-ascii?Q?QzhD0i4Xsply6o/Ynq6vWDfXbUtWfaR9WAKoLiowvSVXVvpGwHp1T2Idbd8R?=
 =?us-ascii?Q?c1USRR1IhSx2rp+2G1bcHFpz/iMStFyfYyZFyg9+hMjd7A3sBvtI7zEbW5rG?=
 =?us-ascii?Q?0kJIywe4cs6PZ3fXBIHArDtDJzl2yiZ6M/oG7pBsdE3Zg2yxlTgXsgiSIeO+?=
 =?us-ascii?Q?mt6HrrsII9TkHTDIMeErtHzZgU4TNMPe0x71eS4D56D21auegPZ3z4YWXp2G?=
 =?us-ascii?Q?aGVX55Lkl4ceA3xowjRvudj2fREqtezqzsMGhAZmbBRPs72tuzKJvy6flsED?=
 =?us-ascii?Q?7lnjVbX8ExzjRXZjakp/D2yuf92pVbXOUvp9EII7Kwv1kkfYSV2WXa0aaltm?=
 =?us-ascii?Q?Wo7s4JadJxsnIhFFlmhmW+b3XnXS4dkINy494AlJ+vkbfACghoc8Rq4WrIvI?=
 =?us-ascii?Q?hw1MjH6iY3J+TueP5AO++Y2gCwCxTN0F1ZZfVyrI4mOpo0KheCJMmvPbzlw/?=
 =?us-ascii?Q?MmNBnZDTRJN15CrWJHgdKaRKi7EYtacq3ytkjKBLkd/M6N+fOVI+ZJogk/SD?=
 =?us-ascii?Q?dZ/LMFRg+rKFdyuPh1gqa/6SCuQjsvKvU807RxswtP1Hb99XAT1E28Ad+3SM?=
 =?us-ascii?Q?G4NX0egIWqtKjN+bZFRUNCTDbPB6AZVmmAqu+OVeduEQ1ORwOre/SnxDfvUW?=
 =?us-ascii?Q?TuLRx3mLIPxq/IxaDZ+ZZ+7SACbLJJnw6R3CftvQQlwpRgPqruWf+ZI4xON/?=
 =?us-ascii?Q?qInl+MlNL+t/UBaY/Eq+be8SD0vIB+S4RRn7lxKhBSHOpK+oInznmHUuUT2z?=
 =?us-ascii?Q?6d/JcbyhG6MSjDhV8zsDHFsmZEuZCeUDyvNFx0CTIFONAlN2p6M7wP83CZDG?=
 =?us-ascii?Q?kBvPFJsa7d8us/fphol2i6WVuANjcsYBkjpI5x9HWSYBPjLSzbhEcRCmmGxh?=
 =?us-ascii?Q?4jJRwN2IDM4dbiN8Xdzs6PjYVVBLHDIXPuCu6H1KkhmIU4b/45tS9br4pt5v?=
 =?us-ascii?Q?1Bj89zgx9Nvk/XJlx86cA4wArY9oSAjiKDsCFVteAaxtJk73/HAvLvK936xv?=
 =?us-ascii?Q?KZkC3VhoEQb8xzGXvuff9cXtONXwZ9ljkD7CAqwTejLMyX4hbjqNDrAZEIV2?=
 =?us-ascii?Q?jmfrgZqr9YH9SmkuxU+X9LjZeU5tNM+tXKVDx4UPhKsBLiuuXvWt1Qz0ousV?=
 =?us-ascii?Q?s1OhkbcCLlk3NA/woE/Tw2IIX2E1wZC2bcAbR04offdsyXCo13B3oW1UoVhs?=
 =?us-ascii?Q?lUf1mKAbEsvb63HC1T9yljufPUUO6BDEhbn8WujDZspWPpe4tcfFIE6njHHc?=
 =?us-ascii?Q?edcEz4lEPoyHx44V1H2Nxfk+F2C5juCBdJb8KWldqfPPgBcPBAWmFj0vBYv7?=
 =?us-ascii?Q?6W+Ckj/+aB6KLtw32gSr6SOk90ANbSZwZj2LcRjVwTxIzgj+DJAHhI+CvpPa?=
 =?us-ascii?Q?akYPZY1Ad5loD04DHkpgMZrsKseeqYOKf67gzYEvn8u+fCua3zu87ic/bt7p?=
 =?us-ascii?Q?joFhAcn0EN9XC8mUbDsty4J1wqKaHSOjeWAZnC/mSH9HDEFH1i3+Xu0wX341?=
 =?us-ascii?Q?k9tZlYT2uOYfB2rXRzC5ghNoWWFMvsKgMh3jUe4qxuF5ALH4x/ohMqcrwkOk?=
 =?us-ascii?Q?uAz90Lwo7idkNdHcBm/J2P+AY/euX8UK9q6IQOEF0L439S3boiX+1RuH4Qgj?=
 =?us-ascii?Q?Ppc9nO7OOVk8iIbdcZEnvZi9Gto=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22da9da8-af5b-42f7-e633-08d9edb03608
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:45:32.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgEedfOK5coIQy0Ohwko02JezZ/sU5+a0WfphnisMU8n/0qVWQF3tZrmr/ttBPktzX5B77Gx8DofWHwlM/reuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

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

