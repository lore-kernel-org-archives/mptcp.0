Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69592C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxpPU3faiTVPpP53ArxDpu5Vw4w/SF5ZxS7Yzd7zIio=;
	b=Dwy/MxSxQ9+Ifc7C+y50xj0/maYqUsrG1fQF8QLUR3aJ/u7SG3TnNn4HlMRGp2mj1enLxe
	iooDULWM5CdgRiQXaBK2r5PrCrEPvhScu8rjn/Au2Zh9UKO+g8neE2vo/481Zg5/5K0H0h
	hZ4JLoI0A1B8/yVzXabDn53/JNzpglw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-2r22QWFwOzG_ZHBAHPRjxQ-1; Fri, 07 Jan 2022 06:52:54 +0100
X-MC-Unique: 2r22QWFwOzG_ZHBAHPRjxQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEOU8vClk8tEX4zNkM41avUnJOgG59RkU2I1OgrfRY6b2XVL++uQlNdxeTBrKRIUyiv9YLC0pX4pRAYWklDFyNrHv45BFXQ5Uo0+/QxmXK4Smq5xV9EiheJfmLHV3eFtJ289JVjiR4zxeqdO4scDzUhUA5msNhaB1vyQx56m+gAPgTEuO69g1pWtkmU/rbY9Snc/qtOXkETWrRXBvyRL2CtGqRgPQpZO9CG1/D8z6TYJ7m1KRCNxiaGGDPdptlUKCLjmydTBezZ4OWjtPN1tppg71svLvIK1H88sPu54yaMJRfnH4HfiIRVQco917+pNPPObx/p+NcAMkxI9fYkUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABoVNMGBW9tFQ2yay8f2OB196D7pkNe5cBL1Epj2aXE=;
 b=gEdgoZjCpEhAmsOTyPk1mYEf5tOKRrgWXH2SDJ2pI+pPF0FnQeQm+Ak/Z90S9Wqnxa/CaFZu3+zh97LANf//X4YoBsGK6ZwM/H2YcQJyzyj+LJJRa8clBnib4Al340Ixc0who3TVhRuCPatBpg7k3l8t9++6WluSqrRV4s7NnkQIx8CabIdNlf08aRqf9xGflTqfnllHixswdl5c4joUuKLFtAliWrSnjioNQ2FMuLjsMPY6u2kSjb4jHQmQu1sju9gfd2WI0sPLHtSP48OzPX+vo1w2NUTXZyGrfntBXnf3t1eQoRXT0Eo5YojiEnEEddMu5Vvqywyf1zJkkv70hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 8/9] selftests: mptcp: implement pm_nl_set_endpoint
