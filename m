Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED92CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Edt1p9KSDoya75M6IGXtjEKGXl8SOfJIAkR/V+wo6XU=;
	b=VHeSo5uvzaNNA+MO9nkP+SXnaGwZ77nvSFpZx1+AHlOjr5+livgQpgCQgOYve+8dmrMpvp
	7EH2K/BVgHv6DbEBDsU0l+n91ebswGUAl3LBjQsWBbBGEmQKS5URF7r8rifdJIyRWIhNpG
	yjphj8hFK60Zknoi8OTKy9pXohqSZ4I=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-4jnrB83mNB2lUHhWUjErjg-1; Sun, 16 Jan 2022 09:18:31 +0100
X-MC-Unique: 4jnrB83mNB2lUHhWUjErjg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOtBmedCr+rkuiayGI3edzDbLJjpwbGHwgh2nFYfHPXFI/gu7nE6ej9bv9LXDrD7r879XuFjm7ur2aWfr0CIxH4mbK+L9aaS8OFxwRbyI6yh4R5OBOsuNA4FkHqtNoSmsvRl+pW/35Enw++0bJD+s69wIYgrp3LTwPqkd6HcVjgbTrpPxYIKGn5pEH+GAXuAWkidXhPMI3xoMJerEmL44loCURUaylC6zYsN2wolVaXo39/AA4AxDSMjAA/GvOd95bbJXLbeshnO5zuC3XwRnheUuahaievAfjKtLOkdj3CbsT91wgy6n8EX66HeR1e4xeLaODxv3IAT8+NTuk+7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2ju45BwrOeaW84wTo2BgVqr4hubXPkYYwiKW/v1dwo=;
 b=huL425ydp9nrA31XUZLh4agsRJCCbgwMuT/DVnxObH8RALiH2M81rtjR+03FPbXZpl7nxLy9sV6SstTdrfUcwpMQBzqsLVoZUVFwCwD1hlFtJCTHZ5bOrE6xsq74p2mTr82RArGo+gwONl7N15Vh6zPbU3N8cOdIv1j2Eq+nivIHEX3dT9SPlPNaqMW6fp97yzwc5RkQm/Bl2AoeedhZ1TL1J3bCIg2JqyIaRvWMfP/+pPkUyFdM1kT31LGvZmdvCylkvp/nTOE94KL2wGOjMIFNfX48sh+0hdvshmLJn3qfYZf92C7Ry++G3RvBEjm2R8tXqO9Q6KNQhOlnSS6Ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 08:18:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 05/10] selftests: mptcp: add the port argument for set_flags
