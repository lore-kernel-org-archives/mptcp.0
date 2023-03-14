Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F32565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcO1bVEI+D8Ip8EyHuzJvqocukgrse7maxedOjxY56wdhoaFVc1XIDc5KWtvaPzHM/EEORLRfq3xemx+FaU5YWaSa9S3N4hRNVjFRdCtQQ5awHmRt4M10OQ/2bxNO97U+AAx5jFPCAfgOjD8+DEGZw+kvXPPrbzjJHRxLKEjacqKHOK9NtzdiC5mD74ys+Cp6beTJ1Qg3V1Fs2JkN4diDIVZKJrvxNBFuIoiEp8uKpS7uVfF1F3mEYvdwJsTzkgYO7DuHmAb6DIaIPe4I1gU0LH1zwZ5/egsnCA1f+23CzwOg8hu2YbkdRY9WvpvVrK95jj+ja99ThmHNaauBonN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwajF9lNBsqY7bvbCkMlVPzjyxa5LGUI8Zw9kn7gAm4=;
 b=TXfZfpw8HOw3cNHMhcj+4yQA0EPjq6Mo/s5lqnuhdZ8mDQ3f3xwjR79FHab9MqUwVrZ4PUTqRbbjNmU5EjfRUn9E0CYxkLmJS4XULgNrwtR2CpxIVKQVeoq0DG6zhAuoNUmo6v1z98/wAJAJf/nYRttAgWHv6NpzdsBfGJIZt/nK4u3vb08w95qZTWZV1+J4Z00itofvV/nVly0DxV0ghrBSutAGhSw6ZQIAuTtDXv8F1Ya3f8jE2plAul3Qsk4YuDtNpMrZwLC3H53oLoc/l6uhQ02BOC7ohRZRN/NRn4bdw2CnrxZcLe/dgSqF/aPS43MfGOBFQuGex0ESXz6PrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwajF9lNBsqY7bvbCkMlVPzjyxa5LGUI8Zw9kn7gAm4=;
 b=RGXK0A1bEdNkg/ccz3LjV4GIXeiB9O+vEvt/m/XbI4iMLFnAuppmwPGmFr8gIR3Ye7/jDAZaQelEe8qWY94OWeq3NL570/yfRDJ1xp1tWnorcapAUIBGiiueOb4YKS35ob84VJqKpjxxqlg4I6eto8dyBLGGgfwzPpIuWUbOO2Kh7JAs+UCI0akV2umgshB3XoFZVVn0z/zueqmkC/Cc2qRe36TMbrC+X5pW4F41R8IS3SSkpDCdCZud3/ceIaL0z7JsqR8mTqxn4mSmpUFhaX0PMDsZihiJBIhyb1tbm5jaAvr7oPotRkvL0CmZBQhhIXuOttNMhtq1W8YAqFoa7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:30:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:30:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/7] mptcp: don't clear userspace pm addr id
