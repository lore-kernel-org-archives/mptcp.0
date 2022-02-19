Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DA57D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzwoyUlrTCNgwRpmAoTgdK8CtpMZ7TRst8d0VsivqJM=;
	b=MF9ncjABOd/7t4QfFeEeOJ/b2Ca0ON7xBFqW/150JI0ditBXLhiERG1HFFY8rCOQ6AwRVe
	rmFsVGjYsVoIdRyMi2lUPNIctiMwCLAIYb0Mr3ElVeE18fNMnb5IGqQzUBD+CK3caSWRe4
	zrsZgrW93VwUGH+0fLgwMsoJuL1Yilw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-HD264u7mPTKvDo8FuMLX3Q-1; Sun, 20 Feb 2022 00:21:42 +0100
X-MC-Unique: HD264u7mPTKvDo8FuMLX3Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kudE8We76Ts3OaC6jFDIegUbwM6ZQJIFhm8kYns7OPP5VQHv3AFnKuIm6DAWzqF60Kq+5SFej2ZfdMbAnlkV35DaYiS6jQ+RGkmq/yDY40og9E2zlTw2l49TmuT7i7AX+8Lb1WcjfSz2cNf9xIGWaO6y7qKpdYsyE3C4YTe5+bsXg+d0GZQauWu5nkC2v9rWnjX6Icqq4NmzP0wTk28pl5Swv3DHfdP/eGAzVEkW+0RCEYH+RlYwHCIEVXLALwc1oWL+kxASMY+VkSf8JZ7McAPu6p1ybXe1Z10J1+iR9wQ6S8tQg5ZR1qtWtGKZn5ZuGrt4vZrb4MJhzz2HGSRU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jM3MBWbbGoYH7Z9+mX7s0PK6V5kNmwNiJpVickdZ90=;
 b=C2lYAMZ/ieHvdLflAKB+4WYxvDTQBQowlcinOgti6hs19LBHG+IRKk3LBMIHLQKVR/khKkkAttFBboQkt4O27O0Rx7TGYW+PuNxs9IPIdg5PL6T1CydEd1C1ZR9cq4d2iVJZQD1YMTP5dp0MdbFelqUQPN0fn7UqaLQ8AlxHh/yP2ObMQNVGmZW956/5DMMR1YD4e9dZJYrUt0d5qGRjWT1s5Fv4w0t7w+gdm9EpytTeF9lpl/OXvJCj33fSTzubreUPNImXWEo/wvme17YRdLCHw27umlCHT+5jrrZaZx9Bc4Uc0DSUdxL1FZxCz5ov3i7OgKdM/TPJLICw9pdvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:21:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 16/19] selftests: mptcp: add more arguments for chk_join_nr
