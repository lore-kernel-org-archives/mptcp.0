Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAAA23C8
	for <mptcp@lists.linux.dev>; Mon,  4 Apr 2022 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649038291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEMxBeQyx4/m3+PYPLQS8qlpBtJK3twYXIaBhl9uTVM=;
	b=KbCKeLObssr+E3SnPdaniKyk5W/TaARggaHdCXTYVkCr269WwdDdI5gOcwvEGON1iw5fRR
	GqGY0GhvfEvwnetaWGalyJOY1EEEApyO0tzY7tIIGVTlQ+YfxSACOL03k3IXN5drjedETW
	nye5BQ/pon3Bojy1yJ4t4EqFSUw0Wow=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-jKCCur7zOCy5chsu7CJ5ng-1; Mon, 04 Apr 2022 04:11:30 +0200
X-MC-Unique: jKCCur7zOCy5chsu7CJ5ng-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAGXP8i9cz3xZ8nTdVLnpP9BxbYgBlPV7QLfZYyLDBslZq1mVZwIMx2F44VKoGMARxmlPq/laQs1m10MKz/97EMiUDl0jduzJLQQMRuIDzC6CL+T8EmUdNVRMiQ46moomAKK5Gkz6PHKXlzvNqimngZNz73vy/rtpYwzcgS6za+tydSqoEcz756R4KloNshU9WiO0IvZxLFFsjLpKBsrucuoAcMDaL6CKANBz0q13Vnp4PQo/Mp0eF56+DFTSgXMdlmGrpTJrIAOUt3hjgY2oh1HV2QUSgjdyRguvnG6KF7xEZEHWECvchuO9CMIQXJOzYCe07OsIBetIfD+5OAzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KFb3y777kAYKAo0/CqZ6N1Pxaw8SXGN06NZKXq0HaU=;
 b=BmiWYRzKME+xGT7Wj0y8xwuUJrOVhWq90atpg4ot9R59TVzCJ1N0zXESu9lxidSpelyX0a3ftpwePtNh1D2PjUJDoAnz6MfWCY2/njMnHRX+L6HrYRNHgCUOZ5Lp9ic10mREmdTDFO3pFmPq98O/5mROUC1G2rgFirAPc63k61w41GMndasTwGFfydNgkuMyJUbxNvxcaxEZCCSjaspiPwLk4405gRsNTJx5V0ELPkvr/yPiXcfJZMW/P/wEsH0vEGOw8bCG807uo8FZxo4Ijwm1xOi3YV9w71Fh5WHXIKjSUUzl/p56zIMJuwxiyJYAvh2IjS38mqHf7v5Ct4NWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 02:11:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 02:11:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 8/8] selftests: bpf: add bpf_first test
