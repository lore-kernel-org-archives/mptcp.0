Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27A2C9C
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642066186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i7l6wLgF+2Q9N3mWGVsKGw1k/5+1jzL+HPMW/46Uki0=;
	b=TO2fOtMbkIZdpx2Xe0KYk979mkW0JJgTvbnOVpkELuX2xVUg+QiWm7eaXgixhWTlBTt404
	gf0zbDE9oM+0jlKAJlrHMpixMhF+hxziKHoo6fh4FR1fN0nq5gKwha2S+kjE7tPlqz16YW
	LF0ONmQT9VL07kACJOKY9vrR6dufPXg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-81gKY6usP4G4rw7nu-00Vg-1; Thu, 13 Jan 2022 10:29:45 +0100
X-MC-Unique: 81gKY6usP4G4rw7nu-00Vg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUzgOKIgDdFpwuAmxP8m2DjHgCQXHid1VH7+eY6Akg5IuiVyM4RKjmDmqdUcqqxlZZt2fhvucvrRrNuFKrPTOaRa583RpurABknTh6B/7XpCEBBBbZQq8Le8tmso+fHn1tCLStn1auQ3rNfSmb/0c05AI/csESS2oBsF+c2y+M60GYr/Im9hfjeSttsYhMSgaofh4C8aFZaXagmSqxlbySy+n6wjNBG24uQx+m1V7zGyULm4gsGLeOnJb1Zyl9Q9sq8U5qfrwo1lvycuzQspBmaVPmH2M2d+4CiIWiUPwnIptgcJxojSVedNXzWEY4q5xl6KXaRiACyPlKe4lTd6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHAHoFc0iw6PqoWhOuwEdOgBWr9wFmUEYwQ4bLichvo=;
 b=HMuK2GwNf5hRNr5FTDXUTLSA3mfx8Q8tV/BJznxvbldwGTAL1CPlXBLRj0cqqdxj2euxsswy6o7GP0pRfTCBgJOQ5/4CFobuc0YRp0ooDkVMWvEKgIvUNny5od17C+xg7D9rsNUyDfkmeKMTYSQUdiSGJX1qke6GXyobqH/pH5oXdkk2gx7I0cmQGqWjgWRgjLy8mjdvPkdkEg8Jk2WNVnCE2tEpdKV0RRa2e88c5BBvdY3p4ibaATaqCfdfUc+/RHfS2DrX31zoy/HlAqwEHUdA/o2Oxm52aX5foehBMrz9RhIHa/P5nUBak/XhXQAaPPGLr6gdK9Do4bvqj5eBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6888.eurprd04.prod.outlook.com (2603:10a6:20b:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 09:29:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:29:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/5] selftests: mptcp: add wrapper for setting flags
