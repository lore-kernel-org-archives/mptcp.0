Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8662C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIRhXDywLfG2Z/1HHEdhR1gFBd6KrWTdQDiHb4qf3OA=;
	b=ZWgtBuWPIE9xgmzHGF+uaifilzXA3yLZdZV/XJjmXcjZcvQNKdCb55IRNvQLIvj6+hHxHG
	p2xR43JRDhyraJdZc1kdzv9tFbwXhLxfOGLYThLE+vnFmlr92cwAjAg7aW+bfPGDrxd6n8
	Mr41jw5SyrPGj9/RmJSIX6pngmNR6AQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-eVLqv9qcMGS_2LMC7thLug-1; Fri, 07 Jan 2022 06:52:41 +0100
X-MC-Unique: eVLqv9qcMGS_2LMC7thLug-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4uRz99joG+XIDWUpLjU071GGG6KxKP5aYhML8n7mnNOHX9xL1BmuZTjNyK/X9DhvHtcOttEbRBkwcC3h7OJ0ATSA/TvoWh32blE64Pz0VZ+zhLiPluuJAyoDExT39X+uRthPxjjUEN6Ir5TyRVN/U2O/xS8cnOYNq6mOx1bz8yXyNDY/R3sIboZKbvudwhBjqgThqas2vrWOdqJxKuv/Jn+5x8tiNqjuupyXtkWEOO5adXXtPi19xJPnL+L1rdBrod9dhlYSqsX2df03UHFgn8tXBoPUMoJEycnu+pPMXNMNzi1Kqm2oMCmlh1wC+kNb7WZQdVCc/kAQoPYVKtvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoqIEV5hxBQ3H3UVckhvifbSYOSGJdedVKY7WTTRwYI=;
 b=HFsnS1ifYpoIfbBiV9foOaD2QmqwxDwbvzsrf1QfCQXoYWWTkyE/GLZDMlV3D0ykPAteUR4LY4+gZMluoPx0Oa0McC52c5SBL5IHkenxhGyFasH9OhMyErlO8gmaww8c3HoDBhuhTfl/Bpkxqo2NQD89mESboUTPaf+5dqUh8DElRoLAHCUCubu/s+Jy0plT1UJTIhUkENfUAWIz1lK2SPKnVsTT0BPBt23Vpx6ZV5RVXhfBePnRukaKUeNBYBTptcwvFm667s5VoL3+dL83n7Gp/TnrcyG7Ln0iecNUVRk6hDHjQaVrpgpn5p9Axg+cHdRHhfgPksaKPEmxrRldTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 6/9] selftests: mptcp: implement pm_nl_flush_endpoint
