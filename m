Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7067C
	for <mptcp@lists.linux.dev>; Tue, 21 Mar 2023 02:50:57 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id h17so12234451wrt.8
        for <mptcp@lists.linux.dev>; Mon, 20 Mar 2023 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679367056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFFzwJhHpPs0hKiANXPOc0RJp4AZ+gyu7bWPV8iWw3M=;
        b=aNkT2y/j2EiR5SDirDob5lw+ZFRttImXjB1mn1a97P+oOiJC3cwfqSckrNRQ5HMfYr
         TdK5GdT/QtjbwWWl2FEyVjqMi8NfY17MPJFgOcX6/mufgyDH7voW19WW58PEsWjqLE+I
         gu2YcoqH0Mr2IAwLGVVBywc0w2lseP8GofE3EaMxFWh2if5EiyZfW3gxkHa6dsY8PGTk
         6qpKznKWFeoWqMLtF+N+9rxFwxnvNHJKxnla6c9oY/CLy9Ftw5jEOEwjxfgCNJA2vrvu
         jHI75+xAOMpxjKZvQidKUsOxS8V2tdGxJU6iyu5uvSDAtm2WDnRh07II3F3dL9KUiYHB
         H6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679367056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFFzwJhHpPs0hKiANXPOc0RJp4AZ+gyu7bWPV8iWw3M=;
        b=Ki/aDaZ9+Dl53Hjt6M2rqL+5xyuVrOGnI++hWV3+0aj7F1o6qt0oU8S70wUrkhcTkx
         CkKlTGeKb/UNx8pqGKqOi8JClw/42G7sIf3pMqSNeiRETKW/gmLe/tFtnVX0Tj3pYqPn
         he1bQAPqDZ/HtjLzzCoNjiStrdADl6II53iwGG/Re6bKxd01qH3lyKVxOn5v3ksf/IOT
         foqIO7/k21IBUYVrQf5IGqHRVlupQ90QbuZ5NJA9FJ9RzAKvsuzt/Eg9reJ1pZQOFv2Z
         /WuvZf04CrgOYh2F2u4v4/YWQlAXXLPDoFrjThyEiWMzkvuWB2bnV1D8uqxi/GHy4Dp3
         Vakw==
X-Gm-Message-State: AO0yUKXQcUn6wAYYsB+wa6eNvl3mHW4breSw4yKsxAubGH+ldVN90b/q
	jBUqQ7ATS3TRWNJfSmdePEJLnxfzUkElRpTqZTU=
X-Google-Smtp-Source: AK7set8MLbzgyIr6WwiHXbACr8V+FXB8GXKibu1tjeQ4yjd+eDs10bFJfQa7Gj/IJ/WrdvG+IdUeGJnX7i1pMp/FLqQ=
X-Received: by 2002:a5d:67c5:0:b0:2c7:195c:5b13 with SMTP id
 n5-20020a5d67c5000000b002c7195c5b13mr246714wrw.0.1679367056039; Mon, 20 Mar
 2023 19:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1678778977.git.geliang.tang@suse.com> <d47a06abb5dae1f333a496183da5ba3e51e5a98e.1678778977.git.geliang.tang@suse.com>
 <067bd46b-9c12-36cd-8ea5-3667669dc6cf@tessares.net> <CA+WQbwv1gBROrXG-8Fb=T+p6rQNf5PF0gKB95mJzfQdsH8-mGg@mail.gmail.com>
 <8387b3ee-c7dc-6555-c914-6cf856375fcc@tessares.net>
In-Reply-To: <8387b3ee-c7dc-6555-c914-6cf856375fcc@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 21 Mar 2023 10:52:29 +0800
Message-ID: <CA+WQbwtPdoG_XA8fFWKDVFS1-rm3LU2BedskF1GuBhQNR=w_qA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 3/7] mptcp: close remote subflow when
 destroying it
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B43=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 00:09=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> Thank you for your reply.
>
> On 20/03/2023 12:41, Geliang Tang wrote:
> > Hi Matt,
> >
> > Thanks for your reviews.
> >
> > We always remove address together with subflow, see
> > mptcp_nl_remove_subflow_and_signal_addr() or
> > mptcp_pm_remove_addrs_and_subflows().
> >
> > So we always get "chk_rm_nr 1 1" in these tests:
> >
> >         # single subflow, remove
> >         if reset "remove single subflow"; then
> >                 pm_nl_set_limits $ns1 0 1
> >                 pm_nl_set_limits $ns2 0 1
> >                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> >                 run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> >                 chk_join_nr 1 1 1
> >                 chk_rm_nr 1 1
> >         fi
> >
> >         # single address, remove
> >         if reset "remove single address"; then
> >                 pm_nl_set_limits $ns1 0 1
> >                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> >                 pm_nl_set_limits $ns2 1 1
> >                 run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> >                 chk_join_nr 1 1 1
> >                 chk_add_nr 1 1
> >                 chk_rm_nr 1 1 invert
> >         fi
> >
> >         # userspace pm add & remove address
> >         if reset_with_events "userspace pm add & remove address"; then
> >                 set_userspace_pm $ns1
> >                 pm_nl_set_limits $ns2 1 1
> >                 run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
> >                 chk_join_nr 1 1 1
> >                 chk_add_nr 1 1
> >                 chk_rm_nr 1 1 invert
> >                 kill_events_pids
> >         fi
> >
> > But the userspace remove subflow test got "chk_rm_nr 0 1":
> >
> >         # userspace pm create destroy subflow
> >         if reset_with_events "userspace pm create destroy subflow"; the=
n
> >                 set_userspace_pm $ns2
> >                 pm_nl_set_limits $ns1 0 1
> >                 run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
> >                 chk_join_nr 1 1 1
> >                 chk_rm_nr 0 1
> >                 kill_events_pids
> >         fi
> >
> > "chk_rm_nr 0 1" means getting no rm_addr, but a rm_subflow.
>
> Indeed but you have this behaviour only because the userspace PM didn't
> send this RM ADDR, no? I agree it might be better to do so but it is not
> mandatory if I'm not mistaken, especially for the client side. Then it
> is up to the userspace PM to decide to send the RM ADDR or not and we
> cannot force it I would say.
>
> Or maybe the client side cannot send a RM ADDR? (on the other hand, the
> address was not announced with an ADD_ADDR so why do you want to send a
> RM_ADDR?)
>
> (if there is a need, we can ease its use with an extra flag but I don't
> think we should force this behaviour, it is up to the PM to do that, no?)
>
> > This behavior is incorrect. This patch fix it. It looks through the
> > userspace_pm_local_addr_list to find the addr id, and send RM_ADDR
> > with this id.
> >
> > So patch 2 is needed to add the address into
> > userspace_pm_local_addr_list, and patch 1 too, no clear the address
> > id.
>
> Would it not work if you modify do_transfer() to use pm_nl_ctl to send
> the RM_ADDR then do the destroy (I don't know if doing the opposite is
> supported)?
>
> But again, I don't think we need to send an RM_ADD if no ADD_ADDR have
> been sent before by the client here.

No, we must send an RM_ADDR to shutdown the subflow and close ssk on
the other side. I guess we should hear Paolo's opinion here. @Paolo
Abeni

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
