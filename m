Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0B28E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hpvSwn6WaMZ9z1f6oqF8VqB72Fr4aaqCSB4KzBbF3gw=;
	b=OoE4NQzqVDj7mMt9++t8DlUUTFQuqJXTUEjr3n16JeI5fnyLq+doajalcT4QgY7rwsE5Vf
	fMsaWRRsacE6a3Sp0WgBflhrj4L7izBGC+mDehvg0jhR/G5DI1gU7cz23KbjAGdWnrILaD
	JVyb1FLA55zG4UXsK6k67RhOLjna2dQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-3N1U3CL1P0eLML37ZD-NlA-1; Sat, 28 May 2022 17:11:50 +0200
X-MC-Unique: 3N1U3CL1P0eLML37ZD-NlA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfcXkMkDJWfNWGgewNfSlCQAlG94sLkD0vCD2RCEA2o4nSXBCTgbyR6M85Ur0Qukz9r44d+4gzkQ5kAwIPwYa2twQGw0y3hqSdtxo0kIKSNqjSYVmAKKbgFA8euzz0KOb1ONoqvUZmhyIqUlDEZVGCvqkdqIUfD/nR148giHvDP6YT9N7N3AlXzi/qYgQHQZjVtGrB6V+NH1cFA6UVqTYOLSXfofBfj4MI1i/XTTtWmVmksoBYr2mphdiEvMvJXY4ZDvbKL8gpkAyMCcrUvh6TkeIn+fRpEJmmu21EJxR7Yk3EAqtVXBYJZMXgVrqfSAN/Ffor/Gyr3vYMIwT4qA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElEMEVxliXKNy6yUe/FlmXjtyre+JGbpuj9iX1AwYgI=;
 b=HMp2okZ4T+WXaE/DjSbzj88ArKbdzJmS13BEkgjPiJZ+zl3JahxKjC2HE50FRG4g6fa/tRKoH1NNhMmpvD1hcv67j0Em8lhJzzfvyOE/sfaGqVvUfLcdYgWh5oaLMgKmxNF9ulD3NEh5Z8JEEXUvKDGcrR9Aib2+FY8lGeKIAe6Xz+e69UlN2usTd/wluCLzEz/70i2Ve1Y4rMGNqwfNozpICA0Kl3eqZ6ewRXbnKhPeg0HIDDUpC7lx2Y330BiT8vVA1cOuFIFvQm27WJSgpOyUxaiEF7DaUXQQkVy/xkKNxMEGFD+uuzlDdt49Q/hdFZ88/Sw/APcohNTuz3jNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:11:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:11:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 00/10] BPF packet scheduler
