Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BA7A
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 23:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645659274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ot7EwqNsyIakmkT2Qfu8PWM4gdZTvpsBBU9epC6DyrE=;
	b=KXpSAZGcH3e0SZ7Ef51FRmP2kyPKWvebD9zPQt1DRJnGcLbw9054+QZrMQ4dzqStGvZXBq
	XINBlrtOMH1eUOv3+EX+LvO7z98cFBXBZ8oCT6r5d7QYk3Gy3DB01T34HEbFhstJR/7aU0
	kjyCrcNa64k2x7BYm4s8Z8JtabU5FtI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-Pk4-da-oOjiBGNBQkhhw5Q-1; Thu, 24 Feb 2022 00:34:33 +0100
X-MC-Unique: Pk4-da-oOjiBGNBQkhhw5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhaZIHULPc/W+vxSVFDeJwP8p3sY/gPe68wBTfkugwDRnKTYKtWktgTR9Van1KpuUa/8Hu8R5tBLGUUCqyXXZuIKHDwPbnnVHT2/gr5x8ZdHUOH8aPVzJV0H06MwkrLI+hI7Yw2S0NP2LzYuABr3aBufur3PY9cDXSiTwXxaK4/3mXkfabxAk1ngwwu3VWlSSq3zmgKBsv5jc/K9XDBHK/5kFlC2OEsfPKllJ8ZK5waEwNl7zjtLCwrSF855Dw1djNI/Tn6qqTxvLZrKqC8E0/BZk3tQkbw3Agg0tVG5/t7cvdBJN25pfcjd2kZ3/G0MKuJixx44imigJPw3NdY29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QKpUfwPM6oc7+chn9cxHhJMn6KGNugGKHoGldNXTR8=;
 b=mpQ/he6BU/RfECYxP4MxxlhlT2WedSsFVjyxEbXzRoRJeMc/ttUyixjOrV/sLXhsHq8ohMaJiFO+ACqf0cpH5ZahhAqJyBV7+V6sWph3DyTKGfaworKKbbeT7AxwQ4mv9XrmYldr+ApespkOdPMC5ZVwEgl2FJC9WSf5deHmMfiuvEuBkdXzytS6Iwh1HpxfbPzl2FvPof39kKNDuhG4XiNj8W5BGwDll4NIHm7jPgntqpgI8MBd7iog7Hiog7DZ6zobw1ehjsng6QAIltne4bFv1aFRKFmiQqD1JOhNY/Ha5Tejhk9OlFPa9cPGH0AgYrDSfB6uNhXUmUEhSoj6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6316.eurprd04.prod.outlook.com (2603:10a6:10:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Wed, 23 Feb
 2022 23:34:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 23 Feb 2022
 23:34:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add the MP_FASTCLOSE mibs check"
Date: Thu, 24 Feb 2022 07:35:03 +0800
Message-ID: <981a7ec4e8d14bffba4d4251d491ff70fb2eeba3.1645658270.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4a3bf8c-385a-4bb6-b6c9-08d9f7250ab9
X-MS-TrafficTypeDiagnostic: DBBPR04MB6316:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB6316DAE63BF27CAD40B2D82CF83C9@DBBPR04MB6316.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XF6x+oVhDY5qCEXB1LGKEDg947JHcPXnPa66XZcBASbPUxx8ppGFIeM6GMfVCYElYwzv+XFuFjlKlkf6n05FpY6JvJSxWXj3nBZoN58sNqh+hA98gRR4HgjMIwrEvJrZvVRUjiE/u2dPUkaI08niKkEk+O/cGn0PZgsS7RQI0DFQuK+JH6cUHGbZJWzSINRXNrgyM/182EmTLzLkcngznKxyLTX5TMlvnVVpXyO/h9c4G7Vh0DmmNoz/6fU5bFJ3RRtfj6dNvG0inP8Bmt4VmzUkOhBQa8/GPMk2GTn6xe+F0MYaBcs7w17AAlnN0NGwBj4VK9D6E5fs+OwSKHCmt8HmZCQ2dvUNYEOU1YYsfxaQIPpjbkAg4v+KAa3/9Z6wLvIBFwHe867lgzRLqicPxT1wUgh6uUjIiOrCafOefHak2ZBalSxAHyawhINZ8d44jV7fHYoKy9/b22bL2MBzmYbp8+1nJRhSPcf9Qi+uim624KHHsWPr3NlVcxC+aHguDbb5U8KVwhgT/hslBLTUi3XbcGaExuCRu5y7CkjlyLnNofU6hml0EwXCSupRwgCpNcvZThY9FT91y0CIrhYdSN7QJfBr5PXWRkVjjf4XSSkatarLjRigxoYgsZ4q4DPs545Vhf1LfndC/HxhBkLk/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(66476007)(66946007)(6916009)(36756003)(38100700002)(316002)(83380400001)(6486002)(6666004)(186003)(107886003)(8676002)(2906002)(6506007)(44832011)(2616005)(8936002)(66556008)(6512007)(5660300002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGMIO7fPPPg/3QuvzqbzTRH+gPzIcZJtMFQjawuLYJkfcawXwasCEsrn82My?=
 =?us-ascii?Q?yEDGqZXDGExNJrvqmQ9ZBzj5UkLi0GPD7Jpd200s1xTSoAi6aNvibKA/PyHJ?=
 =?us-ascii?Q?45c8cPe7n59iQ6RjLAZ6k2tJgeLnvppCJtOYJbnb6Q0jrfHPsRCkGyDs5b8S?=
 =?us-ascii?Q?ngez140IBIFxS/NHXjoaG7XpnrFMw4oLb2c2bE/p9ppHv9Dfl9M14uGAQOwi?=
 =?us-ascii?Q?jD1vLXSIdeIYvsF+X0yP3WAdl715TO/39ugyOCWtNdSncNaTkqFKU/yrFXNs?=
 =?us-ascii?Q?FWOsZUW1rsswlxkTTh0nJvDPgEo65Qjrk7oiJNrwcL4fztwdyPrc9Bb3ebln?=
 =?us-ascii?Q?DRxOOtWo6F1yuakK737dOupSG5DRON4XrSrTOkdVHMa2OEV2GxVf16D3sD5F?=
 =?us-ascii?Q?b1d+l9C3qhvRfnLkWWpQHluN7R/PQoGa0cPBs9TJbq/ClOUtGx6MEetYb9k8?=
 =?us-ascii?Q?L/wvzJGJq7udCgwo0mAWSUloYZwxBW432BzuSJbPd3llt6GivzIfbAevNHde?=
 =?us-ascii?Q?7/BC7v/bYVOLSayNVmv9CRDPjwqMID3Ts5+4f4tLc6cMb1OecL6w8TTHMCSF?=
 =?us-ascii?Q?bj33qdSe6YEeTwfa9bUxEuZ2oSGFqxCeExkWyVAJUg1xNryXGAsTdqsZRakb?=
 =?us-ascii?Q?crqc/7AqiFcMA4cdrJGqn+YWivXtKsriZ2354Oj3FR69/310v1b7F6Py1l3j?=
 =?us-ascii?Q?jzY+2tRAb3yWOyVhcS6Y0+9zG6kmhJvnnZctKWh4NrPg8LxFkXqs/g+0WVVE?=
 =?us-ascii?Q?OnJ94P43TI32kKUnfH62w7F47HpvAcADIdoBGW8aeIq1aZqcGAX2JCDlvjN8?=
 =?us-ascii?Q?lKMdjcFFas2SanJif10W3e0rBxoKAJUecAmrXM9U3Kcm8pst7Wk2joNExZKA?=
 =?us-ascii?Q?x2fzq58KHPmVvmtxCSD8hmzy/OnL8B7eLownnPSHoYA50O3cHD4i/5kznnvm?=
 =?us-ascii?Q?HOr7JT471kRB4L7dlSdkVlkLKVVNAQZm90RA8f2LxjHsUWZY1hoknVHqUbUJ?=
 =?us-ascii?Q?1vBHBF+mmFSPS1MCV5azmOelitRxMnfnUfBnHMFh5pHsGRWEzT8hhB+TfwuT?=
 =?us-ascii?Q?l4uNwA3PCJdTfpaPMkinnkXTMk0LxKJrsoHEOnkgOmQbu11OS1+phKnnQqnr?=
 =?us-ascii?Q?jd/D16sPtWt+lQ4CPoCsAv/IMy9fRNFSZQFzTx/FcP2Kqx5cqFXBp3YtxRZi?=
 =?us-ascii?Q?QEYjUzrXCPmLup8yIiUokAi9DdsIsH6tSA/fF9JkQqCAcb6jmPD8x98joxSX?=
 =?us-ascii?Q?6waNRQAFtIt63UWx3ZFKHeKo5Z+8Ks5jmjNjF/6qKb1vtS8XQkJgt0oQKR5F?=
 =?us-ascii?Q?EKp/fzqkbRD+kkOupHysP0KbQpGetn79C8VJhFbkPsO8i1RuYUxiwP1PA3jN?=
 =?us-ascii?Q?ni7vXb60ZaMLuKQ5mJtyYAlEhS7heIliCZ+K3At9p0NPJ/ic1NEg4H9TNyx8?=
 =?us-ascii?Q?JvOHIDRm/uRM9t0rJGvgdtIcHhXDvVIAFMOVq6hzR4qWbqrOgNPIVRENm63H?=
 =?us-ascii?Q?jx8xG5FoZQ2pCLjUV1SnhPOvkP76QQnPkv3KsN5a/np6/JPXdryvSK3CqV7k?=
 =?us-ascii?Q?IZajTvJPj5Mrx1em3ZqLzhnaLwRMe/n/nn0fcr9gnyW2+JxVAHc2kVAqZUnf?=
 =?us-ascii?Q?ktdhIOa3+UGcWAoNlpMSqmBE6ITg7/0KqPYTEfJl4e8xkz9N3Y/ltQQia9Wo?=
 =?us-ascii?Q?Ll9HuNNMYcud4Ou+eSCSJlGq1Yk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a3bf8c-385a-4bb6-b6c9-08d9f7250ab9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 23:34:31.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6h8XEtc7U1KHV7I/cMgnXldKYIx4XhkGtDU2xDu3+bVWsDrUHAF0MMK3uEJ6vtMmP6GYVuFU3OOH80JvrhCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6316

This following code appeared in another commit "selftests: mptcp: add infin=
ite map
mibs check":

        echo -n " - fclzrx"
-       count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx =
| awk '{print $2}'`
+       count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx=
 | awk '{print $2}')
        [ -z "$count" ] && count=3D0
        if [ "$count" !=3D "$fclose_rx" ]; then
                echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose=
_rx"

It's better to squash it here. With this patch, it will be dropped from the=
 commit
"selftests: mptcp: add infinite map mibs check" automatically.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 7d414cff02a0..10339a796325 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -800,7 +800,7 @@ chk_fclose_nr()
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "ctx"
-	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk =
'{print $2}'`
+	count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk=
 '{print $2}')
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$fclose_tx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
@@ -811,7 +811,7 @@ chk_fclose_nr()
 	fi
=20
 	echo -n " - fclzrx"
-	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk =
'{print $2}'`
+	count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk=
 '{print $2}')
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$fclose_rx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
--=20
2.34.1

