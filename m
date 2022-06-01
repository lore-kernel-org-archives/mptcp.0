Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED67362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654066007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8f+4XaAKXCEVzNrHfOgZ3WGwRnp5QJcgFv5d2aSZSTI=;
	b=H6Zv3JhpCdv58lqLgIhKwQo2H7C97gV/oIdu7RAJz8UiK67WHWYNAn8VA82HjF757UeGJq
	qmwTcKnmfoKWNQXvncez1jdufD13uOOV/5jQ+nF80sxPDCK8AWRi7O5F57rgt4+qpoN7yS
	a4eS/ZgjZiALXFYDiA2wUgMxzxsPdIE=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-7GY6y4osPjyw9H2DT8-iWw-1; Wed, 01 Jun 2022 08:46:47 +0200
X-MC-Unique: 7GY6y4osPjyw9H2DT8-iWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvw3cysRH/uY6zqQyh5phcNdsfKfcvlfQGPPsjy+RwmdK+bbMDl1gZ3pTOvI25j7XJbJI4WEabIq4flMff+6lOzMqcHS5ifjbFwpr+I2xqU/g+iCKyaBz1FoQi+4fq74Lnmqgj/9KL5CXPxEA45OX5wK6DvMBXzifDBLJtaIEvjzvHOLCj4BGwCaf1yXJxodKHIakR6mx3wsM+53OcuTxvVEaaQpDtaUwd9d6ttOHkuFPUHE42ng6vEyp7qE6Q6Fa6crZvnLCl37iaRi0CZb2pyxvC/qkfQoZY6wZsGkdZ8qHnuPali3jTgQha+sAtonnqvdOidzmHR1SahQ/miMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWWBXfE9Oud3pGkvt5TJqbjmg/QtC82bQ+7zljHrWX8=;
 b=jOZFsYMVADBYqJUUWdE0Qdx/yGWcHO/la89r+XcqU9wdr9Y4txOokfWn+ZB3+7hDTjPhxi5kvmNfCop3OwKWZ/t9WfZuiXe7JF07W5ZkDDVodXln+1xcSUwZcvlL9e4iIVHqilwuARoEba/jP1BVKm25r5uIbza3qSyBavgQFSJoL4vWY5c9hYLbw2fUZlg0GLYsDHTYyicWeJRtZJD6Tqd0vbM62418+IfT0zE8z5wL79RYskqaKK6bjXv9C1llHJMExLIe1o3BFVlxYL+X4rDKzudeTx/UELBUCGZMkwQgn+KT3/fatMeBaPSMqnt+P2jrkxUi2OAbVQbmqjhHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2434.eurprd04.prod.outlook.com (2603:10a6:203:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:46:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 06/11] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Wed,  1 Jun 2022 14:45:55 +0800
