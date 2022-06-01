Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB81362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654066015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58WBS+HBnxE6l/SctnekWuFU/3nS2PtBjy+z6uzcPf8=;
	b=ixduMih2uRLx3zzMdcQZfRpZCFtH7n7Cox3nbgyNYylRE9rWJnWrpxsokkOKe6YjbjuUyI
	w9GYsBGUzIvjeQOxJ9xUBhmWBnZxIUyMOhKE7mseetPfsfaNFLQ7a55s25s/w3y2vxG6dQ
	lErDCgBm1Ar5U3cdzxoXov6U4m/KcAs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-46-HyE6DJPNNL-ujQ6rsCU4kA-1; Wed, 01 Jun 2022 08:46:54 +0200
X-MC-Unique: HyE6DJPNNL-ujQ6rsCU4kA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYkqyUkaHCy8/A0iqFyKOcyW9+pKjy8ZkSbxDcXJbx2v/3CADg78XCX2pGt99aqbLtjMd+L5JYeoMdKM8/6pwGJBsXDklxqzEo3xgJewc0NDXkJpaU3i2fCWPAAu4vlYqfRFePsK6A2TwaonpNjxzMOZu6YD6fbpXVUJz6vgc7ixgPPP3tQxelKPDLt11ub+1sw/Kf5vXSHWr22LAzX9WgNkMWVoZxdoLehSKNIhCuHgjE9t74HLK/j3Dwf5jmlo6EX5oPFXITmb847iJGTd/3OPzKflnTjI8CRlRe31cFlw1XMY9z6aWrlWlusqXZFJejr3/BBr1HY2UH/I4gGf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijzT0lpNpuoNGZANhRHgkAx3g+9T2m9yp3NXix5KUnU=;
 b=i9E3MQJRDScXC4MgleRJx0nMli2T7ajUH76RwccmvURICls/3Je8GwMbFkJ9rhYe9yPbKv1/IGWq6/5axaVkxcHqoscGjEGKb9uHPdZspeQp7WDp3K2O1nzd8aOEzqnfr0USk/lD/MGHGm5aNgv6um5f9f+6OyNc3D/oXnb4VnEK1Q9bmyC13VMluHyEJQiXDx6c605PpRlwjJ/D7h6wfDDmteX5Zl0mPheOk1a/ZiFiQWqucrqKiAn7BRqTN1mlJ0JJbkRDmkNYw+Kr+lAu5uWgFTViN1qfsiESWqA0cDUqJPq1kJl6zFfh8lrBzrLhExaKfFS9P8KbuygYX605Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 06:46:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 07/11] Squash to "selftests/bpf: add bpf_first test"
