Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9A70
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 07:29:01 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id l18so794206edc.9
        for <mptcp@lists.linux.dev>; Thu, 01 Apr 2021 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RljCL5ogiJYDpT0UtbnScMCTJAO7LSZbMXgH/FH+9A=;
        b=FeHZUH9rvob9BnmgT94jzzn4PIzf23ZhUKYdETSC/9Suer5HinimPVlplrQp7j2XzM
         RRr4s+iL31N3rWe7TDPxQbDJxmBj6y3pNZ1LvyU+p4AJkAnECZpDy3ZvzI88BhEZ4E2M
         6UlHZ1y74WMHZcKy9uBA0ekoTEAygqcRoIV9Or/UI8/t4ZuKn+7vztnV9K0769cTu2S6
         Of9ZW33JVT7uOLU19c4Oahod9PJsx+NVrarIHwA6mkjxpvtQtZFTlydjZgOHOx37SuR0
         gmclJWzPECzvcWLj0AA6WnXdGEz4T0MIAQ2yIQOxyBVR09mTJy+Ox5pOHc/AtcM7JRUP
         K5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RljCL5ogiJYDpT0UtbnScMCTJAO7LSZbMXgH/FH+9A=;
        b=Zlcx2R7LznQm9yhsIexp0wYJFA9gke9hD38NeyKmwO5vAgClgj2t3ax0Ki2EkIPT9a
         r0b8HDChdHnF+rKniXCSFlFrqGZjItM/SXXLnxzreWQJJ5kXf8PF1CyTHp//7e8i3cEe
         fgZjq8nqseVz0QJYZjzf9r8bKArmPwjODXsRDLeGnYq0UG6UenRWjU44osbp8FrGbB04
         cnqVrYVLyVMFw7T3PUYrZR28wonWg6AaZjEtoGoKVWDCWuWJKcGb2wDkkkK/V8efxKfJ
         QZOIDtHGUOzSFsOvlVfd9KmbAYi/lc9tYjtSG5/RIXtUCLOe0O/MHv7Qj9hTiGn1MV17
         pnPQ==
X-Gm-Message-State: AOAM532BmUiW0dRoR68HI2Lt7sY8ew92sXgQtaT1c431R9yTKIxT/plP
	nqXUI6ECgADxMpAyOmyNA1CiYRYkmOdmQn+UTmk=
X-Google-Smtp-Source: ABdhPJzJL+rzDQykQhPR1EjgKhLpOO8DAQAVx9Uxshc93aG1AN/hdHH9WXlwgcI3Dk8Zag9PyLa2tnjqcPgZEtced4c=
X-Received: by 2002:a50:ee19:: with SMTP id g25mr8410516eds.351.1617262139832;
 Thu, 01 Apr 2021 00:28:59 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1617258890-11776-1-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1617258890-11776-1-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 1 Apr 2021 15:28:48 +0800
Message-ID: <CA+WQbwuXj1yWWyzG5FtgAr2Urg=ubQ9qLOub2dxufMjrrp7gUA@mail.gmail.com>
Subject: Re: [PATCH v2] mptcp: ensure there is unacked data at all subflow
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Florian Westphal <fw@strlen.de>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Thanks for this v2, I have some comments here.

1. There's a checkpatch.sh warning in your patch:

WARNING: 'retransmited' may be misspelled - perhaps 'retransmitted'?
#9:
maybe double retransmited.
             ^^^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 20 lines checked

Please fix this warning in v3. And always remember to run checkpatch.sh
before sending out a patch.

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B44=E6=9C=881=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:45=E5=86=99=E9=81=93=EF=BC=
=9A
>
> MPTCP-level retransmit may take place if first subflow
> without data in its write queue and second subflow is likely to
> have unacked data left in its write queue. In this condition data
> maybe double retransmited.

2. The commit log should follow the "wrap at 75 columns" rule, a maximum
75 chars per line. (See Documentation/process/submitting-patches.rst for
more details)

3. Please send out the v3 patch as a new email thread, don't reply it to
this v2 one.

Thanks.

-Geliang

>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/protocol.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d7e7e1..66707ab 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2072,6 +2072,7 @@ static struct sock *mptcp_subflow_get_retrans(const=
 struct mptcp_sock *msk)
>  {
>         struct mptcp_subflow_context *subflow;
>         struct sock *backup =3D NULL;
> +       struct sock *idle =3D NULL;
>
>         sock_owned_by_me((const struct sock *)msk);
>
> @@ -2097,10 +2098,11 @@ static struct sock *mptcp_subflow_get_retrans(con=
st struct mptcp_sock *msk)
>                         continue;
>                 }
>
> -               return ssk;
> +               if (!idle)
> +                       idle =3D ssk;
>         }
>
> -       return backup;
> +       return idle ? : backup;
>  }
>
>  static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
> --
> 1.8.3.1
>
>
