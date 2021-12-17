Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C72CA0
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 06:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1639723103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lu/jq8QnGBD2BaOfJmiuJrZ8bHLeR7g7bCfEhViAjPQ=;
	b=Py/v1iiFgWV/7O3vE3LkrCJ4lNpwP9eClRJc2AzKAiSdQp6m5lz5js9y3zXDjru1sZtsaC
	KhZgmBjQ3Cg6Yq5TkrOVmywjEY8PxlLzQOAchBbd4XUs1EF+1M5i6MofJH7AzREAbzVfOP
	/OdUJEVOqM5SRkZJR/e4z8Nd/hYKOHc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-FTzyz7vONqey0KgH6WLhVg-1; Fri, 17 Dec 2021 07:38:22 +0100
X-MC-Unique: FTzyz7vONqey0KgH6WLhVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9vYblD+KxEqn1jrn8WeO3OmaVLD+civfX+4xROcLoX5TVppTW2auBrDU4dsUbnRKiDc9vpTCZFRPkkA7lpxZZ2pGlR94kVZ+ZwNn9bEjMar6J+u0JP1XbKdT3zLmvRQo8YTyB72jS/+Xyo9UgT3FY5TKn2bvtd52ab/QttZzo6mYddEI62pd136jrGWfhKUmW/eE3uv7YESsr+Uso9MGzpGYGsYTnH26ZNnC22o/xbwKi11GGjEGpCv2whAXZE9rAAzhhT/ykzkwu9+ZRg/wdcdRmqJ8qt2HuECWVDWvf0UxPchRAyMeeh1CHYtZ086jHShHg5t/UC8AHTF0PhmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fnyz+NqKuiMVrzwRVLEbLL9Dh9IHKNq9arVgRw0v2oU=;
 b=ih61vvKQnGxLFCHTA2GE+GvIZWgPjGscfGhInAgQFlAKEWhBSpjCQC/O8dGffX9ZDM4NJwQp2on0zgZ7mwAztzavUmJyos/sVBSEHzCESqkM0N8h71z88HJjv+ojgRj6yc5UzsOYgUFPxq5XoOAPhg9UCmKpbdzt0ZltOVpU9/C6T3NXgG5yfGNGP2ExWnd9SJo2d1QqNA/KBsboNggQXRAD501VxwuYQrV3kOy2gvAJhtzxg3OF/M8o9mArb+pQDcqytSA+KwLuajCcXeLmLIOqk02oXH0EW3Ijz/5nGCzo+cJ86czn4xK6JUBY1QAmEoDxY2OiNYjfyTwIRHv0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2444.eurprd04.prod.outlook.com (2603:10a6:3:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 06:38:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 06:38:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] reuse __mptcp_make_csum in validate_data_csum
