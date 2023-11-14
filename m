Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B02612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ONU+KIZk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzJ2IXyqX+tGVqAY03FkKE1NjKi3fsOODRyZSLngLoz7j2qWCXhf9m1BDvPVrWYOr/KJ+BVFl+1IQeVSndo2ouZZuKnLpvw4LEOhf/UOGOPKUhvJPnf1AciwwZXGCARWlDSnaoNgca9RdYi7IKEs+OLaWo6wmdx+CpYp4f7h0+hPFj9yNSbLV9Am+MKn2uLUpun1y/pl4Vvidyn3p22xqkbDGHg3QJthoA/27rnVa9XF7XexZDFNr1yvqFXs5v9406Sgg3x+MbZ6Fhnca+kQBzKhx6Fq1iyl1BdRHO95kPwTvoQjiqoJI9hKysBWqgy3ITJpzD81QWow7XS/kIrD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBBbXCOOQu5+3k/n26jJWjP/um5xDWAf6WcCu4h0w00=;
 b=WOPISUIG5+kAtf+XrnLSGFKw8hUiASJj8cpZgFh4ELb1CcorSyd/8EHV6T4F+oZjWlQv830g8hF7ZLgFbnz/t9jF9qPPEjNdHuTF6uxiUEAdHtNMrKj85JwhwrcSQmwPNtBgkJhtgTPTqPYeeUipu69UgPBaNrI5M3QCYVsxVbX0LhulyWyBInrzQjLGzSVwYANXbRsRWL8de/8VO5QXcnmCsdLFevUft7o3bEWDD0UIo2DMfNUcOuM8MMY63QAUoCxsoqML1gr17jmUNP0lPVsQTyfNUJFyIRh4nhrx7gpNiHhTZi4mjGu+gPjaxtMrODUMEaJLi9i7LDKdZB0CUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBBbXCOOQu5+3k/n26jJWjP/um5xDWAf6WcCu4h0w00=;
 b=ONU+KIZkSwL9g5C17I6vOm/s7snXnSgJ2NxpkjAOHHdu7dJMRzCmNO56L8rBT6Tmc4+U3HGceixCFGqG0sufcMlal4hVE6wzX+LguQiat5Yi3kztMqPgcC8spIZvyYsWajeRj6+gdsvH1VxbOVYdLi4H0sH2Qfnd9SouGP4mpcToBFDXqFh9hoQ6cS9FUetNHtjLHucQP8qpwSM6x86qz8XMwC/IVhVQhFxjtTrNnbVO46ma02m41+0ips/E4JXvbZagyJ9qdMwsrt5Bn8yYWbXkmcs6thMQvfyquplNkFur8DHyvZUhbGYdgOseX/2jTG6ze+QMR232KKeoxpF+uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 32/32] selftests: mptcp: netlink: fix positions of newline
