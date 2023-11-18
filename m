Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D0F51D
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="u8N5SAob"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtQq1YUvldS8QNMsqH69njP99OfJufu5eJ7/EC1SmxdGEwwkgbG5FNaBSpJHBKARJ3Cdi5O2JWgU64EMuGHWwkH3Qw5MZVs6B/4c76/GcsOVlHmhOFe1CbiuLGcR+ZNaDGdZNvYe3y78TrL7YmLD4vUGIuxPf6SWNqZVkBeJeVMlPDinJMoehqgAko/G3OEu4ElCS8rFcvcDq+ix9EQLo5tJVqUadEANnn05BwukXMMeLot1WsfHnRsDuRZEqpUmZib1HdzFYLwQF9coj0Tjeo00jP6kP12+I9mO7BAULiz7Td8G6Jd4e4B1t+pirWKLsefKwxyhahS382CtrIf+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=Q00Vzk8LK/g1SyPrCBtXFWsVaati2DHR3SkZ+HsUBVdQOsd70oCosSZZbu0p+y8r1CvpL22gHBIZJipwx11dKzzBP8T/KJupjesNa/rk4OFSWU/9s17YaNxT3jAAlZsrAKp6zwH9gRyrKCojXuNgT2/sIQPH+AhafgV8bW1pDoqBIQnkeUm6ou+1PPkgjBvuD+JL6jJqgEHeShG0xSH87Mr/spzWZ+eazFSXdEMhNTKVNmrO1KEwvqg8FYPe/WBVnvmB/iOUlRV8kYGECPJqsLCt21oN5m+sgd/7nEPiS5Xg1QbUUHmwGXatpE6CapgyXqOYOXtNFzx2gqF3KXliKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=u8N5SAobt4S+SXyWWvqYTAa7XWmW//zR4TIhyJYeAPpMyfRTP8smCPoynoNrv0J3PMR4o7w5S+PWoBRcjMXThDXqH61O2PhbQvDLfBsgWcwaZi5duJeoyyRur+hCE2u0KkOKLWs7VykC6mt0YSS2mRJ7YVM51w6aWggx2Q6YPZy1cqnmwGuHjxG5P5bphIMUMBMMcfBvvqj4Gh5BfECZnGs6va5dc3YeiP+uPHuzy0XXF6Xl5Ien9HO5OspaTaLLF13/oBHx3I/9UJ74TeGrcCi0vK3U17HtyJC1YUgI/7JJkmkh0/d9BhkHYWtIPy/82XD5yOefgFFJ8ogPJFUrzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:29:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:29:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 08/27] selftests: mptcp: add userspace pm subflow flag
Date: Sat, 18 Nov 2023 22:28:23 +0800
Message-Id: <6f9cd54cbffa04c87c85e126cf5d62b69baa3fdf.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0197.jpnprd01.prod.outlook.com (2603:1096:403::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c03a969-ec6f-4337-6e97-08dbe842d290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5c2cLcCYDFOiHNnUagtbkGH5F3GD/KKhsLWTgj54WaTS3kZEq4rgPihVZCmt6QotptFeT6mLezsxA6hSrKbNQZ1xZtEba53akWAu25oFBTKrdPUrhWgUxTrOAMu1aXRi4tNS/bO8A/mVbx1Da3hC3exAP0DR5r6LM9HHIkBnzb0zGZiLbX7JvuTbiPbeApqjTpw5X38yb7K44iBMVFFVSI2oQ35YAIN75wAGhOjPyUT14rcL85k2F3BwEvqYmKFeMq+mauvyk5ZtP91QOSXbUNRjW8FxvikviEIbe1AeUQ8lqG7lUQQqHdqrYoKltBVDJq4plZ+60mi/S1kd2G9KQIEL8VWZy+VFri/hmrdiUiXybFp6ybq6BR3Z9rwQ1+Orq6gb+wNDxff5ojLVW+uh0oQnI6tplvgRNQZdEmg1kKrgtpSFlm7ukpTVtK2//+0zaNK3iOe2scTU0/2RJR5zl9Nrp0WxlgwuzlJOspk+h2KQMUzlGW77HzisPsFBiOZkaFZ0+ODBxwr7QJKexUtx76Eeq2F72mKQ9WA7HC9D76aebWV8wv0rnsTkAwta7vV2pQKtHfWEP71bN8PStkZLxn+H6nX8ybm0D+TqSMdyXSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oATpF1nUaGPsNtTicLVqtaxhv7Pf+PrFvidK0SvHdly11zVEjABuI0+M/uyO?=
 =?us-ascii?Q?gxGsiwKATWuQpC+gbnmlyDncQ8JlWoNJRSdBn8ctRaW9PGO/cqmSvOzyOOgz?=
 =?us-ascii?Q?+FycUY3eOKe1EpkqE2pCE850cXDED03szXmr56ruWCKKUhbD12CvCcjC02Li?=
 =?us-ascii?Q?BW2V94qzyHrBQRPX7BfbLSbLq0/fDqD6F+hiGiJaYarrZDFG3xvB1A7+PEsU?=
 =?us-ascii?Q?gtFaHdftl9NEvibR4WdXw27wvvprFfRyLvkCLU4K79JkqSYzgsEi6FcmVj4T?=
 =?us-ascii?Q?Dj5P8HjTxNw66qJcoi8/2YnqFm+23SzYJoZr4eMwrV3RwoQ0QYd9QktysdKZ?=
 =?us-ascii?Q?H8Ze5B5lM1ZS4jOyMIB4lTtXZSzzHkEAaYIG17iAeKdqGnHoQg+LE8JwKqj7?=
 =?us-ascii?Q?wV90Jqh/DLkg/1zc+1/l6Yt8KjcjuEJuYa4yLLnTQFlgOqaVqEknMY7GMdcW?=
 =?us-ascii?Q?crtzl4nPyEQK9AB1ITTcXNeP5w75qpmEMJqrf7rb+emQmzh06FaxvJQDlT2y?=
 =?us-ascii?Q?7CGqXGDtr38IJfsIJ5DmkuICaN3nAWpgmOWSGoOThA6JizXeT/gBnnefUX5j?=
 =?us-ascii?Q?wdew0BcE35EDoxzOR8ul9KrpUHHjlW4ZJpRHPobGIyOlMvJKiOk1kxy50Rhy?=
 =?us-ascii?Q?Mx1iDTPi9Ijs1YYN8Kfbv0i4L/0JLCM7ZNrrmv5mBaDXtixITQ6aql/ifYX1?=
 =?us-ascii?Q?Xma5u9rB4gvX+iUm0EN3QN3rLZMERRLZ1T0IL0ug+7BLl7ZX87m/zQ2by3vS?=
 =?us-ascii?Q?yUcehhMqJLqbKkttnR654r0YzqO7kVCubiM/yCkGo9JE8hFRokEGdl10qnlE?=
 =?us-ascii?Q?7iGe6D+8tvYHpaWSQRFBY58FDmIOlZOdsy/7k0hyxXLwr2OdWKh/qa7Zhrd2?=
 =?us-ascii?Q?2uckLuAWvMbslikMFH4nFnxKOx8Gqm7HUfrhPoyjHVxdqZRCVmcSUEFR0Krl?=
 =?us-ascii?Q?5qoQwSEQLZWGRJNNv4gaPsy6/nKC4VYjHemFJe3oOlq6gm8V+rZE1dYCbgcX?=
 =?us-ascii?Q?Lgg/VpePkWzddgcbpnoIko+A+qGOE+yZoJ7wdnUpurI7AUYJM8ZXiMRjtEXP?=
 =?us-ascii?Q?q7yCfvEDSCAWe5/xP2KJ2vTXnttAG07xM673sh34uSkB9gMcSfLqRdoi2kgH?=
 =?us-ascii?Q?/EsMx4hq1A5cMteO+IYpGMsnjyrwGIqdKCT9BxIiFWpk3gRaZVl7jx9S0Zdu?=
 =?us-ascii?Q?pA5iJ071hto3TwCdfJNtHJRgvxmqJIi1OVYWrOhDyOEEyhfF5tyQ76h7oXY5?=
 =?us-ascii?Q?OXzI6Duc2DJ3TanxSi5/J/Gk3HEoy98fkaNOe6sKjdCyY0dEKlQKj+A9byh+?=
 =?us-ascii?Q?4yFafh5/j3IggTYbuVjVdzWbWNhkuDxSP2roJs2hvP3Sq3B6rUFUE310HRMM?=
 =?us-ascii?Q?6PdRL5Qt+gmv0nElDhYEVUUsSI587v8EcwMV8D2uslGu2sI1WO1fdEVXw24Q?=
 =?us-ascii?Q?joIL+4/ifq/5J9N8fh84wilaT5wgkMmdyOiLcG34yJGCzzq35KcaASM/xyk4?=
 =?us-ascii?Q?BEc0Ay55Ge3TkInJGSnqFBspTutD93Sg/nRnsBs88Rr9xIMj2X93s35ZvHom?=
 =?us-ascii?Q?3Ga7rv8BERz8hbIDCX0ggsBaGL+bmgN1tZdZoeNBKvWASJPXWo76CEjuGhL1?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c03a969-ec6f-4337-6e97-08dbe842d290
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:29:50.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlh+vvDW/cmrCyH4QyTQxHfFGNF+9pMWkGAARJMVI2fFE3gw+WISIxxYDN148i12VfO2ZF3kWIiabwIMvAbKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf() in
pm_nl_ctl.c when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 
-- 
2.35.3