Date: Thu, 13 Jan 2022 17:29:05 +0800
Message-ID: <3c95141d5176affb237a541824177b799dd62d2f.1642065488.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642065488.git.geliang.tang@suse.com>
References: <cover.1642065488.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7163bb92-e1f4-4cb1-d533-08d9d6773b33
X-MS-TrafficTypeDiagnostic: AM7PR04MB6888:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB6888357E015938A4D4A1870EF8539@AM7PR04MB6888.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LDbu3O5DRCvZpdwjZHYXMuEz283wKG0QBKmMgk0QVRXLTboeHu5DugzbMpLbyC1LqillHba+KDntGO/7FQXjEUYR8yqqb+WT5kg5/d2Rw147Dp81jTBc1XPBesBWAL3WNCjib+kQvmpb5hmuPkAD/tOoyGulHgizZ3YC4cEr6nuOyrx1A/oQFRoW508oGh9wAHWex4CMnQ5EkZaNYR5SofbB6XPghV48HsvICGirOmrr6OpV0W2xiqfg8n3aDJpujPygVwXo7nHewjUbIubcYevh5hgh7z57lHkWXRfHhMlwMO8jc6oWBusIF+Xoadd8j8kq3MCmF80dbAtTseBxqDR2chYJqBXBeS5F585y/NFhHxCLSbNjuL1HeOr1t9VIz1hC+fKebgxz0TCaWcut1TTamCa7lX5UyJy3tTZRp60KWAMdDgX0jdlCiH5A0oT3PVnf5heRQKrkkCVbSF/OR7+7I1xwqTLCuDorSvzmTmgmyrpxtLKHV9/KXnerbST2Q9hHNnvZnRomCBvhP2WCltmyntyz6c03+ZR+iTkAspH6vMunp9ePTUvcAt0G+HtJrNL4Mcup8xquz6ZvFuhUmihcMa2tgJGiy+eqz0B+6WIs62FGzIsMuzKNR2X51UzoySpcwPoRBuP1QI/zK3e9Yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(4326008)(8936002)(6506007)(55236004)(8676002)(6666004)(508600001)(186003)(316002)(26005)(83380400001)(2906002)(38100700002)(6916009)(107886003)(6486002)(66556008)(66946007)(36756003)(6512007)(66476007)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0DLL0KKbTe4ixy156oY/kj1PJrruhZpZlpT3IWiiZl58sWXM0OBhYt1b359?=
 =?us-ascii?Q?iaADGzM/LM+G7ZyddHudVTEVoNRpi6Cz8pmAqlMVDZ+y5enybsHzgpMSxdE+?=
 =?us-ascii?Q?0jekU29H5qkHf8DsOs2YsuNeGBkxkkSR1rrHiPEJJ1tAcPSv8H7BkQWt6gLg?=
 =?us-ascii?Q?XCONJn6icdDTnbCpvh3LXBDEGIdUj6RVRUmsJSqHC9gFu9+Wv4Ewr+bLshE3?=
 =?us-ascii?Q?4th/zNdTsoeVCsL42LId9PCgrkEKzTGPlpgd4Q+CFIS1HVmRDeIOdM10mR6N?=
 =?us-ascii?Q?oB/zTTr/2zaMKhb34lHLGHmOvikqb+ZTxVDdE2xW6RPGnI/kvBwRLqiQRcq0?=
 =?us-ascii?Q?3WUKFaJE66Rz7caFpCyDh3l1pIO61HY6gALi0iPm8O49U95XNhPFFP2UtU6k?=
 =?us-ascii?Q?NAjATarV0oY7z+Oka7jfHI8bGezg6XJfmFvSAcU0OSFfgIGF6PkITHtPxlJF?=
 =?us-ascii?Q?ht3o8Da24NyH0D/QpDqLunoQjQT+i1urPGtssFJ+f32fD8yhPn+RJKuBWCRW?=
 =?us-ascii?Q?aNE5zMfzez9WSsS/SlcuBN/ZWXXO+VEKcVuRFjppxUjpHQIU9B3uvKMb03rZ?=
 =?us-ascii?Q?Ecfh52s+AztJBhPXTPuFa084i+UG0yDqRJ/FgADQ8UlL8Od1n6P0kmX9igeN?=
 =?us-ascii?Q?isdbQVjeOOuaWIMADDrtKV0HBhX/mcbUHLTo1RZUeCdpURcDGhKv/myhslTr?=
 =?us-ascii?Q?O3KzXqoG1dNy5dX6RfKoSRI0f8N8gkERQQxIP5CONfhBwvHDcLK/Mo9peWj9?=
 =?us-ascii?Q?+cg7y0obuCT+7wfYOC14j3tbybA1JbOb7VySNnROxnuHQRcgj7moXbCuzaO6?=
 =?us-ascii?Q?PCY9fLUqIs2Cxaye/GuBNiORsa04EfoMSu9q+RtiYqnSFCMnK4EtosjwTPBA?=
 =?us-ascii?Q?4f9g+mRGpgD3XuhJL1Ab0X2RXnNvAjltw+fy41fLnpSkz+k31iUYRs11WbKE?=
 =?us-ascii?Q?6qzES/IBPuxS+bCc2pk5+wcSNZYAjNAHXAyN/pcB1yCRrBhep+RALoiVIEKn?=
 =?us-ascii?Q?pc13D58xC2XZP1tuK5i10GXt2IYaFl8GBZ7cbw6U6bSp15Mt4y+k0LhWDj+V?=
 =?us-ascii?Q?3IilgpkaXU977U+TYdQQpTCK3VnwybHzAXqIPZWs9ARjnx/3TvJgsS4g9bmk?=
 =?us-ascii?Q?hJU5qamvXlSaiTqo0PGOMdAjTOv1q6uudI8PqWWSBL1/WK+MMSINuiKzCcGA?=
 =?us-ascii?Q?ooIVL67FGp7Ozda4AocvR1QqT+MjYpnCOHWO+dhJCgVE8SBlHIu4739tiFw5?=
 =?us-ascii?Q?k6J9sXsLSRUBDcRe5w8PjOsG9FVCQGHjj+eT87yML37C3GDCauK97xdYND+1?=
 =?us-ascii?Q?Y/M/KoE0YOjPzJkL5jD3csQyuGjWZp5OWruzcZHbSbexVTCEVnBzY1/owGiX?=
 =?us-ascii?Q?X6CV9yyYI+8ncIVYztoELOFDUB50MPrPpfHnMd67WrAsOVcGSjDwml3QYIsU?=
 =?us-ascii?Q?gBblIo8GIA2FK84Kl7puOGMrEvb+rwmcZKzaF7Vbt3FoSiB+Z3bT6WjwXttO?=
 =?us-ascii?Q?DqLLV7YXmhmydYZSvlfYH4O8LLzF6p5Fe77OIbBf/BM3j6pESx+jWv+1XZ4/?=
 =?us-ascii?Q?1QYNVewk6VTqVeIrYWyLWKqShU2sFvMMEEWINB9MUa0Nv6umc/ew0ioD/tQz?=
 =?us-ascii?Q?g4Yr5GPHOIeJplQHydjz5i8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7163bb92-e1f4-4cb1-d533-08d9d6773b33
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:29:43.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRJCI2YDEADy9dmo90HusqR4FO3G5MtgsqPmKCX2ls0HV4wzieKEhE7vR8/kHREaTiszFmj3PjhiRQTrEsoPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6888

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to set the flags of the PM
endpoint.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index ec86ea9d57a8..16fb756e363e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -376,6 +376,24 @@ pm_nl_show_endpoints()
 	fi
 }
=20
+pm_nl_change_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local id=3D$3
+	local flags=3D$4
+	local port=3D$5
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint change id $id $flags
+	else
+		if [ $port -gt 0 ]; then
+			_port=3D"port $port"
+		fi
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $_port
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -577,6 +595,8 @@ do_transfer()
 				local arr=3D($line)
 				local addr
 				local port=3D0
+				local nr=3D0
+				local id
=20
 				for i in ${arr[@]}; do
 					if is_addr $i; then
@@ -587,11 +607,12 @@ do_transfer()
 							port=3D$i
 						fi
 					fi
+					if [ $i =3D "id" ]; then
+						id=3D${arr[$nr+1]}
+					fi
+					let nr+=3D1
 				done
-				if [ $port -gt 0 ]; then
-					_port=3D"port $port"
-				fi
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+				pm_nl_change_endpoint $netns $addr $id $sflags $port
 			done
 		done
 	fi
--=20
2.31.1

