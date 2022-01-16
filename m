Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB72CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mn33dTqazdkzJodIth9TiRKaZaLluMeczHDht9qxAuI=;
	b=Vu8Vfyf2rUx2rBi5wXjx3BVNbkcurRTSIvJN9g3Zz31SDCNMb5ux2yxmm44O5l/HI/KyFr
	YVy0nZbCp2PdTT72apFBNyu90Fi6pUYVTjjirVBlNdd8to109PRXJStiheKbzK9bQFN92i
	q6SXBvBSoZUlze4j4aRn5jXs/ZnplO8=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-0GtXhb_mNL2gB3_eM42IvQ-1; Sun, 16 Jan 2022 09:18:59 +0100
X-MC-Unique: 0GtXhb_mNL2gB3_eM42IvQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtPlcEIexLpEXCPmNxj9bflVFC0NKO8a1ZzICNXaHXOyZIs+ldllJpaJLVJUB1ZUze/8+mVq10k+zRTlM6uGTq8xNm7SZ7lJUfqWQ+Dxac8akubzbSAIvwUwLsan3crtZHPvVAHcv30nBUdPcJ9dG5JkyoQlhOMARCMmzZQrmDqzGRc5sirN5S+ZFfZho82LA7ATHABsssi48O2csB8Y9ZA2TdJc8y6PbnNW0Tk4Vfr7YFGGEAHGaqV7mdJoRtnP3Zmm6NdeVvPeHVaQ1iXGvRdkNI84VbkIeKj4uDAl2jIYuv1iKZ/99j4xsvtGCDgyvaM+gFunAPH0HP2MPCZ3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytlFxzOBosESGWXeT4xjih6cfuIlrBnM9mHCSe4Chpo=;
 b=SDSaIRrElAgdiOeumLYwEMpRl8SPQHRra0+5EWp8VqLjO9yFgIJCxdOE4BQsu/UYXGhMXb523DIbLPtdCyaTdTgpTo++9LA7G28h7stS03ZIgpA9zWdgLzcrvR1++LlBgQHk5XsWc00jp0sYbsZgOM7KW7y1c43Os4UjWsSvczP5aM6mXq1pwzdW+Cmx/MgZ/1el26l22HRvlTNMqJ8pkNJpzBR/ICzB5L6q4ERgJBkO9Y6Yud76COW+/cfyszTuQaZk32QLDzYehRPMVpcBbd78WIJky3MXJ9bvaXCPd5gNyVleh9e1T6DAiiR9XiuaRXHZsoWtSL9A4qZ0qRkE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR04MB3047.eurprd04.prod.outlook.com (2603:10a6:6:a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Sun, 16 Jan 2022 08:18:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 09/10] selftests: mptcp: add wrapper for setting flags
