Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DD7F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmTOpDeOQPZzuqBkDnYqvUX4BSdfsmeBnI3IGNnNw/b4Va7OZdRZCpCiRwbTPW/XxfYTWFH6FvbFZGb7aDXYBOeEKP9rzzbkVDTGuo93foafGnjecgjSMj6k5uMLpCOv98TCMrKTT8M8aAzf0crSs4jdz/eQSrGsM1Bed0/l+/8O04YqjlD+DTqdPsH+stmELMbujmb0F/2Qb3GhDKhJWZI0NOqTIS1AjWDvvcsV04GLZqAOcf6xUDrLIY2XJoacPA7LllM6EqHVOPvvuzOyuMGnYsjAwQIN2esteIAobHoxBe/pbowFziob6ZHEmDoxFSDdNBzDn7rMiiqbirQUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgYN5Zmxa9v5mMmb59LNwVWwczgrOTCpGuQzIlrw4GA=;
 b=goOAAUuzIXDvOiGkoCLLGHm8toEnAJ2BjC+be4hWz4SaZQqH+xtmqD4ROrWO262+ETmPjhATB3oH0xuUtteXmaluV0gXfz+vMP+vvQaHVWHdTGpvjH7mg8OgiervY5iUbQSRaZboDZCCimjPzy4uAo6Y+k2Z4zoBMBNNFKVnYdWyHS6KRXoa/K4slHdIHraGWgkqCE/A/bUf/Y6EWIEKxeQu6rk9xmsh+fAsk2bnOdCGCeSAsTANdGBMgM9/5eEsWTfDbRDPN8+1gGgv1wlFV8BxIINODI8doSiSAVXiAMueb+EvOsK4HTZCbl/liMorG3vGtrS9LMgSaZ/BA5sigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgYN5Zmxa9v5mMmb59LNwVWwczgrOTCpGuQzIlrw4GA=;
 b=sAYLsE8fXLOGmMyta0l8jSKo1F0dfwRWbzYpwdDe4faTFC0eEM5nH2nGBpMGXVKa3gq+zGsL9OP1YTTuwu2tG8hPoYd3cFAxZ6IEp2dew1b3NoL7EnBpfcyqtQ6mDJgfq9MkpoQH/kuETfGzDxsjR37qon8GDobT6ow0/kkL9Bus7SDwjJsAM6CJxmbg5ahiBO5wppVwA5rp+cJptxIZM4HEVHAgmMdZLOsN+cEjHAEBzR9zGvsidyNS/nEfdqEfTEHpUIBNQk5lKb96i+B14SpdwiYyckTaoK3J+4CYi/pZduA7IdsKbuPcFLD9lquNhrKuQxYm3ZnMJKjjN4hm5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 12:17:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:17:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 00/11] refactor push pending
