Content-Type: multipart/mixed; boundary="===============8713749962849001548=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:pm: use mptcp_pm_init
Date: Tue, 15 Oct 2019 16:49:40 +0200
Message-ID: <fe1ed75afe43826752372f406bbd7d0b135f4d11.camel@redhat.com>
In-Reply-To: 20191015140630.15863-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2147

--===============8713749962849001548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 16:06 +0200, Matthieu Baerts wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cef22193035..00ab1e7674eb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1033,6 +1033,7 @@ void __init mptcp_init(void)
>  	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
>  =

>  	mptcp_subflow_init();
> +	mptcp_pm_init();

uhmm.. it looks like this chunk will conflict ?!? I see:

	mptcp_subflow_init(); =

	mptcp_basic_init();

in the current git tree. Otherwise LGTM

Thanks,

Paolo

--===============8713749962849001548==--
