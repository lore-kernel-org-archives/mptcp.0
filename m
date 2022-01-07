Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1152C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0jhvP8UI5eV5VUXD+sWvVHjp4YTjiMxVdocDZau4H0=;
	b=HIm83cUDwXg4FsXjkCbls2YktBWwGpkd5CNeTVz490n4nAdiophuJOio9efPCe1wuYeJjv
	ZbOKycoV/AnXfnIiQk18z97SZvWy0FK9ONjMfR8t3X0yfHyx8euTr6zFz64FXktTwIyFoy
	caIDTzQEeJRYvr958urFC3TOKytAwew=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-Wt4EUksXM7Cq6NiOhmiUgQ-1; Fri, 07 Jan 2022 06:52:12 +0100
X-MC-Unique: Wt4EUksXM7Cq6NiOhmiUgQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU6D4Nnlxp1YgaW7+YKceGBWxAB2hiry08uvXkzLTtDhLhhTN8wMnK/h9y9YdLWwxd8gdGVy75gKe+jG4k/zVM+N2WwKPAs6uyF4Te6ORr3u/G5GwhqkeOvJv1C9++YuIpQNO8TZEeV1r4YzFHEq5utTr7LDpBUxnNtZhr0D8+Lk8MJkA8hmIzEPCjdpIyZKZt3VyErIsTcCqMKiImVrD5k6s/3dgCOENB0g8pG6hD94J6JDWWYgm6kFa4ppb0x7o2+KPS/tp+qE1l/AF8yN+A0pOvl11+HUQ+2lbCoDG7aXGgkJEf7sLOyIkiov3mF3rg6YIW3YkEOXVsWgAdEGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqauNT+rZIxC6T5Bo8oua2KSk9q+Vp4LBca0CYyxgaE=;
 b=H5TTlKIJ/xj35pEXtjeBCmn3OOr6J/TehRabGt9F+S0G+0mFJKnx+PLbOlgHuwMXcHj8C1a5dk4ZeqHCq5WJkLRbkU2azoLVIAEYY8ZhNgNQ4D80o/8A3Ar7jih1RIBXkVpGXCEyRdR0PRsgQq1ZW+g05NvtZsZoe2y/jF/HEatRBg76IibJMiY/5xjPBN9YfiWsAWyN4I3Ym83YBhLUT/REcMkMVax5r8LQBMQd572FGTUWbZPJcaLcIabzpq56do3xpRu8hO71i8l74EwHqnMUgMs2SYLP049taK2YsjV0gv0b4F/S6tZz8aiYXq2DNU7QHUfsUALqdP3VEV5JzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/9] selftests: mptcp: rewrite backup tests