Date: Wed,  1 Jun 2022 14:45:56 +0800
Message-ID: <23261484873eb112ab8bcaa7defbf146248e6c72.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b93ed16-d771-4c3a-4a97-08da439a82f4
X-MS-TrafficTypeDiagnostic: AM7PR04MB6904:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB69044365EABA9B4F035E31A8F8DF9@AM7PR04MB6904.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zSte3MpuAR4D7Tiy1yOgJ6E0eKZCXeRDIcNa58Bm4WZGets3wqyFDZHtQ57yVR2e0dCoOhqdhvnGZ6lcfp5ndtHISQupvOEjKcn+PlZoJGTyEnmLCs3T2pjQXagPpUPaHKd4P8iNGxwojmKHL0E3YdEf7j/fyiUvcBqVYbPHfzg25gDiUpFsxaJsSqDDKs0FrpkhnNld3RhvC8pPiSEP5D7VXo67dKO2GPlGsLxua7CY6KCgKGLdss8aJrzI8GJo02s74VE9pcbxIGcM91HweRE1NK18SvdXktYVvTEC7/OCq8SQ0ruN519AVqbIDCffA+3M3PczujRiBgfmo0VuNFENcUXBoAuWs3XD95QmYvSQFfA86C30Fgs7d6snkc1O9+tkDzz9k+4ryPgqwsZ5e13ZbpHAIGl3vZEg1XG584m2mLdjUmm2VC0XRF/9uBzP0veEQOHV56wwKg11swzPARuQfEfUACXppq3QHvTF3ZKtR7riT+q8uR22R8dP6pAlW3JYPy0C0PkWivX4zWV0TAKllNqqm9kzFdg+8cfb7TsWQHavJnb/YKAboXRYZPwEpi+Odcn5Vwam/j9EViPEYTzhyP692DuJ+EcGVK1p/oQCPskYHPNADihrUynJOzSnEKapC+A9qoKfvPqUqbc5p7LPMagP68McMxOdYvLxyCAm8vq5+muEna3mILiV+mYh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(107886003)(86362001)(8936002)(186003)(38100700002)(508600001)(5660300002)(44832011)(6486002)(2616005)(6506007)(6512007)(26005)(66946007)(66556008)(66476007)(4326008)(8676002)(36756003)(316002)(6916009)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owG9BsvTQPrCqN2KdrFOq+6YFLoIGafpkzSELn+GQOPdLBsIzpaS8T//CIVS?=
 =?us-ascii?Q?dgDh7h1ikVTQtQuHLsh5bmZEFZzdnnBcQNxRJzsDJBRqE6XfTWW9nNtyXIef?=
 =?us-ascii?Q?nLdxjFKNIpCqOF7HkmOKMAXq0kBfn/l9NR6rRqBqsn1VKJIuhTrixUUMRBFl?=
 =?us-ascii?Q?IAzDTtWgscv2jioEv+ON82i9KxoubGX3DKjB8eW9/ap5dsKNgBhMTJEQE3Kd?=
 =?us-ascii?Q?LmZ7prGAi/neLWSGhibyXRSYeRyANie7mUr7ZnqSZJ/EGLQKrl7Vrj9Xjobq?=
 =?us-ascii?Q?wTM0rL+r5ivPAehbl9/JQiOtXjCis1PViMkhHWZfpsXM5T86JhSmDqLOT6k0?=
 =?us-ascii?Q?vG3hiw6IX4g/Jv3dR8avKPvB7WlIEze7h9+iocQKewfNxQ3vzHKCjE3CAZZF?=
 =?us-ascii?Q?s99p9c4AljvuGfc/WqDNQrMtt2GpBqZ71XGUk6q8E4VgX/nSJ3DWoXIqdX4d?=
 =?us-ascii?Q?B8zCUOyfw+t/Bf9V3WQ+MXnl/Jceay7iemddRsQBmcirqYxCEeILZOQ5yjlm?=
 =?us-ascii?Q?7OZvIIbV+NFqUuxInNoxqgUwN3nYCt2lYv250wVVz9eQFh42Z2ZbLyQr6HZU?=
 =?us-ascii?Q?mljAVA5ndY6Upr8pWw8DotzyN8LFAR6Am6Jy8LBQlJMY+fB6wAqS6sLoToXs?=
 =?us-ascii?Q?Qol4Reoso118Nt+r1UtodIHr4KNV5GgftRmwx9IPnaEzTkGHZAyDY9QpowRV?=
 =?us-ascii?Q?pwqDD6p1uw+X+QBDmf8dTCoozTFSGeSVD89Rs4+pjBLoiX/O2bCbVSha8Kot?=
 =?us-ascii?Q?1bQm538kllwPG0DuK0S+FDw0c0cxPQNAFgWgXfmwxo16tJck6Z5H0FqEDXgY?=
 =?us-ascii?Q?k8nTt90pMYxUjffTRhXUsEKOXfMt9i55gTkqF8IOafNQ2G15ZS858gRrt06h?=
 =?us-ascii?Q?rIERj+4veUSGpW2y4SjRajaVOgDDGFqXkzQCgXXbN4dIEAbWlqJp8k8sEAsq?=
 =?us-ascii?Q?9d/YieUo1DKiU+8S5/m949fr5FcVzbGBrp9Gh2/H4/AEeqqaoc6O+5ovewh/?=
 =?us-ascii?Q?u5/BXs5vxC1QyrThugyQYYibevbwQcmt5BZ8DqIA3D4erdsq04Q+lJ4DK239?=
 =?us-ascii?Q?AOendlzQ5w9Ct8BNmfEREHmMf+t7svvJhki5hiSLbnJGt0+z76AFkDyLwZL0?=
 =?us-ascii?Q?nHqfuPqWdyMKbqycIw6oE5VhppdC1R7zRfnfhfB/g3WvVzSEezjtP//jr2xP?=
 =?us-ascii?Q?aX/QEIy13d2N0tKE4mJjKTELhdzG2/85MqKAlLcZODN5qrH3LWzW5uuzzDK3?=
 =?us-ascii?Q?VQiCtysAysmpqXts6Sq4DpMJ8YvmgI2MzE9ei8A7qf2n3idxxAAYnqEpi6G8?=
 =?us-ascii?Q?uQ/Cw0jhnY81ALU5P+67N+BS0R5JwO0hrTl4/hiZ8BL21ogYrf5slvzz3yl0?=
 =?us-ascii?Q?Kzqc8pvkxc4SvvKZuk0QdxsOOznpwi8tm07ihUy1d9KbFa4Ca2bYsLDuyH4A?=
 =?us-ascii?Q?s5gDIettP/xCvvXcpUzdHn/3baXCe9gOe5kM02jEIvoqnsP/TIlsu9wXO4Sa?=
 =?us-ascii?Q?CsbdfiHuPu9vRfEZS6/IPYwS9Eot4USlvMJ7aiaBdPiJk1EvakT0zBE0F6in?=
 =?us-ascii?Q?d0f03uvPo+mpE2S11TNofjynKkBp+mC757uJPxEKFQYi+hP6o6WmT8WtYRcv?=
 =?us-ascii?Q?f3d5TrONl6vutE5+1zOIxd2i72pfS+YdcCgF5T7u6rGhQ/6HYzoCm5yKXDe9?=
 =?us-ascii?Q?06sCQjm054zCPsodO2iKUvsPnd6T8ov4Le7y+rF0h/kdIJ4fYMioCgTuPBAO?=
 =?us-ascii?Q?DtHJeGLv6fyKrBgpfvUsQAXYt9QhNm0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b93ed16-d771-4c3a-4a97-08da439a82f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:46:53.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWloRGF/ZXPEa2vfvDFyHg8+sa6xtCKZc20TPbYaRFmhM3Wk93ZCW2RuPKOCH2MUbHwW7a3LuaGf8xFVKNJ2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

Add two helpers, add_veth() and cleanup().

Please update the commit log:

'''
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

