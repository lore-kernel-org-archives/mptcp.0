Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39180FC13
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GA5NrM3p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAxYFtyVoVLhl5pnAr2YWPcdWivrf7KY/dHpX6TWq8kQHCj9IYopE+DgJNBa9tFwOOKrEq3c0Dd8PT/lEFx7pQVEKe0L1turhOcZR7GfUQn75+pyPX6ERcfqrHGPJkBjS733NR1KxR1ro+AzBq14ZWVwEER/kCFbNRy5+04lTEpQ8HW/sve2ELhQqft/1uXjaIEu45gE3Pjt5nqmaSBiBTumXYj6DKKLgN2nFHwqE0D/tOhKvCBjWWUJXqlC1dqLaC5X5uND2snVgThfrb0E9+4uAPV4SmT9NzKJtQgx+6lRYnDUsnCysz0blHBevMZEOFmzxSMaHa5U/M+Df6AkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRd0Bif/P8noQUpSU597xprr5qSWRiRqC/fpPuazJ+U=;
 b=bxequbD6dCSLFPqB5IGN/mH7dnfhbo5Qjmx8F1npUuG+qHdrv6MdEI2AgvntQf73BZOmXlhqrAfYFALwjCVv6UjaCmW0XKzoJihQmP0Wjp4p9+/ENs+GQPyFNtPdhYMRbHYjZD9oI8+yVfBVojqtWea9cwDASdt/GELwABoPVB4wW93+EuegmwLhTSovHYDNJC7R4Dll9xwTfh4ADP/leJ/luNMIpJqkssPpA9mGgqYMmfScb9U3YJe+0vE+J46Tkq247dQftgPTvdLB79VIvfrJc0IzZygFaKZ7gCc//pZQk0aQ9KaEQ397VAWs9SndB/Ivw6KFkqvXFRn9wbcw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRd0Bif/P8noQUpSU597xprr5qSWRiRqC/fpPuazJ+U=;
 b=GA5NrM3plPWojtmPEspiMR4/io4XZarOiPkwz2hXf+Ci8NJu5X7Jd8sJqajf7YNb3Fgwj5RfC6ZL4xmmGrzQNxj/99A55IOowcqUJTa+wK75RCgmTs/acSF6BhU6ylnFcmNSBnvgi7HdLTwDuTuc6cRhMCG6q6VGLHLpSmOyYC+Tty/bCmEikUDv5YxZOqYi9FYo3H2tPEmU6n/Nztd4Ytw1Sm9yywMCdCnbtvVfntMXhL/jZTPDnEeg373nYWH032hjXy731u6203x5aasOc3xGOIgLCik7IxI2Squxk5lVMOrkHK9a4T+Xk72nyAkm8kj3RsSDnZiXdwF/vdbN2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7212.eurprd04.prod.outlook.com (2603:10a6:102:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 08:51:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:51:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v15 1/7] selftests: mptcp: join: no RST when rm subflow/addr