Date: Mon,  4 Apr 2022 10:10:00 +0800
Message-ID: <0d834717492cdba59f67be88f9647c7535aff90f.1649037838.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649037838.git.geliang.tang@suse.com>
References: <cover.1649037838.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0175.jpnprd01.prod.outlook.com (2603:1096:402::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30f1632-05a0-46a4-f64c-08da15e06e00
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB7189DFBD14BCDE7E1C673E86F8E59@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vf1UqWLSXmyP609Mn0h3hyR2ydZO+7+iScZh7vFaKzoxxwSsAlv+evqCNBHIxbkGI1qDWu/gEQLosKJNH1jnSqlhOJIuf+GVPmlh9swQs1oxiGe7kWelZ0TVwyHSkxJ9FAvpMCJic28ELa00gXf8paJC3raAvVt054rMj+qwD7SD/lSfEtrI18M7y9T12uy0k0FRxlvZHJ8/nW5J6bjqRHAuRhrDrX3QWhdJdDp0MvlRPj3E3QYw6s94vT7IInYNwFBmvhje/Emdzneno2GVVDKNsnxCed5XEpsXo871EXRnsSdzVwrzARA0kSudm6sSYYcgt8FgOwFHHSqR9Gj+GGZ1KK4VBAJAyntpT9xEfudmtbvTnJcgWEDrL/0sjJTRhjRoGMfFpvSAl1Hcg+t7NMwPPBOEDXewClKavVfQhjgw0s1q0AZ0nw6ay5vQj1pApA6BueyngiqlvIQlz1w/W36tj1m9fISmfODBFyglzHO6vXHYUvXTIvFNy1Pc6TLFEFqxofinlcsxCHc9AdUFs4c8ddLjh6iLfWbszbHW9vLBVCzes+U/EABBfdLgCIP0S/bx7rD76w+AR4e0qO3ZbHnf8i5VuEaH/mNI0Dx2xs++bTvyfJmXaUc6pCTwQ7N3MQMAe0vXVePEoDTwggCALv10Qbw1XgDnP//5kpG4TiyB15KnED6Lqjh+4NFi5iEf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(6486002)(5660300002)(83380400001)(8936002)(36756003)(26005)(2616005)(6666004)(2906002)(508600001)(38100700002)(66476007)(316002)(86362001)(6916009)(66556008)(8676002)(4326008)(6512007)(6506007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e4PTZhCK8+UDczsr0dfmrcEwavbuh64gns1ElSSGvQjaBlCbWWYWWUB/21/C?=
 =?us-ascii?Q?eXCndMCfDTAXVRBTV72UjPIZ1oJFMSUFT5bdDDQI1X9WeTlt/KoNnFG7RBkE?=
 =?us-ascii?Q?ufF/IAcCH62GR5I7Wwy0riiRirUehpy/8ReQvoVmw9p6vLCTX1o3RIR0uvVs?=
 =?us-ascii?Q?XuXLJX0T9Vb8JoSG0ErfvyyeqZoclm6ik9aLeYCeWgUfxH3O2zlaYgadU41P?=
 =?us-ascii?Q?KdTFwAluewPhjWulQ2APUA+UyAQ6OcgidT17j5fWzt5yW4YZPsnz5lQm1rKr?=
 =?us-ascii?Q?Ss4CCMRdjbiz1nLEUpLK4wA9jndVoncmrSUnwZVsW4wvPEyIrvyPMSe3aVVj?=
 =?us-ascii?Q?XwtbgI+IxaP3HYRlFtmuDJpJxWlXu7BjfPR0obOjmFslLOdFOO+g8AopPwm7?=
 =?us-ascii?Q?2VtXkbEKYNVruhfepyx3PHHA1s9VTCs/YtZMg0pBMsKJanrfISt8tLYe5U1o?=
 =?us-ascii?Q?aN24R1I0lY9R9ECcTlwLnXXUJcsyAabTlflvafCt14gmcsC9z7Cs+Pv9SZj3?=
 =?us-ascii?Q?TJNA+9kbsCeAg34W3TSdg77d8vtquQI6SxK25RjGC1EkQYgLLiPdCg6/E1YU?=
 =?us-ascii?Q?ZS8xXfSVqfxHHA+dhs9YbGOaIYUupGYRpNWt6vwMTnbc8lFONG5+7z/c48PS?=
 =?us-ascii?Q?Z7FVN5BNSsSyMajd/BkCExOlzODid3rFV0RHbRgrRWC7HWyaWl+4fjzT8/Xv?=
 =?us-ascii?Q?RI6xKsSFwZtyVp4hdheRx5SRQ2zvQrLdMLNG4fUiab35uXY8V34MFWs+wy5O?=
 =?us-ascii?Q?kpujIlmFQfbqKGNXJ4eov4JRlyGXXgAWFWlIkUXCy2IupcDdfR3jF2O0yzOu?=
 =?us-ascii?Q?rmeR4SEC/8mvuOtgDw+tjgKMtFI/NqXe0ybPimOr6SThcHbl5fIJ7cWoTVBe?=
 =?us-ascii?Q?dCeK9UBShqTqhvt6Hivg4sgO0EiwSahSR/IgJFVU6dew110M7LNcxJPCAyM2?=
 =?us-ascii?Q?fBoMR448IJYZ4XVOPRZmbY3v2Tmo/n3GEoxdpyav/C24nnI3vLuQy20GAXlf?=
 =?us-ascii?Q?3IgAkSWNTyDIHWHbKL3gesC56PwpwkueswcCf6eUEH0MRx9FS8yiXZg89XkG?=
 =?us-ascii?Q?r2JhUp8tYi7MEdZMsBoiz6b1onqYygCZmQDbjUG160P5YoflUiCJemngN6Qz?=
 =?us-ascii?Q?j8IzQRY4a3l8LlyPbf8Z4agNzdwmrWFLsWM31FSfT3mx4AxudLT0mRQMRPwM?=
 =?us-ascii?Q?tAj2toLUEAUQco8y8tpxUsFUcIS1tvNdNm2NaLBGoTnI5GEpAkbPVfbLwmRa?=
 =?us-ascii?Q?BmHRns59Gua7i9B4t06o8md4vKyUWMqZaTHCFUCTEHKMVmEeZtyU/vmZr7Nv?=
 =?us-ascii?Q?bBKUvXEyWDjpKL+ss+Sc6wrOYSiBdpKBSeF8+MNR9KugSEeZQPRSTCCrh4Vh?=
 =?us-ascii?Q?VdRBm3HoJ9RBsApMidYlbrhj/n8RF8AzuiUWGzKUn6h9mDYDoOBK4K0LXAoa?=
 =?us-ascii?Q?IfiDLwr/cV0n84F26nxyVRL6oQHquNvZm+MUFV9Yqwnfo0QedlT15xbFsQyE?=
 =?us-ascii?Q?3Oa9Fh1+blBY+3j0s9bQ9a2x3Ixux4zHJLePeGoNCL8CTJwhKshfiHtQ1y9P?=
 =?us-ascii?Q?jwQzKXtHSuJVWAWBev4VLDhdkcjKVqgI/6h1Ncs7mphLWvi+I2VILnlk9MvU?=
 =?us-ascii?Q?SFrvhgJur1R2eiUbl/JnYGJ2bj6XzKeQKgBJlm/hJbxVs4xfywI4D+cvuC0C?=
 =?us-ascii?Q?+pArg8+vPqbleWqB9GtpO/z2lOyvsvHyqXZqSGgrvkEn7Zy5zAdkzgHGaBsv?=
 =?us-ascii?Q?bOHRCgwZqvbqVq6nynoN0qxK5aAIHI8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30f1632-05a0-46a4-f64c-08da15e06e00
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 02:11:29.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9TMpHSa190de/Od0ADf2MX0SWb703mujKhJS0oGr0tzjXjD9iAFAECfSvpfXugigNkd0YGw9TL4PgeD6FbkCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 7e704f5aab05..467769e229f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,9 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
+
+#define min(a, b) ((a) < (b) ? (a) : (b))
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +22,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -251,8 +256,117 @@ void test_base(void)
 	close(cgroup_fd);
 }