Date: Fri,  7 Jan 2022 13:51:48 +0800
Message-ID: <267bd9dd81cf105a05f5637d92e22a55a685ef50.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11817164-d6f8-450f-bc56-08d9d1a1ea6a
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2731DF3BCA8738B58ECC3A32F84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PTggcLGkgnReQHbbhvMmjPdtLUAG/9fGhhjE1YNqnVCazgmvbS/09nImHCOmaHgVAO1vtuP56fbJLEvJ7nZJ1gydry5xlHfx44pi6SkpLJ9H3SthhOkk+6mi9ymPmCzxDYSRo+0Wt44T5cpRD0RnG8Q4Mcd132FwDdO7+KIEblEqxurIyXQS3S3y36yolPxJsYF0ZYf/95YRzsQX6Kxxoe4YtJtTDndHhvDYH0/F4yDUaWMB/esPcjxpCAD2LSGtJm3MsRuP7ktvejrqsyi210u+7B9m3Mz5lDlv8ag67CZbs7AiRfPRVQJid6Ldu3o6XmWzV1Q6lr9tfhcvgJ4BTd4KavB1xE/xN1UrTYrvT4d1xZ41JR9b9hswj+DVQBIptSbWK/XlfmQfP3hMEiTwfhGcqbQmolHALvTDHsxPCNKBTIyC1lbUVxBgtQgpex8HW4R5DqDtkWIRzgv9CqABLDGtzFvqOYwsRLSh1eeA9hKH5DFVmiOxBPoqsDxWBbTeXsab9H8zr0kKiKsJdxvCtN5Neuwjpg10Oos5JFMbYnwwwiViXUl9k5I6MAI7sqzJU1slqreeRhdgkUobms0Y8ajo7bb5Zyqvtwaxq40qlVXj1Ho2uzraq0N5sWWLGwXtyHLK6eDOPoik8Ge+f8JC1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(55236004)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bVuVs8MFge0K4BY0sqHtczv1bEYiU95sm1WclXzjzqSKEqOLQKo9PhWGOeQ+?=
 =?us-ascii?Q?fT3JQrT1JvezC1W0v05F+USXcKEheevuylGRmvU1kEejMmfOtpL1+ZrtGLvi?=
 =?us-ascii?Q?oBzNesPXCKdcQNbW1deTs3WeCZsYgNnK8qQEjRc1PocoSo3XdcPhxXsZ/BFc?=
 =?us-ascii?Q?jv76oMx6SMvHP90LW0+tMMN9fjITlrld5uzI1U+jny1zCcb8mQFuqr2wIXfh?=
 =?us-ascii?Q?ZI3F9HCXhN90ZZxLlcu9/0pQbMej3EOR71Vq5OVjP2gE0lgX06pMYXklR+Hc?=
 =?us-ascii?Q?NAd54xrL1z3DwgWglGdxBpK1hbJYQP+c6g1NyOTswjiYAOlRcCii5K8rm1Bq?=
 =?us-ascii?Q?qEL4Op4b75QV76gz4krZGyrjyUzfarvPAJfX7yloSXIkrrud33wDL8RDmzT5?=
 =?us-ascii?Q?19f238DqOlksf+oqx1izc6lBxkc6l8jMrlAFLY7aKfpsI0JtdQnxMLhvVVVk?=
 =?us-ascii?Q?wf6/bM/u9cGGuJOPEK2GBIjhUQmwdz7sVJb3zgUn1Kz67LdV4V6t5tjajsn6?=
 =?us-ascii?Q?Xe847UBNamJAQi5pDrtj63Nmvegy32kPtexVmGNK4dyBTKgGTWuBSkwQ9YDf?=
 =?us-ascii?Q?qJt9MLgueVInCKqRWO2PkjLmJ/1YILywa1EX0B3RtL7uepEtHOXsGebDcx53?=
 =?us-ascii?Q?sNS5PlcEOY/r8Y2wpnaIBg1gPfm7B/oPdtDuNmcfIV2zpiW3CkOynbE8TtAt?=
 =?us-ascii?Q?pMLxtvKB389jwoJfIbNs2fu/anlqof2pazVzsWjUgSKUWsT4t1ik3XgU1aO0?=
 =?us-ascii?Q?oug4dKtj+bDWdM2PvhSupzuxomXNkOBTUpXpZRdrkss49tmlnWGnJbOrlXRR?=
 =?us-ascii?Q?qhMbA6j+O/HKyPMGCoGPdM8lLMavb/O3oYDsPptrV0IMvROaRbwGq6gq4SdF?=
 =?us-ascii?Q?DUs6ISqPycENrKHtxwnUnc2e7lSIG7ybYKPnBcyMYZxQy2fzzsGo522gA0fW?=
 =?us-ascii?Q?d1tqdnWWRV6q1cCfMPykJLO2EEcBvIjZWBix8GJkN8Sjuz6TXenH78LMDHXR?=
 =?us-ascii?Q?KmLAcvOqQqQleLONIlwIyQWbzO2HsLLHtBMZps5yGtyPKmXyK/4akCK9mZEF?=
 =?us-ascii?Q?5nam2ntWGLOORCsdrMWmQVQOwnRQQ5HM23FxXFlcZBaBX45ekwm4PsKGTgU+?=
 =?us-ascii?Q?P67UQVdDESHmM7a4J5KzBEBn457oROQT0eMjrO2xHiNZpHfWQPmAf8QsRQVI?=
 =?us-ascii?Q?J5CTlnjPQLRYNo4UVZzIA3QcQ7fd1qYhev2IjOXwJuWlMCCeHq6em9ZRoXXr?=
 =?us-ascii?Q?zP+O01u2VkDokUFBKBAIM3EEfciCG+k83YYzPkplgtKbyQPjIbpLx04nXIE5?=
 =?us-ascii?Q?/xuYy3GIYKgsuiRJfT+Zqo0Ow63V909+tigTUcRchesatl4IQL9jpoxLsAJ2?=
 =?us-ascii?Q?OVZ11gf8FVwYYYMfomV9RwCqScgknnqOdjV9t1Mh7HVz+jBKtt5jpajPXlGZ?=
 =?us-ascii?Q?CjSGR7tPVyVrJY9kCxySlRXQBQlfeYQJpeBf+oUdZiOxrsKHf8IpSX3uJ2n+?=
 =?us-ascii?Q?kDwyYeOr7sCpcDLehyNRmgRjydAFimPVeSEBs4eVM9LH96ysQmE+LDP3PYvn?=
 =?us-ascii?Q?goeQmROp/XIvDLHEspqkspZuDqaNP4djxZukdsXAmADr1bs8ZnRG5FYXueKe?=
 =?us-ascii?Q?U3POmgeKdYtRUnW2LOOQBJw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11817164-d6f8-450f-bc56-08d9d1a1ea6a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:40.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGi7Et1xNzzmp1/18+kOnE0YEMd7xOf2WfM7czqcabg76ACeEupKvTrbui1kwyr3PO/nvmzUqaXiXuobg/ooNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

This patch implemented a new function named pm_nl_flush_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use for flushing the PM
endpoints.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2dd6523a7e2d..56f040722b5b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -352,6 +352,17 @@ pm_nl_del_endpoint()
 	fi
 }
=20
+pm_nl_flush_endpoint()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint flush
+	else
+		ip netns exec $ns ./pm_nl_ctl flush
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -479,7 +490,7 @@ do_transfer()
 				done
 			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
-			ip netns exec ${listener_ns} ./pm_nl_ctl flush
+			pm_nl_flush_endpoint ${listener_ns}
 		elif [ $rm_nr_ns1 -eq 9 ]; then
 			pm_nl_del_endpoint ${listener_ns} 0 ${connect_addr}
 		fi
@@ -533,7 +544,7 @@ do_transfer()
 				done
 			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-			ip netns exec ${connector_ns} ./pm_nl_ctl flush
+			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
 			local addr
 			if is_v6 "${connect_addr}"; then
--=20
2.31.1

