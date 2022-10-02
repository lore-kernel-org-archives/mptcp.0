Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E233D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdjM1R/gnOAx/Z1sPORYOtPDEUgec4I2baWxfrPRGuyilN1Ea6IliArge3CKA+i9ydF9LkhCKFWqVf5RfK0M5yLI9QdYaKoZKXXrZfpeeFYUhRxqQWLmZ+JzeCYPzwynhp/xI6vAiv2khkwaM826/Agn6dYTLmzrZCN6VHkJo1q3RiU1PGnoo2p0MfhgF6g/vBrDrpufbMSov4bhHRLy1wY/4s9rDcjNhWTJKeRTBXrsykNE9a4EHXBxuViNKx+47QsC5sD4TFvxcJBOIsvP/lZ1s4r3FSlXrx/4Td8sqxHIapNCqmU0HmdFe0hoWpXu5hJLGunTOfgZeSJNUXqDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEwiw7AQPDGH+uRFNaT68sCaIFKgjloqo2079KiU7Tg=;
 b=gTlHRDBqBXqMJr7EXVk0459JrFFDQ3NmhiN38ChdshbXTc0zgzb1pJbMnlEtVNjMXJ6d3cHLELMdIeSiVb8wpCX5PYqWnDSQnq7ao2eTclu+wAen4SyAjLvkNuyLSB5fLwnRayb4B2b+YA/72EMfPzc4PZllxRnfat5KnLHoXMZWICSyzITQ+4ZxxqSZhOAnGf0jspQitYzrNKsE0OWunAEUHK9zhwB3jm2PbBdLr+sGS26Yw9h7Sq0yTa34DA20LI8JR000x6Ndk3OYyexg3O37+49ctIn911WnSvT1RkMRUUcR+DqMwt89t6sHh4oB3JvMgb9iUCIcZ5PIwpcaZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEwiw7AQPDGH+uRFNaT68sCaIFKgjloqo2079KiU7Tg=;
 b=uke9KkBywZYgklGXt71nrkPqbV/RcaLPti8tr3gIfx27n5z47blkMMMQlM1E7xCelhPCQsC/vT/ujTgEFI8s36rAgp32Vh4RljnT4SS9yZlUY/M8At6aBe6W+F7lG3g1thg7REbeWEcdGuoLhmX7ec0Q6WHVNgAAwTGujcorBbTN6HG3J4IKoMh8HdZ9YRP4zJFp1MPvPttffzLxzJtKMyiraz+ZgIZ+dPAxy7zXnIiifpsT1twoaUCk6wzmKEaR6aOl0vVIb5yDDU8pkSL+F1+9d+aoBHcBbNtyx0QfInHUcSN1RYeBaxNmjij1jPNFh242eEG3S+XszvTutuzMng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:26:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:26:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 10/11] mptcp: multi subflows subflow_push_pending
