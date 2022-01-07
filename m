Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC22C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxUaQjphST/TmAQw7dnm9aHRbJV15FSE/LLTUMpaWow=;
	b=jQhwDfedv8NxWz5MNxoivnCbSkxJtbWxPp/Q9qGXWkCoJ9H4soa0Bsp6GuFZ+5dJpNiLy6
	7kVlvSV1cGhaj/F5hqUogOz1KdCjwL+exWhJkFjABsU32XHGna3Mh3YMgJ8NfMZMLPiwbg
	BBdEtnRtWJP7CM0UtuR9ScFBNxNZ6uo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-d1NQ_TKgONmn7LWppd-_WA-1; Fri, 07 Jan 2022 07:17:47 +0100
X-MC-Unique: d1NQ_TKgONmn7LWppd-_WA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MliUdJ/jz8VO2OhHNg71Gb5NrqhFuBGsg8+lHGq13Nz2VaD5HynmQDazHtZD6nEUgTZpIVFg9W7nDem5FA944Xljthxo1RRnC1RPKFQR8kP2BaYCp8H3tC2IoSvX379Dg2YRo4kW/29PNXRJZrA7nYM6NsuDQZo+AJaY9PfFh0nuPH/fsUJ8QyUbOL37eT+CoJ/WjdjloOtYpFedShNy15ua0sZK+Px4ii7qEK6OO/fG8RjnJBwfE/9ddmcreGQmH0kdVwF0Pi6ocwLbQmlU4aU9ZT+IUiogtJjQtSoM+m3NNyNUpDtPji2gJxIgiR9SMucrb8xlyLDzRZ2yZv+DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG96a1ZURtIWCxWm8VwSq/3WnW99mwWviZ2kjj+4Ims=;
 b=K1Qiyc7E4Mi25SkFV9nuudPpUcV2GgrNSQ9NeXs+IiQCW4Wl1HbXWXr3mdATPaTU/HDUVANdTuyhLLGD/bVNKGKzc8ELqqRswob8v1YtIqp0sWTnqts5gom1xEMujHYSNK1VoeV+G7cvSi/6AoSSDCvwEAmsfRHovhA7OaDUHPs7cK8OWEmgykC7RaQgan3m0lR5+UUgE68rAG3rctUlMyLsmEKmMdj2zfEQ9lkIyM2df6XDFyLvKf9dPY2DcCm45FLDCC94fppyJumRBkLsPLVl/2wxnx1Ex2V8NSpZq0JMjexQcoWqxuwrNzxRERIhDCVvB1kXLgBCQDBtKQxpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 5/9] selftests: mptcp: implement pm_nl_del_endpoint
