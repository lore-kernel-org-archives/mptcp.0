Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED67A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 05:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4/0x/ll+Pc3x0rPR8P6cLSx4dK9sVHhHMLxVDq79oq33EW5spz8O/CUjOHVlP5KZdC9G/Y82dusJbHmBwDzATKyQWDfKCpfk1chb9Qk3KORSGaR45RyGesVaBor2D9Bx7SqcCxlgewBV2l8enIJZIKyHepbhGTz7g3SaVVigHk6Ipsd78W0TM2yYB45cmVui3jXwSk/h5Li1NIbnngB0fRCnRoSCoYpEOyGUG6VyKLQsQyFVcfbVZ1ERJUQL9rrb39ntDgDEdDKJt1B96A/6uQe8RRwwT6Vw3ngGCd+gmvWQkVKOZSFY2kFoi0EBQLdXMc/mlnB8C4VTM9205Cc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdUQ61vXLUrRenZnksFO3mIPsYnrpxYO/+WT4Li6shk=;
 b=Jtb2CtR0nJqWpfUU5jUPNIuBhBKv6+nPwMt4ewKSxBe2to0J+x1dvQYhZB+yOeIIed+WF4D//6eMXTvm1+7abZ+str5zJkkV3Hz6xfX7UPCCfjC9cGuY6EcZ2Rq02nA8HV18ZxZa5DCugejvGnAUIgNnrx4GapI85lr/9mXdAHOIqGNiCFp3YQdPrI1pmwEJu1+Fr12qgkyh2WZeoI9bvOke+zqIC5tpiBZadRePWQzwZKmFt90eRiZjexnAjRxcndpbkK9yCCTAxywEa3JQO/51Q4xwJvJL1j/9IdZFoDMl1fmeBVgG6qlw8T70pL/gXfSG2XL1l2g9JebLyGkQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdUQ61vXLUrRenZnksFO3mIPsYnrpxYO/+WT4Li6shk=;
 b=4VdKlQsaxy/RfHGUT4YSUWk1KvVwSRJYbuZyKdht8uZXx/8IKpkNMtoaqu3Lgj2lBWK2+feZUERuEyUtkL81L9k1MI/gF1Ztyv/Xw9FBgWKK5mDliVlWbWwxxClCn9A7IfwBEHgOOCHQiiEWqBThLH6pTml4sf3PjoOYOvOEtl+3zHIHR/ndO8QTp/Qdg3hGaYjq5nN7ypqdapHzMAxnx5g3av+rKsA7lWg+vCvoXUBo9526vbdeJigkUblZNmjGM1kgMDJROY2IVxNd7SgujGN8faT72Yshhh55YOn+nZ5wr4zI7vJ90L7+Crfn/OofY9B/Fq08TUVUrIEJehZoow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4720.eurprd04.prod.outlook.com (2603:10a6:803:52::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 05:03:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 05:03:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 5/5] selftests: mptcp: update pm_nl_ctl usage header
