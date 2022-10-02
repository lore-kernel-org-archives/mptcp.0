Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10078.outbound.protection.outlook.com [40.107.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828E33D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHZinRl3Gn1krXHDmiw/v4QctplzgR9rFtdYbzehXr2qrqvYxaWLrFscm9cA+g158MXbbxAetow9FaQvwIY/6S+BTOvt0u18XgEQ+R7l4C12bw1mQNnr75WecjS6SPZLiUFam3s9TYU44X4L4KMJb9kSkX4U237Ewivl4IMkSOVyuVmie53bdvmTC/0iA/mnR0BpJfcKmJGYcyUDncecKTgDaiS+1mgpUSEE10HY6Xnz/mLSPw6NoDGpzdydUU983+8384KoPBsHgKrTtxApiz6Mvf1c9ZVpcvSuEo5piXZmBXd6cy2OIfxMY1diLjpdi9/ubKsphrqLLrtSP8FWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHftcWQShmdn5zrNG/KYVFCbqQgsJU0MVMC2MM3gT2o=;
 b=CyFOEC6yhjJ6Hmnqbsf20OIks/jSPOgaPyptQi3g72be8uRlFL4SiR5n4r6gRMK04FgNAc62atvRCYGcyBHW1jiVoSL4wg/z+CHMjyJ7WHY5I/30+cXWf4jzv5ZFCby6UskX4HLM/Y2Rm9cNYuS4V/PBGJWQWXsnVWWaO9pmAC/Zryg7hG80h1roBw8mE5E1HUlwByVUGdQRKVlql6zNnz3dgesBVn2Ur/Amd8Du/n2wbsFtVx2OpZSQrLN3TAbYelRg0ogjrdjwqJNn3/cgjE5XMf2NmZ1cUUQlRTtSIvzMhVMZ4TsUlsgz/oUJgLGcBa5PyJDkfVkNFQfv91nxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHftcWQShmdn5zrNG/KYVFCbqQgsJU0MVMC2MM3gT2o=;
 b=Tj0zwIq98rPWFvuGBaTTTbHbEtj9YqzqibdZVQisAKJkqPXahYhVFhX8qGN/yVzDNelP8oJqwfOFQvJ9skZK81eVKVIu4cqvE0J7+31UkCzg4yBDyKy1wrB7TtLWe8pyn6RHwNWaoXVcMKILYC4fG2ERdsBOzaNGMnPjDP1cj9gZV1zkzmMTMR5u1+u0hOgTyKU5ieedkCFASHAap4Om+K/8/O/LSf6C7Ufd74IR7a20JZz1aMhrF8GMVw+WcUErGVNaQYktF1OaHAMc0PbzHsbo69494IoWVeYE+7YaN+fWK+mjntihQ0lMlpliPd9oNpbD7JNcoih50d8VNl9tQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:25:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:25:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 08/11] mptcp: refactor subflow_push_pending logic
