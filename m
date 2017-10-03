Content-Type: multipart/mixed; boundary="===============2403241708030072809=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 00/18] Make TCP_MD5 adopt the extra-option
 framework
Date: Tue, 03 Oct 2017 09:26:03 -0700
Message-ID: <20171003162603.GD92528@Chimay.local>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 104

--===============2403241708030072809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Oh, and btw., I still need to test this :)

I will be writing some tests using TCP_MD5 in the next days.


Christoph

On 03/10/17 - 09:21:46, Christoph Paasch wrote:
> Tried to split it in several patches.
> =

> Here is the overview:
> Patch 1 to 5: Solely TCP-level changes to prepare the stack. Mostly cosme=
tic,
>               besides #1 and #5. #1 should be ok, #5 is a bit more fundam=
ental
> 	      change but I think it's still ok.
> Patch 6 to 11: Mat's patch, together with some more changes to it. My cha=
nges
>                should be merged into Mat's patch, but I let them out for =
now
> 	       so that it's clear what I had to change.
> Patch 12 to 14: Changes to TCP_MD5 to enable it to opt-in to the framewor=
k.
>                 Should be all fairly straight-forward.
> Patch 15: Here, I move all TCP_MD5-code to its own file.
> Patch 16: I should probably move this to the patchset 12 to 14.
> Patch 17: Here, I start using the framework
> Patch 18: Cleanup thanks to the use of the framework.
> =

> =

> In particular, patch 18 shows how the framework allows to cleanup TCP from
> TCP_MD5-changes.
> =

> =

> =

> Some comments about the extra-option framework:
> =

> 1) As already discussed, it would be good to have the callbacks on a per-=
socket
> basis. Basically, I think the list should be in tcp_sock where this list =
would
> simply be a list of structs:
> struct tcp_extra_option {
> 	struct list_head teo_list;
> 	struct tcp_extra_options_opts *teo_ops;
> };
> =

> Users of this framework would allocate these elements like this (e.g., TC=
P_MD5):
> struct tcp_md5_extra_option {
> 	struct tcp_extra_option tcp_md5_eo;
> 	struct tcp_md5sig_info  __rcu *md5sig_info;
> };
> =

> This allows MD5 to store its state info inside there. We could nicely fit=
 MPTCP
> into this.
> =

> 2)
> I chose to leave the extra_options at the end of tcp_syn_options.
> This however means that we have to undo what TCP timestamps did in tcp_sy=
n_options.
> Unsetting the flags is easy, but the nasty part is with:
> +               /* Don't use TCP timestamps with TCP_MD5 */
> +               if (opts->options & OPTION_TS)
> +                       ret -=3D TCPOLEN_TSTAMP_ALIGNED;
> =

> Yes, this is ugly. But, the only way from what I see if we want to fully
> remove TCP_MD5 out of TCP.
> =

> 3) With request_socks now being full socks, the prepare and prepare_req c=
allbacks
> could be merged.
> =

> 4) We also need this framwork for time_wait_socks. So, in general, we cou=
ld have
> the callback list in struct sock_common as well, that way tcp_sock, tcp_t=
ime_wait_sock
> and request_socks get it.
> =

> This implies that we need to initialize this in tcp_time_wait() and destr=
oy it
> in tcp_twsk_destructor. That would allow to remove even more MD5-code out=
 of
> TCP.
> =

> =

> I can work on these changes to the extra-option framework.
> =

> Any thoughts? :)
> =

> Christoph Paasch (17):
>   tcp: Write options after the header has been fully done
>   tcp: Pass sock to tcp_options_write instead of tcp_sock
>   tcp: Pass skb in tcp_options_write
>   tcp: Pass sock to tcp_synack_options
>   tcp6: Prepare for maximum TCP option-space
>   tcp_extra_option: add_header callback for TCP extra options
>   tcp_extra_option: Add missing static branch for
>     tcp_extra_options_prepare
>   tcp_extra_option: Use sock instead of tcp_sock in
>     tcp_extra_options_parse/prepare/write
>   tcp_extra_option: Pass skb to tcp_extra_options_write
>   tcp_extra_option: Pass sock to prepare_req
>   tcp_md5: Detect key inside tcp_v4_send_ack instead of passing it as an
>     argument
>   tcp_md5: Detect key inside tcp_v6_send_response instead of passing it
>     as an argument
>   tcp_md5: Check for TCP_MD5 after TCP Timestamps in
>     tcp_established_options
>   tcp: Move TCP-MD5 code out of TCP itself
>   tcp_md5: Don't pass along md5-key
>   tcp_md5: Use tcp_extra_options in output path
>   tcp_md5: Cleanup TCP-code
> =

> Mat Martineau (1):
>   tcp: Register handlers for extra TCP options
> =

>  drivers/infiniband/hw/cxgb4/cm.c |    2 +-
>  include/linux/inet_diag.h        |    1 +
>  include/linux/tcp.h              |   19 +-
>  include/linux/tcp_md5.h          |  109 ++++
>  include/net/tcp.h                |  157 ++---
>  net/ipv4/Makefile                |    1 +
>  net/ipv4/syncookies.c            |    2 +-
>  net/ipv4/tcp.c                   |  219 +++----
>  net/ipv4/tcp_diag.c              |   81 +--
>  net/ipv4/tcp_input.c             |   54 +-
>  net/ipv4/tcp_ipv4.c              |  496 +---------------
>  net/ipv4/tcp_md5.c               | 1169 ++++++++++++++++++++++++++++++++=
++++++
>  net/ipv4/tcp_minisocks.c         |   35 +-
>  net/ipv4/tcp_output.c            |  139 ++---
>  net/ipv6/syncookies.c            |    2 +-
>  net/ipv6/tcp_ipv6.c              |  352 +-----------
>  16 files changed, 1560 insertions(+), 1278 deletions(-)
>  create mode 100644 include/linux/tcp_md5.h
>  create mode 100644 net/ipv4/tcp_md5.c
> =

> -- =

> 2.14.1
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============2403241708030072809==--
