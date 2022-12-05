Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAB7C
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 12:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHh+NOQ3PSLRGjbGFwJXIuT3b8GGAndbiQdNkupM01o6uJO6ZLXhF/1uNo1qLUqVCnMSXlbw+q8OG1FmIOp7+FXS/TWf/cu58jj3hVgYDx4xK2BsEYFsL8x3El2VCgtoSTCHXGsSVD8vTaAVYWRbr49g17+S6P4YWShEdxSnhFg/vh5hhMY7XdB1PYwHBl4lFBz95azN/voKgSBLIg9y7ynw2lzCkR+PUhZsexiiItvvFhQdc+3HyYDg6LdqCqnZLwpiN59BFHCEY4wCR9q1h8T6phQZ7bIBAVatAXLXkYH11dJWzEploFakk+u48XAvFP+0UXlgzawOOy916WwOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogFG4MFh7lXBdFWDXL+0sahxRYESbSOk5d5DuEG54U0=;
 b=n1dS8rCoksCOOLwpBLpsOexxEiUdymdHl9FnahYdkuqr2hXx9Ij3RxFvZPGKTELZlQsjV+cye/t2WX72xRxKipCLIEbwKc4tgm6t56xxoAgfTosBaStCb/2TlWDXuslW80FeO4vHRE6sp6Aglqi75YXc1LCtOXWGQ8/FfyHm+5y8eIp+JkdzA461aQYYLzuYtMAj4CLGWFy80/lBMrU+ge7jetQB3/6t6y9hIp0CRtqHNQywn7uDgOOQW4NdQ5w/OfVQaVwTDn3PtOceLdxCyliLIW4Df5uoBrqgUTBsde0XRfznp+UajE6DDoDrr7E1vd78jOGjFq152NXJvx7HfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogFG4MFh7lXBdFWDXL+0sahxRYESbSOk5d5DuEG54U0=;
 b=KlV9TxiU53pmTwRV7X5OfYcOrLU2PHYH3JELKEBk7IXoF6XQmL9dt0dVXNrniyTQr1myIAb9tqlSkm4bXWQRQ5uVY0vqgeIq5TEKT1568UZmgf09BbR0I165KzzJJkSg9D/YRzUeYffl01Y/zXhe5FzlJyJztdpbii0wqozXM4Sfki8nt2NuFOhxDsQf7x2KH8WM52K0BJCwlcx39EiNDKN/tOcq20GJ80o0nsjTTJy2LweAX5vnRFMgHIAHaUhFVu7AduKuou+pOyAXRVxy5lZi1AuzDvvCp3Z1v1vayp4LgJtxlYTJSPTHkzUJCw9zwHaI5JmbXBFktspDbD6prg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBAPR04MB7224.eurprd04.prod.outlook.com (2603:10a6:10:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 12:35:38 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 12:35:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: use get_send wrapper, v22"
Date: Mon,  5 Dec 2022 20:35:21 +0800
Message-Id: <4b463a0bf0729201b6d61e26877f1fc4550b7585.1670243225.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670243225.git.geliang.tang@suse.com>
References: <cover.1670243225.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBAPR04MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6d54bc-a265-41be-b0d5-08dad6bd368d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R90ZMMa/ClEy/ScLi/EztVApyfLhph5JI2lRXR+//IAZSp90w7Zawxxi+9ZfKxJULtomMd2yOfEgUDxAnSEOXuYjsrcGyWotwMD6zySQhQoQzts2nj+2dFraJ4oP970mYijm/vd9uEpAejE7MWhuvAcs5d33zgKGflBGKo1C4w/5700zERnqbJOa9iVmbI/H1d1U1MM2e7eOwGgU0bVOMmvSHvSjkjYqLG8EJHHJRaGt6ZyAwR/uvSmdVzlYjuMgqHAGvTWDUxAJwtv5HePBLZ2jGvVaorpK9aEn0lVNZqHj3MEpX30cY/hwJxrPVfT2TWoQoh6gpP31PbpzCFPnpKtdHBgiJIZJB4ZU3N6gtBmg2OD+l9ANfrZc2TYh1nMa3DF18J0lSXGtaZaOPztIVtPPA3EqpRLUEo9eZvuVtlgAWCw9bs2/FpLSkcYa5pfoOEIIUy3kZ7sEJeIAXjd/fpe7AMHYzz1c26UmiFHqHhYh5yV1UzgvXoCr/Cw6zlNnRXucjpRyhVq9fS0ZzVdkgpDozgNoDDoKKnWTbGM/6Lu1FL5lRNd2ZCLsxDmJtCxqElTLTbWIm0VxJn2Uc8lRalRW9vH+e2rPgdTYHD1jD/D0Kum/WKBMvFok7fKQ278/xX0HlJvh8K09zhfpb6hPSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(376002)(396003)(366004)(136003)(451199015)(107886003)(6486002)(66946007)(6666004)(66476007)(66556008)(8676002)(38100700002)(478600001)(26005)(6512007)(44832011)(2616005)(6506007)(186003)(41300700001)(6916009)(86362001)(83380400001)(4326008)(4744005)(36756003)(5660300002)(8936002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/+d1VjnNpZ9AqOmVseVrgouOZDzJ8BJn/bgDBRIBRGWKggmJ40D1KHW8b1qC?=
 =?us-ascii?Q?VmcePubPpZC8tPjd8WWQNY/vCYm/C8jLDhFC1C3xzkTgwqQkllOgDDb3mVKm?=
 =?us-ascii?Q?7520In7colJZbefWWU/NNxyDtGy2SoyacnPefQV+8eCfV6VHT9c0P7IH0Ohv?=
 =?us-ascii?Q?KpJNhzC0hmaTXnmAHWl6mxU7NtMOtBscCNynmo4gyygSwfpKFN8Am+fLGHSq?=
 =?us-ascii?Q?XLGHB3s6cJB8dePEBe81i5PljACOhgSqxUMU4HoO2UaEfs9DjTaSTkTRvJVS?=
 =?us-ascii?Q?LokCn75/VH/4/mhXLSXkM/8Et6guu/s1a2wIPoZm1X9deVF/BRl6CITlLYeh?=
 =?us-ascii?Q?EZ9DEYGCuvC8J43zGE++jQVXICW68WH7lH476caq85PPrUhTIdK8C7v9/aY+?=
 =?us-ascii?Q?UZ21IEoDqBAtet7vZTgte5bFfIccuKPO3s9jzVUa37CNXHZ/8m6+fLw1OySL?=
 =?us-ascii?Q?AVYVQbJviDP+3PHqWTD1e9XG/xn8lSuFnY5Jr1jGksLDEBKHBdvPYwqxW9E3?=
 =?us-ascii?Q?ZnZx+FfzAvZhh+rk2a2fT4ljWYbptOffjwQSmzfWAWenU6uH6AeAsMYH1LOz?=
 =?us-ascii?Q?Hfjszb1UWH0FRaUtNNBVZyKNE5aRwJ08ZyNKztLm1kXTLY13V2AnPfTDvZek?=
 =?us-ascii?Q?kjfEVfXQfhmDAdGObXBGIcofJ2wFltuENfMmHoMUyGNdC12Omw8DV7CXXQW1?=
 =?us-ascii?Q?vWQZGNMNGtVNNffH8ZRmts/tsC7TBgqksNedKhGy0xIZlQWF0RCf4gSaSI2B?=
 =?us-ascii?Q?tGNDDwMkBL9TBQQLDHGeLXItmU4h+aE5cYN3fFLgHfxVNOgWEF28BJlJOXky?=
 =?us-ascii?Q?FFYdEkMLBt+3hFXYNDMwCTXG/cY1Ehh8TFsrPHZXdYmqeZe5HbpnVMFg0BWT?=
 =?us-ascii?Q?DuqY+R0VElnpzQlJq40okFIUf5iYe/NycXyfGkbmPwefficATEFw+uSFJZBj?=
 =?us-ascii?Q?diiKRFx9A1I0vAc3UhuqT950FksAroTe4o1OXFYiKfjYjKvbk75mJSTiZJVU?=
 =?us-ascii?Q?jEhnnmce+aSdh0S0T2sn5k8HwdwZLNDsNvI4hwSDoZKM1k07bptHx9LCs7ql?=
 =?us-ascii?Q?S5nPY1xjBe72tJmvt7VJct8pOJmfMaaCEsqQIXQBrbXkUFC3TyfS9HU3pP4B?=
 =?us-ascii?Q?R7un3iB4sW64I4WtmsDil2elmOd/1V5oBcGA0nJB0K7eDBxs6BJEAgvEQSbm?=
 =?us-ascii?Q?hGomlHEvygvVNdLe8EWic5ELkgv7Ueq+DZhEq5WErvPjEylEgiUECi9wF0go?=
 =?us-ascii?Q?IMtvOEoJPshyOP4gSqkJgIVcftJ5+RJwGxuKCMCa+TtWwkQ6VEiS8mTUVbx2?=
 =?us-ascii?Q?oMKULfcdAk4B6HLPFJw+eCEsG3A69T/Wi0Sary2j7MvXxb00/7zyROlrdprw?=
 =?us-ascii?Q?1glstbjnrGgIe4Ox+HNdr6AIysYA+4LovjvT9ZoeXDzQ5cg/+9qJhS6P+nVR?=
 =?us-ascii?Q?Q/9QFmiXziFOc0tTdKIMSeJMX1GYyPCMAdOQcvJ+hemhjKVmw2DjbkKkTBsc?=
 =?us-ascii?Q?57dSug/vQsgD3aoBi3rVsKYhVliNvjcTn5tZotEMLhV7u6MxD4kdFBIJVEl7?=
 =?us-ascii?Q?Y32rZWADdwIO2JFOPb8CI8FtCee6mffvB3ZKAjCE8r4IiH/NUGHef0jCz+qg?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6d54bc-a265-41be-b0d5-08dad6bd368d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 12:35:37.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IiZMtiShfiDi/mj7aFfD274H0DjA6DHPH7TnSZN2rVsRTslItWAeBjZQ8alk1JbUMzvfCRLAOB0gvM5keEQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7224

Cleanup.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 712b183fd80e..ea2e48a74772 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1565,7 +1565,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		int ret = 0;
 
 		if (mptcp_sched_get_send(msk))
-			break;
+			goto out;
 
 		push_count = 0;
 
@@ -1605,6 +1605,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		}
 	}
 
+out:
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
 		mptcp_push_release(ssk, &info);
-- 
2.35.3

