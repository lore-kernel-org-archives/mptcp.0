Content-Type: multipart/mixed; boundary="===============4310367385816361374=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 08/11] tcp: Export TCP functions and
 ops struct
Date: Fri, 20 Dec 2019 07:31:37 -0800
Message-ID: <35243533-62c3-761b-f067-10ff5b3b27cc@gmail.com>
In-Reply-To: 20191219223434.19722-9-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3218

--===============4310367385816361374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/19/19 2:34 PM, Mat Martineau wrote:
> MPTCP will make use of tcp_send_mss() and tcp_push() when sending
> data to specific TCP subflows.
> =

> tcp_request_sock_ipvX_ops and ipvX_specific will be referenced
> during TCP subflow creation.
> =

> Co-developed-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---

Reviewed-by: Eric Dumazet <edumazet(a)google.com>

--===============4310367385816361374==--