Date: Tue, 14 Nov 2023 14:35:51 +0800
Message-Id: <ca367088011bb2ea945d7aa90d67ed3e165370c7.1699943338.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cd0b41-ffc0-4215-91c5-08dbe4dccc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J612X/RbRSIo+naoMfys3UFeUIGFE9iGyBdz3pzhPuWGOCE1/3YpmxYjlohih5ads2FA4MVeBjlICiJ4y/W6IeIBwKhU7r/l87oUb1ViedteRg/msCB0SZd4j3QBYsLR/C6xBg4YTFmUBmMyAynmq7KTLhBFIz61vPiSLY+E/xraq3LkCR2gTdY2FVguzHmpFoX++3im1/1ZX8S7RNhRrqruLITYLAjQeHTjVEMT4ivS6pKVInI1wTARqdnET/SplnW+81D21srUNFdkWbg7ry9g1ezwlrZ6MzPxY4uXK0JKQo78mk7YXtWyBIOUYeoPQSA+aiPHuvViNpzJRHcNMJ/uLqqsmnGduP2Gyc2gyidoF24jG6OM3TlAGpyNX+zbbotZtbF6SdyrRldM85tAx8nkVViQ/WgXZyzvh0sCoG6vh1NoMji2nlpC71fuDoQ/8aLOSTuBVQDJuVGpbnDOJarnEvrFEQgp2Gf+Yh3SSBbuhtJUEbyMvm6EQHbZcj5uoDUQx0E5vUXUmiXHaooLAPlUcGxEXZqJVX8XMSTzcJUW28XE0ZdZoTZcmO/dQjQu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2A0GsxnJWpx9FQDg2C4iCQeceuXuvToWjxiAkRMJKlsfWVNpHE9fufZEVgWN?=
 =?us-ascii?Q?/13pPUm2Fv1LwHv896Pw5RVQnQxz9FXiJVEw1SRHw+tODl3yobJSeflmV96Y?=
 =?us-ascii?Q?6ARhvWboC4FOu5flW9OfF6JBVHdhmPHZwPRrIKTZD7hdDrCwk68ob1k2GDy6?=
 =?us-ascii?Q?fLqr0/bKspi1zRIF517SziHkS18oe4ejPU5X9PB0n6YAgo70Z3aD1QrVlhEU?=
 =?us-ascii?Q?0idLiplheas0NUkrp5te1zjfchXOHr4fj0YjGI+i3m8OQ/chPJ7L4PAqwHJa?=
 =?us-ascii?Q?kliFNUsxvWyChqLIjqRMJjzdp7/GD4EViyVqIzfIRzWB3jkkRbPPd9NuNRHT?=
 =?us-ascii?Q?Y6TPJNGp75FFiwfhr3XKI5BNUQxbTMuGh+/M9rtJEmZHoKcRsMcZ/mwfjnRa?=
 =?us-ascii?Q?jKbwi+3qxQDP4iKuU2uVq9SzybHwKSFIV6BU/2FDuaCOqoi3RCVHuJhJ6OCr?=
 =?us-ascii?Q?AeQcZmEMCc8G6kECjua3cKbLpwy2pLE14HHAQI8KT9Z3c9q5fIk8bUYHmNPC?=
 =?us-ascii?Q?ajY/mUXDbZDmDvJHvec61MOaD0olglVlG8gFH0xzXUK0OS4twvmjZy+0xp2L?=
 =?us-ascii?Q?UoN79AXG6vLeYj6l+plJlsYLa/XigieTyoUaJikt+u2dNef5JQXElkTOmUPJ?=
 =?us-ascii?Q?rRieMAYsQX81QCm7TEgqxod27DSUnmswIroeRnkQNJtKFubIHXneqG26UB1h?=
 =?us-ascii?Q?+9IVcztstcSL1/23xgwj8NSyA9WwP0JYI8ZSrW6LiBVbdzJjqxKw+NYMjW6g?=
 =?us-ascii?Q?b//pglVykTbtBcgoGVNQWJoRaCh5TomPJJxZCs4qQ5qYaiFHLJOtyGT9ou53?=
 =?us-ascii?Q?Ih1uw7Irk0xV/SKuYeDmjqlHtaJeX0zVgEJbCgKFIxHdHqqmTZhkFObLPvWW?=
 =?us-ascii?Q?8OcUAg0sY8/aeNuSTShMafsltT1Hsy4RssyuD9Tf/KvJaCIHmSixzNnzn9YS?=
 =?us-ascii?Q?1uyTR/jdkVGnSDaL/pC6HBARXeYcVKrLuyneRBO1/GgTocM8nfd1AllJP1nU?=
 =?us-ascii?Q?/gv2JJUGX+pRBWSqfIUpeLe5i20P2TD/bdqQcBIhB2n40yYxnf8BpMdL4XLi?=
 =?us-ascii?Q?eVOoZ4SNNRtU3RfqTOWYlVwrTJLY5Rnk/pv6GNrMVi5UviSfYo2Ju85RT77/?=
 =?us-ascii?Q?zlcV790SmatcCu9o8ojIY2Fx/Eaqup2MO/Or2xmiTxGoPEVxBIgYc/h0F52k?=
 =?us-ascii?Q?TZWRYcXvizTUO8dKwUcduXD2aMX637wn/cgMWSSvzzgVsTiKlE7ewSgN1nHA?=
 =?us-ascii?Q?z4xhaGtxnd+rFHESxcVbv+25jUxs8rsZxfjGolWMbGxcte/hubT+ohG3SO6+?=
 =?us-ascii?Q?mF0PgJclW9wwDAz4n86PgQBtQnCGqYyNidX24R3uQjcDwncvRT2U1crlUrvZ?=
 =?us-ascii?Q?VooGyVjMW55OzWF2aTcvSfCs3Bv/7d7Xe14lx0MvY8h8ZQRR4MRi4T2A/p6U?=
 =?us-ascii?Q?X+0l+dZuCHc4Jcpf8+li19Ti/ZvNY60ji4/I3WCSy8qDT8+UQtUV1/MsIwrg?=
 =?us-ascii?Q?fHq30mEVNcDPjLWXv7DBFZ6wvz5vt3wvSigeVmkCq75R0kNIOfozNGdg0Ro1?=
 =?us-ascii?Q?Yc5OSwysM4Z+y56BhRNJ3IM7eVYdHSk7L4Zy5Qj7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cd0b41-ffc0-4215-91c5-08dbe4dccc6a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:57.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSc9HWrWwsIL69c3X1PZrRllRrcIR4QCAv0r3/ybNh0RucFquWTK1s6QJgXCyv8D1MHwkDscdDDPTmRpxyJOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Some positions of the new line are arranged a bit strangely.

