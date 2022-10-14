Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D220F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGS2MxnbmBPvSqWCPEy3Ac2+mo1V5SvqLNt3EV65EzAC+w3DlnFWHqVtMDNoJgkjZcdeJHkTwW3dF+ppWhDt+8Dp6cX/q0lpzusO/xfELihIi32XOF+yt8nIJIcv+RXPtnkUXERhfFd3Zu3dxpxrnLAcMHJx1aQvx0QFHvOg0LU+YSXYDtKg2hZUZQA8mi3xbdNUti/RgfAu9wGwyD6I0kG1h5gUN6r7AIrOPhzu4loevRbGvQ0RDj1WO1C8Tkvuedg34hvJK3LhFSG9N9NOjJxhWE+nyHvfmJhwmfxZolqckqzLkP/FyUDCmceyjjgpbZgk2MtMZOh1V464NmCgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6vNB8UECY9SfUrvBcJPfjR5dkMmJID/PpokV5uKAqc=;
 b=N/Rt+DnNXvJByUecp6ZlXAPMisqtURFI6cQXjJMYt/qULMzWL3hsVvybwHYhZfjPKD/YBPXyPKF2VL+zfSUZqd1SLuwscYT1K/IOZuVyME/1tPAoATDjXFeXi3A1tNPC0hn1eLM9sZ/dl1OijWILFzv+1LIP3DYhR5OtBNhKhvYYGAD/qDbuURPF7av6xvbn+fna5jKis6YOZi1RwWWdxpSJBr68LOg8HjG1i2Yz8eRFU1FSNWclduVv7qKwWitOA/TCbMw1bQmnUA2+iIxDci/ghh2goMCzqXeSm6RiunyMnMFYCuw2yUAaJI3EdgaFM+1+Yx5uoxNmYfSsSi/+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6vNB8UECY9SfUrvBcJPfjR5dkMmJID/PpokV5uKAqc=;
 b=BdS7MlhB9rWZx5kaiNqSJDjcoCs4+3olE9z0Rh8LsDptlfARCaweHEMJZutjCjoLrngl3KXMq12udV1E307V62Y1TgM+JSx31qhoYlEACZvuifsfsHeLx8YYreMZB3AG7+kP5/UaaiLl2+XSoi8z8Kin1shvSpwY+cA20jWR58fJhdQkdMaL3k1177wyqdVImvALkd1e+ffcHPburbqeo8/x/kx8kiB2jG8SA8Y9frlWXnttOoDm8sMKRaYlJxX05VUaArtMSPOoFmxD7y4PQ2dHsSEqhf9rHo7QZFCdqSzmkqM7XWdHCr/MOBnZlunifpPoE56g86x4kjUKIpariQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:33:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:33:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 05/15] mptcp: drop snd_burst in mptcp_sock
