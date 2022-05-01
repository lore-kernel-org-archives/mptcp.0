Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4628EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651413004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUOtiDg4T8atGHW0eX19Az1qQmQZsYqJl8dDWBnnWos=;
	b=OvFWG0WWv1p5BO8RKJqVAvJoo2oizSDcVst6DdXEKxoVmiFQBWNJbd5T4FCeYE12YuDdk/
	mF7Uv9z24gh+K0vOvO/fz7oL0nmXfeLML1eAnpFWH/lsd6Mr62roUc7DTbKNEVjDNSeX15
	ifm/zLJmqcIbB9qYVT6KXBqgOcP4QB8=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2172.outbound.protection.outlook.com [104.47.51.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-hJ--GDfsO7Grc_-JbEuzPw-1; Sun, 01 May 2022 15:50:03 +0200
X-MC-Unique: hJ--GDfsO7Grc_-JbEuzPw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEnEN51Peo+bs5NQ8/DRqqpvjmOAGgNtXhreyV7VlTpJPhK4L6xvSIVQ7/Cdhzf++gcStgDMqPRp9aeAzGqiL+Xrp9nrmZazZDX+Yh7CGoE47H/bUwHFiwxGXTrF8Mlut7mf+xTkvMDrc0TFLAqGzCqMQ3yPlKsJUI+e9lPpiWkzdRBcAQ0cqIBHRp5aPX8l2hfjhTNMcBnf5LfFn/CUKMfpA/Z3XPyaQqOCqG2n9KGuteaYZcSK5krKv/D3AABiaBHRI9nOwXKt/WhXsEuUC+xtBDG4LTkacVxwIF2xowHw/VFJe4sAXfxs9kf375JmWgTBbwPLzGwgd6fMg4+Org==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4knqxC2knbve4XzTEB8+fVTeKk6re8tzOKRYXFT88s=;
 b=Ndz/f3STqZFqdHVyJX9s+Zj56oSaIYbQJe40ck5C1G66VhG4RvTm7nNrShzJsqKGIKVJGwplYID/wRQMkOK0rG6wuQV+lpG44SyRYEyXVPd5JbMDr25GydB0vjOOyINdqZwvs1ZH1+jsZ6G6TLs3g6g1wVRcBy8AgPh1vzOJ7S2hQgdrv76NJ0/1xFY91IsiTS1nhvWhYtto6SP8nsqw/NPYWF7jSZhjnkC0Ga07y7vVJAOnHilZM8nmSER8b99Wv/Ok9sQrsfZuuHFjCBC57DIiIaBLteyyHve909qlGxe8M3JIbsdq0wa7XTge159TghBaha/Mo7LLs3RFqtdHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:50:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:50:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 7/7] selftests: bpf: add bpf_first test
