Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53462C9C
	for <mptcp@lists.linux.dev>; Tue,  4 Jan 2022 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641291103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8QrsAONIBZCbjOM4+fb6XgDLOwxfvas2pawqDAkurk=;
	b=WCREMTNEHrGUT1YHt080BelwVHRsD/JjaAykN4hpfiAYSJb/2yWCHnuYBb8cE9tpMKZV9n
	bjfjJ8WkX/ManA6Zuk65dbzOhIdFR21UIBPhG9xVqr0fAy2DL/kfDKtqu2Ka8jWNos6jJ8
	8ULrS2hxhZE+zqVlgBcDmVPW1/UeecA=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-2CI4nI7GOIG5MhR86tBEaw-1; Tue, 04 Jan 2022 11:11:42 +0100
X-MC-Unique: 2CI4nI7GOIG5MhR86tBEaw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvEyWyP9FjlJL+Gto7a2Kn0C4i0d17II32+DQweMtiM04BQeplR/df9ZznbyvcSXZ/1QpclmnwjNsWYgCIG8wrCjwJ4qyu898rRNpsbaqOQACExpXrpI2jO2kjMuw2Ewy+Zz5GZp4cMhYxzfJEHDPoZN17NOOoghzgntTJQFzHF71p18jjmih07ksW7DqKsQEam6IccnY0F5yT4B4ItFTViSDV+FrKk5ByRBqvZ0TW6IyF2D4pe6nlhQ7AkAMaNaDfu/TtA0ChX2gczFNUD97U8mJjB/R4dVTEXTs4SAzgwEtuEaUp/GSuuHytJWq8uPRvNleZnusA7/Hxks7r110A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM06RPRL9tf6YmRRV7ILBoxPfLa2AfsP5V/lMO8WbVU=;
 b=Y+/NtQFhDxiZ3DV4hb+d4KpOo34NYVhH08rIRjvKlLFMl5y3RKEnW4yHaMfD3jTMARx/Wz+i3CckEKtEA9Av815zi/vnx24s5g6yeddRUSVniI4sZqnBQXZsKhQuyscTwIbH5A7bvkx9+WhJvCVshIYpgOIAXW9DUkRtIQlsDYZVo2slrbw3o/nig5/dMENH2GGtkd6XyBB1zA8aBg+fLT5KOOJjbkz/9VPTTn32YkCz8ASzM5nKkG5tOwjtfoceRSLT7xTCXw3I0/7FVtvLOjW4txED0366T7QBmpyex8mwb8xe1Q7NXB+QliP5RiWKRF66mSu8X5VoFWho0a6B1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2540.eurprd04.prod.outlook.com (2603:10a6:3:84::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Tue, 4 Jan
 2022 10:11:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 10:11:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] selftests: mptcp: use 'ip mptcp' in mptcp_sockopt.sh
