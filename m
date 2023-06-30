Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805D174C2
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688147600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nlgBxn/yXaYdsUQGc437JZ5qTZS7sCjkHPcZv8drxA=;
	b=A8d0xUAGbSwiF0vH8zzOxjo2rAhEn+Cplm2pi40Yo8E/SfruDUTzRXVZGan34DlerfI9tK
	RTj/G2NRr6ADkrLXb/X+I704it5IavzdSEPLRMZxU78/sR19cLv1kSgmII4iF8k80K3+nI
	0f6Kr5Ul/ivWNWctxofxIanZQus8TII=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-JcKNujCYPJqT-ZH9S5od4A-1; Fri, 30 Jun 2023 13:53:18 -0400
X-MC-Unique: JcKNujCYPJqT-ZH9S5od4A-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a361b64226so253128b6e.0
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 10:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688147598; x=1690739598;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YBbMmmZtWyqCBW4hFvUKtlTtEZ6I/v4rqJlq0ioPULQ=;
        b=BD4UlbhFt8sDWX8LSwn9xdr2vH9jwKLfts/hepvWefm0CHwNAbDKK199oEbWrVZ578
         +qohcnAI72TE6MeLLq1u17iJ1r1pPbZ0b6EqQ4zYRwPeUvEyxrKkapuuNYrjI2ZjW7pV
         nwrmEKoQhDSV0iQuU5LBd5JQoOlagRGujc9SIjfRZoSnfwjCWXgD6PaZrDmYnNkURE1g
         LNhWb5SDGcDgHnG2x0uCdg5xx0dU2yEPgnAAZgN0TjnB+0LSkViTfsWX22akjD+Oi5dG
         thRBYYkNL62mG8GbzBvnvAr3XPb93No6IpOd+bnvYyMhlmiTHaDmSSEUvQceqKjTk0yZ
         XWxQ==
X-Gm-Message-State: AC+VfDxsIIOHQrUkvg+gYU8S/nAZkZYfODeCFsgNG/zhOtNIsVtYIuWA
	N5UdeFMn4qd1upwJMqqB3MlXCbl/gbynWJWwY0XZScA7w1YnSNookLBV5b8A2FAi+739V+cvNt3
	KgXfKXBRmR3s83vmVBwA6c70=
X-Received: by 2002:aca:f08b:0:b0:39c:7f77:dcf4 with SMTP id o133-20020acaf08b000000b0039c7f77dcf4mr2641754oih.1.1688147597814;
        Fri, 30 Jun 2023 10:53:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Bb5i/zLxTGon3L7WtCcaA6edUnI5bjE3NrHE0WFv/cvmLMk7Sc0dlIkDESirXrdoKylku/Q==
X-Received: by 2002:aca:f08b:0:b0:39c:7f77:dcf4 with SMTP id o133-20020acaf08b000000b0039c7f77dcf4mr2641737oih.1.1688147597317;
        Fri, 30 Jun 2023 10:53:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id mi6-20020a056214558600b0062120b054easm3595930qvb.20.2023.06.30.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:53:16 -0700 (PDT)
Message-ID: <bbaa4c3440e8421a637a2ee8820287f57b443fa3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 14/18] selftests: mptcp: join: format
 subtests results in TAP
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 30 Jun 2023 19:53:14 +0200
In-Reply-To: <10c549f6-c83c-1a4c-415f-e2292dedb940@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
	 <20230621-mptcp-issue-368-selftests-subtests-v1-14-0cae453ae1fa@tessares.net>
	 <7dad11d32d2f6afb1f27a1a730f1976164b188b1.camel@redhat.com>
	 <10c549f6-c83c-1a4c-415f-e2292dedb940@tessares.net>
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

