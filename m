Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C115B0
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 02:23:50 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id k2so12277203vsk.8
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=j+mjDeU8MfTaoo2Hr5w1v30IzbKSmgNAkOvuWkOsXjM=;
        b=UMtVs9r6osj9VmxhbEMYKQzKkleV/r446iRFxqMvE/gbFQVZaizc6S8gprSj6kO3Ds
         N+tt8rVMwKl908yhk9ENaHYDZZSYDiFaqmj/oMNdQYMXghvmG6DGfX4e+R5gUxKTwvMw
         Y0JY9godWbtlKhD/4bTK+2r62kwutzBOxT5BNEqeZvaa8hcJe3skwHqWrmVkKUMTX6Bf
         hHCJaYzcw/ca9h4kv/jUsV3gN9RjZn9CTwv/aOz+6L3ON3GlD14zztk9oXwVS1AyZPXm
         QrIHjrASqemJU9GOjRaJIhDwfzbgTtC5yufuzo1lEOfkvLexyEhhf8ECO1SOlJBAdGGS
         CT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=j+mjDeU8MfTaoo2Hr5w1v30IzbKSmgNAkOvuWkOsXjM=;
        b=4cehkA2tSNVr3W2KygfYhfAF7o5GXT6T2wxHlxrKbwJmh9UXkjrWd5wQQBMrrq4uBS
         fSPjK8ldiJTnNHV1QXF9v7d/TccY0haksZ0Fy8/n9NMoAmkBwyvwYNSyZMDMDlbbNZVt
         kpzPl3MONiUzAG7vi0brakbbsj46VnoMTHAva4BXSSiZytWHJvW7do7P7dlPo8ie/gHH
         P4lf/K7swybIzgb+cIt8MW3pn05zYaM+fTtKTK0qsfm9o8aWBSGohNa82vSUMVCcrt+7
         K1nY6aG/E/knBAu6Nxf4AyIo1jhBDJrCw2ZtSV5PDaG4iM6qrHmbd6wi0SsTuyyPy/BY
         v7bg==
X-Gm-Message-State: ACrzQf0B+YmLXSA24GFzQcMa+hqZ7vz3CU+haZqbAREAJGa2NM1Q0MTS
	uTmlQq5V8zej+H2ozgWtw5JiRiIgfzNy3J9VKjU=
X-Google-Smtp-Source: AMsMyM4RqEWUTYLvpo5uDoNc12YKavzt8E+kH8ArJyRF2vgLlGG6O1oGmDR2maiMAwQbZCIvRZ2jJTrYcNSe1MdMMU8=
X-Received: by 2002:a67:e401:0:b0:398:89f1:492f with SMTP id
 d1-20020a67e401000000b0039889f1492fmr2891816vsf.21.1663899829770; Thu, 22 Sep
 2022 19:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <48ba286b429284accc457e34c6580efcdec593c4.1662725968.git.geliang.tang@suse.com>
 <99b1363eeecf160159bbe9f37e38221e93baef55.camel@redhat.com>
In-Reply-To: <99b1363eeecf160159bbe9f37e38221e93baef55.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 23 Sep 2022 10:24:26 +0800
Message-ID: <CA+WQbwsLPo_XbS-cLe1QhdEj8Ak7Y+as8v6y3FT1Mp3fKd2N5g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] tcp: Add mss zero checks to avoid divide errors
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Sorry for the late reply.

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=94 22:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2022-09-09 at 20:19 +0800, Geliang Tang wrote:
> > If mss_now is set to zero when invoking tcp_push(), this divide error w=
ill occur:
>
> We should not call at all tcp_push() in such situation. How did you
> reproduce the issue?

This does not happen on the export branch, but only when I add the BPF
redundant scheduler.

>
> Adding more check in TCP for the above situation is very likely not the
> correct thing to do. Instead we should prevent MPTCP from reaching for
> tcp_push() in the critical situation.

I agree. Let's just drop this patch. I'll add the new one to avoid
calling tcp_push() in such situation into the " BPF redundant scheduler"
series If we really need it.

Thanks!
-Geliang

>
> Thanks!
>
> Paolo
>
>