Message-ID: <e55bb59b25cb9562d04464a60939fa12f515f444.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c144f7f1-343a-4d33-3b7c-08da439a7e58
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2434:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB2434ACA19A15A36C760F4CCEF8DF9@AM5PR0401MB2434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S1Ol1PeBmdXsF37Pc5MeAHdvBhoSOBidl/9pwuT/ItXYj3ejSoU8me6Whxxdne8BT2GH7ddJp7jEAlUCFEPg5mn6Hop82nb1dfVKZjiZ0eHM8QPf7hinvUs2WNAI/ebD4aupKulaH5GpfDWvHpA/Wu3pkiVFg/YPaFdZWQ/O2I5Co1EGGbA2srBGyi0RQC7SjJ8h+dskSmVEx2VG+nc6x8uIfvYU1Vk5lpyoI6H7tI471K+7WoydFmCO0hA/t2zu5EhnQBfg+NGRQb4lq8qiGl3pVjO+ihwZ3mfwyM+kMa2BVaCs1J5qEpLCNe9/YTQQZ16tQegNmIHMzOoNe32iv/c7pDnAaojTyp5aALxx8D1QpiTiLnkOVoHxZmOG9dmrg/4suRv/3udMRj69VlOa15KGy+Moay52ygmTs5gB8A4QE6zyKyBTTJPiWO1VQhP+tiaah4nPp9oeI4ZAH+6AdAhpDC1jHN02AeyC4VNRlKImVvjzzGvIr7YxFOkFep7RdeFpaEM0yJsbsSMuwu62FjrixP4Bql++rLxD6uojL4VZTYnQVEiTucTj+gobeqQ2TCs6BODMP0QaMTnC/HggC0KrK2KZTNz/ycuewlXzBQfNIqGvI86vAVhR+grAnjlvoVwn7928UKa053WSeyiOZVhrcoD4QuesKnYMoIHjRCpjOuumLMvV538Lk3qgFaKJvm3+npxqxYFSxVOR7J00Ng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(44832011)(508600001)(6666004)(186003)(4744005)(6512007)(2616005)(107886003)(26005)(38100700002)(2906002)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(8676002)(4326008)(6916009)(316002)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DpL/Wp3L7+9QH2ScOAzWyb7K0peRW+/3vRXs12lqTyfdQC4KTrxdJRqbSR+?=
 =?us-ascii?Q?8ZEVNLvI5oXLFcjuD47k0HdC3E5zlu8+BHRqOnuSuJjaK4hgQOj6FlLLtnNr?=
 =?us-ascii?Q?fM30cZBy0gG690rCviiiA2uJWvGlHTh2riIkrfdq+50nsEpxZCS01yWguUYc?=
 =?us-ascii?Q?anmP5NGxP/dEeGFSnI+zKcAZcKahYcsq8ewmLp5WDR8NzdJ6nClwG/PHliRq?=
 =?us-ascii?Q?rC/1Q7WckugZBUlcYQKdZsKAgNFQGDENSXdUnMo1pCSXBRHSbT1br0PNkdO8?=
 =?us-ascii?Q?HvgHboNnOvqx5tQCpaDCDzcLJ4+qHfP3gzzGm7fjkREgFeRlv3e70zET/Cr1?=
 =?us-ascii?Q?YMVUWkhHtBEguyFaDDXR3pyOfX1ie9vHWydeIIX8vb01tqFeixjYnKX5b7/N?=
 =?us-ascii?Q?lTPsVF+NI2wI00n798sEYSSuwNIvnnL40zM3nZBOZUjzuGU6ajCDPDHsjQ5q?=
 =?us-ascii?Q?m00SYsqU/tLnuMKDM4t9PDkniMpPNNQR1ULp/29f/E22OrtQneN19OxnQ0ff?=
 =?us-ascii?Q?sqaZ0tUJ2q8biXFRN3kGxzL7aeekM6iJl0rZYuiP4vtw0pSyQMLHt04uotZN?=
 =?us-ascii?Q?tBW+LntvXGxvilNKY6McBdyLvfSVl033xgdO+pdVaCZcNWIQNYvZ8H5GOMuM?=
 =?us-ascii?Q?z7/coO5yZEIhQF8XIykTS8vVCauCl5bjF94WD2BIC9pTOKJtY0WG/xxQFjDm?=
 =?us-ascii?Q?CYtYzAd1bVz8SnDG3X85VkJFjTjVPIzCqIRWLLE9B5czOzZemBY5JaD5QSEJ?=
 =?us-ascii?Q?GNLDdXisNqP2BnW+QMzKUCo6ywidwcz+Lp0PB5WaOcQrKiACYR7oMHJByM47?=
 =?us-ascii?Q?uVnJ3bXmr4DuF6KltwqHXuAnvVhAXFVuSLbKXKjQWfe3TaxBJzkZvO2EF5Ob?=
 =?us-ascii?Q?piv58yeULiArVkEvbI3//oAe+JYcKJI6+lFrhacoamUQv2IwDxJabaEa/v2M?=
 =?us-ascii?Q?BiALUK00EzR4FHMGUfkSaOPYna+2/bwDQfqiaHnVs4nyWzdiKOQgWZYh2KZv?=
 =?us-ascii?Q?96bzW4JD84LRk35/P/YWQuYAgsfmFdkSxGOYQtw9cmO2X5veyKFNOZ53XFNQ?=
 =?us-ascii?Q?8/UYhSTz2GaTZ8LGweyFJtjJX9slgFc3cdY+/IvtzIhUeoT1JND0zKSOh+1v?=
 =?us-ascii?Q?tI7jUvv1QKwL21kSbnbOR4G47RyM8IMrC1Tse+fBP0RbeSL3XA+Vfhc7e16h?=
 =?us-ascii?Q?p70kAwTW7nApc+fMcBdBVBTqzeuDkXDZwH4WVAByURGaRPnBVdpGUwWHMpqv?=
 =?us-ascii?Q?FaM8Q9rcHzzt6UNFsMT33hUw6q/LvHcJ8QSitieN3nYPf4gLO7ImxcUFa4B5?=
 =?us-ascii?Q?KmmKw7d4YGi9cqMAP/FQxji6GWa1Ks9qAi0Ag1THW1jlsvHU7YE9OVmr/vaI?=
 =?us-ascii?Q?WiX3Dl/BVU7wenDpTwwooHThIHKgKm/Lza0FzZRAuoNxOg3CNgb7MmPWaOZw?=
 =?us-ascii?Q?SmgNhsLh97aN/akhC9Lca/8msPO+jj5e3oWawx0SxUGFbBNHl9zI6m+LjRLp?=
 =?us-ascii?Q?j5Jbxw8bnSTHeAw0j4EX0GCmXbF1ksaMxFDviOn110YzdO268zGNYxxIj/e8?=
 =?us-ascii?Q?Wmv6Cj8j3CVoD9xlzHL+Gv7Y/Wrt+Zj8n31dPV9p1MvrCH68GCutcMNUuQqW?=
 =?us-ascii?Q?ASunERz2NjKhWFAENWNOQfR8+y1y/dyXKeSSXEQkzjDVD8Pl98t/hk7mlZwi?=
 =?us-ascii?Q?+GX2+h8Qt+rWNA4uF4iEivShEdgGTa67mQ3u/5rrcOi+tzq37U7RPMpXAVE3?=
 =?us-ascii?Q?HAMQhK48NnlgTRR8WHCbIFAMPxvw564=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c144f7f1-343a-4d33-3b7c-08da439a7e58
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:46:45.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFHILwZ1hWALpj5ucoZhBlczWT4yIaU6wb26ekLL5o6xRe6WymfiQ9hs4Er+5ib4/6Jk7l7kGON+3ePqUWZ9ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2434

Use new get_subflow API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index fd67b5f42964..4217d0e6445b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -17,10 +17,9 @@ void BPF_PROG(mptcp_sched_first_release, const struct mp=
tcp_sock *msk)
 }
=20
 void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
-		    bool reinject, struct mptcp_sched_data *data)
+		    struct mptcp_sched_data *data)
 {
-	data->sock =3D msk->first;
-	data->call_again =3D 0;
+	bpf_mptcp_subflow_set_scheduled(data->contexts[0]);
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

