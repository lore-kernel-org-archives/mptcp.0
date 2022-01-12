Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466C2CA7
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641982114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OI2FaYHB7uVyZ2Bfs6CMH5rBolb5yO3lrHNwwT8DO4=;
	b=JBUCtN14dXhsinGc/naIxCLWxurGI+qnmNDpKSbl7IYREY7Ri2vV8gQ8wg6hL1HftXdku9
	LTqXG+E3mir2LzOsrl+1csaqg9kV57v0FJbgJSAMbj5zvRJZblgxnNiCq3fjb+Uh46YU1L
	kI2XOvKd7E14MTM/qCfi7fshzA/K6Ow=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-2GD9HtsyMyOeY2FDeBm-NQ-1; Wed, 12 Jan 2022 11:08:33 +0100
X-MC-Unique: 2GD9HtsyMyOeY2FDeBm-NQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvQtwrO0IdmK0f6M112j+ByDR/dDZ+6CR34zuCpbR68ACLGEUSZRnWXcgkKExj/OefM3o45SolTxz+Bh3mbzEbTCWGVCdUwdbzhTqLZC+LHwANoIyvPnyM7x/8XDGJdXOIWZW8xNNH9hkt5zkp2sKjepBXN2AvNukf03tygNdlgqds7H+AmD8QlDWOflbNjvqFIqJONpumiD1jV7Fqi3g96l7QQ42rOa07PGu/TLkrZtPi+cxkzRhpsYN3rSwRhOU2k2XsEazagRLoAfen1/IduKxHzUTMxbsiEuFLofMPKCC7NfDbr2rJf3aKmzvgMq9b6alKCHHxJqN0tnmnWO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRke+Wszr+yRbcUaV7hATvMOaNBnxFBiDGRQHdzvYFs=;
 b=Qxxd3uY1/EKQS6KwbXYUYu38vzLggGAPGpZva4fgPQzGhdvA1W3WFvMkaoStapKO7NGXOs7Da4cvV2Nrd7SykXBvV1HLEtzOSUsxygH0cXr5sBC+LOcTVB2IpQEv41jBDe9w7OJghoxzGhuiQtn4I2YvDR+tFQxUBpv964UDbgweGMnnCEnww/+dno3IsUSTkg8PY34+NCnXAozSzyVLjY9Ekv1C4o+xGdcF1K5xXCVlnyv7t3FCiMpo2iX0RM5GWgSbC2a3prJT0k4dTNdnfv4OTSkL/zBJAzFuszlsASDg/bJcRDYK34GJWqSVeWMKNZWmbnO9+7wjcq2JbaB+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5373.eurprd04.prod.outlook.com (2603:10a6:803:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 10:08:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:08:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/6] selftests: mptcp: implement set_flags wrapper
