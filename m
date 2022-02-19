Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8557D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Mx3DBvoBArVxmFlsBlhNMFM5sVMG/NfKoAmqGagxc0=;
	b=cE0u+2JYp1WeG53pIFT5MW4GL86oye7knAXifpax1vIExoNJiO2JJ16NhHB608ZBVE/q1B
	Q5tisHwOZSpX31MdiS+kSeNWomcDB5JT9KdDBzwSbUdliz4TYyFw1aUzyBV6/iNpkG/fzv
	Y3YypDgl0R+prK3OXXu16rD58tnWe34=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-JG4OBN7APm68C9TJjxIltw-1; Sun, 20 Feb 2022 00:21:01 +0100
X-MC-Unique: JG4OBN7APm68C9TJjxIltw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZFF+Yg28ADmihUW8Dlzx4BiPAz5WY+eUvYzXHm9moofsScbZ77VfRINTCr/j5Bqn/YZcRDb2CKZQkmJcvmvyDdHFR/az5LqFvukVMnIoHnT+UotwVXbGVU2Icq5IimxCVWtkS4vWXrCjxXSX9K7/wuqTMxNor+zBaKRtJp4ieerq9d7mkL7415EtfqBKW5XwoYCLmtl4Cqyjj9VIbE9uhZrRC0vEjlR2y4PmVAmogtc0i8HM4BDiyi5C3dDX7Kg1NQc27im4hcNUqopS4Ukx2GVeCF/KUDgaqUDxy4TeRTqUBZmWRwtNlKNG3beo3jWr75nf6xMxySWrJtgvUakiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8rFyMYmaTVUSJEhfXcIcFjr3Zvbyo+shXVTewwrjx8=;
 b=eaNjSCrcuxzXEAW9vOQaWpSxi9RKrh4ZifkfNvGl7pR6CHaaV9KnVJRQ24xsXe0M10zjcnCBjjnwpxOwbC2PBBkwmt8/IukHeYCqNR0LdCE+xWQda+KsQSk7uHhUK1f81TiW7gNEGAFFj9uDtKqFibUvjMs3B/HM/cdB6XIpQh79bcFW3swjHXK9WMc/+B5ae5nBOKmR21RSq8Ak2RuO1wdCbxrScXG0YLtzITqWM4NApX6DWF358xjKVjornlSBiwojafxO/86yS2x2suEXbQHNEBtlr6vwwaf7clWXh4jcWFN9p7LToof4+uq0ssB9OLq3ztOAToD2AIIyj+98UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:21:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 10/19] selftests: mptcp: add the MP_FASTCLOSE mibs check
