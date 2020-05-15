Content-Type: multipart/mixed; boundary="===============7864214561223287716=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 2/3] inet_connection_sock: factor out
 destroy helper.
Date: Fri, 15 May 2020 11:09:45 -0700
Message-ID: <alpine.OSX.2.22.394.2005151109100.36555@rasanche-mobl.amr.corp.intel.com>
In-Reply-To: 9cb1cf2e8b9dc89510ab38c938e2ba102b207d2f.1589558049.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4399

--===============7864214561223287716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 15 May 2020, Paolo Abeni wrote:

> Move the steps to prepare an inet_connection_sock for
> forced disposal inside a separate helper. No functional
> changes inteded, this will just simplify the next patch.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Reviewed-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> include/net/inet_connection_sock.h | 8 ++++++++
> net/ipv4/inet_connection_sock.c    | 6 +-----
> 2 files changed, 9 insertions(+), 5 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7864214561223287716==--
