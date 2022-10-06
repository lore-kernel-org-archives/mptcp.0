Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A497F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG07FL3dSSdvaj9iwyP57LQ9aEB+EynCzsuHoEqK85EREBNvBwsVPbWq9CRsFlwypMH2S/F4GjV/5G/KmZQsIwC9oDtMGSDPiiWqwKedUkgAyWGRsD94HA4DIU7l3QZ+vRuQOmQZns5c5ByK0jlnjLGhrOZOCpAPiRkJuADpq6bzp7ag4T63r6KUeFXNPeJfYHcGENww/qChweiJ3HacGFcIrfWqFfdeJbLjLoPGgnYTBdNOZRp41FH08UYr/+zyh/o4TgO/blt87RmhJ0Vkx4dCJq4wzBxYOk+9GIbkqcaOAoN9P9kjxEp1K+6rOhhYTc6SHm4wscFgpkg60Pz0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQsbJwkvuqQN0o8Pguj5KlrsL/wQ+TnsofxVO7XjZp4=;
 b=QQ/VbAcDvuLdfktJrSQs09K/MN0UKEQqAvCzZuXhHOEfuI1jzrV3fuLZ9xeHeVohmPVEQ2Q7g88br0d6pbp9UoBlW7SFaW+27bISDJ8sOKUd8c8rOQsTCPuSDymL/mgfsD7GGmaVlEqoHNsnWltlZS25zjaomSQsqONZnldwWvZ6QIT2H/QLSJd9YjDzcCjF/ZIyxf1NYMqBFkD53YQrmnayPOWXEcfIWS80nP4Ej+SJwlccQuHC+X5TUiXStzkn/auIZ5RChk0dPVu9rwjGINp7k5ayCR7UMt27bs7DMOFB3AX2Onx88HypE6+oRkCK2TotOrI0SsdcrW2zcRw4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQsbJwkvuqQN0o8Pguj5KlrsL/wQ+TnsofxVO7XjZp4=;
 b=y9hQteUW3RP4xM+/9w5rd5x18Fpax8j3m9RHW81zK0BqMV3O8Gn8EPf2BM5mmTh6j+R4sB8Zga8eC65ZT+3lMMlSC8CY0OJCl9MNB0es+8hTeAAAGtFH7bFF07Y5ztWo7t/VbKikb9MyPmeUjAYGX7u1dCFsShY0B1PsqwLRq4qxTqW8gcDjKvQIeV0UJdh8DtplDjU/VLQcOkGwvI+fSNk8iL6dF4PMn1yfrljSCAxzBB5cHeGxRhslZN1UGCAqHrs6ONRpuGu6u10UQSo3W0BWQXhDhJbL1JNzHTG+D6EkZ79ApA49SM+NklBeBHc8UgCFmHDpU1eRNL+sSO34eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 10/11] mptcp: multi subflows subflow_push_pending
