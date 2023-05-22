Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF9A1640B
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684776382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49maoHuN18VSg+pOeU173yqYEA9a2DY1+8VlhqnE9B8=;
	b=eLeLK3muAadutUQUvASI/BBSIs0RIzX52Kq3qm13hG9RfNg/UbJUO9JkCXrs5ToAo0t9MY
	hALP6XcZtRy5FpsYuDV22fmqT9gP3HCl7e1BbQdo1N/gFY2D2ZHnxxkJ2a6gHnhlxDajDK
	Vtv4GpoL0eW0yYhnVrA97hBOw0IniP4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-3v-4gZmXMYaVxMqaGxI1RQ-1; Mon, 22 May 2023 13:26:19 -0400
X-MC-Unique: 3v-4gZmXMYaVxMqaGxI1RQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-623a2273194so7717886d6.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 10:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684776379; x=1687368379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQFjCA0IbaBFbcI+5JZ9fyQ/yTiq5uaVZhmjzibEGUg=;
        b=VTbRbb2w0mbBslk/eTxP1gbBHo3ClEZA3XmOApdaCC5PLdoFz1sjVcoRgHirwSWrTW
         BFzFF9M0BJLZuwzMN8hCwvl7He9O5LFSytewZIUFi16jcxqV6HDClqmou/K3txAAHkq8
         FxEDdfIyawV4mSXzB6zTlJy9etig9XFvaymXsuPKMz4yvalTJtfuvk6HMP4mM+Tucodh
         G+257MR+iyU1MiLx6fe1ewzEGJVAtxnE+BB5VEEah5X9qDAzQwLpPCMJDvjiibr6GIP5
         wsGk56kauASxqPotk0fYeKT5kwXOMHYSxGTP8U2O2l1iV4my/I7xC4SzKofJKjB4+pTg
         lDMA==
X-Gm-Message-State: AC+VfDw5fo1VsQ4YvFB6CvIH5/FgXiL1XhTRPD0KpSCDufYLyKGMTRji
	A15zgJwXXM8pc+NVEMLbejnPVy9wAtGEtAv/RIqa9SFm8KqWOMIxm5qSuTPV5ZWpzPqdPkz+I0d
	nwzlT+IkzrpsCV+sokf5gLPY=
X-Received: by 2002:a05:6214:5099:b0:623:5678:1285 with SMTP id kk25-20020a056214509900b0062356781285mr19414079qvb.2.1684776379227;
        Mon, 22 May 2023 10:26:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5A0EOqlwStafH0FeJSik9ntbw/+Vv3uyHvQUezro73eqUfB03hkmqaHVG6cw36NIF7iyU/0w==
X-Received: by 2002:a05:6214:5099:b0:623:5678:1285 with SMTP id kk25-20020a056214509900b0062356781285mr19414060qvb.2.1684776378878;
        Mon, 22 May 2023 10:26:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-106.dyn.eolo.it. [146.241.241.106])
        by smtp.gmail.com with ESMTPSA id mh2-20020a056214564200b00621430707f7sm2085119qvb.83.2023.05.22.10.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:26:18 -0700 (PDT)
Message-ID: <b27d8f3c79b0f8b019af868f33864a746439e62d.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 10/37] selftests: mptcp: connect: skip
 transp tests if not supported
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 22 May 2023 19:26:16 +0200
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-10-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
	 <20230406-mptcp-issue-368-selftests-old-kernels-v2-10-50313e4f83ab@tessares.net>
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
> One of them is the support of IP(V6)_TRANSPARENT socket option with
> MPTCP connections introduced by commit c9406a23c116 ("mptcp: sockopt:
> add SOL_IP freebind & transparent options").
>=20
> It is possible to look for "__ip_sock_set_tos" in kallsyms because
> IP(V6)_TRANSPARENT socket option support has been added after TOS
> support which came with the required infrastructure in MPTCP sockopt
> code. To support TOS, the following function has been exported (T). Not
> great but better than checking for a specific kernel version.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: 5fb62e9cd3ad ("selftests: mptcp: add tproxy test case")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index c1f7bac19942..c6fcae6b2562 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -144,6 +144,7 @@ cleanup()
>  }
> =20
>  mptcp_lib_check_mptcp
> +mptcp_lib_check_kallsyms
> =20
>  ip -Version > /dev/null 2>&1
>  if [ $? -ne 0 ];then
> @@ -695,6 +696,15 @@ run_test_transparent()
>  =09=09return 0
>  =09fi
> =20
> +=09# IP(V6)_TRANSPARENT has been added after TOS support which came with
> +=09# the required infrastructure in MPTCP sockopt code. To support TOS, =
the
> +=09# following function has been exported (T). Not great but better than
> +=09# checking for a specific kernel version.
> +=09if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
> +=09=09echo "INFO: TFO not supported by the kernel: SKIP"

Possibly sed -e s/TFO/TOS/ ?

/P

