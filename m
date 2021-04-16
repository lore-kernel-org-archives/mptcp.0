Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAB29CA
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 10:54:23 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id r12so41520947ejr.5
        for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=prRqfvCrkyy5RtSJxNqzZbfd4V+Wp+8SCCl90CPHCiU=;
        b=gFGWtuPJ+eJ0M9FUCvOWl04akI0P76qihqGSUw+dG3DyUxs1jqRiKS32m1G2Wa6LZy
         PkhFa8rtKjffjNcYrqCb1BT5D4qacKQxG3nQ0mmJO9HJ5vrytsr6k8dvooGS0eaHICrh
         9BWdVo4i+eHy9vutNcfPxmAVC6nXnGlIBBeWm74RFQWlgycHtQUFGGpAG2LEk/P30Jg6
         5vawpypLDMeQFUe5RUMQwlFtFX4u3cndcateGCgo5igXtXj0Zg4mvRrt5km7gXTZrJBl
         01mvdeU1GThrxaiRNbqexK7iWYymtTVRws6Y3E+oYeLLbCSybLkzW5ZsdjL1OZJREOJw
         zFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=prRqfvCrkyy5RtSJxNqzZbfd4V+Wp+8SCCl90CPHCiU=;
        b=mlxSumfqfWxRBgHft6BokQu0v1k8XaMTI6c+dPA8K0b6P8QWyiOoRmqO783JXKd00z
         0cURrEj14hBdEJormm/5YSZhA2IwoWxyRu7Dp7QXdz64mHHLYRUw6S+FxNVhDDTO+XKT
         z988XeR+wWoNV16KbQL6GulILS7IQGiTf+RIlgOUVKUTJOOMNWElcDjvXN02ZLf4Ricv
         y8uxN7OqLv3rhzaIJOnAIIWmWbkACBUmgmRjGWWNe2+f7Zs8SBw2WGR4ENMXwVVJRcEb
         vHkkW7U0kwWdZb0eEzdRMpGmc/YMLs/nKxmppwp4j5hT83a2rqnkqwg8505UZEk7hH6B
         pG5A==
X-Gm-Message-State: AOAM532KZZ41JXNb18PcfKr9gxsXRJ6R50bg/ivsBecTz6O1WgNeEmQj
	uTbQVCeF3C9WCKRKuBBiF/l9Dqjx8N8NWXamppc=
X-Google-Smtp-Source: ABdhPJxyT6qTaqzghaMwZUeZp3XA8SvOwzrJj6g0ifMwsRFacPktqNPVhALT9chKOO5ytlBUdN02CfnV/gIeIN2lUZk=
X-Received: by 2002:a17:906:1784:: with SMTP id t4mr7932298eje.167.1618570461983;
 Fri, 16 Apr 2021 03:54:21 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1618565378-148180-1-git-send-email-liyonglong@chinatelecom.cn> <1618565378-148180-2-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1618565378-148180-2-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 16 Apr 2021 18:54:09 +0800
Message-ID: <CA+WQbwvgrV0bu7JpcsMb+DGi_0v6sS=HRRsVaz1K4N3R9hQ4tg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests: mptcp: add a test case for MSG_PEEK
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Florian Westphal <fw@strlen.de>, 
	Paolo Abeni <pabeni@redhat.com>, qitiepeng@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Did you check this patch with the checkpatch.pl script?

