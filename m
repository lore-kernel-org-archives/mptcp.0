Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCFBA45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/Y9nIPZnvckP+sfxYSjquXxCfPS4/geHVUiyfkSznnl8eOrbXFTEooKSqOKZgFZ8zPJHSBsh1F5HwI7B4d8Sful7SBhAkH8lBn9cE8wJQYY4AnRemoDb6LohdlrX+QfcEeLrQXSEwrmRBAur38EnjeYgH1XxKe6lRTo/ceF1yt9CHvIWXKRJuDWxN+GNedRSm5cx4/bJptR0yT4mZlGMz+UwM5CBeM+mPub06awVRNXPh8CIVLXDRmyGiTsPKVynbVjW36U3QjwQ0XacVGrvyeumiFN9QGs1EasWlHUnGK5KoLW/5/eDiPwjx3AxWDzRBmwUZuTacQiRZ78IXNNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jtVa7i2SBApZAzB1uAjUx6Pau5uhTU1jP3q5BxhGSo=;
 b=ehjPCvODWappVafkJH29KQ6G2VYgZ+/rzRRZCngsSoz78ZTfJtfUBgco/kllXvcOdnMPdAoM9BeD/+XMNA62O+PcPvyi7gwaTYw6hjcGAkb7ZIQOzrIGgdZ3G+Alx6qjcSPEvDYp2JCPF4l4QhmsR4KsJnCJ7gBilVWRia0ECeGx7DtFKFimiIhvJ1JU7BH8esXujHU6uTQbjPgX0C55OnExjVWvqYo26GJ5gXLX/pAvvRhHG+XIxElQlw4hVYdZ6lbDiLK+T7N0r9dOguemDs7jw0y2axkFbXEs7kvFpcD4QQZaEHOCmmrZ/+OPkqPZhdgT+T+mMcH65pU4MqutdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jtVa7i2SBApZAzB1uAjUx6Pau5uhTU1jP3q5BxhGSo=;
 b=VhRu4QenFPYGgobAXcyxzgRL1tt4bmEfiSMiNuIMExwx7qMwWQOXpmSJ7RT4FZkR1YXk2vasxfmB1tXG0Ro7E780WBA0kXhS1g8KNwideuTluKc/M3ACDTzq5UqXbwSxmzSqpGB2zlWVxpT8ojQ11UnUD/eNbq11iNKVuV4L6xhivMPlCPSQ8bZA1VcgM9aKfmU5knBgGkUpQiSjCW4FKuAHqnG1qehxQmow7Trnd0hhwPplaysv6aJ1TcKtKJuYHK1XtA/rRWugdrqdVFpg9cQotXZ+JpvP684j4R9fsE+pJNliGxvQC8OUpmoi7WeHlts8g2m4kzarqBAti/I1YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7263.eurprd04.prod.outlook.com (2603:10a6:800:1af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 09:11:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:11:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 0/7] mptcp: update userspace pm mptcp_info fields
