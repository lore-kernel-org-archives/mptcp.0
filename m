Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBD31740
	for <mptcp@lists.linux.dev>; Fri, 24 Nov 2023 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="3Lwjwh5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWyPtLIU8HGae1r+5uyyBxr3+bfUnElOp7kY2aXNDMOk0RjMQwgLDIdQ4rR08AzGChng/nb1kd7OdveKY9uqJh1cSVAll5XaaJ54176fxoEIr/lSjKdJnKytRycNCgdg3N+zs/+QHdnIXlSXRMSqJqxRPOTBkraxXnkfNtbrm1KlxzW2Tay2lsjG05t4JgsCEM79WEHDwtxXc4R27ENd0b9kmLVvdp5S36g8cg1uMys7baZXRRQeQJbNaaJLikbGzZbGCdQ9xH2jniBJ18AWjZ8BDBiKqaZwnCrr4P1HqQtcEXr/8ygump5CkuVRzxn5oE3+D1TVLO+r828faY0B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCDf6H/fL3WeuFJACDhR8XN1xv31hd2Na6T2OFwbEJ4=;
 b=Wpi0lVj3Ms0d6TI46QS60Sn8K2Q73eEJsKwmUUx+9o43NgrOQqO/TduL4jqeayR2hMLa2B5zw1Qk/jxomm0cbgY3qSdVeJGYBoKvtR2mG2zksN0tQ0Mp5V2zPKoIEiH7/+4OyWYYMVWX38u0rtu+thfTQHadfhhLAlf7USHefejOlli7T7/tWGOczmDiu/CzITB8tQGksPLdTnqBo919yU+XbYG+EUdUP+QCCh3u9b+r/3R6a8N7QsedWOwwEmFQwIOLqSUklE/t3SJJFvLdoW3AqPW9PgSodSLslH/aFOW9hOcKrMxXh3pq/3QGxBSbGL9MeAnVTMomTgnVZIJTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCDf6H/fL3WeuFJACDhR8XN1xv31hd2Na6T2OFwbEJ4=;
 b=3Lwjwh5bEKq902GsgxTVaoMZeLkuRyOslF5YGDA4MfelGTOtJ9xS0DKhVPb5kSI/M3hUBKqI/HLiq0hP0rNPC3sS0VQhlGwvrg1BhT7Z6FGQH0w4sF7k8HLYXbEpTSiruPNXXNPbJ7UUD8iUyw1OsbGdNFWE0EbLYsFkuUTbMQYHKtHRxd5M2qqrZbI0pzB//4RXSjhymRmb2LqW5LdEtyvKr7vWvBCRHcHNFDxGitWmvDOS6lGLBPd/PMl9pcjz8QlhPFIULQSitX8+uIb1K9Q1EsdsqauELKncy5cdN94DdvYsOuQo32Vxoydp3Ss9ibgaSU7AxRMLzlVIlAn1jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9210.eurprd04.prod.outlook.com (2603:10a6:10:2f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Fri, 24 Nov
 2023 15:57:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.012; Fri, 24 Nov 2023
 15:57:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add mptcp_lib_check_transfer"
