Content-Type: multipart/mixed; boundary="===============4317760675920391101=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC final 00/14] Generic TCP-option framework and
 adoption for TCP-SMC and TCP-MD5
Date: Sun, 17 Dec 2017 22:45:04 -0800
Message-ID: <20171218064504.GT64966@da0602a-dhcp135.apple.com>
In-Reply-To: 20171218064245.94150-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 290

--===============4317760675920391101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FYI, the SMC-patches did not make it as I had already the "Cc:" for the
SMC-author (and my git send-mail automatically added her) and I was too lazy
to remove the Cc again from the commit-message ;-)


Christoph

On 17/12/17 - 22:42:31, Christoph Paasch wrote:
> Final post to the mptcp-list before submission to netdev :)
> =

> ---
> =

> This patchset introduces a generic framework for handling TCP-options.
> =

> TCP-options like TCP_MD5 and SMC are rather rare use-cases, but their
> implementation is rather intrusive to the TCP-stack. Other, more recent
> TCP extensions like TCP-crypt, MPTCP or TCP-AO would make this situation
> even worse.
> =

> This new framework allows to add these TCP-options in a modular way. Writ=
ing,
> reading and acting upon these options is done through callbacks that get
> registered to a TCP-socket. A TCP-socket has a list of "extra" TCP-options
> that it will use.
> =

> We make TCP-SMC and TCP-MD5SIG adopt this new framework. As can be seen, =
there
> is now no more TCP-SMC code in the TCP-files and the TCP-MD5 code has been
> reduced to a bare minimum.
> =

> This patchset is admittedly rather big, but we wanted to show where the
> framework will lead to and what it enables. Suggestions as to how to bett=
er
> structure the patchset is appreciated.
> =

> One point of discussion might be whether or not we should use static-keys
> before accessing the tcp_option_list to avoid branching and the additional
> access to the tcp_sock, request-sock, time-wait-sock structure.
> The way static keys could be used is that they get incremented each time a
> socket starts using one of the new TCP-options and decremented when the s=
ocket
> eventually gets destroyed. A caveat of this design would be that if a hos=
t keeps
> on creating/closing these sockets in a sequence, each time we go into the=
 slow
> path of the static keys occuring potentially a big overhead to update all=
 the
> jump-labels.
> For now we opted for a simple if (unlikely(!hlist_empty(...)) check.
> =

> Feedback is very welcome!
> =

> Thanks,
> Mat & Christoph
> =

> =

> Christoph Paasch (13):
>   tcp: Write options after the header has been fully done
>   tcp: Pass sock and skb to tcp_options_write
>   tcp: Allow tcp_fast_parse_options to drop segments
>   tcp_smc: Make smc_parse_options return 1 on success
>   tcp_smc: Make SMC use TCP extra-option framework
>   tcp_md5: Don't pass along md5-key
>   tcp_md5: Detect key inside tcp_v4_send_ack instead of passing it as an
>     argument
>   tcp_md5: Detect key inside tcp_v6_send_response instead of passing it
>     as an argument
>   tcp_md5: Check for TCP_MD5 after TCP Timestamps in
>     tcp_established_options
>   tcp_md5: Move TCP-MD5 code out of TCP itself
>   tcp_md5: Use tcp_extra_options in output path
>   tcp_md5: Cleanup TCP-code
>   tcp_md5: Use TCP extra-options on the input path
> =

> Mat Martineau (1):
>   tcp: Register handlers for extra TCP options
> =

>  drivers/infiniband/hw/cxgb4/cm.c |    2 +-
>  include/linux/inet_diag.h        |    1 +
>  include/linux/tcp.h              |   43 +-
>  include/linux/tcp_md5.h          |   39 ++
>  include/net/inet_sock.h          |    3 +-
>  include/net/tcp.h                |  212 +++---
>  net/ipv4/Makefile                |    1 +
>  net/ipv4/syncookies.c            |    6 +-
>  net/ipv4/tcp.c                   |  391 ++++++++---
>  net/ipv4/tcp_diag.c              |   81 +--
>  net/ipv4/tcp_input.c             |  137 ++--
>  net/ipv4/tcp_ipv4.c              |  552 ++--------------
>  net/ipv4/tcp_md5.c               | 1359 ++++++++++++++++++++++++++++++++=
++++++
>  net/ipv4/tcp_minisocks.c         |   77 +--
>  net/ipv4/tcp_output.c            |  182 +----
>  net/ipv6/syncookies.c            |    6 +-
>  net/ipv6/tcp_ipv6.c              |  386 ++---------
>  net/smc/af_smc.c                 |  190 +++++-
>  18 files changed, 2222 insertions(+), 1446 deletions(-)
>  create mode 100644 include/linux/tcp_md5.h
>  create mode 100644 net/ipv4/tcp_md5.c
> =

> -- =

> 2.15.0
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============4317760675920391101==--
