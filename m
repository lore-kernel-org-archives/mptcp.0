Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241C70
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 06:57:14 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id r20so17373330ejo.11
        for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dxbOR3UrvA0PnQyJXTf0yz224obnEA3jpBDmpOZq6GA=;
        b=iCTKaQmXsMRBfN0p0viRHltOI88XuGTzrj+ZX46d2x47BEQGlXTAWkz02xs6R7rAx3
         663FoSB2GJg/EYUh5UbA1apxfWxR+fEGgnp199AyKhIHHY38wHrElab1rQUYv8+Yhxwg
         kX5K1iL/t19eWr2ra4RUFsZV2vPx4+5B21a0rVccj7E86U21Hn3nZ8UEleyjKnu8xkTf
         mKW8LCW0KOBHWlZwosLkyXeMEKcidn7pexnkV9lxkLumO5dd7HjMO2+UE6NelQ5uaVnr
         qKKKW9tjXLQYQsL8WgQMGd8jnriJPYH6GSKogrlZBJLZWAjKsAaJMk7m3ey1A9A08MnY
         C2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dxbOR3UrvA0PnQyJXTf0yz224obnEA3jpBDmpOZq6GA=;
        b=qTKmv98+co7MN/xoBYmwqnzD3JWeRG9lhhDDfrDOWlhgPBXr2RdZd3iXZV3yTxwYG7
         p+unfu2VY8Ie7hTBl5DbTVi3c5fQu+43vfDqiGIsUX/OLZwZXH6C623C5Q0YcmAWcf+V
         lUetlOqVDWPHJqf2/6hXjODXSPjBCJkllnPXmuO1F9LBcZ9kHuSCpu/J2hURsh7xRLgy
         f0AROyGqz1RSFd2nVXxyTKjV61Qd0KJtxM2MVK74zfBrd+2IQuualz8sjvTJOsfvuypL
         ShdAHNwpL6rYVVw9mMryDbTKb/9TZMzMm6Yx2W8Oqtx5Kq0gtj3IEFZVeZRU5jYzAKIR
         HhFg==
X-Gm-Message-State: AOAM530sdmM1wWEeap1py6lbtxaz6yrTlKMShQRTZuRHCu7ZZt1cwmmN
	sXkI5/O20C3C85TnwLWVUckzOvHd5wVZpUG8aXQ=
X-Google-Smtp-Source: ABdhPJyiYxB3eD3jjL+Io5dGim48y2+1MxQejBywAZrQ0kk7faaWW7yhzra+DHn82FTKJC7/uobRknbpMYoquRpqWpI=
X-Received: by 2002:a17:906:b118:: with SMTP id u24mr1755730ejy.331.1619074633315;
 Wed, 21 Apr 2021 23:57:13 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 22 Apr 2021 14:57:01 +0800
Message-ID: <CA+WQbwvVbQd4niZX1uwPv6oA4RFMeN9f_qsf9OtD4ramJRhzHA@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 00/21] mptcp: data checksum support
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your patches. I'll test them today and give you feedback.

-Geliang

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8822=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Changes from v2:
>  - implement RFC behavior WRT csum failure and csum mismatch
>  - cope with zero win probe and re-injection
>  - fix csum computation for DSS with data_fin flag set
>
> I kept the changes from the previous iteration in squash-to
> patches to hopefully simplfy the review process.
>
> There are at still least a couple of rough edges:
> - csum computation in the rx path for DSS with data fin set
>   is likely uncorrect
> - the csum computation in the tx path is very suboptimal.
>
> Anyhow, I propose to address the above with additional squash-to patches
> to avoid complex/extra long review cycles.
>
> Geliang Tang (14):
>   mptcp: add csum_enabled in mptcp_sock
>   mptcp: generate the data checksum
>   mptcp: add csum_reqd in mptcp_out_options
>   mptcp: send out checksum for MP_CAPABLE with data
>   mptcp: send out checksum for DSS
>   mptcp: add sk parameter for mptcp_parse_option
>   mptcp: add csum_reqd in mptcp_options_received
>   mptcp: receive checksum for MP_CAPABLE with data
>   mptcp: receive checksum for DSS
>   mptcp: validate the data checksum
>   mptcp: add the mib for data checksum
>   mptcp: add a new sysctl checksum_enabled
>   selftests: mptcp: enable checksum in mptcp_connect.sh
>   selftests: mptcp: enable checksum in mptcp_join.sh
>
> Paolo Abeni (7):
>   Squash-to: "mptcp: generate the data checksum"
>   Squash-to: "mptcp: send out checksum for MP_CAPABLE with data"
>   Squash-to "mptcp: send out checksum for DSS"
>   Squash-to: "mptcp: receive checksum for MP_CAPABLE with data"
>   Squash-to: "mptcp: receive checksum for DSS"
>   Squash-to: mptcp: validate the data checksum
>   mptcp: tune re-injections for csum enabled mode.
>
>  Documentation/networking/mptcp-sysctl.rst     |   8 +
>  include/net/mptcp.h                           |   7 +-
>  include/uapi/linux/mptcp.h                    |   1 +
>  net/mptcp/ctrl.c                              |  14 ++
>  net/mptcp/mib.c                               |   1 +
>  net/mptcp/mib.h                               |   1 +
>  net/mptcp/mptcp_diag.c                        |   1 +
>  net/mptcp/options.c                           | 147 +++++++++++++-----
>  net/mptcp/protocol.c                          |  39 ++++-
>  net/mptcp/protocol.h                          |  22 ++-
>  net/mptcp/subflow.c                           | 136 +++++++++++++---
>  .../selftests/net/mptcp/mptcp_connect.sh      |  13 +-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 107 ++++++++++++-
>  13 files changed, 420 insertions(+), 77 deletions(-)
>
> --
> 2.26.2
>
