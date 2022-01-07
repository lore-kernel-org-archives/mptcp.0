Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D02C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Gakl/1oi3UhJnCCcfs0bOIKodu5GO3RTnhoaVrSRo0=;
	b=i0iT2ouFxPQi/FsCvrd/D3uiZMvZxPUWifpyf9Nx7utIfjAqorb7K4FXhgYv2T+Q5al4e1
	bG5MzUTt6psU7NNaprbrJ3P/pDSZzZkyPv8nJ5arK2lX0xee4kOBdfkpuWGv2R438L9BJT
	oZdvp4/b0EjDafp2QGErmhPgJ13hf1w=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-ZH2ODmp2OEuNCWeOrZb9Yw-1; Fri, 07 Jan 2022 06:52:33 +0100
X-MC-Unique: ZH2ODmp2OEuNCWeOrZb9Yw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZItfVAH8bVmjKgT6KYUBqBopDxLLPZmqVylUZDaqgd8i9hv82nDrje/2XO5UU56nzH4zuQE60/xu6yXBfPidnm5NdNqJLCt3FWOf65K3U+55X/hUm5KMrmUIxPoQXdXLkO0tVjBZ6ATMh8eIyppp/8ScM/G6T61+F89IOMu9wSPLHof2G7tMleYgIGfhbtK3pbBaByp2o1E5F1Z7PiF5PY9WWDDAY+qm5ueOH1MzGVT0eBp5xJMo9Y2k9ycwOm9HrCyZTHJqhYOQNf1J9jb5rmUlf2DUZ1MUZclEOopFL75dA5r3Ti4D+c1728Z+eUOGsIAYtBTWMmaTd2VSMCkgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKuxTA1hKnYssbztwJlrQQGu4f4+mjb+wV1dksG9yRo=;
 b=LkK/zxjUoSs4Pqy+Svtrh1I4G22ZMa217v2cyVP9sFNH8YpK5I4P8BAzeef2bzxiJw/TGRWzqETsooHUOpoauv8zLv9CGhAkbxt53FvbBcNt2IB6cYhguxPtl+FisDRH2FHvDHB++gqkd7I16uYNJY1tLZSIsRgk675dKmZUhclIK96cKORofjkCvVEObfTOTLgMQmny05WMYkICco9n75r/Nets2tukc5aN3hc0XFB9/VbyhXWy0Zs4qk/QgHpTNXsnAaXG4ata5QQ4I/l62g4aZ3fjmJ63XIE3HtgN27DHWgAgqeLsMuDhVAA/YAxGESytKbmmUnylYV1eCg83Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 5/9] selftests: mptcp: implement pm_nl_del_endpoint
