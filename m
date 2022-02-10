Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33929CA
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcCDJzHNV6kcFpm6QUQWBx6GY1KwXHjb2MCAhKpBMzI=;
	b=EXUWZyEtWvVniOF8r32H0EFku8l5T5Gmwa1B75OwnlNuPCjIDmCleIgUmx+oI54lxKTDUB
	WeyqklPCP3hGYYP2F/Jm9G1/h2cGOvyWt4VqW0ip4jmCp5KxzBdo7N5/wzqWIZq4gzhi7r
	vZu42jZTadjpJsz1zjxItS8ZvTYYnH0=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-b2aXqkryM7u8F0xh3m5eDQ-1; Thu, 10 Feb 2022 07:00:15 +0100
X-MC-Unique: b2aXqkryM7u8F0xh3m5eDQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPx/eLJLn16FMC5BJzit7Zf5EF89K0Ljt76KdKaEIgsZ9r/77KIvXXpZEogOKI3kpW2EiOQNjTjrWnkfD4jcdbxKxpImT9YPXJjTpHEc0yf+tOiJaefm1EE3zgAjt1MAzutPyr2eWkhzN+0qJsTWbx/qDYOucPuxPPzkKAADPAJO7wWszUrFJ7BQ21B5eF8mewGB11p5icMuSqMPf/xiLLKl/fH8bL0qYUgoApM3Z5AiPdzrEOvKwPcI439ZUlzXOFkoR5AxE50lW4UBN+I4Lv+ManktVP+G2yqYdOYgBnT2gAKJVQZY0cN6KItggUdaUwkj21HIRRdBzhCnbiATHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a26/8dAG+o98EF8E3cZi1/wwV7DYzSfMYnFb5dQLUqc=;
 b=BgFn/XzzaHi4vg1vOINWdFWY38dY3zW31OipZzBpJDf/4yLaGwPuQagkkgdn5ROsuEYRCe+7UA4qe3cj39JqeEqtiW5Hv7hwrMI05GwhM+mrZLQgqoHCMX4iUeeYdtfYo6LBQsjuPTVhZwAd+PiP6vA0dBtqgRmwRlWseDnlzYG7VQcmwPEj8Nl2knvqnbaLgrhQ6kbSddImZF10R451baBxlUeLEF3AYiGnB+ryPX0EZTMLbKaydlvSEouXRBiZ72IOySNnQK501JlTtR/8u28Q4IefLnvx2Ek8WdLQ5//tBlbepA6Q4xEKZnE1hDz8tJttwnfT84G4r/oGp4LV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:14 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 1/7] Squash to "mptcp: infinite mapping receiving"
