Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26712C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641985049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwqrmD1CU+4onRYeb2qm8dO0mlO3b8Pt5u5dNW776WY=;
	b=nQBPm5TCc1+NiUY1wAVC0gSYM8D73utC+PGHAF8bkK/8AK0WzhfShmlNTFd8hGT3yUHpUl
	7lYzzQOmCAWfVR+dEtGxmAWDl1FXr2P0Z1YxgZOwOsrU/1hRnwowdnopsZ6MdE5jDBfnSP
	Hz02p3p1Xdf+4JyfRt7ED7S9uYgJ2to=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-ejRPqOXAPT6WauRv3z8CSg-1; Wed, 12 Jan 2022 11:57:28 +0100
X-MC-Unique: ejRPqOXAPT6WauRv3z8CSg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4kJtlEBqjU6mrwfj+fneicFEayaJH06VaTdnXcWNDnjU5Avm4EcNCNAXg9puL2aFHaZEYVKk5z7p5NXPeAscDuZWiUXRB/QGxQdABfvKYsiF0QTTt6JwGPh62GzpAe1pdY4wYO+ZpjXJzrVeBAeQlqM8BOYCmZYp9Z7OyF5a0KcJEzndMVgUAM11u0mrjfVKNFndR/SEl4f7zWSwwyJplL1/0Ax4Gp3cqtu2D7rcddVRziYLtweHxWZTTiTQziIDh1i6aKNS7X09z/1J5pdnvGoZUVNJALWk/tIOgMC6NCJ84P6dqhttG+Iq66PRbdxCbVwAKc9SvMY+JEMme45kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY1KAnofC3Icqz8rauV1hB81Z6O+GptVruzj7TErbPE=;
 b=dvBRnX+MqB2PVhvxesTGcvJvRAn5OtFJuM+aGvmPGR/fP99ZeCEuus+BzKciFGDRpS1Y8GLw+UpeJlkiZvQS7O9htuw01NXX5x/H8FCKv9txynwTYN8sB1EDN3SJ9m8LnQAoYcCk41Ku1yxqKB5z7jHcTL/vRgSWolLrDGLb6cmEOMpwUqD2cJEejMjL+HrtmeSqSrEHblpXm2vXFdgmS+bJRQ5K6VwH0xP2IEizD6yad7tRRlK0zLNvNG4uVqJipg64QnI7EXRGyQeZ9Y9h8i//rkfJaeSgyORFVQtnPFrhKFAjz9BahnmkMJ8tFHq2AZMKetCZhziuvZvijpkHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3483.eurprd04.prod.outlook.com (2603:10a6:7:8a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 10:57:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:57:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v3 5/6] selftests: mptcp: add wrapper for setting flags
