Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBC29CA
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 09:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641549072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cETj5k7EIT9GJdWgYN5B02FD6Tn0YUgURwAuAktME+Q=;
	b=av+FJsN9mC/8ROoiI8rOPxQoiAkszQsZng7seaqvLBjtvzIyuggMuTiQpei56751lIIJQQ
	rl/5eAcA6S6lCaDPb/RuEQM0TiopR+r6hhbXeumd32oJ2yOMsRIZzmRd20SyXRnQ2U7Y26
	QVGPDyU5VJeAyn64Cnh7gUmz0+onjBE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-dy2lAz4wO2-o4I8ztJXzSA-1; Fri, 07 Jan 2022 10:51:11 +0100
X-MC-Unique: dy2lAz4wO2-o4I8ztJXzSA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ4Gae2xTc/gqZMplGMr1i32BuOzJ6kWaWefTbBHarsl5jDeCi5WBhucg2o0R48iFLRaGfzAbP2Wxln6q2RAMFJITFRQOo5BiR1+Mt3MXg/ifmY/r1mnA05OwprnTg3PxobtsgZ1HSO8ZjVr9dkvQzsOm/59c3MP179oQ/F0OBwIlAUdU4sRuD3a1jPSKe0Ub1lZ/iE/mYWb5NkkKHb3Bn0I7HsSUsk0qHia2MEdbP9qzE/yi6uJUM5YJCPYzzhlwISnbyNu4Sc4++JCsn5o5UkCF2K4S/+vzGrGCE/w3deiYPlOHBv6C4d+6kQBi8TFI1hjytk0RMERgn9OwDRtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GghYI03IPEZjSjXco/tFJ0xdQXbMw/jKQZKdd78BkyA=;
 b=TwAlvnyvjt27CZ//SagPpHhxZzl4HDM5blX3ApDm92sFdEIs2pYHoI/t8B9JY272Vda2lisbI0vgNaVm1w3qsMIk+BDEJoT/zKtXewu6Fa/6FKZ4TP/s8Tir+7ZwNwd6gq+V5EhqV8MbAGgE5BgSdZxSJQ7I0i09E0mcdAXXu8TfMNPWxS/tbltY1o2jokMKnxYQeATJIjKrN0iy/hTFZ7J4lM3W4fXNN5B7vr3WrIEHd/MquBj1iYRhA2IZeIEdeZKEa+5i5hfU+kMO5FOjnJxjNPEmUYOKg0vjZHvK3d0KO566KBFY2xF5J6kzvZPaAWtubsCO/WLI3Lke5OHOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2377.eurprd04.prod.outlook.com (2603:10a6:3:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 09:51:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 09:51:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable join tests-cases"
