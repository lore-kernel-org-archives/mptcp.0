Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82072
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jSmn/8USUNDcGvI6TkCPIHzurOiE+CBqDEUsPJtRAE=;
	b=Pv6/5NGK6tAYo7pkcQ21mpK45VtEzKSuSGxvnSLWBiRJgWvWmngHRVe2LFNSNte7Ikew0z
	aBb9U1CGeISfGLXkv0JaghzANW9RwiZtt2ptrE+YJ/zN0yJScPZeQDjSCGkN4Nqdrwyu/K
	5YjVDAChFjf7mRwJveiXgyZDiKc6Tw0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-LzAImH7JO3KcGaIT-5qr8Q-1; Fri, 29 Oct 2021 06:40:36 +0200
X-MC-Unique: LzAImH7JO3KcGaIT-5qr8Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5iY5CSgv3HgpCxas8iz2ckERJMTi21CMXr/XDsq8dmhmqcuWofbg7lGCgP1BPn8arbqOztrOxgODbwOu4Stknoxh4hRVqjoDqcGgLYYKC7NdZTGoB/GyVZmtuGEf5YEaPoHo4YH/bf3oDk9+Q1VzJ8s7dw4gMN8hCyt1BQoUQrQARBk8P4bvxvs/SoixusDbhEZmIq5mV1ajgaoMQqKVp3hpk/eyafoFPLGlcZnO96XVCvPpP/8k7EBiQA2SCn7hzMg7igF+1L8jmFa0gq4MlPbO449SQ2AhJqFkLbJXq0n6hKc16Zi6F/qirR6dv2T497odIqLe/13jOKwmhr3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHR6A64Tty9bQ6G2nrdp94YPG8l4+UyiCdBJYAoWnf4=;
 b=E+Ie88JRL94IYS7QTvOhVAsq/BRZEOMbmucmeFHUiz/ycvJw7P8dMaX6//2x59PA5xgdPKRpl4VQVp7O8u9AMD3C5xC3Izc+Jfn8wdLRFr4aIFjUfk6Bhg4YE1bqyJZdveJQQchCQMc6kElQSCy798Zmc0Fu/4G0UjwCoq1cY7JBV1p6VLn7BAJfAfxA3WnQyndVjt0sp2mmTKAnd3OTz9ZYvbyejfGbSqNBFBLjfaXx+grvKtOXYbad/9MUaUSe35mmsLBdYoKLdO2KD2ewc4T67fv/8CjOozpxSWVPye1/G3JEm3gUWTfoVorRXb+/f6CF1BT2b2DY7FfsivUInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:40:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:40:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 1/8] mptcp: don't send RST for single subflow
