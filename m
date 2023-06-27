Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC2A23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MovuE0s3T/IFxRfEGkkUnVWBl37Ind2KN3tSobff0kLk+7Qs4TlM1KIYQBLEfq6eOqfKaRuQ2fYolCS3rWT8jY53nV5ee7CrJUAkyhK2kKIoS/2liBE+zaX2pNZzRSsifIpBc+6yTdb/U0K2FhFblO9hjUS92Ec3G51mT0u8g+JLuZ2cgGkWzix1Ii6hQcWGI52up+gBiMhHeEL3jtdI5kN49A27JNq6erF6LNGUv0Fbto+bvxWOiMbrQjt7VDRK3yDPrMmUdK7ucV2Y8IrocPCLKGSu2Bsnv3zmRqw62/jaxRn0fN9FZn7GLMeMfPhBHb4s/YJHaZU3PGe7XG34Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bpGnxXL+o2v7epwiNVrYRkvPGMU94h486ttfyQiImQ=;
 b=fE2bGqymIU9WiefbGv4KUn/P6CGdSOdkLffdqE/dix7ZGQIk3OjUUp2dp+Uv9iL5Hxr0eHbH6U9Sx+oFaWQbf1Q5MdKBpMOhYyk9J083ZCjWjajHfLu2ePduedll7cLw45Rut3oRCMgMjRLHxA4u3d3vKmfluoM9wNeCHAa3cEvEHHmxvZ/0GuYHGSh1p4FcUrQ9YU9bmKs4AiMsC7FgAv0zlUvKalY8Mi7oL67/5OqVM4S++XmfE6Bf9+a8gACTsgLZOW6VvcCNJKkqBFhgQQjcWJy7Vu8vt2RdV2fhi7sLBQ9AiFbeN4gmWaDlH57B15rXrgfRHJejjUE5BkufsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bpGnxXL+o2v7epwiNVrYRkvPGMU94h486ttfyQiImQ=;
 b=e5pd3P0hV6Y+fNhjmADkwQm9LWFyWkb7EGB4tHfc+cgFbVioBMkoiHYTDsH+mfC8Tq80Vz/R7XZkLHPyqa/hhE0HdF4X0GLT2l+aRfH2VRSWpxW2QNzAllgCDVWYF/iWTebR2kshI/X++poky7ELq8nHlXRF8EZ0CEKAESkYCjEfhpBqrWszA9TVF8vwXffpSQXSomRKTIsVg/PQmJ06ITP0vwKC57IwJ6VYUD0kNxnko8jGFAlbF2qFdgp4OdVmwegQZQtmp4YVR+VSeXwEIU3Bspg8Z1BURr3V5YrPvEPXvb1pg7exP7TM1K1Aht5OkD3dr3rRiKuyq39OU72i+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/10] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Tue, 27 Jun 2023 09:39:24 +0800
