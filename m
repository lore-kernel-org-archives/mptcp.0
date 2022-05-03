Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BDD2F44
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651585478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WxkxHEWCOUhAt7LwTc5SDIzPg4aRM9+XvQCY4DSNYa8=;
	b=ZdJKbi681NXXOBGim9gUGFH1eomHFbxrJ7n9vrsntqFyYhgW5HehUWVM9IJmPRh9HFUC6n
	Y6tG1bYY8c9G1tFJ0yJ2jc7ZtNt+x5c6YU2O5s7FxIM/nu/11vHCkq6MstCjKzFImh/uXi
	GmrhfPn3diKrCXV9wqeHbB82rxU7bas=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-zuI4ZWaOO0yE11G_d5C7wg-1; Tue, 03 May 2022 15:44:37 +0200
X-MC-Unique: zuI4ZWaOO0yE11G_d5C7wg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWtvsK7i16yTgGbrs8Xq8WZDQP+YSmhBc31QuCb1hgPW4EO4ConYUPkq/3AVmiYhfT0yjIvVaQHldYT3k7ER+WhFGOpZiZi7da69Af5cK4Sy+Nx6TayXE+gNlgLIjdb8cjf9IuI7SVQe8YTyYNu+KZj0GqgJCZgWq03rhue2T9JJ7nxhx2yVAW/A5OxpJwABYFdpQ292O3JZDqD20EanGMyz1XwrSWNsqEm2miAeFAcWCaRaIEdqHt9LyjpcAbMMnplwVwQORHYY/tCRQaIDNc8OZWw0pRYJDp3QZ1z4XjPVSliiirzZPgmK7lq05AfVmk8Clbqmfm6cDK5SoMcp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7/fxLlDj0tm8pr9Gy2rFnCvRHyFkvlwPF/c1nJpyjM=;
 b=LrBEb57ElZ9cfy19Ns2LG24Aa10EgOLiX/amqFWuEIoiNhYrc6n9BZYP5OPqxw103tzeiWqvLfnPh8KPPNlcxshwtTnwWKAKf9jz5ZafsRwLVFkQdqOrIn2eueUORWEZO8wyF9jJs9DQZRSSVEzvvQ8vpQXModfxcReB/00R5hJBdGdtVvNCc/iENiGqoYPOcLEdUQSZfyb3iyrJmA6GPL4Nib2+QOhkbmd+UYbmPfISWs3/Mq20WyKQSRwp7Ok5rJTz7+lsrB0e5sMaUANQj9VirVg9M7kPLMd97jdkvMQeTu0vw+pgQ/o/o402kTrPzq8oPPh7gXCULbdFGruaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2607.eurprd04.prod.outlook.com (2603:10a6:800:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 13:44:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 13:44:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first test v18"
Date: Tue,  3 May 2022 21:44:18 +0800
Message-ID: <c7fdf7862cc989dbb43ee07247113b6d9d861cac.1651585416.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ff7540-ceda-4802-a8a3-08da2d0b0f6a
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2607:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB260708574801A2837C8A611CF8C09@VI1PR0401MB2607.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	heX2y3Zz3GROsv+5hdp6bEmN3GY07fCU0W6bdo9Hz7m6vb662NfHlQNWJcJfM0LQ715cYGmo0elfvRK2HBtlsk2Ydz7D1lJRpimiXCQLrZ2hwIJvLskxwqCYUmcaTeUMLxXoCsR11Hus+qhvesn02JjVvQ6+UVf+S0xVjC5bz9xxHid7FKCCUltsD5eCgFt/x5+VHnW65RqiQ6nLYgXXDFywL8WTvm3Qf8ajL0CcIt/fsyym1Mw+mPy0Q+cd/RYdd38ziEj5iuMHXjGqYojpOEoW2ynURsLWQnvQDY/BFTUE0l2pVz7rQIt47tJsw2W6ThIRBSsgzseTHRzHc+3y6n3SJXXL53M6C5x1NVd68kSwnBdCilINU3NWGPRNmwVaVTor1PbYPOLLKS3DLXkK5YL9auDzn2S9Url9X1Hr6PR3McuYldYGUbvbrMPOaS+ByF4IXqjeKqUu5SYPrqpEUuOKe+exCw2Woqb6WQtC2qFEoUXV6cnn6lVAhHrxBwGbTrbUxe3F5Wkr0Q8z9F4nYrOtP8Xs2LxNCVQd/kLuw5+WqToxjgU0zC7aiCir6dPh43MQw/+B1BnPjVVesuJknkBr/nX08JJTJyZ3vULgCPeDS5fHfyG7ut2/MbXbDa31UUyDoF15ZTZHKc4V4dyzW4ifFl8xXStB4Mn76f/my98aRwZsMF8sFjK5bdCCN8fQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(38100700002)(6506007)(44832011)(186003)(5660300002)(4744005)(26005)(107886003)(316002)(4326008)(66476007)(8936002)(66556008)(2616005)(83380400001)(508600001)(8676002)(86362001)(6916009)(2906002)(36756003)(6486002)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1pxHNBEYZtdfzcw2bTL5FLdvsIfGLo24GbhDtWfrbkM6Ys8EdlYXgPyjX1G?=
 =?us-ascii?Q?XMyOF73YOzOKQwfWOQnSrEn7DFdTolYvLyAKfKSzqmU81GqoandagyQHmCBC?=
 =?us-ascii?Q?wX9Zt9N64aTJ3jGnZ3gT8rPhgrBDHrXc7JZ95DXveBBXh88y/gX/XnSocKym?=
 =?us-ascii?Q?96sWQzRTstvY06p8hY70sRPI4ib4MHN1fpTvcc++dZzwKZP1gnQiJR+nZvdO?=
 =?us-ascii?Q?80IzhXoT1+BxZHXlbPrukeRSdVgwMqnFriwCjpt9z5tii7l1HriXIL07zpC0?=
 =?us-ascii?Q?hb94BBnTM3z+rnLqX17tGtVZsnEV7PYOWQJQUqZ8J69TdA8QEiCq4otdAC2A?=
 =?us-ascii?Q?chqVynrQPqPenc9KQ716p0/+Lxgv3VUNDjZgQT/qyIk6hZ0F5h5cE15/r4LU?=
 =?us-ascii?Q?uCL8VcrZGJ+5z3y/2xXsRHqBTqNm8N8foLDD6SE9lRTzE7gaDIgVOtUo7+rn?=
 =?us-ascii?Q?IeSwAl7AHrEEbXCDAYCIfEWx9skgG0xXBqmaCJbxbCVXWKevJ8jUjZSJVKU6?=
 =?us-ascii?Q?oiQaFjKoJVORl5kG+xGSYleKnv9yL0pqeEnIzkScNAptDpJgz06Q2Q20qVa7?=
 =?us-ascii?Q?pvA0lWYo+7zCE6f1fzg3jJ7x2VoJ+FKbXa61kq/gfmsjwIUqaZHSMt333ulW?=
 =?us-ascii?Q?Lzo5RGw8cUL6aXnQefsLdWkDgAfs4vqjGRd7V56jdT4OC+b68+mGvE76NFLd?=
 =?us-ascii?Q?UhMRex4FSt94WP6o/coVGg+RWVFIh0uqBPDHcQKyaiRfDm22d7z13TaMzRc9?=
 =?us-ascii?Q?D2R+whSigH0uuEhelJS69khPvHKqIpqeO49mcUJUtjG1wfiJ4daWwAD3glDm?=
 =?us-ascii?Q?I6XDB9Bo1hYsbUMydWtuSHt10Inm/SUAnRA4hVh9XKRQfm/JGefFX0MnhC5p?=
 =?us-ascii?Q?pFXbGj5Yj5jKA3UQDosDBe17Lul2/IwBgJxi7tgglzZI6INVljUjukRA8n3c?=
 =?us-ascii?Q?ZSJV6xAJzj2/rXZgSX/Lg3sAM1FY/5NofCbN+mGxOY7BRzIOU3puI7fjBEAG?=
 =?us-ascii?Q?9hQJMh1H+kK1PFfuY2ZtfiV0CI8Se7TOhuKwVIBFDef+zELZLYwY7d/hHi3F?=
 =?us-ascii?Q?yERHXm7X1p9JLIhIJsW1Nym4COaJjQzb09cu9lQo4D4byKIJWS+maj/6Y4sQ?=
 =?us-ascii?Q?0+zEfWYX8/DwegZe9l3fN3f6IMfAn7P6qzqoDMeXFhJOiZFzGaf8U2y9QEEG?=
 =?us-ascii?Q?VnOHUPvLpoJOPbboziRJaKcFuQotPq0MF73QLc/vo4YwbHxBb30IvGy2/ZK3?=
 =?us-ascii?Q?5ucGYTAGh6bi8RfuqwF2BhKoVNnpvlfAwZuW/hSONYmRlsiRpMn67cVRizJP?=
 =?us-ascii?Q?vpMnSNWkrZPNFxPlunS9RGE6OvnFyuY4WEhm6zr11oDJeDyvvZXfBQ7lOVKP?=
 =?us-ascii?Q?tZtbAPMgODWvLHbNThebeKypzizKRwf9YNicsZJG6zPRo0G4QVxT/AWksIIv?=
 =?us-ascii?Q?/akc7kj8JgM1VpaGjLPmzoVXzSuXQXd33s5P2/6AWNafqUoGFbpggwamkhHW?=
 =?us-ascii?Q?gDKp07mPzEkeEwkbiTlO/ZTN55BPZOdeN5oKvuYyz5HQoatl6RBCM/za0dej?=
 =?us-ascii?Q?wJHaBCuEk/hujUEDLHey0VT4wJbUpc2zl6etczay8QYibErmI0WkCGF01U56?=
 =?us-ascii?Q?jneTqOy/tlDrK/AuXAJFQflavcNY93sZfXj9WWe75JbPOXRH9H3vYfmIqAiW?=
 =?us-ascii?Q?Dy5esU8MMSbvjGgOSM9oQoQo4bLfEImQtjbp+lzzJYmidSJ/uaXKm8csZ3As?=
 =?us-ascii?Q?XOqUnLjeifDEWhX4OX5Upwe+gTfQ9VM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ff7540-ceda-4802-a8a3-08da2d0b0f6a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 13:44:35.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJwxHoaERyph9+pvRvonjfq10O/TYdWrCIe0ZIRJg4QsxabF6h0cLm4zVjtGqbO34YBDP55Lvd2e6b+yy8D6eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2607

Make the sysctl command working with busybox too.

 > sudo busybox sysctl -q net.mptcp.scheduler=3Dbpf_first
 sysctl: error: 'net.mptcp.scheduler=3Dbpf_first' is an unknown key
 > sudo busybox sysctl -qw net.mptcp.scheduler=3Dbpf_first
 > sudo sysctl -qw net.mptcp.scheduler=3Dbpf_first

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 21462c29683c..925858d63a9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -363,7 +363,7 @@ static void test_first(void)
 		return;
 	}
=20
-	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
=20
--=20
2.34.1

