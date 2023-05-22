Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A116429
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684776861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM50uvOJdreOYyRzALUt9+6bDM48yH5LFFZ4PooiEjI=;
	b=hN/7PZNMtQTOCzf2qvsv7ddnoqpiFyE+dy4BSpqTPdQ3DmhI5VCdolY4XHZAuSMvtVd33C
	EWX1DDEGtn944ylfe+1UX7IwhY0+6zN8bQhkPiscguP7FP9h37rC7wLIMOEqb0Ekz+OOuJ
	koxYE0Bn+dqU3Cw8dzFQC00Z+RDB8Xc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-vkP3LW_-PD62m0ClgcQaYQ-1; Mon, 22 May 2023 13:34:20 -0400
X-MC-Unique: vkP3LW_-PD62m0ClgcQaYQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75b175cf0d1so18460985a.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 10:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684776859; x=1687368859;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Kn08YgOkKehZ1wtjtVC2R+r0vh/oIEZIQKU118al9s=;
        b=b6B2EdMhhOCvnZcxypzn+lrWOZhoI9JNfhCd9yt1CZ5d83H9IYbkMS1Nw2wPQCp2ME
         1bVay1MgxnevDMQGXCNVmoBdZjiuk5oshq53H/vQXnujer/4YS75gKcZIyKCKJyxwImK
         +//pX8bBn2jXT2dZ/9lykIHPuLsRZuGQ+eNwE+QzzLeH9Z2WbefT8u0pRFIq1+DnEiOv
         pca9IERMnTHlikihhqjNLhvMFo/WcdAiQajwK6WOlAP5/0S2ZbrEy1ojae4CAAXLJuTr
         neB+8pLQQE5ppoW6VA7f2o2DMkvUrMRfaiSWcTxr5PkoHm7q29lM2+GvNcrr4M5TaCqy
         c9mQ==
X-Gm-Message-State: AC+VfDxy7S3zM8IovsFMvmYYFrSIC32FYDDmDKmtlwh2fsCUMrGDc8re
	cp8mg7WZC8K3ezUzbMAXkqdH8JX1g4ZjrXvs6u+OcaYP9G6JyIFEcOuTPwMmROXcQ9f3+C4FIhL
	rL+RnpkxU8+nXCHHLEFSsSPA=
X-Received: by 2002:a37:881:0:b0:75b:23a1:69ed with SMTP id 123-20020a370881000000b0075b23a169edmr1563979qki.4.1684776859344;
        Mon, 22 May 2023 10:34:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UOeGhmlb1GyHOVOaa2lB1oMG/XGt81SSyZFOTGaIg2ZeobPLF2nUFMY4uKmFxuhcbcU0tuA==
X-Received: by 2002:a37:881:0:b0:75b:23a1:69ed with SMTP id 123-20020a370881000000b0075b23a169edmr1563967qki.4.1684776858987;
        Mon, 22 May 2023 10:34:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-106.dyn.eolo.it. [146.241.241.106])
        by smtp.gmail.com with ESMTPSA id m5-20020ae9e005000000b007578b6d060bsm1846716qkk.126.2023.05.22.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:34:18 -0700 (PDT)
Message-ID: <12e78465ce6246a7584c5cff78906cbee72622f9.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 07/37] selftests: mptcp: userspace pm: skip
 if MPTCP is not supported
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 22 May 2023 19:34:16 +0200
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-7-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
	 <20230406-mptcp-issue-368-selftests-old-kernels-v2-7-50313e4f83ab@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2023-05-22 at 18:37 +0200, Matthieu Baerts wrote:
> Selftests are supposed to run on any kernels, including the old ones not
> supporting MPTCP.
>=20
> A new check is then added to make sure MPTCP is supported. If not, the
> test stops and is marked as "skipped".
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspac=
e PM type")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/te=
sting/selftests/net/mptcp/userspace_pm.sh
> index b1eb7bce599d..8092399d911f 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -1,6 +1,10 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +. "$(dirname "${0}")/mptcp_lib.sh"
> +
> +mptcp_lib_check_mptcp
> +
>  ip -Version > /dev/null 2>&1
>  if [ $? -ne 0 ];then
>  =09echo "SKIP: Cannot not run test without ip tool"
>=20
Up to this patch the series LGTM and IMHO patch 1-7 could be applied
right now.

I think the later patches need a little more discussion. Specifically I
would prefer not introducing all the stuff related to kernel version
and diag dump (e.g. all that stuff that the patches themself warn
about).

/P

