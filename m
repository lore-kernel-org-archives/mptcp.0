Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2047.outbound.protection.outlook.com [40.107.14.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C212565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6ZJOjS+dSPd1YWuarZuRIIw0/GN4ZHwqHYC8ZhR05uW2wxEKB8anzRXtYXiePPF+TbGcCerwXNbUW1YwuiCKcaz8KquUkw7i84pZ5waaISg0pVNwhLXlGkkCoyigBkUntBpdA5e2QH8B9djOSNmgjBW22dR6RZ7iHHN5hfmkT+XcoucArZ8ARqk1EXVq20CxIOsUdr+CbTtjDzJmzveQwahjXzZVth2aHrbTW4gr6I6k5g7YGkG0RZH0V5ClaEnAgxE3BEHam9EUU0171xZ3RgzmZ8B+Z9ESW3fLBiKY+cv6o+j/Ox38YOljx0WD/RxfJ3kd+6yCB7yAdbu2nYzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBhtd/ANFziG0QmGj3k4rTed5mTyRh/ckWhW4PnSemU=;
 b=h18thTB0XekPU+lNGCQxMG8KTGA21ixTie9aluOqSiI5bble9eZ/SxfhiWsScR8wgVUJDmkLnLWpn5wFzrhHQprb97TXmnahT+Q/veuyVg9uvzkBsleahob53UARrzPOBibbp7tzX3z+evZmHxN9Mf7DUgE/544tZQsfaMx0BfAew1iInfBt7CYJgfpUkk1zG/bLvUDBolYgbsAteR+K0exGZguCBCw9aRqS3k4o7v01iQ+yRiVY0xBVJLczIJU+6+NfZ03ChHYyUa/smv0T24CSjqqAxtt4Sk8KvJVdrsJO6QGS3FGt6NPjCfaD+xwZkm635F7a28/djO1KrOSi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBhtd/ANFziG0QmGj3k4rTed5mTyRh/ckWhW4PnSemU=;
 b=m96t8Jq/iV/6qGpeBrtaYxtUWnvgvDAzv2tBtN8f0pnVIOzTAiOpZ5MLCJXNE1HxSLl8IXqW+KZgqT1gIXgYXZwdgdorFGgSojkCs0Zm1j0pjseBpmhxTDkW4AY3FVl49m6ojuQc5TSBXTT7NgkdY+B4/jlhi1ad5fkrswworfBbQcRhd93lw71bRRxPnQRbtDEpMP+ARqAX5slniWdBjkMkQ9chtknOsPUbf7pGyXBHDLsO9vtL+Poc5Cpnc3nEzrz7J2SdQ7qjUeWy+IlfzrxU8rp8Qfx2YNr8+pYMsYzjOvkXIUSAAjJ29QHu4kWO7tqUgTy/onpPp21R/IvylQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:30:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:30:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/7] mptcp: add addr into userspace pm list
