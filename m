Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066BD622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPdtDp3MOZDbQfeO7UTr++6PyXAihvoXGBGEmtute5g=;
	b=KkYiSr9TrCPXMczyhn+R1z4eyn7Zv+Mov2CfLRsMvgi6S4CUADY3UTKJHq15hCLPZLcknK
	esVAaPnPbbCvRbcGslwnDX2ZSiqnWJIgBx1G6vdEORq62WCv61BirHmBgGt6IBGCNvD+bJ
	53weaWZWp6zIgGXWakty43PWDvZhQu0=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-2ZhQlnqVOw-uMALUebW4WQ-1; Thu, 02 Jun 2022 06:55:03 +0200
X-MC-Unique: 2ZhQlnqVOw-uMALUebW4WQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2OoLFmFFKWXAPlGKPEYPMLdWhw1txfMV/AYb2U9YsHfyO/hbAG1ae1XpxftA6mXYZAWUhVosDcC0CcSYFzIpCaUIHD6hFPmhwR2n0o/OeAEJkzj8lqUXBhLi4D0NqRTVtVsTB+W6J36RlXKEda4WJqnMy/eh1yKBp0CwWs8kulYIurmy3gehcEk9onmgTRL6PsgvxePDJwmp89u9D6F74OHdl2y9jRvCP23E+uF26iu0qYv/me80+mYmCRa0BkBQ8a7zU1dEJx1XfrWeq2G3yhfQUEu9PrNFzu7wcE/qyxijZ8mQUdBPzxYP6omyNbCed7yo+vlODBqQbnApIAseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biNxtX9zum/dHL+I5YopRoAtbf9vhMjWLa+Vf5occmY=;
 b=aSKjh5SEcgQA2V9w2FeB1/VOPrBz4AbHOocewj7X+ahLI5JmTUudQii26pS/2ms9Q2DXKMvL7VTyGspmWTy7y7ChPLhhlzhGvm6wZX68Dee6XF8pkNeoIs6KQ9VRZx90WNvyxlKIJGAygSW2MxS2k0AUxKSGb/uE5VUudqDbFmaU8aI1KhHmBl2i8oTO3cWeQD8X9gDSnuwb0I4CM1x18SsCiCTpROdQPqjWsryij9K9093LEJPQYnRa5bVdAPi3nlWInR54P6rTYeWBhHabJBjcokWcxHUxWWB15OUqOkC8qciQcg/cWhRaACu75qTTcYiBJNRvo/XlMjXSxh2Ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:55:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:55:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 09/13] Squash to "selftests/bpf: add bpf_first test"