Date: Fri,  7 Jan 2022 13:51:50 +0800
Message-ID: <16ab61c7b75ba013da044168778878aa470fbc1d.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d0832d-802e-426a-25ad-08d9d1a1f217
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2731C97B3C856F5E12F123AAF84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QpPRwgyTgcOno/Q6VhKiOwdGMR8gKctzR0pJ7z8R+pHC55JtDeD5f2/3laf5EJlJvA6naa0Rp9mjjpWIlNWdWun8fuV9OcDg8BlYZuBacCA+ARYGi60Y2xBL8wn3K0yh2K9xWk6/7FPl8DOBbTvbnqXNE2RD4YK7vm26Z8ztk3Q7fziB3DyRTcWxLOPsbIuwtVz2FvdZd2GdeY0tIqHTX4e9rY4S5rcfoyP1yUt2G1AP9o5pK6PhGJRlWe9gE4Zzw9j7vlgxYvl/K7b6hLHKW20PLRy0trKupJQgT0sYCHvCMhup3cIovOqqzcPfY7cO4Mw9SuDagMw30eeAj7frB8uFAGQbQ47p1KVMEbSv0CGfsC8JD/oSKPC6YT3K3kbDFVEFKQe4wIe9IhN+OJw6Si+s/vpU0X2x2L+22LI+1U7Gjq04f70xMomBZB6dyKK7tUGjHtM6gpyqndtEOJfbUZZ5OKbR4zROycrkUCwP56lTPBEHYQwn/bWCrvE/p2Nod3QPTcQxUUZ4dSxFS4hfZRKQVZLmO74O1js2raeKNuBg9rJpCPHqxvXuYRuqwyqhBWYZifXzSVq0MTtXGa9GmiHi0UI7NF+41X9AW8b60iSIotwju/FGzD1rRgi+17XPNlLnHEfrg+0cxRfk93Bvpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(55236004)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?riPnHz0kGBeFL0fn3fZcx6suXTH6IEw1J2aLwgYn3Ltoz6QGq+H+jaX9AUyX?=
 =?us-ascii?Q?ImFEdgRwPdqxw6DiojnrN9+EMLP3EJyGDnlc5pF+Du9cDSjcMK3L+s0GxlSc?=
 =?us-ascii?Q?YPWBetGhgVmpOf7hYkvu8FoBpkMZ0T3aVOxu6O60mK8xJT+yHT0EreN/O50b?=
 =?us-ascii?Q?PeLxjoajWyoXVoulejCxCn8tDAJFkPN66T+8oFEq5fHQ1SqN77y8FdoWiSbI?=
 =?us-ascii?Q?qfvI0axElXAT0y23RgL1aoF5Pt9UPyR/uTbaxrEjP/9aRbsjeSX+nmWrGQUU?=
 =?us-ascii?Q?u/WSLcEK/JfC2LnvIf2gTtN24hf3Q3LbltWyC9PYoJbvgnKZhxIgHLt2yBfy?=
 =?us-ascii?Q?L/4P7bszc7LrUD3Mf1GtmQsAWp6nJAPVYE4PaNClBCXNpcEt6xI6JR2/02VS?=
 =?us-ascii?Q?MtwYjjXV445UwxBbYXiOmZDtupwk21tOf39RD4QVb+1qwLEoDcn7pgUExmmS?=
 =?us-ascii?Q?4sRuOsFRdhT7ta+2E+0lNCL8qA/J36eyE1+jE0Q3/77gbMk6LGEZkcso3lYY?=
 =?us-ascii?Q?BhNegn3Df79e0MZyPNp1cObl1dtCBkhatGWdx5yjdEbDo3QJUET1oOeJ9jy9?=
 =?us-ascii?Q?E+Av771kNDlvxQPELmiY0R6DuvKoABFb8G8z6CuJTYE0rt/v27CKJ0fiC7YJ?=
 =?us-ascii?Q?QBjeqNdCTpOjTBGy9dFy6ocSAP6iAHr8NKb0pBVrtHIpFk4BdizA7nspLHbs?=
 =?us-ascii?Q?EH3FAgFUrAII25kEs/fNwaRmqpit0ZHlEe/R6/md7UYFMyne8s0iQtzenvdd?=
 =?us-ascii?Q?NnjUjcl/wRGlwVbGfhoq+2zFRMmfZgV4kPHgu9xSDYnZ58qj0lG5D5uPjC20?=
 =?us-ascii?Q?I2uxk93KvSzmmh+51pakYFFbvdV2qmpiWs8Qcn7wQw6ZF4OLYZl6iqOI9RCu?=
 =?us-ascii?Q?mSrqEaoBlvdylNnW0AqLtywpDfhLN4kEIM/3iIaLj3hwg6tTCFfXMkZPVMvs?=
 =?us-ascii?Q?OcH3Z6eq/jr+NLFAGczsf+E2702hVIaTXqzAmPZp4In2b2jBCgJ9vX0t0lW3?=
 =?us-ascii?Q?IWviv0IjAD38AHt2J4JdqdClQddjMPMtRZKz44+i/xV3O83JN9TxbcmonaBR?=
 =?us-ascii?Q?2YoRVi5MPQmZAh3iomOInL6c9ryY6lb1KnSKoEQYAqBlQ34A199ukqo9j74V?=
 =?us-ascii?Q?oFokFFOBLFVckN/CDeexDOMWYT9IlVy8mRuK54zTj27rCQTtOGAEr9FWUoAH?=
 =?us-ascii?Q?oJ4Go5W7+OihrB8bmrcK9pmwp5cikzG0JpCcYCIPgtA3C1wbfdouTovFDlhc?=
 =?us-ascii?Q?8EOjXaF8vJkq/dnaYTPKqyx80MXCzW5+AKh3urixVi23wxro5KPwkLdf+N67?=
 =?us-ascii?Q?obBNuED4H0p+LVX9feesZNo3GSildpd1HFFpByR9g72DMRkHItl3QuJIMXyS?=
 =?us-ascii?Q?dzR928eLFf3eWAX8t74K7oRM3ybZY7a59/pNB8yWG61mCFQLjJoHcV5lYmRL?=
 =?us-ascii?Q?kxGbrdQZiR9M09LFIqpPZZr5MI8q7RbsXxSAsNgpUvwx6r0HkLHNYxvzcMo1?=
 =?us-ascii?Q?R40wAItot930N/MS8zIiM/wqr2DVeR+7B0L2i8+7eV60HVMRUtnNYITh0fBw?=
 =?us-ascii?Q?6oHyUp9nCsdtsaycKb0IevnUirsVHOn+ryHwX7a2/obyANdUrSD2thaCf+aw?=
 =?us-ascii?Q?cvzKURgjPUD2Q9ey68KPosM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d0832d-802e-426a-25ad-08d9d1a1f217
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:53.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhrCnzNzuK+7W0rmcV6bUF44AceVOiIaVRx9WjbEVTZM0UHHE94zL6JurznqJNI2Yx/+aFuQa1DlHXDmbPusHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to set the flags of the PM
endpoint.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ce36205f2e0a..9d1f1ffd822b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -374,6 +374,19 @@ pm_nl_show_endpoint()
 	fi
 }
=20
+pm_nl_set_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local bkup=3D$3
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint set $addr $bkup
+	else
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $bkup
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -580,7 +593,7 @@ do_transfer()
 					pos=3D0
 				fi
 				addr=3D${arr[$pos]}
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
+				pm_nl_set_endpoint $netns $addr $bkup
 			done
 		done
 	fi
--=20
2.31.1

