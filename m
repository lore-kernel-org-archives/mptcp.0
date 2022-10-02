Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1C33D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7uPD1UfHQfKrYR9xrJ5jyH5oNx4P6lb1eX6PMNF9xJbeonFMDOzlaWhfuQNR/SZT8uVjFMUDU3YDN6XlOJwW2B4vDuqVsYI+Lz933kibv6b9nAIF2pKXZuLsXA7XmY5JfNd/WTaF215NoMKFBi5CeI/0xHGxFsJrgfxrmaxzjBkXIoqQegLeE3oL4wo8xeADVKQrGQ3k9vBvSFOyUOAzfkTDXQnM0gg2ijvGhofI6cLPStF/4BqoWF1qGuAWjMRtOv5OC2bs6FRhvAwh7UTtS2fBDNvqNVPBkpGgR5zsLqZMp3iqohCQbK3bo6VK0QV+mZPhnGZkpgaq5bfJzFbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/MCUdcjE/zvAk0cfVVT0PZL6fBpbFIG3jIMKByBZco=;
 b=MB8Zi7gi+UiYWZY7DmiWI5RVm9tBRqOXFScLvLUikOzpnMQwPR6aie0wzXZb+XyUMEs6AZgabINpDPWA6FTrcMFAJy/r7Gh/WUD1fQq6g8Jn4wW/wQ8LuVFHfFRUs1TfHBot2hKDR1uygzpdm010PsySWngvFA/WjSxxUogLwGixmu88uJ24zAcGXRjF4Cq+9kCayWLRAdSZD0JLlAWw/sy2OCsd1cvKYkCQo2XhuG3mrYT6j+DeWJg73kueKyPDwdpY06m20X6r9kc3GG5abMkC4TJxiGG8kE9+9lPyOYy14qyuefoa8VJTZ+PyVVwoZ/9WBDFoNLZOHZJnc8yR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/MCUdcjE/zvAk0cfVVT0PZL6fBpbFIG3jIMKByBZco=;
 b=lK3TXmFMStQt+Fmif+KS6M3XshVJarkN3wpMfx7j85CKA/YBD6O73F3dkwEeoxvtNTtpYZ9P27c3rrvanecgnfsNoQUssvqGUrnjMtv/m3B0VjhcKoIEYPi+lUfpz3kBH+fHEm005oojfySlIXy43uVKznNpYBdh0BGZgWwP9zJoidQjHH9WSJIxzEUs+Kcf/Ny9g8g2DQ7aePedymc+WI3M2uKku1qx2SglF7xVMuTJmLzazz51CBcQw6S7h98eW6Lci4bkpMzwVkPbnlNoItHz28c3sw1E7Ypx6Xixj2lkLiDzzGO4xu9ZM8vzKdh8HKHzvSBjdpBSuS+saNmbGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Sun, 2 Oct
 2022 14:24:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:24:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 00/11] refactor push pending