Date: Fri,  7 Jan 2022 17:51:01 +0800
Message-ID: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5159c726-4a51-4cef-8f8e-08d9d1c33ba7
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2377:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB237746FB608709D5945DF1F3F84D9@HE1PR0401MB2377.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YqXlqWCminJI9y59etXMdHpAIh2VrDHN6A2oP0KOk8bbf8e2MkTCgXJ2vXZa/JCF13M5mvsPzbXMbaQ8Wf6rQIiVVGVLCKW9p44g/uA31vYNPwYAubzGu8/iCVqaoJ9uF9Ym4Fd+aVIDNSvEI5KqAKFp+ZB16Zrxq+YjB7jDG+x2OL0v1oBZ9QLXMOkPox7d1RzhQgaPN83F/OwbjycEHJSCFMIUe8fpnUmAIEjBwJdA872iWUpeitCy3dNboe1uU5q8EG29qDI0kOLU4G2JjHZi4r7JsywSmUudw92j3d028ZYwmA1AkCXIZCLX9WHz73/VmPm2x2XP9qzIdrcjza3YLqmBV7t2+dX9elpOjJjkNFnx2nlJ656VS8em9dFz2b36GT3NyfYmY7+slOZMjJuEqX1edSMa5AHJCfBhUClTTjpnqsypMp/1h5XFUdoZ9MNufYNSbPsAqwOdghuG79rvRqUV42/WaxZp2WKnLPFLFKVvh8MmgWKREJtbnw4jBnxjbVpmZ2GCCBhLUVd4TwBZ8JWjxgc2/jZQbxL+oWkzbhMpOAnqF9sTDcwPiR9ZsmBoOVkffz44Ebzlz+ozr+KxBHHkMK2Ms9izisBC3bu+De9AgUq1XhtKCN4ebsS/8G4D7QYdTaFe48n9q4tx2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(5660300002)(6486002)(38100700002)(55236004)(86362001)(107886003)(6506007)(2906002)(4326008)(316002)(186003)(26005)(66946007)(6916009)(44832011)(508600001)(8936002)(66556008)(83380400001)(66476007)(8676002)(6666004)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?786NH2FClvYVy3VEdSQo6/bNplzYjn140Zwo67nIRWC+W8MAcI5EB0IDTNzR?=
 =?us-ascii?Q?u1EvmaMEFQo0vOsqIW9LZD/O1C0anHGNiQzpNWzzYYfdvC8PTqY0k0sF8PAd?=
 =?us-ascii?Q?EoWnm+2jB9WtC9L40P4vTm58bLKmUq5ycXp/CY9wtRi3NbAOlicrywBxfk5U?=
 =?us-ascii?Q?I6WToF2lOy6e0Fa1oXJL+H2yUtoqHnQDQJzo1rjJGgo3Z8Jgnu4QrRBHW/+f?=
 =?us-ascii?Q?SbVUWv8W2Da2A+j/0F4L+aoddAoJtfCpFXbNFP2mmt/R4le1YrLT2Y/16dld?=
 =?us-ascii?Q?qCAJJFCXixKTTjWwr0ZaL44tqt1SkreE+72UeOpbPb5/OygWOZ7Ksy1hbCKk?=
 =?us-ascii?Q?UANOTrPsWur1kiCNJgmXRvG37HSCGNQCm3JnDx0k30LaSO+PiOzhcl1wKf3o?=
 =?us-ascii?Q?5TsK7DuZKXkO2dCsJA6D4x//Yk8zcC0uKgveXc0LKko+9j911PMs9qUEia8Q?=
 =?us-ascii?Q?lyJLYnLNQ+WUGetm3lUnG0IW3OTPJROjtdfFJmOk8JlhUp50aLKw7B/dHfDA?=
 =?us-ascii?Q?9xK9EqE+1cgX0ri01wiVLoclGEbBUV0eAmdZ2BKjoq85DcEh/Cl0FP1IJoMQ?=
 =?us-ascii?Q?YHiYyDy+baKPTYeanZHxZ1GvmVYYnserqDR7Af/O5MRwFeWVnzx6iCieZp+o?=
 =?us-ascii?Q?Hyz7Yr/BzBjmxxcpvxb5usreu6kIks6f3j+jE4FJNQ4tKm18at+4iA57Kmf+?=
 =?us-ascii?Q?UyNHckrNEq/pQ9TO3crWFtfGbE8NAQ/ovH1bq4vLPR9SRlHnp1YTSSG9bnyg?=
 =?us-ascii?Q?zJL6975dL1xJx0QAvFII7s+sJehqgCAktVDPlGGzv/ew6gLRzqczFgKl/yOT?=
 =?us-ascii?Q?J4qRh1uWV8tu5sXohjqnjUg0L+yeElPIMaHGVJVe9s0IuCPv/VEVB8/zD2c/?=
 =?us-ascii?Q?tyD6rmA6TZAuDBGUvbKqsy/DFZQlIaktPt4UxZA7RHBqyLsi0uBfGa+clqIh?=
 =?us-ascii?Q?RsvLwzAVMK6U4/VOGRqrJn4jgq+Y/5X7nw5T9wdgnECxPafeZVVWLU3jtGS6?=
 =?us-ascii?Q?LcuDpCxEmigckODYoxcjbx/sc9PxgdIchte5XAyB03ExLuO+NDaM7LK391kx?=
 =?us-ascii?Q?KSKgpHAfKC/V5WQcQ8CzlGLjvAqlNdP6LWeXhb7Vl4rcot9XyByToXAqZbxQ?=
 =?us-ascii?Q?acLeIGDtaxcwxwvNh27BFpnBUtn3lBmZ/+2CFSSZvdl3uO6IAVWzYZG3/Ib9?=
 =?us-ascii?Q?U6BZEhAf8l7cmAzYiLUrcAs/dU0367GOTxOFLWZC5nyXvr5eil5wl/DoXEZs?=
 =?us-ascii?Q?cwLJLIjXy4AZCw0SrDn76LWaz2lajUue40cidug2UE1r6zAS8SSqdTV3RXrb?=
 =?us-ascii?Q?4vEOAc1I4NSKOE2jLxJoJOvZKU8vjfBQVb4Mo9Aha0I+oSbcDThA/OL+CD0b?=
 =?us-ascii?Q?7oGOtgBUqZtTkb+H1S7VCrz7/7G+tUT1MBhLMCvOl4qOJ6NL3hqKSg9vJJDC?=
 =?us-ascii?Q?8dFCLLTSI69n0Z48oO+3JB+4evQ3P/mVTdB/jPp2Q58msiG3N5FIxd0HXnDX?=
 =?us-ascii?Q?wcJ7wQhcTOofq+d9t9jZGtvLDb3wdtR5rpjgcxWqVhvAqaobPHBslvj0LkAb?=
 =?us-ascii?Q?X+Sy11zjxk9JTCetIsVkhVZwHCC8+0dQvV/zQAQetkj69W6Kc4L2lGn3iWdf?=
 =?us-ascii?Q?OMnbKAPmj6MY4o1+gPCczvs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5159c726-4a51-4cef-8f8e-08d9d1c33ba7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 09:51:10.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZrMT9HxWlAzYyXsTAFjKhw/TjSwBRVAkY8jW5w31ke1wl+dOlJvN7aGmuVJT9br7nQ7SNUK9ix2Mx56Hm0Lng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2377

