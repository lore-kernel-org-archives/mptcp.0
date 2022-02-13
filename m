Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F945373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zbZFV/erLYI6QZrHQHjEqwm/DI9E91hhlD7Enj/b8k=;
	b=cpSA9P9nmAxvZPwPx/z4CtQh5hMR3u+6b1Orte4JAclqM5nINlGQE2DNW5mf3wCSWFjNXt
	z1bP+KCrrSHJMt+Pa98yG7TB8T2rhTSUV15uUNJUMmUEFSZfr+xL0fPcgYERYMQZSO0dah
	MBa+um9EnRE+j3GzM7T6YSiIzJMQdQg=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-jWBHOKpEPfydndoJAgkUrw-1; Sun, 13 Feb 2022 15:50:37 +0100
X-MC-Unique: jWBHOKpEPfydndoJAgkUrw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLtu/3uOAbGjeGn+P8JpV/7rn3EqyPcYArMf6php3UyPWB2cI/YGEvAOLcAYXQ0b0CJHRbGzKljEjyjAUs7BxWUhOxZ42ct2ofou2nwGz9gLdLuRhoMIlSEOCEyES/ZVHWcmmt/z+q5ckbBuMubh/LH1kyQa1iJgFqykBj9ZAfSTKuQlM4yCc2YhzuPhO2BQthT6U2oz3NURI1l4lQ9lpCF4anGJ1T2dgM4pXlT3/lF5puMhXGvDmT1xurIVsq9jtZa1WrxEOJIbGW+Fxw+Bk2mNIY58kIiSrO1QMVW0PY0IlT48CkGoYYfyGSkuzqJzJKgOMNVSdtYXkNBbBx6oMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm2GbnOAbqmzQOzeV3zeYIaN7LymOIzug7wHvGhUnIo=;
 b=PBmQPhbMjJHV7uMqhSZfRItm+lvlLrX9BiQWrUQN6k9KAoBZsMFSIK8ksdmFQqG+LU/poS9cMW4CIatfNh042CiVH7d0MgT9RW1W4QfEmS9oZS7d1MiX0KlP3lJ4fMXTDaXIKuLOgGJqm7y10jfN7PO1rBBT89wCPG+cJBMOhJnwnn0vOrcYs7dr0KOhMMhvuBYOgdHICSU2fuH59PsMr4kfWkPZaTM/nBCeUcodzVYGwbh406WSGrox0d2LBH4UegoKggZrDPVR5qnssBKKnk5XnhaYJ9w3cOPUlfryCHjUC5KvNDNcMTBLpegTMl8AAwHA9EGMNczZLbPWA6bDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2384.eurprd04.prod.outlook.com (2603:10a6:800:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sun, 13 Feb
 2022 14:50:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/6] selftests: mptcp: add the MP_RST mibs check