Date: Thu,  6 Oct 2022 20:17:48 +0800
Message-Id: <cover.1665058388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3d15ea-9fe3-45e6-bfa2-08daa794c3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CNjAmvSh1MtYbKyBJISv6iOUk1RrxI7LTz/HCSlZPtr4JgkfSp1x3zkENd/LbrufNRbX37aMZvOXjU5IEJb3XGDWV67uhU3WRQ+u1vU6hvbvYh6QswcFmulzlfAynv/gtXZ7kIktVwImg4v8KsuoYXBqCzbL6NzwbowsIfpnftYH/NdZM4ulxQkFehdylwvTlU4dJbuE7f+ZQKbA9OL13Ip8s+HLGbYj/4SicAXtKOO26wGKA+X/R+AV3JLii2qNDTcuJ2xKC4edJYl7jl/PBp3UWrxl/L+gYdqqlMNXhc3dtwWCkbYuaVxChLVGS2YnWU398yqK3L/xGdCe+ujFLOPPEeGRwTMQRnVM9O98xR4jR3EHI+qIWSyFW+FI6Rj/VV3pQPaHWTchM7Twg+TDoNDVfy2wiSUpfj4EouIINQOyr4vGO4ZmBDH1d6mUOOeAczZigaTGwHQxzm4c2d3AH+maREe5ekNppVErqsmTn64uO+I2SNzFjb4j128sIGrV5fD1EZWWdOqKwYSv8ZsL/nj2svHIPzv2f1I8XEJvrB44F1IDjeiGolb5QgkgQ5esE25lmOP+4zeFpZ84PCa8zvNv6QK6XkUG5s6lYcyz7xJmg1V8zjmRLsNcBEwhxG1YSjhxmAWY8jEdyuVQyJCGO0veVqZvXc4GVU1amQVM7i9WOEZI5wgnrEy4ImEny4FmL5n17Guq+FNxxLesDpqTtuok6WwKHnN8slLAYYx5WcZqm6YvcIC1VF5YDPCMNa4l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(6512007)(26005)(6486002)(8676002)(4326008)(316002)(2616005)(86362001)(36756003)(38100700002)(107886003)(186003)(83380400001)(66476007)(478600001)(6506007)(6916009)(2906002)(44832011)(8936002)(66946007)(66556008)(5660300002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ex2aTzLGo1XPiPGnBJsWkQY7/FWpVzdxOJyPEnUntPS5Lt2lif+etQ0LLQfx?=
 =?us-ascii?Q?gMPDrOQxqsGPE/WFIBxl5o4drWoplMzmUyAA0z/HSFyM5H4wPVVEzKQMqkxa?=
 =?us-ascii?Q?HJHXxHrIBW1hIExZj7oyhzGekLGma7xZ/9xvqantdXBcptmW/VGIjAAVgVa1?=
 =?us-ascii?Q?58MIkZncgwhJ2n0E/6IoRpJWu+mtqne+RFkPG7Onmyi57KSiKxnJZDnRkhEv?=
 =?us-ascii?Q?bJ6EWUxe0qWQlzn/RY8WAtM4/9ENCco3dzbEP8iy/dNx1SVqtB92scYH0p1A?=
 =?us-ascii?Q?z7LC2NPK/x6+P6J8ARH4dDVmvl6A7IbbQUN60BcAcPj4+4ev6g2TF83Nm4Yy?=
 =?us-ascii?Q?2hE0+/7fGhKywZdDMTpkDKBJU+reg9Ocq11FVvByYER9hY5VqTBmBLuhQdF8?=
 =?us-ascii?Q?AgS2W1S/X1qCiGyX2nRhTQ1Ea8/Dub7aEDUkZxj+wy9KRzU4oFzbkiWWjU9V?=
 =?us-ascii?Q?Rz/y7lqbSzOSS1MZAe48iZSBXrIeaXSpuGgnJQg8u8rlfg6Hab402VTGDDxn?=
 =?us-ascii?Q?7V9i6mkN5r7bhos4JdQN6ZuVoU4ub3TwZ2oJo/HbLnLquhq5kJkCEeR+Lvd3?=
 =?us-ascii?Q?rvah9Mzi3y3D7r12SI3kyRRObJ5wt4gutyfmkAdalrCPkahnGRs34ffFuhBg?=
 =?us-ascii?Q?k8rQ0skVa32jc5kwG3IrSu9UbNuWNjHEOgQVpypGb3+tYoA+a9cs87EQQvsR?=
 =?us-ascii?Q?CXSeLbUOEKHGgO1ZmoUcQ0594qdoTbyaY53OG0io/XsSiqQVBbCbOOjgc3E/?=
 =?us-ascii?Q?6Bzpxgji9ABTUxwYcp52nUCGNH2NejidXXGmd8bBjeDJ1XBxGTrWamYsepKk?=
 =?us-ascii?Q?/yn8eA16A2mptoMeJBf6pxMSAZ0u+YpM8ujSHrYI25yEcz2loWk1jmtK32ow?=
 =?us-ascii?Q?2xfwqYBYEK1336BUZZdGQzQv3Hi11f9USeMIvDuQ9A5WfycJj7oD3/m8N/+1?=
 =?us-ascii?Q?dVq+fw/D6qCXOo3QQcubHubR0T45nF88cOSBnjg7U2TJMAWPepw2X3FSXT1d?=
 =?us-ascii?Q?SgshhV0f8QQZ4AYwF8RJl2P5g160XqPfDga1xwaveFeaVUgsuxoUv1jVoqnw?=
 =?us-ascii?Q?xgiKgsTLTYMXWMFt2dbEWqar4Apyzd3kNsXd/N6kS95W5q+p7usgG3hqnu3k?=
 =?us-ascii?Q?i3wPwK5oy/uRPneF+ZYosAg3NG8TiwTsjI4SvJUnO6/jpSIP+2oh5nOrH2ti?=
 =?us-ascii?Q?Zxchqh1EAgMEeZSMGaSRM2FgjZIbvSrW22q5v2cjuloXFYJ24m349kxu6tPo?=
 =?us-ascii?Q?uVIP10Erl1sH+/15MZoc77dRjS10prquLH8a4brGYhWReCAZBc0wCkQcCIfE?=
 =?us-ascii?Q?DH2M6mglbLFDr2V7vc793QaY9LXWr7jJ83KOqPo7oZB/nA9RJ4VWcNEQm1R5?=
 =?us-ascii?Q?nRtDbj4HBe79jfQKBmlnPg57MvTyys7Hfz8dW91t0m5jKsIr4E18qiUNqxCm?=
 =?us-ascii?Q?ZbE35yZgh3hmqD5w/n6zHVVz+qyHQ7iW+m0J0XHx/xZC2Zb9rrOTt7fVKtNS?=
 =?us-ascii?Q?yYajBC6psGHM0vRLxiYKd8e7Qrth/MV/x2ALwjviR1Yj8qoWsRPax39IgDLQ?=
 =?us-ascii?Q?eIpU14toLjDSAYRJJTZ0ox4LO1AoPIHGCNZkwWg9fxjWVKSQO9jyXrlVOaJ6?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3d15ea-9fe3-45e6-bfa2-08daa794c3e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:17:41.2171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDOXpFpEIS37LBTHbY3BIetbUy5h2he1k2lxzSFsg9GVYMgSSuXkuMcazqsAjqVB4pxwFg2gsUrxdnzemEWnhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

v5:
- address Mat's comments in v4.

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
  mptcp: 'first' argument for subflow_push_pending
  mptcp: refactor push_pending logic
  mptcp: drop last_snd for burst scheduler
  mptcp: simplify push_pending
  mptcp: multi subflows push_pending
  mptcp: use msk instead of mptcp_sk
  mptcp: refactor subflow_push_pending logic
  mptcp: simplify subflow_push_pending
  mptcp: multi subflows subflow_push_pending
  mptcp: multi subflows retrans support

 net/mptcp/pm.c         |   9 +-
 net/mptcp/pm_netlink.c |   3 -
 net/mptcp/protocol.c   | 285 ++++++++++++++++++++++-------------------
 net/mptcp/protocol.h   |   5 +-
 net/mptcp/sched.c      |  61 +++++----
 5 files changed, 184 insertions(+), 179 deletions(-)

-- 
2.35.3

