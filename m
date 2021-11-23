Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CF2C83
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 01:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1637630625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hgig0VKqIM/WHyVlA6FGYUFF1X9ZrmG0DZ1sz/tcnTk=;
	b=Tue3qXMh1qjBPlc+BFxKaXK3RuTT1Py7C6amHVenbySByMbWUBbcFapokqMt9+6TZpvT7h
	YLqG0NsvpbCkiDUU/FWEyENvpt+/4G+waiASkM2kgBCRbDqKJy/9taUyJlDkCgdXc6VCUr
	Tiqq1xIdlynFtiaTT6vI35ftxXrkSoU=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-hE2jjW9BPW2jiMM-YWRyCA-1; Tue, 23 Nov 2021 02:23:44 +0100
X-MC-Unique: hE2jjW9BPW2jiMM-YWRyCA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR472DuoV2oKo0yqi54iNjOfL8pp4crAOliaOH8RAVgrGSMNf105ChHyIJoSPMWbq+CiHWNrTD77wrtyfwPXIY8uvyIMdxqbor9tvwR68QQD1dHERRoLHoP9A3m7WALK3HLzB6hcIEBJKHDE16pQvGDeli2VB1F6fveQLWJXIHNnJa/EPcg9FY/Qx7nCkJ7kDIIOOILF6VCn+l/zXJy39A6Ir2EXsw1/dvxYAuvRVK3Oh4FrmdE3iy+UqakD7TqDZ3otZt+QkwOb+N5lrxDEgq3BBBYI51pf7T1DXE/f8/TbRw47HytlvHRiRH5Yp5GvuixmW1ww26mmsJDayeZiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1xZF1PzyRWxruwUEu3D4dFj3thaA2Ec9iU4+lJri/w=;
 b=fKPyQIjI/A6OpGBZ4nTxZX4OySun6a4QVmv+uKPpEE2nfRuLgtPYIOOm4pqLPsmzEGMFBt9a2yKexSgJIj+1jp36am5u5exMc/qNmY4FMsn/zJwmQNs2n/lGP8KRzkYG24xznbps/Zwu4IqxbT2cjiloJB5OVixoBbGCSoWC3+zuRJnIhebClbpLnV1I9pjyAPzB65kifkbV+1XjG+SRflENHfVnhC8uLBt+C/ZpXzl9vFQnM39lHnjHjGp+z+RBH2wCo/jHkexOAs0Ju2U/hxWX8WZoJ1Ru2Ly7zYk54DSB/URL9TlmUyIFLrEHxis3YmWspQN5TJptNGyh9G2OVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2891.eurprd04.prod.outlook.com (2603:10a6:3:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Tue, 23 Nov
 2021 01:23:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4d5a:e54e:9ad7:e79a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4d5a:e54e:9ad7:e79a%7]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 01:23:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/2] send MP_FAIL with MP_RST and others
