Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0AD182A7
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jKhjheoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z99/c2Z/rq6LVhs/7wIR+J1DJ5zhCWw6PYX/UpXlFkd62sUHgFqOPM8jV8Wg9GfE3Ag4WP6ejN9m2RrWHHKhFo55+o1pZkkbkfTQKBqJbrA74lSZe69CQABDDKxabdeVluFY7MVE13526ccM/DPymjO3xdeKvtTsEQv0J9YocXcOk8CHiO/4GgS6aZGmd2zaE8+HjrmKCPTyTIifNKzHFbSxblk3fHJ9gQlLcQy5bl8HRlg0q0EDz1A+pwjSkbHmJAgMeFpGe7j0aZLWxL4FInWGTVGzunKcTTUy5oPfCcBLQzJWOny6dQZm4iv/UGsMRvWqdesXsALErJMEsJiX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpTA+rbxgriCpDcESlm22vX+XARIrG2/9TVqbFSxWUw=;
 b=GWgR0NWNFbI8WpyRXn3Y99knYWu1D/JJaqPhuDdMbOXzXlo6PGAln2TzQe9MXNNEzwUZBtYgyTjk4vqv+ETwJaYfUvTVFBVyFjSWn3jmpHPGJIm1u0b3z9adBh43T2nNCBr+5Zk9DO+ZhoVAyqMwTF91oY2ThHDfco2U/E+54PIEQqXvK9EtgoBTvzE4nUqVNpnjtDMbEnf++YaiDvU8jm8i7JsxRwXcZZ23h7Fo5pnBihTSgqXdioK+J8pc7yvvyINAhS5Ybnp21qLMXoLwBnjJz8CwxQ6fpFlkX+lVJi4GdN6Q7zVtDCcG4A1aOEselzzyMpBGM8vly/hUpQ7nxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpTA+rbxgriCpDcESlm22vX+XARIrG2/9TVqbFSxWUw=;
 b=jKhjheoTG5odEgogMSDKd2pVp8XEi5ac5EF2oT+deNFHYT22mVcp90L3h0gTUoXcGuXGY8phJAfRWtaR18JEz46kTS0esGvhv4jKIr1ztZJFE/VMLn1cfF7j2JmpDxMvy4fAKFG8+9r8qGgVS6qsqdfMHHg3zCUiiSOgHmpTNap9Xpy6JaYbJg7cUgHm3rHve4Afx0pfOE4TBV9Yh4XDFXqeh9RCYDWKaYnp/g7Em7o3k/ZpReikQkk5GHEQoNeusjFBD0qFW5BzuRbMrSKOzVqIpu1Ahil2K5y4DnNYGjdYSAplUtl7AmbJXLRTdyQTb5Ywu5FOmSxt5PPW2X95qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:32:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:32:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 27/27] selftests: mptcp: rm userspace addr with random order