Date: Fri,  7 Jan 2022 14:16:57 +0800
Message-ID: <74ccf527130bfbebe3e92ab5b6328e502c880f91.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55a6554-29f6-430f-ec6f-08d9d1a56bb3
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33694448D3437026FCB0D463F84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TinzI6Vie5FABQoohF2+pwUJOe9z04zMOMymElxFQt2r17m7xEIu2GgH404K9ylL9a62djDnMDwA7tTby/In4PD/VH2bcN+FUsIHaVjefWJ08L4ZuYfaw0DdbVi0Ux7wqal8qpKPdlj2zGlDqjC3sQ7UtakARxNwFgsWn5W8G37xVLfBp9PK5NqwCIudAR1Ctl0M2WBql8YBXy+VlLzTPWlu3wAhxV0AhZkfDlkCRE6/hZJyXn3dwxCiyX8wvDHQuP2CWrupnW7JGRseOtaGiZESj/wgZagpi1DvQD57FigTL5BOPdGoyxLoMR9iR27Xg0ZW8ZD13ypEc2BUTEh4xIj/z/uopoUAlfOa9Ki5QDISuCPEXouo6x1JEWoSCn3b2ZozQ1XOmbF6+k1z0j+0EsmSoaJ1zk/0KNObOh6Pz05QOO7MY5610mWyRILoWptlzAvGsDTjq10mYHl8rHD1FNyAVjIvgFPfbg4DdmVJ/UXSbGBCEMIH74dMwN7iNHxZpGRkf71/mlB5mNuedleS98uhZMbPXPdlArDfikBUbXH4zkLrlogpHchUs73RNrLnQ8ChZyPWZz7aHegl/OndUDxVMDygorC++C24RgTl7slpun9reLiJBdIQrDEs30E5ujzEtkvkHJN0VyVD0GhW2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6666004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XIsJL489dbUiFwRjlU341O3HbE7GYPHWLOn4TL8H/yRNWmYtl3RqdMLntVZI?=
 =?us-ascii?Q?KJ2yfscSOXdVvoJGj4YyDywrCpF2OMSH+OB5Mg8GA5fTRy3RNYQmwj49Yiu4?=
 =?us-ascii?Q?z4PngK/+6Buvp+MVUxqJ+umX9uXKceH/lcYPxtBQvcjbr1ygMA0sPSuDQfAM?=
 =?us-ascii?Q?TPbpbtEFjzjiPdER2Dp6VSYHGHGOM0ovpX4HS2ZV6zEsg5+MuymgMyYoNEfr?=
 =?us-ascii?Q?+7zun+X61wQc0Mp3WBeb9SWTlZi1d+UazvdvVhNGlgWCPW6wxYcQWlfYg9Tf?=
 =?us-ascii?Q?vZueCJFonu1uAb/Eq7A7Bl+6IpqXWgV69CQN6L6XZBCIiQkx2j9NhyhiYaYP?=
 =?us-ascii?Q?/lwOLkPNrgKfmQhhry9QyJi8T7qh5WPdrx4+khBNN2rATAO2ojBm0/kiq8ZF?=
 =?us-ascii?Q?y81Xe1eGrbsQhxaA4OC/y4eQeP7k4NXa/dQrCv9T7NTvVkjulcyJxV7V393O?=
 =?us-ascii?Q?0ii3BgHt7sHLQ26XkZqxGJ/2gvlBkW0Z+weObFluqbOeGOEqPbo0x4xTQxqn?=
 =?us-ascii?Q?47kseSk9ja7++VZ49N3MJSJP3iJckEH3kBLGtBxbTgSI1YwIoT1vnwI5zlmT?=
 =?us-ascii?Q?FTg0bGiQFMJA4DV1/vJssMDusv0goaoQUkw7pZK2+YI19ZTwgsY3nRvXn19w?=
 =?us-ascii?Q?wTLEylYwTYMByRCoTtXlwyNn0MNe1ghW2xcV+vGUYJ0uH6dpB2UyXC9laSfY?=
 =?us-ascii?Q?e4DIOplL3X087w4Slk4bd6OoiUKcwuVFchiqZgdJ19xJQXwZ/92mfN3s6jip?=
 =?us-ascii?Q?f2OKwCv3yobguZ0Jx1aJFXjiUdEcO4UKKLjrEtt6hV740NuGeFhsTaFBbib8?=
 =?us-ascii?Q?e0ZO4BwJIjoa/ySUmDUFC+1PWZwUY4Yxg4eXiHo0XBT879KPh6o3oFXXhc0F?=
 =?us-ascii?Q?x0pNmFdJyjEwB8Lr4iK0AAPmseEgaCOqMCgdY/0pcwApGNaMVUKD3SpeyO5y?=
 =?us-ascii?Q?hdYrM+AULkAOtpKd9GwSN22A6YyIKVgCrsRCDfa/yHw7EYlU9zIOkxinSbf5?=
 =?us-ascii?Q?QJ4wgqnPEG4rpQYYk7WPW6+OnECp0SBKKpUQPbylN3ronpI1Zma/E6ZkEJ66?=
 =?us-ascii?Q?i0AomxzL2o59ElJuc398S+37y5BBTbn3vHcII5opecvvT7VyBFOkEaRNxKN5?=
 =?us-ascii?Q?hkCn0AA5bU8+836DpbMWjPjwd/6GgA6qqZwGnwamDQhHswWxbVejkuJQjwXf?=
 =?us-ascii?Q?wtN2a0Vp6FTAprBuZhsko5tcVkzo8yAoCt2NEsHWUEpDeL19kY7vROqyinfy?=
 =?us-ascii?Q?dvyD+KBOSuW8VsB2PgFjjZyyZIzXejVSEG3cYntrQH+hnYw0LLnpxa2s8UWH?=
 =?us-ascii?Q?ht8AkkuMgtPTttfZ/Y79o9yCk5qcEZcKKTTCobiTOKwDLEt/6b9F7wm3Bu/Q?=
 =?us-ascii?Q?t5rDqr62qyMddUq8A1tjZ8osCL+1XA4yRO9YSGFu4Diz6jt6RLFLePo20mLu?=
 =?us-ascii?Q?H48wRpBQaENrdBaZG6eCvBHWKuwA2n1gCq7f2YyvPDZsmuC4V/TKH062R73M?=
 =?us-ascii?Q?QgcqY7cwfmnjyZq5XJuZ4FRfDkHOdFJeJuQmj2xFovXcgDsYg2UbdSeetCsC?=
 =?us-ascii?Q?VJx69uGlpWXGlfw99is1G2OCt+HifRHIun0QG+L1Mp0Qk+BY0F0enodtjGgK?=
 =?us-ascii?Q?4h2xZwgRvv0nFBpHvGwFhv8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55a6554-29f6-430f-ec6f-08d9d1a56bb3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:45.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rzXCPSnZCykEJZMFFOcABv+/VcpbErwjuEeB94YeG0JSbHIPCnsdMvcQVv3jo/mxEuA84tRCQePumcQORd3wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

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
index 788a2ec75458..9219962291dd 100755
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
@@ -513,7 +526,7 @@ do_transfer()
 						# complete
 						id=3D${arr[$nr+1]}
 						rm_addr=3D$(rm_addr_count ${listener_ns})
-						ip netns exec ${connector_ns} ./pm_nl_ctl del $id
+						pm_nl_del_endpoint ${connector_ns} $id
 						wait_rm_addr ${listener_ns} ${rm_addr}
 						let counter+=3D1
 					fi
@@ -529,7 +542,7 @@ do_transfer()
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