Date: Thu,  2 Jun 2022 12:53:46 +0800
Message-ID: <24b6d78128cad40770594d204dd33c5f59ad87a7.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:202::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90a2dffb-dcd4-459b-4ced-08da44540d6c
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB338471BC96A64BE5ADD88A12F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Jqr3qYoJgbhEYuUluxBvi9C2u51jQzpGnczyjmphOYtRWbPjjWcrwTzjMQf3qh9Dr4doEzMU4FAhu2U1qIft6VexZ4tGbymMSQu4vEcLSA3W4kW8thxC8MU7/73OCAKkVoiZzG2dUb/xfRXYdiNxaqTu6zw6FPWdQO9pcyx9YAZ6kLYwxkB9EQMmxGLalfWjt7qMmbmLpknUldWrAd7XThfeGb+UxIRHbR6mymrBscL3IMoFs7imVno7AEO+dBtoymGHSkSuoS/ZtdzXXpMhGEzmMLPlPD0NHeGXokgNpMPeGX2BqvuQE1n/Sr6poGbWCmy8QnjX/1l4UVh9iysnrdHXBzb3j6UL+PmNsU1Mi5WIkB3oocCDuSYlIMoglldnB5Uqoa24XETUTLK2T39GLoM7n73NOYnjXUhaU+lNk9Uoh16i9rrdBU6tE/yE+oiFP3OO4akPDvKsEalBD3T2WnrfXAb0RrAWmfCMJUl8tAIPbri0E0lf/Y/pHTfg8i3HXpRCXrdmD7lp3ZmRb3WeN0xhUlv/6KtrzObeACrq09pXjGReALb9SoSfLzGqeYoA9G0u9Oi5vB/MMy2xcx6mEdTtYZK17Tblk6kvGGXAlH+IUjqKuYJv7E+XkpKsFrpbQJmN6FEpDCMwduFh4Gz69ZqANFwHhUUntCb/sQ2m2sKy2RTZ5ECwlbfj0hxx/e6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l29DKVefzAIHfBx8uK52JABg9b7zSXuTuOrG/cgfxvxRNw3gb5iWHHYeRfDC?=
 =?us-ascii?Q?P+hBfYnQHSnnjTrlP+ueZOAowswJP87zOyu/NiNEXxYu/zW56hBWb7ALmL29?=
 =?us-ascii?Q?f0joy31qD3b5KKLv+NnvRmHJAMveH37dvtRi9+IHO8unCvvmhUoO5LwsIVL2?=
 =?us-ascii?Q?ZTRmtzAlx1TP/RyPx4PqFR6FvkCA2xH3JYiFjNSiaFAO4qMFiru3prAhlV6O?=
 =?us-ascii?Q?yaNUngqnlT3t3z6Qhzs0g+k+gig3+0lAsfeHaWyB/NA/THv6RiEgxxhYocEE?=
 =?us-ascii?Q?8lkzBWdFF1nuuqepnUma8PCaidhLpPUGS+RHmMxpQk1V1NCGjYE5LzonYGJo?=
 =?us-ascii?Q?3ihlF0qwq8CSDQ0Q0ws9nQKlPhzevSvt98mMYKgPze1hXjn75Btd9g32aRAg?=
 =?us-ascii?Q?dAqomw7JTZgDt6fy70E7wsRdaVlsGJLdgP+1waHvw99RmZVj6/kuK5sorDUN?=
 =?us-ascii?Q?PQ7X2D5R26T+hMC36pKmBdvdMy6r15XosTKLrLPzIo2RylLEu1UijQIngNEX?=
 =?us-ascii?Q?bJ6BJdg4uoXybrs5LTm1fuxo9rMpITf+R3vRyE91htkDnGNnTM6ieMaMDb8H?=
 =?us-ascii?Q?Gopxszc2Ut4ZU6jAwbdku0W/j3FBBwBFhhEJ75HLl6nZSeTToTXag730H7bV?=
 =?us-ascii?Q?hkAaNfpKpjFr4aYxsxrYsmQHWxBxHzQuw/poVP7hACtjISBETRhTrrb07gPS?=
 =?us-ascii?Q?YlN2HNnP6RJ7dP7yMQR35VaMJf9wZ5P3Wf7ff6kq3xSkx1bl5M6mmrmn4O44?=
 =?us-ascii?Q?tStWLz53eajOTl6hh5uZ2CKP7iuop7WN05BOLbBzPYkpQyNntq267xHDijM7?=
 =?us-ascii?Q?O6v5GPnqrHp7FHC5+nF7V6Iyy7XlRtFoit8DuJ73ZcYtxIZ3LWGB+6rf42co?=
 =?us-ascii?Q?E0GJhw81sm9uWTiV5KRraCTk1CpBt2CBqTtUDmGM67V+sIB6ksefCCff15bB?=
 =?us-ascii?Q?9XGpKMO7Lfaskn9ltp0uykMJItbwWLyM6fKuRZ2irOCPx2ZCuhVG5D6aGMqK?=
 =?us-ascii?Q?HMUeTdRP25t2BADmAgZHSBKcKyEfu5jUkUgzgHBgALidJ8J0u82TwsBVqrrk?=
 =?us-ascii?Q?dnHdsBt65+jtSlB/QowOQDw3bwtWDuRQAGk0yZfosKYUObLr1QVrZLi+84PL?=
 =?us-ascii?Q?cJfceQcw6y1iNXObOcumAfld7N/rB/uxurNm56Bz1CF7TvTOopgeeOTWAlcv?=
 =?us-ascii?Q?VhtOYpVV4XmrsksWJH63Qk+Dl7qwnIp/0sAYaQvUnGYx4/saXYijSdtsrr/r?=
 =?us-ascii?Q?F5bTRdBwRXH9IIdtLbjkPP5oGStBwBamG51GM+ItRY2GyQ+wYdxHzXWfdFPR?=
 =?us-ascii?Q?hyhorQ58QwZAl8cM4d583q/gOndNXVCA0vDSdiIdRVRmKFANPhAuGIwAKp0F?=
 =?us-ascii?Q?rEuzsyiDfqCoP9FKB6Lo4fTXRpYgSoRBRVehLq8iwARk68gk1fjxDXxNu8VV?=
 =?us-ascii?Q?PBz3PjLdRNnxGMIo/n92PnUisgrwp55M/sGaxAuHmB6dhymwnvq4MLo4ndkM?=
 =?us-ascii?Q?wR2JfuRMX7+lUCW2KWjLudLc/uZjCvd0rRCaETPbuWIrUgKsi0vtETRae6mH?=
 =?us-ascii?Q?REez6ZKW8572UH2l1FE+0WArNvyBmGGQ4uNS5wThl9XJ0/31wo2uUjM2XPkb?=
 =?us-ascii?Q?svlMXoz+oGuip7574igafb2wfPfk+pairR1xcT/YqqPXvtn3vmaIaRS0HaF+?=
 =?us-ascii?Q?jakM8JbxRfNfDG6SgKG+Pa8DqcW5gBQuZcF76IwMS9N0KlxfJxzLymR/zgoP?=
 =?us-ascii?Q?PGw/Zo8oy8T/h4UBbT4phoWF3wI8Myw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a2dffb-dcd4-459b-4ced-08da44540d6c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:55:02.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCby95X7nBjYPQMSxUJLIlcvrTsi8s72V70VUUa2LnUsIixHhn2mh7fw5/r4EYrd03f8DzNGNUbfkCrVRY6JvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

Add two helpers, add_veth() and cleanup().

Please update the subject and commit log:

'''
selftests/bpf: Add bpf_first test

This patch expends the MPTCP test base to support MPTCP packet scheduler
tests. Add the bpf_first scheduler test in it.

Use sysctl to set net.mptcp.scheduler to use this sched. The new helper
add_veth() adds a veth net device to simulate the multiple addresses case.
Use 'ip mptcp endpoint' command to add this new endpoint to PM netlink.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Check bytes_sent of 'ss' output after send_data() to make sure no data
has been sent on the new veth net device. All data has been sent on the
first subflow.

Invoke the new helper cleanup() to set back net.mptcp.scheduler to default,
flush all mptcp endpoints, and delete the veth net device.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 8e9764275b07..eaea4105728d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -250,6 +250,20 @@ static void send_data(int lfd, int fd)
 	      PTR_ERR(thread_ret));
 }
=20
+static void add_veth(void)
+{
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+}
+
+static void cleanup(void)
+{
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
@@ -266,15 +280,18 @@ static void test_first(void)
 		return;
 	}
=20
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
 	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
+	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
=20
 	close(client_fd);
 	close(server_fd);
-	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	cleanup();
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
--=20
2.34.1