Date: Sat, 18 Nov 2023 22:28:42 +0800
Message-Id: <e1ed5ed2d12a875bf6807d2c973784ed01ac6658.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: a86b0dae-f354-46ad-9b09-08dbe84328a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7/Ldg2O1gg2a2VgorZ0Plf9v/4L2zaGKKvF9uLYDnA83mXCE9dT0a8XVKeHrgeXeip9B0Otp37VqwJ+2NtirC4v3w6ZC/wA9tu3Hpwcpx8huXWejWjI9eLRuuhi5iMKZKVv9PtQc+ZoG8gKc/8BHoRaKC7P3gp4Re6W26eaTpG461OVKQUv+QkevnTYVlxBcuDo5Dh9E/dSt7K3pBlyN8BaYEYt7k71+ZI5W/DVhTpVpsdh5jzW4bTL3obXiTgHuP44AOyi8Rb/L3DIYtyplka/M9ivFm5q9MP83Mf9Kt8EwHmF8tLF4wYcDttzzneoc/cNv02tPHCoit/e6v5HjeZKIGYwEnzxTvtoE/wr/b/pTsxXB82Od3zVJKOE4YW4XrkPTk0WwBT9v7f/zmt8qHq2G/3elF15ncMkAOdTkZosN1rw7NTHorF7aj11Cwbb99yh+KJEUwqIG4ghFoEEogaHzzwfEA21JJYrKuujQbQ5pUb7HmYEp6Qq1jV4rAhcuQSAiSdMeJvv/KPTP1QkLGBMZEh6l9nJG62VN5HuRDS0qFc8XBnEvIl6Iiuyvb7r8n1EYFvg19LqiN5YKLYswRuMs4SOr9lhBWdDF4NhHj5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(6916009)(316002)(4326008)(66476007)(8936002)(8676002)(6666004)(478600001)(6486002)(41300700001)(36756003)(5660300002)(86362001)(44832011)(2906002)(38100700002)(2616005)(107886003)(26005)(6506007)(6512007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4/Ti9PiYkKEHf7gD96B7vaVtkuhx0QFusqO91e2k9rMsW5sO+iSoJpdlkjva?=
 =?us-ascii?Q?haZKP+HC01WwarMWpJJGUIDvmy0NWTIo16td1Pbt1CiCFwrIyCUoXQuoOleL?=
 =?us-ascii?Q?q6EqH6XV0tms2j1WIMGLBuDSSVkq/07+uO/nzgfv2EtrlfRq4G3ckyERolRi?=
 =?us-ascii?Q?huGz1DSqrKf9Xb4SKfglEZI2LA/uaPUm7xbMAGBstaf0GnWUmqUlLgtSYqVI?=
 =?us-ascii?Q?TSM9q7kN4XaAL6zVowMrOfxI/8z7fNXBlcbeJniu1rSzdBNORajR20PayS0l?=
 =?us-ascii?Q?bey5yW9MZm1Iph5GL+SVPsEPiCQ8jnsQ1eGhIi5Xd/znLqODXVc+TbvwtCzj?=
 =?us-ascii?Q?60yw2apavKAe5ujE5joTa1SK3dZsXEbqYMbMlJliL5HHKEZs4dBVRhCtH3nC?=
 =?us-ascii?Q?HuUVzrwlvBluT0teLY3x8oyS4s+akEla69ZWI+Ca8EyoMuq1EkxvXoZm2WZ0?=
 =?us-ascii?Q?VFI4k32OroQGbwfWVEO+1hqprou7q4aXPdrHgONTzJvGpEGhQWdAq4v1vsk8?=
 =?us-ascii?Q?IY6QP8ZjUbvVGOm4oxjLE6IZa/XYk9QtC3CLMIy9xPjGbGDGbzJw3Otz7b/k?=
 =?us-ascii?Q?Y9m2r9z1ouKWqDyxn9cY+HzZphO31ijH+dFKHc386aDWOR1DZptYgNZ50qpK?=
 =?us-ascii?Q?Cr2iSP0rHefWQG5i0JEQNEKOxYIenUCWpqPqu0yslkhnOtirpjV/dM9FZhFy?=
 =?us-ascii?Q?iCPREu2NoUHQXUl85QPScH3xXOkCzsbWfWgLOk/ZOLyyRyvt1Bb8onMFZcwN?=
 =?us-ascii?Q?oVBfnmq1Li10sDxesrmr9Bxcx9olQNTpm273n2cLEhE59VhXPuaCzqLRGkU0?=
 =?us-ascii?Q?Yr3dy1no5J6fT+EankWYqwwfGywfKqppm5XV3QiHk6H7lM/J59p16A+VvSla?=
 =?us-ascii?Q?hpvHpg35jmCQAeCDqR4KppY48ViNhzI4FScc0ans61BTFYWfcq/2teVTWDVJ?=
 =?us-ascii?Q?3WYopzkP6Jyv2r1DaUVrPTxay8iKLT8hXN7m4YKfLmwGlErnb0HGzRqt7BmQ?=
 =?us-ascii?Q?L0bkpUobuVn5GcEUPZmgtHWO1DJg1+9wnpNqQSzKeyQ0GytBYonrgobYA3mK?=
 =?us-ascii?Q?oDhGhHmFAMyrg3+b+/UQkl8rlN365bE5VPv8yMuagmZOoFiW2lTJQkXLwcvr?=
 =?us-ascii?Q?jkcLiOssd09iIrRE4+VKMTTOuo6Rg76wzkosXc9bgdT28LPB3HM+NHBpG7cQ?=
 =?us-ascii?Q?MYzeYMk0ZurrPq0zBU7JXmsNOkSFt8OB7Ub7XxumMNbRpfJoT12jU80z6MrC?=
 =?us-ascii?Q?7lQ1VxRiE4V5Y6yNpbRsDnfCMwAV9lyR+4abLfm8lELbE95yToju9jyOc4+i?=
 =?us-ascii?Q?9ydql2W6fVew5uBweaJ/fGSqzoe+beYls47q9ZxsfW946ZvEHunMbahalal2?=
 =?us-ascii?Q?KwYGQ5MByLcXuvvlrRAuAEH0GEFGmNWI/1sMqoKab6Pye09XJQ6YyXtrHusJ?=
 =?us-ascii?Q?sbA7iuo5+0pLHqv0SXER6IKmgVPi/Gvb83S3MEn+rSf6pvkwCJvaQBcdWscC?=
 =?us-ascii?Q?8azwVPfrQZSPxxcvVsZr0EYLMeylKYc18Ab21JuHLkmsfgSsIBhTjG3l76UK?=
 =?us-ascii?Q?1VTvwoB7+NGsKuUw4TzfnSK5hlZzXSRoC3uBiXRK0AQNlo3GPKAZtXHHpi7g?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86b0dae-f354-46ad-9b09-08dbe84328a7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:32:14.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiMQXPSdcoo7SoPggat3J7bpZpluQGV+2TdrdDAzjkhQyWFFC7Rdw7JxoDowuoEiy68i19fe4BOlBmUbyXN/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0b37f6ccfe53..773c04b6759f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3412,8 +3412,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		local rm_addr="userspace_pm_rm_addr $ns1 10"
+		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED"
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			$($rm_addr); $($rm_sf)
+		else
+			$($rm_sf); $($rm_addr)
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