Date: Sun, 20 Feb 2022 07:21:25 +0800
Message-ID: <2eb1e4339344bcdb0fdf21e1fe546613557daf12.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f10df8a-1f3f-47ed-9e8d-08d9f3fe7d52
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB684191DC3CABE9D043C1128AF8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jYAreTdojrGErCxjh9niajV4ZomOYl+5aZN9qVoOjG0+cNviGZ1oyvesr4dLopA4hnPOjsIkckjVYXTkPMcQmdSj0CmTTZvxf0yNfHW1n/DUrZ7BQyIN5XnZboMvZPLNnY6SzE8RvC+X3nYWP87XhOhhnWl1217f0J5EffeW6NYX5LrF1sbQnEwLSRE5NOPwdKCT++XPn++WSjl7+ynzy2mSH8k+fjFeVcPCLGNN3hAp+RIuo0V+GTUjiUitg5Z97iwxS1vPPGFXR8IWhW6rTjmpYxrxl2Xxnt2ZFskFu6hPjIJjftuWJ0ijBjjwDRRWSF0SoxZZ6roj11fhsP0DKf/zlz8vNPoo+h5UMgjTxjJRrsMYdb7GtEMnODcbj9/XUoqhQR/jaMuqY8EGhFYlBT4XPwSC9794GffSjvKnePVliByLSSZmGMpofWQnStGgI9J4RE7KHgUDPqFGjzrBmnzxBAdXOLBahPdqAzG8xbREwskyUkFIIaj5q512DgZm4hEt7rIL3udMZc2mwjptJpOAWsU6YMEbkb7qLzIAoo8XwarkHj1SUVozEZ5hKhrlKgCTbECrKysn2r28/BscufRqRtKgAqZx/11qOYe/kUoDGlYj5bR2GQmUyHGXtP1Lvo1xqM2ohK9ikV7UilW5ig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(6666004)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rlIeWSpNYQuhoN18BoXtPJqh/59DMPg2z3cqB06cPykdINwcQYqxgA/KqLR?=
 =?us-ascii?Q?JzutYKAarMl32gG4tIW4rz0j7urFqudvlT2YKIBSttHWpP/4ymIxoKVU3FtZ?=
 =?us-ascii?Q?S/Wvohzas9lGjsHs9SUk07IGf5hlNHV6aLgWW9ZBTXBQs+aJWljfEcDQHLWu?=
 =?us-ascii?Q?aUIETNZCuPdJe9uRvH614Qn2AQ46SKG+/AiXJA981sIs1LqIDqJDtsvlOzPI?=
 =?us-ascii?Q?QnmKqZCA74cJUoaM1c/szvjrX8b8oitQNrVOFt801i4zir9DP+V8uGzPRM6R?=
 =?us-ascii?Q?j40DI5hmG5dVPCMbwwTUaYqFLe2lipfz2Cpf3T7G25k5b0kdS/LCVJDWX9YE?=
 =?us-ascii?Q?UaFtuQYbS2G9uMAe91Ei83dEkV63kClYxy/4f7KT1xYl2/xZLuv4Wgvll3Zr?=
 =?us-ascii?Q?0Elel0Rb/tVwEykUVPCehaNXi0BmnK+UfBpvCyGsj7mkeg64h7lAw9P+O3M8?=
 =?us-ascii?Q?+PiSw+mylhxI3+0II8fblVQ9K2GJF1BOUJu6Md8IJlzRILT9N371rPZd8iC5?=
 =?us-ascii?Q?0Wwt3EFmaBrbQiMlTJerMTPolSi8MhLQtpRP/oeiAp2cbwLyhg/WqB2nLZjb?=
 =?us-ascii?Q?P1hZYm9cH2vf2T6F5nH1F9wULjqgmJja3mxMGvgvb9Ivp1t/sMn4hI6DGqfY?=
 =?us-ascii?Q?dHrJBUlpABeitbCU2MnzWkh+DXitRuSCzUlRsOwYGR7v5+hV7edq+Nl+N24G?=
 =?us-ascii?Q?tGy37QGjR92iNlcBYXcy6eaHN1EDhaxaNWJLzUJjhWeh45Y49kmXEDEquMxm?=
 =?us-ascii?Q?QtmHTOQlupS3R10SaIOesGkOC/1B/d2c4IiQna29X87OIeDCBGchXi9HDkWs?=
 =?us-ascii?Q?dGG5ofg9ZLgxpXxXkEfTAQ1rNFXCOSqEsr4n2gjxSPE9Q8ITHnKWAuFpPu8r?=
 =?us-ascii?Q?UrPACiuPu5JJ9TVzhHYz7kbRazTwLPnQprqtIaZh8PQnMM9SahtEWINUw9QM?=
 =?us-ascii?Q?Ht4fCp8KMoDWGLn18kqehAK6JVIRKQuItU0f1WyAbNBpXI2W54MWwgvQzbNc?=
 =?us-ascii?Q?1jCZ0u6nyNsI9IKCxdQj4jked51WIPlYN1qFDke1FSubtFIRXZmVK1RK/CNq?=
 =?us-ascii?Q?Ge9RVZO0hs6LMft3A9zUFZAKqZg7B0tvGLnZMDC31ieJYwSIsVLTqPG5qDK5?=
 =?us-ascii?Q?mH6iDeq4K3XDk3/WoI7kPr404bQeHNVhilyk1Ot1+4YlWBzPPIxLs7AmY7B1?=
 =?us-ascii?Q?L6vFp+YOb3bIk6hfnPx97fiwc4dAE3f1jk70m6fG9gXfrL9uud3smJfamAy/?=
 =?us-ascii?Q?GZ4u/eCUK3nB+VC2clYVBV0rFAnUItvDOUVoEPCIlZ8+P/YvtU9Ngmu2erX+?=
 =?us-ascii?Q?mKRAHro3yyHgc69DwrfDebMD5hDpk08Ej5RjGKahR4V0hFfD2j1bbkpgDlyp?=
 =?us-ascii?Q?up4B+NvB6YQnqapauO7Cl6OGMvoezmWP9NvSiknDn7xkszEpN+cyg09y1aql?=
 =?us-ascii?Q?TVsfQeiaIgsAynnpBaUPSstPIb9AkaV4jQGf5yx3iZsFYtZ6ywogJm40tx4S?=
 =?us-ascii?Q?vULothBbtWGmA6xjwLWUxfJ3vAbqflnui2Oz252DjDTKFNw0ui0shaMuaPmr?=
 =?us-ascii?Q?P6Hizzid9qlgM0gKdsJ/z12FrcdkZgr28vgw0tSJBe3GsJAi0Rh5GKqj14Fw?=
 =?us-ascii?Q?haTMcBJe9UXl+MgOooi5jPyCUQb3XA1uuKRWMufZjguD9ARLo3WJp2XEooB5?=
 =?us-ascii?Q?mcr0JGDuG0wTghB4T/qH/ubWV5o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f10df8a-1f3f-47ed-9e8d-08d9f3fe7d52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:00.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiJk782XPNdOgujwAVtu7cHRTMTjnDm+9FiOA8ORjLeSDoMsobq2oZtIY5JxvFqbDuKZB4dj/xz461bU+DE39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

This patch added a new function chk_fclose_nr() to check the numbers
of the MP_FASTCLOSE sending and receiving mibs.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 67910a3645c7..76040c725e12 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -895,6 +895,38 @@ chk_infi_nr()
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