Message-Id: <f7461cb352395867be2f37ad6fa2b8a2df772c77.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe347fd-cf1f-4631-db2e-08db76af70c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WivPSpWq/KSunWMOAc8+MT6BJ9NFgW8aiOKjnWAr3NJ89t+WNkn10KffX1OKU+iyl4Tf7gTcaBfduQTJBD3ogSaLgG8tLbw1S4m+JQg4ZeAgLK6IMm2kf1cgSvbNTEH65f4ExVSFySXXpxk0VMjPZvNhrb05pBp7qPCzoLUlEx+WB1LfF1JgzFqTCl4XmIxFJYSRlp2eyuq4rgEdTVseot8jWfCZ9rlDbjSg0ski9MVvug78nND8VOC03s1SbxA3LFPnN0f0VpQin7g+ibz08KGlotSTKwNiazIzg09T5l4G9E2OYDoVWEt6tzbxIMIKIUTySSo5WQJOVcUYT5KhGRjKRVOI+yfb1S1Yi8h2NlNkt+ZkuxXCHEt9ymGteAJwM1GbDAI90OgOpvSNCvPiF2LbNCCCKcWbXZxsbADW87rloXU0ISd/HOZdrGa/rKDb1u+vsZoDVFmlIpiFw7ia5zHZoONfxyornnBK/kKGu3nfNIPlqN1gIdtPydxCXaP/87Bcc0M0RE8ttC62LbAOxOpFvO3h2uC1JZnPDNfaNgry2JCFcOYTZWnS+wFpoG02
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(4744005)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdkwQSUpkZzUWZWAyYsZlvma1F8CtL+TH0ltys+RXLfrmogK662Hjh3xrBch?=
 =?us-ascii?Q?0b1O/LyWyN8DyyTgKm5YFHZIGhggz5RL/Q+4r7d4KothLehVc4Q+EfQtDXu4?=
 =?us-ascii?Q?ylsUWL8akNSqenXeulB1ACQ3AQKg8Q5/0/8h0gWX1dmKhYYxXISQ6wl89kOy?=
 =?us-ascii?Q?cVMBJ51dr3+XsneojqTOyKf1hb21j5MWMsEGdcHr9OJ+fogeqMvOpLUiR1pi?=
 =?us-ascii?Q?mhzDW1G/x6LXxTkBb5p5WmGkWZR30dK7qN2qhm39bdLSDCZLHJGKbur5or4z?=
 =?us-ascii?Q?SnWS/UlF/VgQPoXAMj87tZE23jLxWt35xc1/RpqkpgB7javRf94cWqtJ/k/I?=
 =?us-ascii?Q?AhyFDoIHesU4q0qASqPe6/RlzvGYnCC5/3nOWSiomrnC78BzF+9Z215TfpI2?=
 =?us-ascii?Q?YZ5738v26ob4S9uN5k6adcT01QVaHPBrNBldOJlbrQInFfQkeuTREWoejQUw?=
 =?us-ascii?Q?G/mYWtaH3+8vy80P20XfgMGBjvoV2fpMjcK2vY30GHUDZKmxX+ghVuy4sdfm?=
 =?us-ascii?Q?rc+vksBzj8ZDGxwsaz+h1Bat2efUR1JOeGRp003Qq+Y1J/QrCym5pHBhdjPG?=
 =?us-ascii?Q?JRs5HaJeIZ7HtPLvXMolPZItwpmxdb77scZTRelJSuQ6LgrW/OPi/Q/LL8OP?=
 =?us-ascii?Q?uh+WNf1X1veu5aQig2kN+u2HZGFDrrTugpjaoMs6oFw+rIHx8IT/jAOVOvTd?=
 =?us-ascii?Q?NbDf4eY1NxkCT/9h9MavGnrw7EwBHULinGIB/iuGRuBHssQU2BtDaRUUe6LP?=
 =?us-ascii?Q?/SLwXYJfKpO2YsJZBl8mqvSw4H+9Vyv6D+E9WA3/WpftGumFZ6d4EYAeHqWQ?=
 =?us-ascii?Q?uJL5UR8vGeRSWn/VeyiacvKV7gLG/teufppJ/wfEMB0FnvUf7Q/GQh7xEn3i?=
 =?us-ascii?Q?K4SKM+F+XTaVWrUvts7a3NQV9hRJrTqyV94vFzbEMdjoVeHHp845ny4HkiQj?=
 =?us-ascii?Q?ks5MN67CaaOU0E48LULNpD9/qZUMsT4k8AtCmFjIqcYAjAdxtOiVcFw3IeY3?=
 =?us-ascii?Q?JjLEQk4P1BwgbHfCSgg1dtXZwZZL+u5tTMuWIQ7B0onUDK2dE3xqkxHk71VG?=
 =?us-ascii?Q?/ZCnTIK7eD1AzokdCJYCTXWjBdJmjQokInIy2SGtvMOxWms8DtBMHv8U6XQc?=
 =?us-ascii?Q?3qPoRmoljHNwVX+AVmFFEXaHZS21Bodmqg6SbH9aFpbckDwWjzY06o3K5mce?=
 =?us-ascii?Q?dpcGvMdeaQu5ACyEcIntXr8IzE6uh8VZM+d3rgVvf6416mFT0SDSpRYwhFzI?=
 =?us-ascii?Q?uItUbGuauxtpkIrvou2lhriVyXYNidz6xg5nz7uls+rr8bdz9HA9OmpF+9Bh?=
 =?us-ascii?Q?Dy+CZLrPiV47Ve0F8JklXv89sfWTbR95UJoYaCW3ov+nqOFNtI3JcfpUOzB+?=
 =?us-ascii?Q?440U8fBlKJenxwrjgdLDrf+xHv3M+PbCf929UBJseBQUl4PoJRZehwaxy5DP?=
 =?us-ascii?Q?vNMDh4HKGP8bm9u+G+3HlWETnrxy+dc6FYwWIXFxkZI6K3+bgmeLjzxyMUzM?=
 =?us-ascii?Q?379JA00MsLohKs5u3RTuq6z+QpGnQgYNdoUyTLskWR64zlYGmlN0AszlMymR?=
 =?us-ascii?Q?/hc4wF5Q9pS/Y4d2FoyAwlXLpVgR/cj1QM4F8xVK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe347fd-cf1f-4631-db2e-08db76af70c1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:08.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ukKlVbEVtKGdqMapU/uu7JOZGnesdonRvHcX9FxantzVsM9VoEn4juOCbSA21iTYLEOOb0wwY9+eLH6kKmmxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

Update send_data().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 21b7ac6d72fd..f58b83ebe52b 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -406,7 +406,7 @@ static void test_bkup(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
-	send_data(server_fd, client_fd);
+	send_data(server_fd, client_fd, "bpf_bkup");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
 	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
 
-- 
2.35.3