Date: Tue, 14 Mar 2023 15:31:39 +0800
Message-Id: <7f59cf86d68c27fb9785d4a8d84cbf9ae1437d3d.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
References: <cover.1678778977.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 359052d3-88bf-4a7c-33cd-08db245e060e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xMDziHovWUzckexT3hZPtN2xFyvfCAF5B0NvLR7LnUz4/Cs8LhnW9VFKtOWf+2XDIvTKmrajaAaqJC5CJiohtcsgdWYIn9NEQXeJAaLSaInjmGHoXN3NaG0xJz6fUbjI+Vf+rwbJgKRH1yCX+ugoj0W55bEWIOnEvlpFKb/sXRLC7o1jpLDYv77WmOZOpnmBEYA2dGDmoAJzeObyK9ab/7GIwXuuTyh9l1TVidtpu52cBK7WJGeYZC270K9p+Z6vcidD1UUXjhvJ6LmOwsxVJpZWKrko4Tl22WfcZhdge7bOJ2XlyVROctlJizGXku1cvJUPrP4tLJZ0gpwb8FcbOmsB4yLyTLAvedWAGVFAyRM7uYQ6AULLHj+2/pKA8HJ6qAM0bep6Cs8U/iLrFmLhjt+JESknK2lqk+HdAafH0b6gzY8CdcvE/EiUiXDjYJhbFpL/0k9wBKiEh/6jPaRTQRX5wSnQbFrmNfrQab4b5Saz/LDXj2xtDC+zs1L5kSNg5xcpaaMXvtcJQokj0RtPhDSCi2lXKGedOzc3uFt1UD4hbd/OxZBu7VkpftPfGe4C8JaYxIHGmankSCirT1dWFeq0FcYrlcOl4LdPn6YPj/0oLOkidRmzCqqlcHUjhFADTSgSx1msrLoqW45JEXGclBzTLTzu7P3wX4Qw8p9HeZoxygCp6wJtCuD+IdV+KnPK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(6506007)(6512007)(86362001)(6666004)(107886003)(4744005)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPIM1vSzcH68gxbQMxv9iDvbkUK9msgJwPd521IJHGusenfhYYTQwZ/mcbQ0?=
 =?us-ascii?Q?jIyeee5pHGXHOVINhwfemneY+nAuSkcKRiWEQNuYKO9dWonvEySL8yF+Huwg?=
 =?us-ascii?Q?01az3878lHbvdd4sOt0sr+jF9AOqmJOtWRkPZMxwJo2Nd1jTK9jjpF4IDFeF?=
 =?us-ascii?Q?U8UH4tCNWVzcdEPoycQ31A8xhbxXdOMhFo1fMDRurmFCumbbrgATOPsU4/3M?=
 =?us-ascii?Q?AIYEH/DTuFNbWkUmetMeq8aG3gqI7g2fpiuTYKdCiokI7X2AAPQxvhcNnHsV?=
 =?us-ascii?Q?kkAwARtKGoRVk2hTf+21ttjjsGb4y4pK/9+qxZfVTSMJ7TGtk7EssVyv3lMr?=
 =?us-ascii?Q?+rqNruDQKA1aTyz7sv6qsctiQC8klOe/Coi3/S89XevpStncwvyQlGk2P8L1?=
 =?us-ascii?Q?nJbkL+eq37x3Qui3yuam7x7Bseb9zX5CXqWcjVGZ36r6A1IdoBzxmiovktQh?=
 =?us-ascii?Q?Q6w7uOMDGESFGV5szbIzR5yXvhJfvYFumT7NAWGmz+jZlUrpYrxMvVHkXJkv?=
 =?us-ascii?Q?+sw71SQfpY4jUYPfhNlhgkmT2gWR//7DcOVcw0k3erdhZep7mr+Ld817BLT8?=
 =?us-ascii?Q?ldsh4b5AiPx4LIyUvL7tOLlQx7PYSMnHgmeKc4oHiYhKlH7lLXM4plqq741y?=
 =?us-ascii?Q?GMzu6Qd9FY0XRYwAQGYichZvnaIk3epxafR01T+HwDqpnwfesoxewtoA3k6E?=
 =?us-ascii?Q?3oWJDCcIUXygUs95Ik0jAQayHcXo1vTLBcZ7ub5qSHXHcn0iPiM5gPdP4CIV?=
 =?us-ascii?Q?MlVY0w7S9smzAEkG50OCpLOk8pRkl82yoNdwmds6F3n1B1qDGwhOaeAayTBr?=
 =?us-ascii?Q?8Pd7Pb8NaBcxvpmrf4Z2+tr/No5Q0VAXfmHkeMNMGn4uhIN5rgIAo/YMYRil?=
 =?us-ascii?Q?GVsWHE6WKFpmfLymPePC/tkoSgMUeD92kiEaJX1ffGIKL6OE9XZOdl30YEZ1?=
 =?us-ascii?Q?EptrPRGbIgNm8C3NjTGtyCrw8Rvin142qEePIhNrerK/cgc54Hgcd7NdjthJ?=
 =?us-ascii?Q?c3aBx9zNQFdV3r1lqw41l/DM8Is6FV293mclbP6QoJkwPFbp1C86QHDm72pN?=
 =?us-ascii?Q?SxrT/Odicq/eLRaeEPO6+GorDsNd84eeV0r9ZdYm8jGNCo9reTeym5aNjD8f?=
 =?us-ascii?Q?+fcJwECYaML+XMO+Tsg9anwlfR6tp5eBKeF9XLhdpqHypW/MtZ8zYS1lnOkN?=
 =?us-ascii?Q?e1JB9WdbC/3phDDNhm28h/ibakaY2f8WqTypW9PaBM5UUOflgRV64+hwtgy7?=
 =?us-ascii?Q?ChJP206MplQHns8GACqt0BcbuDP+MGBsI/TFmAqTNI0dKi71qHiKp2qj7TOc?=
 =?us-ascii?Q?V471SYslT7s1fqeYHEtQKfWmfoldMDv9oTg3Oi5hwo5026B2vb7qbP0L58rn?=
 =?us-ascii?Q?6hkBKDhLwKy/zOmQWx5ujVym2qMwWFxNI7Fi1ffFlWp+MIP7pXrqM2rbKALF?=
 =?us-ascii?Q?uqToPBFm2g2mU1OVIRlUG7PAB5ol0P5sC0vpnuFjxLLiO3SBr0ZvFAiUNlbE?=
 =?us-ascii?Q?VN5ux1CSD1xPyoiVFQOGPGIz7i9qrj9qnoSimO1OU5t98qOdr9IxHaat1z/0?=
 =?us-ascii?Q?GZ9NwTxtirscddtpLybq2e3k+ySEuMogNFNmtiTKFIEGZUFkReVFS3Sjz2oO?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359052d3-88bf-4a7c-33cd-08db245e060e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:30:45.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYryL9o2kB3PQvbT+Fgc4e4pN0hA8O0YZlxFjUj1q5UL47T5Pfwi86jVSvqHsOjTKGto8Q1utjv/DS8H1bTpAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

Add the address into userspace_pm_local_addr_list when the subflow is
created.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fe4c29a17466..49f41a040485 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -301,6 +301,16 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	err = mptcp_userspace_pm_get_local_id(msk, &addr_l);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used++;
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
-- 
2.35.3