Date: Tue, 23 Nov 2021 09:23:51 +0800
Message-ID: <cover.1637630218.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:254f:fa90:ffd7:b378:8b95:8f44) by SG2PR02CA0022.apcprd02.prod.outlook.com (2603:1096:3:17::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 01:23:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdfa18ff-4b8a-4ff8-a80b-08d9ae1fe2d0
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2891:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2891238FF0799725ACA38269F8609@HE1PR0402MB2891.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ur9x0t02ie3HV9YAvkiUH+6jGQ2x+SGz3zFbJkQKTJFpg2Pz4PutQ1qGMF61LyeevAFgZFi7695bxWP2Vi4Ysq4Cs/Ee64lLL/SE+MeNMAdj+vcBgxknXxcMeFxQGWHNzFEm+fHmb5u5kaCej4M+A2SscN9Ckpl5dVleQP8wblWu++fDOQgK5bNDl8WmhZWRREh3yMBXlTUDtdbXnfGPi5xAHJPnBJL3VywWC22Fd6eVmc85BWIMlncGz29Im1RmyilaxzK6jUTRyGe9kcNbazQ4k456Y8+eN8c4PI54IVRyXYvECQOenunTcXCIBd0/9jmuvAVp/5phVhm41eNtK6Cvs26/qW1GqTBNJnFnfCStZgEYaYsbkZxxfE3fDzlDN8BOqKyrw+ChNgUackHGhv7lIbnM1pOPw9cuFliXlLBAoZq0XVGNVHCecvOycYCYx9qaNkFB6jmeVF7TPLOTgavrBjP0SmvRdce7TTIb19wHGKzStWQ7y3pjv0TSoFASCVGDNlSCYmCtpgPG8zSB/gFJX9ek8mzkyHQiiwzB8X6h6F9EsTKvih2F3kbZf2c3AeVXCU3NkTW2pW7eq1JtpaxV6WR/BgAnb4M6D1umRLFUmTPql6F8Mgw/OceYI7ERODU/d7HPylQsr5NRvOdLrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6916009)(4326008)(66556008)(2906002)(66476007)(66946007)(44832011)(8936002)(38100700002)(6666004)(6496006)(107886003)(83380400001)(316002)(5660300002)(36756003)(8676002)(86362001)(2616005)(6486002)(186003)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?03jZu6tz5OTePuUvGJZdU1dZ2BYmmaUpam0qHDQ3K11hMgcLA7cW1kjc+s0j?=
 =?us-ascii?Q?CVSelaM9TFyXeQH68pFZNqkV8vx6N2edNJL6sSsIiLANq0wuVqm+ljdQz1/u?=
 =?us-ascii?Q?EOufgbOt0H/TgorelQeEKHKRqO9lMCVuDt3pLG5B26tQhvlyBR0LMe31Vi94?=
 =?us-ascii?Q?CSDnDA0ypVueQAyp1BmFKfFTS7i4V/o54vWMR07aDOZ5jK6f+Ari86NKnyjl?=
 =?us-ascii?Q?yKa3u3AYTnptUEKYgcoIAoBUGteOsqexvC77mhbbYuLl/DX/ET6tQrsrwMF3?=
 =?us-ascii?Q?DIqhZ37Xpyel9I9oWfI7fAFSI9MGuLhgIB0Vl58akFImMNT/W2+qTRdr4ROh?=
 =?us-ascii?Q?PtQ0vavQEbbEvM8Sz/SiAA59VMsmIfqQCPMVE4PsTjOnTw3R5QF4g8TXRahn?=
 =?us-ascii?Q?huJZbAw6lhPOd2GVnd0ILoxwxofSNJePQ2hjQjv2aDu4iAL20kt9JDzh9KiM?=
 =?us-ascii?Q?+5eU0CMd9Ni49uwuaxPjv1ZrDUJef60AeTh//v7NbeB4wgeTK6HB8fijlrzR?=
 =?us-ascii?Q?YbYz80mQqPA24w2ljf785ilEJuzwlIW3s5b83TSSJF3MJagt0DNzH5+MP1bO?=
 =?us-ascii?Q?aHNwSzGSt4pOKd3oLMtJBb4l9+CMfqeVcQvPXXaColtRuqcwWodlJ+o44jOq?=
 =?us-ascii?Q?rvUCW+6ZGdiu11jJdg3BnuFO3ZaFR1LtX+bevLoXYNgopZiDrFKwBwPbRrAK?=
 =?us-ascii?Q?E68TcTbUUzXwJlR+Q55l6bFtT+pxwLAgMG9S3r21KrbR2sKWaMfNA8vQu7WD?=
 =?us-ascii?Q?h5hLhnz8NxEfo3BMWRl2NK4RZLOdRq6Suelxxll1kbatidf7KlfgYzxcPxiE?=
 =?us-ascii?Q?iGsNVMsV8LXfnyLCOhBrpXDc9EvDou75etL0mpQ0w77BfM1ej9XYf6ltAwrU?=
 =?us-ascii?Q?wfnUG4vnFYzFoEVrgcityEnj+Xmyr6+0iIhE8GdHVEkZmGwITr/kvZEKv51t?=
 =?us-ascii?Q?lBo3d9/VAunSQQfabIUcNxXLpQjBBWO+SKMlDcgfLXKqKrntPLlcHtfUAJB2?=
 =?us-ascii?Q?sEGlW5VwPlq9dD59iVZvMUw3kAU5Z/iFdagi97cJqlT3K5ig+sgnTNjumlmp?=
 =?us-ascii?Q?j6fI5GQ8MMci3Sg/tsJvLQkWAwjJwfEtt2qkGo8mEKKUWJKcs6j1mr6cFP7N?=
 =?us-ascii?Q?iKqlcCu82e6+1s9Au2+ilTngfsywdydS2+8RmgMAa7w+xxkG+yHTbw+51pE6?=
 =?us-ascii?Q?1bifGCT3k/8tXbIIBqJymULiwtAT3yntZve695KKrsIHjR/jUNIzSEkPAFp+?=
 =?us-ascii?Q?W3YAj9nNKSZdVsQDx+FGK3WEOsheT1C17M/7wMxHB8n9iHxjDXV6c7jYtUSJ?=
 =?us-ascii?Q?fvxPBqEZ5EM/oOPYpUwYaPkz6Hsu9s0sqp102NCSqxCMBkf4GGrlPxHo9zfm?=
 =?us-ascii?Q?/1m04FAOa12TJvCSQCerwevPBKTxW9b6uyCm2GKZav6Sf9I5KiuZZWwbQI95?=
 =?us-ascii?Q?Nbre4N7Mjd0RJlMqOxAxIShG0ryZbSfsjO5/QBTuhAffg8qfbvUPtWaatKxp?=
 =?us-ascii?Q?T4+RwdYVZuX/8n3EtCUjYTKbPEJVoiJfAtbiEH+yiRW6JXdmNVynQPoqEqN2?=
 =?us-ascii?Q?OPlmlNcbEAf7TNUSmAJsyl1NKFGS9/9s1MzFTbdzDmb7En3QoXtI24cBKXqg?=
 =?us-ascii?Q?aQaoIAik122jJdjfT3pRPTSQd0hkCCNlWCpcae+cf5uzSwl4SplYL6chGgIz?=
 =?us-ascii?Q?1WMwPVFEEa4ovKENyWI6v1FRNkQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfa18ff-4b8a-4ff8-a80b-08d9ae1fe2d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 01:23:42.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVTi5RFSUcyw7h7WNkKBF+4hQ5IfDXju8Svej0gkArngWhtzL9jgSfuW4X60+1PZRH6r0dPX8kllNe5EUqyLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2891

Two small patches about sending MP_FAIL with MP_RST.

Geliang Tang (2):
  mptcp: send MP_FAIL with MP_RST
  mptcp: print out reset_reason of MP_RST

 net/mptcp/options.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--=20
2.26.2