Date: Sun,  2 Oct 2022 22:25:18 +0800
Message-Id: <3bb3e808126d1b4d24d7979a2b255bfc0232789c.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: c19d8776-f63b-4d8f-9995-08daa482083f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3cyD9IOjG0rKmBty2tX/6OWEgvZDQfjuQic5h8L/5lNG/IiBWxiDvtgV7v/N2lt/8I6BJN+2pk4eRhDcmiBMhkK1vOUlwcft/PiUqLvx6HD/FRhsBvAXsIFn9gtiC1koIR1NolYvY8/QJpwsftYmFAP0lUD/8SM1PvmLoD8wsTujKuF9OMYnTf/VICYcExA5nyWQhWJnMcM4hrhzELdRSMjmTiy6TtG4Mg9D3syoB1sZOlwwev5KG3HK6ceIvoX0rvXYA/kEKAOhhnQorr9sY7onlE18AUd/IY/Y2gi3JiZwrG/g8MvFxs17oCagRSXkJ7xA8VTnKzTAO1Ne5Hp/IzRxWmuj3+563ggiemDSKbXJcAIAa24qksSSazlbFErOY3QJfqXmmHCUo7AxR/yPdN8XJQ0uRmgFWgeNwFnBEDUE1rzklgPqQ2bUSiu0UrBZWj6VUAu7tTHfsj5k1SO/xMrpccld2aup3b6UwtoDCS83AO8ZGNP4MqnRAJ1IobsFJJME4Xmx5GfaXc6wLSZtzAxDY14NWjVC8vBdGxMWTU09hxyOhxU6h3iuV04khb4NghAbgFw5c5eFFzjtM0uN2ob91HWG1nXqSbO0RriIaqqiyAMlLqJnPXM7kIRwPIjqk742XgifiSO2g35vMqTle0/hrHqZvDe1SES40jbqWpnjeXxJ/6+Y66Vd82b5k9cXxg3ncWDxhfhvnrQVk6P0DQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HFvz8xMbCZ5mIxy+8gMt8lOHC47F0KPXaXu/MSKDAez6+Yn/c3I2pDmhv/K7?=
 =?us-ascii?Q?Dz5RT2N20otEz9VEo0iIjkMWsnRKAssu2+E4T09NBpR5Y3SAcAiiXcFfTcLB?=
 =?us-ascii?Q?CtPsGJqD5gh3sfhavnG4885g5cCWnkbx+Wo76qrvtCl3ms7nkkYH4g+99Ru+?=
 =?us-ascii?Q?2LeKsdFoNvtgZkM/wtIfQf+LxXi+wehfmnT0QaeRj5z5x/u6kD8muy5dIIFQ?=
 =?us-ascii?Q?+Tze0hHUjSPbynUJyLADkBbFotLtW2lKQCovKoaSzzLuxAE8QXfF0kDwE1yF?=
 =?us-ascii?Q?XtVsMFBqzWVfZZvCRc5VCVMGCVtcq14lUPte5eor4UcCkrVJgwBU4hHFc3wN?=
 =?us-ascii?Q?a7i/M3XLCEXsfMwC4JEG7MM+E0pp3EvqZKj/vnYpEE2k43eRKWCq2FwznxjX?=
 =?us-ascii?Q?0RghCxADNptbhBQhJ7Ln+9fzXUzzmMix9bv0jU/Fl3NoVbdSpIHErZTLBaFy?=
 =?us-ascii?Q?tKLm/1xLyCm9EifbRBE+lGuzLp0uBcDjpembKON0PNn1ezIkzes9slpuGun6?=
 =?us-ascii?Q?/oIwrnHS9HxgTGq7yrvwemilyr1bYPYKmDw2isLxplmWI+LKPsX8mvd/kMNs?=
 =?us-ascii?Q?Heg9N+P33cjk7jrREeL50bcZwvqWLBtHfrA7kINaMt9/puH8D8y+fCIg6SS5?=
 =?us-ascii?Q?C/bc2iajNQ2W8aYHI8aISSzl8/eewKWKIYaQ5AfidZ8ZwtCqS8QLsA5NgE2t?=
 =?us-ascii?Q?p59tjXctLf4RfCdMCErdaXzinu6XKbeFbEyH2QB+YZuezmQRmjdPstpjg4Gz?=
 =?us-ascii?Q?7YjKuW8dRPXq7tpNYFVcdZ82YYeTt5TbzGwrDOurxZiwcBeg14luoNiN6So7?=
 =?us-ascii?Q?PEXa/HlhW+lKue7B+LC7DIxiANfprS4qd110YPiNtt13Bjqf4Vtv++XqCcLg?=
 =?us-ascii?Q?oYZlMFVFc7260mx7aATrxHVRUcYanVt8WrkSDslHaAfpqvz3GzM1Wgo55kJx?=
 =?us-ascii?Q?i1xEbVqY3tHpTv7ALs4EdkqoUleMdcm4xo4hEz/9rW539rQ8KvhjOFK8wUcZ?=
 =?us-ascii?Q?NKvZ+tch7EEMB/vzdMBXjljANm5+AyGbHIxLjbT2rrABrxcQpIhtX6CP4b2g?=
 =?us-ascii?Q?1KeUjIAW+vyGjsOr9vfw/y+xXCqHqQoOHXB8IL0Ixw7HKJBgGLOB9srNjDHu?=
 =?us-ascii?Q?nImSk+03GCXjoI/0ait6op5/Icq7+0cHAOeLhKmDbg6BBMeIjGdXIY8YFTGO?=
 =?us-ascii?Q?gX3/jyMag6Znk1fvF/b3ikS5n10mOGlNJ2G12RxaAK0x/+Xh7mSlXl4zVdPe?=
 =?us-ascii?Q?TNa+2fKGh+QtUMZYUFL6Q+C/EhFgBmyfQmObYJRpVS7+R7ptoRTGN5H8eAkt?=
 =?us-ascii?Q?hgtj7byYEYT13IzS6wrxlsQH3lLYFEku8hfZwQh93QpKmB8haNIrbceMn0W9?=
 =?us-ascii?Q?PO79KFEYxtptOx0xZWXUvL8vSOq7Q3A3IOMWbQWDdc1yzMuu8j+LtPDoUN/R?=
 =?us-ascii?Q?jknUd7uEG4yOXSRrfBO21HZoHyBTa4T9NAozN2UxzvKx/ySr1R5CJtd+ISGB?=
 =?us-ascii?Q?Y1I01+XdWY4rGLoeEoJQklM59OnOYVjfZe+/2C2upNJHu+6+HnbMBy2WRVnv?=
 =?us-ascii?Q?+uOcSwnQdgfCQJcokfaViwcwVFuAChyZWxu6aCgZwH9RpFfogqrTTQVssEAS?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19d8776-f63b-4d8f-9995-08daa482083f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:26:02.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3j78XJyZm00iOHBfrOCXJ3JgPZubtobnJ7xxHcLWNYHfj/g1RJFG2h+unGFixEuanL4e1rBf7i3mk3qJSMZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

This patch adds the multiple subflows support for
__mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
instead of mptcp_subflow_get_send() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 439af075b144..85f72cdfa2c4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1593,11 +1593,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					 bool ssk_first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
 	bool first = ssk_first;
-	struct sock *xmit_ssk;
 	int copied = 0;
 
 	info.flags = 0;
@@ -1605,18 +1605,39 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
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
+			copied = __subflow_push_pending(sk, ssk, &info);
+			if (!copied)
+				break;
+			first = false;
+			msk->last_snd = ssk;
+			continue;
 		}
 
-		copied = __subflow_push_pending(sk, ssk, &info);
-		if (!copied)
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
+				copied = __subflow_push_pending(sk, ssk, &info);
+				if (!copied)
+					goto out;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 	}
 
 out:
-- 
2.35.3

