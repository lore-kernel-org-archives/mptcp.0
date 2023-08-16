Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2077.outbound.protection.outlook.com [40.107.115.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B501078E
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 13:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKoxZSqec06zL00feKgeMd2Pbi9Ei7EckRhevS5N68Aw7Ed3Q5C5NwNGuYkeTzOkLrQHGjJfYzwNlEyUS70pm6nNkrh1FbaRhPpLdUdWFEsc5MzC6CI4EDZFnoaJmJohaOJf/AkQWoVssEkEU7ZgpFo5GCSOQCKg4mTOkamHEZ3f+VE99QQyhJ+uDXFFH2scjWFOou+83lCSTa9JO+DcqUTxJEeDix9MxnJEQlWkU6QYIiwN7vUEJtqB3dU0eVsvdhimxI3u4vS7HBE+B4xeR5z/RlIMBSeIgwBxNVnCKeYotMcCt/7y5BYemUUWOQrkfmcbNXlPn3tyQwgPneRpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p8yAigMfe47bh1ccg9QOH7iSRKYR4+UFJWvBv17zSA=;
 b=bLCBQaSl82JMIa7nhFy0905VLTGSU0GxYdmEtRgEF0e9Xo8KOakNVBO6L8tXbTvHF33p0QZXOmlIPwujJzMzF6Ow+sm8Ev0EICIJIlBhFdrHkEOW+ZJaauNMsbc0f0A7eTVU4Yn2vApyGoMTHFTWiUo6HLqwv7RBj3imElYlCbzqtHIc0HmfqcYRPc3f0FwtKCU1Q4k0mk4tqA8xuKIydeqD2TD8G3/2hOXiyNJEhtaMbXXbJGO2uhH/MCBYs5nXdW0Klm/bjVVX5TqC80PFBiF5vMtGu4LXScOEbcC+zhhFOABB2vwgt/3aJik3oZ0fJAIMlaZppVnl/zz3zETuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blueflag.consulting; dmarc=pass action=none
 header.from=blueflag.consulting; dkim=pass header.d=blueflag.consulting;
 arc=none
Received: from YT4P288MB0088.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:ef::19)
 by YQBP288MB0098.CANP288.PROD.OUTLOOK.COM (2603:10b6:c01:70::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 13:11:59 +0000
Received: from YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
 ([fe80::72a0:f5ae:95f1:355e]) by YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
 ([fe80::72a0:f5ae:95f1:355e%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 13:11:59 +0000
From: Alexander Witte <alexander.witte@blueflag.consulting>
To: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Documentation for path management plugin creation
Thread-Topic: Documentation for path management plugin creation
Thread-Index: AQHZ0EM96aZ5VGhpD0ik6e1Y0NhuTA==
Date: Wed, 16 Aug 2023 13:11:59 +0000
Message-ID: <F3D79FEC-8248-4710-87D1-925051CE5750@blueflag.consulting>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=blueflag.consulting;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT4P288MB0088:EE_|YQBP288MB0098:EE_
x-ms-office365-filtering-correlation-id: a762bbd3-8b7b-402b-428b-08db9e5a5f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6qwfMwS/o+uy3vlHXB6WpScDjXw4lOqKK+IXit+hdVriyZ2WPJnBYz2LZ26PHirJ39a6uuzZ9AUVSlsb8TkDXmGjpLL3HB0HTfUpQmhgBkX40c84vEJafTs3Ie/SYkvRXEAGPKU2GhWwM7AjfnszII1fchtSEAmNzzWt9zRY8ikGk6uXFI7mC9A1j8uSnOEQDvlSlWZkIAlEOI2ZL1uzePxoL0nuB974s5zqi50F5TTh7f5DzyI/aH5WQ7BmXpuy5Q2VWXLb8qX+S8nTbqtAW2JXJaIIZp8F3iVe6B9KxSev0QWss0wKruWCCZ2w0dVZuwr0gi0XtcFO4M2ZWxuqny1xI3GfAb/5KW/UGmHxYB2u6Ki1FO9gacrAcYC0HdFiynPs3qLt7YK8cXpolm7rwPMMaWai3lrm2xuOQr/ORKmeeR79wU/ulgM2uaEPNFOQcudkFqcmb8w6/XcsLOUhrFisIqMrjxCv2TtfIn2cN56oYAIqDTIQFh6+ZMemnUeFnUXu3I8VWe2+ShnfcsnPNKCURjXXdBZhDIIBm1+73cFYyPGOeBCmIPhP78h8I9QoslVe7gUJrbBm/6EwyP2tiaE57PlxcI0Gv2D4oBqYQ9BwjHYdZ6KhBh1gJ/GX5CMrKwB7o3QGvj6P7gkODM4WJA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4P288MB0088.CANP288.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39830400003)(136003)(376002)(186009)(451199024)(1800799009)(33656002)(86362001)(8936002)(8676002)(5660300002)(4744005)(2906002)(41300700001)(6486002)(6506007)(71200400001)(2616005)(44832011)(6512007)(122000001)(316002)(478600001)(66556008)(66476007)(66446008)(64756008)(6916009)(76116006)(66946007)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aaM6bYfvDVZYYURXVgKukM+U7H1J3caf8K47pttZQkesfrtAAEb+wjH7wL5R?=
 =?us-ascii?Q?Hjvfj4oNvo/JCGobBRlgo+6OiEyHT5TbYMXTPGLvuDWWCYApy3IGCZdOg87y?=
 =?us-ascii?Q?Qb3OgOgRz0ydd0fQyHI9qjxOfVjCwPgBKbhImd3ffClvVSO2n+IFoqLFWYb0?=
 =?us-ascii?Q?A72SnbEY0SbLPTP+KEyIiYnAjRosGe+YteqPg06GbT8NnNyAW9IkSDsH0Xwy?=
 =?us-ascii?Q?2g51Rt/fNFZAFV0KGP5RqQCsk+vM831yz494En61YNVG+36/0v+9C5DCRKCH?=
 =?us-ascii?Q?Jb86Qcmh9OH2KWOkzoecS8nqpQGAPgjRV8hIQkkU+WtVqSZEJ2TF/WUMV/ay?=
 =?us-ascii?Q?fnfwuskVeckgbABzGzRO8wGdq0OP5TWbzIPzJ4+T4hTNreXOKOHpNUIhkiuL?=
 =?us-ascii?Q?LU6Fxp09Ku7JCkxxq7p+DIPrwR9i2U1U1OximoEXa81DU4ZQ/DLUcmmkHpFU?=
 =?us-ascii?Q?aOepBYdbTs+mStDWKjKPOiUSBQFoTjtZIx/4sIyZEHcqELOlOttC+WudBPfx?=
 =?us-ascii?Q?udQQnbCQHCNFej1eP+nvml1BWDIy8Oz+RNQWErMxs07Omv9XICrMxmRrYGpQ?=
 =?us-ascii?Q?GiaMAbXIkdJxCKP9VufJgITNyi+Y4e5rLTPyK+WNXwumlCh9iN33vu2XGeet?=
 =?us-ascii?Q?ddZCMp/DHvrnzHebmUxEexLYw9ueiJ9SzAAiyq8z4qT2tDQXPLFGD7lb1FqQ?=
 =?us-ascii?Q?9mD9yjZmI5qn0TToIvuF+Fgb0BS06zSm0dg4SpZPzDWA8LqKltcAGpJSukwv?=
 =?us-ascii?Q?fXziaaqRAKdZi3GyEBKKimKnN1Xl7dp1MdrMVYymABt8LE6QmH7rrWgc8Qzl?=
 =?us-ascii?Q?TJIaunXkWmiIa34r6m6yBn9VcZptztBsfcoAwCTJ4SoGVlH2RNu7EQ5kA1a8?=
 =?us-ascii?Q?sZWqbiAJW3KAF0LtQ7bip1w8feUzlMQFA9BN956uXAWsfTwygVjGpFFgnWgH?=
 =?us-ascii?Q?XKCDPzUVUS1eQNYlBnSu9Si2yu0S2Z68smDhW6QZleQcf8Zzm3sMwIqWH+07?=
 =?us-ascii?Q?EeUnfDX+R/qN3FObMw2umvlSNfNiYnNymEj+crlDeIsO60ZVREmLPMaNTf1m?=
 =?us-ascii?Q?eyc98noX81HBPA7rzWJhL1g8Zym3JiZWRmB5kMiignQaIiHQwG4KPhNqDYi2?=
 =?us-ascii?Q?CYeMTWKwfNJCne3ydAllGStp3p8W+O6eXNE74H0Fmmm9XhM/7Iws+Dz+94cQ?=
 =?us-ascii?Q?6QIqAwytexWn9GJueJCK06od47aXt1s9Hqr1WrjS6EObzWuAUz9ofC96rIqo?=
 =?us-ascii?Q?l7xt2NL1lAD20/+jc6K/Zg3te0AIF37Rxtk6puhwYYve3ZLrQcP/FdibcPBu?=
 =?us-ascii?Q?vANmVzRCsPWa5CYi3DsaEE6g1xk4W0YN4RLdXqoO2YpcJBcl2fU2kbO7HOtc?=
 =?us-ascii?Q?4vYKYGZHF7P2rZSuvxQehicTDf1fH1gjYep3AcaJeUYUaBwvfzBS8DtPsPvN?=
 =?us-ascii?Q?rywK+l331PdfwxOzkC4wMWnfu0FUhBYmhnMuuns/gVG+XU7WXbwJZLghaeJL?=
 =?us-ascii?Q?E9VKKt0FITacIZfeqcUy7vNU6+sqoZfoMEVuZp0E5cflAEE/PhQYcrhjcUTU?=
 =?us-ascii?Q?u2davMhiQni0gQZR1sbcc97sRd1+s9R5qoZR0wCsiNkshLntURqabReDuqYt?=
 =?us-ascii?Q?hW5JT1wBrIslh4b3ifV5dTa/3AUtWzFfZs58XqMBySzEXFfBVqLJodQKlvY9?=
 =?us-ascii?Q?sPoeNoFzAu0GnXT7Yx7YwvLGvgcJuTaJq9iLllU67L8qSDo6?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C773AE7965D5694F80810B7EE5A9781B@CANP288.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: blueflag.consulting
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT4P288MB0088.CANP288.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a762bbd3-8b7b-402b-428b-08db9e5a5f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 13:11:59.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f1904ac-547a-45c3-932d-4fa0466bd2fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlC+cRjRhAKT6FQ1iyZKCWHqgw0JpgtjPpBSchFa9H/vw0/iG1T+jxyUDwmVi62iGP57QD8/OEeoooZvpmsmyb5WJOKiAW7D1VmQYLXqFJiI6yg7q2pd/H8/q7Uk0c8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBP288MB0098

Hello!

Apologies if this is going to the wrong place (it probably is), I am lookin=
g to get started understanding how to develop a custom MPTCP path manager p=
lugin for use with mptcpd.  Can anyone point me to some documentation or an=
ywhere to get some guidance?  Or if this question should be directed somewh=
ere else happy to ask there!

Thanks,
AlexW=