Date: Fri,  7 Jan 2022 13:51:47 +0800
Message-ID: <879af8688a7d9e1744a561db5616385a1353cf0b.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0897b8e7-7302-4f80-35ed-08d9d1a1e59a
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2731DF6FAF0BB6F646E2264BF84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ihXGXWr14I6OvO3ycMmStlmfItWDvmO+qHko392eVbvMJlxy05HtpFlZzV1HgQGb1cGi07Yi2Cog2nQjbYi7BAXwQFC1hIOuGJ97IGoCvm3lAg6puAK+0nj5MYtM8JBSkOZkpNsigY6ksUl6aGD+61ykmTs6kwDXjKIde4VaTcfBU5XUL2IGvI6MpczhlnZqmYwkxn7Q8lwuM9NE9IkhJXvGDH2PvQKix12NVeebI0h2iTLEhpO987K81goVwflwtGqEJwdYrGlryKXayJSPuOE/C8PLwrCDG0MYmetFOXw801KIAfuNVthHFWxEpqN/VscZF7naMR+owTTLvxJIdXRvOn//KdGgcDoStYZxku/4v2HZMP9HHJpdJKkVVYs6c9EYNw4j7Z0yQwFS0j/aE7P7iH74wttsPyiDGPSZINeiWzybANvf1HJNn/oeaT4/YJ3NnQwIy28l7sjTnrEeMnYdWOxRXdnwnmQb/2Y4TDRKkPp17nbN1NSd7lp35M+TU/JNTI1RGgMwKAAKImd703wZPnJ8tS+jEiH1zdbXGxsDD3yhnxWF7ZzI6v1fSvsuRpxD0DuKIYEIBXoNzGvBVIEJHlPOH67Ifjji0QEoKYQ/cb/+B2ZQ2ysUjvfE0OYtIrlEGAspx/gaItXkUJDVEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(6666004)(55236004)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xzLrOUV8E5wp9exx6x2XYS86S/3zwe4ZhIGA0kIqUAACSXVdyOx3xzHtJFN9?=
 =?us-ascii?Q?8/xmy07EsRC8OVqJxQJL3SxsmMk6P3zLUA0NX3djTX6BbQDm3QqUQFVIRM0u?=
 =?us-ascii?Q?FhFWHL4+pUulE8oNiacGAuMzsocmMycaXlI9X9Bcj8Dyr7HkCl4o542Sopgx?=
 =?us-ascii?Q?RDEdbBoGdnYmLRxqDRm+DJOpsMyjBTj6fSd/fWT7FLDcb8ob0djdRzKxXyry?=
 =?us-ascii?Q?zbDsLRYkTu2Cq4YSSj6qUUdFyABSpxAmo8tyD613L3NrdxIznzszPy08xgsy?=
 =?us-ascii?Q?Qsjdj4FFOGBuqg85XV3BCv5PJuSj/GmFIFBIankn39/QrRl68rrW/V11feSn?=
 =?us-ascii?Q?cJKR1CBZAZgCDtlEO0yjHZqe/mBryZwMb0EqIBbf9tUy8AdtmWjM75YYaJSC?=
 =?us-ascii?Q?B0VCZISaNQZBcaFElefZVACUG39UEcI1Jr7zN8Rqye0TVf9Nt7ZlHU90BxPE?=
 =?us-ascii?Q?yuHfNglW2wZDECmk6Yo6/+1OmzvFkwiY4XbHglRqUrgGE48HBhGlm1Y86BYv?=
 =?us-ascii?Q?RiExVfau2Vxjtmnefebm/yQR3xDhO/ISjEgsebI2AaE6z5Ggq96iouJtN4di?=
 =?us-ascii?Q?7DsY6HOr4mExsKtr874gie6PG8HZEmAytCtZJLBxMZniI5OXierZIkoDOjT3?=
 =?us-ascii?Q?VLouzrBNrNqreXQjYYu5aH0fr99a09kB8uxKhRUY7xtKgYQTby2kSRxH/vUH?=
 =?us-ascii?Q?HP0qArqO6MMzatExj6+pukEuYmXT15ReZ/nRiS0SDi8l0evy1iTBF9T+0gHr?=
 =?us-ascii?Q?vkYGM28HRMII/2p83DsdM4PjBRIXMajoxZuFRmD/I8m4IRmFT/y/NHjEK+df?=
 =?us-ascii?Q?QpO8yYmSLG2pCH0W2cXsBFWGfzxJm03RjzvR7+WuEqB/V19d3SNDInVaEFF0?=
 =?us-ascii?Q?ZkMDwSVrPM+mZ3KnDH79KzqW1hLccJLB3dAMV3zVLIOwdLnQ0h/84WoW5p23?=
 =?us-ascii?Q?cZW/2WZQ7vWRDpRDaT7t0uGTNNlnzJI4AV8WRLfAQouJm0zkImj+sgs09fXz?=
 =?us-ascii?Q?X2s0UlxY85MElvyZrmw/QHgC/4Qe9U91TAG9LDg1BtrwwrNo4BUGYt2ATdYW?=
 =?us-ascii?Q?MRcBuXKA9HqhTKCJbex10eJy5wczU9UuwdgmNhtBiBM/6ImIWabLwiMUR8su?=
 =?us-ascii?Q?8ll7Movgqg1zkt9J4yJeQUkQQzx+ZN82QrP278ldOFrNWserdxw6FPg46z6w?=
 =?us-ascii?Q?RlwAK7okmLt0i9W5fA8CvE3nASJnRwaOBFIQ7WxSRf86ElXNace96y5zqLJT?=
 =?us-ascii?Q?rkDhU6Dru5T+46TLCfR0qepFuCYwdvDZjggy3GR6LyuE4UqgqtEs8hFkDcAM?=
 =?us-ascii?Q?WJ6GK3efgi+mZaCrY+mrT0Do9elMNRRVymRz/NJrq7SIRn8ahdv8A7Zev+Df?=
 =?us-ascii?Q?MAWzHH+o1WbaLPkBNE/Ux/XQhCGQAqiAifzG0isFPZPZ0tqwg/fPdywE0p4d?=
 =?us-ascii?Q?aQLAXAWUtrAucQUur3TYbUMmEgi386c8Y2yucQ+cHsJTwKvoJatfy4tI7SM7?=
 =?us-ascii?Q?c2JTRHtpM2iChLeBgfsrC5TQuymGUuYLuZLVYMftjC65zHT0BFz1TJsAJawx?=
 =?us-ascii?Q?+K8pAZvuNLr731C1l9XiHxjQrVKxSubQN01/F5U+48i9vJaKqndwVg+j7NK3?=
 =?us-ascii?Q?xhnADLy2J/9d6C7gbYHiRVI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0897b8e7-7302-4f80-35ed-08d9d1a1e59a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:32.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hr+kp0wM3pmDjvTk882bYC6ZCyehLueszMM/nDO0/fYvmMcVlOZXTK3rH9UwrDtTIyRuGYw1S9ROMLCGUiIgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

