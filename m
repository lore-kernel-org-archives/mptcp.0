Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB76AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GERaNospwtdtgxt8MfsJImkh8yKtXUrSHZhqRKOJEfGBRbKk4MP5UUb9/CYbUD1JQlYMhqF9m6rjJTTLcx8eQVSGwku/Kv1HcyvBVd6W4oEm6G20LApI9plurqOhQjPrwO1t8WSSRe0c26Aveyw31RFMvSMQm+/zi5deWSf94Ev+3GISOlAe5sgkAXZ8SJ3g9ldfIJjRjYCLNonilufWCgBxK8cdfS2Ql/LkW8QHD7yET0Pr27zAkLQYGCuJVZYhAcmZpo/CtfUwFGB8e4D++0jrZgx/isQmICz0JQVeMRJt/NOz2Znh5a24ZcfiJyFxUVpuXO22i6yOSpevYCEEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTES3xzoEQUSlP9MGVe/Isw+L6dFk7pPAbePS0XGI8o=;
 b=aizM20HRbDpx/fMLDYWspXaT5yp2jJFZGs6q9hhbtpcdJFYM6tl517aEUdkYfAPHYWDSyTj4Y0QK5YTMXGI5HPcxoqpwltqA90cJNaARM+r8u62RgwyvSW3zGSV+pk7XfiwMcgzRa0Lb3/xH4kyQ6wJAcNRIZgfICWQInLbsw1Ly1dzg8hJFKMT2XducsECVMuUtnJ2KwzKOhgwO7Si9xmLLto/6dghSLpl4OkTGUP2oDjARIO4vAMdktTNM5yapFtMubOGLxlByERioHL7LfbBIppMT8b2iI8h0lz+DpCSZrtIrgfBJoY1HXwJa1FnWDntEw7x7EYerX/ZCV5ol8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTES3xzoEQUSlP9MGVe/Isw+L6dFk7pPAbePS0XGI8o=;
 b=K/VA+BPQpfSeMEjhvZmejfocnDq8tW/mpUagxuJ3+vEXxfO9Yqt6uJP9x//vXYjOFl+36jd9zO5a/fnnc0ycJl6oQ9YRYkuxMQWs/CPdhG8tqlyfcI3l/Nxnh9mwx0YeV8TlReqBEZRH7gsFuBdUMZ8N1ChWCkqUUejK7BOwd2I9Dzn7P4OzhpxQ572Vr14fU9PYqGx7GbzZQ5eSh51lA/MNMsQg6BthwUIJcRBp9ehfGUZWmNXwWjWq9DPtJgJLzj9UOVmE5EHPGRPUSRHicyCSueTU/3oh+aFfZOVlNegxeA7N4ALfFA/EMQsmQgis0RKGRj+Iuu3VVsnQGLH2JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DU0PR04MB9228.eurprd04.prod.outlook.com (2603:10a6:10:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 13:30:26 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:30:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/2] BPF redundant scheduler, part 3