Date: Sat, 28 May 2022 23:11:42 +0800
Message-ID: <cover.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:203:b0::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ec6afd-c132-4beb-459f-08da40bc6202
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB848511E11AAF830F4C9E0911F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4TGAoz82FVXrYISjcCcdOxLnqqiAJoTAkK1SAV/gd0nJWxYN+EarAvFo9RX77+dP1Cy4EWsovAzGEXM1xsRrnbGa7Sdld7RhD8A0fynRtNupYXy8kGK7k+pjDOE0+LA/BT17R5AcydjjQwxeEvWfZ/eQKM+bx5MpxU/t6K6uuvI3R5kwn+MqtLMnifi68OwCrg8RpY8P67AYts9DSLUoZ5yY/Fko7m+4HSeDfXitlT6orsOnMYfgtzptrNW6IfsGLQRyuSmYKhjvwpiOpeidnOwKNvx9q1hv6oK/bh61uymq8DYeD2dZ8QgYi3hduzx+EEknDyR68TyiBKUcjHUy/Y4envTYG9/Wk5vrNe6hbJ7a/BjIDVH/m1nPmZPRSq80vt21+q5HrlgzTA0KZ8DbtZpurZuvpYxiCGif10bsjZeCW5zafrzlAHQ1sjOjJDWrjgpoOQFKPCjqJKlR4Ed/NDpshGp3LqjXucimZrLVwfAbzET7YDwtdGXwPEqpSvprqEdaDcNE8sNWM8vjwvXZhnzvFjCdNVuHY3dAfeb53dCKQX98e9lmkPWTUnNWH4PFg4tU5UnuVzNntI+VFNntvzM0Zk80yWpOBRbp6gH08OH8e3LXEl5Dirc4xxRYUGH8R3+uzK4Iyxffu/A6aRg9GMmEwER/2bC+1AfDJpxm3CA+3vH7NFBtq8vqBkoOV441
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tTnQ3lqxepla+FUFaGH8Ik88F99aDBgzGuRW3ozoEPEzIjDFt47gl5iSQ9se?=
 =?us-ascii?Q?coRJ2Z2zaHrPJyTC3wwajQQ99lgD8ULT2ALtVCxEa1yoGbP/7KgpEqIYp8ql?=
 =?us-ascii?Q?KwKcZmfS1b8Nqiyx82vfH8wwOpETKdqRk9OZLAHPlvZQF5IsABbDPW36hA8M?=
 =?us-ascii?Q?Om147cwnPEpRbmaCtGM41o7lUKmmvKFAr2eIxhWj/X8Ctxp/t8gZCVF3vJ03?=
 =?us-ascii?Q?I7+lcq7OmErXZ9fhIstScvKavxy/xtc6CSOSeWpcKzQS3aZuysAY40WuAhkA?=
 =?us-ascii?Q?GGO/5tnYLBSiHR4MNMzMl90XCgdmY7ePLl7a3QIzLU8YZRLYYwEE0iJl0vdh?=
 =?us-ascii?Q?ihWC+1n3hAUa+puFPfnc7qJm8epDluo3jZsBQjUi8YkUQvwrEtuifTFXgchi?=
 =?us-ascii?Q?YX5kUKVr6RCgAU8FxlVLtY/lBOir2x+dF6QkUwFIdCmDhQNRYWc+X4oaI076?=
 =?us-ascii?Q?//ypslPKiG1AghnBoOETVJX15yl9vfWKFRL8yT6R+nHFD+Z7ptSy9c/wsmiA?=
 =?us-ascii?Q?ROeHTR70V308B+xT5ICCXbxdwNgi2SWEuDWnEFA3HuFTXAYc/BvGgRJAYzcn?=
 =?us-ascii?Q?zW8K9ckAHCSsRXpmUEhW8fOsagpxH8gRL0/3b6oWmEoIySciWK6hHju048A1?=
 =?us-ascii?Q?0rAmOxWqrB4h+Xdb1Ds566wfMVzbB5BFtg2iW+2mkrFFKXMq78DP+A59QT/N?=
 =?us-ascii?Q?JJhREdCcaMW2g9dpJtlO5NEOKaEYROAqOaQXhlBNoULODP80pS3JkslRtR94?=
 =?us-ascii?Q?glhS6kX/BQ9fiSkPqcfzHFDU5yx+jE5iUHbMPzr7NZLUjDzxi5teW4iKBzpu?=
 =?us-ascii?Q?L7SGMOlXaAHFLjYp6x/llPJKLsgGeqLhEkoLHCMbh7CG9R8b6u/d3VvcqaFj?=
 =?us-ascii?Q?8PbUsRojp+Ee6VFb1tWJPQi1w37LkfetNRIk/awALhj8OcM8UrDGrVdTuyek?=
 =?us-ascii?Q?XLstks7yd2on+sLKzlwkZ20TfumOub6ntDPhYsacbpGop9woT/dU/Kb1AXhS?=
 =?us-ascii?Q?JSpV7B3ammFzHz8vzGsAhiSSAROWQEUxk358y5HfzONAWwgnQxt6SKmU5WZq?=
 =?us-ascii?Q?9zIriT/4n4U9j2sj5J7EeGNlhP10nOTPUJzt2VkrZXJDXYqn557Q+WYW6+2f?=
 =?us-ascii?Q?qpnY+DJK/ttySIXv8yJOH6D3oWrSy4cd51BLAf+jAfSbjnGu1AY6BWa6F5Ie?=
 =?us-ascii?Q?Q9JJDbASvaYIW3mFIsTjLQaUkbB9Dyq6+ZziMJci93yL+sQ4zgOlSIdJ8M8w?=
 =?us-ascii?Q?6hGOQ+KA4B6r/25S/aIh2o03o6dl0rqaSotNPgxbHcBs6tEKDd3FY4jXl5rV?=
 =?us-ascii?Q?wtapqzTb7Wx69xWhA6eAfiCzwQCQRyEVJSR0aIQXaABYKR1U/RiASL20TwDx?=
 =?us-ascii?Q?KKl4cOUfg8knwyaLBbBJ/F9vEwr5cOJiY+jOdm5fqGu9bYvGqRzQU3mAzOxv?=
 =?us-ascii?Q?fIyIGQvJt2dVdwIORitXBbZfWVFS8j9SBS2AK3A8ahagn+6Lk+u+RN0x3TcP?=
 =?us-ascii?Q?bqguWX2mm1TqrbdW/yv173Q4kGDBHY4mYCYFTJOsWJeneVCtuLHFK7Evxf/b?=
 =?us-ascii?Q?UelR2s1bhOgvVxvBYiJ3hxyZPmNPkkPTRaCsueK+4oQXccdSsJqgLhs4FomT?=
 =?us-ascii?Q?iOSO93/CTlwmkUxo7seR1f6JUr4yaGLTKlWkf6nyhf9Pie6uwIZUgr6h/yjW?=
 =?us-ascii?Q?HR7YhsEkJNC1lwQLWfPvZ0/ru9mg4ibmpUA/5Jb4fgX1XTzvP/U6/qciDGZC?=
 =?us-ascii?Q?5glnihgMlTMYLqqYpCtAUH1vezJmJI8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ec6afd-c132-4beb-459f-08da40bc6202
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:11:47.2754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9QKBrJvBfYHubDfybRV2lPM+VCE/SSKT/ni2X7vC6BjuYEItrIRLbD2SQdRmBj9J1J+ZhbJRlz3Hv5yY4I5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

v3:
 - use new BPF scheduler API:
 - add backup scheduler
 - add round-robin scheduler
 - check bytes_sent of 'ss' output.

v2:
- Use new BPF scheduler API:
 unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
                              struct mptcp_sched_data *data);

Geliang Tang (10):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add sched in mptcp_sock"
  Squash to "mptcp: add get_subflow wrappers"
  Squash to "mptcp: add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: add bpf_first scheduler"
  Squash to "selftests/bpf: add bpf_first test"
  selftests/bpf: add bpf_backup scheduler
  selftests/bpf: add bpf_backup test
  selftests/bpf: add bpf_rr scheduler
  selftests/bpf: add bpf_rr test

 include/net/mptcp.h                           | 12 ++-
 net/mptcp/bpf.c                               | 36 ++++----
 net/mptcp/sched.c                             | 59 +++++++++---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 21 ++++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 89 ++++++++++++++++++-
 .../selftests/bpf/progs/mptcp_bpf_backup.c    | 43 +++++++++
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  5 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 ++++++++++
 8 files changed, 271 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_backup.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

