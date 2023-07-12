Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03536100A5
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689150857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeEz6+zxg8tTxvbNF3pgeoH5UAx7QIyl8liCOaSRDx8=;
	b=DaMnCXmg+TLqlcqiKcHXDbnD0IpCGOoI/c9EYTF4X4TaK/Id7zC8tz/63E41jQf9DCU5ZM
	VTAZUJCxXw+2EuMKCjpS00MEpE8Y+mY0Ynl9ZVF3dix7BweJJ1aodlzgwvRqilbllkWdvk
	+f73E6Xd/HVm64Im4+r5SQeQxLMZh4I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-WN3XgIkMMUGbjWabtNUcyQ-1; Wed, 12 Jul 2023 04:34:12 -0400
X-MC-Unique: WN3XgIkMMUGbjWabtNUcyQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635de6f75e0so15250066d6.1
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 01:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689150852; x=1691742852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NC9kjNOS4dR7paJ62bP8dBIiWkvgMr2YdgQ5Z01yFPI=;
        b=ik7l57ERs28cBkon/ZLEdohQL+3lUhPnIx+prPne12nJk9NI4HbW6lzoD7JyKbVZiC
         p20xFbXpjhFEJNLIpS34RMxJyA6AXEDZqz51Uz73zXMqlJY6S8xYiCFuPEv65nZuioxm
         odllA1B50Sv7t/3MjOtHvp0MPocPJ94yljfJYjIgsr2KReg1kfc69rZYpXiOsFa/4nCO
         1Wep0K9shLxuLAsthUU3b3gWocA0ZanGlIFhmMNKC6FhS+DELS38TLrgK9Lc/jR83Chj
         lFTtGVuB+qNlohPFr+jsR4uI9fAaQ9vmGzhmQt9CgRFSZhNprV15Rq6Sv2IixLXtT3cy
         RnHw==
X-Gm-Message-State: ABy/qLbVfEyXK8shP1SrYuwWjLO8BXdmAfnNvD9dAhUnUAxKB4DImfkg
	ou74XEzLhKmrv+dFKXhblgItCk3fUIlrgQdVdRk1odcwjwDBKaKOTmafkwNIdkChUxTEqyRuDB2
	LEvIVqFz4BJQkhvdGn+Kipg4=
X-Received: by 2002:a05:6214:29e1:b0:626:2305:6073 with SMTP id jv1-20020a05621429e100b0062623056073mr19473377qvb.4.1689150852183;
        Wed, 12 Jul 2023 01:34:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH14UQ9xUh3w5imxASAm7FuWjywnuWi5hP102IJ1wqEAtcS2a/2yle0zYQkYe1Kn1UW0BueIQ==
X-Received: by 2002:a05:6214:29e1:b0:626:2305:6073 with SMTP id jv1-20020a05621429e100b0062623056073mr19473369qvb.4.1689150851877;
        Wed, 12 Jul 2023 01:34:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2041189qvk.14.2023.07.12.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:34:11 -0700 (PDT)
Message-ID: <e8e801ee4344f0b68a3c484b58c6f413eba09a92.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: join: rework detailed
 report
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 12 Jul 2023 10:34:09 +0200
In-Reply-To: <20230628144927.828117-2-matthieu.baerts@tessares.net>
References: <20230628144927.828117-1-matthieu.baerts@tessares.net>
	 <20230628144927.828117-2-matthieu.baerts@tessares.net>
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

On Wed, 2023-06-28 at 16:49 +0200, Matthieu Baerts wrote:
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 5c5c8b5e068f..3a0e2fa7754b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -49,7 +49,7 @@ declare -a only_tests_names
>  declare -A failed_tests
>  TEST_COUNT=3D0
>  TEST_NAME=3D""
> -nr_blank=3D40
> +nr_blank=3D6
> =20
>  export FAILING_LINKS=3D""
>  export test_linkfail=3D0
> @@ -184,8 +184,8 @@ init() {
> =20
>  =09trap cleanup EXIT
> =20
> -=09make_file "$cin" "client" 1
> -=09make_file "$sin" "server" 1
> +=09make_file "$cin" "client" 1 >/dev/null
> +=09make_file "$sin" "server" 1 >/dev/null
>  }
> =20
>  cleanup()
> @@ -197,10 +197,34 @@ cleanup()
>  =09cleanup_partial
>  }
> =20
> -# $1: msg
>  print_title()
>  {
> -=09printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${1}"
> +=09printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
> +}
> +
> +print_check()
> +{
> +=09printf "%-${nr_blank}s%-36s" " " "${*}"
> +}
> +
> +print_info()
> +{
> +=09printf "%-${nr_blank}sInfo: %s\n" " " "${*}"

In most case print_info is invoked like this:

=09if [ -n "$extra_msg" ]; then
=09=09print_info "$extra_msg"
=09fi

so what's about moving such check here?

print_info()
{
=09[ -n "${*}" ] || return
=09printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
}

Not a big deal, it looks like a nice cleanup no matter what!

Thanks,

Paolo