Date: Tue,  6 Dec 2022 21:30:24 +0800
Message-Id: <cover.1670333050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DU0PR04MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: e37cbbaa-1eac-4a4a-ec90-08dad78e090b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xogdCC67v9TioqyQgZYAZw1YGIdrfDiHnDtJnJSkz79HZHl4MHzRAY856Q+gE2bL50/jP1XrPf5eiy/Cr9mHxgRiOU7Em4XQfrjd1T+HAVJ92TpH+oUoLhQEw0aEm4LpTuKd4XewdR7tDbBOZpPTPwsqeSuwg4t4Q2+uX6/9IofqK55BzHUbqKyPB4vRkAWrEPWnSViZV/kJEWII0hi66LPCre+SH5UkeIoSuZDYkHnAZdLVqwIrAI2vN7AMfX6+HcFhIt7vbb1dEWeBP/kyIToqGkNuvDYTXeqxIb702sl553gaBMYuTMMptTA/CvjeBMU5d0qRvq/rgC+fd8PS0kNp/oa4oaVbPbvEydSdXqg2LasidOF7d7oET75b9hkTTc51RJ0YuvMF4kXr18L324Mw03Wz2j9XrRTkUKfMKpsvjWTmdjqUswfZfC+F0p7dXtVviAPXJ4wZpVM+r7zq07NU+tgkNxqwJe3/dErtedxpocz3wJ6g0PdERXgcQoxVs7IeVCF6yT8V66p6hC05abfEs/tSkeiA/R9a8Xh1TMQ3WZAsz1mBlC5xfnbhSVb/MBIzJK1mX6kh2szXEW+T8aRW/yk2NY7XZ/FyM0PtiZspfZZuwMwWb2fU4TNUTN71JFlj4e3j+P+ERGyn+gi34g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(83380400001)(6506007)(2906002)(6916009)(86362001)(186003)(6512007)(26005)(2616005)(41300700001)(44832011)(4744005)(316002)(5660300002)(36756003)(8936002)(66946007)(66476007)(66556008)(6486002)(478600001)(8676002)(4326008)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MQfOAhe4EEwzISF3iZXqfzu7/688X1nDdmDjgW/KjoN/d5cUjsVoHZ7e0SO0?=
 =?us-ascii?Q?24cP5Nf4UqfJvoCJP36/Gh55sbG3RZDcpimfyFQcYGVNRlrKP/WYCM7PCYx/?=
 =?us-ascii?Q?ME+j1Sk1T+Pf+2J2rKADJZ/W3FT9hxjI0qSfbnfRDfcdf0ssuXiWamG5NoCV?=
 =?us-ascii?Q?LY1iEAk6HOtrQL3PYU/iiQwDUvKrHizdVJRf24dUpjKM3JiJurgpDX9yNvdO?=
 =?us-ascii?Q?+5r4Itd4e4MNl1JwTcukwOwo/OUJoonJ6fwRbbWiVziFHVmPWZAzCF+T72XJ?=
 =?us-ascii?Q?nts/9rfPoihYHW8zh3/BiFCSzrllf1W5/qbKYlZPbtn6yJFbfUMXAJBc5wcQ?=
 =?us-ascii?Q?8fQh2EbQTjKzLSfl8WTwM61g/c3nkcwXrbncx/VWXdvKAbGAe+5MIbxtg2MR?=
 =?us-ascii?Q?6RwJP63SG4wjsUQdjJ6tlp5KbhIaj26+3BxiwNOXIFiWSyXPYjbDkWtmGcjF?=
 =?us-ascii?Q?p22eJdINHKTHsh8RcH527T/h4XpXfvpAyanKTj3UOTDxKtROg+F2UDGniRIR?=
 =?us-ascii?Q?oI3MGsGr4p8EXTojBOwAhD6sKGyZQedTFzM8DSftafebYWuEudyan7T4JYKh?=
 =?us-ascii?Q?r6b8bm0HnlEPh+QEN8cwcAiPqDI62hl0fQ6YhvQf43hKCc0nhxoM/XVQ8f1b?=
 =?us-ascii?Q?iQ/vajF1u3N5RbJP2lkahX6u3DzK9UAXbZ0pa81mFO38pdLJmT8Ooed1Iet0?=
 =?us-ascii?Q?qWOBGVVhIUN3No34kpf0Q4NoifY6Fg+pqf+tobHF2i+f/kkUWnnVWfF+KRJW?=
 =?us-ascii?Q?XuyF/FzrCvTYCWgApj+M3BhRlFoB76lKvjMJuEI9maJtsCWQ543hUCEL6lWp?=
 =?us-ascii?Q?hW3UTjgSL5+jbigaPaz2aqdLczIlcxHl5MitaFskEYks7/As12zj9+DjH9Pk?=
 =?us-ascii?Q?yPst6BQLbWCHPFA4fbKKTP+c3HqF9JcHUbbF2LIcfv8/RppmvFWwfa8Cggy7?=
 =?us-ascii?Q?NJjA/TIADlkpNstCbLiEfFh2tkAnKbYuZ6bfw0BmkU9QGcvSYSU/1n7sIfuS?=
 =?us-ascii?Q?YDUl5nVmbhkN+V+GiT/EqOGB02CjvFjMIRecAiSZvKNCtx0YtMZ6Bj4fiYNQ?=
 =?us-ascii?Q?Gbe01Mq38LMr/zEOuYP4FS9lwt5SIcsuFdTG164N9kxh/fx05xC6AGP/3fsI?=
 =?us-ascii?Q?ox76Ihgg5yuudTeTrWI3xT5eGT3/8uDpeP2LU3J0dXfk/pWM0mnCnqEz0D3E?=
 =?us-ascii?Q?T4Ya1fZMDH3T3ol5LqW9V4fb7QImxs68se1BeY5VPc6zO+oex1YDELKKapmL?=
 =?us-ascii?Q?w5A0Oz8zlxa8O71kQG90Z5+afVrgGKbp3MT9W8nTFnb7CxsE6s24q9737+bq?=
 =?us-ascii?Q?jSrE3wCy1dolTc0CaOinNJbmH/nF+rJgDFwMfnauAvlTGz0fB4H7pQfJlYiW?=
 =?us-ascii?Q?noiBzjGi2Y/6GAnVee25wyIW+yQSnwcCWMc0hFvfIPbgA3Jz1L0f/7WWMh2Q?=
 =?us-ascii?Q?6UhMv4TzYQ67O+O/9puwMDiUZphGj+bTtOORy+vGV+pwopgjjv31OCL2vJMy?=
 =?us-ascii?Q?0HVXRbAdW9ru1gXBx0RzR25sUlOtMEbf+ZJmAuGZ9xLVBcgNAbZeGAldevSz?=
 =?us-ascii?Q?0GFuxAO/A35g7C3jw5liP7kcmIIXTcoqmnc3bbPVr4SsSpGZpVnFNC9myLUx?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37cbbaa-1eac-4a4a-ec90-08dad78e090b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:30:26.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kcn8DjtY1gtOKNxvXLjhitivQ05u6FvWWaroU8GFTLyhhj9MySqboBk9ZEU74p7TuEDolJpkz/d1Q0G1Zv6Wpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9228

v2:
- drop retrans_redundant flag.
- call __mptcp_retrans() directly.
- depends on "BPF redundant scheduler, part 2" v23.

v1:
- The DSS issue has been fixed in this version, and all tests
(mptcp_connect.sh, mptcp_join.sh, simult_flows.sh and BPF test_progs)
passed.
- No need to set already_sent to 0, drop this.
- Add retrans_redundant flag.
- depends on "BPF redundant scheduler, part 2" v22.

Geliang Tang (2):
  mptcp: add use_lock for mptcp_retrans
  mptcp: retrans for redundant sends

 net/mptcp/protocol.c | 51 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

-- 
2.35.3