Date: Fri,  7 Jan 2022 13:51:44 +0800
Message-ID: <c232636a36b5d3250728c86c3d76de842ff3e4ab.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49063c28-ccb8-4472-0694-08d9d1a1d960
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2731AB044591A96BD921A052F84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LVcSpiTt2CX3DwZvcLD+WJbyRuA5912k0RhyWw3ddHp1qtUZ1cS7esL7aCKnzfiqblzYQx0Y5vWLrl53uNIYKiLRGTJAEnnawh8TPfG0cSBfBvWedexsTZ13Gr58KuroYLMeYR4NuRsUuL8IBHQByxgtOibiMQ5VkWyAxp/aLqC9wVvAdieuqsd9DuKcM+bErnDqcTAa0eAFmNMKST3TfILmeimtTp05CQ5TEKSRPM6Kz9ub0l9OoyGWBaqMIqNWrlGqfV4Webyt+4o4W1GtYYGBP0EfzbvH/wzjtBNNvk5sQ6kn+I7LUN6Lwkike5Jh1vvhQEMcV89al/L3L6huxk90oFNm5ACoLCio7BZu6otjW+iN91yyM7yXC6ZQ9KQBQfj2k9M5kUj9J6fK/tm8c1pFF3Zlk4gIiRqGT3KGRmQwt+Wf10SSqWU2ysSU1vGCMkjd4UL1pwS0ZZliaCBx+fF2Zmwg68vDvg1cw7DYMFHZrtMSvoMmRxFYv3VQsHVJSrUedTnmu5zof9gYaKJdkPOQmrdlSHlEDSteYnaZZls2aXdKfElhpMUG0y53ymsLYLjFdU6UFZLkJ3iG6Ck8SR7hEqkn5/uYDCxEcHOSeIe2MQ50ZUyuuSI/1fPFLctJV8cfzWoDyrb6Xi/a+Nas1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(6666004)(55236004)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Gw+CtjCOXzzFw0BdCT5XNjmcO3AXk/5vGiaQeHfrmQR2Y09AZm1zBbBqd7V?=
 =?us-ascii?Q?LeZkgf5PUJnXFFn4iT5M1vA9iEZUKMdt17Cs6Rzs/I8h+EB9nNtDqMSaZB2b?=
 =?us-ascii?Q?+7dUnA2M8mKFHO4s1ENi5PnvkJ1uGoxkTwroYwOG6hqgnokxI0SNKecKzCOK?=
 =?us-ascii?Q?1m2q3KofvUzr2vQRoQSJ0+sId4/fH+X+u9MhFgIRhcdjRooJO2decAlV4625?=
 =?us-ascii?Q?UGIkhnK11TpeP2E2DhjAhkXpmPr2xnL4bXCTX6+mtL6eIdHhyIe0VM/8e3mV?=
 =?us-ascii?Q?eS/PrRSE5GbKYKYj44BV9BIkvpa3X0x+59M4NIjh88IUt+HzVXZGr0xOD2DT?=
 =?us-ascii?Q?SRnt+7XqOkPoFZrKSE38O6Twds4Zj8qriNYXIhpqbPCfCwnTHd3sVD6ckaCT?=
 =?us-ascii?Q?IgA3/BDHAavK8U+DN5Q7lGg7FNi/aKUq9AuuurKbhuBIZhHKfJAga51K57Wy?=
 =?us-ascii?Q?bf6KluvMtQ5M6f/12U8N+A0BVnVErkvaSTOxInH3jrdURQ7UVd5GA3i0bAdX?=
 =?us-ascii?Q?UIQ6/Q4as+ISGtF0RzQ0Yl54cpaMc94B0rn8Z8vIHl7Ygc3jDz5x1dAmW283?=
 =?us-ascii?Q?ttFCMjG5a1nYVlYbvTLTUzoUrH4xpwyemD17F9vPj6bC3SmW4y+jwmCJfFpR?=
 =?us-ascii?Q?aF/qpvgFfV8xNzaW/FNt09qa/h8ahiLJh5MoiiJ3K3ulOsCAKZ4ocL/RP98Y?=
 =?us-ascii?Q?RqIVxqPB+pjuvgK9fIj8S2aDaiKXOY5Vo9EZiOIT/N+Ycn5NFejguEUV0VyV?=
 =?us-ascii?Q?kKRIKEN/rCmWFlHRME5iKHJ70vUrH2EwV3dALdBaP7mou8fdd43t2cAhEq2i?=
 =?us-ascii?Q?tRWCJfLvZL+uP0BZwME1V+E1f0Byfq1CoQzL1ScpKtqUC/jmERthTUbg/hRp?=
 =?us-ascii?Q?Yc6RwOF48rv975IQN/zWkEHJM11cgqbgoCCY3SlyOo3EjQ9iGm7VDeogMwhv?=
 =?us-ascii?Q?DgC9jfoulIh8tR6vftjTHx1YbmKxh9IxtPVqC4xany9ccpRSUz8VztQqOmYk?=
 =?us-ascii?Q?PqdwDs9qJS3zr5Tc3oyCSpgo6mwi6zQu+HzI8XLa2xp9S0JOylB5ae+sDVbk?=
 =?us-ascii?Q?S1e4fCNy3Uq4Rec238yvZ1AekMYpEKMpp2xSyqmKbB3aI+ozylhm+yzCPSwU?=
 =?us-ascii?Q?bUhuzlkdgN/l50GlG2BgmoNf0KJQGUx2LdsDGa1L8GPQZRDqog8DlFuzJDOu?=
 =?us-ascii?Q?BZKhlK90cJuT+w0EMcyqwGUBo7hfjvJVYsbs9UCSz/Ni73VNDTGdBba/gSpk?=
 =?us-ascii?Q?OXg19/rZf4IS3Axg4L9YrRKJu8uONvh7Pgumxr/Zdccfl5SDDfjg217Y8qks?=
 =?us-ascii?Q?YzGZaJPC8Ff1+xwtjoltLTjbbb+HvFdrZRtNRcR1AalNZtITiwKVSQ3k8J4s?=
 =?us-ascii?Q?rz2vQTe2boYPvQ7y2ryK2NbYtSimeov8I+K1PHf69YF0gyh/jR3rP6Z1g4MO?=
 =?us-ascii?Q?sXRw0ODkY8wtDZaH66ZLJBaN37wbvPIijreeWG3rkPzKq7bhGFPn8wdQ6zmC?=
 =?us-ascii?Q?srkblbsIqaDJTy2N4MncarSq+OS3lo4BhnioEoSC1ZYXMXTR5KiNrxUXsXp5?=
 =?us-ascii?Q?YPVlvmZrMxBQ0lGvnX1MKxBhrncH50clu1iY03WfvbUHLGaYxbV0/3IOIc0Y?=
 =?us-ascii?Q?I5hWV69CkFIrUc2jdXZwgoc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49063c28-ccb8-4472-0694-08d9d1a1d960
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:11.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ke5Sc9UPlSjTScigVyfbAms4/Y6sTycVl4yWtwaGw5hKlaio5cv9JIWsAbKcE12UOMlcQ3OS5bu8ssJzB5iHbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

The orignal code in the backup tests only works for the output of
'pm_nl_ctl dump'. It chooses the last item in the endpoints dump
table to parse the address in it, and the address is always showed
at the end of the item.

But it dosen't work for the output of 'ip mptcp endpoint show', the
address is always showed at the front of the item. This patch rewrites
the backup tests to fit for the 'ip mptcp' output.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 1b7f63d64e55..5d8b1e475127 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -474,12 +474,14 @@ do_transfer()
 	if [ ! -z $bkup ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
-				$backup
-			fi
+			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				# 'pm_nl_ctl' shows the address at the end
+				let pos=3D${#arr[@]}-1
+
+				addr=3D${arr[$pos]}
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
+			done
 		done
 	fi
=20
--=20
2.31.1

