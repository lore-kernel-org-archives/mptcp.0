Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4F2C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQ0sAmxrTeBRiEUAKTQ7azpH3L12M/z7/LA3EPHzpQY=;
	b=Fum1G/9S0SkgbnuIk4b/oZIyBP1PPpcUvoqbWNURs3EECJ7xjBP5ErB62nTqwmQoJlDuKW
	FcV/5qdauvL5Be6GGgRNkcgQZec9bnRE2Kh3Sgx5fjBsqvN0yVkC+sOEvG4xXTw5DT2hkh
	pGxyrzqidsZHqumOQ+u1HGAfnES+If4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-31lfSzJNPJiuviCeHDioCA-1; Fri, 07 Jan 2022 07:17:54 +0100
X-MC-Unique: 31lfSzJNPJiuviCeHDioCA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuY7hCjbnjwqUXDyCemV61eLXIsbYUKIWfLgSUEg76SUhgGGXJjTNdhDMvH2Sc7X4ojWRQCSxPOKz9R9sghyTIrLGR1l+BVIqpmvMKtGV4mD9ElsxkeyNXHa+ZeowM6P+U/TnDjxuMF+YI0U9K6sD13vDuS/Kx7fc2E6Y6a2UxdGOVzgLUV4jYLxQs2IGy+XqlaKYXvJgOYe8/aaK8jE91U+tUbJV843JdLI0NvlWH2HEjhI7LLevAWz3H2RQ2MpvpLB5uq1QO8JF/LqqA7jYSu/DG/2ZuR0v+Yk/BmtS7eT6yJ2GdjgYW2nqXkHGm8Iz92RgoGvwzpWEfQDe9bIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfjg2K9ih6223KUYzJQpYSDfM6o0E4/trjxZvmjnHrQ=;
 b=P5ceAXFSeyh542gF7i4H6hEELT0AhCTbLhkeveIEIyGYrlPc3GucfeoZY6CvzoOv3O5NTVAyC89fjoLTfD/HpkqrevqJjMTf4IlbTuAK6UZeEoI6QgzheSHpItV0VZefP6fuSDOtDepcI19okY/mBbfN+1EX9HcLYkxQDFWt1b9U3xwGDQUQgOREs+L68EgPvWhRc8VPRxIFcUr9JD0UrX53GrCfB3ExdVJIOUXqg9UxMMWmvBLg6KKOj+j8VPZ8gQkVB01LKETIUgkvbldPXKe64E6LG3S23WhkIz5pkurEeVMwpmiEYpKQq51s6ic0jaGolYIMWFsf5rRRs36+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 6/9] selftests: mptcp: implement pm_nl_flush_endpoint