IPv6 removing test failed on my test every time, this patch fixed it.

12 remove subflow and signal IPv6       syn[ ok ] - synack[fail] got 1 JOIN=
[s] synack expected 2
 - ack[fail] got 1 JOIN[s] ack expected 2
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpAttemptFails                 1                  0.0
TcpInSegs                       54                 0.0
TcpOutSegs                      58                 0.0
TcpRetransSegs                  2                  0.0
TcpExtEmbryonicRsts             1                  0.0
TcpExtDelayedACKs               15                 0.0
TcpExtTCPPureAcks               23                 0.0
TcpExtTCPTimeouts               1                  0.0
TcpExtTCPSynRetrans             2                  0.0
TcpExtTCPOrigDataSent           24                 0.0
TcpExtTCPDelivered              24                 0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
MPTcpExtEchoAdd                 1                  0.0
MPTcpExtRmSubflow               1                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpInSegs                       58                 0.0
TcpOutSegs                      53                 0.0
TcpRetransSegs                  1                  0.0
TcpOutRsts                      3                  0.0
TcpExtDelayedACKs               3                  0.0
TcpExtTCPPureAcks               29                 0.0
TcpExtTCPTimeouts               1                  0.0
TcpExtTCPSynRetrans             1                  0.0
TcpExtTCPOrigDataSent           24                 0.0
TcpExtTCPDelivered              26                 0.0
TcpExtTcpTimeoutRehash          1                  0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          1                  0.0
MPTcpExtAddAddr                 1                  0.0
MPTcpExtRmAddr                  1                  0.0
MPTcpExtRmSubflow               1                  0.0
                                        add[ ok ] - echo  [ ok ]
                                        rm [fail] got 0 RM_ADDR[s] expected=
 1
 - sf    [ ok ]
Server ns stats
TcpPassiveOpens                 2                  0.0
TcpAttemptFails                 1                  0.0
TcpInSegs                       54                 0.0
TcpOutSegs                      58                 0.0
TcpRetransSegs                  2                  0.0
TcpExtEmbryonicRsts             1                  0.0

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..41a2510e2f97 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -393,8 +393,8 @@ do_transfer()
 				do
 					id=3D${dump[$pos]}
 					rm_addr=3D$(rm_addr_count ${connector_ns})
-					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
 					wait_rm_addr ${connector_ns} ${rm_addr}
+					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
 					let counter+=3D1
 					let pos+=3D5
 				done
@@ -442,8 +442,8 @@ do_transfer()
 					# rm_addr are serialized, allow the previous one to complete
 					id=3D${dump[$pos]}
 					rm_addr=3D$(rm_addr_count ${listener_ns})
-					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
 					wait_rm_addr ${listener_ns} ${rm_addr}
+					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
 					let counter+=3D1
 					let pos+=3D5
 				done
--=20
2.31.1

