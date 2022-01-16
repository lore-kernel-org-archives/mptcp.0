Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C152CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjhzF5PoEJuwwWAa22cnMbzTBhyfzDBP4zMPxwH47Yc=;
	b=GG+KBysasxeqyYEsICijGbkSyemsXW6N3yLSkczArfhlu0q5wXHVjjWbZLE3AFE0g8nqMS
	tQqZxeqqUCGpR0NGVLjtUuK82gY2mXGdqigeYru21t33A6FRZe55sg79OZgaZthQJP6J8R
	hpy3bf0OoT4e1yRpbO/Mqb07rjJzE7Q=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-3PRIekFmPDKRDSl-JmDNDA-1; Sun, 16 Jan 2022 09:18:11 +0100
X-MC-Unique: 3PRIekFmPDKRDSl-JmDNDA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg5hmTuhl/1wkrMwRIJP0D3SjLYrEoROK07uEhcj49uNRdDHuY4csjJUDOTvB6apu3rXOYXmpyofinNuf1imSfwS0JV4K2QNmLqf0mJAo9qMbw6LWxXgaRyIqp2k6ZfNfIdabdaaerLRAjw5jqDRfLE/+CfoSimrL4p+FXDfd13gxBSu2FkUD1sKk6ajf66n1B8k/UgWE1n/zBywrOja6sk5/enZHHAuJIM/Q3guuLHSm7Neex614kneb7hBSuwwHEA4rtCEh/EnTZKj9myjSeUhWcDekN6fCgSO78HVjrVI4/5Tf4sG2ZZK1Nibm+Xrk/QtS/Hb2sNUXcOno4r/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07GI3ftnUr37Z1HJrB3SsxT0T9Jz3pwnTguJIgU49KY=;
 b=aCzHbUos72wQq4kL7Cgj7HfgSPZdf4UiDlVAfCW4KhGtHQy/iWznN/ZtmP8WZVowXOxYXKXVWU70cU7yiAfFSogu13e+RCXk+eODvQ7vU4SCSfzbVbTmluxhqUoYP7A5AXP0gAEOuyUVsVunrHErmlHiuB8JexZolRFMtqTsek9LcHUZ1A3hGKoW1CAbhl+2F+SehUNvJ5JTXm7QI99YubIYyNA4inH1oJNBcJ6U+/LPd28ymOUPVsnk294NUa0VYdAucLh8SBM980qEd68om/3ahJ5U4JMaMQZZ/i0mSh9xsnFi+hrEQoWhijg3wbRCH/CguExpCUMQXTeB+481xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 08:18:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 02/10] selftests: mptcp: set fullmesh flag in pm_nl_ctl