Date: Thu, 10 Feb 2022 14:00:25 +0800
Message-ID: <621a0237b6c15001e3590b27358dbb854c2ab6e8.1644466571.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4fba3fc-e734-4566-5b5b-08d9ec5a9b4d
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB576100473D6F30A70D2790FFF82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xG3CNza7I6JFEGE8otQjPnchFesQOYN0/010LTxrNWBOvbz/Pp5F0AGjrfVc6wyJCiEMUu5E0auZNLs/RiYpmWEvWF4V2X8iYFzcYX2PHDFYmPEULF2v/UGnzHVOiti5eUAaAGlyPCU6z7/IEQ9wWicXqftP5NjIHtnQhUDyZUDWzkjEMRd6gC/mglO85TL5XSEW1x28Ia+gdsrRGZenWGFd9Q2hYOX3qOeBXwdCdIOIxAfwVVTLzFMW26KsLBqMufYM//H9aRnNmC4XHqnlml3J1oBQdb302hyy4PZoVaZNwL6U5FXHMsNPCfQO5tAmCNmrFRHhQ5OdfFLkb9DihfDwDAdtAhb1yowYj4kEHk6FEzXLmpAcmFcIddyIp3CKclkSfacalnW3XPJ55xbmSraPqs62bZXE9sXASG/mtFTLM0LdXI2ImNSgIQC9rZC9nNxq+0HW2mSHymY2fqXA3zzEQSEpJmqWt6MfLYWUZ0Hd1cYxjYDI0M/Ag0fdYiTBpWFFdaC3iGhBb3QvUjL85cWREuBkKn9ynOshX29J61JIJl4369b0ke4tPM7UMfgu/1icmC54cQsQq1UBkLpvc+UL3+yIEl39a95VNXQb1huxWb+iRs3C2fzI4CClgf2XGGtLaciwVwlkW9rZyy9aUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(66476007)(66556008)(6506007)(8936002)(6666004)(8676002)(44832011)(4326008)(2906002)(508600001)(4744005)(2616005)(26005)(5660300002)(38100700002)(6486002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8QVkh7zG8K2lENKfKnhaOU3K4NmpRJQW0FZrkJjgnfySZXZI/wMS5MqSvpR?=
 =?us-ascii?Q?5qPUAye2mwFi2L3eySeqW3z5xva3MHoLuV68g/kFeTDUMqkw3gLkpimqoCvD?=
 =?us-ascii?Q?ueZ1GDpmKfRy4dABBFqj7/Paj1DXtWTYKI6HVj/kVtydHHPzD+KVlpq86QTF?=
 =?us-ascii?Q?tTjGnK+oWhx9SegFGuytxX0YipPQcc7UusJx8zZ4rxtP5dQGImd03A63Yzki?=
 =?us-ascii?Q?VdpwoOmmbW6AH0B7a2b4eTHHTUWxCKfdEiqWMKR7OozMLvaGrAlhgQygDgKO?=
 =?us-ascii?Q?BtqWnHd7V+boWO60hoYmlJvSjM2TrHx70h2eafYIM3taCLQDqGo+/KY3clZc?=
 =?us-ascii?Q?JpY6zI7EPGI58NGbp96zf0dLyQXhuq3ZUejpKt1HIbdZmHYj9o5gD9kutrzZ?=
 =?us-ascii?Q?8E/89AH34OueQppE23y9ocFumd5gT8M87R0zsx4isAUjytIlRiGkrBb9WRn4?=
 =?us-ascii?Q?dHYiZN1kS67fJ0mQjp+dl4+Xe8y2VvDMjC4bPXbN3fNfe5lIFKVHlB/OqOGI?=
 =?us-ascii?Q?TO9cATHpAhYjITKzz0+r82SAdfF5vlzGsyE5TeyqnbhBDndo7hB4j7qPXp75?=
 =?us-ascii?Q?RmwX9mLYlE1WN1xC1OsKT4bGawhEb+kzuw/KdstaGFB+KnCfXKoh1hjggoi5?=
 =?us-ascii?Q?FMG13qnMWejORHufKIo5OlxyKUcDmrq6NOmNHJ5vXnPN016ClV3WIrBSIPxr?=
 =?us-ascii?Q?68VodiNVcrRTKmrnW063u+ssdl7odHlNGJzes2UIjw3/wAaBdQAJXpmcYeMT?=
 =?us-ascii?Q?QakY1NZkhyDA1Qz210qk7dFm4fCbKJDgrC/2DAOgnpZ3miPaWhc+utw3sqyT?=
 =?us-ascii?Q?dhHAyT6qZbXZmlb7gRBe5FPhQ1N4KUkrO3RO/sMImUMrRhz+PHPrlRv1us1S?=
 =?us-ascii?Q?UPLoOKK/LfM/1smL4pc+pPHvWTvxXsi3mV4zGFp/BwfI6canpPMy3iuClMr9?=
 =?us-ascii?Q?nxjnqfEiY7ZsMako0IVHObNm5YVWoJp45A5T2+aGoFyG4qZmFA3eOOzZUz1Z?=
 =?us-ascii?Q?D4gelX4JBfZrX4AgTlCHtF+bhKVALCB+2bpzFFcb23JuTY8b/B5YO/XrdMSY?=
 =?us-ascii?Q?YF/nmhDav5XBsTl8/ta5wQjW+BRa11w2PYdzFXxoxhiW0GL8vHxh9yQ5+N1x?=
 =?us-ascii?Q?SRqpORq/eHwxmumbeCIrOUO6RvPQGkWzmumHpRKhRTYYbxDSsJfnBKrwPzl5?=
 =?us-ascii?Q?J+oNs9BuFNdsbE1A7aXJp/6eAod4yH8aC+Qdddy+AjhtEYpxuDDCiQCBCkEI?=
 =?us-ascii?Q?ffrdakdqIZSngFw9SJuZRwWTJZm9Wa4nZJ7EUEWX+wyBdGgnI3CzVFzZvEuy?=
 =?us-ascii?Q?d+2FUIqg1TGjxaEY1B7fke3shkk+qQrv9y7cBigWU1ONtJwesi5vzQ9BnpVP?=
 =?us-ascii?Q?wlRiipUw2MJhFE+JMDGj66DaUb15/dQM7Z6hRRDLT7wJdHwAo3Q8fHPg89t8?=
 =?us-ascii?Q?halwDKuEpJ0TVnvmxwcQiByNDcDrlksMiZN6UJq/fRvtJmXCWCOk7RggLooD?=
 =?us-ascii?Q?saa6hLlLAvphIZVAUyAFWgvbi2z1kQuACGmHhd/6bnbX7dcFKtLCc/MO1ZXz?=
 =?us-ascii?Q?ZDOATx1xGU8C8jXFefu9XNNPgsfvsGInjAYW3fumGMn7i5Gs2y/ZUyVUQrdm?=
 =?us-ascii?Q?f6YV65nxDacNKiBaRypuBJY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fba3fc-e734-4566-5b5b-08d9ec5a9b4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:14.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPr+xqBZBcneepZ4Ndku9xazad6ni0FnpVDFAzk0HZHfAFybLR7ulw5ABA/V9a4wvD7haKZVo3UB2uSEI4Q1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

Print out the infinite map received info.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 485f00dcaf84..ae4d855f3c2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -962,6 +962,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk,
=20
 	data_len =3D mpext->data_len;
 	if (data_len =3D=3D 0) {
+		pr_debug("infinite mapping received");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		subflow->map_data_len =3D 0;
 		return MAPPING_INVALID;
--=20
2.34.1