Date: Sun, 20 Feb 2022 07:21:31 +0800
Message-ID: <7ef5338fe9c9720c8074c37f65d30a517e69a1d2.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa55689-0e27-49cf-9913-08d9f3fe95c4
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB88126C94B3E168966E8CD718F8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iVcmjrlGeyDzCG1Mzxvqd3M0UEMsjOPC+17tkQOvAoDwt2T8Pi37axMEAAdKIvClzdOBYsU5MSScsYTDz/b7N74aKFoFvxw6SC/010fOHHkd18H9tHArSrYlosxEeb9ep7VUL4PrDVMl0x6EYEoiP8Uxb1ccnXGTsHRYwg1GQcWf9KWC2SKUg7wiSV30fKZqL1W/TUqI2S7IKKp+rb+qNNrt/tmG2datC0ARFRrFaR6jjK5OYaSEXyF+LHVFq3wIQFVakKyOIjK3PodjXKvjzSGR32p0RxaUYFFbLS4kwb71lL/0iGtrqeX7NnT+52YwC12ovGIepUV/SIN6xhHZITlsHI5gmvjlSJ/xHkrPKnceG3Idg/kanMJFRDncswy8OsF8m8YBnaCjzENNqe8r8/EhyCESGw/CW5xmlwo9XdGhy5zRspyC1FSFEG/ZTFEmR2nfAI+64FJn+2m96Y9ZEtKks3CzBJ3tCbxuYeiOyEfb7xlpY5HcGvbrHG3RX5RHLLHUd1keHVHVrGEAq5cnxJZ07cS29TlzmPeM98cCT/RXuY8wtRsE7rNc/PSFfmBEJRNJ67JIbORGYPhZleIjEYlv/XX+c91qyAn9WUPzQ9F0YL9R1OjaQpJEmyl5vMEiaeVzbtsTjFapbTTLuOov1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(54906003)(186003)(8936002)(508600001)(6666004)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uy2kIJJdlcR8fPZCYAV3sHiOEPyAb3vIJpJBFY6j1fb4VOGMQSJm9wz4NdLK?=
 =?us-ascii?Q?vZ+85heD0Tdu+1kGX0MbeukOijaJAemcigsiJtU28XUa+zhiem2756kHd9Wc?=
 =?us-ascii?Q?EB2J+rWxOQYyGi+e2ZtN/glXMVr87BbBorxMzz0rN3J3jzehwltFkNMJ+dx5?=
 =?us-ascii?Q?4gy0vyRCVUYJh0VfvqfMv5hq4pFNEGKxGnxd68bJ9r6f1qaQX0UkgkukmDkx?=
 =?us-ascii?Q?PmXb8/X1N58ZewjnlQ4PeQOwQHL5CVGOiLeUdYeBkLf0i6+4vz2NMQxpNPaK?=
 =?us-ascii?Q?dKxR5418I+SU7vwLIepazHw9TZNBeyEVsQ3WIr+agb5g0GBfcUULZhNI64JZ?=
 =?us-ascii?Q?5GqmscN3of1VKCR++G/yhe4mZsI1NUAbENiiwMGdseYgXG6gamJ++fJ8nXqO?=
 =?us-ascii?Q?w+Zh0wwAjgoEG4/y/pHhel7W5+E7rejsbfNpHiu9jmH8/021IB057YGHSYiH?=
 =?us-ascii?Q?3rw722kYL6YExfJORtoi0JlF3jNDJOPW2kEdMOvqQc9yHQyKp6snWQ/kWxlZ?=
 =?us-ascii?Q?rmpN9FZXeX3W1M7xGtM1C3cryfGlQbiKtUFSW8ZCqWn03PJNZ10LxhUF+shU?=
 =?us-ascii?Q?bJCYlaJhUlR/pIe8sk6XBTPDtDGU/vzSR8heXk4xx9K2XPza1Ayf/Z05RRzh?=
 =?us-ascii?Q?HZySGKQTclwwDhAgZQPytflVQyYS4TxrvhkAy8rwLGP2qo4DhW7HUhMhXPYS?=
 =?us-ascii?Q?2o4WPMAyaddyB6zz4KCfensMepJiO/1xbTGrseCFXJfx8h8TGItA7i3wWPnr?=
 =?us-ascii?Q?cmmGU+JVz3qxI0fITdVUUw4hNFG/sVWZ+LXNEWVxPudYoJP+/eUX+2Q863gQ?=
 =?us-ascii?Q?+sdLKthb/qCdOdXI4qmS8o7WYUieCTA8vkzejDiqzkeI0qig5eZB2VdeSt4K?=
 =?us-ascii?Q?Nno7zBgrGINltSopYhx3ToVpW5oKrUzKWU9xG0R3QFkWBOBUZxSvXXr/jQDt?=
 =?us-ascii?Q?Sca+npXQTM8wgDAMF6qzc9X06vhOYnloAa0HZStS6G7YyjPQWG02ZejBxNTn?=
 =?us-ascii?Q?LbtEsE4y9CT+nsS7HBM9MAU5zSl+TXF3LPlDb9k/38yEgk7I9a8CN9j9Tnf8?=
 =?us-ascii?Q?e6NzJwoF9aKu4MiMJaDxu+RpeuJB/ORdiMDtuzuKk0H4GVqpqYxqlvUVZfVn?=
 =?us-ascii?Q?dmfmQEqvVWrydKLrk9k+60BVhiWgutcgT+SDeko8hFuPSPhf+i03gQG6951I?=
 =?us-ascii?Q?2W2MtQAPra2xf68faxRarty2qhJkpfSrHnq+Pd/q8aN/fMR8A4BjksuJZe5B?=
 =?us-ascii?Q?JUFfZDRAgS71l9/1AMmP+XC9ElJMTblUvKIUzP0724WGRgPz1H2IkDAhEYNH?=
 =?us-ascii?Q?iqcqHvnZPPKWIz+Mh3ZEjdCXh1AnmdOoSJqEDCpDG59OdMguLyLxuPJ0k7TI?=
 =?us-ascii?Q?wO4zxynQS+lw5vZdrmP9picL3uvNMnJnq+AVNORFPAEjj1U1276oBhBRUyws?=
 =?us-ascii?Q?TMm//w0RSA9GV/W1gPg4o4fvb2TC74EeZqUvmSCj3jNIKrYwgGPuwJu/BihR?=
 =?us-ascii?Q?RuiHUwnzu9IUaZYcijdL6U/oLLCtOynYxw5x7AldOlzda8OvZ5ZJ9riWGyJ/?=
 =?us-ascii?Q?7ondLorpAFvl7n7SqgzWG2pkkkqATDRtLK24ABltvUcGTOhZri1FbWM1n3NM?=
 =?us-ascii?Q?qmfm0/W2ivg1dkB49EwytfrE5noRJ0xGiDfpJXLdN/PEcJkanzwsql8JgN1f?=
 =?us-ascii?Q?rx0mdlQB86woqqC4nTBu7+IKiic=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa55689-0e27-49cf-9913-08d9f3fe95c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:41.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIwO93aCo9i6LxWuXwUYI6INA3zJQhc37GLtzXH9dHDfHo1fAT6T84AWEg/n+CoJnLezj0N0LQKLqggTOIE5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