Date: Fri, 14 Apr 2023 17:11:03 +0800
Message-Id: <cover.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VE1PR04MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: a11699c1-b0e1-40b3-f689-08db3cc8312a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z6ph7+GcyMI4Cr37+B7zGm6NqnUfHqW0hja56TrH+vKDf4EOKZpHGL0RIO9nRAwe7CJeoIJSX7LsTY4SpbF1vH5UjzC+Wkmb/MzuvLcOX6esjNW4rbGdh6cS6PfgPRE+X0V3lJnqhE0XXlFHR8WhMNB94r9OxJz2e5Ipp5tDsPBJw5Af9iYbMu2oA4hlRTGAgBGfGwe3dBMVG44+kk+4h83oqQFZexhqiyW//BTAHO+ZsV2rvXtWa0InIe1ucF0lgnNI3QjjEqd2u6mp5JrCrfQs5Ns3gQNqJAIzweSwBTSNOhAmk0r28g5hIr5uq3xoJkotMq+C7xmjVQLRbH0+gyxQ9WEjoGle50dozYwQzVWQ5LPXxhwlid3TrxiaRHHx46fXpclax5NFRoQmBZIG4kC/YRsE6DEMiENeKqmlThX55KSuCYOCPxWOVpVDJzlIEXDqVyZlNnFB+CUNE1m1/A2yp0yyU2UwNQqE1iZPIK7QEGHcbzQ1zP28mW5NecfOfzzb+QiHUWvu+Z8tlYbhKuIbI3LTCSr+umz1r5TMPx8h5vEe3dptEqJJ8atPhmQgK0dIgEGRniINw9FqGyrdSf4xcC5HjWik0RfZti85bcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(396003)(136003)(366004)(376002)(451199021)(186003)(6916009)(316002)(4326008)(66476007)(66946007)(66556008)(107886003)(6506007)(26005)(6512007)(38100700002)(2616005)(83380400001)(5660300002)(8676002)(41300700001)(8936002)(6486002)(6666004)(478600001)(86362001)(36756003)(2906002)(15650500001)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sf+hAeWfOH1mTqJrfdUeVDNMK5kVgNmcibSC0K8RXYpG08pzfcdXH0Bky7Uy?=
 =?us-ascii?Q?+ZpzvUETGjN0teteXzVHtquFPmfCDaZlM6dN4SkugRm8fRXjDeaHcjm/pvkA?=
 =?us-ascii?Q?5baLCfIk7MRTwPRQi6i+NF/88v6SPLM+82M3KXl/PDzfxxbFS5JgVJvrwyvC?=
 =?us-ascii?Q?bDJtiya0aTd2VHe7AbmUW/B5lwLd2Xc9MWPSzS1mpyRzvt6DMf5UBvyHx132?=
 =?us-ascii?Q?dHnqs19tHMP2ivfbvrZcLQBhPNfsJQVpyWHMdgQqoGnQYs4J07a3wiFtjJcd?=
 =?us-ascii?Q?7bUfLlvpEeAbGfDRbrSnbaHQc5kqhUid05gIFfYJoLYcEl2NIKC3E2nAlhV1?=
 =?us-ascii?Q?k5GkxUmREoEESddUEmK3/UftGXFfAdoGS+38adnkyGMxDkuipwvbk09Q2pZN?=
 =?us-ascii?Q?hUg4haN2gi5hE3AOpLGV9xZ8tXhY/AwuPDUTAVB+HBKH1KeujmEupP/AmD/+?=
 =?us-ascii?Q?covysY4o59pLjoXMhw+koicwibkA24oiYk6yewh/KJuQsn+UZp/PiZjAsZm6?=
 =?us-ascii?Q?PvSlo6ktzvUTdYyU1HmCQoVyro1W73QKiV+6HDNrVnaafodCvMSIpTICVeqf?=
 =?us-ascii?Q?UN0eii5cTe9FpnXRGrf+plfmBHeLbM5cVyCS/QIDm9jncSCuI89VWH/r1TLe?=
 =?us-ascii?Q?0v84urD2KZFLHOGA2NteoQjKn/uWMEpxMs+RdeSNsW6z5pNesXVYvB+h6C12?=
 =?us-ascii?Q?hWx7fPGPcZdFS65xUaP4XtUB3irUWMVkjbYSY0fPsKr2R/Q6S6wUOPDuJXFa?=
 =?us-ascii?Q?JMUc+44a2/nj4LgohsOIsozZHMfg8h/372SQUEZl86UQZPeXBKpe+PWVwMYe?=
 =?us-ascii?Q?kvmH787fNwzPajF5gqxOlLwH3mdv1CzfH8TeGBx9UBYzcwrBRXm5V9EKCh7y?=
 =?us-ascii?Q?GigJfv9q5ITJ4mcQXl7DcoX4xYgQG8yeQHJCm0G0F4dl1vtHMT6oAt7nFdC8?=
 =?us-ascii?Q?kxSrpNslwcAJfvktbUB9jQBqr5N27c9WtpYZNWq4KttXgB11t21hh9TiamwR?=
 =?us-ascii?Q?FXepCjSlDicIWXa4Uh+NTHVmE0t2nA96c0btLqjgXv0pMyzeM7NuIugOf0Ac?=
 =?us-ascii?Q?+u9oCCskw0yHVwmKky977qcXFlJIq1B6F6aJldatxsnEB6Bk233LyX2cbMGi?=
 =?us-ascii?Q?Ctp8/6s85aY3mQqdByI5BHluLN7elkULBAyqmcg+wf7QQ24n7s/5XZx3nt/s?=
 =?us-ascii?Q?1giJQ5FdOS+5FrvNb4r+qEZxaFW+kbjLxYDPdgSvGYpUgOdE5O27VV5b6HMp?=
 =?us-ascii?Q?WzaDmq6u4K/bC8NSKqoy0yzlJw3gAG0DIsj6TQGjbneFWWuHmPzfuVoIeZD3?=
 =?us-ascii?Q?lqh8dXDAKeEj/VwbyuxC1bmMweWVoLnBDLNsdxaq5s6LqcGV4ujF/hOhUvHH?=
 =?us-ascii?Q?SZVap518PO8cDbMBFH5Ow0drjoJqbaHtSZr6IWg/E/E280qY2xZDPr35Jz4U?=
 =?us-ascii?Q?RYu0w3pJ/5JC/cQOJ7UlSIcfEQe+VWXFcrtpxOpm7/EMr9j4qPtLFkvCzH8/?=
 =?us-ascii?Q?iz1m1E6a/0zirK39lO4DvcvgYXL8wRctbDAQ9uQ8S71A2z9DCUZlTYCTDoM3?=
 =?us-ascii?Q?h9iFoETBYuGWJSPJm9mH4m+eCUch9CjxYdltK6r2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11699c1-b0e1-40b3-f689-08db3cc8312a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:11:12.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJ6Apn/FkHXclU6+H5yUFvk5TIAVjFSAm7vjJ2sRbOCEp+bBODwnkoBfRlu6iVwpYUckhXF4rPY6yBx/STn4zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7263

v7:
 - fix userspace_pm.sh errors reported by CI.
 - only remove addrs in mptcp_nl_cmd_remove().

v6:
 - send a RM ADDR from userspace.

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (7):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  mptcp: only remove addrs in nl_cmd_remove
  mptcp: don't clear userspace pm addr id
  mptcp: add addr into userspace pm list
  mptcp: increase userspace pm add_addr_signaled
  mptcp: update userspace pm subflows
  selftests: mptcp: check userspace mptcp_info

 net/mptcp/pm.c                                | 21 ++++++++++---
 net/mptcp/pm_netlink.c                        | 27 +++++++++++++----
 net/mptcp/pm_userspace.c                      | 30 +++++++++++++++++--
 net/mptcp/protocol.h                          |  4 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++-
 5 files changed, 90 insertions(+), 14 deletions(-)

-- 
2.35.3

