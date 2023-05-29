Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654E7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eompfiDEFttEscvZKLaqy5JhNdT3gkEk9jtliBk6YD5P44709RI5MLHGyW3BcxWt/s2OD4Qr7OAnNsw/CuTdmsrvQGe/nWLf5PPgtv82jc/HBq3aWplAfUHbbIU3rVXiL1jWujRC2o6qsahahK0yYMwgqxPCQYrMzrkgna2iQNxXAM1eY7QikH3D6MivfK2A94Ywyr6p0cxFw1LLR0ntN2ld8rgGaaT5I6K/Sxzq10w4v2M1xkLHXYCy7FfG92Rd5hD8v9xCC2Ik6dtCvRPTQCeW3Yyxxuc3UY7BZOzNbQmGMlChF/rTn8Xh1I1JjyH3eGIVoiBFHS9k88JYmzyI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc7FSfSRG2sHuSgk9lboygz5/Yfexs9J7FiRQS70La8=;
 b=cjxOZKARUAnK/V+h3cpwsJ/ezXpVNtPj+KrGuLReNUeXzHE+lbT01kel7jkBAgwKVmjWK3bAbP5oJ+0VeOztipXfPqHYJE08Mn8DaXzn/XL+jIqBTEYjOY0afTfktnA8wUzCn3PUSVSpbZKTTEe8DUZdNA8t/8QP7/HS6xe1vYqtTByKgEmgQv72f6TwedKu2NZubsmS/DG6AUhO5dOD1KHKVvWZ3W3h2jHXfPx45lyM70+X48jvabDx1fhrumaQeHv5SvnY3rrx2ZYYaVCEGdC6BDHFzFqZafyftaHwmLDtfD1magAD5gQtAYCL6ZRcdnML8Y1DiI3DgcDPzLpFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc7FSfSRG2sHuSgk9lboygz5/Yfexs9J7FiRQS70La8=;
 b=eA6Q7vcfr2wm9ot3X21Im5cFBEm982sF0lY2YamoqXN3H/s2WyF4t6AxbDrIaKsjlsMmEsQU3tq0BBttGRNCFvlMMMScdnAw/8F1wokFw8bIab93otLFQcHf9Tc7Irdgpxay9z9kj6+pRQz5Gw/UhQYkiiRIRDl2x5nJtdiw7vp8B4JEmk9YhUIQg1DMbtbkBL4JuCkueGowMQjtjg9MdU9RMqpGDWO+AR+VmoDsQPfUNO5GPiwwdZiLx7NjEzMZyj6qgdH9/FwTeCLk9ZELmvYk3eYkCWP5ahRnspHTHcgim6JUc5IBPMYDkFMnV35uY0IeMIM3fy4JyufFZeFCYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:17:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:17:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 02/12] Squash to "mptcp: add sched in mptcp_sock"
