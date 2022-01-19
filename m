Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1E2C80
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642570936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6w9+Za2UUVsNYUeYIQG70Yh6jFFVl4ZkT0Tx97BMQ2E=;
	b=jo+KPakvpl7QYJyyEQ8bLjzt6omdAlziUdk9KRdS4D5FhV+kvYmJ3StmooTdle24A9/zAp
	34xDNYAu8r+psCwsS3s+DjA9+5KmKpFFhSgPmFmO/O03gLpHVSbmnDGSADIszNT7+AtjIC
	+FjOHo26XBLyTnxpKAHdpr1k1RO0hnE=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2059.outbound.protection.outlook.com [104.47.1.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-1j4xgv1pOJ6A2UkW5lMGPA-1; Wed, 19 Jan 2022 06:42:15 +0100
X-MC-Unique: 1j4xgv1pOJ6A2UkW5lMGPA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaiudKHfEXEfEGdODCDHamSdcfjNzMEGEBgNN/DPkI0m1+8FaZvm/33sd3VxrDL7rDuQwRO0ree7P/r4723+mN6QeBjMCS/c9c5jKHBOuS5hyGKXmAAmIU7kEjuTaP0uMxdnKVrUm/7XTq+tqMkTFCOJbXceLYtf/0HY/XDcS6ddntFrdTVWweyBjDADRiRXunssW/UmD47D8VPJT7yhKYcpjXco+q11hvRohfrwASWtIhkmDB8uhbLPp908AIVT90Ho8yJetwjynqym91I2ZgsU9M5lV1PYNagnsg7ShtJOzJBGyJTb/xkKhnp8vPmESdv2pAg9U5oSuD0TDIu6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RTp4qZTlVi5i2IoHWW4jsRMaEn/oeTGsApopUMubXI=;
 b=NAMHmRhyL/0Pxa8s+YhUTQaf3fyNlXML15xm9D3EzFiHtHYZi+sJ2b+laKeoszcZslVYK2CGLmFAZ1e5mASxulkF55l9Kb7V8tD/FvhUbbisHgd/y7bAuPKLE6fDne94MFRI3BjM8+SuhYJC9bZ66DYSr6VeessTdbYhLIU5fYzXk49lS129dtSQj6D0n7hwbh7mCvB56Fi9h7jtabOoriF4Id6vnN8QgCZIBkjQ4XnvKPbY3MeC7aMTX/JwGOgW3JQ48itavO1GlpQMn7WP5rItDvVJ7RsN8xq0UCpB2RMPX0zdWP1/1kisdS/UQccWppx4tbetfc91Hsy9L2nLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3225.eurprd04.prod.outlook.com (2603:10a6:7:24::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 05:42:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:42:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3] selftests: mptcp: add invert check in check_transfer
Date: Wed, 19 Jan 2022 13:42:11 +0800
Message-ID: <ed191af941837d4c63ea37a9a863dc39904571d2.1642570570.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f47cc8e1-2f78-484b-161f-08d9db0e7126
X-MS-TrafficTypeDiagnostic: HE1PR04MB3225:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB32257292748C672320F85E2AF8599@HE1PR04MB3225.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	twD5eNZ77dwr5avHaOdS/JonT+AABbEo9YceQQohKUa4qI2SXtrgIH03rgDuUUoMlwaWOTNstriiBt7LCyEGCHMeALEGfHzdcZYtovs1sV7nTM1nNXLKT4JLv5CClADTK/wFk5+8k2QNP5HoOeiz3FFJ82TkhI2FJ7nZtEc8C8OalzBpg8C3NNqLXN7J0BzPN2ZFSlgnulRjG7GQb5yqS5Poq2n1wRid6CLmTDy2+K/GOSJOnTbszF24qIiCWIF3/mRdxjiEKBgMINiq7hwnLgVN7qu5+bWzJ4Z6ZcxyPSUG7Gfoutu+tsYo0iBeb5TRwM5XWL+b0S4IdZx98GKSIxFFImZyRndzOEBbiDuPCNXa2w7+u25ifjv07hdzuG6CY9++9uVoiQJ2RN/kqJCWMQopoonL3s8I0O5W8gijEzVSPkFnZCLHsUPbBkNitmPtCSIkJtLMAerGsiKaH8+Ma6kZRYvjIUhIqcaTeDyZn3OPdw0BgU93QgyXt7YIwW5zqZPLa1+tuERHM8tbow2paXfQz8sBSMj5kNVPw4T0LHq+Ztlt4Q+KbcVDx+FJvtt8uPiz/9F2LlKIUY3go1QBXOJHUl9WCMcJLrVMp8cbKHn0H4SoguTaLru13EMLhj1w9tH5Pc1UeUmg3Nl/yvqMbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(26005)(55236004)(6486002)(86362001)(83380400001)(107886003)(66946007)(186003)(66556008)(66476007)(5660300002)(6506007)(19627235002)(316002)(6916009)(38100700002)(8936002)(8676002)(2906002)(4326008)(44832011)(2616005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3fsI+jaZu9tFSV2+eD1KFRCkSJvK0BmBbuiBi/AeNw0qGgR5B8MIx+CqBVVF?=
 =?us-ascii?Q?GAd41VYXrJuM67bEaeUEvtCOHTXrHOYcjYqmSDw8LN9eNpvRFjuMFGZm/2xS?=
 =?us-ascii?Q?3hKsZnSFU6I4ewsToDA7Fq1b7lDTkZUrZCipEeIL4ynb/OD2+IoUwN+zg8mw?=
 =?us-ascii?Q?6iL6Wo/rUSbS+9627tQIl4ZmDx0/67ewJUCSm0/c/fIZ6CAoUZ/FDijFZXXk?=
 =?us-ascii?Q?PfLw43fmGZxaY56j8yHTkiNqIr8cqqML8QGrEw4NRmmh4UP3seCfJqRVz051?=
 =?us-ascii?Q?wiNejTiZ2F0jH60TAGiHlaQdWB3GwkZfEzFMyR7h+4fWPJ7Xk0aeGvc+CCEn?=
 =?us-ascii?Q?WEJwJubhKMLPLgiYgjqweAhAW3V+nNojtUZ1s/EADW60Q7pwlWpW6A2pNCbz?=
 =?us-ascii?Q?thxSOyZmz1bPAd0TQzVbKZAJ0BSsmErs5uieJwnxIjR5zI+zop6u48/o2FP2?=
 =?us-ascii?Q?1KyGbkE3szTMhtqW99viUKYYS15yj18yF5VkjIBqxa1k6sZ8vKnDumP878wc?=
 =?us-ascii?Q?PT05KXON3a4e3kbUYjae6XbEBbOWeWOCXDQOlLCUl91QvtxpE1ThgoCyaDlE?=
 =?us-ascii?Q?X0Fhutp9knQ82vC73NsM3sFiXLEMWVS8RrXb9Vg1kvsZy5Nxiy7003L8YLHL?=
 =?us-ascii?Q?bv92e352ZbpwojlPRCcDigS4BZ21SaAvBuo46fAJ6E8OBXG6A4K5aHmfX1yh?=
 =?us-ascii?Q?joB81gK1h9ggWz46wBW1oz0Zr2DmzxKP6PSQjV5nILSuVSeAMNc+WmFnbwmV?=
 =?us-ascii?Q?StdJsJ2ZbiWuuQkuwEFAn8T3O3BT7JIfKh5NITQW21B3b04XB3RxxaDj+Lj7?=
 =?us-ascii?Q?LBzfvXQb+dxe6V1YthAeTER+HQ+IEW2OMThsKEOW8Uh56h4h2AMOgf7Qzl2V?=
 =?us-ascii?Q?HTZSgRt3c/7HhEuZSnB8g9DjlHhgzoe89PsUui3SQzMi0kGp3zal/jX8cYu9?=
 =?us-ascii?Q?nRVVPDdKoq8UcDKs3iANqmkWKytA8Q4z4AMpfvGE/1/SXXy1YxGox5ziIQKw?=
 =?us-ascii?Q?JcQwYy90KZd5wVkYnntDm4KVumZQQn4dvzaiaSYz4NICOsk7O1ukcJqWJX4T?=
 =?us-ascii?Q?+xDdq2DbhBF4i4dnC+IEsbRd/EyhjC/yNZxtGuxapMW5FcmXOrMEIctJPy9y?=
 =?us-ascii?Q?g1kTOogosy66+7c7vwfJgQmUue/yLubmPhPgYLJejeYfWrmfhdYOwZ4MBJIn?=
 =?us-ascii?Q?KOH1mxZfIqXIrxGxy5zZ2E9RY8UAi1vQES2O8JIgsG2L+BislFitkMQtbhCV?=
 =?us-ascii?Q?BoJPKZS6/e0nG9fzJw8F5WZKxi6eY5y4Tb8W5yRTlVS5b6OLFFh2n5lgaVai?=
 =?us-ascii?Q?AHsRIVYFSIeWPw8I68vtkoElf1h346/T39/215s95+HxGJvWVdps+WBMzr0Z?=
 =?us-ascii?Q?GmehzDYvjDcP770GWyZI0G2IojFcJA77Mmx3SK/u3K2iPcoPUpek672HXOlX?=
 =?us-ascii?Q?ukHxchNE0tN0YW6jo4kjm3Gk+6GiGe+53NqGw8QFfNOldvYlARNcfzPMTM7J?=
 =?us-ascii?Q?85zueZPDDTRdanvNOXR6B4AXzB5pTu2h94wFDKRlGDfMmAzqFsc7CY0UnLPa?=
 =?us-ascii?Q?ipPPDBfifWCbGNka9t+Y3O63fuviskx1uLxONk7EsuHGAOSA9Sb0bgAZrjwN?=
 =?us-ascii?Q?3vlniWfOtpldirCocQNqqp8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47cc8e1-2f78-484b-161f-08d9db0e7126
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:42:12.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ4K8bKWJaTyFagFPPG8EM9uMqZj4e2W9p311BDZC+wle03li1aPdbaJkWBvXT94Jx8u7KBC8nlEI3/bDuaKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3225

This patch added the invert bytes check for the output data in
check_transfer().

Instead of the file mismatch error:

  [ FAIL ] file received by server does not match (in, out):
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.9xpM6Paivv
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.wnz1Yp4u7Z
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER

Print out the inverted bytes like this:

  file received by server has inverted byte at 7454789
  file received by server has inverted byte at 7454790
  file received by server has inverted byte at 7454791
  file received by server has inverted byte at 7454792

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v3:
 - add the check_invert flag, do the invert bytes check only when this flag
 is set.
 - use 0xff directly.
 - update the output log.
=20
v2:
 - instead of adding a new function is_invert, add the invert bytes
   check in check_transfer().
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2be3cad4b52b..4f8ee8a9a8f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ timeout_test=3D$((timeout_poll * 2 + 1))
 mptcp_connect=3D""
 capture=3D0
 checksum=3D0
+check_invert=3D0
 do_all_tests=3D1
=20
 TEST_COUNT=3D0
@@ -58,6 +59,8 @@ init()
 		fi
 	done
=20
+	check_invert=3D0
+
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
@@ -193,15 +196,21 @@ check_transfer()
 	out=3D$2
 	what=3D$3
=20
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-		ret=3D1
+	cmp -l "$in" "$out" | while read line; do
+		local arr=3D($line)
=20
-		return 1
-	fi
+		let sum=3D0${arr[1]}+0${arr[2]}
+		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
+			echo "[ FAIL ] $what does not match (in, out):"
+			print_file_err "$in"
+			print_file_err "$out"
+			ret=3D1
+
+			return 1
+		else
+			echo "$what has inverted byte at ${arr[0]}"
+		fi
+	done
=20
 	return 0
 }
--=20
2.31.1

