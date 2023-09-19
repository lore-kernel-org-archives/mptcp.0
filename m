Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BB341B8
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6xU75icPMZOElLGoBolCQ2xmf0w3Bt2xvvP3eWXy7p30cAs2M02/KAC3p7u3Rq0olXY5jN0Z2O9p1oxP1aPT9jRXLUts4hvWW6qFDEZb1GdLnnUsP6GWzt/LgQ7YcQYDclqiyALNBxn8sOVPpBabX94mRgQ3PklI5YNcWnF/weg1SADTXeyWFQlFAFrR1+01vMF/G/J+gBL/Wo9XjRZLR8j+rTE9GBZ636V1oNoIu/xp2rAj7MPAWklKx9Zd9Zjk2SuSEkbMg94XmiOrmXtUVUx+i8tLH1iJ6yPrys9cuyPdGd0wx4inEZwDBqSigIMT72TqNm7HLkenRSADJpwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNw0zsb4wZAmD9AaThDWqiAvjV6ZxsfKpG3uZIV1Nrg=;
 b=VPzJvb0KEowQzTiT+2bRykTPzkk8VkkVl0ulj3cxVxWARcghTXWdtq0CUzXQ6l1yJ81N+enbTxaz4kyp0Lnw7zWq1UbPOtSHdsViRwwVR4KW+O4J3vFNe0rXkVCMTpdHPu2QvCKDN/YGZL9NodWCJBkDAuNVGDeTemBMOHm//KGqUt+Sfp5C9vIgqG/CeyHt/QTZTHpmSY18ViN2MZQ+M3OMfdOF0B6R5M4FH+zbtPseKi9h+P0BtIfxwURDgd63mR5nAx0DBul8N30iCyHIpt7DGoG0O0j0zAQ3+N4M8tvF1oDBq3KyKaQUcokfO7VYhXFbfhMSspQVOZXdmdsYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNw0zsb4wZAmD9AaThDWqiAvjV6ZxsfKpG3uZIV1Nrg=;
 b=UR/+n4j8kacAl7UB/HH9dQRTMGYAHPSx2ci0LXbPBvVOoBCXBFOvh5J0FI7SlrEZ58wamXmJqxo3H+4M9QUtwoISOE62ebp0vLp/DBj42bGg8QbeLajnWolQWEsY1L+jTtsowZTkQiOdRo5darEuF1E4Pk4XYaA0wRsXdowjN2AcMHBoy7vcSYdvxXAc5T9H8IELfVAU8qE0NCxsdEUwS4CQkc17Y8pT/4vH4YcQpfCzS5IsqeOCM6NSn7Q257w6WnWht9wutahU/AzYd17LtEsHyetq+kTzNrexWR1CKXdBA1ZANI7xCmCHWYbQGQREarQn+IAxYad+qC0F2OdqCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:02:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:02:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 08/30] selftests: mptcp: display simult in extra_msg