Date: Mon, 29 May 2023 17:17:16 +0800
Message-Id: <e74931ae5fd52b1353bf90727fbaedbc45c05a83.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f6fd31-5c61-462b-b5c6-08db602590b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RcBAa2ZoJJxhgwJ3z+mvzDVeNkYAXmFH/GX0/FGL0mh3Xcp6k+4vlxz9mU8OscS22np8Lry0Y0vemBJOX/ZA1p1KCS3b/nttANcE7El7Ti8ZXuES79SHMfT6aCg4PlGuYidAlE/LYyuQyY2J9UV7cJaLQLiaZYWnEVjJ8+MOz0cS4EAG1ffPsWsqLIKiU+TzoiKE/lqUgzvAISl3MwlyroTJmCI90KE6crQEdOrcpVcH6yadsJklt+fCkTi7KtSeXKZGMDZjm0gWOEvFwnRSsvrS+UcUGgU0dihJLfodBFYaexHvK7yo3M+xPKPOuNeLi+1EnISSnw5JVC+75bUajt8sFwgOg4BYOWz/01OXNmoei2zb7rgPA43dbe+UaxVdBnNco1nkiGiJRwAfi82a1yKKR3kW9+dztnYldtUBFjectOb31oFP5WOANAg5tjBSe5I3AH6/BP/fK2MwJASYx8suiwWz6N8Gr9hHDKBUYjLgkz5bkT1y4qHtVP/W7mWx1slfXlHEtOIEZWi1N6+kT/z1ZYn1+9JTaOrLt7x84ngAnlofYsEY9RGHNErs7NlY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZvKScAoXzCifD2VdPqJ9ZJuDHYvlqxT9MLEmk34mnyYgEkFo+UQnocWNJWK?=
 =?us-ascii?Q?ObeD+VyvOizlf0rs9d/tN0DXhUT7OhG0TX57BO9Oc9mv+cN5YPFNZUJy1L/K?=
 =?us-ascii?Q?dqeUtrRKWl5zWdoJdvR8pI5yu+BA3cLhObn2Xp7mVD3BYcJvuqmha+J3ONSR?=
 =?us-ascii?Q?J11STXWOl0yQuvkUEAFjsvm13IxH6+WltdQu+96p6w0NB1ucBEO2XhgJKcyZ?=
 =?us-ascii?Q?im4k8gVINdHrFGuVkEcogCQFH4Ad3C9Adtv7P707zXVYBaC0heZVpRJFqlcK?=
 =?us-ascii?Q?J+IIPN4mM1vz4fNODj1tnZ0XcW47oLZrGrJbuzgOK2W+YqSOJ+JdzF3YeCSz?=
 =?us-ascii?Q?pO6c0ZkhhD5UThbdD5iwA+OVoX4tj7K59t12IViw1QUIrqi5xDfu1oUmLm8g?=
 =?us-ascii?Q?v15M49RgQFZNiLw4ucGCuzvifFRARuvGwuv193BpEkJLslB6VlGfJJ+vfmNP?=
 =?us-ascii?Q?/mPPAZDLH/xf1HM6SmdwBJZ6pix84rRfgtkAtTi4/uwX64WrNDyZLAnm6Nuc?=
 =?us-ascii?Q?E5ZCJev63QilSb3N5LQ0dQAQnjBbsdAZgTHvh4L6MZYNpFrphd3DnRKDaxb/?=
 =?us-ascii?Q?Hn+RDXV4EJWJdQsVhGkvv+3n5kFZZOKoz9dnWC2bS4kyF2pOXneNYgn8F1Jo?=
 =?us-ascii?Q?2CYWBqC2RB6z7bwnSvbbq/3P/hqTsw8NZaIwOvOAB/qE9Cb2xMX8so5k7A+W?=
 =?us-ascii?Q?YIZshA74jp0Js0SyAUp0NQEpEXmc36uEkkDYmaYxQo4mC4PjQ7XrDP3mMDz0?=
 =?us-ascii?Q?qzWw7MIm21MyH1wWRGfGY5gd1gAhSlzx9bVX1HtMh8Lzz5CMxlB8sWPS7/PY?=
 =?us-ascii?Q?U+INYmTavP+tjONJ2QTgqenqmGBT0XFUaZGuyWUmsjZSv96/HD55/nYGnu4I?=
 =?us-ascii?Q?PcCMzrteZGa1SGM0/86MmF8Vo3ojEkRnis2E9AKvMRtl7Ehu+PBAgK8vdZsY?=
 =?us-ascii?Q?7zosL1ZKn+Z0sGaYObyGZHNYN66Gn4lhyh3Jed3EO4sQfLmfYa/ABvn0yDwk?=
 =?us-ascii?Q?lS0PRFayBSOkCVw9iSOLBfy6jmsc0kdsH08Kaae8v/TEJhbQeCMv4luphU7g?=
 =?us-ascii?Q?Xd4wP4zEIvEeEbNVXPk12XRzLWCjMRe6Y6h2qvyoncAxe5P+BeAEbIugCTEk?=
 =?us-ascii?Q?5/DrBHfbiTNr0d5sbLut5TyZFan1zuxQJQXQBVFD5mO/hYMUeETVbRPTaxRw?=
 =?us-ascii?Q?u4uwzDU4WHD/NwG5CTmlhxl6f3mTmWy4orzmKOgkQWbceN/d/t7L8zh4eCyJ?=
 =?us-ascii?Q?nHilUXotdInjtrutpWt7XfIxuDALnGS7fPu0oIGkJp6iSHqh1ftGuzbtky4R?=
 =?us-ascii?Q?y4mDfAFs6sqoVnkJ09nvXZtxWh/tGh+9EYxTMzPauQyqiFcXwBdbQSosRrvi?=
 =?us-ascii?Q?sq6yLVkAcgRAGimTx3REsVVcT12MJnnmGeo9T25zSNM16r3UdhSjfLlnrq6i?=
 =?us-ascii?Q?DagqvHTIW4OwhkM/Vuiy3RfIT3Y4k1Mc5sUkiBQpBMrH3WTWFYUkhYZWDBRv?=
 =?us-ascii?Q?v8eNcu6/6fR4LQRdSszjYnQV3i13RAuaBOJOH0OjBspOCReiCsSeMP+PPk9i?=
 =?us-ascii?Q?9Le7zw3Cfxj2A8nXJG4bUBS5BhWbs918oeZ346yL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f6fd31-5c61-462b-b5c6-08db602590b5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:17:46.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3qjuq9iwjJZUV8NPNEXOdipWMl8gLr7IdcjDLUT3CNx9ERtmrTUaFbTNj3fi2xp44QflTfHIm2qJ+tJXIX1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

Add sched_data pointer into mptcp_sock too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 1 +
 net/mptcp/sched.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd3771c7d79d..09a5e23adca1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -311,6 +311,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data *data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..edd7c92f4ffe 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -64,6 +64,10 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
 
+	msk->data = kzalloc(sizeof(struct mptcp_sched_data), GFP_ATOMIC);
+	if (!msk->data)
+		return -ENOMEM;
+
 	msk->sched = sched;
 	if (msk->sched->init)
 		msk->sched->init(msk);
@@ -81,6 +85,10 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	if (msk->data) {
+		kfree(msk->data);
+		msk->data = NULL;
+	}
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

