Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A280D
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 05:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpU0oz8uapu4Ed39vjPMSbGttpvZmxYGTJil/RR12hFjTD8FkLjfIUh67G2pgOslrfPTR7yBw9XOK5zaxg5Yo/YijPGVoyfz5t0gPSs/eX3bA+wx5FfaQiM7nCh/kI40WTN4vCo41siPYgrRZJVATqtUyfccYLhAhJLcYas1tAAD04N4v9K9GDto/gW+5hZgI4Wv5h9GdCo4mpb/gKFXQOduaAu6ZUfyCp0TIGkX97GEv2yTs97DvYpwwmPsqc84UrW4axsLtXkMcSu/qtgmnZFthqSei+GdcV+G/m5ENb48JDAANcs8N0vUEoj16QstrWfLsKdIjnAmikx0p4W64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4xY9wNk3xj2xlI53EinXfxcC41nNGntpzbO8P9AbzE=;
 b=gcMaYmgRf8GWzbAISCCAoCO8cNa2HbKh3UHXOjYJccWCcwK1ltaEapUkrrW1H5I1P9YoTVvS1SOYBMlrwphobaKD7aVgUlRnbqf84CKxCO7TGS6SyVQjeZXCGVOBTcPLzgRQQddawzDxBuMo3Zbfmbf76tQHFSECVpPemJ8xfbKyiQwQsC6IAvI+B7UJhE4Qf2yKPtHZpEQD4mcxOkeIBgd1XMvDwsrwEU+/manDAjj21jRg9kxskDvHpTQqCbyJeklumIpC7c9gNpNVFTBFOwFjWJrLEO4eeJW7R2eTq+stjjGvczxAusSz9EyRt3g61yheohesfGaYK9wr61PvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4xY9wNk3xj2xlI53EinXfxcC41nNGntpzbO8P9AbzE=;
 b=KLtmBF3POEWZMkZST0AMPPiM6qjXtgeQITYAS1yzMs6QWmSr7i2DVh67hv9jNATL6w+Gw6QK6Ki5SNLPlNL05pL3t/QBc8PxlXZw0hQAhaP1GcrXF7a2mGCZusiro6fPIi7G8JTHhJ4gx3LKoSjucN4r5ZJNhTESKs/2zertxc8HeOMMcsz97cipF5WnjsuTIpGILLYOqcr5qswgMO9gkhL9/WTF/uJxJFsmiidYY+GdHjahIEPd86Yy2/fmuNjyY06I9qoRAQCe94sANS8G35nrYUQAAt5aTc0bfFZCe1UbcC97RiJzPaCMPoOsW1+tXojcgFav3LJZSPEc0SnpEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 05:38:34 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::6480:1775:c36d:b797%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 05:38:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: add id argument for dsf
