Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0107A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo8AMBUJ8Qns2bUFx+lBTTVEqaVPJ2QHGXeK19u6Glz3NznfrfEFllVCmSwM1/bMSxwk2ZY3IvEcsm5VP8vX7CzT7ICh3Apq8MGW7Hngn+lfZptM0DUOVZzEbh0R6W8o6dKokRsetP9hpCl4DVVkfcDuuTAe4/JqjlYHb8LJ+xgMW0tPUUfNFEpMPQUx3q/hlhVHxjm1frxBItZ2y6gMkdYMTqxL3XFDwRyhSPWuANHbI2PUKWCM5u1E8hVmuq9gwaOURtCWXWd06/4KH5CsP3YY+pP1C3L+RvqNsQ7RNmL6mIb0cUEC/92xYjvWK31k/PdddtNaOkxUU1egAZh2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuauZj02I7AYWy6nBktosFe7d8yFyeW98n5zES2GGfM=;
 b=e+aNb6snS1cOSN9rPVRQLi+caAEjSXMAbIf5M2SUGs3e6A5BUZ6w+XPi07en7yp19bb+NkOBpK9V8M90lN5qVAv5oUgToeqnbSBXnwQ9SM7eZy+iaiRCu3duEMFa4qQwPVZysn5K7KlGGWx8xQGFxN8dOsm2OGENBD+E0K38ZmEOv35hygv3wVh8IjnweNISVcqksMFD39elo82vvsMc0GBMDoE/56mM0FriGWrvMXVb8x9+HatpO1OGZ6C7PNPvbQ9aGSxQYsuIkyZpdLw5hcZgA6B7Ko4IHexezzL7kLEBBnbsNSWNOVCClRxZQz3coqXbh+/xFV9E+WC9qGGfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuauZj02I7AYWy6nBktosFe7d8yFyeW98n5zES2GGfM=;
 b=kisnfktT0pldnoFExXW9WAwXg1/N2aka8Kq+U7qCaeWCNSmvDgmDcWpuDGVrjw6G1gb+gG3wXBfd4FNCVCaUAbkJALZkQNdMu1hN688sFX8HXqrzqxgR+2v3jag0mpQrRQdjk/wY/KIuUQ02zpgHH5i6ZenvC2HQX3teA+zkPTLd9UQgX0cJ0EpUzUSBp/wIIPdN9rk1cqiUNe/x0EdD1Cfp7d7GyR5qGimUlQURKH4Up64SAk6WHdHnWY9q87W9W96UF07eV2XSFOqLA+iL/6gti9SrTQbXE8nIKLLOBb0sMB3XQlRvMFtHHpcgaId3o85Mwdcavgr3VZO4oOKClg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9150.eurprd04.prod.outlook.com (2603:10a6:150:25::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 13:05:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:05:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 1/9] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Fri, 10 Jun 2022 21:05:26 +0800