Date: Tue, 14 Mar 2023 15:31:38 +0800
Message-Id: <c913793939e57514aa7143d70751749961ede71f.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
References: <cover.1678778977.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: e91be8ee-cce9-4ebe-4bd4-08db245dfee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GCFHUBk0/5ciXbmfho52bxiKfjmOLSGDk02RlPM+buaWGvmRCJK4eE0YqQgr4u9rgVAl3kLgQkpL32shQwTDLDBOeCVX9Xiu+YCFnTkSPWGW0NigYCYjE/dQOBS8/3g1LAJcjn/5MS4jaPwPPPKE/eM/RvcQNIMoziqRSaJm0GUo45g7G3YL+pC9/ZIy0zjB7/dV35FB6ZiDqVomD7xvtnfCWgzYIJIz1KSY9J+eEN2ceT15G3LUTzaXQ/q/xGVAOSVvEbUDYchCYXYLh5Ub++8pOLEr/V2WrURF9jXE6BGSHhMkSG1rjvBTdHAqx7gt51s/GNqRGa70DKAGJhwLJ54yr9OeBA9TEAMFi193++rBY7HLvty+VMNDj8Jfw645fkRr8K6y2oNhxthTMBE2weXrIh2SHf7RlBrJWJUGK/oCMX22BAfnjcXdn0NAUj2tvkH3m8vT+dDEJEtP7F0tyfbOeDba0vL7+ZFK2WSLTo2q4lP8xbZWIG+4iVGz3FUIu3zRyps21M6GTjz0l3t5dVXUWi/1ZMKLAVOui8aiIfn/IX+tbQoFkGWyuR+pp6XD6Z3m+Tu6LciJOOKPH1ls4os2ZNSkbkSco55AxYzZ3r4dh6PNaszD2+YOzb2wsrqTqfLjoKebnIuA/Wjgsm7E3jeJr8hXbzeUrA2ccIkjdgz3wfGC8I6w26F7n8eZU40S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(6506007)(6512007)(86362001)(107886003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yb3hgrrBDmtHmAql2U0Toxm4/7qeZaCwb5P5KFNv6daYfOlpfCCwCyUgA+cy?=
 =?us-ascii?Q?U2B425J8ki+FamrIq4uzpceI4X3ASiCdPi02xxFJyeLIJVjWlfrKlMLgAgjv?=
 =?us-ascii?Q?QFe0Bene5Olb9S4kSwq0f8eyLN34FlQN09LjhUHJVWjALz9+CRDiZhbFqWq1?=
 =?us-ascii?Q?xDLEtbNd9B6Fc+R2Ds1cHRgzLU9SuLc14SI7tVhOI/jFMcU0P2qyukTtuGxU?=
 =?us-ascii?Q?J+6IJ+JqGy2RBXRdPs6Gs8USWqf4Wbz6wdwXDLLCYd8vLu+vIA/fbmy8h8J2?=
 =?us-ascii?Q?r3kLttACv4npv/t5FwGjX4OrO4VwU1pIly9oQNTABnWFGtiLislnGY2HJjnx?=
 =?us-ascii?Q?CmSv32dmnBgb2dk8tGUKpwOTjoSJia4AGF3g49PNPxByMdkwQ5JIjTNWPCc5?=
 =?us-ascii?Q?3v1raIphOfcBXX2P5lOFCw5tdZVxMs+hyq4PGIUDCMauyeFTZr/NizOzxTU0?=
 =?us-ascii?Q?jAULfFp7aaMCgoM7kEg0xw5Zb9UXoWvAhVg012IeQs0hE03eHA2/EJy6Bfmc?=
 =?us-ascii?Q?2+VXn/fpFH64ItYYaNoW4M4cDqac9zKq4D5Um26gz5GE6HmGIN6mYNGlP6Da?=
 =?us-ascii?Q?aIxiwRVJYeCSAWtmIzlJEogA2O+upJYi+eKpIwUDUzrCNbjxlQPjrdL64IMb?=
 =?us-ascii?Q?veFvI5TJrf/1vgT2r9njnQMPVN/0H/ivMXH5bWVMWA5w6MF27oykccjhjCyi?=
 =?us-ascii?Q?ZBXzMqpHz18awT9LE7aC2OsjvBnJPYfgDOPvzrh8HSk5bZaha8SwxQC31rqq?=
 =?us-ascii?Q?6UpL1WECuMXCPz5m1ItzFMKgZeiYmUkW7IJm45d71a/cPvt3cGQoadAB9rNt?=
 =?us-ascii?Q?sIo8Ltx7porhuiaQfl0dmykp3uKsIu2r85ge3MOzL7PtGH2X/qouWD0dGFVv?=
 =?us-ascii?Q?xlEmHstWtwh5itfEbhuJ0We5vTMoDZnjPRakPH05G9PFPbqDiESR7DKDW+9M?=
 =?us-ascii?Q?G0EL6VPThdybsEY2+GlcLngz3lfTB1Ba/nY+LmP90RYSU/Q2xWRSSO3zblfJ?=
 =?us-ascii?Q?wfZGA3DsV142+p0uP8wPrPjLUt/vS12h3B19j6FREu2+6pKwP+4hG5u7Rqk8?=
 =?us-ascii?Q?Bs5dmIm/ATwxKsR0N/8/7aEvYTnSrPh/KW7ADFcflPArh/EmuSUehIrrrtwt?=
 =?us-ascii?Q?hrZCRDY/bYwBBNRkheEm7skB3wGObGYX8FlanW/Lcux0CyP+CcRaO91PAnHe?=
 =?us-ascii?Q?Vxjwa1Mo18/RxborrAd3s6qDdSgT9tI+I6P7hO3Loqbc58+kxdiVMwWjuYG6?=
 =?us-ascii?Q?YSvinnSX5f+KtRd//lwTJDlUFUEHA+0qxL2VHsVPMycm5X/XJXnu62cFSVyf?=
 =?us-ascii?Q?/n8SnOwOmG82OKgF6c7uvDxzAogl8Nz6uYoX/XPHn84p3RULqB5pacy4Q35l?=
 =?us-ascii?Q?h3PhYpoEMsaQPWWa86d0OlNNP1jMQp7q9fhyIohsbPe9U2UWmPRrADXW1G0z?=
 =?us-ascii?Q?Q7SIT1HRYCwaVZxxcssg+AaoSV6ooqLnS+oTGc/AdxLHUUza3PypTZUwuwji?=
 =?us-ascii?Q?heE6mrK1WA2GNZbIVGQS5HpdeQ4eOVssvI9tFqBe6+oBRnUjgcWiE3+taHRu?=
 =?us-ascii?Q?XTjKGvKd47XR/QInpoB7fmKaOeYkXRrWzRcCE1s6a1D2St1SrfpJO9AO1+Cs?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91be8ee-cce9-4ebe-4bd4-08db245dfee7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:30:33.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7g2xgXsvPQFsU1cRjvrAIFUZWpIggFz+LQONGy355oaLgONMvZVp5s/DuS1Ql31n+gw29gZFyEzg4r119/Q0eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

Don't clear the addr id in mptcp_userspace_pm_get_local_id(), clear it
in mptcp_pm_nl_get_local_id() instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 2 +-
 net/mptcp/pm_userspace.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 67995cb4f8b8..df15d846e7db 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1055,8 +1055,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
+	struct mptcp_addr_info skc_local = { 0 };
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
 	int ret = -1;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a02d3cbf2a1b..fe4c29a17466 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -113,7 +113,6 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
 	if (new_entry.addr.port == msk_sport)
-- 
2.35.3

