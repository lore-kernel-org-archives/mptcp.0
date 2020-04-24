Content-Type: multipart/mixed; boundary="===============5640602066492135831=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix race in msk status update
Date: Fri, 24 Apr 2020 11:24:33 -0700
Message-ID: <alpine.OSX.2.22.394.2004241123300.64783@zzhu12-mobl.amr.corp.intel.com>
In-Reply-To: 4d5e3c09ca38a0a3ec951fa4f5bfc65d5cd40129.1587725562.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4245

--===============5640602066492135831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 24 Apr 2020, Paolo Abeni wrote:

> Currently subflow_finish_connect() changes unconditionally
> any msk socket status other than TCP_ESTABLISHED.
>
> If an unblocking connect() races with close(), we can end-up
> triggering:
>
> IPv4: Attempt to release TCP socket in state 1 00000000e32b8b7e
>
> when the msk socket is disposed.
>
> Be sure to enter the established status only from SYN_SENT.
>
> Fixes: c3c123d16c0e ("net: mptcp: don't hang in mptcp_sendmsg() after TCP=
 fallback")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---

Thanks Paolo, looks good.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============5640602066492135831==--