Date: Thu, 12 Oct 2023 16:51:59 +0800
Message-Id: <cc3f501a23445c34189d0e40aceb1fd312319c31.1697100600.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697100600.git.geliang.tang@suse.com>
References: <cover.1697100600.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4eae8c-ca2b-4755-5d1b-08dbcb005ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WhRAVmCMycIWW72SFPBic0kGXAXfs2ciociRcb/DrXwXxBNfzZ3xqab5nlxm2LYnnrigGgG0kSmsWPTEv6afIA8Lr10MSeFYvcY9o6+V+ZGybKVxBwd2i4SjdaTVwSeGbxe8IDGFAnk72AQr1HGHph+R3f5Gh6ynjelp1ZlKNz6qF7B76ts9Ve0kF+Upo4Ek0Jtw20GkRkz8O+s97INmC1o+DlIzxc3LBDGL/ECsN0QqSTj+HxOLEgpvHy+k9PVdlmfu4k/WyRpNYCeTLq2/RPzK+8ncR5wKEmXOoElTFYSx0cZ6Ptq9SOLkixWOWyI9xjORh7Eho4uqmCAf0Xllifesyrs1XY5F6xb9zcjJa34ruoGFA+ZB5xFFbhv9JCTsGCroYAbiIAPhES0UTATQ7j5EEDYFCbkxUTUvfwqgayKXKs81bjnpwuLp4NRbmlurb5Xh3TeiFJV57G4uidS6UvusgmIdpP5vsKhGLeKu/POooI+vE+Iw2DATFg1PM5gRQ7+0vIxW/zBaoX7iWurWJxJbzWGDgmbcN75x4Sp0tHWOR8UThXNS8AufiYl/FfqJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(2906002)(36756003)(86362001)(38100700002)(44832011)(5660300002)(8936002)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(6916009)(6506007)(6512007)(6666004)(41300700001)(6486002)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpUnYJYOF/g+71KmXPK7O12FLBOboim9urgijMhy4Rmi3MmfuvI7sSn13NO0?=
 =?us-ascii?Q?0U4uVN2d72RQl0N+w4Z+xAXZfLBwOCH+uWN0kCyc+Upi+XkOtkBsdW6yHu4P?=
 =?us-ascii?Q?snMogmQYmhUOP4UaF3+5VXftG1pDKrZhvx1lAnfnpEWsWF8LFux/ZghPU+NM?=
 =?us-ascii?Q?Ghq2TlLMkpTHC2ltY4Zv2ZBR6TL7CSx7CTSBzhkap3KoIo5uWq892rZI77mY?=
 =?us-ascii?Q?4WU91Q2syGWFxBU02c+ijnDBWhpsMGdPFLia7X+cDxkcvENV1e9qAqoBnH6d?=
 =?us-ascii?Q?+V6qz5xeVQwQed/aHYcqaCsrME1XRCFu/GUcbVat6U2kCC3vYdN/PIQRvHvQ?=
 =?us-ascii?Q?YTQL99Mau2ydw3m6351A2SlEJd+aQbuthgyJiKE9Wi8b8fM9gHBW+bJwbE/1?=
 =?us-ascii?Q?YrX7VuZKK3Blj2QIaffi6x1yVpJNghP4QGaGfmHoW5FXSH4cxI71RulRfImK?=
 =?us-ascii?Q?XuvOVSaKAD7oTEj1uY0hiiWVCdWs6ARlav70FzqP/NztcN5yG+0tCmsuyESp?=
 =?us-ascii?Q?UyY5XuLwLbs7IgpdWK1ffd5yN7jhq45Et3Gxuoesn+BBVaZChXTzD3KfJCdV?=
 =?us-ascii?Q?jJqb3HFUI95cEsS9Ms7CtU6/W5sR3jKyoD1WjNVuIvZNf3Tslqw7jo8aThiU?=
 =?us-ascii?Q?JfdONHBc+lRPQ0ZrEQtUiN/5QT6swp4YVOaaKhsPd+5moWTx544jv1ionJaC?=
 =?us-ascii?Q?brbLyEsCJuNhlmitriMrl5fKmgc/CUxpkbBUUcCyHUT3V/O399ZzG+J7kJGt?=
 =?us-ascii?Q?C7WWI3KPZLggpLx67YfC8ztoht+agAFbuqfbiy0dqd0xbK9Avko/eAXQcf28?=
 =?us-ascii?Q?Fy8kxIC74Ggts8BwnIgJ5IzHTCMAoeP/84raqoaAD+3m0rCiXNyV0uJDJIeB?=
 =?us-ascii?Q?OYtImz3njQh8gcLUBphxNv4ItmEH6DRxITCDg/rbt8Oq/34qOVWY+2t1mP/U?=
 =?us-ascii?Q?aDICXsjP2kliIDojpjVcEEWQdPNcr1/+FDHl9MD7Io1kauNlRXPZEG4xNQpp?=
 =?us-ascii?Q?zSKG1phFc741MvTf0nDPePHFz9W3Dt4AFCunKMRhyYHAQqFwQyjNx2/b1nRn?=
 =?us-ascii?Q?kj35I++DhzPUZNM3B+Rxuu6F0yRswrgHrnEVBb5dUj++WT7x/SsmOJFhn8rw?=
 =?us-ascii?Q?wvQeEulXLIi4i6rFoHbIwu0d3gSMa9hFlR6G500TsXMV7xLSOnTLPqVSxEy/?=
 =?us-ascii?Q?C+YmER+2cHt4Im0iLh4ohR+4KVCjYlG9S92il7QJuYCt1sC5tBTtEUTe4V89?=
 =?us-ascii?Q?w2hybyMm2dQ1gV5EJTeWKg9HlqIXUqKhuqFJvYHp1XGAbxfoCRynvSFk/dTU?=
 =?us-ascii?Q?OWFJ4BrT7j3omHJUcUgLjL2uTqJ6+Dnktoo9O7NyGEjNGoqkpKU9PbRvVyo8?=
 =?us-ascii?Q?48+V2su9jdH3kF4hNQPMqJYQetjTOz5Hx/+67iD46Z09PthvvqKGxSpyUlE4?=
 =?us-ascii?Q?lapWhk1bNtX6/HGPyzR63UmySGE1OG9ST3mIu/pbZshwdyKKFAyydtW5LhWA?=
 =?us-ascii?Q?O22uvQOHVQGIHdnxKh7ULBKZIYa/ZjqifAQVPoi5WRujE+i1wrZyodfDM8Rc?=
 =?us-ascii?Q?uhQZYhtYNnDak+m7GscNIltZBbcMyYq9GZj4Reur/rgU9X0vYkyqe4ruLiQh?=
 =?us-ascii?Q?5dZVZJbgggx/brTvRRjXnkym5BDPGR2QS/jlDgJkQXGm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4eae8c-ca2b-4755-5d1b-08dbcb005ff8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:51:07.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEq4M8NlKM6JtS6HO2+MqPmhVB6u8jf1P+BzPc+S/8s5N3O4pm8pi9p7hv2QJPnGAPxnkPSv9gAyM8T9TDN69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7212

