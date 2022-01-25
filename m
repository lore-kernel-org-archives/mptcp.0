Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D3168
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 03:24:06 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id i1so173802pla.9
        for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 19:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c8pYFYzVE1bsezK4cCOJhb+1EltcQ8k1h4b2JgRR+GM=;
        b=AMIPugj6cMynJvvHDJfXUUpIIuAGBShsJn+ghemZ9q58w0aI2udUofx1yxq7Djb6w7
         K4IryWlGgQl8PT9FMpZZ88zjgL9DdXvmOByhZuVRO0+4RlOROYvTkSYMHApCx+MnW1RL
         BF5yZSXvHLbvCaaLr4N/LWNSndDEyBlRNnkBZC9qx2VOFbI4HhI5wvU8g1AVRGM6sdls
         BAk1Z4O9h+p2MNlOJbhXqfeBSKTt4ENxV/PMOEw4ZuF4zzKdgZLd7SFph0aHMQOS/F6H
         TujDOR32y0PxP2i00eSCRH7ChFTJRRQpv66x89RRRHxLHRQx98dyYDkI+7IAKrkRHPt1
         HxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c8pYFYzVE1bsezK4cCOJhb+1EltcQ8k1h4b2JgRR+GM=;
        b=SvpV5c62IstI0Zpop52SsbE0wW7+HZBm/H4eySSaN1QAo5FgUSi9Rvi16X5w2lS4Qp
         ruol0UNUV0CgZGqqJ45gvKqVix7QZeJdPS1/FPgbVFT+9R0musAtCS4QKdQsJx5gWLu9
         gTBvwKos5TX2vDJ23EqV1XYdtvuODo+8Kkxxt+VpWhHa/e64acmuXbptwevCQRplOKRf
         hKjlDnqmwiuGX99csF6s2VWOzVxaK0jFJ6/OBJPCj9cSs7nhkU7cx9pvFB/avZ1a5COm
         cUaY/BcEPj+pSxJUVuciEcpR3GSXlEv4XhLK0jm9ipuhNmj6pRmVYsCZYj+ShzzrRHdV
         u7FA==
X-Gm-Message-State: AOAM533JuOHtdGFiTeSdsjnkl+eAnQvUplZpLBTOSljTRguFkPmx5w7n
	ksKhdDR9hUZDhUzqrjCMm0I+z0InuX5ZwMSaJVI=
X-Google-Smtp-Source: ABdhPJyVMGb2+fAFt37YnGZUvKs8YSH1lLiOJTGbegPORLmiYC8usIsxxWxeBYJWd3Y6g3bf7SGeNF1qjMAclqN/NdU=
X-Received: by 2002:a17:902:e54c:b0:14b:3548:cfc4 with SMTP id
 n12-20020a170902e54c00b0014b3548cfc4mr11211614plf.102.1643081046435; Mon, 24
 Jan 2022 19:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
 <20220122093135.4023846-3-matthieu.baerts@tessares.net> <CA+WQbwuSJ-WZuQFEjTAtD5ycodbiC0mZ7dwDWQa0VEWsOPSO=g@mail.gmail.com>
 <fc920e6d-72fe-49c8-e31f-920fbd15c952@tessares.net>
In-Reply-To: <fc920e6d-72fe-49c8-e31f-920fbd15c952@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 25 Jan 2022 11:24:13 +0800
Message-ID: <CA+WQbwt_aqrVBFZyTLBp7TBrioVk_bxFKFos2GOgFLG=2Xto1g@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: add missing join check
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

I guess we will get this error:

'''
01 signal addresses race test           syn[fail] got 2 JOIN[s] syn expecte=
d 3
 - synack[fail] got 2 JOIN[s] synack expected 3
 - ack[fail] got 2 JOIN[s] ack expected 3

                                        add[ ok ] - echo  [ok]
'''

But it didn't happen in my tests. I only got this error:

'''
01 signal addresses race test           syn[fail] got 2 JOIN[s] syn expecte=
d 3
 - synack[fail] got 2 JOIN[s] synack expected 3
 - ack[fail] got 2 JOIN[s] ack expected 3

                                        add[ ok ] - echo  [fail] got 2
ADD_ADDR echo[s] expected 3
'''

I'm not sure now. Please ignore my comments.

Thanks,
-Geliang

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B41=E6=
=9C=8824=E6=97=A5=E5=91=A8=E4=B8=80 17:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> Thank you for looking at that!
>
> On 22/01/2022 15:04, Geliang Tang wrote:
> > I think in this test chk_join_nr is omitted on purpose, since it is mor=
e
> > likely to fail. As we can see, chk_add_nr failed sometimes, if we add t=
his
> > chk_join_nr, it will fail more frequently.
>
> May you explain why this tests is likely to fail? Both the commit
> message and the comment in the code don't explain that.
>
> > Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B41=
=E6=9C=8822=E6=97=A5=E5=91=A8=E5=85=AD 17:32=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> This function also writes the name of the test with its ID, making cle=
ar
> >> a new test has been executed.
> >>
> >> Without that, the ADD_ADDR results from this test was appended at the
> >> end of the previous test causing confusions. Especially when the secon=
d
> >> test was failing, we had:
> >>
> >>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
> >>                                   add[ ok ] - echo  [ ok ]
> >>                                   add[fail] got 2 ADD_ADDR[s] expected=
 3
> >>
> >> In fact, this 17th test was OK but not the 18th one.
> >>
> >> Now we have:
> >>
> >>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
> >>                                   add[ ok ] - echo  [ ok ]
> >>   18 signal addresses race test   syn[ ok ] - synack[ ok ] - ack[ ok ]
> >>                                   add[fail] got 2 ADD_ADDR[s] expected=
 3
> >
> > I think if chk_add_nr fail here, chk_join_nr must fail too. If we got 2
> > ADD_ADDR[s], we got 2 JOIN[s] syn too, not 3. Furthermore, if chk_add_n=
r
> > passed, we can't make sure chk_join_nr will pass too. Since MP_JOIN is
> > translated after ADD_ADDR, it may be lost.
>
> Indeed, to simplify the commit message, I mixed both a "success" and a
> "failure" output. I should not have done that and only put a "success"
> one to keep the output small.
>
> >> Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
> >> Reported-by: Paolo Abeni <pabeni@redhat.com>
> >> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> ---
> >>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_join.sh
> >> index 76c45c845d3b..67be3e1215d7 100755
> >> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> @@ -1342,6 +1342,7 @@ signal_address_tests()
> >>         pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
> >>         pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
> >>         run_tests $ns1 $ns2 10.0.1.1
> >> +       chk_join_nr "signal addresses race test" 3 3 3
> >
> > I think we can omit the join numbers check, just print out the name of =
the
> > test. Don't pass the join numbers to chk_join_nr, just the msg:
> >
> >         chk_join_nr "signal addresses race test"
>
> Do you mean we could have situations where ADD_ADDR have been properly
> sent and received but we check counters just before MPJ are emitted? In
> this case we would mark the test as failed because MPJs are not OK
> (checked too soon in fact) while ADD_ADDR are?
>
> If yes and if it helps, we can also wait for the kernel to have sent
> exactly 3 ADD_ADDR before checking the MPJ. On the other hand, do we not
> already cover this UC where we look for MPJs emitted after having
> received an ADD_ADDR, no?
>
> If we keep checking all counters, I think it might be clearer: MPJ
> counters are not OK because we didn't receive/process the ADD_ADDR, no?
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
