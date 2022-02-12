Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81346257E
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644682539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmnNQ8I7yi53PgKS5AW9GSIuCr1OpR5vFPtKocG+LjE=;
	b=cGJuvm4hiVafg1zi52/pQ5/8xPc6o5U07saY1a/5RSui3CAbpqNmWztvjnTKmrZ1f9/xtP
	H2sjcJOpsvXm2BrCiRjo0QMVhTM20G5pklwiphdUiNFSA94Jf9hH3DlsBoA1iLdHoMeGta
	YoDqShhi/Wm+ozsmgEZ1V9mzI/Rbpo8=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-bHBz20xVMcuVELeMDKy_Ww-1; Sat, 12 Feb 2022 17:15:38 +0100
X-MC-Unique: bHBz20xVMcuVELeMDKy_Ww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzTa1X2ehySippNfg1cWgjp6SIY7ItBgmzorK1Ast6fvFvG46qxjg8+EVhn/J72E16GK2w52aASnH7+thEucYWsNJZiHCdz5vWlu+dQywL9QrMZnetojp9S673sn4HBKDi1DXN0wOXTpRU/T6pGJ5h4xNJ11w8/7mUJGpikprnNJJutGLbYG0w7cj4kgJQtz9VsMkcQOkxDc9wjo0frgo6EIPubCvCYghgyMJz/qESmxTzlp8twt8RM2qmVMWnCovvSDazBB85nQwdJfQeca6SqguRvKY6wQHqCwGFm1QK/LuplBD1v1REsZhYrjAATCI5GLkcVYDupYBJ6LpT75PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dlZ6mvFvziLhG+/zdShszurzWWe/RgE86pGllWpX8w=;
 b=Cr5+6j+m5CMBd95LFGQXdNo80QcPXQrLdj5AWzkefZ8oFImrZOwdZNcTHO2kPMG7TQZLUrd8QUKmz6zRVsdK3wM2CgQSedrccL/wGfAu1VDVSIK98nn/7x9ctKyMsWi/TZ9FjScZ1LlOONQcn6AGIvekA/GoiFlgVEmwYpZB147Vr072VB5wm6rEsoKtFseK4u3i1oQKVCmlw7eH9oeAWkt7JELeqO1oTai3fUmTBbt5CUeAzdFH7Gg4XL8nFMdf3MsYAHGE1eTIfTDH4Mz5PWF5sPCvlqoxGAzmhmfJWEI5I8Sp5EJE+6pzJc1dZDg0J/GCrkMlawqaXbOLBh76Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6548.eurprd04.prod.outlook.com (2603:10a6:208:175::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 16:15:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 16:15:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/6] selftests: mptcp: add the MP_FASTCLOSE mibs check
