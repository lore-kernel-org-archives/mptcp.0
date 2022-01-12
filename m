Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0162CA7
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641980047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhGQb7Y7WD3WS3IYirUqTQjx1TvyqzeALFQoEqvxDQY=;
	b=dgDaEWrVFdPV4UhV2Qu3PnUcVuhPlnU9dAuZhyZ5lgX6SmnbpIfQrSDj8MXUXtgWoTOroY
	kH1pGEfg3zRN2p9fvjr0kjD981wJ3J7FQdaKpy2/Fp/bjscSY4k84Z7LPQw2OFC+9ERtPP
	U/TgpVivzJ5EbWClhbwRxxt/7FoYQ4s=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-SvX8gN_dNK6h2RYrnIThig-1; Wed, 12 Jan 2022 10:34:06 +0100
X-MC-Unique: SvX8gN_dNK6h2RYrnIThig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmxHirthxXgqAG1+U7GctMhc4sshaMFSHsgr9rGDe9sUD3I+YXLD6HTHh+M9b8Z+9HqlE3Y63xTirbUnR9UAUKjI24oH8jQYlCk0KfVpbpDMBwc6cOVqTB+HC8j5TA5QVOKT8ZF74/4lJhJtJ3PeTgQ3pPeOfp4bfHF4C9RXk0seOkrQlykYX0Kfdiss0avWFV+ACjd0PAPWn3Nzg8Ct+hfxCOWaKErqOF6NPOd6lMtPaNsonlIA5ycq7A/wHbTKUNNHue6T4/2nhX38AltlBaMRaE3h9zODJfn7utVDLELzhWVyht67L4hTaBlZwHMZFyJSoCMl2ZSJ678vNrd5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeOr+1THhDxx+Xo7b/ObILYl3AFL2NPHTNXoISUBRTY=;
 b=TZ1GMNzzsl3EHA7rSA2kevLIYoZ+mu+wO/kzUpIqJ9HZUmW/O9ChTCWsQQplUJUG6Fewx5B0MxEPOWlHEfM7NaoW+haIOsRdgiuF35PDKuu5Cdb0DltGvf2SwrDBmB0vIdabMk2a4PAxcQNwMWJn/3WE2tv1PR7KY6j7+nLlazmrAuQg/8CgQ0YW8h/fo+cMKBqFu15Rz222C7Be2xUoyEeEvGuSu8RYQX52hDYewknmuk2HXfRKkyKpmAb142ZW6yu+MkhHdVejr9QWRPa4lG5TplbvchFgAPJOBuw30896CUMdk8dBgn6UtyOWRm2PWGo94O2PWrg+JJrkHxElkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 09:34:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 09:34:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/4] mptcp: set fullmesh flag in pm_netlink