Message-Id: <17cbf2a479974da043b87ed313670d3020504dcb.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc488fb-1ccc-4020-af31-08da4ae1f3bd
X-MS-TrafficTypeDiagnostic: GV1PR04MB9150:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB91506DF50140416E6E1C7063F8A69@GV1PR04MB9150.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wfm1evTBSI4T/NrDj+OHX6q/W5X33bvt5nkM7bsNxxKyYHY4mTAwVKMrSugXNrBL5LeoAwgYiO6OmAxvXg2lVuXUFQys21br9mvfRAaPD3Em9NIT0/VNnccyLXpyeGEnguzIVdI0JkzshOmjZtXWpCI8Mub1U2fSWgwgenUAYgdl+n06yveMOZULxosZsW/lWq+fDuH7nsabY7rPRE6o7s2J1JLTYO6syDGuSEJSYOALHExYGRkXhVVomHb0gZlA2IeA5PHtR9K8yTj1TU+gZlb5mYbpgnYkR2Kq41sbQ2sFr3NatdA/LHS0UrQ25Juu3H91N317J1no9JRADhROTCBcCxB8H2TDmNXHHWEKT+7VyzE1Oew7kv1EoiWkZw3fdy6USiAwBl2h4jQu1ZmOi6Qw0qinis2+h7psT7JO1mYNsSfRsS8pHzEyFrJpFt3CuZJfu9uDhBtdGAeb+FqAkIsq9i+AcLdoEjb2vfQkkzd3gp4byQz2oxNPpoZ8HVbXA79osT6YQBQY3hYNE2QN24BOMhVkos70M1Jxb0EcApAj5smEsIxGY9XZO1p8yvygtZ5SVAGDyHnpUyznxZKSYuL4o9nqyIkVlYyGwROhHmr37Kg/yHu+tyGTnMLSasHz/jvtXbStLOvnt3DQHGvopEzRO5TfiFoT7OmM+sdWexvQYyl36XghsgMK7b/JqXTELrYKSkdnsdEISwtTdI4kLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6916009)(508600001)(44832011)(5660300002)(316002)(66556008)(2906002)(6666004)(66476007)(8676002)(66946007)(4326008)(6512007)(26005)(8936002)(36756003)(2616005)(86362001)(38100700002)(6486002)(186003)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8M1/gDSgVrWdk3GZbyxdFJ/NZmNRkzjylAVEQVlFGBTU5piAUsApx8ApZXJl?=
 =?us-ascii?Q?ONkYSaa+EAhyiVCz4HIeCTxQDUM9GzwJOHTLkuCWXpDYyRH76XRffw91GoGO?=
 =?us-ascii?Q?CwHdBjVgEqPKbznGLPAS7QpxfHQ0jkFPBGRLmXZfBGu6wNYeCIb/ulFookpH?=
 =?us-ascii?Q?fVc9dGp6uYFqKulnk8ELsPaJK8KRawMEF1J/MXGb1rIvJsSYabsZWUltV/Zh?=
 =?us-ascii?Q?RFZMj+Fw+2XRTPCQRRHFvUSkVlOiVLWJYFx0480DgIfRFSxm3wYpoAwHh7Rf?=
 =?us-ascii?Q?mK1n8VGaEIG9/unxcBtbOXSjuqiTfjOeesUh+W0AVf0YIoKwcnvKJ8gLnGTP?=
 =?us-ascii?Q?N7SSVugHgHXSWJCTdcyu/d/Q+ukdMALt4jo8zM1aOFihkqg5UgfQfhJWCcAj?=
 =?us-ascii?Q?oGDbw4tA3gqcEOM5cJrSms72AyG3GDlO4NrCtRdlEv1PwoVQy8QI29HvQDge?=
 =?us-ascii?Q?OJ1M3Aoa3sUDYUKM4GUHolJh7PtCfyCO0H68xQGCBhuIt6kldN3ShKW6HKja?=
 =?us-ascii?Q?nA6dmD/3IYtyQ2G97WJlC6aMT90AzKil0Zwb61owhv/dkvW74WmlrvR7noTe?=
 =?us-ascii?Q?kt2UTQdIUrAHmJm0nT4PINcgQWXzwxR+9bMdgNIfUQsrYIIPNxpUSEpQfXiW?=
 =?us-ascii?Q?0OUNBJzhGVopoHb1y6JHNp/BtMYDr9rbpmmkv5kbT1BT7Op/hbeVJJ/IiFQp?=
 =?us-ascii?Q?aBsrreAJLZQSJbCAa3ixFdlPRwvZJW6r8cnhwdxoQy/BFxPZIJIHuu3jcZNc?=
 =?us-ascii?Q?/xB63slJL8Mb1wA6M4UAi7TmsiB2G1QeXgKy1r2JBtiV+3rxwxKimUfBLLsy?=
 =?us-ascii?Q?FsCwYKXm1Gc7LPEKx5PtZ+sEpnVzx0PaP+Ef992rTKDzgd/OYAKWWAdKc/Ck?=
 =?us-ascii?Q?5cTLRPI7tkXrXBJiLx3d2OpA/twAdy9RiNfSxKz85GyXejnn0gpV/oZ7ttHc?=
 =?us-ascii?Q?UqifR9UdgcQDB5w4yExJJNmYcX6dMwON7Qejv+LobhbZnPtXHI5RbF7sw2NQ?=
 =?us-ascii?Q?udXHM+zhfv3lCSfSObuTh0FcLPu39sfYh2engdbkyNV3bxvG2G+raeHysDg0?=
 =?us-ascii?Q?tqAUdG7iJXoeP8RC4ZFTsyHAvxT/YKm4Ndffg+8etWQS6Qs6+dn8WsSEs8tK?=
 =?us-ascii?Q?3yTBMcpBnXRL5o8ZWwo7UaPRo2G/N2yNEdaos+V6/i1KZdBC+ue3x9GlAn30?=
 =?us-ascii?Q?XCRrn3RLf5fVThoAg8mLq6DnaUEU4atHcbn4llwYQRaDvPulWI+PkGLBOHQG?=
 =?us-ascii?Q?WIVC35ul34ZXaiCBw4Qc/J/m0im+XXlcewyimj4CltaG87ydIyBwMO/Hd2tr?=
 =?us-ascii?Q?E0DeZ6HPW1SDr6w59w9H6askrtuknINOqKdWvHScOc15SHa1LyJT6thRph8/?=
 =?us-ascii?Q?udz2eNUzwCeBE/1ckjSKL4dppSx78LvBTDk09GkGQZrvJYZXA8I3lDnFN0K2?=
 =?us-ascii?Q?XQ0fmV+1ZGTfJGO+b8KGY4q3+f69hmuk1ypX13NmGxePPxR6ITEkE5YBG01G?=
 =?us-ascii?Q?OMtu/hdqmvl9ZP+7l3jHmVDF/C6F8oScbS60gfzRZ7BSZ6hgv8QZjpSUXrUE?=
 =?us-ascii?Q?p39piV3YYQxlDUIR7oY9UJXRSAyWp6b+bPHUquMs8BkP5QRXJs7ACYgfnAey?=
 =?us-ascii?Q?0P8XS090Td+94BUrZrG1+UeJiyxZcnTJcGy0Mvi601el/5Yb1xZdoyxymVV0?=
 =?us-ascii?Q?O43IO+Q2zZrza7DCr7zbkhx6/xKTR1HuCTDzT7JEiobxEo+hf80qMQ8YCxkY?=
 =?us-ascii?Q?9QgfbwlSotbs/Ynb2F1v9sRVXyO2XC4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc488fb-1ccc-4020-af31-08da4ae1f3bd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:05:54.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNgx+cA9a503Tuk6T2rblNqbfZD6VjHix//altnA3lJ3IfJoKCh1FssUAz0cPMNjvB2tE7BPBXeZ6xPZ5CP1ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9150

Add redundant flag for struct mptcp_sched_ops.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 7af7fd48acc7..5f34e32830ad 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -109,6 +109,7 @@ struct mptcp_sched_ops {
 			    struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
+	bool			redundant;
 	struct module		*owner;
 	struct list_head	list;
 
-- 
2.35.3

