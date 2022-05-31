Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8C210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuD34DTemg3ytzjSRpqOMdXBBzTb9A3wwgtjNJcrl8Q=;
	b=ZurhPetKzYwDfhxGkC3DXAeLGTlYLyzbxm5zScA5r4JrVrHMmMV4UK9v4ASDxCg0fTfaok
	OmuI6UoSYIeBeIPq85yOiMYMC+2v3q+9B7Vlh/tWzFcZq5uz+egBO7W17RUwmdIIpeqg80
	hrz80IdTWEg6Hb5+WZwbRilM0dFjtEI=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-44-uwkbJdQ8PFO5hVYTS3A7rw-2; Tue, 31 May 2022 11:10:19 +0200
X-MC-Unique: uwkbJdQ8PFO5hVYTS3A7rw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz2Ca9Cuh2PEUXSOJzUBjUqYtW9vOyF5SezG9uX6GpYaZ3XpMCZYj2z4NvNJ0Njao0KvYvekfCkCJQplnNHkESsomLGWvrN1rieyLGHDSA1YkP4IKMZBCxYjLDg3bwaVLZDfuquGEiRzg7603ijH1dFSdRmRIYaKZ/SZYVf9ekTMAU18dVrQPF3tJmW3Nlsu5U+t+BDEP16R1irBAz2d/eqUGKZcjErjrmH8CoBhYFZR3dqGmm+zwmjtant6F91lBtexuyYvcbIJGdQ3FNDiX776+D+MKjnxktRW2H1evFUM4N+RXnd4Hto7p23OUd77tR+0bRXYOp/OJVd0o9NtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNahJnbwaormUEeouPE3Bw39oN54wccrluSkCLoQIyI=;
 b=m7HDAIL+Z830UbEcuFwBbYszgNVDvLEd6651DMd30yItkKQ/1XabjK2EfcDRDMZU/IsO1ojox5R/vASGqm5Ae/qFwv9G8vzh8Sn9NK3q44NuEE5zOBMYIgrh0w6JhelvaNkXSZwri3szBIIYjkkwAukkYvyFPznmqv5ro8IOfTmw5Hpsqry3x8WCLyG7bkTWy+9t3SZY7smFRQUDTCPgEQkcG8D0zBxOEnityLzTsZJPi8wFu1r6Cf6SApSrqLtX7IKctAKr+3Wncpqkl63GPi8p/U8sWZkPT835zNQTyLkRVx3W+gGUehD4zuAH4uXnqiaWK4PK4S2UWnTpqIyizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4356.eurprd04.prod.outlook.com (2603:10a6:208:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 09:10:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 05/10] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Tue, 31 May 2022 17:09:50 +0800