Date: Fri, 14 Oct 2022 21:32:12 +0800
Message-Id: <d93f71b399dcd3d66562f10ab63d27dbb24580f4.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: faf16270-5622-499e-2c09-08daade8ae17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QzIUxqotUrkwDyz7azIZJC204EDFVdfaB74xIvRwRowDu4AnOLTtvWd7PLk0qeBVjKyTSH8jjGWpYFfz2BZnH/NP4zoeSfBcayHYHsBiYjXItR/mjCQfellE5dU/nfUBe8jrtqX7DZDDt1tgr7yNkgtucifSwGcIzd7V/CmWvSka3GAKXvnpC6GWNntjY2iz2wg7GFbVKDofemoMxJy/Rm7E/Ep/4K9j6tj0Bg0C4FMBXfIIPIZmK87ubVPgdSFXNg7O9Fsjjbq9gopQGRFUqUvDluPZTa7TMiWLfOMV5K3PFIZbhlAO888XCfRH5VU84yg06aA1jG7oHCrAxRsxht3mEGzO0cbO5Y2huSOFIL12TILexbXepp+5CEJpkE/W29hpM6i9NQm/LvBcb6Ms6+VhNOPN4ZgNNEl4DmugiVtKLvWT3Z49ytiPMbvQn/NztQGoTToWY9Mc1tJXCM7ncX4nK0brMKnUYyGp9+l2KGnCJNhhnBWej3iz8xCHvWOI77+We1atlzDoAwpm1gQkTO+BTeRm9721GMD7GIZT4NcqPHd2H0LssgG0RXoz3PAe4cChHZehChO2qpqkQ6Q37AgjK+HnmNp7NONTfaem91kMXR+8MtwmPGambvwLBPrv+wcdEYO7pr/snddkmY1kERmBpvX6V6Nn6LbNUsxp2nfoK8CmFMyIRsbZlti4dqF3oa1vqJ2jqgTiaTyAmp6iBt7W3EFVdkL+dJxTVcuJyi9IzgjYHcfWztj84FLFFBYm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(6666004)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wyb2HK74pg1rOcwi+lsk/iLMdrm8heBkIwFh8LgGvOQy3qmt7Oc6cjKT83QC?=
 =?us-ascii?Q?iYG6YKesAtyZsdrVK6BGuT6CdiTcEPDgQVxnpk8/Tr6AAD6bn5Jr0LTVJE4G?=
 =?us-ascii?Q?uOZ+URFNTRcXCeZKrvolMIBuAuu7Is8iVfTapA7lLl/t+fWLIq6BE+6UTZQx?=
 =?us-ascii?Q?sDWqr4nZ6jF6IHPXSe/TOe/0A3LDXUh6WMIHdMXi3KrF5eU/AjbopxQBbXSj?=
 =?us-ascii?Q?dIRSq4F3RS6B40GdzZ2/wLyoA8npITuwlcCV8MRFSYA/VHLGRJJ5PIIG2zuZ?=
 =?us-ascii?Q?v1buFLqBiNqgiSCiyU7ZKqkfsQj6G82Pzw8q4o8hVeMkumMueiBU/yZOj8fG?=
 =?us-ascii?Q?ns5AIYimm96kFSC6FLGx1FWQwyNeaU5sl1Yzpc6rpQbxTMJT0e7Hsh1zKVrK?=
 =?us-ascii?Q?ZfJ1liynh/8E5gbkQbw0ftKXcRzqYfIogoohFYAAOvClanVIOt14sQt61oS0?=
 =?us-ascii?Q?SUymTPECX7MckhKr/w68H36qEnfn/BgW5TDRV+H6q/3lHPSpVQBRm/Zv8sIz?=
 =?us-ascii?Q?par4UhXCcWEpFByEGlVtEhsRMVTPBOazc6RTGpARWbUnAII8aMsGX0aSGbhj?=
 =?us-ascii?Q?5jAChAjr3FaQxCVvFFaurFcQrKpiIVjiuKSi/+x3DWsA0V6tdLIwobqv7Snt?=
 =?us-ascii?Q?AlTg4XlXXY297v9BT0/VGb/mI2VgOdx96+py7SlzTep6ZuqOuRoiIh3g/t4N?=
 =?us-ascii?Q?RucpQaYFY3E4oJTwINXgewqc07ng/r+MtaNmMmFwQ/K1872uNGKEeRXRbWpA?=
 =?us-ascii?Q?GBN4jE7duY1GWBBTvpa5BLazk4TWhQeVhKnkeyW1l81bAHpc5/pCDn7imfhf?=
 =?us-ascii?Q?p7zu+MJZ8SnQ1VseRGaRydImkp+p/m/7sOMTj8pP23E1fZ+q+Yw4UyidLH0k?=
 =?us-ascii?Q?njyPSykhHdyzqcTqnns4F4WexccgChAJUrxiFzRap2ybdCwcbFWjs1VzYr0S?=
 =?us-ascii?Q?3BPSut1jDpOoq0wlF8DkTcMQNDLnarsGj/+jjOjfp3VZGByByNn8Xzqy4WX7?=
 =?us-ascii?Q?4uwW0biStXQPBsGPl6tLgkrYz4T/q321KsyiiOcGnFGSoLEwEsuGk/4TbGfb?=
 =?us-ascii?Q?+bpZFB/jB3JsXhrjJvYBlP0gFc0unFh16Vgb2EShGssBbY2doDpiioCctWGy?=
 =?us-ascii?Q?Pa16rlKRQBHDXNaUBqYoNY9JSiDASljVo4Vd5QrOUe/j6zwW1InjjGatb//x?=
 =?us-ascii?Q?OFnf5zm8ziEHuIVeagw4r0gOJze4olxt1WeZvKPG9OlXG3VL3LHbBpQDRqlG?=
 =?us-ascii?Q?UmX91791s0jAm2rOL9dGycXArSD06jW+9QKsCw+ow1PxcEvKIp0cbs6eQegU?=
 =?us-ascii?Q?dxd6G9j1UdZYhxixetwc30sQJJv1zY1XibDievs8XiYBAR86Fcv5HZBIH2Ms?=
 =?us-ascii?Q?3CHkHQyX7X+Md68Pn/ncUsUp3MmupRoGXMmrBKPUNcuBrne4jVeojaWlGQJp?=
 =?us-ascii?Q?WgZCYuYX7Z768Vt4isfvz4ko2Ad1GlzYwpIrBF+iD7aRof9kVrynRsZFf7sK?=
 =?us-ascii?Q?TLs52HIA9ns+aWaGdFeuO6UUe211oAl+kRssxyUjBUORGo8qqYlehCWEphSO?=
 =?us-ascii?Q?hbnsZQRMS6gdv0RIQoW3M2evyyD0/Jfg0d1Dj4kYEyQwyXhVEHmUruUZZEk9?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf16270-5622-499e-2c09-08daade8ae17
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:29.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SINRgOLvORoS5PQ+SOse/bpp1gyQbdRm+kjFs+FTvjIrKaTUmvX+rmpFjoTbvk1wXL/DVjNQnsETXjH3tIeq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

Drop snd_burst of struct mptcp_sock, use data->snd_burst instead of
msk->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++++--------
 net/mptcp/protocol.h |  1 -
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c807220277e1..e95a49e5bc89 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1427,7 +1428,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && msk->snd_burst > 0 &&
+	if (msk->last_snd && data->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
 	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
 		mptcp_set_timeout(sk);
@@ -1496,7 +1497,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
 	msk->last_snd = ssk;
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1514,8 +1515,6 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
-
 	snd_nxt_new += dfrag->already_sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
@@ -1541,6 +1540,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sched_data data = { 0 };
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
@@ -1556,7 +1556,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk, &data);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1584,6 +1584,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			do_check_data_fin = true;
 			info.sent += ret;
 			len -= ret;
+			data.snd_burst -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
@@ -1605,6 +1606,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sched_data data = { 0 };
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
@@ -1623,7 +1625,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk, &data);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -1639,6 +1641,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			info.sent += ret;
 			copied += ret;
 			len -= ret;
+			data.snd_burst -= ret;
 			first = false;
 
 			mptcp_update_post_push(msk, dfrag, ret);
@@ -2277,7 +2280,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 270c187c9001..b731e7b37f5a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -259,7 +259,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
 	struct sock	*last_snd;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
-- 
2.35.3

