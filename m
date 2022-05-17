Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBF1103
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 05:19:37 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id q7so4974864plx.3
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGxZBKb/3ekC1p29+M5pY+8bLNl1xB/+3c3RkyhR34k=;
        b=XdRNsZ2twmwVx7hhoVomoZWNcrZ3pcblOIVKVaS1N/vWQqBgcmmrqzJKNEz4OoZhoQ
         mhJDqdpbSvEWyzzfgz8bcwggIiqCTiZCqUpqOUaCMb40Iwlx3xmFbwK9TmkiV2fYKInD
         S/9BCGENGHC12h4/5KgYPbcnduPfIyG+zYq/jCcYArziQ319vOHeoXHP7/bGi3Od4PAW
         1QJY6fb8Og/7gQ4050RJwtS43uTzOVRnLIisjuK1Jd2b1Pb8LGCJEnBEj6sOw0bg6fcl
         oJD6RfEhMmYdGmcuKRO2EWpHsUvIugO1iV9+r6Zs4bSGD7NEp50gPU2Gwa6fNDVExZ2Q
         e8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGxZBKb/3ekC1p29+M5pY+8bLNl1xB/+3c3RkyhR34k=;
        b=YfoSvllzUSy3PSaxTvE5ITUsPif9aeq/Gnxb3KsEezY1N6U3w67KrNHPWegmkgfkRY
         q8UlDD/sOzyUZVzPGqcghA/qi5JNuaSD6V/shcPN8TW5AONm9lsifhP5eqg8nbhXzkOk
         H5HIhY6Zb+AunXXt6Gn1mMC0Q9N/z7962de0f3tlfm2/Dnz/oPmbK8OqN2LDZRahUmyU
         fMmuMbVx2+JnSlLVtRh+xplTmIvV5mA9Us5fydXN6u3lQxRbYa7XRDg8IWU0Lj95hRTo
         i8B0FtrvkUBUJ4ND5oCZ0X6+I0YVVjU5eWED8YBgqsKUW9eNin1aYyBg+NX/qDsFGJir
         AZzw==
X-Gm-Message-State: AOAM532cc8+j26ibgwMJ9TV0IG67sXzRuxmN7kqjDJxI8o+09r2Wk/Jm
	uN8CXmzvsRG5GKm2TBFBgl/46tYAxxRSiW6nRjk=
X-Google-Smtp-Source: ABdhPJxdl1+BkSItOx4mfYPN2Pq1PxPcjJ5hqIyGIaMFzzXpudrP61PO2Lp6hc4mA2FM5gGX4atQsc8Xeg3liu2s+7Q=
X-Received: by 2002:a17:902:8203:b0:15f:4423:6e9c with SMTP id
 x3-20020a170902820300b0015f44236e9cmr21038627pln.25.1652764776757; Mon, 16
 May 2022 22:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
 <20220513224827.662254-6-mathew.j.martineau@linux.intel.com> <20220517013217.oxbpwjilwr4fzvuv@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220517013217.oxbpwjilwr4fzvuv@kafai-mbp.dhcp.thefacebook.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 17 May 2022 13:19:38 +0800
Message-ID: <CA+WQbwuenfY9Pxet6g0Tvo++JOAmU98+QymuWVsi-2iRpPq3oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/7] selftests/bpf: verify token of struct mptcp_sock
To: Martin KaFai Lau <kafai@fb.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Geliang Tang <geliang.tang@suse.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=8C 09:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 13, 2022 at 03:48:25PM -0700, Mat Martineau wrote:
> [ ... ]
>
> > +/*
> > + * Parse the token from the output of 'ip mptcp monitor':
> > + *
> > + * [       CREATED] token=3D3ca933d3 remid=3D0 locid=3D0 saddr4=3D127.=
0.0.1 ...
> > + * [       CREATED] token=3D2ab57040 remid=3D0 locid=3D0 saddr4=3D127.=
0.0.1 ...
> How stable is the string format ?
>
> If it happens to have some unrelated mptcp connection going on, will the =
test
> break ?

Hi Martin,

Yes, it will break in that case. How can I fix this? Should I run the
test in a special net namespace?

'ip mptcp monitor' can easily run in a special net namespace:

ip -net ns1 mptcp monitor

But I don't know how to run start_server() and connect_to_fd() in a
special namespace. Could you please give me some suggestions about
this?

Thanks,
-Geliang

>
> > + */
> > +static __u32 get_msk_token(void)
> > +{
> > +     char *prefix =3D "[       CREATED] token=3D";
> > +     char buf[BUFSIZ] =3D {};
> > +     __u32 token =3D 0;
> > +     ssize_t len;
> > +     int fd;
> > +
> > +     sync();
> > +
> > +     fd =3D open(monitor_log_path, O_RDONLY);
> > +     if (!ASSERT_GE(fd, 0, "Failed to open monitor_log_path"))
> > +             return token;
> > +
> > +     len =3D read(fd, buf, sizeof(buf));
> > +     if (!ASSERT_GT(len, 0, "Failed to read monitor_log_path"))
> > +             goto err;
> > +
> > +     if (strncmp(buf, prefix, strlen(prefix))) {
> > +             log_err("Invalid prefix %s", buf);
> > +             goto err;
> > +     }
> > +
> > +     token =3D strtol(buf + strlen(prefix), NULL, 16);
> > +
> > +err:
> > +     close(fd);
> > +     return token;
> > +}
> > +
>
