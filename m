Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC516414
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684777729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awuyZm+8FfOLWlFFFM2HcOnq3jYJU6Phs1i25+ltiio=;
	b=SWzUUD0SS6HZzVM34wbIuzx+CP6LUJVSHdMOFmktPJXhxRQycT01uT99X7Xsv2X+gSLXqt
	YtRZUsoCe65b/w0PzBltX/QtScd7gQG7M+sKOy3g4B/q8eH7EJJVM00BhSpy1A1rkhY6kl
	RoexGcPJzWJ73idI/JSi8hJF1VUyeGs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-HUTdC1BROqyyTQOcrVInIA-1; Mon, 22 May 2023 13:48:48 -0400
X-MC-Unique: HUTdC1BROqyyTQOcrVInIA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74faf5008bbso16676185a.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 10:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777728; x=1687369728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXfmnPslG4TZpzLrqgFjucoWToB7xJH44fcO49KzXQo=;
        b=aJ+bbBIIcp1RePrdkRejEeHuz/mAgE9E6FLS/lrb8hxus2PLKvb2B2d5xxv6TMDO4o
         nMNMPxsDkR/FDVKF1kdteZb5cuSQM3B/W80ul4OSxzpNoQweQIRQb/PLSFfpTDqMjlTO
         Gfz1fb3756MMOYEgroEDk/CIPAUh951Fk9GjRnjZLfrKughqQ1KjphXSxlC81bXReCss
         WYCXDJ+khOaElryPIYNdzGKFk4BAt9kE8itNTowHo4cVl7dzAYlSk/Qpymeuh28DwNTw
         TAAvZWIxG5D2r0T7o7DIh3QTQmbnU1IMu2SUYYnv+7+VU9gzuPGogdk5MZOx8vbOTzNS
         h1gQ==
X-Gm-Message-State: AC+VfDyC/j8/rgSlbZjkpLeDx+qEZO74qH/04JynBQZPDUm3NLr7NNUz
	Ks7+UIiGzZazSouDCB3LamHEirEHFghlDfne8EpQX8wbCLPdHICSx4t0JGEv/ZhobhrGBfyroQj
	BfkDUMrzWeHAk4t4=
X-Received: by 2002:a05:620a:668a:b0:75b:23a1:1de9 with SMTP id qh10-20020a05620a668a00b0075b23a11de9mr1517614qkn.6.1684777728311;
        Mon, 22 May 2023 10:48:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ysOsc1RzD38SdHSthbb/q4xC7FUFG6jz1SX1t8MBP9yRpvbUhuvrF9pSL3x3ZDb5AAuJiYQ==
X-Received: by 2002:a05:620a:668a:b0:75b:23a1:1de9 with SMTP id qh10-20020a05620a668a00b0075b23a11de9mr1517602qkn.6.1684777728077;
        Mon, 22 May 2023 10:48:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-106.dyn.eolo.it. [146.241.241.106])
        by smtp.gmail.com with ESMTPSA id u23-20020a05620a121700b0075b09ae68b1sm1052571qkj.118.2023.05.22.10.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:48:47 -0700 (PDT)
Message-ID: <1d88e4860e959d792de27839c930cb7eca70af77.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 09/37] selftests: mptcp: lib: skip if not
 below kernel version
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 22 May 2023 19:48:45 +0200
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-9-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
	 <20230406-mptcp-issue-368-selftests-old-kernels-v2-9-50313e4f83ab@tessares.net>
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
> supporting all MPTCP features.
>=20
> A new function is now available to easily detect if a feature is
> missing by looking at the kernel version. That's clearly not ideal and
> this kind of check should be avoided as soon as possible. But sometimes,
> there are no external sign that a "feature" is available or not:
> internal behaviours can change without modifying the uAPI and these
> selftests are verifying the internal behaviours. Sometimes, the only
> (easy) way to verify if the feature is present is to run the test but
> then the validation cannot determine if there is a failure with the
> feature or if the feature is missing. Then it looks better to check the
> kernel version instead of having tests that can never fail.
>=20
> This new helper is going to be used in the following commits. In order
> to ease the backport of such future patches, it would be good if this
> patch is backported up to the introduction of MPTCP selftests, hence the
> Fixes tag below: this type of check was supposed to be done from the
> beginning.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 21 ++++++++++++++++++++=
+
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testi=
ng/selftests/net/mptcp/mptcp_lib.sh
> index 29b65f4b73b2..dcfe5eb6f7c0 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -76,3 +76,24 @@ mptcp_lib_kallsyms_doesnt_have() {
> =20
>  =09mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
>  }
> +
> +# !!!AVOID USING THIS!!!
> +# Features might not land in the expected version and features can be ba=
ckported

IMHO the above wording is a symptom we should not introduce this infra,
nor the patches using it.

Yep, self test will not be perfect on all older kernel :)

/P