Date: Fri,  7 Jan 2022 14:16:58 +0800
Message-ID: <62c2e9c36e5de33653ffbaf3a282c24f46d6f873.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c23363a-d8f1-41b7-1b0a-08d9d1a56fe7
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB336993459183797D45287A08F84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T/J0kPCQwBQK9D+t2kVNF6q+z1MyRwSRXsY5CfHptqtrF/x/e6/2FEKl1MAXdTwfpPdteSMRRnHCFy9Svckj2JSJjRAgMwRXsjXUUD63WjyTw/SYRVVjLPPPxkR74XdHgX4tTMdXBGXQrUx3hbjWWlIN361Y9ifNASqTGrT20grpRGW1J4kjgwFytLvfAQEWncK7P9OfD5EVcIOLE0JB9EN8Ipahhzp2QFTT+iZSHY7OEgYavSGSTU5oDbPmSIqgxN5GE4F0wRUSTUwvJ/F0/gntwUuT+xLMAaCBd+CqUXUxT6AXzKGTIbqD0sGPepgaGfwvUCC7DGi/2WQwFlQDZ+pZLpcpfx2z1n1uDgvHfk6pcAbN0Ra3KmCCy62BXeecL+/XSEPUjbGfuWsU99qa2K/y9YEY0tsiLLBVV5A6I/4nrlFz+T6DLUJZ9Z1kLaiEx9DB1k3sp3r+Q1y+lDZpHeRCEWAFQ0hIQyJvWvdNdpndjcJvTciQhszrw5W3mwRuKs6olYDZDUgTn4NEJfXT4xUIBKFiMuCDZnpEqjsT38IELfTYkKOx85D2PSw86Xh8qASqgih8Djva04NLfAkKk6VSDIbQ7LsZ34dvshAhJPlUL/DT2eKKL0JOOYPXpS6uDG3ips7ok4LNtgS81RxrVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HBm4LhhxSgqVi/ep7Fp/Fuw/ZqCZ07JoOiOCCDtkDEv07GjdhfYKNnQ/minA?=
 =?us-ascii?Q?1dWojDn93X2R1QkHCDAsgesPeJpJ+xrxgrETGr5ZyQsxOOOTwFKBU30/aQpS?=
 =?us-ascii?Q?TpkQO/m4x2+YxbhbtCKa1czoLY/4zcj6Bd2Dh9Ugm2rt9/YS7K5U4ixrTqLB?=
 =?us-ascii?Q?GjY0mZc/HKfSHOtelSEAm4u5upR/wF08XDpW7stvnGlxniu4BEOfosU9xRfi?=
 =?us-ascii?Q?MG6xLwWeiUfoaRbxF0oZbp4Tk1XKfxi3MjkwxbtLFgyjxsuUm0gatxwfe6rl?=
 =?us-ascii?Q?eKyA0OUsZdNdFKTlq0ypm8K3eqNxFwIUA7rJoyLhs27tiJOT9zNqvImR+E2L?=
 =?us-ascii?Q?g3Qe5bryKx9TKKMbrF5hLsyhsXHV8rVaSDdJhmrwvF2AnQwU6OzWUaKPfFE4?=
 =?us-ascii?Q?4HeD+ypM+/b8+8Ul1GDPZ7+k7YfT4cS/hW6bgdRrKZyIjQwmucJAQpVg3WJo?=
 =?us-ascii?Q?a9Nlm4tqM9brfwoB4kgjuypfZS8AQAdy42l2UCVDk4Exd6J1/In0FKYbwLo7?=
 =?us-ascii?Q?Wn89agzTdqahpdAthuHpnDWJhyZgvkV7EfgsQGoQB9knU6zl3y87UR+VhvN4?=
 =?us-ascii?Q?hcdNXgKOhx1xG91doOyV7YRcIzOv2yDWWIIWrLRsHD7TMMf7WmKyYLJqNzNa?=
 =?us-ascii?Q?thW8Ul/87ivH2gn7TEkZHP38sKNF1sZaEyl7EdFI0hCyQTbmD2DwAEmvSmxs?=
 =?us-ascii?Q?/kMQkra67cDnRAXmD5TCTy9odKLViOvfXO/2maoGDQNu5A2w5ksnM10/+wib?=
 =?us-ascii?Q?86gZSsvsh/G/kLFQyX8FNbVBd2Q/bBzCyCjXWKBcwNQmF7QvRW3iS6ydi8pU?=
 =?us-ascii?Q?GepVuxPbTlS0IuK33hxV0g9SjgiR4EWaSEAwg+P2C+qfwXHnk8kEgATkv4i0?=
 =?us-ascii?Q?ziybxbe28BQK8jhoFHnvx778TRnGXV9W5ePiIicxNkgaOphWU9pXnU05CMmb?=
 =?us-ascii?Q?saD0uMRYuaw5CEGirJchfVkRRh7jx4+qDKRcLrvaG16aUFZiT2DNu8wqcU6M?=
 =?us-ascii?Q?x8r0BiOPh9siT2w0kfvx+9OIPLkv//2GnZi7jnBpxAC5eyrC+kbebp7faHCX?=
 =?us-ascii?Q?4DY3v2+LC4B2dgKyx4lpzPzhsp1XBBhxbtxdxNVrsj+8ztzyiJI1j3SUBKz7?=
 =?us-ascii?Q?w9G8pXL5pqjiG/HW4rq3vdbefNfvDs9cioD/jmhOsJj9qY7rCyXew8rXId5S?=
 =?us-ascii?Q?FNqOGN3qbYHv8cGAmmAa+GcLYoQwfVlINKXtDRTKTD6AfWDVzxrSiFbc8BGW?=
 =?us-ascii?Q?00wSeWt6JMVJ/CiYe2OeUI0fK3XVxMKKGihi81twDOt/mcm4MJ1c2drBDFD0?=
 =?us-ascii?Q?gqqeldIuQMoOdtRNivl+eRJAOyn3bgTwMFjLnYoCFk/y4oEXYARkFu/w40ys?=
 =?us-ascii?Q?x0T2811RKprt1zBIJ9wFXG+maeT6/+2nkJA1XujpDRVfpJq6WQZG9cRkaPwJ?=
 =?us-ascii?Q?0xWCD04eVtUp3OizKqgWbjmVNh5tPtUXGUmn1oOOb/BJZjvlqOEhdNA9uJcX?=
 =?us-ascii?Q?04FIvoJz1XvXpvu/g6q3m28ZHHyCY2P5NHv0umNQkiueY6ELQqn0wbhrrbpI?=
 =?us-ascii?Q?1CNXwK+Iuh5bJ85oVb1eUiLlXSWPP/HB3NjA769XkEGIKKsUUW8fwizA5eUH?=
 =?us-ascii?Q?U8zQcJJ6y3s/qqvxbiwzWZg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c23363a-d8f1-41b7-1b0a-08d9d1a56fe7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:52.7799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TckQ6UdwwJpz12icaQfkQmmjkPNE49pB9i7R4yWGuHJ4MpG4Kw3Sue4bpFgG4KoyRcDwZb08jQVrv3ZpDuz3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

This patch implemented a new function named pm_nl_flush_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use for flushing the PM
endpoints.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9219962291dd..475867a01b83 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -352,6 +352,17 @@ pm_nl_del_endpoint()
 	fi
 }
=20
+pm_nl_flush_endpoint()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint flush
+	else
+		ip netns exec $ns ./pm_nl_ctl flush
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -479,7 +490,7 @@ do_transfer()
 				done
 			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
-			ip netns exec ${listener_ns} ./pm_nl_ctl flush
+			pm_nl_flush_endpoint ${listener_ns}
 		elif [ $rm_nr_ns1 -eq 9 ]; then
 			pm_nl_del_endpoint ${listener_ns} 0 ${connect_addr}
 		fi
@@ -534,7 +545,7 @@ do_transfer()
 				done
 			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-			ip netns exec ${connector_ns} ./pm_nl_ctl flush
+			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
 			if is_v6 "${connect_addr}"; then
--=20
2.31.1

