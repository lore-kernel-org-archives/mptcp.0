Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD52CA7
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641982098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu1a8LomT/JBQQRpb+GZYDoq5RDmUWcmvQ+EsyKdBtE=;
	b=EejrLcOyxlfdfMXxFpCX8EN76gLBKVN5ov4FyuzPjwjlvIN2Bf9+H3n36jfE8auqnK0fvd
	pqIREdVig5qf+0JBulErWx/81du4HrpGFFy+NfFTEbP5Pg79C86X+EGwPyGOV88UMUe5jI
	lNzvT9Oc1L80GIOzpNdWqBtzUxya+2w=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-wqPIw6meO7qoh6jRZNx5Bw-1; Wed, 12 Jan 2022 11:08:17 +0100
X-MC-Unique: wqPIw6meO7qoh6jRZNx5Bw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKuPB61Tr+T5rGKsakuec4JuCJezfV1ECJsTmOAW7XJjXnKA/RBLdCzFv+ZBxcaOmL0NggwP4Y6KaHiux+wvB7mxSPYCj6iZ82svWxmC3X3f+FIPPs+XpEPiFJ4S6d5r71N0gdk1XhgqP+pDQv77wsivs07gtYeb3WlSDwxPnC+Cu8eNKKyXGlnIVld3AkEStry8YWkrdvSmRHBSkgKoDb+HyRZoDd2fB6I6KG2+sePBQWoWofPiDJhkPBtNzlvA+iVRrOM5AVvTwjdeU7z7iQVeNu/3KsVgVD1Sza1WIuS/j83ylASn8q87taIO8sS+siSQJNR4q0TsW3lBWWMadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR+7VrkF433tJxVARGTjcbwMmFv+9rVBDoCglbDvy0c=;
 b=lq25Ig5gGKzpmTG2PgHYIcIHrkNGCITclqSYuPMlfUzdmOpArbpIyj3eMwgJCHlRo3DfdRJTfOHKpVFVK2xPpZzj9LP0wXlHWe7nQA43QIcbIttJDwv6RqMi42c/H7OAix1CeCqrJojB5g6gbNxmJ624eUl6dWxVzOFDIudVERa/DNwwsC0Qufzjg3/phwPMxlgp210AdR5lZOC0nfukPPaRiMGnhZDAh9Q2PgAxBya69QhuWE7lv+B+OJUT5X96/rQnPv/LOxMJGIJGXoBqONIOPhjPQuJZYeJyy48vdYPjPY+3wzvTrRJGEcS7FxAy/xOm+XuUpgA3YlwI2+p3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4533.eurprd04.prod.outlook.com (2603:10a6:20b:18::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 10:08:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:08:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/6] selftests: mptcp: new approach of getting addr
