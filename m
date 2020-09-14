Content-Type: multipart/mixed; boundary="===============2096327180954028012=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 01/13] mptcp: rethink 'is writable'
 conditional
Date: Mon, 14 Sep 2020 11:00:26 -0700
Message-ID: <alpine.OSX.2.23.453.2009141056210.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: ae4a76d7e6c72044d63128689155643e9f888e74.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5849

--===============2096327180954028012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Currently, when checking for the 'msk is writable' condition, we
> look at the individual subflows write space.
> That works well while we send data via a single subflow, but will
> not as soon as we will enable concurrent xmit on multiple subflows.
>
> With this change msk becomes writable when the following conditions
> hold:
> - the socket has some free write space
> - there is at least a subflow with write free space
>
> Additionally we need to set the NOSPACE bit on all subflows
> before blocking.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 71 ++++++++++++++++++++++++++++----------------
> net/mptcp/subflow.c  |  6 ++--
> 2 files changed, 50 insertions(+), 27 deletions(-)
>

Thanks for the v2 Paolo. I've reviewed the series and will tag them all =

so patchwork is updated.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2096327180954028012==--