Date: Fri, 29 Oct 2021 12:40:11 +0800
Message-ID: <7a6e038ebf37131784841361cb1f5e089dcae32c.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0183.apcprd02.prod.outlook.com (2603:1096:201:21::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 04:40:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc90cda1-9ed4-4de2-edd3-08d99a963fed
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2652129DF0EC89B0CDA504F8F8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UpQku3n1icoAVxmnIWdtR9QGqetRK/3IREcBQItnPWJW9+goZsz4C8ce9PmappxXNFJ1HNU1RYSHwICKlUA0n53v8oF2nICuY7Ioip57KqloeOntjRQJ3oEo+dipUxLWtHWJwgm45jzNh+1xLYMC1Mq+H1hB0eWTvSUK2cJDeaV90B8F43eECzORyXsp0RHyMDbN/z7kCsAV7h35V37XNuP9UXy55EP7sniugE5e5YIgrQIXJl68FWGu77VhhdFzQLGLpHwv8NBQYqNRnxQBYJ7Lcf5W0dOXG5SBLfiP5yCerqWF3JiJmGHHOq3+4BkI1tld2EaLy/d6Bw3/REVn00vXgCuf85WJf8q9l/xPFZ7njp90j6b449XXKn1p9rfjirygphlAB24/rGjFQdSUvhlrBWd7IG6qK1ooeGSKHYl4gW9T5SO2XSLbCNknA3UUSwXsJaUSaacfNO9vX6uEza8qsXYcFUY0G42mT+3QzjRG3k+z1J0LDub2583reEPZSVQPJJ3ATnPeQ4vv8KxOnyKn7wAQDxIqBfKuKVuMZpa8i+jpIoRymCHcnkSfXv6efOM6Y5CwRV+lqbT7zM3p1HLvaYJ6NVnglfeEUKzog7k1XlvByiebYqfZVVayMITdMwrhDEPUGdtqsjtVOqFV+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(4326008)(66946007)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(107886003)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2r6tIrlVa4bB2zZPEKPAk5uXgUpXcRL0SQ7GxpcIDj/IDh4qRPTB/HJNdhr4?=
 =?us-ascii?Q?8tg2S1Uqzq6LQ0pnyDEGR+LSoMh5fclqqfwxGwTVNCVmmaK0iBNOgdO1z/hK?=
 =?us-ascii?Q?wENKkhLBSFWGhSgb/BHtWH5x0jB52F+rWE7KBiyfgAJN7EGnCMW94jj38GSu?=
 =?us-ascii?Q?mGxOozTfLwMpEaCRrboxCpRraqKIuMEoEIlMdukgiI9WuA+7IMfl8AY6vxKo?=
 =?us-ascii?Q?QZadPfQYXBy5R5KFsZR/KGSVt1+U6pWsKe+wD+AvHjkBCNKyOZB+eq+3XmIj?=
 =?us-ascii?Q?446eW+HVg/6MgpIZubQfKsmsgKm2rMpd1cXp9SWCG6+7jt6ZwrXITCBKvtui?=
 =?us-ascii?Q?ysvg77uNqHSeQEihUCtk0XjifvIY/3P7zoTJTGSS8yzpvcZ7Y5kp73y8WK63?=
 =?us-ascii?Q?joSEDTsw+LV0YHAYVr4D8/B5QTWzrqeE2/rqGAPLlAGZAy6KI/JewF5NtSVj?=
 =?us-ascii?Q?2R8+DogiKAYGGfrQ/+YtAlzxm9EcJZ2ortcczS67dtFK6RQcdkwr3f/NqmrM?=
 =?us-ascii?Q?fBS88na4GXBGSU0CAimCWN8rT44E0rrMjnThEgyItwwA6EbUx1tdsztDQ+zh?=
 =?us-ascii?Q?JBJVVNXQ0CDWglqihiCwfPjiaGoaLq6o/AJlPYFP8tbEyHtbFUX/cwzEkqGv?=
 =?us-ascii?Q?KPri/mHsyNx0pxJYZ8ohMtUk/SIq9sfrvPZYP4Y87WFoh4CtO2eixNfKfvB1?=
 =?us-ascii?Q?8M3ErETiAQ3cnEfiudWcmbyX8kuOpIWFO/i85hTMiIKGt6CYLnugJZUsrVwx?=
 =?us-ascii?Q?0SwnK94nYQphREnDMd5SNRAq2bj7oYR8YQNW03FJHJKlg6SXDA//H4EjMY5W?=
 =?us-ascii?Q?6EWF1lNOeh2lu4RofgjkyRqWrZr02WHRsr8+O+DSmpudCzsIjKx0ibs48kri?=
 =?us-ascii?Q?7hSJti+RBeAt8IKg6NpIFn8NlE5vp2nZfOt8rqBWOeiAXGvhc2Hh08WQyUGX?=
 =?us-ascii?Q?f7oHY8Q9O16HGU1dHt1ZWq4NeAWVKYs7B44j1Tq0HiWF1JGa46P2R178O6x+?=
 =?us-ascii?Q?Zffm4Q5CL2Pixtmqf01wrmt2WsIIBaxsioyzGny9pYO434hQ3iIbslAlUhAi?=
 =?us-ascii?Q?AjI/Ckq9iQ8wYjEv8nnqy3BE1XC4wfVu/Hlvule1ki8wm8h45SvnsSN8yurU?=
 =?us-ascii?Q?GNcJ3R2CKyVGdXMif5AesW2DzWxYx2sH1Jpogs4n9OnZhvuUnXQiNhEA6xId?=
 =?us-ascii?Q?30l6zii91AAHPHSyx7r+1luCWUrPBpYWIN1piqOS1z+R8LaOZagam1Zki5mf?=
 =?us-ascii?Q?Ii0/yWTvavBfC7pFic5M/7xGCS2WNWlYuEkKcCHP3eRGDmW779R7CmaQCXbR?=
 =?us-ascii?Q?eynvaUU/W1dta3pkfXUSpFjiItoEjWqjcVVuisgCz4kX0ieotxJaeI+zGIQF?=
 =?us-ascii?Q?uQRkWoD1vOxHD4CzogP18B87i0KZcwdW+/5CR8xmMNHC84awXcUYDO+OqWmv?=
 =?us-ascii?Q?3Ug03avAz3RquTzf8EdznFUUiCU6Eryph7wtlfJh2XmKggeVcWg6rMJsGtNv?=
 =?us-ascii?Q?m2L1g7B3FHjXRjVtKBJdoHrswSH5anLn1YCgSZ4t1pmH0VyrPDglDHHRHJRd?=
 =?us-ascii?Q?Qmpp/cbDdhfu8wkC1uqa9EuojTdgnUlqrPXoZKBHoHz2Hg4czSPWDngx2Oyw?=
 =?us-ascii?Q?FL1ieGu7bwa5sHOUfgmJzKs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc90cda1-9ed4-4de2-edd3-08d99a963fed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:40:35.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPgvesIi2l5CkiWE2H/RT+wDk5i7b/UE/rvVFM68bAUP3VuA63wnjtbgjnFl0JddSutqiZ2pIlJWNEubt6hX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

When a bad checksum is detected and a single subflow is in use, don't
send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6172f380dfb7..92b45a7c997e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1167,14 +1167,14 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
 		if (mptcp_has_another_subflow(ssk)) {
+			ssk->sk_err =3D EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient =3D 0;
+			subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb =3D skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
-		ssk->sk_err =3D EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient =3D 0;
-		subflow->reset_reason =3D MPTCP_RST_EMIDDLEBOX;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
 		WRITE_ONCE(subflow->data_avail, 0);
 		return true;
 	}
--=20
2.26.2

