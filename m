Content-Type: multipart/mixed; boundary="===============1141830755458577074=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 0/2] mptcp: partial recvmsg() refactor
Date: Wed, 18 Sep 2019 15:42:04 -0700
Message-ID: <alpine.OSX.2.21.1909181541490.40632@tvtrimel-mobl5.amr.corp.intel.com>
In-Reply-To: cover.1568799121.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1882

--===============1141830755458577074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Sep 2019, Paolo Abeni wrote:

> This 2 patches start the recvmsg() refactor discussed in last mtg.
> The explicit 'duplicate data' handling in 1/2 fix some stream corruption I
> observe with re-injection, and the 2nd one fix another stream corruption =
at
> the end of the stream, still triggered  by re-injection.
>
> With the above 2 patches I still stream corruptions with re-injection, are
> almost gone - even if I can still hit them with in at least a very rare c=
orner
> case.
>
> Only minor changes since v1, to address Mat's feedback, details in the
> individual changelog
>
> Paolo Abeni (2):
>  mptcp: refactor recvmsg()
>  mptcp: recvmsg() should really try to deliver 'len' bytes to
>    user-space
>
> net/mptcp/protocol.c | 120 +++++++++++++++++++------------------------
> 1 file changed, 54 insertions(+), 66 deletions(-)
>
> -- =

> 2.21.0

Thanks for the v2. These look good to merge.

--
Mat Martineau
Intel

--===============1141830755458577074==--