Date: Sun, 13 Feb 2022 00:15:36 +0800
Message-ID: <df91e26c84e10842cbe89d1074fa4267b67c9bc3.1644682054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644682054.git.geliang.tang@suse.com>
References: <cover.1644682054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c3c2766-cc51-4e50-11ed-08d9ee42e6ed
X-MS-TrafficTypeDiagnostic: AM0PR04MB6548:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6548A8E463A6DA411B4B65A1F8319@AM0PR04MB6548.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zt8TbVheIOgS10JHANJpta+037V095smenyfj+WnFK+jJhkQALyWf2NUsKHwdehOnEoJk1mjpzdeTTLUAe+8EG4uPurb+F/AKwA6x0YqWHf+fnjQlP2SAJRbryL2Mk6AgVGaWF8Ut3IZFPgAz8viCl0L1MRaFy3pv/H720oaBvz2hSiiqqmEfXL/Fmv0+M6RizL1IW6te6ZWs06GQZ3LrCn82jDYUyOBT96Ulk9l0HEzD6fzPnA+vIn85+j2d9CUbv9jpmCCqV1Z0zTKX/zyvfjjk5il6ivXq0z+y4iM3Jjdc7x1p5gn2GWhjr4jrIlXgx/8dpnSUlhjHhSIRD0bLbg+Na9Jk1pSb52TEENwQUDz4wab2sWSrawwXanYoT40fEzz6n6RE9/D1kJCW43BcbmnbDthssm5Aw9MxzZKcBFnq9dGgOPhsAT8gNy47O/zUErrcYF9zuufzU5ZCvAdl2T4UNof80VxWW/HPR9NmxVtvMqdIsK9r/qiGizKRWqDp0wy+Y3QAVNesLOKkxJh7aeILN+WSiYqm8orGu+vguGVf9//gLKVWQXR2xF/6eW1FJaV3fweeroj4DxXUOhvBPFk37JvdZBrc77e3m2NLLcAJ75/t6dFFg/gIahSrDhKs8RYyrwYF7wApxaB2msGD2AWnsioJR7fiAiG9pg0mMqHU7NZCKdLBaaCRtslZdQNVQ0uAg8sn90+VbqFDViQBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6486002)(6512007)(5660300002)(107886003)(38100700002)(8676002)(6916009)(316002)(2906002)(36756003)(8936002)(6506007)(66556008)(508600001)(66476007)(86362001)(66946007)(186003)(26005)(2616005)(83380400001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jA5imHboP/g1UaKnLi9X4N19z0uMbsqMdZNXjEZW2YzJG0S5r5NNM1nM912?=
 =?us-ascii?Q?klUjfl/rp+SBdJnjNogvd1E5ycrZp5pEzXdTAWwWGXHFzGBy1Xo7juLw6TUV?=
 =?us-ascii?Q?KGpSlK1K0mB70iEjJnVMmsHsZy+JkuiVQspfdhz0khtqU3iZLS2zWnszp6EU?=
 =?us-ascii?Q?JOIJ+2lzqysfKkuiLg1DXKn3T6jT3BkgqnZ45En+QbzlzX8cK8dmUaFSf3rk?=
 =?us-ascii?Q?dWFdP+7B9doWbOWdtPCSk7WHjbDepLTYX/Kw8mvLS0NzUKGW9caZRYtyPOmo?=
 =?us-ascii?Q?GRiU3CIUijWTzhbDNRmIw5nIyqDOnwb00Al5Fdyw2QfDD5vruLzZIZ9ee8PJ?=
 =?us-ascii?Q?0kWKUTWkq04OWOaxuWXEhXTaIkp02ChVY9viPnX+HbKMXVdvPewYofQMIxkV?=
 =?us-ascii?Q?ScXlCPXBN8NtyVuUtsaoO4310rug3B0D0alY+w1lB/imUeeZIbJXZ2Mk19Ed?=
 =?us-ascii?Q?z4Ek/qBPXlqwsIghv+0d2NEMGNLcTFTOM7y+s74s5I7752CtEM9q9g88WLTc?=
 =?us-ascii?Q?fOY2Y0UTIS0lg4Kh7nYXhhIKNGxgBD4DpdXYgwNxY+qHOmA8ISuo6T4LcoBd?=
 =?us-ascii?Q?cxF/RYuQu4UqqoJrLAjKjq1BD0Go3Qf9yc6zs5zSEozaVXWknBVnaTNc2QaN?=
 =?us-ascii?Q?ZwQA7MgxzeCQZyPFYQBJhmcOK5VQWrdDbdcaQcgg07S7i4SM/k0zBWNRDP7J?=
 =?us-ascii?Q?lL3z3JO/eh0X/LSQPEXVlOgC4tEpNAJe9997Naz3wcdv2nDTvhvZmo7mbEw0?=
 =?us-ascii?Q?jOSkSFkFneGGBF3kcCbqeITA6dUoao9EHrzdzRTlVZOG3XbiMetRwHOVIwgC?=
 =?us-ascii?Q?GCZEybAIqFN9uZ3aF3H9GxB02B+fbeYBSQF5K5Ua5PKJw4vOFcfI59mKWFRi?=
 =?us-ascii?Q?hWSpR4IMVQAMJ2R2qwchZjIPDt+9V/MomWfoUIEdBwYQVBwdQFb8hGLa1/kG?=
 =?us-ascii?Q?tdcrti/FskYj0SfOmbfM2GmcbS4SlJm1sVlI22HECzmJ+HNRgEPv2F2lJaRX?=
 =?us-ascii?Q?GLUWH4+KX3+jdyiYR0+ayZYiC4JNJbBpe7gVOsek8QTJ28ZdAGF1Hm1701EN?=
 =?us-ascii?Q?0o0X9HQta9fFgBWTMt8KCTvWv3+JYBu3TCFtnADjIx4QBEoZ/K7lehsgKkQL?=
 =?us-ascii?Q?JfPusswn3bf8UvqjOh20GQKrwRoWHYUbicCP/OIcuusNOw+VZ/u2EGZSNZmf?=
 =?us-ascii?Q?kPoSUTtMrkcrFafgRsoRohu+hysvUetRn9daIuRUTvvUmvmlBilVnFfLa5rs?=
 =?us-ascii?Q?uXPAqdeZWGERSepFpKMAjyDzrsUmkmfVnALrGKff7MoXSCGDRbpNTp4odm0y?=
 =?us-ascii?Q?0ODBkI1FLkRHY6LrmD4nQUbIediPzZxPtEhI04RhOZqpwXe5tFV6rJqnN9k0?=
 =?us-ascii?Q?H0mlBJwcYoncyJ6rtyhpMYrg+1p3cpdU1pknqeOZqpzPM7cuQKiV2J8XlH0i?=
 =?us-ascii?Q?2tjO9CHrv2yvDBovScxFOrjcxcsbnNZ2Bm83Ku2Q7B7PTMeTlHVDBmUuCFff?=
 =?us-ascii?Q?lHPKc9afvXhAoEY7Rt24vSrUsysXWyBDKI2XBG3ys4dE5tCxk89BnsGuz2j4?=
 =?us-ascii?Q?iOuJxXwDHHXpBfFxmWLBs7jf3avP6wVf0Qyq0SJYyRhZJvTcMYgAGhP3O1af?=
 =?us-ascii?Q?CsV8ifKlmj8xNg+kAYOcwr0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3c2766-cc51-4e50-11ed-08d9ee42e6ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 16:15:36.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7I4U3hJvZt0qrI41hCny0uinfaZJUxEGMGyo/o63twAhb0rxpxiYQRxLZsgXgZitYrAt1iKYU6dbwIO85ysLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548

This patch added a new function chk_fclose_nr() to check the numbers
of the MP_FASTCLOSE sending and receiving mibs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b48b11714817..f71494b87d5e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -834,6 +834,38 @@ chk_infi_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_fclose_nr()
+{
+	local fclose_tx=3D$1
+	local fclose_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "ctx"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_tx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - fclzrx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_rx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_join_nr()
 {
 	local msg=3D"$1"
--=20
2.34.1

