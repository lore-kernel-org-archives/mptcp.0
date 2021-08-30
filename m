Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2C3FC6
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 04:19:03 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id fz10so8616639pjb.0
        for <mptcp@lists.linux.dev>; Sun, 29 Aug 2021 21:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNe3anjwpv2ulgnHmA/0ZDX2NIxUGAa9FWNuMVx9Egc=;
        b=DjHX+ANttONpk7Y/YK4VsghonLHkRwFtPl+pIg0CN9eq4qi9pbzCjaTTFo+fSSzDnI
         AfpdKP+aCvGDypGE9/JR8SKZyLlpIwi146hxpybrDSJh+M/UKPV1LVfQkXG9bHb0ZjvW
         0TNme86y5MIJjVP3B1b7AsJnKOrCmTkrthxv+0dYkgbcD80vyTa+brI6Tq3q4eHyid99
         zuK/CM/fr5+Kai6JBSTmCiNEm13yT7G9groLMIEbZoP2S4frBx7QjcugsNAFZJ9rFlsp
         BETnUIiY9gAsEdexEXNoFZXY+gHmj49iB7g/CMCmGCi7DL19hXgsARzt67H2tsMNVqaz
         FsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNe3anjwpv2ulgnHmA/0ZDX2NIxUGAa9FWNuMVx9Egc=;
        b=bTnB7xVifZMuRLlWwZEHOrbOfHRy13ENuqw7SoM7qCo4fpiciu2MzfS8LRVZM/ZrCM
         BYpIfU4hcId8wYsDyHxa5PCgF4DYKHaQG0Pzf2Rpc/jUmv5QqRfk3mP5WaKNYRTjH6BG
         XRkcLD29Jzdip3RUHgJT2jsf64VsFBnDO56S4IMBWyca+PfBow2CJjabwFaEuYrWy89g
         TZt4hOvIx7vYXqQBDAL2iCkURmCrWxuir7pmk9a2LPsIYgGnKk+cHklFYcO7DbNayMzr
         dJxL3bUHEQIFdPqqxcyzBqNy2tHRwWTUy6i+b8kZPq/RKo72v41+CQpSl5CvWUFe5QXt
         cBcA==
X-Gm-Message-State: AOAM532Ni4aPDKF4GZ9L8RVmiC2VaGrZz5MnuwYnVAqKj7dmXU88giNE
	PFWFd8JIcodtgF2AptP/G5git6kkaHToIDnshxM=
X-Google-Smtp-Source: ABdhPJyW27TZ0SR6noItV8HbHXi9mtse41CgNFi0mJH/VIwyXPE2xIH8ENd0XDC7+nmnBq13lFR8bDqc/BW2M1jpjY0=
X-Received: by 2002:a17:90b:1017:: with SMTP id gm23mr37596830pjb.6.1630297143398;
 Sun, 29 Aug 2021 21:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210818102756.30734-1-fw@strlen.de> <20210818102756.30734-5-fw@strlen.de>
In-Reply-To: <20210818102756.30734-5-fw@strlen.de>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 30 Aug 2021 12:18:52 +0800
Message-ID: <CA+WQbwt2Mod43S=aXYce9JDOzFG1VkN3qRXAD7Wk2XJwy4x-Nw@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 4/5] mptcp: add MPTCP_SUBFLOW_ADDRS
 getsockopt support
To: Florian Westphal <fw@strlen.de>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I got this compile error in my Fedora-34 system (export/20210829T054626):

  DESCEND objtool
  DESCEND bpf/resolve_btfids
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  HDRTEST usr/include/linux/mptcp.h
In file included from <command-line>:
./usr/include/linux/mptcp.h:207:33: error: field =E2=80=98sa_local=E2=80=99=
 has incomplete type
  207 |                 struct sockaddr sa_local;
      |                                 ^~~~~~~~
./usr/include/linux/mptcp.h:209:37: error: field =E2=80=98sin6_local=E2=80=
=99 has
incomplete type
  209 |                 struct sockaddr_in6 sin6_local;
      |                                     ^~~~~~~~~~
./usr/include/linux/mptcp.h:210:41: error: field =E2=80=98ss_local=E2=80=99=
 has incomplete type
  210 |                 struct sockaddr_storage ss_local;
      |                                         ^~~~~~~~
