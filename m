Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA757E
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648205288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CEFySunIyHZqQ/q5376ND14uWWYOdFiziNHuuC5qBYk=;
	b=UuFa3+JVn9yxgSUZnj72+bUlC3xbY8gafLnpQ9muJJHwinIy9gn81QcF72gK54Jz126zHa
	oJBxhyY2ogNIvCSMjlcaqQ6GSdTh0PhZm8elWKKJbL2qOAD2W68oyh6EXJQGhphECrENtX
	pj0WkoNqmbdr001diO2hqyhA58WaL7A=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-r6kG4GVMNUu7xTXEvAhL9Q-1; Fri, 25 Mar 2022 11:48:07 +0100
X-MC-Unique: r6kG4GVMNUu7xTXEvAhL9Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jca+Ailta8i1AC4t+pAf+gvDyVuRrw2Na8nGl02h5+3mWdoL9+ZIQzMYNfti7xwLjRFbfkwrKfa3obpDnPmH59kJpSElxBABgrBp+L3eD2rSqic5mWdvNvZU+N8T8wa4imXgI24F5R4ce39WswOMh4drSTREcUf9pzNRPIDHI3cfE8B8gR7AD/FVhycqsydRsvmqA1wxybLejZJdaKc7Ixuew0uKMKcBRSly1Ip3/2d3ww+L8bBnLb4QJXVJ6YDotA2uE+BPC9uqXT7PyQmIP2EwaqIdZuqS5yFAbbdOrFXKt70gtOIDgP0RGiiLKc4cR7nYeCMZ/CE957Ywisw2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzSp7aZ3VVGs93VXcS7WX9/jqPscWpeOLGAQOwyeC8A=;
 b=dpv6F/1+rrItg4IyYtoocB/j3KJIhM2SshLwIn3GG+/7zMGquR95mgPSPWO/aiFmsWtPRA0d5jndcIWJgnhQwqKexdOrr+jkyW3fahN3YpWmIJz2gfOt+Gw/YR8D7c54zBxWHhjlQdmOGZ7k2c06gMeOyqVyE+ljJQBywUosFBkDU0DicjgVh6YSoZnyLFBMUIQap6KWmxwJYGp96RQ+tbCkh+boCviv5KV2F9ddu8NJGm/+bRXz16dIMnuBj8kiM61XfuoMcQErLSbmED2BRqLe9QcHvlfP0CY50zXueni+CB1aD5F+oIJ4ev4nsiIyfDKSADwX/XugLKkHR5Piig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7236.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:48:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:48:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: add bpf_skc_to_mptcp_sock_proto v13"