Date: Fri, 24 Nov 2023 23:57:32 +0800
Message-Id: <16b3bbadb28abcca8a16ac51c915b5b10085cf36.1700841412.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: c95e7b63-7245-4a16-545a-08dbed060493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EakMECXNmw1H9u378g4+m4dMwMsvCUjNB0f+KeZDIT+tYzEw6phMhdCXYanMkA3UMcbqJSCQBhYOmwa43ayQ5UmXaubaIHd4RKXCbkaeZgX/FL/RgK4dA+KWDVsBb+J3+ztRIoUT8Lm1urwEaMRCuOnIoffT1fMOYIsYNa2G3pLGKpnPbiSfwImgmcc87XOt9PLBJgm3Hm2M3RmEqmYCP2IJbbpJLCX/lDGavBDKhLiZrvlDfoE4mdAN3g3xQiv8JIZTZUZ0+A0C1Hen8oNG0Tfwb7v5QpfAlzQY5Myg4rOjjhC682uIvlFy77nKUwtRnxqGhtJzBJLWcYrPzMLldj0mhj3kkSYz2D9DF6LcmtEKsJNuU1qcl/EbgJjp6yjHGa9adr6j+YdsVCX71AJugm1nhXbwCqimQXWrlrN6EguWs8nsvBHorIGTrwwETwO+lW6fKa4KGpzYYFqAc40sxk6Jk/jwLb2M3SsajGPLQwnS3zEqVbSHFhTNGkcrIyh1zGqrY5TIeAeCF3uLGSXdtz3K6/yAbXTXr5WdOHXErRhENdyjct+i4lMBuYdQgSEnnxKsNNBgRTRavp4JX3Sv8qL6c7fCBRhel/ndu7vC630=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(4744005)(2906002)(5660300002)(44832011)(36756003)(86362001)(41300700001)(38100700002)(107886003)(66946007)(26005)(6916009)(66476007)(66556008)(6512007)(2616005)(316002)(6666004)(478600001)(6486002)(6506007)(4326008)(8936002)(83380400001)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssv173BddxnT3PlXEUbFpkYVIqDUkHAuB8eJIYB1vAaUdJYw9AfJg1U2I2Td?=
 =?us-ascii?Q?DJNwZqQMo1eN2I0sLsBFwNLWaTl6IGSCk8xBu1lijaGrEQDXymeg1HUhRt7B?=
 =?us-ascii?Q?L4eldi7qm0GltVdsRbgdr8zjsQj0X03pL0ToXy35DZuXoQOZJkFEbHGSShvb?=
 =?us-ascii?Q?UY9VqmDE8ItU6bqQkW36C9RCYqcnleyIclzNUA5MX8PPgYSvpj5DXm5MMG4O?=
 =?us-ascii?Q?xR+RSSMj9mQPdTP0srmEUGKu7r0qBsOKkj75DtPmOq9VQ7F28qWqlRSTKMJC?=
 =?us-ascii?Q?lP7MElANpq4cnroTtB4gfZ61emkd73Vg9AqeVLjLkgnZ78yu4G1KqZ5eellR?=
 =?us-ascii?Q?yPOecpEHOFThb45iEzOf775qKAlFogpbC7t3aGWC03qxtLAxqrHVkGEgSMUr?=
 =?us-ascii?Q?/y3sRKjZN9gajeS7cUkiHC3dEJyvTaYz/CJCK8hXXM69j4TtjfVK13KxlLWR?=
 =?us-ascii?Q?WuW8wVC8qjFTMmjeAHJvymBAo07YEpkHgx1NUMJRTRbIdwRjnFVzGKmJUTno?=
 =?us-ascii?Q?4+U1XW+426HGLGYqK+aWtgk3aS7ByPgw1UhSCtuU1qVVfp1mlRbABuK6V0Fk?=
 =?us-ascii?Q?lUZNVFjwkmj7NCnXzxAXYlmhjjC+HWJzz5ve5HUHU2e8VRKy1aRJgTMoWtab?=
 =?us-ascii?Q?1H1CohyN+YTtvfhAi2F50uYegg1DB9oqcnjRv0fuwrSDU3R4J3Wy1fogM00+?=
 =?us-ascii?Q?otfkPbjl8XfmLy18KtJHqs9lrLSMe9rkH01+TcKi4+fUU0FREQMnb4eE3JM2?=
 =?us-ascii?Q?DxRboFnn3pnPB83XdWY3438YhyJslaABfEnOdhnyy6lUcQXcx+V0SZmXYTj8?=
 =?us-ascii?Q?igFSOLQMEEXcPhlUA/tJxddSvjIrHtaTH6Ry/gt2FtIBbDUvfjKPDbG8Hhwy?=
 =?us-ascii?Q?evq3/GczRWXKFb/C81AMQ/8i+1zLL+1I0uQ0PlB0jYN7X2urAPXZbZfDYZHr?=
 =?us-ascii?Q?OO1FZkuiYEvG7F5vrdFXVRUTzxb8PULiY+fowBsqcGLCFFZL7RAh4VRbnVCI?=
 =?us-ascii?Q?Rp5pV+Uj92PIg/QQLo+nMtlTxydgTJydqXePW5Ot2msLVG4fvKWl/mhR2QbX?=
 =?us-ascii?Q?3EJjArbSNmbFRjDRaruCILt8u0ZBa/XheDKJpt9sQ9auK4eHRAAEcOB0lvHB?=
 =?us-ascii?Q?T/JOXtW8ki+Axx5bGPR8W86Nv5zynIKzrd47y4gd4Fj5Q8jnAc/wGdrlxOKt?=
 =?us-ascii?Q?bYxxHXLlsO/i09q03Sg7yDdCd05HWablzjlEyYkl4ZNkL+R6/w0otMXtDv9k?=
 =?us-ascii?Q?8uDhqfr+fAku6gRLNxZeI3Sc89JxMvJTMowSw9hzWqveWPHhzKJ+Gdd7zEp1?=
 =?us-ascii?Q?aXtbi8l44vdHSM0tjSp6jKRgsiew4HfRUOkCZ/+9pm1opoQ/1QW06PlmSikm?=
 =?us-ascii?Q?U43j747FawSCPE7nmAxp6nWoKUqErqL4ID794FI2WATSnKN6jSB7xGrmssW9?=
 =?us-ascii?Q?K7RGZBKLZMo93dExSN4eE0Ogd+54KUijXE+t2Tx8SkdU1mSr1PdytQUXtxc0?=
 =?us-ascii?Q?j+yIteE8/qFi1CbTraHHoTi6A/lfBR9pb3d547q6NTm5uviKRE/ltxnI1jxx?=
 =?us-ascii?Q?tyt/TcSO6YHJQNQsCDEtgSlvnIFJ78BDLa1BZpdk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95e7b63-7245-4a16-545a-08dbed060493
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 15:57:10.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nA/xHwD0MUT3hlm1dHrUVu0LmUMciY3eYKfLgeAAtADu+o55VBWol2nPVPddytQkfs8r95xkXsRDarBGpuaLow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9210

Keep consistency with other functions in mptcp_lib.sh.

Use KSFT_PASS and KSFT_FAIL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - Use KSFT_PASS and KSFT_FAIL.
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f8be9dd0e20..4b30a9634f16 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -258,8 +258,7 @@ mptcp_lib_make_file() {
 }
 
 # $1: file
-mptcp_lib_print_file_err()
-{
+mptcp_lib_print_file_err() {
 	ls -l "${1}" 1>&2
 	echo "Trailing bytes are: "
 	tail -c 27 "${1}"
@@ -276,10 +275,10 @@ mptcp_lib_check_transfer() {
 		mptcp_lib_print_file_err "$in"
 		mptcp_lib_print_file_err "$out"
 
-		return 1
+		return ${KSFT_FAIL}
 	fi
 
-	return 0
+	return ${KSFT_PASS}
 }
 
 # $1: ns, $2: port
-- 
2.35.3