Date: Wed, 12 Jan 2022 18:56:45 +0800
Message-ID: <d680c5b3f56c6bc626d4b0d3f1715c87670bd17c.1641984855.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641984855.git.geliang.tang@suse.com>
References: <cover.1641984855.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d2632c-726a-49ad-0841-08d9d5ba5250
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3483:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3483C4F8680B0BAE14AC98F7F8529@HE1PR0402MB3483.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DfNHrWrZGA2KCGE5gtu+3N2kSQHXniRU5k+jbeaj+PC4Zr4lkFPcRf+rnbhYeOYgoPcxtxZrOjg4fnPZoE9H/lffUL1JhE5rY4AYXM9dtjgd8FNWWiSMDyElbquz0TbNuxb9lt4ao0vCbqWoc4XoECyrPzOe+t6txA5m28wghQFw7JCvI5teHtqSgychAhGqcxHISmMk3jCyfTq7UYZlxMNhZjIQtmhiL1nkvOPbL+pGvEOFul8homnIYtXgzbMZozga+5WyKEM6AqOjp+g2SVCPBTg1FZtebpNhbuiUynTN9qx0NCg1GKkft3kWsdjeQe0gdPhMSdWuZx2q6yIbFIkC5gyq0FV1LDl8vojO6WxbdCtVDZuaWVgt7yO8F/aUgUcemrdXipzf+nKv/kXyLmI8vXphnpZW06GREyLMf2qKeMARcY0mWCazWfRn4xNIt/7HOCKjEobrHjkyfQSTriv11jBt4yAri2LEcK2YSRIfdE0e4/e0UXHMkQYIOon69cx/2DnEuLu5P08LbqZB/ZZCoJneNv3FcVComL+m3egAczSvzRnq6Ifo2+64oFYp63jBec9USh4INCxQr6eIr9WumWQ1X1S9N1XSc8H7v6cDglj1jr9YSbXTAo27igx/erZNDL9TgPbG9cznMsvEHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(8936002)(6506007)(107886003)(6916009)(8676002)(36756003)(38100700002)(5660300002)(6666004)(4326008)(186003)(26005)(508600001)(44832011)(83380400001)(2906002)(86362001)(66476007)(316002)(66946007)(6486002)(66556008)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+UC50gWDfAPzrjghnMb0L6OYeotGatUKU+lJJRFyjxeMOpgZ+x30hJ6768p?=
 =?us-ascii?Q?J8psqyDA0JXD14bJv4kgbuXKo20FWvFsm+IgjsC+LPkaHU07dbnGt9p6u3lG?=
 =?us-ascii?Q?jcxPsijCM8CRM6LxJ0QXjmWWh+/lOKOPSpUXr5NqZuBQIJxp6wksVELLo+GT?=
 =?us-ascii?Q?lgoA/qKjbMmWhQKVa+Kqmwh8zsep0ZYSh4mh8Mueiajak1SrYEkTAH3KocSr?=
 =?us-ascii?Q?P6+E3z8IWlW+uu7laK1TRk5DprJekWwgI0MNJMO89fcD8+LbRxS4lG/u2rku?=
 =?us-ascii?Q?mebDx+/my2+tBrWU6OTgiKgGGwEA9a9g176R/iWkjHzekU04qDMUF0+M8chG?=
 =?us-ascii?Q?Ny5D5uL8O7VN1zW7ztK3rd2+27dCtRbpMBG2w1Vhd/eLi+EVncuNHPeSqt1p?=
 =?us-ascii?Q?avwYjIMGR67qILQ00hxIpdo/6GeJMkDy6VB58F2yz+42W6q7OuuaYtGuVlQV?=
 =?us-ascii?Q?Jc1AbAdSuNhAyNeO7aHJujNzghtFLYQgkHEDvcgDWOx4hDmbeaM1bzydV1Mc?=
 =?us-ascii?Q?PuwpaWwYwGZ+Kdh0eUvz4bXAGte+oJMZxmkDEtZKZiN2FrJW6McMTnwPe4QM?=
 =?us-ascii?Q?6Ep4sgihikgfOqAdI2PGqxMhzg0KcQyzdKrWJhssixDJJ8cYKb4XkW8L1fIG?=
 =?us-ascii?Q?wazr/9WQv1rhmLyZLSitKZ/IGWOPCdKM84ez3n86XEhS7RrbS7R+VWP9PJhH?=
 =?us-ascii?Q?pr9X6V85e1R9Z8nUrUsfa3L85Li9QThfido74mM5tfA93JHIRiRTU7hQ8IEF?=
 =?us-ascii?Q?j9P7i7QhuKseuAjd8DFkYZ3s4wUQ1jv18i7DmbmoZOETIrC6NcsEVeYk4C0r?=
 =?us-ascii?Q?ub2VcGNuKp8JKZVgab15IzmPSc2eUVoOq/i5ioqBO5dVBm1fohi80geSXsnq?=
 =?us-ascii?Q?qouFNLMW2kvnjg8lt4BPkOomh2B+YGZomC0cpldLJ0i0l8it5pKY2K2oVX4U?=
 =?us-ascii?Q?azB0S+pqTblCu0fi0yGvOkU4V/1q5G1VCmRKp7ObPCxD/mkwfs0N1Q+EZcVr?=
 =?us-ascii?Q?InTOLKT9UCE6dHid4bO9u9BRIkvv2y2VAYpv/Bp74uvXil9YSuXQvu09s7KI?=
 =?us-ascii?Q?5imOBnSj5fMpU8tzXksPgodkZzJifyzrviBoNwALAr71hclrzSSp9It9u0QA?=
 =?us-ascii?Q?zHYtToq+XwdMbztKCQVqDHazk76iSbjxwazXoxBoXQjGx8HhmfIASjoTpe/a?=
 =?us-ascii?Q?e5mPLqd7WOYpLWA4d3bYfV06MAu3BE2bR20V+rOONDwnqDcQH9M5eawglRXT?=
 =?us-ascii?Q?HFRJ8J/IKZncg8cU5jS15d8fgekMsnxza2Vn1IBM9AmMAl3KSOLhYg+ZVZvX?=
 =?us-ascii?Q?pwEkLchQ01RAx59Vksa7z2jlRPtIONT1VLw+NTRhLR3aOwjj6y33c+GPPVU0?=
 =?us-ascii?Q?mUrJBF6/Oass6OB7pI4/9BAwWW4u8prV6DsANyM97/KjTXPo1boTF3PbszH/?=
 =?us-ascii?Q?uy9PxoVg8zQG3XL4TCbIVfp5siBWenp2lDpQlujaPy07cXOPzcAHNXeAm8eU?=
 =?us-ascii?Q?g+pjCZLnqmlVK4QN3t0NYeuhR/8b0x3P5nOqq1VFlDYyf5T4LmQ8HGGfl8ne?=
 =?us-ascii?Q?YYYzCdwGnw4/HuXGw1MXtY10Zu/LlBTFxghRKqzs5mSwYWkJyZTQOWUFh9ru?=
 =?us-ascii?Q?KVilnkFqn8zQO7C+9KiWhag=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d2632c-726a-49ad-0841-08d9d5ba5250
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:57:27.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgYw3cMbwp6XGZSxNl+DWajQgweidnWY0ZmhsiRG4rbz7q6C0hfvAWeKFtEPl0bc4wHa76AQGflIfCKZ2hxIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3483

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to set the flags of the PM
endpoint.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 66f430d6300f..512dc92a5646 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -371,6 +371,20 @@ pm_nl_show_endpoints()
 	fi
 }
=20
+pm_nl_change_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local id=3D$3
+	local sflags=3D$4
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint change id $id $sflags
+	else
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $sflags
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -571,13 +585,22 @@ do_transfer()
 			pm_nl_show_endpoints $netns | while read line; do
 				local arr=3D($line)
 				local addr
+				local nr=3D0
+				local id
=20
 				for addr in ${arr[@]}; do
 					if is_addr $addr; then
 						break
 					fi
 				done
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						id=3D${arr[$nr+1]}
+					fi
+					let nr+=3D1
+				done
+				pm_nl_change_endpoint $netns $addr $id $sflags
 			done
 		done
 	fi
--=20
2.31.1