Date: Sun, 13 Feb 2022 22:50:34 +0800
Message-ID: <8554bd77f8ab87e77853afc45e1df32e20f36979.1644763526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644763526.git.geliang.tang@suse.com>
References: <cover.1644763526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 755a5dc6-285a-410e-e612-08d9ef0031ba
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2384:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB238458F5CAED11F1570F07ACF8329@VI1PR0401MB2384.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VyoRwClxD9M1uSMSQ/yR8gLL/n7cHpXrrxv8yUyW5DcE6z+NzLD2wxdN86g4tIYXfjM5RBRXlEvQhu+MWK7YM53bMkJMHvlS/oxpRsyeDSOYDgIETBBCMSfeHg+LFUX0HeuO6yPSSV5tsrGq1WtE7iWFpdvOdzUZmF/tSZsK74j8htMGc2txIHX4/rEF6RiuPdfEh/H1diqh633cxh20/oHQY0Yd7VFJlyxLWFjkmPkNH6KwwyGvXhl/NcemCgjJlCzxGag7hOkabu4NMGolvJsQP/VDNZf5xW7hj20c2+giIGxu5dPbm8COCuGKb65kq6M/u9vudfaRJeZq5wcoOCtdl5AZ6MLiXt0m1FXBOGNuwK9gNOblK+yR5TQWqlGhkzwLNKnrDuU1bLlgqNKIeUGWhxkUiPDDXJTqVix5XnPJd3gDmfBhDzAkl+IuBtM43SVrhS9S+R9yqkXmqnbiMoOBLRi5pHeZwjg0lMoz+MfeQ/XRjf/G5LsOBIodPxgMTLbtsVQcIdJh4A3bI0TIYosM46dOVoRZhBi9CZdwfDV3srP3eoJt0ZpqP4dg/fxmtwtJLdD7JEY8XfFF1ZYQxsdAN6xJa1rxSKbm6CZ6OlfkonpJHR/ihSdJaLnXbvwB95qRjyulCRv5w65WhpQdFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(6916009)(6506007)(86362001)(66556008)(66946007)(66476007)(6486002)(508600001)(2616005)(8936002)(186003)(107886003)(38100700002)(83380400001)(36756003)(2906002)(8676002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0c1k5dDburlWvyFPoHLpKEl6p3SqC96iNubFFGOCuchK2MaCb3qhiNEXmtcT?=
 =?us-ascii?Q?ZK5UGT1tqREZPoLs5OmGVQtgm0AS3xHOBGkig4oPQmDZZTr3Hf+W3v1eUDn/?=
 =?us-ascii?Q?LUJNeYhruvNTV+Up1owxcg7zSz8JRr7asq7UunmeKxAeqZy4xIglmTx88CM6?=
 =?us-ascii?Q?1t9TqbZ+s1Q7iMU0cSJprwM1G/yi/wdWbLLECbdJR6Qvyv8JEh/T4QKuO/r8?=
 =?us-ascii?Q?EaWXY29WrCXXSxSP/+/Vs7zIzAU7cndH7F9CvsmWuU/7ridts4SePq3+DP8n?=
 =?us-ascii?Q?oxJNy570+1LuoJ1aZhYyLK8Rjg7WDoJVTRkw8jmEp4Jwtg/F/RBBMOfURNFf?=
 =?us-ascii?Q?c2+QAskrUwoz9EZRaVtM2Qj6CNuOKgkzbGiJlTBTJFQfah1mbNGDszl5Vtk0?=
 =?us-ascii?Q?WindxDYAYxWqCoblhd5xM7UyrU6ftIvhEmOLaDhFYrssrzYqDReZdiB+ZIj7?=
 =?us-ascii?Q?bBQoJaCIPlDN89abXVMF2+evTc+ecZ8dYp7pS1JJw+EsK6mJKTz864MnRAgN?=
 =?us-ascii?Q?XG2Cr6d1xwPkRitoDscsv0sIeHo3qX7aOTGTiJjQSEcCG1h+o+FXLfSVsluk?=
 =?us-ascii?Q?pwiVyjpJQq6qEZaOFKrbKXkrNawtNqMnm1IRAaAdKwSYnDCOuuahLM39dGKt?=
 =?us-ascii?Q?AyeepWwoh7eZ4+9RPsQl1aZCeIHhZqtCa8lCT558z9P9yh8Jwbx+F3N6wIni?=
 =?us-ascii?Q?7fwYworsTYD3oIOuzy5aCHj/1EV3847s9R1y6rUkSH0Ny53OopOJDYqlz0cd?=
 =?us-ascii?Q?JP1fnxOpOcqF0zaEB/s40zRXRSlB6Dn7aOMgnAdlA2+Qrv6m5YEhgKfH0uwk?=
 =?us-ascii?Q?TZvVzTxdooi9aZM5dEBfN2Vrm6lQyL2GCjTpG17n3CXUAmMyfdBapcn3W2pj?=
 =?us-ascii?Q?IMue5HvP/nYama39MqtrZ3oBgstGXKkfKYWLMreZWe7ieqbDfmfu1ipbP6zp?=
 =?us-ascii?Q?OmC248uNTwMFiWWSq5GifoWLrxNX3NlFN2k2PWTMy60ZCWNK0OkRUq+XUgDD?=
 =?us-ascii?Q?jc/IP6hr88tRY6O/hhs9rUnDoe1iKSli5JZ1yTFHSs7/ZkDm8OfyngwcYgzY?=
 =?us-ascii?Q?j89+3sH3at3D6v+dBQG9Y5RDU8ZkvUAOSXO+Rk1ESWZ1EPuUTGWt4UKDpQ71?=
 =?us-ascii?Q?DJtswW7BUcz91gL4rc7hGKh6UkrR0qxOqk4g2e+mlTCsJv4dALHXo+x/r/CS?=
 =?us-ascii?Q?xkKQen5rIpn0VYUB8Q2+t7t2Es1zkQ89sAo7fykEG0l6eLt+H2n65JuVxxSQ?=
 =?us-ascii?Q?mtpJxzq1zIzyB4OX0GLNeXSfsEXmsY+m09K442ugzZDhuj3D+1huWNaaVPmv?=
 =?us-ascii?Q?12pKBM30sOuqYeKeOLLFceGiH0SwgkydbcLOKCc1HHeGmhJBNCSnCQCVuT/2?=
 =?us-ascii?Q?HVQc/nuqRNym3YVYVZL065wftHuYEU4BlCRdB5Dr4aCOyw6BcrlvjuYZl1gK?=
 =?us-ascii?Q?pebxXepGjp8BKiOM0PUAj5kYaslXqzEN/dxiUN9y8wcRwnvQdXxsYDGpoUn5?=
 =?us-ascii?Q?8xlAuA8E6+pGpvYXeVjNwqJNkK08X2snosIQgklnGV7rCPotbzo3aqL7Y2es?=
 =?us-ascii?Q?5E2wVjSqkqov94W8vkNsiMHhHO05CUnukLHjtLIiXiLbGRCJRIX0TYtDjIB1?=
 =?us-ascii?Q?yKTZL87sXKvFNoaHo16d9zc4DBqTFjoU/2MXqeptUH4tdh9T1otY7HS/a3fQ?=
 =?us-ascii?Q?aN6mUuWoaUFf2HHeURLHqlVimCE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755a5dc6-285a-410e-e612-08d9ef0031ba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:36.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0B0dr/53nc4ZdS7xcAWNp5MzPRwtS3DnaGK/DJ3TiK6AiMuSQw4GwfFFEo36sO18OF74cVxXhCav5U7wWy+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2384

This patch added a new function chk_rst_nr() to check the numbers
of the MP_RST sending and receiving mibs.

Showed in the output whether the inverted namespaces check order is used.
Since if we pass -Cz to mptcp_join.sh, the MP_RST information is showed
twice.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f71494b87d5e..3252865352f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -802,6 +802,55 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local ns_invert=3D${3:-""}
+	local count
+	local dump_stats
+
+	if [ -z $ns_invert ]; then
+		ns_tx=3D$ns1
+		ns_rx=3D$ns2
+	elif [ $ns_invert =3D "invert" ]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
+	fi
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_tx" ]; then
+		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rstrx "
+	count=3D`ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		if [ -z $ns_invert ]; then
+			echo "[ ok ]"
+		elif [ $ns_invert =3D "invert" ]; then
+			echo -n "[ ok ]"
+		fi
+	fi
+
+	if [ ! -z $ns_invert ] && [ $ns_invert =3D "invert" ]; then
+		echo " - invert"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_infi_nr()
 {
 	local mp_infi_nr_tx=3D$1
@@ -920,6 +969,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