For example, the output 'pm_nl_ctl limits':

                                                     "accept 0
subflows 2" "defaults limits"

This one can be refactored using $'...\n...':

        $'accept 0\nsubflows 2' "defaults limits"

For longer output results, such as the output 'pm_nl_ctl dump':

                                        "id 1 flags  10.0.1.1
id 3 flags signal,backup 10.0.1.3
id 4 flags signal 10.0.1.4
id 5 flags signal 10.0.1.5
id 6 flags signal 10.0.1.6
id 7 flags signal 10.0.1.7
id 8 flags signal 10.0.1.8" "id limit"

This one can be refactored using "$(printf '%s\n' "..." "...")":

        "$(printf '%s\n' "id 1 flags  10.0.1.1" \
        "id 3 flags signal,backup 10.0.1.3" \
        "id 4 flags signal 10.0.1.4" "id 5 flags signal 10.0.1.5" \
        "id 6 flags signal 10.0.1.6" \
        "id 7 flags signal 10.0.1.7" "id 8 flags signal 10.0.1.8")" \
        "id limit"

This patch uses such methods to rearrange the outputs into different lines.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 79 +++++++++----------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d68353c18996..1f2e9145fd77 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -61,8 +61,8 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
 default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "defaults limits"
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+		$'accept 0\nsubflows 2' "defaults limits"
 fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
@@ -71,15 +71,14 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
 check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3" "dump addrs"
+    $'id 1 flags  10.0.1.1\nid 2 flags subflow dev lo 10.0.1.2\nid 3 flags signal,backup 10.0.1.3' \
+    "dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
 check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
+	$'id 1 flags  10.0.1.1\nid 3 flags signal,backup 10.0.1.3' \
+	"dump addrs after del"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
@@ -98,13 +97,11 @@ for i in `seq 10 255`; do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3
-id 4 flags signal 10.0.1.4
-id 5 flags signal 10.0.1.5
-id 6 flags signal 10.0.1.6
-id 7 flags signal 10.0.1.7
-id 8 flags signal 10.0.1.8" "id limit"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(printf '%s\n' "id 1 flags  10.0.1.1" "id 3 flags signal,backup 10.0.1.3" \
+	"id 4 flags signal 10.0.1.4" "id 5 flags signal 10.0.1.5" "id 6 flags signal 10.0.1.6" \
+	"id 7 flags signal 10.0.1.7" "id 8 flags signal 10.0.1.8")" \
+	"id limit"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
@@ -116,8 +113,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-subflows 8" "set limits"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" $'accept 8\nsubflows 8' "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
@@ -128,14 +124,11 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 2 flags  10.0.1.2
-id 3 flags  10.0.1.7
-id 4 flags  10.0.1.8
-id 100 flags  10.0.1.3
-id 101 flags  10.0.1.4
-id 254 flags  10.0.1.5
-id 255 flags  10.0.1.6" "set ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(printf '%s\n' "id 1 flags  10.0.1.1" "id 2 flags  10.0.1.2" "id 3 flags  10.0.1.7" \
+	"id 4 flags  10.0.1.8" "id 100 flags  10.0.1.3" "id 101 flags  10.0.1.4" \
+	"id 254 flags  10.0.1.5" "id 255 flags  10.0.1.6")" \
+	"set ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
@@ -146,36 +139,38 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.0.1
-id 2 flags  10.0.0.4
-id 3 flags  10.0.0.6
-id 4 flags  10.0.0.7
-id 5 flags  10.0.0.8
-id 253 flags  10.0.0.5
-id 254 flags  10.0.0.2
-id 255 flags  10.0.0.3" "wrap-around ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(printf '%s\n' "id 1 flags  10.0.0.1" "id 2 flags  10.0.0.4" "id 3 flags  10.0.0.6" \
+	"id 4 flags  10.0.0.7" "id 5 flags  10.0.0.8" "id 253 flags  10.0.0.5" \
+	"id 254 flags  10.0.0.2" "id 255 flags  10.0.0.3")" \
+	"wrap-around ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup 10.0.1.1" "set flags (backup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"id 1 flags subflow,backup 10.0.1.1" \
+	"set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nobackup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"id 1 flags subflow 10.0.1.1" \
+	"          (nobackup)"
 
 # fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,fullmesh 10.0.1.1" "          (fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"id 1 flags subflow,fullmesh 10.0.1.1" \
+		"          (fullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nofullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"id 1 flags subflow 10.0.1.1" \
+		"          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"id 1 flags subflow,backup,fullmesh 10.0.1.1" \
+		"          (backup,fullmesh)"
 fi
 
 mptcp_lib_result_print_all_tap
-- 
2.35.3