This patch implemented a new function named pm_nl_del_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use for deleting the PM
endpoint.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 740258ad45b1..2dd6523a7e2d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -339,6 +339,19 @@ pm_nl_add_endpoint()
 	fi
 }
=20
+pm_nl_del_endpoint()
+{
+	local ns=3D$1
+	local id=3D$2
+	local addr=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint delete id $id $addr
+	else
+		ip netns exec $ns ./pm_nl_ctl del $id $addr
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -458,7 +471,7 @@ do_transfer()
 						fi
 						id=3D${arr[$nr+1]}
 						rm_addr=3D$(rm_addr_count ${connector_ns})
-						ip netns exec ${listener_ns} ./pm_nl_ctl del $id
+						pm_nl_del_endpoint ${listener_ns} $id
 						wait_rm_addr ${connector_ns} ${rm_addr}
 						let counter+=3D1
 					fi
@@ -468,7 +481,7 @@ do_transfer()
 		elif [ $rm_nr_ns1 -eq 8 ]; then
 			ip netns exec ${listener_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns1 -eq 9 ]; then
-			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
+			pm_nl_del_endpoint ${listener_ns} 0 ${connect_addr}
 		fi
 	fi
=20
@@ -512,7 +525,7 @@ do_transfer()
 						# rm_addr are serialized, allow the previous one to complete
 						id=3D${arr[$nr+1]}
 						rm_addr=3D$(rm_addr_count ${listener_ns})
-						ip netns exec ${connector_ns} ./pm_nl_ctl del $id
+						pm_nl_del_endpoint ${connector_ns} $id
 						wait_rm_addr ${listener_ns} ${rm_addr}
 						let counter+=3D1
 					fi
@@ -528,7 +541,7 @@ do_transfer()
 			else
 				addr=3D"10.0.1.2"
 			fi
-			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
+			pm_nl_del_endpoint ${connector_ns} 0 $addr
 		fi
 	fi
=20
--=20
2.31.1