Date: Thu, 16 Jun 2022 13:02:26 +0800
Message-Id: <11468cbfc4fc4ca766094b81c544f9108e04daf2.1655355422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655355422.git.geliang.tang@suse.com>
References: <cover.1655355422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5d3a58-6a8d-445a-33c5-08da4f558004
X-MS-TrafficTypeDiagnostic: VI1PR04MB4720:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4720695AD05BB0FB354B8632F8AC9@VI1PR04MB4720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1N+pjp0voWiestKoVWRrFdvxzBWFgYNMBuXB3ZPTkTG9HfyLl/yeIeTAomXjbRS3ZGzQiCJiVOLTcO+rbnJ/NXulmX3d0yEMdOCRXso6ur3P52Ncpxb3rD4RoK45BK5Jyz5AVZKl1AIA8BeYtTKz7Y+pf/frUU1OcjmqZfQU2P51HL4JxiLQmj/tfK4O6PeBwKSTMDt+3IuOBbnO6m+nLpozEhqFz/oqa/Fdt8j5ag6xYaxCidgr/ZyJLuXwi/HWCcjBAe8+1AbJfKwHfYLMctXhUx3QV1wyBtkbZ1lszHJMvOi0BPJRTzeplt36YCOcBBYY/1e6fZ82WzFiM9cmk+4cSpWCKsEW8DxDx9tvUuLJ+t0q4KuxseVB9nZxXfn/eSosxtxHlB5M6EChlNRVWWpWwnWTHThPMi4QGJttB9bYM1csXnuklLqbpS9gltwuENtqU2TF7BVB/Hh/ETGN9IH9Ra5AMzmUD58Es7BauTeNDrHgGaBeo3bC7T59jv1R1TcAbWA1UT3yfj/lJEXATLq5bvTiva9Co/9LlCJZg26Lf8rYKFEw0l8YMMEQZ/h2cw0nmyGEnmJtdXGbALJwUzdidMSmzDktAb6dzvo2ZzeSnDnoHFFIonDQXjIx6ssLO1Qgb0FDzmPrK4xEMI4lSqh7T+6p3ULFtlqhe3t+WArpEXGsZhcf02BpmlhmjDjoIhz9jqmFdIFUZlq+OkU0uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(6506007)(4326008)(66946007)(66556008)(66476007)(2616005)(6512007)(86362001)(2906002)(6666004)(38100700002)(316002)(8676002)(36756003)(6916009)(54906003)(8936002)(44832011)(83380400001)(508600001)(186003)(5660300002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4oEKZ1h/x8PTW2+jXIwD+Uyb2LAwOnE5uXl3InZ3kERWWwdSWHQNVqcZZNl2?=
 =?us-ascii?Q?dJE3dHkUidimHxDTPlgFE7GfwpRoxPqS7z4gVwrBnPD8gxUc8ijtyKUtdr/W?=
 =?us-ascii?Q?NylU2HQpXzdtGp/4muLMwTgpPssHRJFl/WVZ+0iuLbsVgW7rwISzbjo7RB2Q?=
 =?us-ascii?Q?W1R0hgKHqgCKUdEaOkmEoynhnoQqTjK0KFsT4HUwSuAVDPsDJBNmcu7vQkb6?=
 =?us-ascii?Q?PtnGzuhcc7rWxsWU+xAOKQdMN8pE6DZDawZyWunLJRWvTZDzrkA6RoLk5TAm?=
 =?us-ascii?Q?8AQnPleQL32sHBtIrWvpz+oKbiu0BITYGXHo4m461M/tL0x6B0gKUTyCaMQ5?=
 =?us-ascii?Q?eLfFldhr8dkckKGSTmOV4Y843MmaODFOIExbRmycWYWcEEcto/OKgxX9MknG?=
 =?us-ascii?Q?vWRHXAQMHdFywstGDRVqo7sZeW6kNg/vqyMlaEL21IB1I/N6+55r43Fxs5BO?=
 =?us-ascii?Q?z7utpxA82O51uqjC39dVg8N/3cDv3h30OUWYsoNIGni/vSI/qMuGFvbC3KXM?=
 =?us-ascii?Q?X6x5wS46qlJrLt9SHj3TJM18wOVmgR8nHiNU4MRN5RvxVZhcww1t1ch0apIC?=
 =?us-ascii?Q?aAUdlrkTL1YsASCkQvi9Y8tK3s3ZuwMSntwHg5O2gNi7JrANwMj6BXl0sJkg?=
 =?us-ascii?Q?YPowVFD8QsOZgJSS4fBDwc+pQxmf0A+pi1Ua3f8i0cfA9Z0N7eNBDb6vMbP+?=
 =?us-ascii?Q?7BrlfiD5bsSPl1yfGL1ISL3UXtbrTreUipc3pvPKGLS/TDvNuNQyGPMtT2yB?=
 =?us-ascii?Q?JOzjmQ+zl0kqDejAx9AU5ViinVgiY+F/kkeDjjqlsRzmll49Nyi5PdTiMiRS?=
 =?us-ascii?Q?hf2z7SASFHyCMsvdq3l6ZX0V4RHhHPwCLPt2Zi1PZaPStmREfBmXNUVV0r8z?=
 =?us-ascii?Q?To4vZiCTd1VUooNlvLRR2Nvu9xmzMZN/wLP2ZePeqUj2qUMNR5TVSm6k33MA?=
 =?us-ascii?Q?yS1CwKA61pWL6DavlXkhcwh9IxGLejcNoz7FE9JtUyhWjD5lXYkg4yBNf+pP?=
 =?us-ascii?Q?FMhGvkaSh2c4zd2LVxeawN4+k+aCBChvq+nvZ9ZVVA7MJbQGaaUvn3gEfjCa?=
 =?us-ascii?Q?kKBU9LdaGYWC/zHivtWVZvsEGx8Rlh5ohe9AYEByi9R3LCEas8MOVIFvKTFE?=
 =?us-ascii?Q?nHfJM59s4dj1r46jIUlX9qnijL65Vhwba7kqj3lyQmR+oBbNN3Rz+owFLxOx?=
 =?us-ascii?Q?3AO3aCg0Vqm1XhyTQjYGKs86/4lynE52HDRGL9x0yG0qQA+2lwFFvTFovh2G?=
 =?us-ascii?Q?Q/pIlYmH5OR2Sv2v55u7pBRXi7Ql+F1frKvfYXrpMQJYFJQdyF6jpuGxLzZ5?=
 =?us-ascii?Q?2xg788PS3TWADgC6lXKsNGJPNcZ4oo/BRN8pjWfmiIpJbEk9AmnpCtQditN+?=
 =?us-ascii?Q?n18ZJWoh9QXQ6lsVA5xXWaQbWvN161RxeN0FOZh8Bz4y2aguyhUmSCqDyzAR?=
 =?us-ascii?Q?IxV3k++57nV+m9aym7NB+TbPXTgnMM1qqVTWK91t9mvIhzWRU+rb7lylh8LZ?=
 =?us-ascii?Q?4UP/U6tRsYmLWDCbZC1uGCc5tA4c5/fhOFDKAJysAS6tEI9xbcCmsBqENicW?=
 =?us-ascii?Q?yQ5+oX9tSQH5H6kWXGVwJmoxYBqK0QUtHfH3CTlEOdVnzOYerBq08WhX7oLO?=
 =?us-ascii?Q?c600Lk+/bilmVzPCQvWJghVqGkyI0EnXwbyHhJB1fh/PrjAiuo1E7B1TPM2z?=
 =?us-ascii?Q?+kzEzWaYaAZt7w5ib9aF8qcQe4vx8cFyqJ+cQK9+ak3uCxpV8hj9Jbk3mZZl?=
 =?us-ascii?Q?pCJJA+I/WDhn7Ordc3TxRJtNfY7gV40=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5d3a58-6a8d-445a-33c5-08da4f558004
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 05:03:06.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHHKIxPa7z3vNI2Jx54EcfecYJ9iz0f5sSRJeMMaz0xADYKWuX7Rt3tXKBgJVeNPVccQES3BAxU1Ui+ea1Vy+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4720

The usage header of pm_nl_ctl command doesn't match with the context. So
this patch adds the missing userspace PM keywords 'ann', 'rem', 'csf',
'dsf', 'events' and 'listen' in it.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 6a2f4b981e1d..4dd87bb9ee91 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -31,7 +31,7 @@
 
 static void syntax(char *argv[])
 {
-	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
+	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
-- 
2.35.3