Date: Wed, 12 Jan 2022 18:07:32 +0800
Message-ID: <163e573afd0182e7a39002d8051c6fe2fe3c6760.1641981669.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641981669.git.geliang.tang@suse.com>
References: <cover.1641981669.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64269a1c-bcac-48e0-4a7e-08d9d5b37339
X-MS-TrafficTypeDiagnostic: AM6PR04MB4533:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4533F85E59A659ECB9EC00C4F8529@AM6PR04MB4533.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	byVZpACGUAgvHxImRKCcAi6+zhFsXQ0yWkVwP0wkxyh3crNz1sV+BeKQJTzh6y+8sdSC46QgnzPsR7vZYaCg67YcldA3jpInpPabT+mbkyfgyqIsvpmIL6vZ7VJO9Kn19Ou6t+LtySvv5Pp5hIoZa4iYdtoNkYNoi08z+BGohfHFf/JaZ45zwD2EYkxEMQBeW/HL33CkVY1Rc03GkS5eRORrGQQHXpIQMtv6SDnLOitMQg87WumDzMq9KvNZ668lG3aOGBgy0gRqmgGafbRt1/H8w61PKK1bwIl2vVCE9hu3ydjUP6HLSLdnPGTfagxdRDJiWNmnVbGI2NNVgqIJ9kuYsxq21kCGpEuakAS4UctdEpLHLfkKpU019dLI7NZ9NM7C303OS4SqupxRm9GkEhDL+WDz79U2QVolMhkJ90k1YOHhjFQ5PXrdQT3aQD+rjcFNYaPfxbYAQRkhrlmP50D+nQ1rx7TT/zmAWZJ+Up8h/HA+/1/wNWgqIrnOaYM4miskGeb3g1THNQmWGB0WcCkb9p/CILMvj6U/zRaTPSgOx99XUe+pRhgaT1SG7/a4+196rld5Govkm6XIr8/nXHClxPBVz5T86aqner9akiQAz06yKvyTeUHyFbCCK0YbayVtqpDYoW87GfcaT+2sLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(508600001)(316002)(6512007)(5660300002)(2906002)(8936002)(6506007)(44832011)(55236004)(6666004)(2616005)(66946007)(66476007)(66556008)(8676002)(6486002)(4326008)(36756003)(6916009)(86362001)(83380400001)(38100700002)(186003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4WyN/NhjBF+8VSyzRLWZvu3XvNhxX8GCmE+AG4r1knT4tgGu53GJE6YGKIn?=
 =?us-ascii?Q?ofGj9OMPDhrCM4DvzfhgKht9tzuj3EMvKlJebcYmtmkOOTSD0KXx+7q64fFD?=
 =?us-ascii?Q?7Cci3IOfv3lyw5y9LUKIz9oFlp3alBRF0gJPQWZ1YBm93+lQCmCvHDV6UZCx?=
 =?us-ascii?Q?pQC1ysba8X/tVyrNt6frjyCbNtvt1bjhjrxHEOixFmjgy5DmLoQH6gvvuL6y?=
 =?us-ascii?Q?LvSdFgxcdOysUal5e6JG308ekUPt97vk+DgBKcdvGK8Y4EOdytxW+4I+syCj?=
 =?us-ascii?Q?iwyTJmIBqADEB3YMXm+b1B7eYqr69qN7QMW+q17aEMryjKGT7/TPdwq00Ceq?=
 =?us-ascii?Q?iqYC7y1jlsyUolqkEt/iGVtYIReP2+IXTffJOCMIRvyJXt1GfHPu6cSf3KbT?=
 =?us-ascii?Q?efwAqSWMv+bFYfUlUizKiboT1Ft8Z5+YeiA36H5/0Ys6M5/LEZf0Qpy+h0BX?=
 =?us-ascii?Q?Q1LhEx+Uh+DEO16aAB5ysJxImwna6qxOJ15J5nw7T1zdRFoG7CXdELro2YFk?=
 =?us-ascii?Q?8snlctPpuKM8pbd8oJVgzsF73/j99GCltoGiS91x7WFLxY9nKjkq+fT4IfWF?=
 =?us-ascii?Q?UmgRDG9MXWSj8NFQ67edFzA9ZcPqZ79a8f355jiFBFQkKFGaIQWpPqFnPey5?=
 =?us-ascii?Q?uaYEBl17rCBTrJ2921GV1oafAcBmLKXYMKJNC+fT5gSF7Ceb8IKZ82iP5ulq?=
 =?us-ascii?Q?0l1+x9sRRRIWWH+iDYz9KZmIaETAyNKRCFtOkdFRngEFpEx1TQ5a6I+1Y30S?=
 =?us-ascii?Q?7xtShvYWe8QVTsw4WsQJP7aIs5iYTb9F1aL3hMFSSawwmLxRPoPEoIpg2g3D?=
 =?us-ascii?Q?/76crOcxscOCwnm/JjJJ4uXdAmqUnzr3JvHYRGY7fSZBgAeGnqGci/Fjj8j3?=
 =?us-ascii?Q?eTCKKBqxpLzXvvllAdslXG7TXSkCs4AcYwyk3xyeO9mUfVf5kZF9Wq2+9lQw?=
 =?us-ascii?Q?KS5smJVKRhOLc3JaDr/oXwI/pf4egxBm1VUafBABYWB3KicFdU5mlqkwi2qo?=
 =?us-ascii?Q?ko9WShKf8gkbzYsm6uuL1ktOZ9rVeNWYA48UCcEcS6etxHPxi0XDSQ3qjcM2?=
 =?us-ascii?Q?mbTPKPcRbyp4iuHEle2PQZwf6BS4XlntfoTJcdac/uLskTMgd6xI0zoSAPCG?=
 =?us-ascii?Q?VRc0KE8VHi9V4pTPKXNgSQZLqRNpulH8tJx05/Qj86exdUd5dSfFwfWHhiWC?=
 =?us-ascii?Q?rI7+OJzHgkAnVMbwd+0d7ARYoan1JPtYTyWC7l2Vuk3vP0NU8lqybhldJBid?=
 =?us-ascii?Q?GQulkJyh06T7Dvd4X8IOSBD/NDDxjU8dsoYWeSGL1X3vM6D4tbQ8umdcFfkQ?=
 =?us-ascii?Q?vMvyS8uf9Tp2afWbfKeDT9s92RHO/OYOkLy7Krusp5ht7/xuc1Z3bk6SFmBP?=
 =?us-ascii?Q?NHcw8WvN2iDk8t3AC35Ffy+8u1McSYqilN0HKAV55k9UuOhf3Ef960DaWBZI?=
 =?us-ascii?Q?NGfitGJPa+j9hmgcUc4/JCxIqg+7oH28BL+oNPB00lxTm1syvXYtD1G/jCs1?=
 =?us-ascii?Q?nzs0OJ8zzGfy6yC4PWXBSKbxRm6hRwmdI2HxB/EqDSNwzIOqWhDapR5CiD4+?=
 =?us-ascii?Q?zcO5qukd9nuXZmmHDsJlFhSCz+DT8G/EJM7ikBVBU/6zcpkLpLruKViHj/AF?=
 =?us-ascii?Q?szzfyUXgF7jkPjA+Uy0BKuc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64269a1c-bcac-48e0-4a7e-08d9d5b37339
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:08:15.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a7ANAULqw6bZKApoj2GJmhFtMHBlRgHIWYyFkGk0bPaxCnb9OKkwe2Yq3NrwL+oOU4GlJHwGYbAFUMk2+An+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4533

This patch implemented a more flexible approach to get the address
from the PM dump output.

The original code in the backup tests only works for the output of
'pm_nl_ctl dump'. It chooses the last item in the endpoints dump
table to parse the address in it, and the address is always showed
at the end of the item.

But it dosen't work for the output of 'ip mptcp endpoint show', the
address is always showed at the front of the item. This patch rewrites
the backup tests to fit for the 'ip mptcp' output.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 395f06784582..086e0778a1fa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -240,6 +240,11 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
=20
+is_addr()
+{
+	[ -z "${1##*[.:]*}" ]
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -552,11 +557,17 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
+			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local addr
+
+				for addr in ${arr[@]}; do
+					if is_addr $addr; then
+						break
+					fi
+				done
 				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
-			fi
+			done
 		done
 	fi
=20
--=20
2.31.1

