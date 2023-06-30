Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA2E134A2
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688122327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n34Oh7KbK7lPP0cm2wRIVJA2mNSuENGAle2yBOIDi6s=;
	b=QngxXuQUJdWbxLgSlaSa8a3ZbwbpendVn4qqOA+wEiXYj2EuQOsPSabWX4lGx66VaaHcEi
	wXzedKR7Z+O6lfm5nSPjXnUos4P2YzmwYg3nlbzdMDbbxHyyLlb7s18DLKXwXbM3lcZqGS
	QAjPBXkY2chL8wEhVGbdMJhzY4M4lFo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385--NQaUKh1Mo6OcN_7dQdcVQ-1; Fri, 30 Jun 2023 06:52:06 -0400
X-MC-Unique: -NQaUKh1Mo6OcN_7dQdcVQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765ad67e690so34567685a.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 03:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688122326; x=1690714326;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxYsCIYcyFMhgCi/6lVLhRfWfceM2Bc5TCeR19hfMPw=;
        b=YC/krc6S8zASxI3LVocy3UGjVg2QOAO8yzu71n5DTV/Q7bDAdFji9eWjRf2gIEQinW
         c7cEJUp1bgAmK/qfAEfIqgbBQl1NBa3LlBBjgNkHniJueQgc6/Xf/XxOHZZfMumbX9e6
         cry3pLjc3kzRkmHujQiTvRWTAUceyrM2gxT7Ao+0nOzCo5sk042CZN7qxkksssmGwIOs
         cG5o+Kcovs3Mwj59A8tVS0/LfIgPnLqKnrV/pslsPaRa1FgjAjKZZsEaUOkcF247NAZA
         4WKnmCaRanfoKVpT8I2rFLUlH5uEIVSXC1BbrnMhO25wufgzpxwieBlIb2lwvk1zHJ3d
         8cmg==
X-Gm-Message-State: AC+VfDwwfWSJt5fMYemZZzC5pJHsGU/Orssce2C950gSHZbMx9n+vkBG
	aNIcB3CCW1KW4EK8ihnSzGI9tVF+/I5yYBjkErN1fgnAnfv35kJkJQlOX6Pp1VwBFT1I5YKxWA/
	lTAw5ZHriO9O8AXo=
X-Received: by 2002:a05:620a:248a:b0:767:170d:887a with SMTP id i10-20020a05620a248a00b00767170d887amr2846266qkn.2.1688122325959;
        Fri, 30 Jun 2023 03:52:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jwCpqdKF7DycR+ontMBVh3KK4ufcls+ogYu4cfmyykD9FLKP516tSPWO43l9J9ZmddJNmGg==
X-Received: by 2002:a05:620a:248a:b0:767:170d:887a with SMTP id i10-20020a05620a248a00b00767170d887amr2846250qkn.2.1688122325624;
        Fri, 30 Jun 2023 03:52:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a15cf00b00763b9b390b1sm501114qkm.107.2023.06.30.03.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:52:05 -0700 (PDT)
Message-ID: <76ee3a32adb98108a88c81babcfbb9cf3edd724c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 06/18] selftests: mptcp: connect: don't stop
 if error
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 30 Jun 2023 12:52:02 +0200
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-6-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
	 <20230621-mptcp-issue-368-selftests-subtests-v1-6-0cae453ae1fa@tessares.net>
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

browsers! ;)
On Wed, 2023-06-21 at 19:18 +0200, Matthieu Baerts wrote:
> No more tests were executed after a failure but it is still interesting
> to get results for all the tests to better understand what's still OK
> and what's not after a modification.
>=20
> Now we only exit earlier if the basic tests are failing: no ping going
> through namespaces or unable to transfer data on the loopback interface.
>=20
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 27 ++++++++++++++++=
------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index 780b8fef2261..dba58875ef4c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -7,6 +7,7 @@ time_start=3D$(date +%s)
> =20
>  optstring=3D"S:R:d:e:l:r:h4cm:f:tC"
>  ret=3D0
> +final_ret=3D0
>  sin=3D""
>  sout=3D""
>  cin_disconnect=3D""
> @@ -837,14 +838,25 @@ display_time()
>  =09echo "Time: ${time_run} seconds"
>  }
> =20
> -stop_if_error()
> +log_if_error()
>  {
>  =09local msg=3D"$1"
> =20
>  =09if [ ${ret} -ne 0 ]; then
>  =09=09echo "FAIL: ${msg}" 1>&2
> +
> +=09=09final_ret=3D${ret}
> +=09=09ret=3D0
> +
> +=09=09return ${final_ret}
> +=09fi

It's not clear to me which is the return value for log_if_error() in
the '${ret} -eq 0' case.

What about moving the return after the 'if' statement?

Cheers,

Paolo

