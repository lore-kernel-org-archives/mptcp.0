Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C009134A2
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688123343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OiUAkY6cEkQqVSPrB94Im1e+/RpogLX9VoT7890oaQ=;
	b=d8lYwLVJAzZTFc3oACS5SG/0GmHuCJxrZEHvsWqr/wd1x+CrHjVa0Ow6VZkGLcPc/IWbRF
	9k0JPZdDzr9g2hrlybI3rtKINCzsZWj4d74s9zFTKqhT6S/4ggGr54Aqn9qN02fgRvMV5y
	lGg3vxIVSG2FImhKxes2xGEqLuuQ0cY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-Rncvx8g9OWaXCpfhvWeBMA-1; Fri, 30 Jun 2023 07:09:02 -0400
X-MC-Unique: Rncvx8g9OWaXCpfhvWeBMA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e2618aaeso2972886d6.0
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 04:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688123327; x=1690715327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOSeGaavPQKIuUHGXgwUdl8GVjBSm8Fp7/kmXn3PdLM=;
        b=C/u5hBvtgPyCWPqvLSVJY7mhTy2MAFrKEK7gLA79m9j05/UnveXGZvrSqpoF8HX97k
         QFoBSErsh/ckDNwNRFAW3SaFjqybs650TeY9JoiVeY9XlB6QWQXOtNv+3PWkkQSLhBvx
         0blDu1LR3GH8YbnjokcoFfGIOINXWqT7ZIsq5/Tze8L6GBHnQqTXFYFLxbI25IpnRsla
         kqmYJBvV/kVJNjsLUPZ9a1VCMyugZoTri87MUT3/6y4oXfYVw9vBhdDJ7OY8+mmYg2Z6
         PdD7RvBrcnf4a+vNZPcWzwfgrM7OXodcbqtmEGVqrX7q5oS1tSIxTGdIMhNM1cEI3CtS
         mUKg==
X-Gm-Message-State: AC+VfDzL8cL8oVKcqpa1Q4fJoxMsys21nUbCLEMHoBqfHxSMepOB1cBN
	b8Fro8UpSzeilMOcioEkZCVqWuXyT5DSWXjRRh5iaqW27Ly8tsaBgY9snL/jv5/NOkOWxSFrdqK
	YEj7skbbkxlvLLBlmSRrqdb4=
X-Received: by 2002:a05:620a:45a8:b0:75b:23a1:69ee with SMTP id bp40-20020a05620a45a800b0075b23a169eemr2686808qkb.5.1688123326841;
        Fri, 30 Jun 2023 04:08:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qSfeIWdvFzHRcVRHgUL0RQ968PghoQe5qB7DFG3fpyyi8263Rdy8JLNvHKstkU5+KmBBWWg==
X-Received: by 2002:a05:620a:45a8:b0:75b:23a1:69ee with SMTP id bp40-20020a05620a45a800b0075b23a169eemr2686790qkb.5.1688123326503;
        Fri, 30 Jun 2023 04:08:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id m9-20020ae9e709000000b007672e3348edsm1712862qka.108.2023.06.30.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:08:46 -0700 (PDT)
Message-ID: <7dad11d32d2f6afb1f27a1a730f1976164b188b1.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 14/18] selftests: mptcp: join: format
 subtests results in TAP
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 30 Jun 2023 13:08:43 +0200
In-Reply-To: <20230621-mptcp-issue-368-selftests-subtests-v1-14-0cae453ae1fa@tessares.net>
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
	 <20230621-mptcp-issue-368-selftests-subtests-v1-14-0cae453ae1fa@tessares.net>
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

On Wed, 2023-06-21 at 19:18 +0200, Matthieu Baerts wrote:
> The current selftests infrastructure formats the results in TAP 13. This
> version doesn't support subtests and only the end result of each
> selftest is taken into account. It means that a single issue in a
> subtest of a selftest containing multiple subtests forces the whole
> selftest to be marked as failed. It also means that subtests results are
> not tracked by CIs executing selftests.
>=20
> MPTCP selftests run hundreds of various subtests. It is then important
> to track each of them and not one result per selftest.
>=20
> It is particularly interesting to do that when validating stable kernels
> with the last version of the test suite: tests might fail because a
> feature is not supported but the test didn't skip that part. In this
> case, if subtests are not tracked, the whole selftest will be marked as
> failed making the other subtests useless because their results are
> ignored.
>=20
> This patch formats subtests results in TAP in mptcp_join.sh selftest.
>=20
> In this selftest and before starting each subtest, the 'reset' function
> is called. We can then check if the previous test has passed, failed or
> has been skipped from there.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 41 +++++++++++++++++++=
+-----
>  1 file changed, 33 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index e6c9d5451c5b..5c5c8b5e068f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -39,7 +39,9 @@ evts_ns1=3D""
>  evts_ns2=3D""
>  evts_ns1_pid=3D0
>  evts_ns2_pid=3D0
> -stats_dumped=3D0
> +last_test_failed=3D0
> +last_test_skipped=3D0
> +last_test_ignored=3D1
> =20
>  declare -A all_tests
>  declare -a only_tests_ids
> @@ -97,7 +99,6 @@ init_partial()
>  =09=09fi
>  =09done
> =20
> -=09stats_dumped=3D0
>  =09check_invert=3D0
>  =09validate_checksum=3D$checksum
>  =09FAILING_LINKS=3D""
> @@ -162,9 +163,7 @@ check_tools()
>  =09elif ! iptables -V &> /dev/null; then
>  =09=09echo "SKIP: Could not run all tests without iptables tool"
>  =09=09exit $ksft_skip
> -=09fi
> -
> -=09if ! ip6tables -V &> /dev/null; then
> +=09elif ! ip6tables -V &> /dev/null; then

The above chunk looks unrelated/unnecessary ?!? after the

=09=09exit $ksft_skip

above, we neither 'if' nor 'elif' will be executed ??!


=09=09

>  =09=09echo "SKIP: Could not run all tests without ip6tables tool"
>  =09=09exit $ksft_skip
>  =09fi
> @@ -213,6 +212,8 @@ mark_as_skipped()
> =20
>  =09print_title "[ skip ] ${msg}"
>  =09printf "\n"
> +
> +=09last_test_skipped=3D1
>  }
> =20
>  # $@: condition
> @@ -245,14 +246,32 @@ skip_test()
>  =09return 0
>  }
> =20
> +append_prev_results()
> +{
> +=09if [ ${last_test_failed} -eq 1 ]; then
> +=09=09mptcp_lib_result_fail "${TEST_NAME}"
> +=09elif [ ${last_test_skipped} -eq 1 ]; then
> +=09=09mptcp_lib_result_skip "${TEST_NAME}"
> +=09elif [ ${last_test_ignored} -ne 1 ]; then
> +=09=09mptcp_lib_result_pass "${TEST_NAME}"
> +=09fi
> +
> +=09last_test_failed=3D0
> +=09last_test_skipped=3D0
> +=09last_test_ignored=3D0
> +}
> +
>  # $1: test name
>  reset()
>  {
> +=09append_prev_results

Can't we dump the previous sub-test result here in tap format (when/if
enabled) instead of dumping them all at the end?

/P