Date: Wed, 12 Jan 2022 18:07:34 +0800
Message-ID: <b688ee76457e2eac414dee125c531dc75d6660cb.1641981669.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641981669.git.geliang.tang@suse.com>
References: <cover.1641981669.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31e40adf-ba3d-4cee-9242-08d9d5b37bca
X-MS-TrafficTypeDiagnostic: VI1PR04MB5373:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB53737D2E009DAE96EC72A660F8529@VI1PR04MB5373.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	THOzEA3xJ98tW0PLf12plKFkIkoDHwSfy2gO40eGggNK7qa92LlKrQsLIJsTJK53SiRsYiFAnYyRD7vlbWlJ7qG24G5cV9HmMhWg0/MoD2mV9BPnKh1EoUc+MCl8N0W9ePV/2CJExclgOeFvGamPL5vqfDV9vx2Pa0XvPA0lpv2OYhzXUjfXDVj0t6nwOlTSVWZcEDR2fJM5CjCACXZlZqvQt4jeD9EdDbc08kbW/oOkfBaYxkOqCd57RO1uwpm3xDJavRJvoMn99njyVbinw6uLPOCp7ZXcau7Cv0A548TRItQFFY3r9z3RalNqfWaoU1cue9vUjbHBeb7SpdkNuhRvQ2xcH7/82kKEDGSkk/R2XWSWVh1LsRmBr7a0J1CNpT5X6R2pvScfrwTWwF48B7H4fGK5WEBViMWDMavoR3fl2Pd6Jp1Mp6jKpTvgz/foPhfdlQdWDXG38TsUV95svSw6w23WlpmUfCpTIZNn7THKixfaIrk+2F5Mf58Lgz2gkDP9MpEv9WTmiD2hLVuEQZGlGnzs5HVCoXkX6Ma72jMrPOQCHJFI+47Tre0r9tUe9WoupkRwBReGbaH2C0ZMrks/Qs6CidWEwXFFEzAF8EMPyJ3OxqzGjObPDl/u8Rf8ISvX0cGODUxTsCWHI3w2TA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(2906002)(36756003)(8676002)(316002)(44832011)(186003)(2616005)(6486002)(26005)(5660300002)(6916009)(86362001)(55236004)(4326008)(6512007)(66556008)(38100700002)(83380400001)(66946007)(6506007)(508600001)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Qbs4kVEk4Ctse3H85353XwQW9MaYPxeB6azDuBwNKKapcOzTzg2gP0HWpSk?=
 =?us-ascii?Q?8WIYR1dfG193lqBRramn0iJQ+uzeIlAHxtsIcPGm2fFpvy3S0av9kWIrQyCB?=
 =?us-ascii?Q?ohWifZXjlpS5Wjqug5xBcifbhjegOUy5/WgU/MUAJtfPI4m3+sNyEVF86daM?=
 =?us-ascii?Q?EjE5TD9yXPBJHVAPUhPDQzBRyTJDZt8JNmJKFqJlIbRlvWWBjRYIgGLb8WoA?=
 =?us-ascii?Q?ANzHyzywn2tbKNey6ZFW3q5QxoMtxwN9ygLlmea+LBGcOqrjglzv7NHf74xl?=
 =?us-ascii?Q?lRX1xdQPvcioYMg9KFtKa5bFXBlGn1QI97GxdXmz8lhPaj095N0Pj9F5QyIE?=
 =?us-ascii?Q?QpJegomgYvKqRRhk/Ci655TdE21a7V+sEq1V0ETsheocwqcDicUSAOW7y/w6?=
 =?us-ascii?Q?qyAhnHwcaEtvptZI0cBRqWF/i3a6U3ymUQHAsqXLNijxP6oNJS5qJWBDk7xL?=
 =?us-ascii?Q?/w8t5VRXR4QaTbCv8CnFau5QW/BLx1lHtzESjRXhqwfFMG7r0u+K38iRv04c?=
 =?us-ascii?Q?+6qK8MS5+yPrJMwaVRvRRJegeSpYDuqYJuNEcjG5DInjvGSltecmRxrR9Eg3?=
 =?us-ascii?Q?/5sFt4dmzm61zSAbVAfUnsUDhHBJWTzy4gRirNgCJ/UIcLFIpSq+4nhCdOYk?=
 =?us-ascii?Q?WlNTShDIeadO73DCE5qSjelFhzsmVFdB6TRwXBL0i8Gs29NOHjKB5o30mxMH?=
 =?us-ascii?Q?TSM8t++rB4iPLqJS/FHLN4kBfYiVBiRJMDj/dAxofW5h5dgzO/R4g9zQz4d6?=
 =?us-ascii?Q?1SElJqnV+hG4YbYX1SzdfwvOLYO4aDou1Lca8kpAiAP9wuxZLwOH+xN4Qfpe?=
 =?us-ascii?Q?jTjIiQLQ9dtLm5L2JT2usONStqB6ZrkKb2h0zdR4Qo2p5FZ+wftgIQGzc+cf?=
 =?us-ascii?Q?wucJGSGyTyObN65alSsplvFtxfFSLdL+v5DgEbuZsunK+SHrsDvUTDSBPtF+?=
 =?us-ascii?Q?/3e8b1jwNOs9j7TrohZ55cCpbXDcfbU0waPreYVrfDH4yUaTUadAQzy5HDGk?=
 =?us-ascii?Q?g0UOUM9WLBNva1jwuUjisDqK78CABFmWHvogiiEy+UXj4P/Ljcjwv4htT4qw?=
 =?us-ascii?Q?4/38W1jM3abgUnywnJRNs3f/ftY3swZf29Z00BzveQDix2eRA0JkhAKX+YKr?=
 =?us-ascii?Q?VApqvuIJkwVo9Z9wE1Jb3MxPV61ZcFhzVPP7q0bEcswhYcYGx4QteMfI+uPj?=
 =?us-ascii?Q?A3sQCDTJfxtC+ezoihXgDC/QD5MF0y1cy+WSSC0YQ788BurbhcwujClle6u3?=
 =?us-ascii?Q?LAiWli1KL/KVIIWkzXDcMzz8Nh/8vQjkR+VPm5OELcAhCnhmECHSgL7Mu8FV?=
 =?us-ascii?Q?KpuBylnjcOgvR55gX6wTHG39oF/IN1ly59m52OLaUEen/sYKE118ZzpUAbf3?=
 =?us-ascii?Q?l6ue9MikBvtHDPWLvY8IngYLeRTTHyjpU1xZxZddG0shZtXiitM64oFxgMnL?=
 =?us-ascii?Q?8fnW/8zjbS2JGNdX0pmZLfOLlmR0vYNiy1oDGw3VYvW8Yk3UtbJcF7ehBFla?=
 =?us-ascii?Q?5gj0VTOkm+7ekt3qIIvbUT+0lisTBjvnd4L1CIR7VeZ61wkxjQcSQXUqCyUG?=
 =?us-ascii?Q?hKne7oHALfoYc0qmBvKVmXv1NTah3sac72eP4mFcuk/PDGAydc9HCF7EsItL?=
 =?us-ascii?Q?ze53an+mq8Jvq0A17HHO3Cc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e40adf-ba3d-4cee-9242-08d9d5b37bca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:08:30.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCZwaQ/OnewupbozA0kpDL4xWjcasHNUNMUx8vhpsAsCCcPs0nDkwpagNNtPjMZQgNjxOlmh3dPOSPoYILvbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5373

This patch implemented a new function named pm_nl_set_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to set the flags of the PM
endpoint.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 617f311057df..866f88b27dbe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -371,6 +371,20 @@ pm_nl_show_endpoint()
 	fi
 }
=20
+pm_nl_change_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local id=3D$3
+	local sflags=3D$4
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint change id $id $sflags
+	else
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $sflags
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -571,13 +585,22 @@ do_transfer()
 			pm_nl_show_endpoint $netns | while read line; do
 				local arr=3D($line)
 				local addr
+				local nr=3D0
+				local id
=20
 				for addr in ${arr[@]}; do
 					if is_addr $addr; then
 						break
 					fi
 				done
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						id=3D${arr[$nr+1]}
+					fi
+					let nr+=3D1
+				done
+				pm_nl_change_endpoint $netns $addr $id $sflags
 			done
 		done
 	fi
--=20
2.31.1