=20
+static void *server(void *arg)
+{
+	int lfd =3D (int)(long)arg, err =3D 0, fd;
+	ssize_t nr_sent =3D 0, bytes =3D 0;
+	char batch[1500];
+
+	fd =3D accept(lfd, NULL, NULL);
+	while (fd =3D=3D -1) {
+		if (errno =3D=3D EINTR)
+			continue;
+		err =3D -errno;
+		goto done;
+	}
+
+	if (settimeo(fd, 0)) {
+		err =3D -errno;
+		goto done;
+	}
+
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_sent =3D send(fd, &batch,
+			       min(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_sent =3D=3D -1 && errno =3D=3D EINTR)
+			continue;
+		if (nr_sent =3D=3D -1) {
+			err =3D -errno;
+			break;
+		}
+		bytes +=3D nr_sent;
+	}
+
+	CHECK(bytes !=3D total_bytes, "send", "%zd !=3D %u nr_sent:%zd errno:%d\n=
",
+	      bytes, total_bytes, nr_sent, errno);
+
+done:
+	if (fd >=3D 0)
+		close(fd);
+	if (err) {
+		WRITE_ONCE(stop, 1);
+		return ERR_PTR(err);
+	}
+	return NULL;
+}
+
+static void send_data(int lfd, int fd)
+{
+	ssize_t nr_recv =3D 0, bytes =3D 0;
+	pthread_t srv_thread;
+	void *thread_ret;
+	char batch[1500];
+	int err;
+
+	WRITE_ONCE(stop, 0);
+
+	err =3D pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
+	if (CHECK(err !=3D 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+		return;
+
+	/* recv total_bytes */
+	while (bytes < total_bytes && !READ_ONCE(stop)) {
+		nr_recv =3D recv(fd, &batch,
+			       min(total_bytes - bytes, sizeof(batch)), 0);
+		if (nr_recv =3D=3D -1 && errno =3D=3D EINTR)
+			continue;
+		if (nr_recv =3D=3D -1)
+			break;
+		bytes +=3D nr_recv;
+	}
+
+	CHECK(bytes !=3D total_bytes, "recv", "%zd !=3D %u nr_recv:%zd errno:%d\n=
",
+	      bytes, total_bytes, nr_recv, errno);
+
+	WRITE_ONCE(stop, 1);
+
+	pthread_join(srv_thread, &thread_ret);
+	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
+	      PTR_ERR(thread_ret));
+}
+
+static void test_first(void)
+{
+	struct mptcp_bpf_first *first_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	first_skel =3D mptcp_bpf_first__open_and_load();
+	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_first__destroy(first_skel);
+		return;
+	}
+
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	bpf_link__destroy(link);
+	mptcp_bpf_first__destroy(first_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("first"))
+		test_first();
 }
--=20
2.34.1