This patch added five more arguments for chk_join_nr(). The default
values of them are all zero.

The first two, csum_ns1 and csum_ns1, are passed to chk_csum_nr(), to
check the mib counters of the checksum errors in ns1 and ns2. A '+'
can be added into this two arguments to represent that multiple
checksum errors are allowed when doing this check. For example,

        chk_csum_nr "" +2 +2

indicates that two or more checksum errors are allowed in both ns1 and
ns2.

The remaining three, fail_nr, rst_nr and infi_nr, are passed to
chk_fail_nr(), chk_rst_nr() and chk_infi_nr() respectively, to check
the sending and receiving mib counters of MP_FAIL, MP_RST and the
infinite map.

Also did some cleanups in chk_fail_nr(), renamed two local variables
and updated the output message.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8ceec91933b9..310988a8acb2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -828,8 +828,21 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=3D${1:-""}
+	local csum_ns1=3D${2:-0}
+	local csum_ns2=3D${3:-0}
 	local count
 	local dump_stats
+	local allow_multi_errors_ns1=3D0
+	local allow_multi_errors_ns2=3D0
+
+	if [[ "${csum_ns1}" =3D "+"* ]]; then
+		allow_multi_errors_ns1=3D1
+		csum_ns1=3D${csum_ns1:1}
+	fi
+	if [[ "${csum_ns2}" =3D "+"* ]]; then
+		allow_multi_errors_ns2=3D1
+		csum_ns2=3D${csum_ns2:1}
+	fi
=20
 	if [ ! -z "$msg" ]; then
 		printf "%03u" "$TEST_COUNT"
@@ -839,8 +852,9 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -849,8 +863,9 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" !=3D $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -861,27 +876,27 @@ chk_csum_nr()
=20
 chk_fail_nr()
 {
-	local mp_fail_nr_tx=3D$1
-	local mp_fail_nr_rx=3D$2
+	local fail_tx=3D$1
+	local fail_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_tx" ]; then
-		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
+	if [ "$count" !=3D "$fail_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - frx   "
+	echo -n " - failrx"
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pri=
nt $2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_fail_nr_rx" ]; then
-		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
+	if [ "$count" !=3D "$fail_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
@@ -1005,6 +1020,11 @@ chk_join_nr()
 	local syn_nr=3D$2
 	local syn_ack_nr=3D$3
 	local ack_nr=3D$4
+	local csum_ns1=3D${5:-0}
+	local csum_ns2=3D${6:-0}
+	local fail_nr=3D${7:-0}
+	local rst_nr=3D${8:-0}
+	local infi_nr=3D${9:-0}
 	local count
 	local dump_stats
 	local with_cookie
@@ -1051,10 +1071,10 @@ chk_join_nr()
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_rst_nr 0 0
-		chk_infi_nr 0 0
+		chk_csum_nr "" $csum_ns1 $csum_ns2
+		chk_fail_nr $fail_nr $fail_nr
+		chk_rst_nr $rst_nr $rst_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
=20
--=20
2.34.1