Date: Wed, 12 Jan 2022 17:33:49 +0800
Message-ID: <d51b8fd1d4d8171369d5105b708a02d787fcc9a7.1641978967.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641978967.git.geliang.tang@suse.com>
References: <cover.1641978967.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f27617e7-7f70-46f3-9cfe-08d9d5aeacee
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB429044C7443DAE565E14E329F8529@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C5ktrls6lc6JsgmnDwf78cpKkiwaag2N3A/JBVhSbvG8woopxHF278nQTctMG91zHVFQjfxNH6zdgkVD5e0l48wKNduYPwfiOuQEy+6f3XG3Ar+eLJWYYcbu+iE6u+6zS6p9+oIOe92L0ZEO2b3+/tswNqJ4H8R7+sWicma41QaxhzPqk9t3cXHdhPSSO2OmZWU1G17xDRrrLEvSy+MZom74Qe23wOavbqpbF27sowhRgU0ncRJ33dvKbxr7XHZERzLpjqqN9Jvbw5UKelyIAe8V1dhYmDT6p3xEEd/39nSfHj4UZ+/sILIoGn0QLhpG4tR6ba0/zMnq9LHoYxA1xMmlI31dbBPiMIs4Jn5gqI107Q19X9UAuL+lepQkb70TuY15EpOj6+fa04UgEgmQnWqAgN51vVVSgTG6HIlaVfjMhQgv+4af0JF1m0eJUKfbIHXw3X4XWG6HoloC3U+37iRol5hJ7aDAYPiajPRcpYjCgLEA5heerZVj2+AscL3VKzj9RgzXJNiRETpzBAcTYXSkJRlDfhdvmCd5ok21si2hu2oDMHrG2UWMVbyybtKalcZ49Z9wfA75O/rpCDljyUqNSD/5i5l1aUiwt08DkD9lG5LH96SPF3iwqxIVA1nCll4s3qHxZA2o67GPOPvoHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(6506007)(6916009)(6486002)(26005)(4326008)(83380400001)(186003)(316002)(8676002)(38100700002)(66946007)(86362001)(5660300002)(508600001)(6512007)(8936002)(6666004)(2906002)(44832011)(66556008)(66476007)(2616005)(107886003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qc8RIwAzKYdNSNdC/kqVkyq5YDCR0YWuNDzLsrXRQKAw/TbiO5ru2Z68p3is?=
 =?us-ascii?Q?B2yCQRiz23lXjv3PmplWSDXZrLRAlItpvYZ+WFQkgyIfiH4eCZNyLSfOKMJy?=
 =?us-ascii?Q?jHdZeZvA9cuFvZ30DKubN5losGYHD/tXWkvy5zETuAb6U10KBWaK2YaL1eTt?=
 =?us-ascii?Q?xqM9g0cV/MhLTpaa8lT3pEvMpq/J0cVTk96VSghwFfc3VJuKqLPIVzkssQyQ?=
 =?us-ascii?Q?4zbUub+fL+zIdSDI+1UIbdMxa/I8ULNZbPbJ75HM7ThMmK9zT/wmxJPJVTSR?=
 =?us-ascii?Q?XolXtYC18nRAl3i5LcvXFDjdF50c4h2Grc8XerNk7K1JzoXCT9hAHbME5roc?=
 =?us-ascii?Q?ujDMYy2APPld5pAFTwoI9U8rx6bgahUCMZfvVx8q8uAtlJozsmlnWhn9m6oQ?=
 =?us-ascii?Q?NCJbiBjPD5ORLwQGyIQowIYW5tKDvnvhsV5cj3Wcw8EDwzAVvegRRDedz01Q?=
 =?us-ascii?Q?qjeek3TNY6j+Z6hThO3kChKNNUXaFZKlfn+nzj1BMAyIFiDueEcBlYYcz/2d?=
 =?us-ascii?Q?46scUrcYwqym5M7CJBADcAb7rGu9ppSVMoaWiztlSaSsIZf3bfsaTJQa6S5d?=
 =?us-ascii?Q?pYc1lS3Sk9E5gbbS5cg9QX6QEF3hAZyc+kics78I1hmlFspIeNzCIH5+JSUg?=
 =?us-ascii?Q?hQcaQRyJqo/qFGe2YbGdsf4AQxrwcxWXkaNhGa4pATRB9QuFR83KHAziwkS/?=
 =?us-ascii?Q?XxNc6aU8mGiu47GBrBV2+h92SP7EQBuFOe71XS4ESgu6570L3MT2XdDnC5Nz?=
 =?us-ascii?Q?h4aObkeIgGWPbDLqsdGoN3eZDwD36gSvzER+TSzxFckZwrSX1iA9uHMQcyEX?=
 =?us-ascii?Q?J8OAnvOWOUu/Lc/ixeCrtV8AnEE4f0f9OppuOU/jYHEfrYOrCkvaGQ8Pquo2?=
 =?us-ascii?Q?a+nvYRGSwaYp4LEaPYgfQ+eLPMP14S7iC+upwZA/DaoGW7OkzOf+nzMtnnEH?=
 =?us-ascii?Q?Hj8z8G32iAFlvlJwNSVXb41XCnTMqNwC9AsV+SEihZu7l8qRguc0GqcbhSdt?=
 =?us-ascii?Q?lRNHcWvjKOk5Q+/ObJ+gaVLHE6jvmdCtISXRRhqFu6X6sNSPeXklHEWEcVYS?=
 =?us-ascii?Q?N9JiTIEpGDqrGPY0TLL/YTA72Is8crxgu8P/FQfSN8S0KeqFkcv0syIzX30b?=
 =?us-ascii?Q?Pv53AfLx6TM5Ya0Y2jBN03Dbp4DVzCEMFYaZKYh4OFRDM3VFuxypXpuUdnv6?=
 =?us-ascii?Q?mFSfDhJz3QYfhEjhcTqH3CHPrK9yTc7zb+dMcERAlX0KPPY0BHBwJqtfsBDI?=
 =?us-ascii?Q?miMWNMl4Ht9eLVT3Hl/ptqY114yOpXg2c4HV2hYfuNPaB69i6KzykHB93nkf?=
 =?us-ascii?Q?6jFsviMEQ5dOFY772JgT5KsPHOKQ8CMkfljSc/4E703zCGi2bz+TISnTse+M?=
 =?us-ascii?Q?zFKn470MUtkg/O/ewKLLOwTFVkhMIX+gYgPX+Tty4A2aWh30yl8O89jZaUk9?=
 =?us-ascii?Q?So3PJA8nqfJUWN4ww4Z/sIDXRTJorwrmWXQvy8WHb4kAtS+zsFG5+1c7D94+?=
 =?us-ascii?Q?VszV7yLNNovtx0ogWNQnThiSlBwWsP26O1UGIx2CtFwRaSnCfcnuiFsv7yi5?=
 =?us-ascii?Q?Q/o53dXFeKP5bfJ+i3H79j2TDLOCq3p9krGovURMNhDOH1LSR+/rfiYielkd?=
 =?us-ascii?Q?TMX9nIAXf7ZyZQUSETplLeA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27617e7-7f70-46f3-9cfe-08d9d5aeacee
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 09:34:05.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8dlT3usnojAVY7WZKlhpPfuNwnLhMczrCDClAUirwh0B0I++TA8PGGoeJ1vHHqBEGPWdye1ASjgsQZwogkOLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290

This patch added the fullmesh flag setting support in pm_netlink.

If the fullmesh flag of the address is changed, remove all the related
subflows, update the fullmesh flag and create subflows again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4c06cd6381ef..8c5a4be21e3d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1722,9 +1722,19 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct =
genl_info *info)
 	return -EMSGSIZE;
 }
