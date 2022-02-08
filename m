Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911702C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 11:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644318971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L5Ewp6ZZiD5cNEcDnKWRlQxPdxq/0rSQ+io+KNwA8PA=;
	b=RQVebMpgKKLKzg2Ix5T2ivC4S3WfFpX3Cp5FgB0M3Xzigs2rmW4P3k3LqdizI17UKNT1FH
	QqtYi+8vme4Sz/xmMmmj4TWLbUvIUgr8jZ2fjmcdSPfbZKsJCB43zM4sw62N/GH8sZQclm
	jbv06hco2ENdAONKrlniGs0qXQgceVY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-_Bwqkt1TNMqO2W7hShrSbw-1; Tue, 08 Feb 2022 12:16:10 +0100
X-MC-Unique: _Bwqkt1TNMqO2W7hShrSbw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUntC3T7oZGE297T9fo79ucIi+ii22mcN8HHDd57UlgkjLS1gV8HvpSo6dZhOxJ6HlRMVdGBN6RKgHkkSAJ0jJp4iG49DyvBde4l788+3U2n6oZ2cBvnJ/PlsPdCR5knCQIgdXT00Hyb3JtwaG6MdE4znmn2lm2Yd0AzBt9VctIzuyJ67IZuBGLiPU0TevNO4117LRbnLnEH391KlJAdxBv0kRmHQdpoOsR3x+nXHmRi/hjiBQPHmyWBomne+5vcdHgr3JEsJM70SGRWLp3p9GH1i1hmpKBo/8fLTeMqOpc2juLyYxpA9BKb+lZ8c54qlRNhzbcyYcsvp0zBaISVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HawHF8yYut7cIdSVey5YAOyP3f/AoI4gkODbNi+Vs0c=;
 b=fIWsSwwd6oXZs/3g3ug5grNIetDK04bhSL7eOy9hv0VqNrL7MhVVwmLylp3GTCcO06su8MTxkgw9tc1+bc6BWp+ula4LtEtJDJJ5ogdBQ4wfAuTPPmZXX/UZhXDbK19K1UNKqGn9c1zc38+9JEH7VF+tjartxmd0TYdH5KaYriWo/dr+efx+AZBHnNKvCab2jN38h6a3zldfRDd1j4WkRUyf9FYYhgafGdlABuGZvfqrmmpe3LNItDbmaZdQfPMjK4n/MsQGD7idf/S+DoJVWjeVAmWqoGaInMLkkJeXtbZOzBAQOlvRqa6AoFu0IVykzMSFo3wMQ9Hlm1AHfS94tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 11:16:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:16:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] reflect mptcp_pm_add_addr_signal
