Content-Type: multipart/mixed; boundary="===============0872652658834911689=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: harmonize locking on all socket
 operations.
Date: Mon, 22 Jul 2019 16:02:57 -0700
Message-ID: <alpine.OSX.2.21.1907221601590.2401@mjmartin-mac01.local>
In-Reply-To: f3fb40cd330e058e8eb21b3701eb0c5c01dc2324.1562860777.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1541

--===============0872652658834911689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 11 Jul 2019, Paolo Abeni wrote:

> The locking schema implied by sendmsg(), recvmsg(), etc.
> requires acquiring the msk's socket lock before manipulating
> the msk internal status.
>
> Additionally, we can't acquire the msk->subflow socket lock while holding
> the msk lock, due to mptcp_finish_connect().
>
> Many socket operations do not enforce the required locking, e.g. we have
> several patterns alike:
>
> 	if (msk->subflow)
> 		// do something with msk->subflow
>
> or:
>
> 	if (!msk->subflow)
> 		// allocate msk->subflow
>
> all without any lock acquired.
>
> They can race with each other and with mptcp_finish_connect() causing
> UAF, null ptr dereference and/or memory leaks.
>
> This patch ensures that all mptcp socket operations access and manipulate
> msk->subflow under the msk socket lock. To avoid breaking the locking
> assumption introduced by mptcp_finish_connect(), while avoiding UAF
> issues, we acquire a reference to the msk->subflow, where needed.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
> - fix msk->subflow misusage in mptcp_getsockopt()

Thanks for fixing, looks ready to merge.

>
> rfc -> v1:
> - rename *mptcp_socket_get_ref() as *mptcp_fallback_get_ref()
> - use subflow_create_socket() in mptcp_socket_create_get() instead
>   of open-codying it.
> - use mptcp_fallback_get_ref() instead of mptcp_socket_create_get() in
>   mptcp_stream_accept()

--
Mat Martineau
Intel

--===============0872652658834911689==--
