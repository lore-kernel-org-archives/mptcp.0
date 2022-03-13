Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDFA46
	for <mptcp@lists.linux.dev>; Sun, 13 Mar 2022 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647172125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OMIYRn28AybYVBn2AdLF1pp0RJx7ZLlrnmUn1LpyG8E=;
	b=fPsMZa0flFiUkrGuyX3NoSEsQ7+AYW+h3spxN3mas4HXyLU4jUGe/6GwG4YJEKIoKNr2lt
	WGaTAVSiKTdR0A/Q0p4ilRG8VXvkErX2M8qcgylDGFqaB/HbfMWqzCgbm3koi1lEsF55Yn
	t7AsvFNsimAeY2I+GupT8rp9yuFf8D8=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-9Q0MoVqiPMemBoGzoV2z-Q-1; Sun, 13 Mar 2022 12:48:44 +0100
X-MC-Unique: 9Q0MoVqiPMemBoGzoV2z-Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flXBkXWgbEQvG3QwsRcgvjVHShQNJk2AMG/2I+8TVF3dBF0URO4fE2s3k327KQJwEb/HRJX4V2y5oMbJGtrek/E8NgGLYoupB8QlNFEtwcK4vWSKKTEsTYO8QhH2FMxHFjMJ5zPcoSJrAVwgDLqIW+KvFwyS4AZCmAzl8+pOt+VF8HVL+2f3rSGxIeZOg9tNkrazDFj3cIP9rBT52UU6nYf8QpWA2ju6MZot0gSJ8CuTXSXgU/Z4io+DIrrLoEiWOVMdXw2D6xlFilAEK36xZwZGi35jRnX4KCCkfUUQB8TZjdJ4d6vtW0J99guqNTGzjfGZWi6xNhVjz0CkfJgqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUmuaDk0j0s4aO2Y7Cja+UtGjoF3ZteQkY+dFFYXkfw=;
 b=HBlfjG9efg/UEpvwKcMjBIbbJMqsG8XnN59U6vQaN/Y8TIA8CxFkfq9mzFrLq0nDq/gcBHMblts8XJp8L/hUvR+rYYAPh44w3YVKA8a7bexoy+dpKFonK/rUKFk3Zmvg94c1nE6GWLq8iw9FcIMxKcRPlMvYv5drJTDkFQMpZ8jMMckhJuiD1zZJjfPs+aPCD51aBqhPRwLWn5RHPv5djas1IPNZfFuiaUtNNfe6Jl780BP249TA1qbiFPxH+4wD1SrLw6s1Pku6uef20GBaZPTmATJ/0wON5R/RE9ap8FoD5iDtYNREGOrJoCfmuD7qDKqYm6SGbvI1QMsqQRKU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6094.eurprd04.prod.outlook.com (2603:10a6:803:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 11:48:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 11:48:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: verify ca_name of struct mptcp_sock"
Date: Sun, 13 Mar 2022 19:48:40 +0800
Message-ID: <e420de8eeaa57d05bc3f0e1a924e479048d437dd.1647172099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4533ed5b-3880-4205-2dc7-08da04e76b02
X-MS-TrafficTypeDiagnostic: VI1PR04MB6094:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6094961E4B5F6B3B869D55E0F80E9@VI1PR04MB6094.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/3pJKrNOMaK7dRrmczZzJD0Uhj7/VlGzQPnIpVH0vyjv3nqSMSzg/1FYYLoCO3nc0jdy1qJX/V9HDdKWAUzJLmsUb4NPrtKwMkMA11iuwmyexuTxfEcFyYTVUCqJk4JyrQkA7sIYuuiq3nI+qkW0Fx6oEdaQnpG6Lb9cAYKgmNfQZZKXZBWr1nstC6g913ZnBd1oJf9TNaK0iQYvLZFtV/MYgU6gWz7KCKtAYCrkIMvTeOvLIskWzjsvDzZDD73tvFjYSCsLfIqIq8FPEeTzYUfD3wOuh/YeEuiuG5H/mgUIDqUUNpWX244X7cpMmRwk88aoCouprgdZKgzhqxDpxhpQX/bmSCOGCKE6sgFAi2VS1tXGPYh6fqOWXmxWQLVUJsEadSBWppoHVvg4yDTgN+KGm7oIeh1F7j7XFFBiI6Z9oJoNiBiRWBXyDnZpOTnSmabYMWFys21Ym+Lsjdy6uvjZt4KL7XKze9qhm7Wklqs8BRsqJR6YekeelOpD4hwxJDJJTsDJtKmCtAPz7KFMOt5KKmvEzB2//YOd29mbhAXo3U5iLOJPlhMgqWxfLhye87qhOQi+mcPSQWoEqsTsiP12e7ZjCLFhxb2B7rG3uk68U1Z3AuOvtf83jxFLJeY3h6lxCPl2EMAPwjOxq2bM7vmneZ+alCu7osufh2XkzKCMWB3IJAoMGZZiGHckrhlZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(107886003)(2906002)(4744005)(6512007)(5660300002)(26005)(186003)(6506007)(2616005)(66946007)(8936002)(66556008)(4326008)(38100700002)(8676002)(66476007)(508600001)(6486002)(36756003)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1KJzmxEaF9LJAiCPKrvn4+cD4f49CJFFwUDqh9ZEevAhqJWhtX7roiMbbw0G?=
 =?us-ascii?Q?7YKUQ0jHEtOpAhgQpkzOt+YDNiRcDkSparlpF3pfrYA8TzAhqgWG2P0sJbgq?=
 =?us-ascii?Q?kBa5wD9uHGZZVzUDl1pnwLRHg2KwMpu47BFZkaQqyzuqX6JBAML5PsS/Sqyw?=
 =?us-ascii?Q?OSFuHppmDOpzGmyfCCm4yw5EwvsPN756Anby0LUZB/BxALVZ+mhk6YPp1led?=
 =?us-ascii?Q?VOnWTIZSdcMIq1U44ACzz6DUJEI4zjW6Y+5LAl9HXP5LxV37b8eIwLLMU3I/?=
 =?us-ascii?Q?L5i5p75nOhIwWTjbEeHn8pOs68hXsd2prz0monvGX4cYuwAPx09E6CaT+4Ma?=
 =?us-ascii?Q?vxFjMWLgpDS8TgyeSn53qgF3DzM1+nAz0kht1B+GHJrJKjSMhv4iM/ZptTPJ?=
 =?us-ascii?Q?epQmAnfGO1GXD5Db7+4Y+R/1HeF0HoDC7tLnHelO/yVGa3e1iE4dh5WdrvkU?=
 =?us-ascii?Q?UOyFoOQ11bED1YVd3toauJwHmYBQnflziI5D4HiCpNe/ZwtVmDhQnvcza7+3?=
 =?us-ascii?Q?UXwAk/rB1SbKfycYlBGttYSZqjA6qgu4cmHdFRPGMCrUzEn2aToj/11DSVFv?=
 =?us-ascii?Q?SUcpH7BTuimzXFRDv7LILutY6ObvZR7gdekAXu1t/HaUWk2TN8WxlYsSkTOp?=
 =?us-ascii?Q?IdGqmQtJR75od/1aKdpw7qTKjiOWMX2Vijks0n6JlgV26fXqZ4VUnVEmlRkz?=
 =?us-ascii?Q?IAt8xxup2UaZsWuAeYTmMNYS2hGBxoPfFjV2RSdlCTwVKLUFhNgQM8Sj6cE0?=
 =?us-ascii?Q?oITV6jQ0AtBVOfUP9CAYK3ni0WR3G83zgAwCczy5o2+S44tTWQ5v432+slL/?=
 =?us-ascii?Q?mW+zLeZNR3zxOjvlLxolNUA4NgKGVUhWW086A3zuFM4/OqelLSJMY/iEH/hQ?=
 =?us-ascii?Q?3BMiSjhNgnnQPlQwR715bt69YDNpZY8tUCoCO6ple8Z23/CK5OKKo0tfg9Q9?=
 =?us-ascii?Q?4tDML1JkAm0dU6XDO+iddUMGZn97aAbSZj7H7M2IDCkYEzWuOhE0CJcgXSa3?=
 =?us-ascii?Q?tZWx34eUhAOotn0RLPXhlE40SC4oi8rNpQNO4NCl4caUojuAly4TJQyWzeH5?=
 =?us-ascii?Q?as+i33VvJMyKuIPkFRNIymJflyJfmF1DtjXyZ8LcwlavJZx/HpMtwfgvu9Se?=
 =?us-ascii?Q?u2SR9ibXwgFmSjyM4gSCzjgA0idpnDn3l+zNJwaHDqhYCxeydoTsIQgGVFr8?=
 =?us-ascii?Q?2kSswGlpMYgr2+x3MH8JmSJjF5vnq2m6PwQY93Ank5ec3gNolBXSR8aCMRXv?=
 =?us-ascii?Q?MhfmYixRljTANMSiMrRrj4BGEce54uedj6HL0pkUNYJK6k9nnZSyG0ewv62h?=
 =?us-ascii?Q?MANsaT4cwpKhzkl/EzeKEtDNj6p6unkkKJx+o7yqFe4Wub9Hmf7XSbVOAJFU?=
 =?us-ascii?Q?pLTBnrqGbPIRq2buhBqldsFSmZ09wd2QBw+g18BeO5JOZ2/qeJO827cdbHZ8?=
 =?us-ascii?Q?YOW1jd4UjuGwybelo61M8nt7+cJBwvbQwWCbdLkEyIrEhm9n0EEkTw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4533ed5b-3880-4205-2dc7-08da04e76b02
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 11:48:40.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEz8eRKBGlkDFnwjbSe8xSeSG+r+wfdPEZ6KeshvzSjTRcbzqnVKigStxuaGPCPgp2lo59t2fhv5QusWs8BjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6094

Drop 'err' label.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index aff35ab33379..a8c0082dbd01 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -93,12 +93,9 @@ void get_msk_ca_name(char ca_name[])
 	}
=20
 	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
-	if (CHECK_FAIL(len < 0)) {
+	if (CHECK_FAIL(len < 0))
 		log_err("Failed to read %s", TCP_CA_SYSCTL);
-		goto err;
-	}
=20
-err:
 	close(fd);
 }
=20
--=20
2.34.1

