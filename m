Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980992C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZrDhsbfa7n2oP2Tml1zL1t2LQUXDqmrc4n00hUuH48=;
	b=YKERoaDOUDftyK5tTRxIO1QEmYUoz9uiwvGiTUx6EJcErDn68BNBXHAVjVcAZq3xcYSSIb
	FqLhRfg9+JNhpA+vDl9L6rowPN47B/cmPle60EcU9WziD9M5V7SfobabUYzCALPaViSbwv
	w7mt6QRWhgL0ozqGHFR1PXsBhCmS9R4=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-YkdFlLpMMVWSIRe6DsIXWw-1; Fri, 07 Jan 2022 06:53:02 +0100
X-MC-Unique: YkdFlLpMMVWSIRe6DsIXWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNCI9AA7MMueMC7YNmMAFfdZBYj0oeUuT/b76NwU7l9SBDhI3Sgokh47AfkpkItBp0a7uxFHFgOyekDItLSBAAQZsn1Wp4PEYKfa5qmQw+pzDje6kKVUw9ghfkh6OG0hIAJ4xz58SeUIKWgAW1MbINkge3HDPmTL3KaNZ55koMvhzGEX2tT+5TLQ+tCevDgliNY2n45BSVtXEqlTQ9EfFTpAojbXp3qX+GFw3jO0kBN+4+kCNU9Jc2vVAZGPWk8RGOosjn68Ixj13LNVYFXfadV8lBCX3vp9a6RlSQklYJo5dYjPi3gQokQf9pSQ348OZ2dnzXyppZf7tQfQiluW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wTq4cW1YXAvZIi0N2TNyDI+0LLfiVof6raufy4kCis=;
 b=U5A3p1KXMa8Eqx61gMwDvrhT26xWcLLmYh7LkDTZoZGwVLSFhXe8C3uQPcVBbFsMP2yxoVLP71ss/vgj068kYK4qugVnvMPpVFBm1rYFjv7d4mV7SFhSHoeoVORUkGlIUQUC3jpfg9xssvakGcGsLmHvez9rwaDwvSj8ywi0BVjddvi6YlM/NrSPE/wLvruKm5AwiC/dqAMCISrQLvepicd7lOctX+DizAHbte1qo/FaznaCXOX9j94MQT0EzqA1Ifl6iUviW71YlhPUFKYY+KCIxZS4iZgAGBTzTR/VNgNFhkZqrOAbZ0rwg2tYVkYmb+RJmCEjWE7vkb8Yq6aRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3002.eurprd04.prod.outlook.com (2603:10a6:7:1a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 05:53:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:53:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 9/9] selftests: mptcp: set ip_mptcp in command line
