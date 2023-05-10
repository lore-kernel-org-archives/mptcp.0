Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C4373
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 04:14:23 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30786c87cdaso4155961f8f.2
        for <mptcp@lists.linux.dev>; Tue, 09 May 2023 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683692061; x=1686284061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDlLkGJJBvLHoO3Mn26cbL245NbENReWXNhl/QeWPsw=;
        b=bfR7PrE14H8QrBL9UYMF/P/kj+B04NIj7wxWZ/qQB4VoJAUdz5TKyTa1rDj9jXFwUv
         W1j2Un5tq//D87KiVllwgwyO0oAzt6bwHi7GIuKgZ9fC3mDrl+mvOp5ofVRQl4GcvS1v
         RxiIHOOT9gCDf9ncgX2FFQtgr07hWJ0vEE9RhH43ThfGOHRWvrzSsplEQUmiRTMf7MMl
         wF7O+f7TObapsG7nKS3bxUnBwqlZ9pEAyuxq1gYPo6kaL93X0c3JGoEE0KfGAV2Pxp5a
         bUHbG47L+OfQ9Wl6ngAv8DldZXMParUZdUYV+MJSmiJkBjkRWayETQXZKrMl8M09/2VL
         WE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683692061; x=1686284061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDlLkGJJBvLHoO3Mn26cbL245NbENReWXNhl/QeWPsw=;
        b=kUYSCgLVgvRIm8+GgQmlZHFAiDb1wuhWPg/LrEoUgY6hLwK5l7saaUuPxiq+qZu15e
         oRxXzzGxKr1HmmUMBObm7INz4uEhQCUw2rM5xdwdsx35cCcvkJyPwtWyhO89tt6gJ7br
         xxtYlUMw9XaNCF57CbF6D+lERTGYuFoI2gJORrymXxLWJOG6BcU4SjMId4bPwDCrvCKc
         5lLFMgzmEokvQp5JSGM62O904h4xRv/8hQ5ZgoIlPzOjb40952tuCGvZ4I0gZoJFoK8m
         km7j6R3H8Ghs02UVeVLIRJz2WJUTfOrcy7REkdubdwnHuOqpN41MePSfHNnTopfNRZR/
         +QUA==
X-Gm-Message-State: AC+VfDyJkI5hZ8ot7FkLLJCfIChxUJ2yeLu1Tor8IhObuyMQ4ym3Gng4
	SD2O7JuOvpGVWBBCKAwxoNhWpGS+cYgrao0PTkU=
X-Google-Smtp-Source: ACHHUZ4znNchnpZbX2Rdz80pk9tUBZ7O4rv7L/XIpLwruNfUvjnNfPhGSmHv/GN89QN/rZx/4pRz3cF/m2s6NpQPLYY=
X-Received: by 2002:adf:efc5:0:b0:307:7fa4:527d with SMTP id
 i5-20020adfefc5000000b003077fa4527dmr12342655wrp.58.1683692061296; Tue, 09
 May 2023 21:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1682499136.git.geliang.tang@suse.com> <2663cbe9ab1203202f2ae587475abc36fa93e4fb.1682499136.git.geliang.tang@suse.com>
 <658236c6-dd35-dd20-b72a-8794fab1d36a@tessares.net> <4873cb19-a65a-72a8-2932-0a4a8887ed16@tessares.net>
In-Reply-To: <4873cb19-a65a-72a8-2932-0a4a8887ed16@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 10 May 2023 12:14:31 +0800
Message-ID: <CA+WQbwv1kmgTtbrkUF6KEwF8k8-C0TjiYeLRXSdruK7uv+rkDw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v10 2/6] selftests: mptcp: update userspace pm
 addr tests
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B45=E6=
=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B 21:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 03/05/2023 19:33, Matthieu Baerts wrote:
> > Hi Geliang,
> >
> > On 26/04/2023 10:56, Geliang Tang wrote:
> >> This patch is linked to the previous commit ("mptcp: only send RM_ADDR=
 in
> >> nl_cmd_remove").
> >>
> >> To align with what is done by the in-kernel PM, update userspace pm ad=
dr
> >> selftests, by sending a remove_subflows command together after the
> >> remove_addrs command.
> >>
> >> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> >> Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
> >> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >> ---
> >>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_join.sh
> >> index 26310c17b4c6..67d5d724266a 100755
> >> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> @@ -850,6 +850,14 @@ do_transfer()
> >>                              ip netns exec ${listener_ns} ./pm_nl_ctl =
ann $addr token $tk id $id
> >>                              sleep 1
> >>                              ip netns exec ${listener_ns} ./pm_nl_ctl =
rem token $tk id $id
> >
> > Out of curiosity, why did you have to move this command before the
> > destruction of the subflow (just below)? Is it because since v10, we
> > cannot remove the subflow if the subflow has been destroyed?
> >
> > For the moment, I guess it is OK because if I'm not mistaken, we don't
> > check that the subflow destruction has been done, right?
> >
> > If at some points we do verify the following command is doing what we
> > expect to do, my fear is that the next command might not work if we are
> > unlucky: when the RM_ADDR from the previous step will be received, the
> > other peer will destroy the associated subflows, no? If yes and if it i=
s
> > done quicker than launching the following command, the subflow could
> > already be destroyed and the following command might fail, no?
> >
> > Maybe that's not an issue because we don't check for errors in pm_nl_ct=
l
> > (which is maybe not a good thing but that's another problem). So fine t=
o
> > keep this like that, right?
>
> Does what I saying above correct: the next command could fail but that's
> fine because we ignore errors?

Now I moved the RM_ADDR command after the destruction of the subflow in v13=
.

Thank,
-Geliang

>
> >> +                            sp=3D$(grep "type:10" "$evts_ns1" |
> >> +                                 sed -n 's/.*\(sport:\)\([[:digit:]]*=
\).*$/\2/p;q')
> >> +                            da=3D$(grep "type:10" "$evts_ns1" |
> >> +                                 sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*=
\).*$/\2/p;q')
> >> +                            dp=3D$(grep "type:10" "$evts_ns1" |
> >> +                                 sed -n 's/.*\(dport:\)\([[:digit:]]*=
\).*$/\2/p;q')
> >> +                            ip netns exec ${listener_ns} ./pm_nl_ctl =
dsf lip "::ffff:$addr" \
> >> +                                                    lport $sp rip $da=
 rport $dp token $tk
> >>                      fi
> >>
> >>                      counter=3D$((counter + 1))
> >
> > Cheers,
> > Matt
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