From: Matthieu Baerts <matttbe@kernel.org>

Recently, we noticed that some RST were wrongly generated when removing
the initial subflow.

This patch makes sure RST are not sent when removing any subflows or any
addresses.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01480663c102..ab6908b7b143 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2343,6 +2343,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# multiple subflows, remove
@@ -2355,6 +2356,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# single address, remove
@@ -2367,6 +2369,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflow and signal, remove
@@ -2380,6 +2383,7 @@ remove_tests()
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, remove
@@ -2394,6 +2398,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		chk_rst_nr 0 0
 	fi
 
 	# addresses remove
@@ -2408,6 +2413,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses remove
@@ -2422,6 +2428,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# subflows and signal, flush
@@ -2436,6 +2443,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# subflows flush
@@ -2455,6 +2463,7 @@ remove_tests()
 		else
 			chk_rm_nr 3 3
 		fi
+		chk_rst_nr 0 0
 	fi
 
 	# addresses flush
@@ -2469,6 +2478,7 @@ remove_tests()
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		chk_rst_nr 0 0
 	fi
 
 	# invalid addresses flush
@@ -2483,6 +2493,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		chk_rst_nr 0 0
 	fi
 
 	# remove id 0 subflow
@@ -2494,6 +2505,7 @@ remove_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		chk_rst_nr 0 0 ## TODO: currently failing, Geliang is working on a fix
 	fi
 
 	# remove id 0 address
@@ -2506,6 +2518,7 @@ remove_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		chk_rst_nr 0 0 invert ## TODO: currently failing, Geliang is working on a fix
 	fi
 }
 
-- 
2.35.3