Date: Sun, 16 Jan 2022 16:17:35 +0800
Message-ID: <850e0c7ac121aa9392de828a326c70ac87df953c.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86cbe13d-b0b2-4e39-e6c4-08d9d8c8c78e
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB747224EA9D844CC50095ACCFF8569@VE1PR04MB7472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/+2m9Z1/HPehEy/1MZt11y7J7e2HVPzXiXgXMprlvFzI6Cx5ReHcNO6TDrTN0u1SZVw3hLv6S89FeLTB3ounP07aC/cAqZQ0i8yc6WZvEqK7Ws57/B4BglbWNqvmLZ+NaL83eNbHMW43VbwM+dn0zmwnB2enuidNVL/sB1aVFIVOo6Csn8C9vBX925sEwYBl+SLEy/z5tk0mqKbwCZw/MS9ZEKGfKzfAcCDKJHSz1975fpcoOvY140I94YZKhfyBMYlpLoIOGasF3VlPEiqUA0bQ/lI8+vkFQQvboA5j3OkwkRTroVDSZfcY9dFid6pPYXLH3JLmjIq+zkskI7dfKaDG9YJFXz9ByrOOrbUeOSGWKIhx1hCGD2Ejv3zav+VUmNy4CjKVawRVBfuy8OS2JPafvfYz5IPjtyUZFvE0tIdCHk3wGjKya0x5yXvQWNReugINWKaXnsmTvelOU8rH0xckWtChknFNjzBEWDFXMr82hrBwi6Jyp246v9oh7E8UFX+fchRW+bBpZCbCjZJoAQbuVPs6RRupWiRL7e25isakiNCNdIFMxtrqp9ljw+HYLfokCPVl6wD8jWrQMb24Wj1UXkW+uDZcnEJi7u3PJmee7myev+NMfLnq7r9nHT+u8OI3PoZYeBv7L8Sxjqh6AjkzXhhdET5kPqBzZ8Id4bvO3nrjgItX4N1s21uC6hnP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(107886003)(38100700002)(2616005)(44832011)(6512007)(316002)(186003)(508600001)(66946007)(6916009)(66476007)(4326008)(6486002)(36756003)(83380400001)(8936002)(2906002)(86362001)(26005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GyJj5k3zF+6urDmYoy4iTLRAioeQ0e6ZGQ02+UZXLM6W1W8BPPe+Zr6Wo1Vc?=
 =?us-ascii?Q?XgeJFpbevOlWX5d8gYVGgUmfpjdS5+MCcitglC8K7orAEiWIg9KaMu2M4SUm?=
 =?us-ascii?Q?9ZaHXJW19uLUNrUkd5qc2vd2skmeHu4NKEfB83DD3CZ6iCcCx73XnoCHRbLw?=
 =?us-ascii?Q?w/gtKlbFCbEu/Y5a2UXd6tWccwYvQiAP/0pRGLOTUUxbzGglQ01XFrXlDAbo?=
 =?us-ascii?Q?hsJyhznl5nR0I/Rnn6qmLA4lKQcwKLH7MdNBAJPg+Urq+LbpGrKcQgcPd9aY?=
 =?us-ascii?Q?l36df6yn/K7J/vFnyEFcjuWY3JKSduihhNQ0F62Ca489gLPZwf6k9lf6nkuS?=
 =?us-ascii?Q?0PU5uYJpDVbt9Lmjd/tUTe07JwSg85+7EnXGljHzPcuTBcxDLGXNOQxdr4Us?=
 =?us-ascii?Q?x8uuahm6ndi8clMkrkI+Wv9ArGyORrKnu4L8yfPrjcc/sT6oJZCmPJMwjkkh?=
 =?us-ascii?Q?8MMvkVK8j6lFCUj8Xbtffpj/a5uoSqkzJstAF792BauMmX6q8CvwUVQIxnTl?=
 =?us-ascii?Q?E+fndNPiQ4RrbumepYxgcFZsca6ErP3LVTsnV1wfj7wVcL3i7jprRfdC7lY/?=
 =?us-ascii?Q?esewQlmKIhksYhy2eAGN7Y3pULZ4xTKR4pCTAAkqSyAzeqaFM9oQOrQeGB2j?=
 =?us-ascii?Q?YD1iMcCD2tqyxH1e3YuM314nBtN5N0jjNsyMXMvQxOerG66nt1vsydK5FUJf?=
 =?us-ascii?Q?BNFpC2RwkXEQJjd2L+0nb/47aKVLbVpPQSn5IMKT4khWJCc1qH5EYTnekOcQ?=
 =?us-ascii?Q?x/SAp1SDzAE+OjHTGzmgMdPG70V3+Z6+DDEvC9B3PD8MLS1xkoVONHNrkCYt?=
 =?us-ascii?Q?ACAPA6s6fWB/p3biCkK43/p9m78YIOXhJNSKDV1WJjuYlNxGka0ZVH6BGU9F?=
 =?us-ascii?Q?qekZnh26sa4NbabRrkp6FC2/yqpRmFesVKaT4il79QxpPc/y5ELMvm3dSlT3?=
 =?us-ascii?Q?7iUypVhZePdjfI1/40CxG2Bn9Peu6r2+YUptPTwvsXZOxhSl7dtDRyeMIvkt?=
 =?us-ascii?Q?awbgey8GUh1Iob4aZnX/EhJRzRJixjy11V4Zt4t8khVOTARhuhaB4sEQZzzK?=
 =?us-ascii?Q?wW4Je/2b+WNWeraRewcWJLSF7B9lahGlmt1CcDL4xdq6WawQAqNnCwEPJbCA?=
 =?us-ascii?Q?J8bBe4H4cMQPOcqzTBhjHDF8mx5NK4B8y+vPm2wX3aDfQV5kfk6bZzFUUvsh?=
 =?us-ascii?Q?0IybiZ1uc3Y5dCIS3vr70M+54QO26W2eJAPgYwToTmRn1+EGYL8eMPcBiiRN?=
 =?us-ascii?Q?atU0FdsliPVNMLPH7lDS6EOHBv6erPWWBSxAXW0bpDOaW49u4dViK9WssMVE?=
 =?us-ascii?Q?aa4j0tOMh/X7sXWs+xpbaEn+nxY6N1qCTwg4r06Vrc/nbcuEzz04u45FRq6n?=
 =?us-ascii?Q?jpqzAqHu2Y7UJ6fqgpHAFKnqOvseD8h9vU+u5eM/wMXqgNLIpIt0JzX03hJN?=
 =?us-ascii?Q?Pe6vTM8eA1xn/H/JCdoPW7jH0HEEyJn9nijQp7nkc7Ol80Pd0knFln0eotFF?=
 =?us-ascii?Q?T375PhUyvxPgqRutrUnbjXlACvhjo5qcD8x1fKyAeIXXRuzWY1kIU5TGumQL?=
 =?us-ascii?Q?vA7dhpOhfspQaxpmvOPh361Vx6aa4hQFzDRWBbn8HKRQTFS0Vo2EtlCckZqt?=
 =?us-ascii?Q?NJ+/YKb6cazu/dqJBlyY3ag=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cbe13d-b0b2-4e39-e6c4-08d9d8c8c78e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:30.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WxHYwekff14/K41jEkFVDseD4cKYg1uNok4c1bK2WClyEul8REmhSP0nP/sgGPdOziCujw1tWVNFygk+YpoWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

This patch added the port argument for setting the address flags in
pm_nl_ctl.

Usage:

    pm_nl_ctl set 10.0.2.1 flags backup port 10100

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 9b6db9d77223..3c449158d821 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh]\n=
");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh] [=
port <nr>]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -722,6 +722,18 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 			rta->rta_len =3D RTA_LENGTH(4);
 			memcpy(RTA_DATA(rta), &flags, 4);
 			off +=3D NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "port")) {
+			u_int16_t port;
+
+			if (++arg >=3D argc)
+				error(1, 0, " missing port value");
+
+			port =3D atoi(argv[arg]);
+			rta =3D (void *)(data + off);
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_PORT;
+			rta->rta_len =3D RTA_LENGTH(2);
+			memcpy(RTA_DATA(rta), &port, 2);
+			off +=3D NLMSG_ALIGN(rta->rta_len);
 		} else {
 			error(1, 0, "unknown keyword %s", argv[arg]);
 		}
--=20
2.31.1