Date: Tue,  4 Jan 2022 18:11:17 +0800
Message-ID: <6653dbf53abfec82b61ab0856a182d5f4e79277d.1641290905.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641290905.git.geliang.tang@suse.com>
References: <cover.1641290905.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 794bd484-b3bf-4c1f-9291-08d9cf6a9a46
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2540:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2540CCA9156328292CEB694FF84A9@HE1PR0401MB2540.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s45kZH2vnMJsGKM0p3b6LD/G8cfbcWZcdYLcKqkznABjqMDgWY+5g3QVkg8yoqe07Himy5xQlTGZOWnlC4d+ExionCu26RJOjl1l5gihfV+kmMq2zU98DYSJkkzlS7+4P+g++IQblWJgUnAMc0mGKnuc47FacJBRJHPEu0aTHhKv4wWVToQINuXIMC/fwAnz+FIIJcSaWK1u0WDSxfR31EufonwowCh7aRuUX7hfPjJ/bVl4HT1iDRAgFOLXCvDHUba2Y/UPlp7GgxPDHLCJMm5my2jKSeQRUr0q0MO6lv/FEFTJBkEZ/ra793Xr4pQ1mxm/PyYInrmRHszTSCjctfmK7nDf1w0WfOf98vPAhJt3tlSX7xArs3vwuaIoEdYQv3NH0TufxOYdKEpZtZpwz8Z8xwFmy2xSp270Z0Nnim+yE20cifzVGRW83veYJnnp/YD6ga7BPprURvVZzCGG8+gykgUwl32WpPXtufaDxiSj69h73rWfy0MsS+UnBXm4nwNPvMaeORIxY//VFv9AZQt9e2IivLEkPlHKXtp1X9GkC7vOCOwniAdG+9+9HZbBD9b5fYSMFba7BFIStmEXrfsAbjpkzbH28h+9sj7m796XUiAm1JLx2oRqixSEr3PCLKDiYgOwFPAiJCocvOsL+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(4326008)(66476007)(8676002)(2616005)(508600001)(6916009)(86362001)(6486002)(5660300002)(107886003)(186003)(38100700002)(8936002)(36756003)(66946007)(55236004)(44832011)(316002)(26005)(83380400001)(2906002)(6666004)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2AZ1tG833rMRwlPKAKpA6Z3D2O0LdV8qxHRwShZqHkcxINKjAQIskdnRU0Ld?=
 =?us-ascii?Q?ypSLXXTxh9/oIayXW6+mp8FY0ZDV6cHztMbPo3yv7//gkbM+lav/2Cne5VTP?=
 =?us-ascii?Q?bao6pDr2TTqdggRLeOB+olgLkUjK13kCT5rLwcc9tB54aPTK78C0dEcEdQwj?=
 =?us-ascii?Q?jHv/NagXrcq4OOPM9XYTP//6D+T8msh/gZAIVT9xZONqUWYfFkm53Txan7TX?=
 =?us-ascii?Q?dvNAqGkd004lLDgtKCv1YlteUp/RH5l5GXcUZ5kkFvyogwTUpHIDfmLmQkC5?=
 =?us-ascii?Q?V8fC5YBNP5ruEhz0yIbmiNthiGYNnO8SCpCsbUI198pYtHNG4uNMbSyxo+x+?=
 =?us-ascii?Q?pbrb58BzFa16M5KIUVhaRTx7Zop/s/glIYsOS3boITpnfm/j8oiUCp5xgvLp?=
 =?us-ascii?Q?stfSFXaWcQ5S9gpZXUdbQ9bp04mg5Zg2Ml0OoIGJcfJoGPzjasDxCB9TXXWi?=
 =?us-ascii?Q?OXZX8ijnUdijf0zOof3+Xum0RrBM2Hhec3A4139PBW7zypXgy/jXhSuqhJEi?=
 =?us-ascii?Q?5WhA/76crQwQScD/rXBJkmt1mpo1ATXm4nkOcOAcRCVA53nXp40SyK+BvhZt?=
 =?us-ascii?Q?HGxfckcbe5O3sJBOmToyWBR0WgRIgXpaLOQQ8fYhqaqc/ncSIzX1LDYglxAG?=
 =?us-ascii?Q?xCsrQ35+YWCu0wkoYJKQPPPmKjBPI08wzV9JNnzkmgTrmcHtkpX6f7EETHMD?=
 =?us-ascii?Q?u5noJNC0XWWn5LGoh0K3Tdhka5ajo2tnYoBPJC4pCJhMIpWYdsbOjwY72QO+?=
 =?us-ascii?Q?qG3z9LOao636tE+WcwFU0rEinZStGa4bBEEokk9kB2zGQt+PakyXdJ4uCXut?=
 =?us-ascii?Q?1igotDJ1P744Zb+OoPWw41UBE4W8e4GsLFApIb0W6v2SMaJdciSpbziTB/OJ?=
 =?us-ascii?Q?XZjKj3/tOBodtUjRijCiLrDoYFzjZ7M51bO4UDs2zCn2CBz6iyk7MRTIS4NX?=
 =?us-ascii?Q?mwEywAmZvKQI7KTEr1v5I4nCm5OAAQqUdMOt/wRBvZ9xPvTCYQ3kA+FkMU/E?=
 =?us-ascii?Q?szmeK3acJPMw2RkXzkjFmVBgmpg9Tr2wsN5RaBkjTi9upBBsibuZ4IdSsALH?=
 =?us-ascii?Q?XKXDWtbDr9V3DFFK4gVFLuA8jjNzwqPNkkExwmaeiU+yXhn42gCbwt54AmA7?=
 =?us-ascii?Q?E1L6qkgAzoeuYspvjICDqTf51FDkxOV5z0YxUaLZx+yUVkNbd+blNmRp3++Y?=
 =?us-ascii?Q?7AeyTkNnCKFmoCUYTrn1G/xLia83TzNa/GKgIhj6Rnj9pL1vNPivuLfdbLB+?=
 =?us-ascii?Q?WEhxUVrbuVNDOYdpJ2f86mw89UbE2QRoGZAYv7Y6l3Y95YhQBBnWoqatcN+Q?=
 =?us-ascii?Q?lkCL7pa3OHH/0JRm62MAuIyh7plZx4ukRrovlyLkhs+lL/P1MdKx1udHiskh?=
 =?us-ascii?Q?5QoJ1FY+EnU/jbpLLri8nR/k62TYKHpFuo8pedw8vNinzBGu5OkPozw28zWC?=
 =?us-ascii?Q?gYTnvrTjHQnpbXBzCAI1T9hcz5l5XoXis5UOI9hpufeViVMbW/rOESIjOJfA?=
 =?us-ascii?Q?DyY0Hm3CGRNwXyzg59SBaKx3UkdgpfFzLkPX7TcXeXnkQngU/VPu8AvoeEU/?=
 =?us-ascii?Q?i0N5dsGBsQhWNHirJ7hHpeftXPZ410jws+B/XO9xi3c33gZdRnhNNHxjaowk?=
 =?us-ascii?Q?GnO+U77TP5XcgsbU9bsftxw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794bd484-b3bf-4c1f-9291-08d9cf6a9a46
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 10:11:41.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/CqhUROBGx6sc8YNW0eFNAEJa+7nYyPrCXBbOc3GFkw0moAOh7W+U2g6oCPDS14uT/Ew3x/5YISPMklpwE+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2540

This patch replaced all the pm_nl_ctl commands in the mptcp_sockopt.sh
script with the 'ip mptcp' commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_sockopt.sh
index 0879da915014..f4da6d2da1c5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -57,15 +57,15 @@ init()
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
=20
-		ip netns exec $ns1 ./pm_nl_ctl add 10.0.$i.1 flags signal
-		ip netns exec $ns1 ./pm_nl_ctl add dead:beef:$i::1 flags signal
+		ip -net $ns1 mptcp endpoint add 10.0.$i.1 signal
+		ip -net $ns1 mptcp endpoint add dead:beef:$i::1 signal
=20
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.$i.2 flags signal
-		ip netns exec $ns2 ./pm_nl_ctl add dead:beef:$i::2 flags signal
+		ip -net $ns2 mptcp endpoint add 10.0.$i.2 signal
+		ip -net $ns2 mptcp endpoint add dead:beef:$i::2 signal
 	done
=20
-	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	ip -net $ns1 mptcp limits set add_addr_accepted 8 subflows 8
+	ip -net $ns2 mptcp limits set add_addr_accepted 8 subflows 8
=20
 	add_mark_rules $ns1 1
 	add_mark_rules $ns2 2
--=20
2.31.1

