Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30076.outbound.protection.outlook.com [40.107.3.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEFEA6
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 08:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbXdzn0Mz6w9YKIkCyR5dIYvMgQu96dQrmnjKHNeA8FalLuzJRdvKcDDKPGHSMrESLBxfZuOnBj68V551ovvKA5UjKtrwQhWfuzAIjnQ7/V9Oxe6rk3jFV0g9zqBGaKk5v12sE4IWvknv+vsX5hVt1m0ASk3wihWlDFa1il8gLcZZL4FlQ58mjt0SRWt9DRnHQcYzqBnUcqz2oMBXpbqAHn2HxbPjG4/1iA6OvN1LqYtZB9cJOdlxECS40SPDVIa3g4y965Z9QRDl3yIO7/uhMqDIIX/7Tsk0TMLZkqmLpTg/EVGCmlHbRXBDXcqijuhLgVqikX2kYMZqrYed3pPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUTTg33+3CDrczuIrfebSYHK+Y5M2yboYyz+w124WKE=;
 b=bZ3cFOus9yBqezX+9HXl+74etnnfvQ9+ds6ZYHmGns6hgArITIUQZjLBbig6J2WbAuQY5kN20nvPR/L0NGAuImpeihcV0kOSymkfFLg+9zIO5V7+2XQ/goVhDzdQHMGDcqBdipcMu7i7vwaoX07+ShhlDMvbHzDg0o4vEUOwX3ZtaS4Adc4qVVAPU87LadBmQt/yZaB2gprFZY+yvGnVksVidWDVeE8ALpjGEDMpIDjlKPHfnN5GzCJPs4U2Nl6/qDsNIsi98/ehQyxMYIOVeKL/Kk1SqRjhGGgqM5vQBPIlihj1YEFdcticbkFwp9eRFP9+fm0GAIxoxj6A43J5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUTTg33+3CDrczuIrfebSYHK+Y5M2yboYyz+w124WKE=;
 b=BRviVlF7FwRxl+d3G+KdYiVdiPMF9crdfi4r1U7XMPDvSmUefmonBeVnbk21JYM/fZGKyNGJZkS80BWJrMarpYPWYmOuiZxxLIWWAn3LStcRD72WQs171qP0cYuThD52lJBdwk4mk6af7nJG6o6JG2WWAVFzMJF6rcAS1HZBHUEJZRu8CIsRfpoMZpSQw6xBq3v8YmGt2ql7NltVe864KYBAtokLdyJBWh7XgKP6NeFtHA/NKlpztSJ5Fs5AxnlSW/zNlsEj7VQst5kQWloalB9y7HI+3xandEkCpRFkUd5mz9/MIWsnUWP1cH7vNlhXlCHzaWbqfDP5u8cjnDZQYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4381.eurprd04.prod.outlook.com (2603:10a6:803:6d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:50:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 08:50:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 2/5] mptcp: redundant subflows push pending
Date: Thu, 30 Jun 2022 16:50:51 +0800
Message-Id: <ef3d52ff98c97b3c3e5b1efd84a1d4bf3448df5d.1656578856.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656578856.git.geliang.tang@suse.com>
References: <cover.1656578856.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2144d53-822e-47e8-38e9-08da5a75a59c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3qzmW1O/ACuZoOvA50zL/7lllFHeglDuFhMVA3+9VCRY81M7bQRDNw0sY/kGxzpPWdaYqq6WOVIxjsjYy8Mc2OM1T2KaokJ1a5tauGdB0X99FoMGr6exQYABpPTFwmQ1dDbcowvl7HADrTtffhgGu6gkGFMw1w9HNsQ8+3fJZnpz5a1JrbPepfqbabZmmuiszVsN/n3hjmvW2dHX4dcAsbZUtkEmr4+yLMZh6ykr+WwWTR4Y3h5UZiVBAgOc+qGN2nV5rpFpiKGRtnvScMlkX3brXMd/2j0V7jv8qCRndoPsTC7fKsgMJ+EK0f9uCCUwUTUhkNmS+W+oGQ3PPMxicVLl1DKYjXcr4RZKv+dhlcfsbD3JOay9onhpTozG76PdiWdA7fCfJNAHMH7jZEtSnXKrpLkfJ1WbWUJtEzw/yshtvNkO1GkSNURuZ+7IXv/ryuUDavWN/iSB8XGKZ58qG4ub1wI/MZEXhmhh302tShcLPBWHwhTszh9eJjtmRZWhtSeKBZAgEUxBDJwyMME2h0lmGhWMjJ07ZOu16ygzcLwHnEkYid2cLlLOApzE2mIiWtp6lPKbE4xkdW2KEl6GD6yMR4oYbdg8TMlDO7lVafLOQr2GfpFgeRQUisDQSZEoraZIfE+RRRwrWY1qku5cfWscBPZXuH/A04NKuzx0gzhdVkbKud+Fjq5uY1knAb0IOncq75SCPCsbkVGfbOiHtlZOfX/uZcuA1boqwxCH3Bi1x3uuInYVikY2FcB7w8EC8GZBLY67x4X/OD3Nq3ruwk1Wdx/+OBnkSFWGYbNAKIrdzJExkUZowCg+flSd5jej
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(136003)(39860400002)(66946007)(44832011)(26005)(83380400001)(5660300002)(8676002)(6512007)(4326008)(6486002)(66476007)(41300700001)(2906002)(86362001)(66556008)(478600001)(36756003)(186003)(38100700002)(8936002)(2616005)(107886003)(316002)(6916009)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MyKpxH+TpJ9adQyimQRoml8YBSam7qChFUepnO+IvFkhLsQULLM8L668Bhxz?=
 =?us-ascii?Q?9VA84aWU3HDQzx2Gt28WpVHCOKZ4T6mA/bPCrwhP6J1IsCVEM/2uWoUYP2j5?=
 =?us-ascii?Q?FMdMnHMau7cbLh7ElU/Pwe4n6yeBjY0M6T+WOeXBNjJsSfT7h8QMbrFO4yNJ?=
 =?us-ascii?Q?Hfvcr2dIxHb5GoNLLgaPhGAd1cZ7YmD3++u+CTqYd+E3xSCXFujLUSq97Ptz?=
 =?us-ascii?Q?gJqUn15K13RiC4EUqzQWEV0VpHluI7BOqypGS7ezaho/NLsxmfUyKXYNtlVe?=
 =?us-ascii?Q?+4hcIzmgbGZrMagcgCIOKMUMpbFGcRMY5vmaGDHISkAUqljMXaY7ZUHdizCZ?=
 =?us-ascii?Q?Per94fx8E68+icJ5DvRmBMI3+CkpWOpW9zwJlMLjbFNvIq3EEWXUcqf9FynW?=
 =?us-ascii?Q?ctaXfnPlKFFbyamEqG0iRob1zLVyZfr8C9RkOXXZGsK7ix0joUF8tCXnNiS4?=
 =?us-ascii?Q?GqtKGbJ3cndsnUOI9vrfh3WspL5ggzxA99QozYJl7nzH9g6B1C6WuEww2Lbo?=
 =?us-ascii?Q?l2MMAVsH0k0to+lTsoyOtCRgj8F7zq74jG9tqmF+rYAPWdqYojmyjWSpSGk/?=
 =?us-ascii?Q?ieeyXK19e6e09lw47/zCf+uxZZsFh4VCc5XokF2+6pcqMZv3R01GrppuKzUQ?=
 =?us-ascii?Q?LaA1OskdO0MmK5J4BjDKvhWSe4WoyZTHJI3VOtdid0oTCJkNADuKaK4HrIRi?=
 =?us-ascii?Q?SOkVrj8xmp/6eUOW648CjiWj5a56UKUbcYMUxCC/21bY9CB4V3j6C6nLK9Hl?=
 =?us-ascii?Q?puLdwNtMKKR11OacKG0tTb+50DiplA9AywIoMtjP+VfTMriNW2RrEptni8CH?=
 =?us-ascii?Q?L7hcbJWNeGlKlp1JuM2z5dV7Z/UW2eWo13Vdp7DG/dzHBaDkrdMNomMtaRCa?=
 =?us-ascii?Q?bHRjs64u7NbcQd2ARDQ/85/pIiMVV5BtqgIWNpnEPHEA+cSN5O43O1PUwC0N?=
 =?us-ascii?Q?WSkbgbkxaFA/8dRo77ChrXUr5UsKAVXn0wt3yE34j1qGYJ3rKL1HT21sSXwZ?=
 =?us-ascii?Q?uq82J9YyFL3LanlRrCtomKUXAycAW4F+MwpvfZ3wEa7wf3GqAQyvKhUwMkhh?=
 =?us-ascii?Q?1537l0/fBjDh00eHS9hNSdtGJ2idAvvhmb0vHEISATG2ioknRWa6dIrDwavB?=
 =?us-ascii?Q?A7MbHNLpd+0IklvP3MaxDqZCUIXolGF1zBltxlUY7WaZKkrJvbB7joBwhvtq?=
 =?us-ascii?Q?d/OLfoFcJcekUE7P+5eRJq1dNSoRQ3mHabdaqA1nd68a0883mkxG7qhFJqT8?=
 =?us-ascii?Q?zTPd7l9VXHbWAXjV2Ey6iaEwf5t28fxp0G5FjSOFSozLooZQysnwNTqqiWK1?=
 =?us-ascii?Q?35OVTfK8v/8sHvQ21B8jQnXDNFhdKlE0dxMre/C9WQjKkSjql856UyrLna83?=
 =?us-ascii?Q?ZlOWlogC+6OcsZ7Dp33bkNLi+zf1aKT5r/OsAt8fB6+gKLYZ1wSUR3FyEFLF?=
 =?us-ascii?Q?6cHW3F5rS7g5iVZOslvUw0A1ZnOnZU/iqj7jaaOIKtf7XQKJBxFHIC0hMC0d?=
 =?us-ascii?Q?KDD2b411dB6es9NlldibTKyoAfhGW/8ZCWSSJj8xCzAfVcpLlY5a6/EcJJwx?=
 =?us-ascii?Q?alNXwmOWdf/b6mjQXol14B0LKPjSOkZPAaOaV4gDDXSA8Nr/RLKquDZVvff9?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2144d53-822e-47e8-38e9-08da5a75a59c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:50:56.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8NvgUdrUGD0b4RRjYHBssmUy8REoF+zT/Vnrqwb9zm8W905aw7rELbbpVu+9qh7lgNtVWvyKEa8B6/3PJpizw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4381

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 96 ++++++++++++++++++++++++++------------------
 net/mptcp/protocol.h | 10 +++++
 2 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6e44786e01fd..f97e6c318c0b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1516,57 +1516,73 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	struct mptcp_data_frag *dfrag;
+	struct mptcp_subflow_context *subflow;
 	int len, copied = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
+	if (!mptcp_sched_get_send(msk))
+		goto out;
 
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			struct sock *prev_ssk = NULL, *ssk = NULL;
+			struct mptcp_sendmsg_info info = {
+				.flags = flags,
+			};
+			struct mptcp_data_frag *dfrag;
 
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
+			dfrag = mptcp_send_head(sk);
+			if (!dfrag)
 				goto out;
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
+			do {
+				info.sent = dfrag->already_sent;
+				info.limit = dfrag->data_len;
+				len = dfrag->data_len - dfrag->already_sent;
+				while (len > 0) {
+					int ret = 0;
+
+					prev_ssk = ssk;
+					ssk = mptcp_subflow_tcp_sock(subflow);
+
+					/* First check. If the ssk has changed since
+					 * the last round, release prev_ssk
+					 */
+					if (ssk != prev_ssk && prev_ssk)
+						mptcp_push_release(prev_ssk, &info);
+					if (!ssk)
+						goto out;
+
+					/* Need to lock the new subflow only if different
+					 * from the previous one, otherwise we are still
+					 * helding the relevant lock
+					 */
+					if (ssk != prev_ssk)
+						lock_sock(ssk);
+
+					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+					if (ret <= 0) {
+						mptcp_push_release(ssk, &info);
+						goto out;
+					}
+
+					info.sent += ret;
+					copied += ret;
+					len -= ret;
+
+					mptcp_update_post_push(msk, dfrag, ret);
+				}
+			} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
+			/* at this point we held the socket lock for the last subflow we used */
+			if (ssk) {
 				mptcp_push_release(ssk, &info);
-				goto out;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
 			}
-
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
-
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	WRITE_ONCE(msk->first_pending, NULL);
 
 out:
 	/* ensure the rtx timer is running */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index af414cd8b7cd..09a9797d2dfb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -355,6 +355,16 @@ static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_next_frag(struct sock *sk,
+						      struct mptcp_data_frag *cur)
+{
+	if (!cur)
+		return NULL;
+
+	return list_is_last(&cur->list, &mptcp_sk(sk)->rtx_queue) ? NULL :
+						     list_next_entry(cur, list);
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