Date: Sun,  1 May 2022 21:48:50 +0800
Message-ID: <2c5bd5067e0d508dc5e677da3848d6aa6f610174.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a05f4fb-74e9-46c7-8fda-08da2b797d41
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB62833EAC062DE1D3AD3A88AEF8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JRI4U5LHb75+WXNXpTRQkXy50l5RDvwbrPt6oKwosC0VJpPvMBycePU8LyFqoORRn8+RwtJMjF3sd1yhgq6H9fA8Qn3k1wwF4QxlxfZJ4NBXgPYY5ADXqVDWHhEg4hXqGPSOEcj+fdXfVWPzE4IOiSty1Frl3Yhj1pJFkpvSz7m1QCvx1XwC7H7aqeN8M5Ubh8Lv4E57lhUcqNkP7EoAPZg+Bnp8+RY+Vpq8R32G5f/hRNQKGBtQyCqHTLFoEOHMGR/qxeUYlBEFview9e7qrjhWWetCqWAK+I3kGOstI9EAwoIZmbEXKxdcACln5PTN3r25GRlFGeFIdXLDYW3N7DmYsmOzZQX2AGWAz1c5NVH1p/Y1Jm8uNSXTF664YyotqxX3BY63lJOmRsHvrxPKMgzHLj+CZBSwM7DG6KsiDfUeFjMUQI35+BNUMMEcwg9/I93CpJD0MrULpmwJExbAFCBGJTKwjMz7gqQugj+vqsvR7weMKlXXg0oj+z4WZPCdJ1opLSCbh63TLPnGucnFFJJorDo0WVN3aDM3AFW+ezMkeFpfrOXeAEGvinOAO3O9uNVxOSASoYhSOs0/VXz2S0nnQRMBtNxeLYqiG5M8RAOT17BFGunJ67fF9NQKlGb/upXxZkkEQAxK+QBbCJFLcvPZdMo2ZOd9uzNReo4pdUV+ZDbnCAGo1Izq87jp6I5e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(36756003)(6486002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqs1g88+7MkmiR5NMgYoKuLuOPd23mBWsXtCOS+xl/KOkoLEMsvMkaM3+Y/C?=
 =?us-ascii?Q?iwhLpNXyE3IY4acAQeFAcOEIYpuCZszkqqmOnB6Op39IyOjNRCtJcFM+prFI?=
 =?us-ascii?Q?PmchMR+n7NJxci/7x51OPtiXgRXr9aF0TiBC9qmSGPwyV09M4XfjKWrQkAN0?=
 =?us-ascii?Q?iV0zZryn2Ll5ihhQGW1OskiI9GaTnziVhLr8GViwnWdB7Nk6r2CexH4n/XKO?=
 =?us-ascii?Q?Cezo7MOAi6NR0WGB4OkXGPwrCCH302pAclEWdx8MaQVGkMJAwQkVhRaxqwhl?=
 =?us-ascii?Q?HGbraFI/FgzivsxL6es0sm/HhgoEhwZsnPBaDlas6Rub6CEo2XAbqmTsjhfG?=
 =?us-ascii?Q?6J440DQpp9BcrYNfD//JelLfa2IRciuH7y7ynWV8nT+grDJoFOlDyrnaLyNQ?=
 =?us-ascii?Q?S2pMK9fkuo2fgXKFb5ZSgjp9GL+6bTF2vJ5hci8Ro1B0c5E9NM5a24TU9Ci8?=
 =?us-ascii?Q?fv3uv6IlAdkBYP+COYcTskDBs8+XX5tWflBf4DvCCLlUYvOZYD4nUgnM91HP?=
 =?us-ascii?Q?BKr6V5n+6kNBBdLl5lsAhP9lrPOY/Af3+aco7gplGTwVEch9hNj76pGwpq6J?=
 =?us-ascii?Q?0EYQb7VnbG8YAR9Y25VIMfIPfeeunAyK4F/3mFrgGcnAm0zlQCxEnoZIYpop?=
 =?us-ascii?Q?re+q0KMtrXoWKkU5Y+xzPqbYkd/f+ZujoU4S36TqyfG+IE1kbuU4NW+FgHjr?=
 =?us-ascii?Q?lAremgkhn62PPBhkdLBdHqhvRsg7mFOXf0IjG4bcYKKhS6ZCW7hi8B2quhtz?=
 =?us-ascii?Q?XZKHAESjUu60ktXp1X2rmz+vIqWZeSZZWacsuixm64ft2wX91MNY6LO8fJ/H?=
 =?us-ascii?Q?6OFNWqPsaJlmj+j0DLXVQoBA6ei3J/QerMX83EoDFmZQN8fqq+dcAAQiLPhI?=
 =?us-ascii?Q?ZfGnEV3kVSoKTKdCefc9iljhpRGDZMJcjih7F9uMbuPVjWwGVlNdlQcY4J4x?=
 =?us-ascii?Q?/TITk7sFXioVxD9QBA99Vpm+AewYZ8dCAwFw3XYj6w1+/RXqWP/9sA2BGi+Z?=
 =?us-ascii?Q?OSzPH+ffOVw74qgv6ih7bDwn+YmHHNYXMUlZEvbtAdEWyzqBcYZwJ9z66Xhl?=
 =?us-ascii?Q?eQ0mSfg9HlNnX2bKjENJgiiWLvzF6VF+cauGeaU9bHcxfprQP2/8OuNc8bcs?=
 =?us-ascii?Q?XcUfGnX4bVY7fQsLKhxt9mnoIFHN2yo7eN46Soyj0Ly9Emwj9zJTbcEmxa6x?=
 =?us-ascii?Q?7fnUPY1nDqZyEgEle8i1GeZ9D//Z/pRlxpp3WFKy4MiynQJUMSXr/IsBTBgW?=
 =?us-ascii?Q?MZR/sHzp4ShvgsjaDdKjCiBEPFP8Hiwo7QLjxSBUPkEGjilN9LU3stg/1Fw6?=
 =?us-ascii?Q?dG76Kbr5B+bIN/VluzK+3mWLv3sZglxRJldJZkj9XURV315JX0iSriEEmvHc?=
 =?us-ascii?Q?4DcW6WVaQvkJgyF9GRfVhSYWkEZg7FAQGi3D223AnASTBz6TSIc2XQlV7yCZ?=
 =?us-ascii?Q?sAwIArq3uKSVML8zmxQGUvAbHrNjVNAz2TlPn0SWl+3QXfNAY4x0KzODlZPp?=
 =?us-ascii?Q?4SF+LyHSZ47aM+kALTAx5HYOnKfQALRjNN081Y6RMctO8CKKb6k5zomrTwqG?=
 =?us-ascii?Q?+RGJ0dL/kMRd9A6MPWUP38d7HRWWkk/Y36CUzd2zyDT7X63wsBL++WaCYviJ?=
 =?us-ascii?Q?eD4MJ6ofiuzo8Q8oK5FwFRhr0QdtNoPMNM72AILxC7LqD3Hz+JApwtC9UGs6?=
 =?us-ascii?Q?AWzElNmM20akN36EnpI7iX+XnHM4+pDwnAICSzwRtw8FBa4Mz7pfdF05LCID?=
 =?us-ascii?Q?3eOIg1hIhmDHnq7ppu9+bYyuVW3hEXw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a05f4fb-74e9-46c7-8fda-08da2b797d41
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:50:02.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb+3vdAo1r5YWRHcx3kb2NRy727UqC4TtAX9IgQ4u6UFuEABolBT+buLOWBW3g48QZf8vHy8zNRIud8A1cO1Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

This patch expends the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first scheduler test in it. Use sysctl
to set net.mptcp.scheduler to use this sched.

Some code in send_data() is from prog_tests/bpf_tcp_ca.c.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index ed5773c26045..21462c29683c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +20,8 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static const unsigned int total_bytes =3D 10 * 1024 * 1024;
+static int stop, duration;
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -265,8 +268,117 @@ void test_base(void)
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
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
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
+			       MIN(total_bytes - bytes, sizeof(batch)), 0);
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