Date: Sun, 16 Jan 2022 16:17:32 +0800
Message-ID: <75d2a81e0a35aaae416da2c2b3bca971598c7544.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0001.apcprd04.prod.outlook.com
 (2603:1096:202:2::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f830ca-77c1-4334-73db-08d9d8c8bbd5
X-MS-TrafficTypeDiagnostic: VE1PR04MB7472:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB7472E51997947BE3F4A9C902F8569@VE1PR04MB7472.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1m8uq9j9h/BpUnmWnqBnRNuZOV1xc+vx34kNwPdNwTwvZsAMewN7mRlVYeOOjS2lBqqZnXjWnqm6DfaUW680eKpQgM/kG+UWVonUhoxkfAMfY9EBpRwY9oCdlAzE82u1tYm9KL5q6X4GlTkP0LFyQ/k6KWJYwubJtsMLzY0A5dJ8I++qVXWyidQXB4blT6CtEkwP4SpYDjfeouEkaD5eWNnqnBgVkhVH8MH28ZKNqkMILHZzQGTBIZKLJ7qM+3jua90+UU6XZzwY0NAbJdqISK1ARL/6eo8XfjjolfFrcEIcvRET9SS5WjYFszF+VGJfMiLa9Lx/M5ptr4XzjlfKuwrSFUG3tCpwUQp+9c7uaKfLwUhZou3jywrEeNNaVA0KU0X8RG6ZtyqRmCVNnpSzekrOTMvt3Za4VZYQx+sQXFVzO7w1Y9GGuX9drw1EO/7GoTi0Yd4p084hCdnD6CxCVvgRBVVskNostpX7O9jdCO/JkdIuo4w8r7VmTaFmhmPO4d6ksqbLZASQJYefkDCR9/41TI69eAz6hkMOZ1E1l2+HJbUSSK75FBsgP0jHKGnjlNIeCqHRrspuunEYcHufCDkQYWn/2/ieqOtOP9MTfED5FN/DsE5APg4p8EyO39dNQeqjCPt96+T3WWcJjKx0jYAauWwsIQL+BuUYZJkKRaSttyWgbqwLWRMRk9AIDil3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(5660300002)(107886003)(6666004)(38100700002)(2616005)(44832011)(6512007)(316002)(186003)(508600001)(66946007)(6916009)(66476007)(4326008)(6486002)(36756003)(83380400001)(8936002)(2906002)(86362001)(26005)(6506007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fleWnur6KvAKvh9fEoCZQkhrhNtaL4cxcsv3EvrnNnRZDFqekBeUAIpB2Hpc?=
 =?us-ascii?Q?ngv79p5iUii5YEjWiLKLDNXZX3EuRcd2aPua03ot3dPb9n7a/xgNA893Brnu?=
 =?us-ascii?Q?fdFXJ8dW8MHg2n4leaIjbgTMpQfUqVgloAQZDd7l4quhxtj4fezx+ZQQejP/?=
 =?us-ascii?Q?jkyk1bw7mpGNLvb4TzPwQvg0F2ZYDO+podY7rFNOFNU9AQ1Q20UV+STWVlLP?=
 =?us-ascii?Q?7IUBMGpiQU38dB9uRaly1FxmdV+cZLshvDqpZgOJ6KpkTBT5aysMwdG+XR6W?=
 =?us-ascii?Q?DDFj84eglgrF6dwMINixTjUzfnBguBD3F0O4PzOUv7KAaFmA84SYI4Pr+NX+?=
 =?us-ascii?Q?t6NWW9TUofI3MhJDAUOSCnwDBZb+0n0ePHifVs21r2vSagjbsZLK8hfYLD1k?=
 =?us-ascii?Q?++0eMYy++ceANUc5Uot8kNTRPJeOw7qXksp46GZFZ0b2GWG0munc27ugmRlB?=
 =?us-ascii?Q?LvWMRBtUzF5yZ2WZOOUcUaD/acfPiRoA3XHqjoYn2EJrA3F2fWgJf5l9CSBH?=
 =?us-ascii?Q?no1hHNLmLJbjLL3N4JDrSgOwu+nlC6bVAb/h4qI+ZgmkR1uVVaAhvtZjHZY4?=
 =?us-ascii?Q?J1QaabFLsiINW5rEf0MFfq3sr0SXLwSqL8gG+wp44F2uOD3vs1cExK63/OYx?=
 =?us-ascii?Q?HgKadtmBGb6QQzJcm0dsHuYs0EFHFODVS35CBxaVvQTUglZ6LaGA0PaATgGs?=
 =?us-ascii?Q?lDU7hLEEBul2pK8InrwtoxYsWPflpBuVsILemLYA/gWJZW4UcCENQmsQghbd?=
 =?us-ascii?Q?FE2N+35V13wclXU9ePqh+jWxhHnGSJyzHADjGupJt9S+u4qcUq6Y+stghPjc?=
 =?us-ascii?Q?BFqY6EE3FL5vzLUhTSZKAPhki6AyKEctoNqKACwPQjsgb3ZmElmZs40kXG2U?=
 =?us-ascii?Q?LvbyUg9HscWCzjdftz69AvmtnheN5KTORpYhm5BnYsZMF7RbOUOxcVlw1e2O?=
 =?us-ascii?Q?PV718uSPsBmtCTMlImCtlNFwyNaPaTYvzc3lhJ7JpfXqKvhtUYkmUXYNx6F0?=
 =?us-ascii?Q?omjGPHJ4x0EYc5/rL/Cy51bZ+sTPvEZiNFkLyWSPIUQAL1eFjMgZ6XvFwiPt?=
 =?us-ascii?Q?OZieTIR+0QsiWROXK5EcKBtXo2KRR+8SmDI5BOVVZX3nTTsMxhI/PLloa4lg?=
 =?us-ascii?Q?z20Xk6wnZKOUW2oh1Zupf1vIKpUmxGqsEo5GhLita78bjJkjS/uBPPLijN5/?=
 =?us-ascii?Q?XorMFZ9ONeDlK5cfDipr7MhGc6LUFfyyqKukdgNEaW8DVsVB+OubzWlpgQ98?=
 =?us-ascii?Q?uRa/wmY8jQ7tJCnPUhYe44qKZFbo1mdF7GQGRYgMWcNntqcEM9sXhaO86OyV?=
 =?us-ascii?Q?V+pkJu5tnlcFCAy6Mj0nSDPqU1u5/qgdeTGpqBHqDMOo5u2FVSSkU1KwoXQa?=
 =?us-ascii?Q?CUce/QWYUUGZ1MceqoiEyKg+R+fEWk+y8o8PfWP1tz5/RrJgbAFkNNVNFCxn?=
 =?us-ascii?Q?BUhJO9YoeB0G/tP+hxoqsunVS/LtE4tQhVZPq26xBQw+x+zfGD1ez+iQcwmX?=
 =?us-ascii?Q?HglfnIQy/W8i3WlTGkbKDXvM4t8j88gN7wXSOtFPl4Ywk6K561KdLKtGBz5K?=
 =?us-ascii?Q?tHnZJTOv9UkQ18o4KxfdonlWVmscS63mOvYmt0MLsQDrWPXFxSIBW/ff6d3i?=
 =?us-ascii?Q?20izo2fS7BD3mwDB2unSaIE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f830ca-77c1-4334-73db-08d9d8c8bbd5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:10.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaB/B3hB8JNgcAcwI2cbmWtzb5SvCgveRK3auJnsdmwTTpAWllZyWKLbRSL0CpVu2+NFVu7Anr1s7a3SyFrJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

This patch added the fullmesh flag setting and clearing support in
pm_nl_ctl:

 # pm_nl_ctl set ip flags fullmesh
 # pm_nl_ctl set ip flags nofullmesh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..9b6db9d77223 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -28,7 +28,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [=
dev <name>] <ip>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
-	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup|fullmesh|nofullmesh]\n=
");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -709,7 +709,10 @@ int set_flags(int fd, int pm_family, int argc, char *a=
rgv[])
 			     str =3D NULL) {
 				if (!strcmp(tok, "backup"))
 					flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
-				else if (strcmp(tok, "nobackup"))
+				else if (!strcmp(tok, "fullmesh"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (strcmp(tok, "nobackup") &&
+					 strcmp(tok, "nofullmesh"))
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
 			}
--=20
2.31.1