-Geliang

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B44=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:31=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Extend mptcp_connect tool with MSG_PEEK support and add a test case in
> mptcp_connect.sh that checks the data recvived from/after recv() with
> MSG_PEEK.
>
> eg: sh mptcp_connect.sh -4 -m poll -P
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c  | 45 ++++++++++++++++=
+++++-
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 38 ++++++++++++++++=
+-
>  2 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 2f207cf..668a041 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -45,7 +45,14 @@ enum cfg_mode {
>         CFG_MODE_SENDFILE,
>  };
>
> +enum cfg_peek {
> +       CFG_NONE_PEEK,
> +       CFG_WITH_PEEK,
> +       CFG_AFTER_PEEK,
> +};
> +
>  static enum cfg_mode cfg_mode =3D CFG_MODE_POLL;
> +static enum cfg_peek cfg_peek =3D CFG_NONE_PEEK;
>  static const char *cfg_host;
>  static const char *cfg_port    =3D "12000";
>  static int cfg_sock_proto      =3D IPPROTO_MPTCP;
> @@ -73,6 +80,7 @@ static void die_usage(void)
>         fprintf(stderr, "\t-M mark -- set socket packet mark\n");
>         fprintf(stderr, "\t-u -- check mptcp ulp\n");
>         fprintf(stderr, "\t-w num -- wait num sec before closing the sock=
et\n");
> +       fprintf(stderr, "\t-P [saveWithPeek|saveAfterPeek] -- save data w=
ith/after MSG_PEEK form tcp socket \n");
>         exit(1);
>  }
>
> @@ -331,6 +339,8 @@ static size_t do_write(const int fd, char *buf, const=
 size_t len)
>
>  static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
>  {
> +       int ret =3D 0;
> +       char tmp[16384];
>         size_t cap =3D rand();
>
>         cap &=3D 0xffff;
> @@ -340,7 +350,17 @@ static ssize_t do_rnd_read(const int fd, char *buf, =
const size_t len)
>         else if (cap > len)
>                 cap =3D len;
>
> -       return read(fd, buf, cap);
> +       if (cfg_peek =3D=3D CFG_WITH_PEEK) {
> +               ret =3D recv(fd, buf, cap, MSG_PEEK);
> +               ret =3D (ret < 0) ? ret : read(fd, tmp, ret);
> +       } else if (cfg_peek =3D=3D CFG_AFTER_PEEK) {
> +               ret =3D recv(fd, buf, cap, MSG_PEEK);
> +               ret =3D (ret < 0) ? ret : read(fd, buf, cap);
> +       } else {
> +               ret =3D read(fd, buf, cap);
> +       }
> +
> +       return ret;
>  }
>
>  static void set_nonblock(int fd)
> @@ -819,6 +839,24 @@ int parse_mode(const char *mode)
>         return 0;
>  }
>
> +int parse_peek(const char *mode)
> +{
> +       if (!strcasecmp(mode, "saveWithPeek"))
> +               return CFG_WITH_PEEK;
> +       if (!strcasecmp(mode, "saveAfterPeek"))
> +               return CFG_AFTER_PEEK;
> +
> +       fprintf(stderr, "Unknown: %s\n", mode);
> +       fprintf(stderr, "Supported MSG_PEEK mode are:\n");
> +       fprintf(stderr, "\t\t\"saveWithPeek\" - recv data with flags 'MSG=
_PEEK' and save the peek data into file \n");
> +       fprintf(stderr, "\t\t\"saveAfterPeek\" - read data form socket an=
d save it into file after recv with flags 'MSG_PEEK' \n");
> +
> +       die_usage();
> +
> +       /* silence compiler warning */
> +       return 0;
> +}
> +
>  static int parse_int(const char *size)
>  {
>         unsigned long s;
> @@ -846,7 +884,7 @@ static void parse_opts(int argc, char **argv)
>  {
>         int c;
>
> -       while ((c =3D getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:")) !=3D=
 -1) {
> +       while ((c =3D getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:P:")) !=
=3D -1) {
>                 switch (c) {
>                 case 'j':
>                         cfg_join =3D true;
> @@ -899,6 +937,9 @@ static void parse_opts(int argc, char **argv)
>                 case 'M':
>                         cfg_mark =3D strtol(optarg, NULL, 0);
>                         break;
> +               case 'P':
> +                       cfg_peek =3D parse_peek(optarg);
> +                       break;
>                 }
>         }
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index 385cdc9..6f77e04 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -3,7 +3,7 @@
>
>  time_start=3D$(date +%s)
>
> -optstring=3D"S:R:d:e:l:r:h4cm:f:t"
> +optstring=3D"S:R:d:e:l:r:h4cm:f:tP"
>  ret=3D0
>  sin=3D""
>  sout=3D""
> @@ -23,6 +23,8 @@ rcvbuf=3D0
>  options_log=3Dtrue
>  do_tcp=3D0
>  filesize=3D0
> +testpeek=3Dfalse
> +peekmode=3D""
>
>  if [ $tc_loss -eq 100 ];then
>         tc_loss=3D1%
> @@ -47,6 +49,7 @@ usage() {
>         echo -e "\t-R: set rcvbuf value (default: use kernel default)"
>         echo -e "\t-m: test mode (poll, sendfile; default: poll)"
>         echo -e "\t-t: also run tests with TCP (use twice to non-fallback=
 tcp)"
> +       echo -e "\t-P: test MSG_PEEK flags of recv() function"
>  }
>
>  while getopts "$optstring" option;do
> @@ -104,6 +107,10 @@ while getopts "$optstring" option;do
>         "t")
>                 do_tcp=3D$((do_tcp+1))
>                 ;;
> +       "P")
> +               testpeek=3Dtrue
> +               peekmode=3D"saveWithPeek"
> +               ;;
>         "?")
>                 usage $0
>                 exit 1
> @@ -393,6 +400,10 @@ do_transfer()
>                 extra_args=3D"$extra_args -m $testmode"
>         fi
>
> +       if $testpeek; then
> +               extra_args=3D"$extra_args -P $peekmode"
> +       fi
> +
>         if [ -n "$extra_args" ] && $options_log; then
>                 options_log=3Dfalse
>                 echo "INFO: extra options: $extra_args"
> @@ -706,6 +717,31 @@ echo "on ns3eth4"
>
>  tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms=
 $tc_reorder
>
> +if $testpeek; then
> +       run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> +       if [ $ret -ne 0 ] ;then
> +               echo "FAIL: Could not even run loopback test" 1>&2
> +               exit $ret
> +       fi
> +       run_tests_lo "$ns1" $sender dead:beef:1::1 1
> +       if [ $ret -ne 0 ] ;then
> +               echo "FAIL: Could not even run loopback v6 test" 2>&1
> +               exit $ret
> +       fi
> +
> +       #set peekmode=3D"saveAfterPeek" and test again
> +       options_log=3Dtrue
> +       peekmode=3D"saveAfterPeek"
> +       run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> +       run_tests_lo "$ns1" $sender dead:beef:1::1 1
> +
> +       time_end=3D$(date +%s)
> +       time_run=3D$((time_end-time_start))
> +       echo "Time: ${time_run} seconds"
> +
> +       exit $ret
> +fi
> +
>  for sender in $ns1 $ns2 $ns3 $ns4;do
>         run_tests_lo "$ns1" "$sender" 10.0.1.1 1
>         if [ $ret -ne 0 ] ;then
> --
> 1.8.3.1
>
>