On Fri, 2023-06-30 at 17:00 +0200, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> Thank you for the reviews!
>=20
> On 30/06/2023 13:08, Paolo Abeni wrote:
> > On Wed, 2023-06-21 at 19:18 +0200, Matthieu Baerts wrote:
> > > The current selftests infrastructure formats the results in TAP 13. T=
his
> > > version doesn't support subtests and only the end result of each
> > > selftest is taken into account. It means that a single issue in a
> > > subtest of a selftest containing multiple subtests forces the whole
> > > selftest to be marked as failed. It also means that subtests results =
are
> > > not tracked by CIs executing selftests.
> > >=20
> > > MPTCP selftests run hundreds of various subtests. It is then importan=
t
> > > to track each of them and not one result per selftest.
> > >=20
> > > It is particularly interesting to do that when validating stable kern=
els
> > > with the last version of the test suite: tests might fail because a
> > > feature is not supported but the test didn't skip that part. In this
> > > case, if subtests are not tracked, the whole selftest will be marked =
as
> > > failed making the other subtests useless because their results are
> > > ignored.
> > >=20
> > > This patch formats subtests results in TAP in mptcp_join.sh selftest.
> > >=20
> > > In this selftest and before starting each subtest, the 'reset' functi=
on
> > > is called. We can then check if the previous test has passed, failed =
or
> > > has been skipped from there.
> > >=20
> > > Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 41 +++++++++++++++=
+++++-----
> > >  1 file changed, 33 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/=
testing/selftests/net/mptcp/mptcp_join.sh
> > > index e6c9d5451c5b..5c5c8b5e068f 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -39,7 +39,9 @@ evts_ns1=3D""
> > >  evts_ns2=3D""
> > >  evts_ns1_pid=3D0
> > >  evts_ns2_pid=3D0
> > > -stats_dumped=3D0
> > > +last_test_failed=3D0
> > > +last_test_skipped=3D0
> > > +last_test_ignored=3D1
> > > =20
> > >  declare -A all_tests
> > >  declare -a only_tests_ids
> > > @@ -97,7 +99,6 @@ init_partial()
> > >  =09=09fi
> > >  =09done
> > > =20
> > > -=09stats_dumped=3D0
> > >  =09check_invert=3D0
> > >  =09validate_checksum=3D$checksum
> > >  =09FAILING_LINKS=3D""
> > > @@ -162,9 +163,7 @@ check_tools()
> > >  =09elif ! iptables -V &> /dev/null; then
> > >  =09=09echo "SKIP: Could not run all tests without iptables tool"
> > >  =09=09exit $ksft_skip
> > > -=09fi
> > > -
> > > -=09if ! ip6tables -V &> /dev/null; then
> > > +=09elif ! ip6tables -V &> /dev/null; then
> >=20
> > The above chunk looks unrelated/unnecessary ?!? after the
> >=20
> > =09=09exit $ksft_skip
> >=20
> > above, we neither 'if' nor 'elif' will be executed ??!
>=20
> It is indeed a bit unrelated, it is just a small fix. Before, we had:
>=20
>   if iptables-legacy -V; then
>       iptables=3D"iptables-legacy"
>       ip6tables=3D"ip6tables-legacy"
>   elif ! iptables -V; then
>       exit error
>   fi
>=20
>   if ! ip6tables -V; then
>       exit error
>   fi


Ah, ok, I missed the first few lines of context.
>=20
> if iptables-legacy is available, we will use "ip6tables-legacy" command
> instead of "ip6tables". So no need to look for "ip6tables" command we
> will not use (hence the "elif" instead of the "if").
>=20
> But I can also drop this chunk if you prefer.

Just moving it to a new patch would be enough.

>=20
>=20
> > >  =09=09echo "SKIP: Could not run all tests without ip6tables tool"
> > >  =09=09exit $ksft_skip
> > >  =09fi
> > > @@ -213,6 +212,8 @@ mark_as_skipped()
> > > =20
> > >  =09print_title "[ skip ] ${msg}"
> > >  =09printf "\n"
> > > +
> > > +=09last_test_skipped=3D1
> > >  }
> > > =20
> > >  # $@: condition
> > > @@ -245,14 +246,32 @@ skip_test()
> > >  =09return 0
> > >  }
> > > =20
> > > +append_prev_results()
> > > +{
> > > +=09if [ ${last_test_failed} -eq 1 ]; then
> > > +=09=09mptcp_lib_result_fail "${TEST_NAME}"
> > > +=09elif [ ${last_test_skipped} -eq 1 ]; then
> > > +=09=09mptcp_lib_result_skip "${TEST_NAME}"
> > > +=09elif [ ${last_test_ignored} -ne 1 ]; then
> > > +=09=09mptcp_lib_result_pass "${TEST_NAME}"
> > > +=09fi
> > > +
> > > +=09last_test_failed=3D0
> > > +=09last_test_skipped=3D0
> > > +=09last_test_ignored=3D0
> > > +}
> > > +
> > >  # $1: test name
> > >  reset()
> > >  {
> > > +=09append_prev_results
> >=20
> > Can't we dump the previous sub-test result here in tap format (when/if
> > enabled) instead of dumping them all at the end?
>=20
> I guess we can: Linaro's script should catch the different subtests. But
> I don't think we should do that: from what I understood to be TAP 13
> compliant, we are supposed to write the "test plan" before displaying
> the results: so we need one line indicating the number of tests that are
> going to be done (e.g. "1..115") and before starting the first test, we
> don't know how many tests will be executed yet.

Understood. Then let's keep the layout used this revision of the
patches.


/P