Date: Fri, 25 Mar 2022 18:48:05 +0800
Message-ID: <56077cd2ed2324d5b9f9154634e1acf869da2311.1648205259.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:d0::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c04b23a-36b3-4bb0-4711-08da0e4cf0f7
X-MS-TrafficTypeDiagnostic: AM8PR04MB7236:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB72365941CB07E0CA3A6A6B7BF81A9@AM8PR04MB7236.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iEIrJC7rbxbo6/NkIOnZt4BFlRKC9ayjUBxQn68XUqmBhmPjhu6rK6w4DDAviM1fA4ajvFB2hEA2O8T2IFgXeImEAXUrSIBPwX9zzeD14QutYX8gDkT+JJGMuBXFsB6fFEN8lzQ/eMwxQ5EDmtfFn5t0n9Ls0NTILqM9fCqqmYfsd3CbLAS/P5l70rYfREb0UrvTpofS21mBiRtYRQleDhVxJz03Q86I20b8A3ONxXFamnMIuRnd3PZi+oGZtYetqpOPw7tHlphIJE7J9F3dMjBVFgMS0SjNTM++29ni+QO9/5URHXwfeKki/VYwPbjOXELsE6szwtmgKCsax5fFlnu/EtVCj+FGo7Y6+oKd5S/OVFRNPKSWCiaMUSK873xUvvfovGK2ZKDvuByt5Vx2dVdv4nkLlwhCepbtONbrHStA80fzXXp1Vl/jKJQEeeERqv3lsuM8q2+JUtWX9ar8etfEw1GJWL/7puOYckUY+ocBvtRITfxRULyxlnIUtIJvdF/cf8ln+TDOZkPosLx7sXtnHAgMRoFxJ0/63Bn28PhtoQ5XsiHDHDCtYTaigwGwf8ad4Y2ftQI5waW6LM5P4yFU6mfsDPwxg6T88Ow6F8I+zSaDuwni1ARNwTtMbjDqaLFsgAjHjkv35B5g3jwv4wf47RujiOzq4FTbjiYtX3CvRBS4iHzoEVF51IaRMlckZN395fQYdvkvTuEo+RKKWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(4326008)(38100700002)(8676002)(66476007)(186003)(6506007)(36756003)(26005)(83380400001)(107886003)(4744005)(86362001)(5660300002)(66946007)(66556008)(2906002)(2616005)(6512007)(6486002)(508600001)(6916009)(8936002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7HgeaTm0lAVyG+jHRroeqiTgdevm7HqZReC5goglQg1PEbAnsrARxE/uVpn?=
 =?us-ascii?Q?jGGqA96k8/PQVg6qFTP+Q8zR4sPaQGFCA/DFIkKd+q8SHz1KSbZTw7ehif3h?=
 =?us-ascii?Q?D5rEOFkfIgc97A8NyoRer9q88POGZT3lV7MX1cAiriRH2j60dRHMg/1D7z8V?=
 =?us-ascii?Q?rk+Gv2jIrySjF3Z2bJoDStNEyQ+mD8r0sEkxbJkyebi1GBOYsWa6Gg6tsdhB?=
 =?us-ascii?Q?90iDX2VWlrZffYCCZfYhxWrSqIe8v0AxEAK+N4Q4OPKbqbj4FNb5JN0rvSO7?=
 =?us-ascii?Q?eprY0acz4BZYh7UkiexOL9K8Tl9IAgWdAu2ZqnRseWPaMfjUDJVsrHJQ4LVa?=
 =?us-ascii?Q?n0t8/uQGPBSByy7NZzWkSvzxb8DPFfMJyhFDJXfOFw6TeKOj7uEOw7S1tHCj?=
 =?us-ascii?Q?/u4cbxoWfQLUNSs2OrWTHiA8+NUfecQNlXSGPrUWPkhMEeZhwcBvIjh+/mcG?=
 =?us-ascii?Q?SZsYqq4vyA1JJ4uMmOpAXcZdi5hKCx4UBleGbqjm7SV4xCkZVnkRe0NX6kpO?=
 =?us-ascii?Q?af8uHwk25yKAxCNZ7E5yWks7bejRE2gHuDD52XbHVkfL1SbYRSTkzPXT5Ah3?=
 =?us-ascii?Q?mcDW9YlwVH+ayXn+uTicMybfMkgEe0al+OInZd4H5S2Xtt+3ZQEQrbr8QIao?=
 =?us-ascii?Q?+5NacmNLmgIIy/0Rn4k5X8qv2oiKQ/2w2mZO6BY92j5lMNiEP+rmjn0kyDye?=
 =?us-ascii?Q?RAM+VRkJxEYH6QIzlbbDUCW0V1+Q+mKh8PPQOYwg3sY50uXWOoA71kLNkQpR?=
 =?us-ascii?Q?KuJM2qGdTkLc2/uOa6JjB5WAFEdyNJw7yBOWsYf1zmcCXvBrlUjy42FSo4L0?=
 =?us-ascii?Q?1CUn7exvmX5Jye0mNyKgAoBCM0JfddDbt1ctSZpAsgMcvF7+jnRrTK9VEM7V?=
 =?us-ascii?Q?EEihREtdJu2O0r6EoXiamtnNkIRfCRzg2pQg44Y5qRUhf9VXVv6ZoN5SUjf5?=
 =?us-ascii?Q?H3HEtLWEnm55Ers4zF3Cx+am0axW/38Dq35HWin+SnlN4+KKb4BfeMcGssp6?=
 =?us-ascii?Q?VXkYFDo8V79VNKo36yLwvUPg6Ctz0a5CiYS3M5zqY8P9rkozn7bu/nBMjxoN?=
 =?us-ascii?Q?YeJ5fd8XO/pqvpSoT9sTsWxBFDRK1y1APW5B3AD6xBOoMXXyIzGoBFXyQ+aG?=
 =?us-ascii?Q?NBIyIez7dVpSNBxQBK/xjaHCipaP0xbVHImd6o68gGaURwSOEbHlyJZooja6?=
 =?us-ascii?Q?tmzqyNw18FF907K13q8n3sepv2rcVTWwPqpN1f03D+MFxKOhF6Zhy2SK3rnQ?=
 =?us-ascii?Q?ekwqz0OuMiDhdI5jl3mkVwYIrzQMPhokIl/j46iagqGQduOjXNtNMO+j3LO5?=
 =?us-ascii?Q?0/mOYpVEuMToeqaemNfAzSn17kOOUnjJ6BwNMHQu5L4loRG9D/0FOgUOmHyD?=
 =?us-ascii?Q?N6YNKmIltZ4FlReBuoDhoQExE/9GlMSyQT2ENsgr/MwQe0oCQAWH/Icdmuqw?=
 =?us-ascii?Q?Gk5zE4lqIOrvf+1FzK5+GfgVRwQ9PE6t2MHxwFNZ6ISgIe1GrD8i8xITii0f?=
 =?us-ascii?Q?mi/HrpH4+mge/6mEpquz+0jk6FA6Zrjhs/UAuXt7o9Hrjs71KbK64W32ifrg?=
 =?us-ascii?Q?0GIszQQkI3rDKy2HBww8MtWQ09vwRH65BdbHjugzqeaye5332d3Chfoeb1Gk?=
 =?us-ascii?Q?r6sVINet9RJIcPL7TW1QtTnv87Yoz19JJteDPhkDCOrI9fyCq1tqTLXEYC1Q?=
 =?us-ascii?Q?8MK1pClVYUjHCZjfR2EN7rLa6Q0C2+SIxT80Y2SHK+WQLnq2cMJtVjckBiX8?=
 =?us-ascii?Q?nWUgdYeMgZfvYNv6gQZLYQqdI32KWjk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c04b23a-36b3-4bb0-4711-08da0e4cf0f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:48:05.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvbnokwMXJAmV8nE6Ospd9gaiM4pqYaUt18ijMkXP8xWAeRUpVmb14Arg6tX6DfVLMkC/r6z/Yd7TIUNi80bQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7236

Put 'struct mptcp_sock' at the end of the array.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 scripts/bpf_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 0e5a9e69ae59..d5452f7eb996 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -623,7 +623,6 @@ class PrinterHelpers(Printer):
             'struct udp6_sock',
             'struct unix_sock',
             'struct task_struct',
-            'struct mptcp_sock',
=20
             'struct __sk_buff',
             'struct sk_msg_md',
@@ -634,6 +633,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct mptcp_sock',
     ]
     known_types =3D {
             '...',
--=20
2.34.1