Date: Tue,  8 Aug 2023 13:38:26 +0800
Message-Id: <4f105c7c700ef0c139c1ff5e7d4a5d844e3d06a6.1691472939.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691472939.git.geliang.tang@suse.com>
References: <cover.1691472939.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ff2969-3147-4c1c-a1df-08db97d1b515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	setLw2IdsytiNZt0sKy/sF2ciIYT3tOql4fkH2UeAZOszubeUG3YQGinKZgn29i4U6cBlXEhdDViEsUPm2+DQJqtdAc/30VT5xPZ6Pkel/OiuoHTrbAW8fMhMN29Zw72ZB9CbDHEgHHYsahbJAeIeHXrzDHQR/+SZv+/jMCuGvNCi5gtcauIDfFx9HxOw6nwJGgQsLtf/fqK73T+EphYCR4BR7PGJcjehxlSNJmV4QIwDLr1Ilxo1Jk9yTnAv0u4968tbHmsnnFdkjD5TX2u/1vaUNNxSqaywVUjVZa+GChS1O9oaPmwnwYks3PvIHlRiY/tfho6TtH8N5Qf3Gqojc92pcIs7BHBywIXIRXl4oitoix9nrtEDHaNwe6c/7dDXolNo934fNhJvynX7+NMuGa1rXoX5fIgGjD83QFoKUtgZKLGQWCSkbyYaRJ0DqByLHI8VG9Appj2PbObv2awL7QxJRptEgUKKIfHYAAkZnjeMpGNhK2TvpW6OKiFiofN6JwSMWvMUCMbwTo4kKE9GI8QHr1bSfyx54M4DCySk61G3VJmye1yjpuPbMD24Zs6ueyrR3HCohrP96AdVh7ct/ZA+UM5jM6QQ7igEXP0U3RBZOkkTP2jl15NPyVtvBBTb/4cZ56M7Vu4PPimyv61cdFdcgL+FsE3T3v/E7J1Jzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(90011799007)(451199021)(90021799007)(1800799003)(186006)(2616005)(6486002)(86362001)(478600001)(6512007)(26005)(36756003)(6506007)(107886003)(41300700001)(5660300002)(8936002)(316002)(8676002)(44832011)(2906002)(4326008)(6916009)(66946007)(66556008)(66476007)(38100700002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHu8kEVM4Og71jR/mDcCtZW7c2A2uM7Fu136yaWknXsOmlAUTNuFx1xuRJJT?=
 =?us-ascii?Q?S8N8sM2H5CMlqLlqjwSDmYry9yiAMklCnCm6SOBCO3q8pk7bFrxOvMRIl6MT?=
 =?us-ascii?Q?8YbigmmHAby6/LAg99BHsYHIzkjzPoRkOE+RTpIhwd1WUwvUD8+wu+zChF0v?=
 =?us-ascii?Q?L97D7cMp0nWRZYxgoyBeFc5zOqP0aO+I1aiD+pVk+eJKUBHYvP/7eaW5c86o?=
 =?us-ascii?Q?u/JKQracWLncFcvEvjjFPYYiDZkOLYLCk5y2N8Yd+XgkPfMkP7spnO1ldw7E?=
 =?us-ascii?Q?EOUUCGGeq7Zv/5qrAAZ59jyAjA6ZM4+D7MB57NhxFnzCiMdfXuwos1E7VDA8?=
 =?us-ascii?Q?LrI6kEBxQVbp8USLaaCi6Vj70f1hkjBOfzVihk9R3lWgZ5KIW6E8r0h9Ro+a?=
 =?us-ascii?Q?Xr4rs0lE3MFr2nU2CE0rksCwQOi5fN86h+RPYFzqT1ObY4KRVfNhdYYGH7CO?=
 =?us-ascii?Q?Ld9iKHfh42LWOoCVZ+PaxMbat8D+pX95fMD1CE8EXOXc/VMFLmrNP5vphU0F?=
 =?us-ascii?Q?HFxn2o6ZGMRcXgdjdKuvVaddKvnaRyCjTtOv3rOI2LW+Ss6yW/XC9idb5F8x?=
 =?us-ascii?Q?iPIKFkjS0vNIkuuCq4u/oq8puPDmHA6HZPmRPwnkXVzxX8sFZgGF914TmCyA?=
 =?us-ascii?Q?SrZIOWS9+EGJLMSW0JhiLaGBpxNNPhBBA945sCGsRRBBDC9Q+mkKxLSy8TDa?=
 =?us-ascii?Q?qE/5QurfhdKie6kkpvnXVBJgmtJWMFh8zE9OJkq618s6mY0p38mGIKJZLTyw?=
 =?us-ascii?Q?+s9WLP7X4iSfyVtXavkdMIXdZxgw9WQ7UJ2a7eNViE9oCSjegk1CQXhATun5?=
 =?us-ascii?Q?x1gn8TrM0yZhzKKzU1LdGXQwYhbMK0DUozW9nB+DzAiDodcFDoTPabjQUXlt?=
 =?us-ascii?Q?SH6bUuNxhgTDm1K7qSgsE4j5Ga8aCAH0LSN2cJ+z51zglAv1aihznIHF3gia?=
 =?us-ascii?Q?si0w6kr8ZaEDvwxphBohcFDMSBKAv0T643+esHzS1jtIArBG6y03LL00VJy5?=
 =?us-ascii?Q?gNdgdIAFaVRudKVOed2YdqM99o9g9+HCvade/Q6PJkb0iLhwxCOymZ4fRyF4?=
 =?us-ascii?Q?/yFghrBx9aqy/fxxXl+P89zIXeLCjfKjoIxv47+Fy85k9GzIIsQzwrMsZU/N?=
 =?us-ascii?Q?WZaXZYJox4CqjLbj5eDp13YPagcTZD2rrAB+6OhjSZzRjhnuA4irkfP/aZs4?=
 =?us-ascii?Q?075wjmKXImsGdmFY4LDSXyJMo0DF8uRqOA7VfdJ9gnMHZ8FBR1UI87DcNBPh?=
 =?us-ascii?Q?LRDRE9vWR7BWq5I4aISfKZ9hRsyx9gzt073OJ6tiD9QbMf8QSsQJSxozSzUH?=
 =?us-ascii?Q?vCxpL8f81v28XmX/pHf0O7Xy+KphK4VchoL60qKDyAHMWp6ofm1rjZlJ5rTx?=
 =?us-ascii?Q?oAb7R79g5nRh8k1QmxCKYqboW3yGLYAKUVYvFAH68lFlxxyOuBCz2fMOVYz7?=
 =?us-ascii?Q?jf8mPd05tPFrKiVS829NfJBN/yQseXRwFTkl5H2qyq0skcTQ7B8Qq/lnm011?=
 =?us-ascii?Q?IVdJfvrnWPy0qzH7bGzHcwoSbMPJ0AVkz7mT1Y5pOtPcDSP/D852lHCzzOxr?=
 =?us-ascii?Q?p41WdwH0l4M3pHTDMF0/VOZC/tyKUJU6du8WIM5M?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ff2969-3147-4c1c-a1df-08db97d1b515
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 05:38:34.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwP4egQr118YvRA1xaOpq8rIO4lkVaxMmSs1LmWo7jP80TxT+XXfZ5hbEp4GLpWaCOoKYUYE/TZBtB3zcr96Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

This patch adds a id argument for userspace PM subflow removing
function dsf(), to remove id 0 subflow.

	./pm_nl_ctl dsf token $tk id 0

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..6e078854f440 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -358,9 +358,40 @@ int dsf(int fd, int pm_family, int argc, char *argv[])
 	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_SUBFLOW_DESTROY,
 			    MPTCP_PM_VER);
 