Date: Fri,  7 Jan 2022 13:51:51 +0800
Message-ID: <7433c017276a3cdd75eccc08c37483f1bdf29afe.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0154.apcprd02.prod.outlook.com
 (2603:1096:201:1f::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a1837f8-fa6d-459d-6acc-08d9d1a1f61f
X-MS-TrafficTypeDiagnostic: HE1PR04MB3002:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB300209C56F8A348BF09E5A6EF84D9@HE1PR04MB3002.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mptp+aRzoT3myrPez55LMraDZyEi6bJIMg9BiD4I6UTRjRJB13c3VSWsU+HOP2+N2l1RmN7rqR/JCtmJhlfE31RgrNHV349rPQDesVBWwkQuSIGK3cGAh1THiMqzFjUvydMv6x4QYFDQvlnzhFKnmNEuo5NUE6KgiQfh/AAQC0bO66oqzsiG6F9CSClQ0cIIRVpeHr8SrElesiCuHP21d6JnrFUsOrAciH10s/sXrWRJ8gTwycVykLrz42Fbb00V01Z30Wf1o2Qb0oUs46T4kxRRfJSWXSWveh5EtQ3Jpnj7+QMDNRQ3GJa38aaCkmu5EKj8qKbWDsW3sj3Oa9TLocsGZheBFMVRaZKdLGs2QlpgrATEI65pQhVSqoRSt8iL+76YwEQMvevtvDOwLyYBtOPgDnrfkdyofwSs24D7rggk4GIYkRYke2gFXh67DjkLNwScnpCj8khXXY6R7pvP5JU56Ty/tRRkcOS82ieoKm5Xn5A/hHLJ3eWEHOekonYkFY/i/yWlpWpRmwkmQ2Phaq5P50STV6bNmRb31iW1c9o0f35Mnlt/LkpVQKGdqbKAuA5wjC4E8bUf1El/M4JWbrPQtsM7jJ+W5F9bi8gsPry9qvjIFZ1Ny3kgHwI6mKITAoqQ2+mSSkJfSm70HHVuTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6666004)(8936002)(2616005)(83380400001)(4326008)(5660300002)(6486002)(6512007)(2906002)(55236004)(38100700002)(508600001)(44832011)(6506007)(36756003)(6916009)(107886003)(316002)(186003)(86362001)(66476007)(66946007)(66556008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y4n2CksUZ7yIN1W+KvPI72yYGy4YiGbKm+goPOt6uRqDASZVsE3xCWj/Lxp0?=
 =?us-ascii?Q?ruh+EOjj786ED/VJThSt/3aJNBQg2V5ZCLXRCfRey0x3cUJ5RG6RI/kf7mhH?=
 =?us-ascii?Q?lCiZ4TfJCPCM3CoVGKcJ+hMM8v5cPSQvcooD28ycaynUNqYhaP8NqmI62w8M?=
 =?us-ascii?Q?0F1tTKI6unVrPRFeMWqMhAA1fNXlzCvlgVHOFK5QFUjw/Cjlt3hIFijijquV?=
 =?us-ascii?Q?0/O3J6v94amxdjGDtj/Nd8sAlYEep1jHgtJWk/8btM+Kuo7sjpdmMoW0WAen?=
 =?us-ascii?Q?wVM6KvJeiMbrzAB5P6D8iotRDh+43IvMOONjmcxw6q6ba+oHDd9vBiSNpE3S?=
 =?us-ascii?Q?K5Ee1s22bT8KaFPXonyUioKtm4lNsnQE9lYRBm7oSGwSrU8rFSPF8923fPNI?=
 =?us-ascii?Q?VJRAmfH4I3R/+KZCMRT3yFX3tDGPDpBPunQoT459YXeA9BiKbcGNgAVgwNJG?=
 =?us-ascii?Q?8IFQUwWeLUHJBkwS/fZNKaZA9WKP6Gh1LbuFPDIKAelSsgGFJ34JNBhqtrDW?=
 =?us-ascii?Q?fK/8L1qr5Ybbinb5WF9w4TkKTGBwvGhYGlsibGvZV/1ULeYMK6z8P2tSeFwa?=
 =?us-ascii?Q?s83NP71IhAKOh3IdNew24QMILEvusrVHFWb9/fpa5ry8kwnnIIthmE9XBQ+f?=
 =?us-ascii?Q?QDNjNK689G7A6qS71N/NuQL6eACmOS+au9pIyTGlr73rh8QJIhzG6Hae+t7j?=
 =?us-ascii?Q?AXHVJ5IAOQdW6bJpF3l8KvmcwufwEf+M4n7NF83UHN7kZmvut+sAITcyONvw?=
 =?us-ascii?Q?Zz8CMsBBeg2nlmbyIluVPfeyXt32pZ3u0RuV4E1l1doUXXfsltNPuxTcVn0u?=
 =?us-ascii?Q?HCdELRF9nDmg7htaZ37vXzdK1JlEsR27gIwnSY/ZZxBRScP9VqaiZDM4K18p?=
 =?us-ascii?Q?guFlGLoKfVxXZ8pa9owHtXh0gLvwKXrcsy4z0PTtFeM8JIT1G9yl5n1HyWxh?=
 =?us-ascii?Q?VCOjd0/TtfRlrOvcFWjGE7+/dVwfBeb8Q9tRRsLNCxcLVmWxlvDq59FqYEZg?=
 =?us-ascii?Q?C6UP6assPzp83ZEfeJMRyFoKcFrXzXQ5eLrQau9ZFkbNM38mm4BclMAwjL7E?=
 =?us-ascii?Q?w9aTNDcQ/6roRsKMko1H6AMAdntPLHz7HhXAxevi8W2OMA4TNTEJdxP6UNzD?=
 =?us-ascii?Q?bOXch5PeC/U6NtsUYe8LCEhItiHVTj1cpVa16JkTfNGHFF0AmVKW/kwkO/na?=
 =?us-ascii?Q?JD8hRuAIlAyqvZ//7HoZDnrsFvWCMeIOJU0ccjo8N4RyFSLm991fW+YVldtl?=
 =?us-ascii?Q?o0KL6ACS44f1iNWvYDEtoMKmUXXUJfxqB68fDd7WmK9qMcdHbEHyFymi5SHH?=
 =?us-ascii?Q?wn3Zo0rNZZkMpPjK0jqnxWekgM49rHvXSBc888D7jpkuHmTEHEhElsHzL1r9?=
 =?us-ascii?Q?iQWfqj+be7g2+a6apu/XKFVPgeoMp7dKVffq2XmHeYhWpyhDaJqMVULbSh9I?=
 =?us-ascii?Q?PviMoVt4VMppK3OTad8F9ijIe1amy28ht0Rz1iBKW6oI7T1SEx6dFyzmuIdX?=
 =?us-ascii?Q?eyJrjMwwp4/OiD7T06P+ARDWxWrKhFbBwrDnrWVXYqYgV3VFyiONG4YIHwvd?=
 =?us-ascii?Q?IpgQnTGSmoqvg60yZJmyBNJHiaOzu9UHoM1f+xGEaPnu4OXvVjm8Y752sIDO?=
 =?us-ascii?Q?8NTjsDXNJVXrNGwDCi33B84=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1837f8-fa6d-459d-6acc-08d9d1a1f61f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:59.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SepMZcqs1KIXgisc73C2p0YGvhsD1gG8yfLok2B2A6PqB36ltgp4P+6naksMOZhVIJrgMMLs2QH/iw4zOjZAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3002

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9d1f1ffd822b..e2231b271217 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2151,6 +2151,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2172,9 +2173,12 @@ for arg in "$@"; do
 	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
 		checksum=3D1
 	fi
+	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
+		ip_mptcp=3D1
+	fi
=20
-	# exception for the capture/checksum options, the rest means: a part of t=
he tests
-	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ]; then
+	# exception for the capture/checksum/ip_mptcp options, the rest means: a =
part of the tests
+	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ] && [ "${arg}" !=3D "-=
i" ]; then
 		do_all_tests=3D0
 	fi
 done
@@ -2184,7 +2188,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2238,6 +2242,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
 			;;
 		C)
 			;;
+		i)
+			;;
 		h | *)
 			usage
 			;;
--=20
2.31.1