Date: Tue,  8 Feb 2022 19:16:04 +0800
Message-ID: <cover.1644318561.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0166.apcprd02.prod.outlook.com
 (2603:1096:201:1f::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c1b3a4-e91c-4993-1cd0-08d9eaf46823
X-MS-TrafficTypeDiagnostic: PAXPR04MB9005:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB9005F3946AD1B43CFE51472EF82D9@PAXPR04MB9005.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nZNLMGn53Ga1jogBx+ym6+6prUMqcKf+xSciWzXbs3CoEZW2hEGVOLkF0scpBu5js93TJqacT7jxHIYCkj0s9ZwKVVrU0qQc7eriJpLaBMv+UGbiQZUAjLuG1e/FslgEL1ydx0g8A8BI2UWkO9S/xCmCk7uW/TK04prcdFv8PFsH+S9ZNiokn9Yak0eSuednU/a6Sd5DqTOJW3D7Hwr0EPP9knxvIpmcffiggC+sVeuDoDffPUZ020dyDEqzqJuBqrGWe6zcshQ6/IQV5lLEv/MAS59rL88IlqR/p2CPqy4AEr5OOSj2E+w/QWILYHrt1artePJdUcSPRFBWTF1mlwj94jws0bM+2LbYi2kcgQ+v1HjW9fpEQ47DyF/MAUcmoGWJhnggscgtmQ9JvidkTcZKOKoSuOBsDdDLb6cNuKd+6/iPcAMl8kE/U0FS2q5+W+CHNBg3o6nz4Vb3iwBz3AGMi3hgvxUSbC2Lgm1zwT3MPE1vEfIBpDcqjxfeymu/KUvdKXyIzLkXfMR2P1nqs21h5gZjaQCiCtXBhS5F8HYMZWwKSlKHJ0gc6XHitIx7jeTVVCjOnQWrnxyE7gm0nSgYX67gvJQ9XyKqa2mokBwmMXy0ug2tFefAB+zbPut03K6QQlriOhOW2yOp3xARGNa8cg+GTQWh6MpWAPIK8e+GV1o7AGq397rGGaXd3Uleq5+QnMqPFw63BT9o4z78FkLnunnrRM2wEe3KKrk16so=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(55236004)(6666004)(66556008)(66946007)(508600001)(6506007)(6486002)(6916009)(66476007)(316002)(26005)(36756003)(8936002)(4326008)(83380400001)(8676002)(6512007)(2616005)(186003)(107886003)(5660300002)(38100700002)(2906002)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAS6MAF+QtajM8128/oefVIkkO6Hib3dBIXytI0yYkRBmL1Q5ku5fgcMthq4?=
 =?us-ascii?Q?4ASPEKFZBzxmDUHNqw71IS5To0FfveobUov9k34jn+0mhg+ZKgzVAeLyb5Di?=
 =?us-ascii?Q?2Mye0GPA4SeYp792Qr+3XBVLQGSHNPEAlb8osF3HWzIDzOKNxz1S2L6s0wkr?=
 =?us-ascii?Q?Xi+TeWiDjvKcacMmKognIq5YzBQ49tqtVkhWfPp6SuCzhiK1cdbLHpmZA27v?=
 =?us-ascii?Q?Vs0rFHmmzmWJqvJz9zkENRGiCSnWcgZyhzKIIx50QgYzmevwgmIpI7NVCwgk?=
 =?us-ascii?Q?Tu+iQbSz2EMyekAbdJZ/2c6BLjVNksCHWe5djKAnXnBktM3qOMz9rMKMG+WV?=
 =?us-ascii?Q?Y3jOMlQo5SB7tK+QH0hxm/xWTXKgRIXed7mN31LLgu5aRq8T/EiWKIQGfOJq?=
 =?us-ascii?Q?9VQkN2lbAAGCzIYKVl4XfF4D3euqcRp+EwkmlG0/vhWEKBqi1tRO3h4YrrUp?=
 =?us-ascii?Q?zH6Gf3/DeUk/7Pzwlsso4KIVn+VCrLl8jgKUG04ZpdCQTTE3/l45/C2rBsVr?=
 =?us-ascii?Q?nca8lwHyALFpkmJDZ76Ld/tagIxc5VsyE2o9cB/owdhqn2DGfNTzzTnCyffr?=
 =?us-ascii?Q?mIMAStJjNblkxz+reaUSsiArtovdwWZszgX2B7VeWl+WvNaARh/r/T/AQ2k1?=
 =?us-ascii?Q?azKjdCgUu4G3ABydvBfMN8By0KfYfaXMDemCEm+YCAico2HlODNGqLNnSWe4?=
 =?us-ascii?Q?9wvksG06zcPdyrk7IbxdS9gEdyIjbzt8tUdHtGzzbWfzD1ZoWwm+3rPEfa84?=
 =?us-ascii?Q?JLKXw65jimExvA5gO7A974FUPUsPG+gk9SDCOT/ptJwZ7zyoXk0yEZUZqUsP?=
 =?us-ascii?Q?8ui9PAot+Il7s9eLE9360tnZBGc1JvsABMjqmRP50CRCzU9qDqbB/S12WS5Y?=
 =?us-ascii?Q?kx4AO8HO3suEE+VZruqA1Y1ufj/nfLXwjHQ8URYn0uHbwmT4U8ZjMUbpJ4BY?=
 =?us-ascii?Q?N16c0Pqjpf1wSi3X6IerJ7oJoZyGayyXUdDC8leiwn6Vu3+CoFn63tP9CeUn?=
 =?us-ascii?Q?WJlNBQpY6CF1CX2KZP+xRYtA17dDJGCRk7yrU4lP1cRQQOWQK01+m1f8FMkp?=
 =?us-ascii?Q?zFq9qf7M2jl/q1dgBYVJru5OmfkArTy3+Px5cxz91OWnfoYQBo4ITyKQvEgY?=
 =?us-ascii?Q?nIWGWLHd84J9FNFauAbipD60CmgqlbHLbet6tshOh1H3oZwavfBdRcYth0hL?=
 =?us-ascii?Q?qaaFM+n9T6LQug0CLwad1Jx97U57QNzzaPGX9h1ohF7KqLPiMM9hZJHkcT8r?=
 =?us-ascii?Q?k4PkGEriTm/qRQHlFV5BciDve1/C2FlGSYQ4fQRJWhaqyyZ9ZlWwXD8UYaey?=
 =?us-ascii?Q?ROxz4ctyAwlaEFN9GYADMnLZlD9myxnJpNOUEM8QlJPwvf2Vj88v9D+FicKE?=
 =?us-ascii?Q?rPPEpeFqnDJQGbBNI4kzs7oEhlUur40sXDkYhyuI6QhnlgmrIwWBxIXnjaOU?=
 =?us-ascii?Q?4Ac0ZKf8cqQi5qZa3NIaCXOlNGmC2N+gYsNHDnOozYf97NinPvXuDdF1czYV?=
 =?us-ascii?Q?wwvCFeKv8JaCioKNe0kbC65tqKG81eIX4PP0UjvIH56Hwo+RgMl3i/CuZINq?=
 =?us-ascii?Q?hfBXRAK00v9NX1pJTqkJ7rLS1R1dbBcd3TpV2en7FySGUYMxyC2WZ1PHPFdc?=
 =?us-ascii?Q?D7VJRLYZTyyMjGQ6oGXETXg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c1b3a4-e91c-4993-1cd0-08d9eaf46823
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:16:09.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3ayivyF89CWoGDLcD/i/jl02Ey3JtESLt3VatnH9gHfspXhUGOrxtw6bmc5MFJ+xEgBXlpCsq+m1dsQs5zMyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005

mptcp_pm_add_addr_signal() has too many parameters right now. This issue
was introduced by me and I promised to fix it last year:

https://patchwork.kernel.org/project/mptcp/patch/f0920ba1126ff81aa1acbff47e=
805e5573c64abc.1626158123.git.geliangtang@gmail.com/

This patch set reflected this function and dropped the port and echo
parameters.

As defined in $3.4.1:
                       1                   2                   3
   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
  +---------------+---------------+-------+-------+---------------+
  |     Kind      |     Length    |Subtype|(rsv)|E|  Address ID   |
  +---------------+---------------+-------+-------+---------------+
  |           Address (IPv4: 4 octets / IPv6: 16 octets)          |
  +-------------------------------+-------------------------------+
  |   Port (2 octets, optional)   |                               |
  +-------------------------------+                               |
  |                Truncated HMAC (8 octets, if E=3D0)              |
  |                               +-------------------------------+
  |                               |
  +-------------------------------+

The echo bit is one of the important properties of a MPTCP address. It
makes sense to put it into struct mptcp_addr_info with others properties
like the address family, the id number and the port number too. So patch
2 added the echo bit in struct mptcp_addr_info. With this change, we can
drop the echo parameter of mptcp_pm_announce_addr too, or even drop the
addr_signal status MPTCP_ADD_ADDR_ECHO later (not finish yet).

Geliang Tang (4):
  mptcp: drop port parameter of mptcp_pm_add_addr_signal
  mptcp: add echo bit in mptcp_addr_info
  mptcp: drop echo parameter of mptcp_pm_add_addr_signal
  mptcp: drop echo parameter of mptcp_pm_announce_addr

 include/net/mptcp.h    |  3 ++-
 net/mptcp/options.c    | 26 +++++++++++++-------------
 net/mptcp/pm.c         | 29 +++++++++++++++--------------
 net/mptcp/pm_netlink.c |  6 +++---
 net/mptcp/protocol.h   |  8 +++-----
 5 files changed, 36 insertions(+), 36 deletions(-)

--=20
2.34.1