Date: Tue, 19 Sep 2023 12:02:09 +0800
Message-Id: <9271c666e8bbc80a5ee08e072a1db13c49859d11.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c127735-1583-457e-b733-08dbb8c54ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G0Nl3aJVlHVfbFr2t3VI2n2EvzXElRV/0njDbPT0f/T5v5LluMnj/6baUPfCPNUKX/MxjXOw59Ry0ENT0k5RNiGRKVYs0Ht2D1lWdjrZVO6+7/OJtyVp11706/LhNrVUk0rDgYp2HH9e246oewMzF9ERojt2STsMjGUyO0k0OMpGGG6CzGj8kw6XKkC6Dvxt2Meb9yvtrPY0AnLpVr7ycqZhF9Lk96qEbyrR0OxAotjsuSS15gH873CX4mqHgLpcd6iT12kLuitTVpyHphoCisgVUu6AwL4jTipt3GcEcxqdjFbThqI27yYm5UE5zHKv6OqZ4R3jEnJjzFOtTMESwHo6F33VK0pEmgN1IZLC+x8I+lou/ZQiUl6VBhi/m70aW49isHX8iHuYpEaQlvFBo9/0A+VbT5yc873lUqx5H9esl9tBFkBp8DWucdi0a1uD3FzrfO1re8yL9SsAwWhehtP65Mtb+D/xsw7yOHeMUAX1L10fMS9r30k5sxT52j9CcySLqntpcNmj2S/kd1/G6/ZFTzXaZztExv8vDoX25WeCenbBWwxpMlYL87Oi1qgXVItzWT4TtF1/pU7Du9YlV7XJRkzH0/hhweA8LC4QZNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?45+4mC81yNbbBHHq9UQfMbwYs43SkmetO80Wp4zNX9nD1jz3gjXZkEY8s/GQ?=
 =?us-ascii?Q?0ZNKxDRBmLxscCvM3l6qh1M/y+8NE6DsugVKfm1CZn9y91GyFZ49Q7JShWR9?=
 =?us-ascii?Q?yRJ1zzxi1rpoEn3tDdqvINFSPkGqYvqZcdqKuxI9YmCZHcYzWz7zGhHMP1iL?=
 =?us-ascii?Q?GkuAfRTirgVTXJCPSJi9SPoGAAKlOeyIDgWy3oLXiw5b7qnaa1zqTY7TBwcT?=
 =?us-ascii?Q?SPMoJcLrX9/3vJ/hc0IMwroEY7p/zZAvIT/0py6RcSCOMmOy+Fy5fAN5zy8o?=
 =?us-ascii?Q?Lr7thIZlAQ7d3WvymKhlmkyB+WImX9uvIY/fORhMYslID3NZ0zM6PAQKL/+I?=
 =?us-ascii?Q?H78BWfa/kXrbCL8jA6FSw0ERyZOOWWwqKMQoS7/81Cz8KTmG/OwxKUKcsePT?=
 =?us-ascii?Q?UfGCZRh7xkMLUIAETEtHiL4dsRq5Mxe/GSATXh3vnbfyta/kvKB40mnUeVDQ?=
 =?us-ascii?Q?SsYQQ85cir83kg1fCUKZQZR9P7oo5luUxOITs2IKU2XjpSAap11bKd9OgpLd?=
 =?us-ascii?Q?QqNxjoNvbmbff4hoARZ4WP8tt02x8vuTB8x1qa0IjgJjRPYLF9LseIxVwhWT?=
 =?us-ascii?Q?Rb+bmSDLi4Rg6H5YRIN+qdb6HKvGKRs9CyV5FXaF1OKd7vpG3B3xtXHyxmxy?=
 =?us-ascii?Q?kjNGugxR8OCizqjQMyF2Xj7EypzodQSRr1PepzD0FKG4Tg/JkXsdQ9eNHEfS?=
 =?us-ascii?Q?LTXgHhXHuRhBVm+d5LBXU0FhkUXdkdjxwfzDM7y97tT2Wu53iGl79sgizhrC?=
 =?us-ascii?Q?sxoY+ksbZm3DgXHoe9Xr93gj7eD7ys/algu1RBQvsHirCMA95YKSwqtSG2IV?=
 =?us-ascii?Q?XqKwk5RN2KWn0b2IsRveEoeys+aVhlRTaLJ4kyx4MqiBuf3PUPfo3R/gRJ/D?=
 =?us-ascii?Q?ENCD/t+gOD9ljapV81wh2vM0IA8EbHYD1OKHsIjvxa14ISlTn3/ilwYV+7ms?=
 =?us-ascii?Q?oZBr2QP+kchSJVjiWkFspwjIvbRqIVVQB8wNRsEBWaXV3FMFJPC8HAREz2i4?=
 =?us-ascii?Q?sjU9JoH7UpH3R8nSugjiJytFzHKBhdL9vNoDmWETS8hPNFnyaIdHXPuMgVhQ?=
 =?us-ascii?Q?oW0VF2sPHZWtxYLkodbgpwQYmWz+lipIbthF6qcZx/FooEH3Pj6MX4jaY2pz?=
 =?us-ascii?Q?miygIPAGl6Azofh2W/DJ4oJ/EmJ2Ahd0PQUcHcjgwbhS1p8Kekuv9xUv8jG2?=
 =?us-ascii?Q?Heru7EnTUx14xJcBEhkRx4O8zhUecIoZmVY8Os+9AgY9DG7WyDqDiR+v6F9K?=
 =?us-ascii?Q?j8Y1kjqV93oBN1cxtdIh7tlTW3L4fDTGmG+SCZ73IUKpJrOm4rkmvvOy3gb5?=
 =?us-ascii?Q?W/bzqncty5oK2O8MBGRhMHmkqv0iPZsWn5gWJiRM+eO5mFotl6fBGpcHAIS6?=
 =?us-ascii?Q?x9RKdTc9sAyTBIRvvrGrFSqc15NTLQRi0AfiF+Xp647KydYQMYPcBRSw3RBx?=
 =?us-ascii?Q?jdcomhMMYRTMfEB/ELlmGaTmsXHPtmIMjsOgm+e4PjdhfwybPmdWudF19j6P?=
 =?us-ascii?Q?Elqt8qdiyVDBNb86/nR+u6kl54tWhqzpFfy+fsMJTu0tSpzKKGIB/+gss3OH?=
 =?us-ascii?Q?eGR/7ab2gFhcUaW17qxsuRHY8BriZUTi5njIUIOz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c127735-1583-457e-b733-08dbb8c54ff0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:02:59.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiTnqGvKQGTEufI5cLT2xxyY0GT4elU82FFCqc/C1dDb+b5BZr2xai+GqKzL4ekN0J1+Xd/VIzzNoPDh2wCtdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Just like displaying "invert" after "Info: ", "simult" should be
displayed too when rm_subflow_nr dosen't match the expect value in
chk_rm_nr():

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ] 3 in [2:4]
      Info: invert simult

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ]
      Info: invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..d02e53be8b31 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1766,7 +1766,9 @@ chk_rm_nr()
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
 		count=$((count + cnt))
-		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+		[ "$count" != "$rm_subflow_nr" ] && \
+			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]" && \
+			extra_msg="$extra_msg simult"
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
 			print_ok "$suffix"
-- 
2.35.3