Date: Sun,  2 Oct 2022 22:25:16 +0800
Message-Id: <e51b7571d3f794ecc62c1e99ac659731fc56e093.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b024bea-e9c8-4bdf-af2b-08daa482000d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ITJU0lnQxT9ZV48cnuM+kg+y/6d83Urpe9elpaz/VuL+1KxZ+FCJIGgrqIlegF1hLFj79VG62HZBWBXXmSaVq0HdU+OsKE/Mcjlq2q9MOi0XvBlPJLQJKb0c0FLWlftQBmi3bA8Uz4PdaND22/qt+edFePJ3KuFE5f94pplSwjHiPK18ehLefMZHCQJeEA/lAFiHWjE3W7LX4hrci76CMHkQ4OkS4Kf1uVVe6Ov9+nWMRR0zCDS9JqYUu6xMhi/TMgbgaMVlWJL3/ZqNB3iFej8FNlhA0abHl4u40hw3vS4XZr5hrr1Kw7TnfglPe62UOcXLueGv9aqr0wsi0+5vdhZL7t0Ecs7RQXldHPiMI9Mg8Flja/eCPRVu+tMiGYUqURnG3q3kaWY1R1lhuIpkK99qI/48pGjByOBUKduH/TmUOQ2CmjWYvh5yyweB8Mv9zTf4gk5vIkWfR2Zp6F5jdlz4busyZ5IUvvA3QgJdPdsF5l+8YLjf9mJurpuWschLHcFJpJyQmPfHxkXLBtOGhZs7d8EkCDPqRe4SfnRSOkL4dJ/hSIwuQPQSVuzTBT1F4RlvJSASFUQwjls7C0xD7ahfztnnnl8XZhtRjnYMWEspEmqQZ5ui756ZYwrGZN8R6XIyGXdmjhVaQj5f8hEw6dXZBEafDYMUvcx1OtX00lC6i4lrfpqW04tSe+43GDDq5RtrbOnMQ+aEs/omw/sjYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6bvqJnjBduBmPWVFcDo5grDB7Ldmxg7MBMvauSwTJ8eEzchcyq4sbEb3zFcs?=
 =?us-ascii?Q?4JcKZgNSkS5I4IEiQ175JEpWivdZCUKpkDWsGbGMNYyGiMNev9m9CgOwTetF?=
 =?us-ascii?Q?eGongarXEzqGxe0K8A538ztW3WqGK8xP7/mNXRqEB9OvM4T65G6aMTs9+L5/?=
 =?us-ascii?Q?LvzRD/nhjestc35CgecDAdLI3A5FtEDuCSo6HEZPdl5B7q2q8Yv1ZOfQ+zTv?=
 =?us-ascii?Q?82zAnUCVXjInwzjwLWa7tNm/VOwSMFfN7rrMhmZ+yrZzl2Msu0AASxYrLppX?=
 =?us-ascii?Q?zz3CLussKGhFHHdGehQYm1GlLqpp4Vs/eD/wmH42+luEMdwmcjjY6a8RDVjB?=
 =?us-ascii?Q?mg90Ts/QP6LoK0aakkjGbuVNVtZLEx8akIoTIG6iW2YrnuewNzROjpcmkF0s?=
 =?us-ascii?Q?uiOieKcCCt7Gm74eLYOHsfdhcnr3C589obflwbuWEBsUSv+08gc9JwsNEh0p?=
 =?us-ascii?Q?y0ObeT6c4CadNmU645bzYEb0u5IzvHvY48gNZ+N1Uw9unmXFXPMpNodkvU1z?=
 =?us-ascii?Q?fFD37HvmWdxTkpxQuqddxTokeKwtEgwuHFFdkL2JAnLNnV0Y21KY2ov2NJA4?=
 =?us-ascii?Q?c+vFTwgWRSU+9johmROq/j0ZcJmNVn+I2q10xRcpGsYOOG+KcYOa88aDMi4u?=
 =?us-ascii?Q?Sz0lOK29S+g9grFiEbS0fjriQZZFZM0mPA3TNAMVGHHFlPihLjOTo6XNwBF6?=
 =?us-ascii?Q?bJ0DdU5ODEzKyB50gDyGGWthr8UrxliCbNNfkhJgNu6l0Kb+4QuOUgdgBej3?=
 =?us-ascii?Q?jvdYyLclgJYyndZQQWJ6qj9SWtG/qJe3kKdilGTrt98oi4We75LF4SHkb1Fo?=
 =?us-ascii?Q?CDWSgjsJAh/n+cRxX6IJi7GVSM+tQY74d4uK9qDxsKWAlwg8H343xA7l2USL?=
 =?us-ascii?Q?Rs3nVP81pHwx+ctenUHDij6CyBB/R4ymfo6aJwgPSaXjwBR8K5qBmcquHU70?=
 =?us-ascii?Q?HVcjBTL5vTCpKcu2deXvF6W6JFGVtyAnWjGYn1M8sTrdcMe5PQB+T+vlk9X8?=
 =?us-ascii?Q?ZSlnkL8rGjDOPr+0tU/FMfXadB36yPBjEk5L5qC1Clj6QNwcaLqXpiSOXVoh?=
 =?us-ascii?Q?cuGLZeK0jmKrag/B0jKnSk7H79AFHLAXcWskjAERFddnwhgeDnOUdswoLKBJ?=
 =?us-ascii?Q?YUZpW80Jwcw8HsDPqJmgvLaEng7CSUe1u91TB7Sztrwr/92QJB5xUoqAnQU+?=
 =?us-ascii?Q?J4I3ICBEWFhAUpMqaPHtKiwlebveU/zkMSqwTG7HzqXfxzskl9biDzuilsc1?=
 =?us-ascii?Q?iyJeSgqFw7bVjGd7QZTMvhQqfysWSrbElU5TWaBGyXyHYTEhRPPHSXVDXTnF?=
 =?us-ascii?Q?nnLwB97dJO7u5YkqaZJc+MWS8Nvxk+enxkskUPj3qxLpihT55Ltl9NkB2dnc?=
 =?us-ascii?Q?u2JljW2gNRzsJhSJKDNduTQFbMlV9GZmYiAlXu3m3/NTSZ2ccddJXT04MkT3?=
 =?us-ascii?Q?HcmWJtcYvCsoQ8wPuna0osF5ueMcqYgGEO6Idq0yRfgwKN4xborm8zXP8HEw?=
 =?us-ascii?Q?FXRANwtWA9liQNaSFW96qffEG78ZUW7nAMqj7U/OjHEEs48KXogo2cu9v6bY?=
 =?us-ascii?Q?reUjs2bcHePDa1a1nMp6Vx++y3802/1JrlrWWNrx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b024bea-e9c8-4bdf-af2b-08daa482000d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:25:48.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfeVGJ4XXrthbVTZoWTJjrvZbrfbdEFI4Z3aYs2Oc6S7T4FEestxea1FNaaNrcBLsmyetIr7QzUsxQJJ6+Mu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

This patch refactors __mptcp_subflow_push_pending logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Send the dfrag data with mptcp_subflow_delegate(), break
		Send the dfrag data with mptcp_sendmsg_frag()
		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
	Update msk->first_pending

to:

While first_pending isn't empty:
	Call the scheduler (selects subflow and msk->snd_burst)
	Send the dfrag data with mptcp_subflow_delegate(), break
	Send the dfrag data with mptcp_sendmsg_frag()
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 66 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8674b431593..c036a788fc27 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1602,44 +1602,46 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	int len, copied = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
+	while (mptcp_send_head(sk)) {
+		/* check for a different subflow usage only after
+		 * spooling the first chunk of data
+		 */
+		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
+		if (!xmit_ssk)
+			goto out;
+		if (xmit_ssk != ssk) {
+			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+					       MPTCP_DELEGATE_SEND);
+			goto out;
+		}
 
-			/* check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					goto out;
 
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-			first = false;
+				info.sent += ret;
+				copied += ret;
+				len -= ret;
+				first = false;
 
-			mptcp_update_post_push(msk, dfrag, ret);
-		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
-		    !sk_stream_memory_free(ssk) ||
-		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-			goto out;
+			if (msk->snd_burst <= 0 ||
+			    !sk_stream_memory_free(ssk) ||
+			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+				goto out;
+			}
+			mptcp_set_timeout(sk);
 		}
-		mptcp_set_timeout(sk);
 	}
 
 out:
-- 
2.35.3