Date: Thu,  6 Oct 2022 20:17:58 +0800
Message-Id: <9c15254bcb9826194719bee8da25829b84c08431.1665058389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bf4549-2816-46d9-abf3-08daa794eb83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6riJsZRwrfhf0eFO4C++5tFpEmocLD346dI6wU7GmFKFpwj1Wxv3TbZFLdo5WyGv6LbL2N10LRXNu1u/d5G4/4eiUezcAbOkPB1dqT6i7KQHRZEoYpy5hI3lDjjvEhAnWFegt09lpk6pAXjhvjFyZvuUElzDsdHMSoDV5gbs7urhRLk7P1bBlHg+9b45oxxuwxuL8c0Yx/S3sV0fUknKnuXD837+9iT+bS2uMy7/xajIvOaCBGCfiZEdik5xmgJfIfE+Um7Fqcrfcvucsd6YH9TEl5wESNEPay+euqEzZcd+3TXnTBYqtyGkwW6M00GpZoqGbmtzPmJ82QDB0geUTmD3hx5fzFeCRdcU1bCuis/4bpQhWbIqivFy8RgfQVdx/HwxL36lt28JDo7eUstcR0jEqhiyx2JIUTD1gPhSD6FZJCv2Q5BzuHI106y7wIHnd0NzTUpMvPFzX5gyDAlRzAcTEUpSJd0+tsY3qBpYAnOoL8uZQmmTifBp1hjNU5/XzhN20NRoXtdIXHM20bisbzkI9ssY1X2w4grmurf7NMSzB8vMyOqjZlqC8u83flyb88KFdj2QIn2bTt1wsaMh9RJh/dV8Nt7mWBDHsyDlDgz8bKhJnx23hqxOyyfpbC6eOmop6G/V8qGEJiDc4btL6YYtZP1OMRwT3PpKlkyNmfH/94uHcvziZ9f5YhZfZdiCSjau6/xQqGBfkWYJCNR9hAAdRC0EGlFErK95bkZudc7kYZSH6aax80kM5P4r8AX4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGNC8R8/3qCluAjHn43Jc+DXpxNxYlHgw7IF948HoSVruBl7mneZID3eog2X?=
 =?us-ascii?Q?qm8ntoEPKMe8ZaDwcFPKcZ20SdMt5udec5BWwkAL1kE1actcn50UGVsB4RDE?=
 =?us-ascii?Q?pr7Rw2Azkmr5EfB0ihohPHrHYxEqz7fQMMrYjKLWCLxR8pIEArSk77qiWqVA?=
 =?us-ascii?Q?RA+6di3pfemF6zNfHJdIKH8JYeADW1c1MHZv0jU8212W456O029yFMcmuirz?=
 =?us-ascii?Q?P2Soy7sA8i+ymc0JD6ZnJWHzfS5LZlllyPoJAZN1g2SUg+peRirHhXPeW78l?=
 =?us-ascii?Q?Ofkuq2yw7GZeQuTmOD4V0/nTvO47YAAs0gt5sLAnjPs9sAxAS8mlbWIt2JrE?=
 =?us-ascii?Q?Z2XpPemQFmuWPh2Z8xp/gZnQzYAugsVybGFyBPXqQp2sofV/7bXcARZyzmtu?=
 =?us-ascii?Q?aMo3eElQQSlfA6m6xJilKYs+mmcPsJ2fFi3RqKEOCbWh8AEjPE5QvYlpJMgR?=
 =?us-ascii?Q?BJvOvyvUXwol9yph9ewuVrjckPTiEOHHLDXD9eZslTnAuMyB8vsBxkW7XwQZ?=
 =?us-ascii?Q?r5kyv2I5uqPZqBSe0S+EHsC/iSjfznqzwnypr2y2h6ttw3nqPlj9jLTODZvB?=
 =?us-ascii?Q?f3XiHpxLlljOhh85OqlcQdUNB8Fc8vk7NBH/Hztu3B2d86SdX/Hcma6Zp23Y?=
 =?us-ascii?Q?7ugC9Yq8fK6JahcnxSqg2iUaqm4U38xaBYxTc0j2LRCCzSZSAIU69s4hADkA?=
 =?us-ascii?Q?F+sIY/XnyUirj8fMDr3doni2Q6zhyucxDW753C0iFthTfR4OipBCNrpdHcOM?=
 =?us-ascii?Q?2GoU4OL4gbRgfrmuNQZfFY+I78fHEY5iE8yuGQga4R+CbORPwQr9X9wLJslI?=
 =?us-ascii?Q?Xyp4KI4HCObkaJTFeZIL66SxYlbeXEwMcLXqopapmrl6Lt3YYBc0niPKe/o6?=
 =?us-ascii?Q?zax1AxpPqIXl9jtZiJPycb8U+6zs9OzZI46HOdl7zEc8hsDuz4Nnl2zJ5aV9?=
 =?us-ascii?Q?pgLF1gL1ZlyL3h/5gjdnH6ZnKDDsxTFySp7/hd1HGowG2xNVeuM0nvUBHV3W?=
 =?us-ascii?Q?6pv23SawqR+XmjPNM3ivZL3oJzvoQ/Emx2AaE8usvtKiEGnQU2RZo0YvYcw0?=
 =?us-ascii?Q?Dn5kN8puXTU4jjL7qqcxUOuew2PLlKsphj8yXdszZYAqkO3Zhc8/vW9mBo53?=
 =?us-ascii?Q?lI+Is5npR4+EuoxVb+m61i8dhBYbNRmxwPY/fFO9A/r0cOHM6JS/o0OBmHe2?=
 =?us-ascii?Q?rrtZ783NmkFJRh+Tld8mHcvhLFjXhdg6YWpHvcsm6hUAwd1WxQahn8UL8pFa?=
 =?us-ascii?Q?CWJU5tX+yaGXla0oAkeFa7XYZh9B8sqzwNuKPMB28YOE4Vkc/bLusOLlP0SO?=
 =?us-ascii?Q?D21CoOxFwu92HKenHcF4gLnzrCIKciCKjKQTgtjoTNugSg+yEg1SSa6T8M7J?=
 =?us-ascii?Q?mm1XHAfJysLsywGt8lj4ja5IZvyEn1xBfvzwEwc6N6+ENRgtu1IwwJLBvdu1?=
 =?us-ascii?Q?hQNW8tpKug4wEQRcbM75ODFcg4ieIkbENDtcfcZiNZ+oHhCyUyegTrY1H6Bc?=
 =?us-ascii?Q?3lNOJbMfp7oRthJKawNFjtT7ct+aVuJWE7larlv6rSIinWYepFxvb6CHZKE8?=
 =?us-ascii?Q?eQERBj+Od/8C8KM9YkIHk+ILa7gX7QFyyFuWI/vX5Dolq53JG8qxDTOFPO/O?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf4549-2816-46d9-abf3-08daa794eb83
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:47.7744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCztraiQmA/oac7mMuGEyfnD0WDTqzTpoPX4+MZf1E+3te7AYkvUhS4cjffpH0wipzw0AlT+FzrxQ0dUuurr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

This patch adds the multiple subflows support for
__mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
instead of mptcp_subflow_get_send() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 66436885b749..ecea2a400e6b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1601,10 +1601,10 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					 bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
 	int ret = 0;
 
 again:
@@ -1613,20 +1613,44 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					goto again;
+				break;
+			}
+			first = false;
+			msk->last_snd = ssk;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			break;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					if (mptcp_subflow_has_delegated_action(subflow))
+						goto out;
+					mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+							       MPTCP_DELEGATE_SEND);
+					msk->last_snd = xmit_ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+					continue;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

