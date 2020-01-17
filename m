Content-Type: multipart/mixed; boundary="===============3053229098877099597=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: handle ipv4-mapped ipv6 address.
Date: Thu, 16 Jan 2020 17:24:00 -0800
Message-ID: <alpine.OSX.2.21.2001161721070.45790@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: e7f5b14540a28e29842f43587964ad111e40456c.1579213677.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3386

--===============3053229098877099597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 16 Jan 2020, Paolo Abeni wrote:

> The TCP code unconditionally overwrite in a few places 'icsk->icsk_af_ops=
',
> which lead to the wrong oops being called for ipv4-mapped ipv6 address.
> e.g. Kasan notice a invalid slub access running packetdrill ipv4-mapped
> tests.
>
> This patch try to address the issue building ipv4-mapped  mptcp icsk ops
> and using it when appropriate:
> - on connect() for ipv4 mapped address (and ev. failure)
> - on syn_recv_sock() - passive socket creation
>
> Additionally subflow_v6_conn_request() should call into subflow_v4_conn_r=
equest()
> for ipv4 packets, otherwise we always fallback on passive socket bound to
> ipv4 mapped addresses.
>
> Note: this still touches af_ops twice. If we do differently, alike:
>
> 	if (sk_is_mptcp(newsk))
> 		mptcp_handle_ipv6_mapped(sk, true);
> 	else
> 		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
>
> we need either:
> - additionally handle the #ifnef CONFIG_MPTCP_IPV6 case in
> as mptcp_handle_ipv6_mapped(), as we risk to skip 'icsk_af_ops'
> initialization otherwise.
> - wrap the above mptcp_handle_ipv6_mapped() call under
> a preprocessor's conditional (CONFIG_MPTCP_IPV6).
>
> v1 -> v2:
> - fixed mptcp_handle_ipv6_mapped() argument on 2nd call (mat)
> - add squash-to tag

v2 looks good to me, thanks Paolo.

Mat


>
> RFC -> v1:
> - drop unneeded mptcp_chk_mapped()
> - fix subflow_v6_conn_request()
> - add missing hook into tcp_v6_syn_recv_sock()
>
> Squash-to: "mptcp: Handle MP_CAPABLE options for outgoing connections"
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> include/net/mptcp.h |  2 ++
> net/ipv6/tcp_ipv6.c |  6 ++++++
> net/mptcp/subflow.c | 46 +++++++++++++++++++++++++++++++++++++++------
> 3 files changed, 48 insertions(+), 6 deletions(-)
>

--
Mat Martineau
Intel
--===============3053229098877099597==--