Date: Sun, 16 Jan 2022 16:17:39 +0800
Message-ID: <fe02dddcdcd7aaf908cece1ced361f57433e6272.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc82f30c-ad80-4fd3-b928-08d9d8c8d811
X-MS-TrafficTypeDiagnostic: DB6PR04MB3047:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR04MB30472777FCCFFEE64284A32EF8569@DB6PR04MB3047.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ouKSQ8WssPyywg7MnLcFWGyjbpOouoqdtkSCXGEMtAewWQptAplqY97cPYigZ+zisLFY8VKl8VULVDvZlE2v+y5Y8TwloyTZB9kFM7ba3OBrh6yZVxNFWdS+5nABHSj6R+zG5uP05RBtqyUA01VNgMwULjPK20iCQyuykhAbUDaFXvk3BS7hs9JGNxrh8IfY1EAFhFXNc7msMxLIPbrnr+iwlrAGYBAIvwSovWMsq9YJj8QclWcOmS157/MBGUGLr0LQsZo+b3qvUHy8LEXLXkahNO803bqQ6cPXwwF9MJG4OyPHAEirDHH7dG2wm0eXhXekUsYZsbkegAJzu9I0Ho2ebY9Xj9RmAY368n0A6bJDld8rkq1WUpGnkNfbPRnt9TEvkKApaqPcvV3qMxReDp0IEyNSl9HVO6NpZiZJdKj60Q/hi7711dCZjvbnMqSS27dm77hG6TuzmfkhK/fsWqU+KJKK/UIwLK6cMvuIvEpy7D2d8dnsBOq2Mu1rqIfjdzVdQ1jgqIO5LiqHxrRXbZYrObuzKTNhqYQJ35Nhe3T5sdk0DQBm629CEtUN5frEQbBYHvOUCQterbBNLGuaOMRzNKJNq0bw/0OT3bZeNooRx2nXp3aH33mFaeFvG2p2WIVoKEZe2xyRNhYgC/hiMWsL3et/y1dYbovELZfoN1d9gNzVd3p/L2s6oE5v6+x0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(4326008)(8936002)(6512007)(5660300002)(6506007)(83380400001)(86362001)(508600001)(6666004)(6916009)(44832011)(36756003)(8676002)(66556008)(186003)(66476007)(66946007)(6486002)(2906002)(38100700002)(316002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBllOlJ2+mzA0PiJoY7GLpQcBYLE75brrZ4Pr1X4z6szks52Rj77w+O7TgcP?=
 =?us-ascii?Q?csLG5BcLIzelexa3taE2Y5UGKm9P5CROBCgySej8SzNAH6r1A3Tm6lwkCxFY?=
 =?us-ascii?Q?5+8xjxfETaGPOUZoAA9A0m4Gdtip5yBzZfvFb66LhypTsGTa14JLlA1/pL8a?=
 =?us-ascii?Q?VMLFd0cIDmdLwTI5OdKw2QN3//wNdbZS/BAlyMS9XE3y2bFx2W4Rg4yOoXlo?=
 =?us-ascii?Q?CbOTxFzMiTUxyG6PBphbewSPDC8vhskDxB8et5HONfEa+0WYHcpQv00aNUkO?=
 =?us-ascii?Q?blX/st4OGdNRXioLmd5ZpLcltZ6EOFpcNV1jGFtshgvryY+Z9Q+IqSoPEiw2?=
 =?us-ascii?Q?ZhO6l+u89L0G8mzhT4Pyh4Q8ElosGCCLd5w2yLVyL6qT+YvBUgT2Poql9Vq4?=
 =?us-ascii?Q?9lOXO7B4cLlb7Q6IAQdqGSMGmWuz5WxGyr2CYh8ZOwBnji7Vmbm5nRxPHK2S?=
 =?us-ascii?Q?oA3qU3V4cHWb89x7tS4fdRV0k7ka5CwmP3qCxq4trXo96SymfHhoMpTseEGj?=
 =?us-ascii?Q?VtZF6MBbqa8B7GR2eolJOal5bF6xoXF6Kozw3tJsmEYtA00xPPhIy91933yd?=
 =?us-ascii?Q?0TUolLCkPt+Eu0amwHsRbs/PEa4bb0rktyGmAm4NlUq5REU9Eb/tdnq+CB+z?=
 =?us-ascii?Q?jKWBu+p9K5eVW2Sw00tBha/rkdD+IF2lEANqV8HRomSZ9HAWRTUgNyZ0DsD4?=
 =?us-ascii?Q?EoKKtgltdfGwKyR57e5T9RnNCMBV5Ds8S8eYm18w7wEryKxDRFFU+t+kPHJo?=
 =?us-ascii?Q?UV34dZwMWUO+bdb3JF4dx+39PzmSZLJLrjEKhNEJXV1iqpJE0vAbLqJxFMOe?=
 =?us-ascii?Q?NZsvO06PZicUpc51jd4ese3XblSDQeIMB+BVx3hQjlnbXX+l1XN8MCnnWN4o?=
 =?us-ascii?Q?qnCBKq5Mg37i+SBIZeOft0YCCreXGdjwNJhnGnDmkJfgKltkndDMvUiMvDgv?=
 =?us-ascii?Q?tVxob5ebOsjV5RDY4KcWnQx2ctEle9HlixK8Oj2Hh118KoKXTT76GHOoda2w?=
 =?us-ascii?Q?LG2wdREZ2EhlAK3oOZH0buhB0WZbsEMN4kbkaSxKOsxECUe5W/smbQ8CX/1R?=
 =?us-ascii?Q?54bmIg7KYQqB92weHYAF+/yE+99/4Hzk3JYCVrZgrBj5kvPYe7EeUtz13oYJ?=
 =?us-ascii?Q?yx2pGEpz7uEj+djnBU3w7uqNbFeuqrsL67BqJYza+Dzi0BySUr9LTUfoXx7Z?=
 =?us-ascii?Q?qgz5/u/hYT2vOlp5pKTo/SS3wH/aSgmcpXgZIX+4sR+5xqr1vpxAxnfR56hk?=
 =?us-ascii?Q?sUKQhgHmJU17mfE6UZjlkyMNZG75IoPsBEkMTtd9r4td831WFPe0GSa7vxTP?=
 =?us-ascii?Q?lEb97lscdi4Qu+Dp5tAT060rhd6hUfaOwW0pZwMrSFP2I7slkC1inB4JLkAC?=
 =?us-ascii?Q?DlvKchPkyrGFjaiedo7HZp1fO1l8NihyLo5yr7LH6ejViDH7kXTo321wtqEp?=
 =?us-ascii?Q?vuLbGdNYmKyGfxFt1RAzXEXx4vivdwQohJl9j99XJ2DEKT6cFrwx7uMUz62N?=
 =?us-ascii?Q?8mHg90mxiJmSM5tIuOewrMQgLcbj1iN8W4Ham6WIT/wFxsTzRsm37Y3gmenE?=
 =?us-ascii?Q?W8tPJ1DqIIB3hpL0SmpzI2F4ZJmSUhDz/JVIb5u9oe2FkCinsOdhI0AC+52y?=
 =?us-ascii?Q?KG7jVpeALQMUd8CNgcmVr/0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc82f30c-ad80-4fd3-b928-08d9d8c8d811
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:58.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDryONj+TKM1PT+TPFbhFMwDJwd8lReGED8/9Ds5qBX8GKazRge8DcPdDc718Qd5COI2Rg7WWfVrfZWsgr3iMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3047

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp endpoint change flags' and 'pm_nl_ctl
set flags' in it, and used a new argument 'ip_mptcp' to choose which one
to use to set the flags of the PM endpoint.

'ip mptcp' used the ID number argument to find out the address to change
flags, while 'pm_nl_ctl' used the address and port number arguments. So
we need to parse the address ID from the PM dump output as well as the
address and port number.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 84c03267ea9f..681a72bbca9d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -384,6 +384,22 @@ pm_nl_show_endpoints()
 	fi
 }
=20
+pm_nl_change_endpoint()
+{
+	local ns=3D$1
+	local flags=3D$2
+	local id=3D$3
+	local addr=3D$4
+	local port=3D""
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
+	else
+		[ ! -z $5 ]; port=3D"port $5"
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -585,7 +601,7 @@ do_transfer()
 				local arr=3D($line)
 				local addr
 				local port=3D0
-				local _port=3D""
+				local id
=20
 				for i in ${arr[@]}; do
 					if is_addr $i; then
@@ -594,11 +610,13 @@ do_transfer()
 						# The minimum expected port number is 10000
 						if [ $i -gt 10000 ]; then
 							port=3D$i
+						# The maximum id number is 255
+						elif [ $i -lt 255 ]; then
+							id=3D$i
 						fi
 					fi
 				done
-				[ ! -z $port ]; _port=3D"port $port"
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+				pm_nl_change_endpoint $netns $sflags $id $addr $port
 			done
 		done
 	fi
--=20
2.31.1