=20
-static int mptcp_nl_addr_backup(struct net *net,
-				struct mptcp_addr_info *addr,
-				u8 bkup)
+static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list =3D { .nr =3D 0 };
+
+	list.ids[list.nr++] =3D addr->id;
+
+	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+}
+
+static int mptcp_nl_set_flags(struct net *net,
+			      struct mptcp_pm_addr_entry *entry)
 {
 	long s_slot =3D 0, s_num =3D 0;
 	struct mptcp_sock *msk;
@@ -1738,7 +1748,10 @@ static int mptcp_nl_addr_backup(struct net *net,
=20
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
-		ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr,
+						   entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+			mptcp_pm_nl_fullmesh(msk, &entry->addr);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
=20
@@ -1756,15 +1769,13 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct net *net =3D sock_net(skb->sk);
-	u8 bkup =3D 0, lookup_by_id =3D 0;
+	u8 lookup_by_id =3D 0;
 	int ret;
=20
 	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
=20
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup =3D 1;
 	if (addr.addr.family =3D=3D AF_UNSPEC) {
 		lookup_by_id =3D 1;
 		if (!addr.addr.id)
@@ -1778,14 +1789,20 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *s=
kb, struct genl_info *info)
 		return -EINVAL;
 	}
=20
-	if (bkup)
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
 	else
 		entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
+		entry->flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+	else
+		entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_FULLMESH;
+
 	addr =3D *entry;
 	spin_unlock_bh(&pernet->lock);
=20
-	mptcp_nl_addr_backup(net, &addr.addr, bkup);
+	mptcp_nl_set_flags(net, &addr);
 	return 0;
 }
=20
--=20
2.31.1