./usr/include/linux/mptcp.h:213:33: error: field =E2=80=98sa_remote=E2=80=
=99 has incomplete type
  213 |                 struct sockaddr sa_remote;
      |                                 ^~~~~~~~~
./usr/include/linux/mptcp.h:215:37: error: field =E2=80=98sin6_remote=E2=80=
=99 has
incomplete type
  215 |                 struct sockaddr_in6 sin6_remote;
      |                                     ^~~~~~~~~~~
./usr/include/linux/mptcp.h:216:41: error: field =E2=80=98ss_remote=E2=80=
=99 has incomplete type
  216 |                 struct sockaddr_storage ss_remote;
      |                                         ^~~~~~~~~
make[2]: *** [usr/include/Makefile:106: usr/include/linux/mptcp.hdrtest] Er=
ror 1
make[1]: *** [scripts/Makefile.build:514: usr/include] Error 2
make: *** [Makefile:1851: usr] Error 2
make: *** Waiting for unfinished jobs....

How can I fix it, please give me some suggestion.

Thanks,
-Geliang

Florian Westphal <fw@strlen.de> =E4=BA=8E2021=E5=B9=B48=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:28=E5=86=99=E9=81=93=EF=BC=9A
>
> This retrieves the address pairs of all subflows currently
> active for a given mptcp connection.
>
> It re-uses the same meta-header as for MPTCP_TCPINFO.
>
> A new structure is provided to hold the subflow
> address data:
>
> struct mptcp_subflow_addrs {
>         union {
>                 __kernel_sa_family_t sa_family;
>                 struct sockaddr sa_local;
>                 struct sockaddr_in sin_local;
>                 struct sockaddr_in6 sin6_local;
>                 struct sockaddr_storage ss_local;
>         };
>         union {
>                 struct sockaddr sa_remote;
>                 struct sockaddr_in sin_remote;
>                 struct sockaddr_in6 sin6_remote;
>                 struct sockaddr_storage ss_remote;
>         };
> };
>
> Usage of the new getsockopt is very similar to
> MPTCP_TCPINFO one.
>
> Userspace allocates a
> 'struct mptcp_subflow_data', followed by one or
> more 'struct mptcp_subflow_addrs', then inits the
> mptcp_subflow_data structure as follows:
>
> struct mptcp_subflow_addrs *sf_addr;
> struct mptcp_subflow_data *addr;
> socklen_t olen =3D sizeof(*addr) + (8 * sizeof(*sf_addr));
>
> addr =3D malloc(olen);
> addr->size_subflow_data =3D sizeof(*addr);
> addr->num_subflows =3D 0;
> addr->size_kernel =3D 0;
> addr->size_user =3D sizeof(struct mptcp_subflow_addrs);
>
> sf_addr =3D (struct mptcp_subflow_addrs *)(addr + 1);
>
> and then retrieves the endpoint addresses via:
> ret =3D getsockopt(fd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS,
>                  addr, &olen);
>
> If the call succeeds, kernel will have added up to 8
> endpoint addresses after the 'mptcp_subflow_data' header.
>
> Userspace needs to re-check 'olen' value to detect how
> many bytes have been filled in by the kernel.
>
> Userspace can check addr->num_subflows to discover when
> there were more subflows that available data space.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  include/uapi/linux/mptcp.h | 17 +++++++
>  net/mptcp/sockopt.c        | 91 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 7c368fccd83e..c368c11a0ed9 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -201,8 +201,25 @@ struct mptcp_subflow_data {
>         __u32           size_user;                      /* size of one el=
ement in data[] */
>  } __attribute__((aligned(8)));
>
> +struct mptcp_subflow_addrs {
> +       union {
> +               __kernel_sa_family_t sa_family;
> +               struct sockaddr sa_local;
> +               struct sockaddr_in sin_local;
> +               struct sockaddr_in6 sin6_local;
> +               struct sockaddr_storage ss_local;
> +       };
> +       union {
> +               struct sockaddr sa_remote;
> +               struct sockaddr_in sin_remote;
> +               struct sockaddr_in6 sin6_remote;
> +               struct sockaddr_storage ss_remote;
> +       };
> +};
> +
>  /* MPTCP socket options */
>  #define MPTCP_INFO             1
>  #define MPTCP_TCPINFO          2
> +#define MPTCP_SUBFLOW_ADDRS    3
>
>  #endif /* _UAPI_MPTCP_H */
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index eb2905bfa089..8137cc3a4296 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -840,6 +840,95 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_soc=
k *msk, char __user *optval,
>         return 0;
>  }
>
> +static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subf=
low_addrs *a)
> +{
> +       struct inet_sock *inet =3D inet_sk(sk);
> +
> +       memset(a, 0, sizeof(*a));
> +
> +       if (sk->sk_family =3D=3D AF_INET) {
> +               a->sin_local.sin_family =3D AF_INET;
> +               a->sin_local.sin_port =3D inet->inet_sport;
> +               a->sin_local.sin_addr.s_addr =3D inet->inet_rcv_saddr;
> +
> +               if (!a->sin_local.sin_addr.s_addr)
> +                       a->sin_local.sin_addr.s_addr =3D inet->inet_saddr=
;
> +
> +               a->sin_remote.sin_family =3D AF_INET;
> +               a->sin_remote.sin_port =3D inet->inet_dport;
> +               a->sin_remote.sin_addr.s_addr =3D inet->inet_daddr;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       } else if (sk->sk_family =3D=3D AF_INET6) {
> +               const struct ipv6_pinfo *np =3D inet6_sk(sk);
> +
> +               a->sin6_local.sin6_family =3D AF_INET6;
> +               a->sin6_local.sin6_port =3D inet->inet_sport;
> +
> +               if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
> +                       a->sin6_local.sin6_addr =3D np->saddr;
> +               else
> +                       a->sin6_local.sin6_addr =3D sk->sk_v6_rcv_saddr;
> +
> +               a->sin6_remote.sin6_family =3D AF_INET6;
> +               a->sin6_remote.sin6_port =3D inet->inet_dport;
> +               a->sin6_remote.sin6_addr =3D sk->sk_v6_daddr;
> +#endif
> +       }
> +}
> +
> +static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char _=
_user *optval,
> +                                         int __user *optlen)
> +{
> +       struct sock *sk =3D &msk->sk.icsk_inet.sk;
> +       struct mptcp_subflow_context *subflow;
> +       unsigned int sfcount =3D 0, copied =3D 0;
> +       struct mptcp_subflow_data sfd;
> +       char __user *addrptr;
> +       int len;
> +
> +       len =3D mptcp_get_subflow_data(&sfd, optval, optlen);
> +       if (len < 0)
> +               return len;
> +
> +       sfd.size_kernel =3D sizeof(struct mptcp_subflow_addrs);
> +       sfd.size_user =3D min_t(unsigned int, sfd.size_user,
> +                             sizeof(struct mptcp_subflow_addrs));
> +
> +       addrptr =3D optval + sfd.size_subflow_data;
> +
> +       lock_sock(sk);
> +
> +       mptcp_for_each_subflow(msk, subflow) {
> +               struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +               ++sfcount;
> +
> +               if (len && len >=3D sfd.size_user) {
> +                       struct mptcp_subflow_addrs a;
> +
> +                       mptcp_get_sub_addrs(ssk, &a);
> +
> +                       if (copy_to_user(addrptr, &a, sfd.size_user)) {
> +                               release_sock(sk);
> +                               return -EFAULT;
> +                       }
> +
> +                       addrptr +=3D sfd.size_user;
> +                       copied +=3D sfd.size_user;
> +                       len -=3D sfd.size_user;
> +               }
> +       }
> +
> +       release_sock(sk);
> +
> +       sfd.num_subflows =3D sfcount;
> +
> +       if (mptcp_put_subflow_data(&sfd, optval, copied, optlen))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>                                     char __user *optval, int __user *optl=
en)
>  {
> @@ -862,6 +951,8 @@ static int mptcp_getsockopt_sol_mptcp(struct mptcp_so=
ck *msk, int optname,
>                 return mptcp_getsockopt_info(msk, optval, optlen);
>         case MPTCP_TCPINFO:
>                 return mptcp_getsockopt_tcpinfo(msk, optval, optlen);
> +       case MPTCP_SUBFLOW_ADDRS:
> +               return mptcp_getsockopt_subflow_addrs(msk, optval, optlen=
);
>         }
>
>         return -EOPNOTSUPP;
> --
> 2.31.1
>
>
