Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831DA2C82
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 14:04:35 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id n16-20020a17090a091000b001b46196d572so11742412pjn.5
        for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 06:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cD2IA0ZrviIf/Ni2lDhxK6QL//vfIx2BO6EEm1KmdYc=;
        b=ECT9nCfmM4y2M5QPYh3+SNG3qPJzW1th6uUe3Y+Utng0HgoyrmQS8PaE1WCZQrtM1a
         ebuzGSerQNCOZxf8l6SwMUzjrj89pKTTeynbU4NH4JWbqlCpNBX7e84kmy5WRibZr5AZ
         QfzyBgxXG5mIsONrnp1FtWuj5xTHRZY4yBKuCYlmLiL+ShXmyC6iGxx8uLO5lnEU9lOA
         6hsX0EQP1LnxdVVSnL3ffkx+mQ+vgPkkqUvFKQrWTjUwx2ZYkpr1B2Lm5BF9Ruh1jI45
         hU/s9hO+A+QDVYp80kcpD9Icn3jXlX4wBR17BR99bs1r28Hd4sS41GhYrrZWDu1ntiCJ
         L0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cD2IA0ZrviIf/Ni2lDhxK6QL//vfIx2BO6EEm1KmdYc=;
        b=0SLTf+AlnDTFPGAljkncx/PTH2097+VyNB4nmYTi09yG7KDFATY916llJMysJjXuDk
         vrmfHKLc4tlqz07XbeVOj7znBqYYXVruErXNP3pEY+Xa5xiJwKpnSJY+hzYK1yS/Neb8
         icmQ8mQJTioLAzTDkjpFK/HSC1PtkTLhxWzFiqshswyTa1E0GznBPVRoo7a5LkqAgrAk
         kpfwFpre3ujs5yth3ao1SC3C5mHFsiozUUxmGUNZwjA1Ev+107mBoQn/JDt+XOSj72vu
         HQnVlEIu3igYuN59q7BmxxLHU/nx/Tcs+ry/S+mozk+izdj8AvU9iul0u5019CtscGuA
         BA5w==
X-Gm-Message-State: AOAM532DKTckIT2d6glUJmLiN+p2xhvFEd6As/bUk+MhjQdsuBMjOaVJ
	p+fbK0p2ezL8kbvpzm3HE8Hyoy8U3U/+c3Ttbz8=
X-Google-Smtp-Source: ABdhPJw7n09AXwly6i5wdo6/59u0+BsEaqZE5Ouf/6XVAfXu+2kLDiLT3KO7STOF+HJvcbv8PEwZVC/rro5AZIh2E5w=
X-Received: by 2002:a17:902:e54c:b0:14b:3548:cfc4 with SMTP id
 n12-20020a170902e54c00b0014b3548cfc4mr2054585plf.102.1642860274896; Sat, 22
 Jan 2022 06:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net> <20220122093135.4023846-3-matthieu.baerts@tessares.net>
In-Reply-To: <20220122093135.4023846-3-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sat, 22 Jan 2022 22:04:39 +0800
Message-ID: <CA+WQbwuSJ-WZuQFEjTAtD5ycodbiC0mZ7dwDWQa0VEWsOPSO=g@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: add missing join check
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

I think in this test chk_join_nr is omitted on purpose, since it is more
likely to fail. As we can see, chk_add_nr failed sometimes, if we add this
chk_join_nr, it will fail more frequently.

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B41=E6=
=9C=8822=E6=97=A5=E5=91=A8=E5=85=AD 17:32=E5=86=99=E9=81=93=EF=BC=9A
>
> This function also writes the name of the test with its ID, making clear
> a new test has been executed.
>
> Without that, the ADD_ADDR results from this test was appended at the
> end of the previous test causing confusions. Especially when the second
> test was failing, we had:
>
>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   add[ ok ] - echo  [ ok ]
>                                   add[fail] got 2 ADD_ADDR[s] expected 3
>
> In fact, this 17th test was OK but not the 18th one.
>
> Now we have:
>
>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   add[ ok ] - echo  [ ok ]
>   18 signal addresses race test   syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   add[fail] got 2 ADD_ADDR[s] expected 3

I think if chk_add_nr fail here, chk_join_nr must fail too. If we got 2
ADD_ADDR[s], we got 2 JOIN[s] syn too, not 3. Furthermore, if chk_add_nr
passed, we can't make sure chk_join_nr will pass too. Since MP_JOIN is
translated after ADD_ADDR, it may be lost.

>
> Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 76c45c845d3b..67be3e1215d7 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1342,6 +1342,7 @@ signal_address_tests()
>         pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
>         pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
>         run_tests $ns1 $ns2 10.0.1.1
> +       chk_join_nr "signal addresses race test" 3 3 3

I think we can omit the join numbers check, just print out the name of the
test. Don't pass the join numbers to chk_join_nr, just the msg:

        chk_join_nr "signal addresses race test"

Then in chk_join_nr, test the input numbers before doing the numbers check:

'''
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -918,7 +918,7 @@ chk_join_nr()
     printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
     count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx |
awk '{print $2}'`
     [ -z "$count" ] && count=3D0
-    if [ "$count" !=3D "$syn_nr" ]; then
+    if [ -n "$syn_nr" ] && [ "$count" !=3D "$syn_nr" ]; then
         echo "[fail] got $count JOIN[s] syn expected $syn_nr"
         ret=3D1
         dump_stats=3D1
@@ -929,7 +929,7 @@ chk_join_nr()
     echo -n " - synack"
     count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx
| awk '{print $2}'`
     [ -z "$count" ] && count=3D0
-    if [ "$count" !=3D "$syn_ack_nr" ]; then
+    if [ -n "$syn_ack_nr" ] && [ "$count" !=3D "$syn_ack_nr" ]; then
         echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
         ret=3D1
         dump_stats=3D1
@@ -940,7 +940,7 @@ chk_join_nr()
     echo -n " - ack"
     count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx |
awk '{print $2}'`
     [ -z "$count" ] && count=3D0
-    if [ "$count" !=3D "$ack_nr" ]; then
+    if [ -n ""$ack_nr"" ] && [ "$count" !=3D "$ack_nr" ]; then
         echo "[fail] got $count JOIN[s] ack expected $ack_nr"
         ret=3D1
         dump_stats=3D1
'''

WDYT?

Thanks,
-Geliang

>
>         # the server will not signal the address terminating
>         # the MPC subflow
> --
> 2.33.1
>
>
