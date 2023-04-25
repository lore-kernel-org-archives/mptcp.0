Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C17B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:01:47 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3010889c6ebso3239940f8f.2
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682409706; x=1685001706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUVpugiKZx68vd0owGLI3cSps4nNwqBjVpNUTNn6+MU=;
        b=gQmGK6lxF5RfIRw4YeRCQWVj8FqLyRzkSXU+iyEZ/5v4LgmvnqBvmGtTjJ6rd7ckdS
         MOMWI2dmk8b21RJLtLxmNIOGctUVAkh4I626ClhIzYe9HmbJZHbqCN9wG3XGFEpqBxQU
         Ye+54z8wYx04mFshSMETPHeUlepKM6IP4aihp1Z3uEqnzpZz6H5k9IjgxgiKRo7AdZUT
         gZly5TdEaOP1eLUbYeomWzu5XKkn06WT7Tcu/8utz5l/t7WHUBnWE4WzyLOlfaVPk8wV
         imMKws73DxIUGqTeDg2eKJRlpPLw7JSv5wiz5LHmnRJZladdE7/wyx9uqiFX0YBZZLyR
         BK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682409706; x=1685001706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUVpugiKZx68vd0owGLI3cSps4nNwqBjVpNUTNn6+MU=;
        b=PISUwW7PwIHldRn7TLU1W2wvmCCrUVuaY2cw88AXvG7uHDq0iGn58tyVz/DNEo7BJb
         qdCCG4YDqjMzI77akNoOZTszk2H5AhaZJ7lVzt88THurItaH5KDaSYUTf3/T9RGkGYI2
         N3Gpe6/Tx/+0ofAcCceubiLySDtpDZE3nWCuV9ZQMHVMK8eU3WX1HMXe7s5wnlpkdQFw
         ZGahhZZ95iqkw+Vr59ZV7DWWkVkchwpnd43ZIbD0jkg+HJ38oUhRnKYygJYW72WTSEfy
         ydPDXak4MofhVAH5EpBjAIKUCC3A6mxiKitWtP6jKyuFGhsVRlbSa5Pl2N3E6l+vP2VJ
         EHZw==
X-Gm-Message-State: AAQBX9cOmFFRgffez/X2tRlTtGWK4tcg6f9ty2BCACYxasY6w5jicKMw
	sDVlqTaoDRp4fo1jljvf7jiDBodH37My09vDG5w=
X-Google-Smtp-Source: AKy350bbMT5aBjIw0pyLxrHHfLHuhc1BMTW97B+G09Abd7RvT7DjGG8h7oLqCXw3CAW9BRm3JwLzigoyTIkhzyn64Xg=
X-Received: by 2002:adf:f544:0:b0:2ef:b080:829a with SMTP id
 j4-20020adff544000000b002efb080829amr10112342wrp.11.1682409705930; Tue, 25
 Apr 2023 01:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681960259.git.geliang.tang@suse.com> <6c50f4b82533d9499318cad9d8c846823d7e280e.1681960259.git.geliang.tang@suse.com>
 <7f6d74b1-86dc-2c0f-ea5a-8a1907b787cb@tessares.net>
In-Reply-To: <7f6d74b1-86dc-2c0f-ea5a-8a1907b787cb@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 25 Apr 2023 16:01:37 +0800
Message-ID: <CA+WQbwtQ-nzp2MpM0JNi-raAC9nL=JpcgCcxyJSTOMfF3UA=ng@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 2/5] selftests: mptcp: update userspace pm
 addr tests
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 22:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 20/04/2023 05:11, Geliang Tang wrote:
> > Update userspace pm addr selftests, by sending a remove_subflows
> > command together after the remove_addrs command.
>
> To help with the management of this patch, either add:
>
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>
> and explain in the commit message that this is linked to the parent commi=
t.

Updated in v9.

>
> Or squash this in the previous patch.
>
> I think it will be clearer and easier when managing stable versions if
> you squash this patch (2/5) with the parent commit (1/5).

I prefer not to squash them, since they are in different repositories.

>
>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index 26310c17b4c6..9a9b6e9b28ab 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -850,6 +850,14 @@ do_transfer()
> >                               ip netns exec ${listener_ns} ./pm_nl_ctl =
ann $addr token $tk id $id
> >                               sleep 1
> >                               ip netns exec ${listener_ns} ./pm_nl_ctl =
rem token $tk id $id
>
> Please see my comment from v7, patch 7/7: should we not do the remove
> address after having deleted the subflow? See:
>
> > (...) on slow environments, could we not have a situation where the
> > REMOVE_ADDR signal is sent to the other peer, it directly reacts by
> > removing the subflow and at the end, this "dsf" command is not doing
> > anything, causing the test to fail because it expects the listener side
> > to delete the address.
> >
> > Should you not first delete the subflow, then send the remove addr? (or
> > skip the deletion of the subflow command and expect the client to remov=
e
> > the subflow?)
>
> So just moving the "pm_nl_ctl rem" command after "pm_nl_ctl dsf", no?

Updated in v9.

>
> > +                             sp=3D$(grep "type:10" "$evts_ns1" |
> > +                                  sed -n 's/.*\(sport:\)\([[:digit:]]*=
\).*$/\2/p;q')
> > +                             da=3D$(grep "type:10" "$evts_ns1" |
> > +                                  sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*=
\).*$/\2/p;q')
> > +                             dp=3D$(grep "type:10" "$evts_ns1" |
> > +                                  sed -n 's/.*\(dport:\)\([[:digit:]]*=
\).*$/\2/p;q')
> > +                             ip netns exec ${listener_ns} ./pm_nl_ctl =
dsf lip "::ffff:$addr" lport $sp \
> > +                                                                     r=
ip $da rport $dp token $tk
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
