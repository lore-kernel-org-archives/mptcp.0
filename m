Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BD70
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 02:50:18 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id t4so4416274plc.6
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 19:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=19gdj25nV+J0/j6iUbELyNNy1f4k/ybIzOi9b169VjM=;
        b=Jg9pXwngKKpE6Ch6gOXor6ZpK4S3FeaK9XZaXN/QCUSnjTlgkCPLvT2L/KEnNS6xJn
         v+SuWoFGjJ55tGFtPC2iIgXiUwMO/c52ooNwynDykNrDhuiEwgQ9cldFP39pmfNE9BBK
         y442bze2icNtkgoB5/GCuhJjGBTY/3xxVaE6E+IpJswSg+FHyGZt6PWYVTQM4QoPQO+I
         vuBBI9aqO2XCC/Bz/N8D3h9VxtvGw3ClsccwsNNNSjveIsKOQBfnwXZv4LNH59333qaq
         vau4l2nOfEXcSGMn51R7SQ/MF1WhszcZHWMEprTDBn2oYD+SSi/O9AsLnS9/HbT0+BlH
         Z0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=19gdj25nV+J0/j6iUbELyNNy1f4k/ybIzOi9b169VjM=;
        b=F6Orue67RLI8JLYG2HO4B8rBbd9jD5Z0TXMVdVzJQQHGW0V5UY+Wvdhba3+g9QD7ES
         LbVpErRhekk1IdY3E/RqRPppflRwaZjz0bG5RdOoTRvRf6H6I8Y9XQgmpuez+aTt9bTm
         TjzMx8Lpd2b3a/6HC+rFRop2gUcWPMtMHNIoEL6HO7BKqju8pN2yxPmaJjEcEj8A/K3S
         GbN8jHCZEnnm9/AZvXrbK8f4Z1Q6oPG+v3Ij1tgvPP0c0nB/KMLLPhoaNXsyxbG28Qh8
         bmU1t9UUmLFl3TkHBfOIefDlOieqXYqA4ylvVegoSd4l/sXUPYfcBE81IQqkWeUjbdB1
         6VEQ==
X-Gm-Message-State: AOAM531Kne3M4s6UYpykP0vbvPGZ3cTTF61osQvxACfeNFUJH+FkDR8i
	SSgp1AAxDy6hdQyOMCEvzkELj98jiw7Mrv+9EmbcI+aW3bg=
X-Google-Smtp-Source: ABdhPJxbRoveHz62pG3vy/OQ7fwk/SyQLHfFVZwH3QpP1cFoU6Tj9IGfkt4OnKDyiudE/nt0HiwTnVamkEE4q86O7Rs=
X-Received: by 2002:a17:902:8693:b029:eb:53f:1336 with SMTP id
 g19-20020a1709028693b02900eb053f1336mr7838058plo.52.1620355817662; Thu, 06
 May 2021 19:50:17 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1620286893.git.geliangtang@gmail.com> <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com>
 <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com>
In-Reply-To: <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 7 May 2021 10:50:06 +0800
Message-ID: <CA+WQbwvjyRF+hpcOfFJoaam8+X1y_eF9N3JQSA6hvbfbMQdp_g@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 2/5] Squash to "mptcp: add the mib
 for data checksum"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=886=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:48=E5=86=99=E9=81=93=EF=BC=9A
>
> Rename DSSCSUM to DATACSUM.
>
> Please update the commit log too:
>
> '''
> This patch added the mib for the data checksum, MPTCP_MIB_DATACSUMERR.
> '''
>

Thanks for apply this patch to the export branch, please update the commit
log too:

MPTCP_MIB_DSSCSUMERR -> MPTCP_MIB_DATACSUMERR

Thanks.

-Geliang

> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/mib.c     | 2 +-
>  net/mptcp/mib.h     | 2 +-
>  net/mptcp/subflow.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index c7042e3317b5..e7e60bc1fb96 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -25,7 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
>         SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
>         SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
>         SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
> -       SNMP_MIB_ITEM("DSSCsumErr", MPTCP_MIB_DSSCSUMERR),
> +       SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
>         SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
>         SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
>         SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index c407358eced8..92e56c0cfbdd 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -18,7 +18,7 @@ enum linux_mptcp_mib_field {
>         MPTCP_MIB_JOINACKMAC,           /* HMAC was wrong on ACK + MP_JOI=
N */
>         MPTCP_MIB_DSSNOMATCH,           /* Received a new mapping that di=
d not match the previous one */
>         MPTCP_MIB_INFINITEMAPRX,        /* Received an infinite mapping *=
/
> -       MPTCP_MIB_DSSCSUMERR,           /* The DSS checksum fail */
> +       MPTCP_MIB_DATACSUMERR,          /* The data checksum fail */
>         MPTCP_MIB_OFOQUEUETAIL, /* Segments inserted into OoO queue tail =
*/
>         MPTCP_MIB_OFOQUEUE,             /* Segments inserted into OoO que=
ue */
>         MPTCP_MIB_OFOMERGE,             /* Segments merged in OoO queue *=
/
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f60a2fe1a2cf..c8968038174f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -902,7 +902,7 @@ static enum mapping_status validate_data_csum(struct =
sock *ssk, struct sk_buff *
>
>         csum =3D csum_partial(&header, sizeof(header), subflow->map_data_=
csum);
>         if (unlikely(csum_fold(csum))) {
> -               MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
> +               MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
>                 return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY=
;
>         }
>
> --
> 2.31.1
>