-	if (argc < 12)
+	if (argc < 6)
 		syntax(argv);
 
+	if (argc < 12) {
+		u_int8_t id;
+
+		for (arg = 2; arg < argc; arg++) {
+			if (!strcmp(argv[arg], "id")) {
+				if (++arg >= argc)
+					error(1, 0, " missing id value");
+
+				id = atoi(argv[arg]);
+				rta = (void *)(data + off);
+				rta->rta_type = MPTCP_PM_ATTR_LOC_ID;
+				rta->rta_len = RTA_LENGTH(1);
+				memcpy(RTA_DATA(rta), &id, 1);
+				off += NLMSG_ALIGN(rta->rta_len);
+			} else if (!strcmp(argv[arg], "token")) {
+				if (++arg >= argc)
+					error(1, 0, " missing token value");
+
+				token = strtoul(argv[arg], NULL, 10);
+				rta = (void *)(data + off);
+				rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+				rta->rta_len = RTA_LENGTH(4);
+				memcpy(RTA_DATA(rta), &token, 4);
+				off += NLMSG_ALIGN(rta->rta_len);
+			} else
+				error(1, 0, "unknown keyword %s", argv[arg]);
+		}
+		do_nl_req(fd, nh, off, 0);
+		return 0;
+	}
+
 	/* Params recorded in this order:
 	 * <local-ip>, <local-port>, <remote-ip>, <remote-port>, <token>
 	 */
-- 
2.35.3