Date: Sun,  2 Oct 2022 22:25:08 +0800
Message-Id: <cover.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fc89f6-d00c-4e15-d554-08daa481d7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vxJ7TgkvcDFPsyy5Wd+DA/Jbap2uo3mvLSlmSy+bKZ5qMWFbCOn5tY3DhksTsmehBiW9iJQeSPcOxstDI6CPABphOS9Sw/LrW8drvaJf0SG7eMmVPKE9pp5saX9o5TDIcqw1Z9D51eH5nZ/xaTLnBy9rtnkdLeqxqsa3pw7A8lH4e4JQ3KhaLs7PLp3BHKNjKWd7zBouq19E4ghplPozl3zAjUJaYywpnai0yyWwYjlnp3DjZma8NERq7lAmVAD3xjLdm1tvp3XqrwKKqCSCpjD+7Xk5Mz2Dw8FJw5rb18nN6636BuPn5VUKr5oCuHI9wRfzQ19hp+Z6i23zrmwinNfKl3TuaYWjAmF2tZZ2hMgF7QIIKjkPTWI+cvql4SbszOAv5Losv4bVmAzaIURl1GlKGhHgXJmm0IVYJUqk8amjf02JWb+P8GBHNku1aqK/KltYChQvV0NW2ED5tzJ15OYJkucCHNNKVRg1JGCKXmzt2fc8KtSPjswB1ovcypd3P6tAGyZKCOqgKtzzCoGqrK6G5PiZF/MnPbIQScxLdG12F8H9YZjgG7te4cMw7Nj9CjAACeRds7gLC/Wh55IEowGYD5nfcD+6M76jdNtu+9ghvXdGFpO/uKtlppnelR81gyQFbYE7abmppUo0QYapqaOZZk2z29mEp3X5huf3FcsBsQ05l2i/6fkfp7JBdbhMgUBdQMc9hykMRp9vxBi9Iw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39850400004)(451199015)(316002)(6666004)(6916009)(2906002)(8936002)(44832011)(36756003)(66556008)(66946007)(5660300002)(8676002)(4326008)(26005)(41300700001)(66476007)(6506007)(186003)(38100700002)(83380400001)(478600001)(2616005)(6486002)(6512007)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7IXpQbJ+6uXMha5A1+FIQJFMkLhxKW62z4f4EujxNAtHH5IL8KK+64Kw2i12?=
 =?us-ascii?Q?d8fSrdK5qVrEsFhvmPm+7H37Xv+upx5rs7sLCKFmkO5jqtiqJEz31RonhLwb?=
 =?us-ascii?Q?d+joECZuILTgCRyv12hWzAeqGab2pByUHA3SWAplbYdbnEY4tmJXyRDOhg3h?=
 =?us-ascii?Q?FK0zP73N6BECsoIZeCIN1Vqsq954oDXpNKVt5SmpUCX8S5HEQpHtqI8LJsRy?=
 =?us-ascii?Q?fuXWcJMZ6GyOHVNKvlNUahbtP7At7aAS7F4IYLDb8dv1IoImi6ij9Nz6ANJG?=
 =?us-ascii?Q?xFnY9VYgj40aslowMDlMBDP37ydfI8ES5VjpizfEyeZfbA2bk+y29d9cSPCw?=
 =?us-ascii?Q?BzMUH/QGnwg3jSwCRxLYasYC00ngxP+D4PFkY/oTtCDSd8TzNBoUJy8NVnLy?=
 =?us-ascii?Q?ZFarunLyGkx/zn386SvEExMzOcaea8kqRaFDHgZW8Z1AcXfckiS4h/HjvwC2?=
 =?us-ascii?Q?6JEYNbp1KQxj1AWeNBCAPIm5K+10zTFVOnH+UCai0oUQOxY2gk8mcostUe9D?=
 =?us-ascii?Q?PwRwKzCH4mj18Wzpo8tqnUxxifWM5UZIRUulRqmIDxb/U+oZ8exZhh+XhbuV?=
 =?us-ascii?Q?4QO8IUXkUTC8g+Iy+RJ81OchR8zGy7LyzFPlM1zx2oN6JL2FR4BDcU2s3nMd?=
 =?us-ascii?Q?H3bsn11/xtYuwgnX9F7+G4JmtQTxoQj9F35WLsnB+qOYsrmW33LOcSrT9Scc?=
 =?us-ascii?Q?kq4pVm5PmznNu9gt6ALrr0E+OFjpy/k2S/J0PqMU7bSyKHtXDcPlgueNTHa8?=
 =?us-ascii?Q?ceyvuzDB/qErIFRlNOzPy3G2S1vjSv6WmEBalQwT3aHBjc6xNwZyJ8pqDO+T?=
 =?us-ascii?Q?EkgTLbsg/midfJuMMrfjfnujcD85a2rFahgo67NeS2uJbgqigRT3Bnury+c/?=
 =?us-ascii?Q?vWuzW6J4gY7QG5wOCdwYMHjjvW3MHHOQFtyP4n/vysQEuvXhoy8qls9RNH7u?=
 =?us-ascii?Q?QHndOgDnevTn8EzNPg27v8UNw/t2cY9r2ftaGnvwZ6CPMK32QEOCXYIP7Y5O?=
 =?us-ascii?Q?BSxc8DrkkUsNoPRmaWtGsOVbY9HIilFYm6qYTZ1zH0121S/0/AS89+dLrZYR?=
 =?us-ascii?Q?zDBxcXl/e80JWapLC3dZ6ZDMQksk3krCYA87YbMio/VPRC3qOuwodpYBtwR6?=
 =?us-ascii?Q?7ATHuagppaAxsZv1byegvG2GnzKRWSAeUfX7+Gbe9QcS6TKXvZmFdvctYWFu?=
 =?us-ascii?Q?FAPL2Hd26AUpIgrz5JfnW59DY/ntRrmvbMqwIyrT/g3/qm9Wi8g2ON7AY9W+?=
 =?us-ascii?Q?Eer3tJGX3XOOiIhHZfubGZ2vSaglDpCi5ZUvOA3mN8BdCiDW+Fd8ciQY1jyE?=
 =?us-ascii?Q?KUvp6+Ldi3bLO6kGkjxhK3NAoIm3D5cp84rDxLSo7Moj/LAaXj2OgujOw5PD?=
 =?us-ascii?Q?2mbgeyDgCIa5E1pqPKUM5nbbIB/4JuWz4PmmM8LWfdJOUQP0sV5Qsai2vU6l?=
 =?us-ascii?Q?9yysGwnnSfbKDkyJ5g1RAMXOy39ymNEH6gY5VHthsyjCcfxzx04AV5ecKdZu?=
 =?us-ascii?Q?ncDM8UdYPHyxGOGPB+266w1anxGBPSHLdmiZMrOr4PhmDs1qJrp8LH3WyBN3?=
 =?us-ascii?Q?hNwaWeC/lIKh1GVrVfgceKCnHwKnOYmf+BJjqUU7L24PFeqqISSViKoIRCoh?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fc89f6-d00c-4e15-d554-08daa481d7b3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:24:40.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xLrW20lCNF4iWfF7vdUmJJr907JovUMO4NqZ9a4AoBXN2a12zoq2bkd0UZeZ73waCeBNrGgDcOhQa/0/lFrtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409

v4:
- update __mptcp_subflow_push_pending as Mat suggested.
- add more patches from "BPF redundant scheduler" series.

v3:
- add a cleanup patch.
- remove msk->last_snd in mptcp_subflow_get_send().
- add the loop that calls the scheduler again in __mptcp_push_pending().

v2:
- add snd_burst check in dfrags loop as Mat suggested.

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (11):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: add new argument ssk_first
  mptcp: move burst check out of subflow_get_send
  mptcp: refactor push_pending logic
  mptcp: simplify push_pending
  mptcp: multi subflows push_pending
  mptcp: use msk instead of mptcp_sk
  mptcp: refactor subflow_push_pending logic
  mptcp: simplify subflow_push_pending
  mptcp: multi subflows subflow_push_pending
  mptcp: multi subflows retrans support

 net/mptcp/protocol.c | 259 ++++++++++++++++++++++---------------------
 net/mptcp/protocol.h |   4 +-
 net/mptcp/sched.c    |  59 +++++-----
 3 files changed, 164 insertions(+), 158 deletions(-)

-- 
2.35.3