Message-ID: <fabe645b19af4a9e6c5f41faa83a5ac2de5e4b2a.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 203db066-a217-4bc1-51ca-08da42e5618d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4356:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB435650576081BFDDCA70C1F5F8DC9@AM0PR04MB4356.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DKqq2eldJlhI+SGop/8rbUEQvvPCtkmpnv3j6tTTjiuLwbakQdywK6K+FVs/YUk69SshPc6HkpJCfsejH8NL1+aen85SnZ1vS+yaP9VvFmYRi3YaoUnC6uOzJfkTuX297KUibbwzEm4zzgT4T30Le8v30dqKcqx8DrXOlD1kBJroGi9g5T63OfT9dZLjvrB85PvPYphXUkkYJpJv7DCImNXQrTdmmXUjPC+4cU+u0jH5UJjpIigADrPMhmOajWaP7ZO0JUwSRfAxRJSU4Ull1Us94pNafWwCK6H4HqbEp0jJ0G4kyiKsv87Ayf5Xf3FE9xJ75bl1pJh7m5STS6W2mt6K7VQSMKxTIPhHD1iIUUzuR7Fv++7e5vRaJ+SBllRB9hWR780BU2KhGEe7sxX7k92GC3ATsxbEeCI50fw7HgQNVJaswudJ9ZQhPrUII4DclF3Nhoz866s1YXWRcoJwjn1I53Ulq7SemFbGfGV3Gw1uJwC2FOKj+I8NyhY+LpAg8FOohbjFsy2Z425MvYMiTYMSJRq22b47gEYhWpp01P7zPedpcQQncAy4LvsQiDkuybvs2vUsWMyQQaOcPuh+PBbe1qr0VKbEYLreioDzJTkm656J6EBq1oATjAlexMjejQ38v3vN8KeY8MJuPSDSTLiXFp0X2i0xTbp743818YtGDZnV60VCxw+xJkVHq0ODIGNwpGRxoSQKyNr+Kv4JUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(8936002)(6666004)(36756003)(66556008)(4326008)(316002)(6916009)(66476007)(8676002)(6506007)(26005)(6486002)(2906002)(4744005)(6512007)(508600001)(44832011)(186003)(5660300002)(107886003)(2616005)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mfVJNhKGhioenoLU9dwLYl9N+4XTx7jN9Fl8xLztHImfywWbVnF2LBUkiIsW?=
 =?us-ascii?Q?khWLCx2nIGKTsEeNIlmKwMi3A/Nly5SIL5iypKeCgniZ/gegExo6/Z+mh9oF?=
 =?us-ascii?Q?tW4jwAAlYBhnXfAqAVontEE7cWZ+D41j/0kp9beO6CyjtUMnFlFIZu45GEu/?=
 =?us-ascii?Q?xjuD9giuqN/QL3J7VH++ynqDhOEjD6AA04SIKofbSAmZkoKllWhgcWCbRlNo?=
 =?us-ascii?Q?cTUbm5863+3pwUZCSb++M9RlhBcU2oDNnU3YTTjqh61vsWuRgtIhBCEC3WNc?=
 =?us-ascii?Q?cZ5F6DrePJZgkh1owcmNRhC1XDlU1JYadCd1kFiiz/4v9uh5OupnxjsUPw7V?=
 =?us-ascii?Q?oVsWXokXRnyOQSCDbsdOvlc+7KvrW0Rst9lPZ67VvlyhMr9KISfEgq4dG7oc?=
 =?us-ascii?Q?BOj7CssN0JbR6MtPNzQOp57qkAFA+AWF9L273o9uzRNrXcHR20Po+QXGRbd6?=
 =?us-ascii?Q?2QEulbAMg8pWoY3UHcLQC/z8fJpkKE0D+L4inMYo29kmuxW5EF7tfGrV2QOa?=
 =?us-ascii?Q?pvmjfxf2/44OUwOk4upnCD/u6EOMMNJXm6wXkwbgLFy24KCWM7aZm0WWkZzr?=
 =?us-ascii?Q?xhCPwPdDjP05G+Z2VDHJt44BUe6Mc1DcWW8Y5cP86pV/WwBG2Be0x0OU/HBM?=
 =?us-ascii?Q?C+mqOwzu7X162PW8ov/yJJg7bCQkUgYhlK3Pv4U/YIAm8/vkKU28U4x7vE1q?=
 =?us-ascii?Q?tE1/VvN7GMLisPehZKEnoOUNX7os9FEB9os+UgKrU1SRQp7zwoqg4h5tTq2r?=
 =?us-ascii?Q?NWgK5Ru5240BNUWPyOrGk99pW6ymwc2B3S6mpO3IXdM6tw3WwFMcbKlpdm/n?=
 =?us-ascii?Q?6UGyahwky6MHvbKJNoW1a2MqWguWOxnEBjt67RR4qNV76mSegtIlhTS/7cx4?=
 =?us-ascii?Q?Ql+vIcfT4MX+pxLBgVdbceqNPRj4I0RkoWcufkXkUrT97KGqPjqp4WgzKA3b?=
 =?us-ascii?Q?KoOADsdqD0Emmgg4GEjkt7tDkgljR+Ep0mwX9dDS69y1K35XDdgOqz3A7mPL?=
 =?us-ascii?Q?aYh/fR8oc5Ger/07rwjwgDWSun2gvRBHh+BgAgZdlkhYC3d8K5NN1pR7Ehdb?=
 =?us-ascii?Q?BWmXWGnMj+PBECV3mbwPLQaYKYjC6Nhu3AUhtkVDP+DZA8l6tv2W0hG4KCl3?=
 =?us-ascii?Q?bTPMIb/W0fXUxsXFoKdQcE2QYRuKhRa/9QdLyK0f4T01yNDirIJKcWrGt9AZ?=
 =?us-ascii?Q?FMsaK6kbzWMEEwlTv0/w/1m9reanHFR0KyJUBb3nWm7LNRJ7BOHa3m8V8YZ4?=
 =?us-ascii?Q?zcIt6MeWJfgE7nLZRELZvkmnR3L5VCDHLoepfRFYfzjordm0+1OxvAzXsJNV?=
 =?us-ascii?Q?/xsukFtYYvfLtY5EgU5/8B8W3lavlvA5ugWfXrlOI/y7nxkiD4WrOsTepmtb?=
 =?us-ascii?Q?75h3lTJiotydVvUCKyUC48kNpwr/53KnA5+AvV4NJYSzzTb6kDzIjXnobJbG?=
 =?us-ascii?Q?guBHruTAAcWyPXj0jLPtO2sUTyhGUhw6lQk00Pdn/ubwZtsSiMnasDSH1ch8?=
 =?us-ascii?Q?t8b8srPxG6FXi18VDLEYrTccS2eEW7iCvkujT7iEXF1SUOfWoQPwx+T7jDxr?=
 =?us-ascii?Q?8nQuOkIzIwu3hWtqw+PjsN+8/kAUnC1MYcrjdKsr1S94VfN2pkodux155AMm?=
 =?us-ascii?Q?nov/BxMbiIjPS7wcd8xftS+tjbgNc0h4ziyao3uRsGlfkjo+/pBeIoF0DfNe?=
 =?us-ascii?Q?IL/8S2zzeJAW2wbTtCaOmsUlwJ3mWvEaZRmma66+G4DKrzOMhjt7ZCU8hztl?=
 =?us-ascii?Q?6Hevv1+dKWkxw6qAnObTkn8RaFOfewo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203db066-a217-4bc1-51ca-08da42e5618d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:17.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K28PsoeeB0MQWi2kjwxfj64vW1ZIOt/oWkRd91Tub4ZEvjxhKgqUirN0r2KhsVr7a8Z/TlN7RdwZinFCYcjUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356

Use new get_subflow API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index fd67b5f42964..5f866f51ac70 100644
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
+	data->contexts[0]->scheduled =3D 1;
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

