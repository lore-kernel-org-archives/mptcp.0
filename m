Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F97B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 15:27:11 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so5280437pjb.4
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQ6G+i/Lfa7T0L99QPBq/ySr/hZaTzeK6smO25oTvzY=;
        b=TS8V/CV+s3RglgqNPLVyT6XWZA6pahz48nRqPJclwj6FcyashZhmiUMKXz/PbuPeFu
         bI2sgBdlhTp49Y1HccyjssMo+H4Ratb17iTYObHCN8MF45PExCRmoW97mbpMXFGHI/Mn
         r6sODcqM+3WC76vHp83KkzpqzncSAWp/ltvMDFIhF9goeX0MsbgGzXuUfJ6kySDE+FO2
         6iRCmFjBArgk28Ceyyvh2PSNl+w5h00EibX6A2aMsszN/M6Glq1m/fijs0pogbvSIQ1Z
         NoDJdQ7x44FAJ6MQppwbpeQ9YduMELgzCLWOdEXdEkS/5H7vAUUOMmqJxtxT55zThmcq
         YxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQ6G+i/Lfa7T0L99QPBq/ySr/hZaTzeK6smO25oTvzY=;
        b=CzeNNSlpZ0BA2aW0IM0sNYpi9tEugBRGD/SXBH5MIkJDz9/2/sgkz2KhFCQvOLZcHH
         tpO0I7TIW77lxRlKXR5KPPEqVHRMzBKPNeyPfBeLpSZVR9EwqfOCzpQLcAy9QEhj5lVk
         iWlsToWRiq+tPsSYrl11scr49XgwMvafY9Kf032VsBU0j+sWR/62pQYgvAO0JaQH8xyn
         rR18Gad9LZDKgUOo6xTBAluwugcRvS5Mt7qVcXsYNHMj1wokugQSsNsB3489LvUDHaOK
         3Gx+UbEJaufLQ8/kSWBswsO2UQHJKU7LA041eIGGA2QfV0peroryukLvKlt7pK2C3GGF
         3CFA==
X-Gm-Message-State: AOAM530nfu1OmMjvSNd91tB5VkIDtqcndlzChr2DPHj0UsLz5DwcAmf/
	sh1Om9d1SJ9EKGrGPqgP+4uisYz1BS4cnD/wUtymZqIoHeUOwA==
X-Google-Smtp-Source: ABdhPJxdd+7Awxd55Do2VmkdiN4B8o5NXh3AMi+DifwivKUauQ9CcgsSFTxtHjtS7Zz2D2JG6fMRD4ktOGFzAYHojLE=
X-Received: by 2002:a17:902:6acc:b0:149:8f60:a526 with SMTP id
 i12-20020a1709026acc00b001498f60a526mr29084840plt.25.1651073231461; Wed, 27
 Apr 2022 08:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
 <50d4d7a13beec75c5172d81c2c6d037fb74efd79.1650947056.git.geliang.tang@suse.com>
 <d521e76e-729a-cc7f-9ad5-e4e26f3da8d@linux.intel.com>
In-Reply-To: <d521e76e-729a-cc7f-9ad5-e4e26f3da8d@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 27 Apr 2022 23:27:29 +0800
Message-ID: <CA+WQbwu2n-Wva1Ja2dFxkbsQtfitCgUrK_KMQfm2VJPCsBmxig@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B44=
=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 08:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 26 Apr 2022, Geliang Tang wrote:
>
> > Add CONFIG_MPTCP check.
> >
> > When CONFIG_MPTCP is not enabled, we'll get a clearer error message:
> >
> > libbpf: extern CONFIG_MPTCP (strong) not resolved
> > libbpf: failed to load object './mptcp_sock.o'
> >
> > The message before is like this:
> >
> > libbpf: prog '_sockops': BPF program load failed: Invalid argument
> > libbpf: prog '_sockops': -- BEGIN PROG LOAD LOG --
> >
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > tools/testing/selftests/bpf/progs/mptcp_sock.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
>
> Looks like this also requires CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC,
> can you also add those to tools/testing/selftests/bpf/config? Maybe that
> should be a separate commit, since other bpf test progs appear to rely on
> this undocumented config requirement.

In my test, this bpf base test still works without CONFIG_IKCONFIG and
CONFIG_IKCONFIG_PROC:

> ls /proc/config.gz
ls: cannot access '/proc/config.gz': No such file or directory
> sudo ./test_progs -n 103
#103 mptcp:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Thanks,
-Geliang




>
> - Mat
>
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_sock.c
> > index 5cfaec4e7245..7b6a25e37de8 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> > @@ -7,6 +7,7 @@
> >
> > char _license[] SEC("license") =3D "GPL";
> > __u32 _version SEC("version") =3D 1;
> > +extern bool CONFIG_MPTCP __kconfig;
> >
> > struct mptcp_storage {
> >       __u32 invoked;
> > @@ -46,6 +47,9 @@ int _sockops(struct bpf_sock_ops *ctx)
> >               if (!storage)
> >                       return 1;
> >       } else {
> > +             if (!CONFIG_MPTCP)
> > +                     return 1;
> > +
> >               msk =3D bpf_skc_to_mptcp_sock(sk);
> >               if (!msk)
> >                       return 1;
> > --
> > 2.34.1
> >
> >
> >
>
> --
> Mat Martineau
> Intel
>
