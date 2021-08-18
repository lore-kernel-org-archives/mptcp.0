Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A22FB0
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 03:16:16 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id w6so915067plg.9
        for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HyTmv4wFz81cHTZ96aqCZ9JjtP5y+3/unRWWz1xjKPg=;
        b=c2vd7bl1EMJCj+Ynvd8e+sHgwK7jFMOhYns1ptWp0vSFstj9LdBr3j3yH53Y76qz1P
         HXZGLgp+dSNKckxwDOHgil7gqus1opEyZun2sKbF1y16uVlSBz0fqm3AVn2zzOJHCXmy
         jhIMysi/GqwJ4z7IDIZbj1FbvjAfgrz0n00pxQHybqBXw6ZMXBeuMTWWuDhecSRgTnRE
         6nIiOKVQQ5XJCHCvUknDmhRK1mAwxuUHLxUSK0RtWA08q50z2WDPfXbV7WrlM7Xc668v
         vJ/ZNPcMxw/euCeoTkHp9OjtiJLzLxGyHio7rSX5XqPxnbVA/Al9mJPojlJTAk4sQRVW
         xD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HyTmv4wFz81cHTZ96aqCZ9JjtP5y+3/unRWWz1xjKPg=;
        b=jAq3jyYreLGXopbKngi5xy3vUe6lK58ooXRLZKoNpOI8ZNyhuPOUNPCNbkSVSdqquf
         iIF4s/8kAVvuGeTs8r9c4jiRmNoCI9c5b0siFWE6MJFveS+VBYZN0VrH0JtFWX8Uw8OA
         dMuQXN+Du7z+pXFYZxQ2Z5j5k81lwiDQ4Xra+t49h0G7KpY7pkqE8L05ONN7ypiyA6Vy
         k4QSiuC2jQMxq09iAeTo2IpL2Fd3ACC7b0w7OluUotes+O7vTionOrqED2CCX+HPC5q4
         MgAzz4qF24Xp7xYMOlOSCJ5nReS4/Cx8Su/UpJlY3qxOVq738bpwMu9JCKS2EO1noD7I
         WsJw==
X-Gm-Message-State: AOAM531gvo6QvOIp+/6g/swss2INyLpEVa22bZaFsY+/LUQ5GFQad4cY
	TZ7RnTPJbSdKozmxAWjFnRhECD28jyLYdVsBd2s=
X-Google-Smtp-Source: ABdhPJyPzEDKiNcYiZF80m+J3NoULNmcQov3Aq5VTOb4gfGcsjjCs2QT6VaMSXa/y971WnuBu2f+MCEeux0h7LJQCRw=
X-Received: by 2002:a17:902:8642:b029:12c:dda2:30c3 with SMTP id
 y2-20020a1709028642b029012cdda230c3mr5416640plt.84.1629256576249; Tue, 17 Aug
 2021 20:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <b73d65b78787ba0ecc36ec2d5d6fc2a68415d938.1628863533.git.pabeni@redhat.com>
 <96a46335-40c7-ddbf-be45-aab07b8d3d4b@tessares.net>
In-Reply-To: <96a46335-40c7-ddbf-be45-aab07b8d3d4b@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 18 Aug 2021 11:16:05 +0800
Message-ID: <CA+WQbwvk6uY5zajSYgb59_FdDSB4oQ+6Lz3Er3JAEdm1OvFrcQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix memory leak on address flush
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:31=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Paolo, Mat,
>
> On 13/08/2021 16:05, Paolo Abeni wrote:
> > The endpoint cleanup path is prone to a memory leak, as reported
> > by syzkaller:
>
> Thank you for this patch and the review!
>
> Now in our tree (net) with Mat's tag:
>
> - bbffcd9faae3: mptcp: fix memory leak on address flush
> - Results: a5b32fb5c3ca..55f3937bfef4
>
> Builds and tests are now in progress:

Hi Matt,

I think we can close issue #223 now.

Thanks,
-Geliang

>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210816=
T173103
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-v=
alidation.yml?query=3Dbranch:export/20210816T173103
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
