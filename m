Content-Type: multipart/mixed; boundary="===============5434604729875278477=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: add ADD_ADDR IPv6
 support
Date: Mon, 21 Sep 2020 12:50:37 +0200
Message-ID: <7420bd7cf84fc19aef2fced488db0b6a2112cabe.camel@redhat.com>
In-Reply-To: aa214a833e31f406fe542366a56198d6edc91fd9.1600608822.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5960

--===============5434604729875278477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-09-20 at 21:42 +0800, Geliang Tang wrote:
> When ADD_ADDR suboption include an IPv6 address, the size is 28
> octets.
> It will not fit when other options are included, e.g. TCP Timestamps.
> So
> here we send out a mptcp dedicated packet to carry only mptcp
> options.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v2:
>  - avoid adding new field to tcp_sock, add new field in
> mptcp_pm_data.
>  - drop OPTION_TS in mptcp_established_options_add_addr, not in
> tcp_established_options.
> ---
>  include/net/mptcp.h                           |  3 +-
>  include/net/tcp.h                             | 21 ++++++++++++
>  net/ipv4/tcp_output.c                         | 23 +------------

whooops... my fault! I did not take in account that 'struct
tcp_out_options' is not currently exported via the headers. I'm unsure
moving such definition there will be acceptable. At least it will
deserve a separate patch.

On the flip side even the other option available (v1 of this patch)
does not look 110% upstrean acceptable to me. =


I'd like to ear opinion from others before going on a somewhat
dangerous path...

thanks,

Paolo

--===============5434604729875278477==--