Date: Fri, 17 Dec 2021 14:38:18 +0800
Message-ID: <cover.1639722883.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df30f074-88a4-4351-c67f-08d9c127d19e
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2444:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB24445A509CFE242B2F9CBAD6F8789@HE1PR0401MB2444.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	695A7pTh4GbrBkY5FaO7DolEek/LoIg9F56QE+F1IsQK8qw/6i1qTgC7pR84ZU5D9K5J7GXl3tKgJ8aQUwMk4e5tRch2xGgadkqG3zERD1KiYgN7JTMtwNJMGlhx64nElHdmf5p+1a/mcEKgaxs8DwUljqT+SvmN8OHsaWGgNkOi9QRmg5Ay33sYs1MQxOruY2xncq1nBwjn6PIWvgPD2pc90WtERUyWhCvP5k5+0eWpBdQvG31bYifH7WarbCszcWtl7IlAU9FRqoMdcVD1fgnYkT7+EzCV9PRD52hhR4lKdgK40EF0tACfE5/4133POYi+Y3jgbb7V+kzF2EgsBQGlr8PsssUj5iauRV9ZsvYzElv15y/jS5h5bGg6dQ14V9DmfTttMKELLI5+DjRwqwfVHT0H3pEr5ujzMJ45FbjU8gnmGrbqS0xzsirAqkr6Fo5GYY5L7XuVrFbeUc0uCdVWlelQvt1jZi+nQrX5ZSW+oB5w1KxOyQQjT0Nd2Yta4fE0aFJ3T9t6J3cZMn2SMviSorGNLdtlbuYEzkIai3I8vdyrxpBWWpjA3cVQtTUd3yARM11z2RNDx4/kOHDkEbORuZ7GN2G2f0U8imY6rQMuyVDo+ZgLr8uOzSWLSzUZAKJFZthlzTbpi7fvncVvwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(316002)(5660300002)(2616005)(55236004)(8936002)(44832011)(6486002)(26005)(6506007)(186003)(86362001)(38100700002)(36756003)(6666004)(6512007)(6916009)(107886003)(4744005)(66946007)(8676002)(83380400001)(66556008)(66476007)(2906002)(15650500001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GdJUulhYdf05f96mdZpxjIyYrInbxu+l8xxWD/uZ0OStaeOJZOwIILmJ/VKA?=
 =?us-ascii?Q?p8Dsvk0leTenpQH8UgOePz5znV/1pM6jyEwmFQDE0Vc92N03etJnp8A8RG7j?=
 =?us-ascii?Q?TkkjItO6XaZHtXy/JpoEcBPbHuoT8PXTjajSeMsimVwEzmEfKU7alh+BvNAY?=
 =?us-ascii?Q?ToxPpe/ZwFpzTESN7ynSFHjbvLmp50q390fN1UuUDPDjJ361pmGqb7AdxMrL?=
 =?us-ascii?Q?qVrNQxB1DeoxKebq2G6lwl5ePiLcvoLPBeqBuiu0xVkgauatMVUnpOSHd78o?=
 =?us-ascii?Q?F8UM2N7twG5xXvguOeXGEDdS4bMEqXDlx9SRBLLBunQAA94SrLpD1oijpn/6?=
 =?us-ascii?Q?QdVrMprw31dT+9ZG92BlOCnvkUhwEsWEx1yp2+VTJ0dKeIlTN8XRdQoE/FGq?=
 =?us-ascii?Q?e7BhHWl2nFQxVHJc3Pa0CFtyERSejhLevgollpK18h1ry/conwpZnBj//OcL?=
 =?us-ascii?Q?X8hh9FIVtx+FFJXqUAFRDZBOrTmUQN9UMSk4kHpz/ysiKdQBMUdzyf5ZfkYP?=
 =?us-ascii?Q?1SHgXhd+WNz3f/GWhpwSzGCXS9bzm4iM3k2IBxTt5FykEIs70Z9QIRComgrv?=
 =?us-ascii?Q?+EBrTUVU/5X07zvC5VOQ5jdmICJCMx+Mutyf0H8LSB1cJ26CtOr7O1eh+/Pw?=
 =?us-ascii?Q?KstEET7CSm46UOHsMINf8DkYWgBN+nf8U4ADugu0HiM/ATkSLbvtu5mryV74?=
 =?us-ascii?Q?2B1rM8Pj++Lzn/gHGOkCtoIWW0ntC6yezFiMFIigRhWKx7JXUFGfUtLl4+0r?=
 =?us-ascii?Q?C+zqa4GLYjFrzGHMTt+mdX9OrF9uqrigPQzYbDdJFLvvXPv78Gh3Z+6zH856?=
 =?us-ascii?Q?gCax9S731I6b2eInIFsIoflV9XYcG8nEH2DKY7ty7jUMdb4Cf/c6PBAnEC5x?=
 =?us-ascii?Q?kNeLD+7AwJBp6daja1jmCFp931W0wh86vzwf66r9D0E3LZBVfLULE+Gp7g9L?=
 =?us-ascii?Q?T5hDmwQYC/8COlyT3RwIQUCraXBXvoLMD0S6rFIdsQxBox1ZEzTV8pEpivWm?=
 =?us-ascii?Q?u+yUMsv/Akw2buxZap398q6dmiQZFcNGh6A6Zf1eFkcWVstp+LuSqqhf5KWI?=
 =?us-ascii?Q?kwZHPOaUvuB9uxI0VLzLEoArryUT85E58C4pHDHaf5Ipkkj0gUyGCeawf487?=
 =?us-ascii?Q?0FRcR+3m9PTsszeGQwSGe/cl/M7gDKOyHU8Cr9dai4nOHrOK2RbCohRL+Jyc?=
 =?us-ascii?Q?noHs9FTOb9WnqREtQylai2EW6cvCk2KlJyZBSI2c7f6NJ7iQBstgz53w+/Cd?=
 =?us-ascii?Q?g5ZT7DW/MCADuxAfpLXygcl9n/Wiu1ykciQ7dbBIaa1lNnoAlSY/K8gkjw4x?=
 =?us-ascii?Q?Z0qat3OVI1Yfax8daYWBekUhake1FiZNXvOX6D1cXl7RFxEfnm3eWJ0iAjB2?=
 =?us-ascii?Q?H65S54tKJFsNeSZZd4sLQLqLal1MXFSOtVl6fjuLoYIGieyY37dyGBb7QrYa?=
 =?us-ascii?Q?qhOI+d/q3ma7Vr39FG/QXgF65Afz4yBAVKGG2vzQ43G3IRxbn1jKXWj22ORW?=
 =?us-ascii?Q?6EOOoxJCOK5aVqh2gnyVkybb9bHdnkBlNqN2eyHuLu4NXuwHl1oa8IIKWRTD?=
 =?us-ascii?Q?3PHLgVEo1OkFJbrDQMZKHfcdCHZOzMrJVmmFzxupsvtU6NdVXcDNYYgqjN2z?=
 =?us-ascii?Q?YNo1jkevJ+j8boSVIiJCEiQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df30f074-88a4-4351-c67f-08d9c127d19e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:38:21.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YebF1iJtiyJD/kmUIKgAXRrovMnA8YIheP5qXiD6o+HWi5+fAZEE8Zk3j9uYgaDWtLHhBGAAIkm6Kd0B0kHmnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2444

Two cleanup patches for the data checksum.

Geliang Tang (2):
  mptcp: change the parameter of __mptcp_make_csum
  mptcp: reuse __mptcp_make_csum in validate_data_csum

 net/mptcp/options.c  |  8 ++++----
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 15 ++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)

--=20
2.31.1

